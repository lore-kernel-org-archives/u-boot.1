Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C916EC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEEF981190;
	Fri, 24 Jul 2026 09:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FU0Aglrz4J-r; Fri, 24 Jul 2026 09:02:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DCB88109F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784883750;
	bh=WwhISjKX+LT2dPt4tKQxfLguBL6+2+Q6EhdpuM/G7YA=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aTu+Tq+zm016zvFF42gMEyC1fx1ErCjv+VeV5031KEqS8MOkU/Kxx36HK2acWqXRW
	 M+AxnrfwBb4KTRyUp5fg3kmrqSSALOL+vTEexsu+g/xxIVR5smfedb/Kwa16e9wxyJ
	 MB72eoXRxjKVe60iqSak73ZEGlwyrM+SuDB/0bYhr2gPzmj0xFtcflDG/WBPUEUXre
	 BNXYZWas6NLvD472AsEwjOP76lkgdXilAgq4p6c0Llz7IAHZNCyJDjDtK4ahIl0e7m
	 dENzy0dCADnoeL0yy4Yzwj3Atu8Y97RQlWvB+WhsGW3E4CatqeNFS7aSKcU3qAj+FO
	 PeOBkNNBwdNNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DCB88109F;
	Fri, 24 Jul 2026 09:02:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA7B63B0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC4E7404A1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPbUHeTSiozh for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:02:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 088B340064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 088B340064
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 088B340064
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:02:27 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso211519b3a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883747; x=1785488547;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WwhISjKX+LT2dPt4tKQxfLguBL6+2+Q6EhdpuM/G7YA=;
 b=NiZ3+HvMm+qLCxYMB/GkT4tpk2jmfL3c+ZUWLNnw7FTHha+pysUMB2MZUPoXr84RlD
 GsMuHC8wcn23T3C+Kzciq5hxGM/K3duRcXKjxu45vzPPolQLvlXlRM2Srh20MwAnFh9F
 SelTKuKXAh0Uit57h3le5vVOyeP4c7AX1J4z41eAVHtSogAvS/q866wi7Y88QQ10argQ
 8CDLGTOVhSzw/sNTBTO3ciS+6bnaHPmsGAfntPbgD98q1eCNkbKCeOXsuLsldRAVEXxf
 qpGVkjVHAMEVKvO6lhzD+T8FHdZte4WNnkGIZk4+VVrmNdvQBGM/V4aQx+ZbTn1QGvQN
 4GMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyRJcNqgbwinbECG6ueYfkC5ufdBCkk6Ik/a43I3aC2tLV6C8ych2M/htOAxXcCITJ23x1QDQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKHswz5AZuQzXXUFWkXbF/JVYXY21asf5dmang9nuh0Lc7FSBe
 91IkGCoJ3Qa8K6CGA+ibnYmDOIuSRmA+wsP81mZCusHlJamJ+2CLiaiKcpkaROCsoec=
X-Gm-Gg: AR+sD110Iu/5yGKjbN2lL/sKl4kZPcSlmxzFQcbax6P4W08HhIOdxfCqc994jxyVLIS
 qnYgDxsyh5k2/xEbd+lW/jcpxMK8SiSMeRemCmuoLL3w+1KemyhvSYWUvHAID7r3TOQdnPNpbO8
 y+3WenKprwoVB0IW/e04MU3pcwg4L3v8SYKcqVVCYmPTWV/dLXG8CsrksqCXeR5TDaxiY7D2aBM
 kuvWmHlUciB9FwDKYyOVD/slKBIDV6lyDrAeUqeRJGHXlFsYqeoAi1mkTLpDBdytQmyq+ZdOxVM
 V8NeQ+4EP3GwQRiRdkN+yMPtczqcxByJDzdnJabTZ+M7wNHSg/18D33l8/3DMtdKWecqJKqD7rQ
 ff5D95UgqJ7E7puYo5Lolj6smN+TTK9b65Nb7yKcoldQnI7lXERA23s9Ih4w5cz/DJr+veAZTvn
 R/BJTDBret+gEbPl5hj44=
X-Received: by 2002:a05:6a00:1149:b0:848:401c:98e with SMTP id
 d2e1a72fcca58-84e2b7e72c0mr7402822b3a.15.1784883747215; 
 Fri, 24 Jul 2026 02:02:27 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e17297f8asm4371773b3a.25.2026.07.24.02.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:02:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:02:20 +0800
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 E Shattow <e@freeshell.de>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Subject: Re: [RESEND v2 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
Message-ID: <amMqHBorMhIkC8s9@lliang-1876.localdomain>
References: <20260529032624.6868-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529032624.6868-1-hal.feng@starfivetech.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784883747; x=1785488547;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WwhISjKX+LT2dPt4tKQxfLguBL6+2+Q6EhdpuM/G7YA=;
 b=CY22RjWDGIuUOMGpQQdyS8CruovI0n38nTJ+UyqpDPKyzeskjOOBJZCohXFMjEmYcx
 sXhJGRNp0fS7t6MTes2z6nsR7mDl4Oyl24rA9dCm0Haz1jUEb9l0vm1wWLkFTHPbXx6k
 2rNes03l2vBjACiLbHWEM2LZPBivaSGcU6ifU4ZSHUISZIb0fpKYjDywHM1q+chgwGX7
 RBREYfUfRB8whv/uLLUuFCcLHekJv2m2K8rpQGwd2bwWOU4Jfk1o3r2vvx897cvCxsI0
 vM6j6dRrI3XE4+VBc40PicFsm/bZ9Qf9GE++0vQZKi5hUPexE15Z2H1kPJNCaevCzzmr
 4QRQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=CY22RjWD
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, May 29, 2026 at 11:26:22AM +0800, Hal Feng wrote:
> VisionFive 2 Lite eMMC board uses the eMMC as storage component instead
> of the MicroSD card in VisionFive 2 Lite board. The device tree of
> VisionFive 2 Lite eMMC board is already upstream in Linux, so add support
> in u-boot also.
> 
> Changes since v1:
> - Add Reviewed-by tag from E Shattow.
> 
> Hal Feng (2):
>   configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
>   board: starfive: visionfive2: Support VisionFive 2 Lite eMMC
> 
>  board/starfive/visionfive2/spl.c                  | 7 ++++++-
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  configs/starfive_visionfive2_defconfig            | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)

Applied to u-boot-riscv/main, thanks.

Best regards,
Leo
