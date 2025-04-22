Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B1C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 18:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD7580FA8;
	Tue, 22 Apr 2025 20:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o2YCb7Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07218144A; Tue, 22 Apr 2025 20:26:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE64D80F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c40235c34so1656717a34.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745346370; x=1745951170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay4t9mtOWMMcaDgEXV5D5v5rY4zQVIWXioQp7dp/A2Q=;
 b=o2YCb7Yp7CMHCqwieDTh6C1hFRxogWimvA8cBLIhrHA160ZXhi7T56oVBjZvFyqsNc
 f1HsPEUBNrA4A/5jtwo2qynziCabORzABaDUazn0gDW6uYTCKz2aPEtpC8X70HmxtYAA
 WLucxseVDS0+LMQAGH1/FN/8F2RNdd5IKUy0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346370; x=1745951170;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ay4t9mtOWMMcaDgEXV5D5v5rY4zQVIWXioQp7dp/A2Q=;
 b=w7Zt5TREVe4mU5EIIKfg+RdpeKmAAbTjrsKtU3PRU1MaLVnRc6ZIThWRKo8jG3l9Mp
 gXt3R2TsM/COXA4L89LU5Gvr7XYH1XzIdthXODZ4U9Ud6ROOarivRHVB14B2+jEEU54f
 /P9WZ1NaeyQA3LE/bScLe8x1R8jvFHem8L/v8zg2gpeVO01umX0ISUQsm49tDOwsMuuQ
 CWRxepSNVTK9sySQqlh5eGrLa2tXh3zg61NioneLppykfd27TBKSVfmyv1HT+h3VXEbl
 Zka3nzs2iC9Fj9RV4f07Qd3o5hmiLwptAqPPEVry6TujqM2GQ2iN0qe4yvskn3FGTnWm
 iotw==
X-Gm-Message-State: AOJu0YxE684t6umc+0hcqmcyBq+IK0+AJ80T4cJu/Spm4oU2eWsjGuz2
 KMmcf5+83e1MGUea5xE2Hw5zlKJPegaQzkJoYA8b4I8gAn04juJATQiS+ZT0sc8=
X-Gm-Gg: ASbGncs62AJvFrwGU7y+PA2xCltPA0GvZaaET0nkPvEm36Je82sHHNIhS7LxuThTJhL
 EUrjEyVVAFZgdntMit8Ie0xRH+vNGOvGTjF8q9g+LG6UPRoeFw+z2bUlacIHUbstm5zAzGZOATT
 OFioQmzWAgCa4Hk8Vs+SYWsetgZwS4J0K6e2fkQy6dOg0U4Z/eAAK+u9HgLMTxHSsdbRhhvg+SA
 gyMVl+03HMMkxunNYrnr//uFMbjXDPtAUBIIy+cdL45WzXDYYHGah5XHyaAU5Ki1ftK4YXcIHaU
 3iNg38d3nr6rRd9f9cUh93v/gMEVr/pMD9Bi+XdVyEH+xdHtfOCFVPAq848KkfsiJE9iR38ImlZ
 J
X-Google-Smtp-Source: AGHT+IE35A0Wel7cYA4iU436uOJFMI4ymccmD8H+PTOmFonl5ux8lphX/P89HWBZ8MYsNQfXqcL1Gg==
X-Received: by 2002:a05:6871:a:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2d52696c7b8mr8448044fac.1.1745346370287; 
 Tue, 22 Apr 2025 11:26:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d52134ea5bsm2704504fac.11.2025.04.22.11.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 11:26:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, 
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>, 
 "Meng, Tingting" <tingting.meng@altera.com>, 
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
In-Reply-To: <LV8PR03MB81371BBB1BF844425EB2DDC0A7BB2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <LV8PR03MB81371BBB1BF844425EB2DDC0A7BB2@LV8PR03MB8137.namprd03.prod.outlook.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250422
Message-Id: <174534636919.504874.11945418472935443176.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 12:26:09 -0600
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

On Tue, 22 Apr 2025 05:11:16 +0000, Chee, Tien Fong wrote:

> This pull request contains updates for the SoCFPGA platform, targeting the 2025.07 release cycle. Highlights include enhancements to Agilex5 support, improvements in DDR error handling, and bridge reset handling for SoC64 devices.
> 
> Key updates:
> 
> Agilex5 platform enhancements:
> 
> 
>   *   New MMU region mappings and memory layout updates using LMB_ARCH_MEM_MAP.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


