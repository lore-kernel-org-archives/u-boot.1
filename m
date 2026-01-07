Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEFDD0D155
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 18:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BA183A91;
	Wed,  7 Jan 2026 19:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CrTMwu6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958CF83A2D; Wed,  7 Jan 2026 18:34:29 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D45C83A91
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 18:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kallikles28@gmail.com
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-b727f452fffso150818066b.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767807267; x=1768412067; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hplMP/IHGJpakyZc37aPIv58mIo9gNjxyEfc+xd8a4c=;
 b=CrTMwu6LaToWjWbxd8/jYlj/6YxdzVVUW4TMVf7BW0YhGtEDtq1mcRd3I5X3tsZZOI
 JkZKCZ4xhHa9eii5yrPJOWAx9Cwazh9EObj+hgeFtTsVFk8sUzo8XAVUUmOvA+si1OkS
 PLcDOWgMztSnZwdAyVk1GH6d+2lPLtWvmR9gsTpo/LKkzQBhG14JTaTnRqJYenr88cQz
 wY/h8JG+Xxs2ayTrSPsW68fBYnRo6otqdBLEQwVLxUWnE3SZe+SexfmxrlLSktPWoO1L
 Tu7qJlIgm0D67+CXa5fc31ngPCwbYrb1mKvdLDqzD+ILzCpEpAtU+uPB3CRPgr5AnLiV
 brgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767807267; x=1768412067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hplMP/IHGJpakyZc37aPIv58mIo9gNjxyEfc+xd8a4c=;
 b=SikCPjG9j2kP1Mb9VPHSbI2DNAjVcm0XXOeggAkbd4jx9IzL5foJSAJ5RoRt6YSLHv
 fEdUsGJyQcA8vNdl9/eg6pBdvP+Bu+DJYuIbbuOuNsQl41XG+MTBycPt9bJR+FYCD3lJ
 D0fh8MhtPRR3IQjSj0fiZex7xm8m2q7SZi9gT4yBU5zaGn8LzKyr4FIKXWvlx+3HUXcb
 NSLcHlhLBbaRLwEbZ55L/VyarlnqjHDL1IAcu2aiA3Fzi3C8lRzN6+ZtG4giiA+BePeS
 vXtRp1zr5GXTuLz8V5Zi4ijXQy/quijneU2BsoEaplxmchIiRejPUSkx615OGCUAwTMR
 6N/A==
X-Gm-Message-State: AOJu0Yxs3Ykd+nuk2MQEJWmGtZdKO9TOxpUD92cSyHVTmMHs11hvP5sv
 AFPeZvHIECc8Y587KRiIRQEjmQLMfUXczLypwiGttoRyE6GF8SzDewtBrlQ1J7lQ
X-Gm-Gg: AY/fxX6rXBCNa1yLkZ+8IqhTFO2RMuGyfusbNblGvYifVknbTSN3nkbAldnCdD37YmM
 FqwC/+6K2cVLPTDopqeo9+zbMWICAQQ0pLavgWhE1vhGd71XFhHU4txHlUO19duSYsDHNOjY6Yy
 XOI4cKSjOVlZecarSJUdSfwdh3f6B6QvRETgTeyJ2Amm/CM6hA/ojd1Mh+fppP+3aL+k6mMxDSd
 riiB/Edmq/lh/MEgboy/Vytbj8yzL1aXh3CqBB6kDarJhFdt3XKXe46yX6s9EpnC/Y+K7adrt3I
 yzpvWNF9GYCNB21zF7jlxe23FqmI9rhJZUYw3dKeKRF0pHCqoOQKJZp7dct/FQqRhDNqJ6R/k1t
 0z2yA/t/ANX7oUXwEXXBCT+HGtTWorHrvVhQc2gFp4yrL/1SW5SgfiQ6Gnb6Bgd9BT9oE/0Ik/8
 RKFoM7FrkgIqr7VaX/
X-Google-Smtp-Source: AGHT+IEqCHGBS+FTfAh2ljCYO4LvY96f2yylcFWBOf88ckyeDMqRXR/6lYPj91VcWvB6JYi5FX6p7A==
X-Received: by 2002:a17:907:1b08:b0:b80:344b:421a with SMTP id
 a640c23a62f3a-b8444f43f86mr381353866b.18.1767807266890; 
 Wed, 07 Jan 2026 09:34:26 -0800 (PST)
Received: from eryximachos ([2a02:2454:8c27:6f00:7e7a:91ff:feeb:a1bd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8429fdf4e7sm589587666b.0.2026.01.07.09.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 09:34:26 -0800 (PST)
Date: Wed, 7 Jan 2026 18:34:24 +0100
From: Philip Oberfichtner <kallikles28@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v5 1/3] Image size checks: Use HAS_SIZE_LIMIT consistently
Message-ID: <aV6ZIEP6onZvPVtg@eryximachos>
References: <20251110091256.2422534-1-pro@denx.de>
 <20251110091256.2422534-2-pro@denx.de>
 <1f18b0bf-019c-45ee-a38b-5d29f8ee9b12@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f18b0bf-019c-45ee-a38b-5d29f8ee9b12@mailbox.org>
X-Mailman-Approved-At: Wed, 07 Jan 2026 19:08:08 +0100
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

Hi Marek,

Thanks for the review, I'll get back to it asap. In the meantime please
take note of my new e-mail address.

Best regards,
Philip Oberfichtner

On Wed, Dec 31, 2025 at 10:27:44PM +0100, Marek Vasut wrote:
> On 11/10/25 10:12 AM, Philip Oberfichtner wrote:
> 
> [...]
> 
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 8dade2b501e..97c7bfdad47 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -36,19 +36,33 @@ config SPL_FRAMEWORK_BOARD_INIT_F
> >   	  - initialize the serial (preloader_console_init)
> >   	  Unless you want to provide your own board_init_f, you should say Y.
> > +config HAS_SPL_SIZE_LIMIT
> > +	bool "Enable size limit check for the SPL image"
> > +	depends on !COMPILE_TEST
> > +	depends on SPL
> > +	default y if ARCH_MX6
> > +	default y if ARCH_MVEBU && ARMADA_32BIT
> > +	default y if ARMADA_38X
> > +	default y if K3_DM_FW
> 
> K3_DM_FW is some driver, what you likely want here is:
> 
> default y if ARCH_K3 && CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 &&
> !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
> 
> But it seems am64x_evm_r5_defconfig below enables HAS_SPL_SIZE_LIMIT too ,
> so likely remove !SOC_K3_AM642 from the above, which will allow you to
> reduce the amount of configs/ file changes.
> 
> > +	default y if SOC_K3_AM625
> > +	default y if SOC_MT7621
> > +	default y if TARGET_SOCFPGA_GEN5
> 
> You could also add Xilinx Zynq/ZynqMP into the defaults here, which will
> further reduce the configs/ file changes.
> 
> The rest looks fine, thanks !
