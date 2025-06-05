Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EAFC5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 03:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7818380050;
	Thu,  5 Jun 2025 05:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oyza7VCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F51B82116; Thu,  5 Jun 2025 05:09:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC2E801BE
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 05:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6063462098eso337358eaf.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 20:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749092955; x=1749697755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IifHUje9XZbQai8X9u1B+4hKd629Cobl6KS8JCzzDD0=;
 b=Oyza7VCazctQCWbjW/2jtcAuHwwTYUsMlOrB6zxi4ek2BaUncm7OTZttejiDohzJS2
 z3H32artXzXBW3p6x/6Bw0AAbt+JhzkUQaPDzzN45S6VwU+fPPcpL+Pap7WN+job12Kn
 IK66vB4t/hW2lySxu4kybeFCSp0EniuC4LPHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749092955; x=1749697755;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IifHUje9XZbQai8X9u1B+4hKd629Cobl6KS8JCzzDD0=;
 b=Qhe2/h3PVz/zHlc8XgtZa2d0JyXWoaz57YwtIr0mO14ljAjF1KZRxNsyAGwit94/VR
 CCROfBK2qnOscAYvZg8fKA+mlrazhSjRWi0+VOCrfDCzgX44r0SvtXeUDADagCRFj3bi
 15okPlOMpQ+cxzxAgP8af+CP+9A4ZWDLhhOkxKQluFaDBw9KCbr99BtD5oN7w2PXf3ll
 pElDe0mCStvYdsmYnKtz5mr2zzz32vZpYJj2RyeetXeK5kj9aBZVMo0XS3ndgOwtQ3bC
 qf+JMBnYL6tpOmpLiBCd+6qR8mEUWAu7ixSt1qA7SmN0edqBOPwqSXamw0Tzr0cKolii
 /7jA==
X-Gm-Message-State: AOJu0YxCskj+Sd6jzRrsKqUbdSTIF53CeANfTjl9/ROsf84kOq9fvpG2
 hfP3Z9SeM3Cpx6ybhQmmxTTKXEC76poQGizoRGHM0UZC/nWIfk3gbfvmkgZP3YT2aYA=
X-Gm-Gg: ASbGncttYcvLWPrz461EkkXvlvs3Wj0mL+gHBF6keLKRRLKJ/qONeLF+D3QEX2lh5bd
 A87Pcedw7hg11Ck807pk1eYyUiAZgYV7nYmjztj3KLvVk710Ig06MRPmV3G0toup6IVtGE63fPt
 TTE274ZC19MKkIZjQzLdDyB4veC2KEwlnw4+M6oRuO/QqKQ1zqCbAqR2fDbN1Mug1vBzK0NSzh1
 r/dF5io3BEmVYTocbn+CW6oGbEMiR8ZLMZvBbUCI8UqhEQTBiQOSA8W/Wr6YI7S2m7UiNZKqad6
 HuxZf0zjpqUMZjvcf3PXvd2XILMIQ2EPIo1TeYMI1Bj6p3M5dYzlClJPYxCUCJd7pIUacABxDTv
 E9qUxpplI73Q=
X-Google-Smtp-Source: AGHT+IE6XqtEZYTTldagykdxn3zxycLHC/dHpKB58kxuqQyVZnUaS1WWpbN5SOCBjTxl1oLD3eJNxw==
X-Received: by 2002:a05:6820:1e0e:b0:60e:c93a:4b43 with SMTP id
 006d021491bc7-60f0c6e0a08mr4079038eaf.2.1749092955278; 
 Wed, 04 Jun 2025 20:09:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c70b2esm2518069eaf.13.2025.06.04.20.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 20:09:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250522164013.125496-1-afd@ti.com>
References: <20250522164013.125496-1-afd@ti.com>
Subject: Re: [PATCH] board: ti: am62ax: env: Use default MMC related args
Message-Id: <174909295375.1989110.18218910135346270073.b4-ty@konsulko.com>
Date: Wed, 04 Jun 2025 21:09:13 -0600
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

On Thu, 22 May 2025 11:40:13 -0500, Andrew Davis wrote:

> There are common MMC args for TI plats in include/environment/ti/mmc.env.
> Since we already include this, there is no need to redefine these
> MMC vars. Use the defaults.
> 
> This seems like something that could have been done while refactoring
> these vars in the first place as it happened after this AM62A file
> was available hence the fixes tag.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: am62ax: env: Use default MMC related args
      commit: 5262b3ab9329b702f98ef61e76b0c78eb8c76f24
-- 
Tom


