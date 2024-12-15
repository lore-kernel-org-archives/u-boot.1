Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C611BE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 14:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1054E80086;
	Sun, 15 Dec 2024 15:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p4bbjUh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8992780083; Sun, 15 Dec 2024 15:03:55 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6021080040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 15:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so345754285a.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734271432; x=1734876232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1v6+UvKyJlfavJ8z0p3WMC6CC8B7OfHILUaH7yNrxw=;
 b=p4bbjUh6HpqEM2UKxX02gh4aEKBBaTu23LM0Aei01yIxalkHVQckeiqlmMz8VREsn5
 BBDRlZt/xV1CUDia1nbb0EQGoGPo3t7msbQzBjQY5YdZS/OLFQb2WgymyfK/Sk/zbbWD
 nPeMzWt5kKVxq8DML1mA1wXGgmHQBV7MGZfTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271432; x=1734876232;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1v6+UvKyJlfavJ8z0p3WMC6CC8B7OfHILUaH7yNrxw=;
 b=Q+P0w+uRnWNraSL5C41J60DGm1agJg+Q8VGHiKsWkbkGKoY1RnI0iqxGggTuh2IhyR
 Kmb30fiu5niTCz4zFFULjosROj6g+lm+w/l/50i1r9uMHSV1rkpPSQDA09c2VWqsfapn
 FGIJJxIJ4gyvPqDo2Xfexrxv/ksSaqnh2x36a3b52FzQ/0x+T2tBUhrXLX8rizJLgJpv
 JIz7Gbhylp3ehEp4QkBQHMDJfvUc4qRiT4TiAyIpV6ChVdqALaeG1ZC2Fk2RnTkNdK7g
 zzPbH4rALEAV5pl/JSOLi4HVe7Z+1eEadrZo6txvt0EO2zxIHTGLwR6ZERSZiJM5GNFj
 HZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQhY6T7BhN8CuS0MV+cTQZaOnBPyCl45eDfcAGY0vDCFErJwfSu4V63KQSYckQSVc6cXnV64E=@lists.denx.de
X-Gm-Message-State: AOJu0YwNFK9zA/+UB9tUTw+ae245xImRlDyAFiXPZh0sCNINp5y5GhEY
 c1O6Edm+rqb+6vFIgCFj7jhnz6axrTWrE2BWa/HevtAciORl0KvFRSYu70Qym84=
X-Gm-Gg: ASbGncvV55J8AxDJ9LzTuxJcs4psszN5zrXGaB3FnwSiX3OaloBkCBYFAda3XfA6Qsz
 cZeII0dCD7IPwJaUWpjDOUg4L58FzzLiiUIFONTSZEvbxGOrShk2r9jBjolzZuGSExN1lRW1aHw
 4cSqMCPGJEefhbupFQc8xZYdAW5wEgk2HavXhUH7sgOcEZ4sI/VT6Yl1Ms8uXP07b/G5+CLYvzV
 PH0XCDF3mvpBQrZHuP0+o91SuytklVnJ6sFexIq7AfeMfCxR3CXvUw=
X-Google-Smtp-Source: AGHT+IFlEaua1JtedZ50AJeucv+10tDXqJozcCqwhDalVzLWv22Jhgs9dBQJvDuQ1LbHFV1hM2gztw==
X-Received: by 2002:a05:620a:2990:b0:7ad:832a:4063 with SMTP id
 af79cd13be357-7b6fbecc68cmr1299735485a.7.1734271432253; 
 Sun, 15 Dec 2024 06:03:52 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd82asm139942785a.82.2024.12.15.06.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 06:03:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: m-chawdhry@ti.com, vaishnav.a@ti.com, j-choudhary@ti.com, 
 b-padhi@ti.com, Neha Malcom Francis <n-francis@ti.com>
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20241129110333.444270-1-n-francis@ti.com>
References: <20241129110333.444270-1-n-francis@ti.com>
Subject: Re: [PATCH 0/2] configs: Enable CMD_NFS by default
Message-Id: <173427142999.1931614.11975835681042536271.b4-ty@konsulko.com>
Date: Sun, 15 Dec 2024 08:03:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 29 Nov 2024 16:33:31 +0530, Neha Malcom Francis wrote:

> Enable the NFS command across all platforms to allow network booting via
> the NFS. Clean up the J7 configs to use TI_COMMON_CMD_OPTIONS.
> 
> Neha Malcom Francis (2):
>   board: ti: common: Kconfig: Add CMD_NFS
>   configs: j7*: Enable TI_COMMON_CMD_OPTIONS
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


