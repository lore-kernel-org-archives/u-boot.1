Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D19E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76763801CF;
	Tue, 17 Dec 2024 05:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZOLUCQ3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74274800D2; Tue, 17 Dec 2024 05:04:19 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB0A8022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ebb1652729so1738448b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408256; x=1735013056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyRnDdnQnl6jFrpCaWmQ32EKztFzj482GCZeD/r24DY=;
 b=ZOLUCQ3hzM97DoamGlot7o+50gnDCW9fWObKdIGkh8c7wg84xCwjWUUDANTamwM3kL
 D9XbxRJShOtqPgTYgqJmT9Rh/BkkUlngrZnFKxJ5b1B44o37bZsaBR0AA4CSlODVW11N
 rO0kUXRgTxU+V2Zi710pXloWSGaF2LJ38SWNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408256; x=1735013056;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyRnDdnQnl6jFrpCaWmQ32EKztFzj482GCZeD/r24DY=;
 b=Lib6BTUJjU9uXRtYP7GGPnYrt19b2dq+BgpnRkWPs65SZZxQKIm/XYIuJ89Ou/nveC
 F/IsFeNMBS4eRqtj7su2lUCYqBoFwjxJQRTpWb+hg+ph07tQhRQrZS1diYucWt00tq0F
 4tS0cRIKSeDmd16sc7U8io3hJuRd1sZoxOis/cMQmDjK/rAOnxR9sh9wrpx1unX47EqS
 OgGeFcmjJTEUqbG58zMQxHdO0xOhjB1CCIWnb7s5rUMshRIKemcYDdBqdde1THtv/rtN
 6iJVxs/q6u2ryGRwCI4CV1XUKCoO4sX7c32HYxOfCrQS1a1eZmXDIFo1a5jwQYR26HuB
 v+1w==
X-Gm-Message-State: AOJu0Yxn6ysm54dqjD+er5TdTsQSq/Dy4VHIS9TJYb5YD7RONh49gMGB
 9ezlg8qVtZcl8Nulc6+4H1Te/xQ13lcg88v+gHj4I6V9KR0CudZqa1V+TPnkesM=
X-Gm-Gg: ASbGnctXLc66gjYuBKV2HyICjiFU9XfnY7lYYXopIn1ypeyhoFBfUprq4nHorNasfGO
 wyMq+KcLsk7lykdoA0JFQQ+v9i4hpHB+Vxa3X5jfUWb7UAY4ClyXHmZjBWYcRAyGZC962uNC/EP
 1zND9xUcKa5Gzhn7fwAIHQ9YmCu7ODVApM+9fUnjC9UiQCAWR3t9H4zrMVBZQRqageUq7N6kqKC
 CxEqaHUZY77cRnUGn+k6XiH7Cb0vGlxQMqg9RnsTS5bTMWFP+FDN2U=
X-Google-Smtp-Source: AGHT+IGs0R2Vij5UpK5qSMmdxsm5EEKi14D0RUNBAiasKE7iBs04SzHlY1d27zKbzFj4sn02ssKJCQ==
X-Received: by 2002:a05:6808:2198:b0:3eb:556e:dde6 with SMTP id
 5614622812f47-3ebcb2a2c1cmr666187b6e.12.1734408256030; 
 Mon, 16 Dec 2024 20:04:16 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, vigneshr@ti.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-kumar1@ti.com, j-humphreys@ti.com, n-francis@ti.com, vaishnav.a@ti.com
In-Reply-To: <20241127061334.2173945-1-p-mantena@ti.com>
References: <20241127061334.2173945-1-p-mantena@ti.com>
Subject: Re: [PATCH] arm: mach-k3: fix typo in devstat macro name
Message-Id: <173440825394.3115242.4689620819673965591.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:13 -0600
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

On Wed, 27 Nov 2024 11:43:34 +0530, Prasanth Babu Mantena wrote:

> Fix spelling mistake in the board init files of j721e and j721s2.
> 
> s/WKUP_DEVSTAT_MCU_OMLY_MASK/WKUP_DEVSTAT_MCU_ONLY_MASK
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


