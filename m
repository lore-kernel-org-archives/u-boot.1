Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9AB109878D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B0CF83FFF;
	Fri, 20 Mar 2026 15:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLUkkZKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2978084006; Fri, 20 Mar 2026 15:49:05 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8946683FF9
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olteanv@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b3a5973e7so82731f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774018142; x=1774622942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tjT/XSbIlAZQG7Zq4F9z5jFBL/GN/XUy0wyy+ZXWmwo=;
 b=mLUkkZKWRpBZVX8K3puos34LHDv2eijg8Qz08duPuPY1RFgci7YNJD5ZR0mSpQglkz
 AZpQuTAfSeDhBIfL09Sl9vTkD8Rfkf7wlDD6mqjDZkW/Ty5DF4Hf8l9pKCinAcJ22wzB
 oHI00UYqLc41LKCspCBr36jy6SGLKvYt8/AqTy+Lxn0JhLvOIRX6BDiCP6iA2XEsHamE
 XtXDv0PzTzbvXUz8pdxbRZ7LgsQZt+E5Y0x8o+6czkheaelMEkBei7h6/yBu1xOt8odx
 NoX5HNqrqrtVsQKl/rWMdmwaDKugfzBAzvWlmY1JhZQ3ovfcLYOvTuUE3I9Kiwi+QOaI
 Seqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774018142; x=1774622942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjT/XSbIlAZQG7Zq4F9z5jFBL/GN/XUy0wyy+ZXWmwo=;
 b=AcHtC0p1j1OupWtGjd+8vTMaBTpzCUlX3T/xNxBvpsMVLbJJ+OokwuFwvyhl5lRE7z
 ncD2JL9ExaT0cboGmL5rd235oY5F7B6QmSqFrYMxVC5IvPn7KY58Et5N4v52eelwNHMP
 /WLiqcVErGbZ8ydigmI46Zux13FzCwMrf+dRK8pbe1kife1Hrx3hcZQ+jJ+RoAmi/g50
 6eWQzeefpBisoOfMqDBlfNkXuoowyq4XLxrV23ihU/DKW8dApcEKUe+L+WE24BjbGjlY
 GsYUM5I5JrVWXgT+DfHmMgI+5qfm83GvfiKqSxyF8NAMjkpFNlyqlVlpWvcBKrPfEcQ4
 6ikA==
X-Gm-Message-State: AOJu0YzoOaOynCUHeJ2LUSPHfULlhcq5IsHmhtrbB9tg6u/XX7c2T2zZ
 34adUkkju+oZOrrQ4ryxP/xcU2GyQAeCNbrWFy6SktX20gaZ8jHWK7M77sys0w==
X-Gm-Gg: ATEYQzxfitE94LjQn2a4aKnxBJAYGoyYBuLZzBTfr49VsbX3k/+2JpaAJfp11CucNmU
 kkvVKSpw2MGlcNQKYUn3Fsjat8cG/03T02z1Vd9DV9U/jWgKixiu0T9/Hr9yQo8YZ5yDbklY/GT
 CedyEJOEAV52m9Pu81xwLz5YaWFlsI2P4xXlPjsre2flXRFak5p++Xxxc5eaUCuuN0foMPMqmnZ
 dNgK1zM10nCx1qjmTas3BnoiDCYmCBk7NggQRI1B10zIDD7GNblewH31K/m6wSr0MGzCU8pBD9J
 L6SfhVyRMVhawz6S4SecJwGwez29y2a5OSwYAi4xaFYD5M5htIZkOYhMORed795J2C958crA39H
 UbSRu+mXZoW6LUJiQyp229ugqov4vZhLu1i9/l83fAZmrio9ezPt832aXf5B5Y3Tm2Ob9ckVgoG
 qiyTHedNUTDfK3oqpfJqM9B+ALQQ==
X-Received: by 2002:a05:6000:1786:b0:436:23a2:5e38 with SMTP id
 ffacd0b85a97d-43b642517famr3456743f8f.2.1774018141534; 
 Fri, 20 Mar 2026 07:49:01 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:e024:a63b:8bd0:bd2d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm6348838f8f.20.2026.03.20.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:49:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:48:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Michael Walle <mwalle@kernel.org>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH] serial: Enable SYS_NS16550 on incorrectly migrated
 platforms
Message-ID: <20260320144858.3lpju65fwa6sictt@skbuf>
References: <20260319163343.1679919-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319163343.1679919-1-trini@konsulko.com>
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

On Thu, Mar 19, 2026 at 10:33:43AM -0600, Tom Rini wrote:
> With the migration to DM_SERIAL in commit 191b10ac70d7 ("PowerPC /
> Layerscape: Finish migration to DM_SERIAL") a number of platforms were
> incorrectly migrated and did not enable SYS_NS16550 despite previously
> having enabled the non-DM NS16650 serial driver. Enable these now.
> 
> Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SERIAL")
> Reported-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Vladimir Oltean <olteanv@gmail.com>
> Cc: Ashish Kumar <Ashish.kumar@nxp.com>,
> Cc: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  configs/MPC8548CDS_36BIT_defconfig                  | 1 +
>  configs/MPC8548CDS_defconfig                        | 1 +
>  configs/MPC8548CDS_legacy_defconfig                 | 1 +
>  configs/P1010RDB-PA_36BIT_NOR_defconfig             | 1 +
>  configs/P1010RDB-PA_NOR_defconfig                   | 1 +
>  configs/P1010RDB-PB_36BIT_NOR_defconfig             | 1 +
>  configs/P1010RDB-PB_NOR_defconfig                   | 1 +
>  configs/P1020RDB-PC_36BIT_defconfig                 | 1 +
>  configs/P1020RDB-PC_defconfig                       | 1 +
>  configs/P1020RDB-PD_defconfig                       | 1 +
>  configs/P2020RDB-PC_36BIT_defconfig                 | 1 +
>  configs/P2020RDB-PC_defconfig                       | 1 +
>  configs/P2041RDB_NAND_defconfig                     | 1 +
>  configs/P2041RDB_SDCARD_defconfig                   | 1 +
>  configs/P2041RDB_SPIFLASH_defconfig                 | 1 +
>  configs/P2041RDB_defconfig                          | 1 +
>  configs/T2080QDS_SECURE_BOOT_defconfig              | 1 +
>  configs/T2080QDS_SRIO_PCIE_BOOT_defconfig           | 1 +
>  configs/T2080QDS_defconfig                          | 1 +
>  configs/ls1012a2g5rdb_tfa_defconfig                 | 1 +
>  configs/ls1012afrdm_tfa_defconfig                   | 1 +
>  configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig       | 1 +
>  configs/ls1012afrwy_tfa_defconfig                   | 1 +
>  configs/ls1012aqds_tfa_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1012aqds_tfa_defconfig                    | 1 +
>  configs/ls1012ardb_tfa_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1012ardb_tfa_defconfig                    | 1 +
>  configs/ls1021aiot_qspi_defconfig                   | 1 +
>  configs/ls1021aqds_nor_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1021aqds_qspi_defconfig                   | 1 +
>  configs/ls1021atsn_qspi_defconfig                   | 1 +
>  configs/ls1021atwr_nor_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1021atwr_qspi_defconfig                   | 1 +
>  configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig | 1 +
>  configs/ls1043aqds_tfa_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1043aqds_tfa_defconfig                    | 1 +
>  configs/ls1046aqds_tfa_SECURE_BOOT_defconfig        | 1 +
>  configs/ls1046aqds_tfa_defconfig                    | 1 +
>  configs/ls2080aqds_qspi_defconfig                   | 1 +
>  39 files changed, 39 insertions(+)

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
