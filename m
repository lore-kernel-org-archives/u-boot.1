Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4596C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 15:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F8087D58;
	Tue, 13 Feb 2024 16:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="17bTVPzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD97487D64; Tue, 13 Feb 2024 16:17:33 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6C387D1A
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 16:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-411a5a86078so10964825e9.2
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707837447; x=1708442247;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbzSnRNllTbD0o8fS/dcn5A83z2ku2Gnek5CxQBuv8w=;
 b=17bTVPzyLQaIZcC/AVoD842d0ipMsq3vmdtT5dRd+WoQQU3wxuTFyx0cATCn7jaj3N
 x6MW/ScaHe/3//U/eX1RYTrpDsp1zdjn3yFv3i9PMM6dSoNHn0tdPP+Ak5nymRncWDeI
 qWaRsAmkVvXVigVNRGo8AlTBYFPFwQPgKAyXEdxZBwJhWZGmdTGvWBtDGpDkRJ7eKYb1
 f2K520LNZS0jtSXDPTSt9yiFp/JOjHtSVNcps/OG5wwtQsBk5OHlSXatbAa2DjqrM+oB
 sZbg2HdHRCii53xhWLbvYTpQAt/rKBv24bFEfwk9gsHS1T5ht8zq9gv5wzI6/n3zmVLo
 R6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707837447; x=1708442247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbzSnRNllTbD0o8fS/dcn5A83z2ku2Gnek5CxQBuv8w=;
 b=qMKoducL90E+A8/PXsA84sHzh2I3VKb6gnQ+g4w6YluE3NJNE1MbIPWKYgvSxpjYI0
 B4aT/eADa7hHlGm9nwLQsesXGuxy9EMZgcApZmC0bcclbpMFiAC3zQ9uJjTehadN78/n
 XSMn4MPLLBB8jJtWecKY1+bqkrAU7N95Rkr/0fvuXKCYY3VmpkCjoDhBbtwPed58Q2h0
 doMS2U5xRwSi6FadW5mKqRuQPdFzAa/nh75Rc8P/dR/1ofFyw9/KA32ouA5yySSoTQlg
 GP57o4r8s0GVaOhXsp6arglUUGfIZWKZJiIpfg7uN6SndMuV267G3aoNv3b6/qke56Fz
 A4tQ==
X-Gm-Message-State: AOJu0YxOzmF0RvdZobVmFnpZ/qd42byIi0BcmZWnR8dovc+6HUs7SRFQ
 gXjZ/f/mJ7XOFv/1AmjjdS1FvoVc5ENDPHcoRNm86/IQt/pc18iVJOwLK0PvOp0=
X-Google-Smtp-Source: AGHT+IGpaN7fikwAwnXTeVRhuKzW5epyhWR0tFoDIQI5K4XiojYHNQ3ldsm8aqCKDxKP+/0OdFQtmg==
X-Received: by 2002:a05:600c:310f:b0:411:5fd:42e4 with SMTP id
 g15-20020a05600c310f00b0041105fd42e4mr3336044wmo.5.1707837446982; 
 Tue, 13 Feb 2024 07:17:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCULcuDNqJyHr12pjC0ugGmE+ar3OSQvmSxSWoAXOxD2POKDEQ5HyReKGY70Y3nHmxQ3ZD2+NlaZLOqNw9FkQsxvA9bcTVNnxcoa7tmXcwqokzEJiJwX9N0o8LkpTiSuWNBDVa7G9tBR7FMzGkmdtFHJlbQuBswyL73Jz1V3AupcxHB/FKIFP6F3Fll/1ug9vMaseR2rJhsCiK01STsTU3s5dSN+LDIGfThROa7ky8uF9KtwChDv86fwYCqGzo8INERn6D2JJRMSZkUlHldTKqDN9K7ILvc4P5E4lqdg6033AYBQ/FVL61BK00FQJzdcTpbsnbUswy5V/omnfX+Hi5xM7SCpARD+IDG6vJ7/
Received: from [192.168.2.40] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a05600c21c500b00410d897765asm5978578wmj.17.2024.02.13.07.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:17:26 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240213073638.1125429-1-igor.opaniuk@foundries.io>
References: <20240213073638.1125429-1-igor.opaniuk@foundries.io>
Subject: Re: [RESEND PATCH v1] MAINTAINERS: add custodian tree info for AVB/AB
Message-Id: <170783744593.650778.16592116869771132536.b4-ty@baylibre.com>
Date: Tue, 13 Feb 2024 16:17:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Tue, 13 Feb 2024 08:36:38 +0100, Igor Opaniuk wrote:
> Add information about a custodian tree [1] for AVB/AB, which is
> maintained by Mattijs Korpershoek.
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-dfu
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] MAINTAINERS: add custodian tree info for AVB/AB
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/71b37060bc59a0a49a18b7c7003c54cac7e1e6b7

--
Mattijs
