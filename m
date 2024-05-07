Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0FFC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9768874F;
	Tue,  7 May 2024 16:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n5RIt4MP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C4788753; Tue,  7 May 2024 16:03:04 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A986A88774
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7928b705f89so255604085a.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715090579; x=1715695379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbdQsgDjw0uyewg/7eaesjnAft/hWSQgOgs2psuNiSU=;
 b=n5RIt4MP3OQVhkVvqX7fBFDJmSjOetUZXzjX+BE6rKDid2FqL1C7wSGfF3A1Hx1zl7
 KLaMTB8MAWOiOzPuf5womBNPH4rEaCvrRp0zEGkyPVtxPqf9EJAit6S17kudhgqqPB/l
 Sa7Z8cr52SYYof/ZDNeYsCA7LOtCDLMt30HD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090579; x=1715695379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZbdQsgDjw0uyewg/7eaesjnAft/hWSQgOgs2psuNiSU=;
 b=UvQ3T1D4j8/c096yR9zNC2KLCovaLAUB1QJgj+UHRbBEQFnm3DtyVE1PpnTjJAabl1
 uFTBctMi2Ezf8fW45/2WfbKPuwUaUgZLLH+a0v9L+/0w0xUX8g9zhuC2ToRHj241+xi3
 PsOgglF30ELYztkCI8i5q35SMcVlRAsn1jy+uwmTpyrF5TxARGmogHr9u7Mep6IZvee9
 gIJ4O6nPInNC1I/CdvvEqHkdNvp1IWu83DLY+0IOaZtuXNaM5xSJ5V7oqAnVPK70QU4o
 47HwDW2Bf3Lpq1H10nQWJP/1+J8LautKQxmIIsYS3gzornA3b0SakeKS+LFUHwf8u+bo
 841g==
X-Gm-Message-State: AOJu0YzqvU1RcbRLrDlacuj0s8I6NKwmc3cijNDCFB76KMdDNIr2BDHo
 z4PoKrpqzS8pX9Qp5kET9CxHX5IAPjijC7LUIomg7gpdwPn+AS+Zjb/xvBqQFP1tHs/WclJ5lMv
 /N9E=
X-Google-Smtp-Source: AGHT+IEq6VWZxwtTxfS3/Lby+A8RYvqNPFfJN0BGJJ3+CH3j+XTn+gyyDjWoKftUeOJ2h9fqrttSuQ==
X-Received: by 2002:a05:622a:1106:b0:43a:f443:d126 with SMTP id
 e6-20020a05622a110600b0043af443d126mr16031532qty.48.1715090578914; 
 Tue, 07 May 2024 07:02:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 ge16-20020a05622a5c9000b00437543e5307sm6460400qtb.40.2024.05.07.07.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:02:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
Subject: Re: [PATCH 01/81] mmc: Migrate MMC_SUPPORTS_TUNING to Kconfig
Message-Id: <171509057795.3014396.8094901267064773773.b4-ty@konsulko.com>
Date: Tue, 07 May 2024 08:02:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 01 May 2024 19:30:18 -0600, Tom Rini wrote:

> The constraints on the MMC_SUPPORTS_TUNING symbol can easily be
> expressed in Kconfig (with the addition of SPL_MMC_SUPPORTS_TUNING).
> Furthermore, in order to remove <common.h> from the MMC subsystem, the
> way this symbol is used today needs to be changed in order to continue
> functioning.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


