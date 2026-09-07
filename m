Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67CDC79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 18:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 957A36066D;
	Mon,  7 Sep 2026 18:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOfjn3arHDL9; Mon,  7 Sep 2026 18:09:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B83CA6060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804565;
	b=NyO5mwFvpkv4muWtyCcrvyx++VJPiivml9YNaxI+g2wfmSjBvhu8cgUpwV2bDbM1vGjE
	 PzUfg9kOiScjw8zTZ/r6BuPAk83QYlLF/320o4lVNf7wyp3HjQJovgpBEPwFEZvM40/SX
	 1ol+egG8rTxwXG9Qk/RuYX8K5SIeH7NEWEecwJxaLxj4ZfCi5Yui/hCuHR2dsalirj/g8
	 H+jFUcdZGvtDWR1tnAGT04VfheWYasZ1uEaSGBGb2t06SWsAMVxsiuUDLNUadvaLA5feL
	 LR8EsvwNJphx6Pli6BFufNbykdGtR6MtqEo+BxTc6cxQx3FaN83GWP2G+AuTu/+KVpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cLa68Z3vD/bxqGHo5mMfgwr4Zbsc1f8lQlxphCxlp7c=;
	b=VfDPTskaldtg3PtTEWxw1pjOEWbxrLd5NMbmgtLsIJFWLAq9v1/oq3Wwg8KmwSu5/E/m
	 cKuuqLdYRDUm8pntlgIyUlu4LVT6QiFgij7jZJX972+c4ePlEOa4yo4GiQ8vFCkUeoVIV
	 sDwyHCkLmOYVpvlK2E+eyHEd+xOY13VgW8SU4hphQsoDgKXH3WlCQmYWSXs2UQJioXJjb
	 FsUbVGShTrfQULpYilrEJzouYVv7FmjfngpZ4ZX2n7BIzIUIke+aZ67geJxB0cbhmvNtk
	 FlXoj9M3sdZKxYnwm1+EbQpwFTKBBd+3ExZB3DoxHaWx+CK6InDjoleUCS9Vun+HEdQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Y8Uokg67;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788804565;
	bh=cLa68Z3vD/bxqGHo5mMfgwr4Zbsc1f8lQlxphCxlp7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1OK7u/3VEZ1+8mXvKqCpsyHBnlpIoYxjlify6NwulinTU23nIlwBe2SS0qporLcig
	 OzS7mps31WknHz9DZ+XZ8sdtayfAfqHijKwL4IwO5fdFVXzfjbv61F9ywW7aBnKwb3
	 9qXSxgfWWCH1xwc6r1WJW1Gc5+lK7wBaqXkkN+YJhPpXiI4uT6cEW/4FZ49k67x8Nh
	 +ArJWNMWV/hIDFcBtvU7dqhyn9FtZTEkddIdzXalzWUjGZo3xvECz8fbFBKGHlT9w7
	 jMPQv8QoVWr5+nIwmuv2ALn5INtfg2nfTNk0bZt1J+gKxopWCX0mnQaLnrLSimj3TF
	 XzaBycvqzBFUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B83CA6060D;
	Mon,  7 Sep 2026 18:09:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFC11AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0DBF6060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:09:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtLqGzG0XAva for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 09948605D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804562;
 b=XY5GqBxYJKR1aXDh9pcyBKy2Pdr8O4rv8MMyxWNzzBpNWxpXbD7iO7rhOkPTd/9pT+QD
 aIC1f0qtxBJpGE6WmcJhAUIEZ8lnGmMfXfsltFxBF72WJdHm4tNqTbth24+liKEZaAUp5
 duI+NG9U5ZGLtmB49bcsAoruymzBw0deNFuUCX0YaI345i5GaDNvRVJIVqKBpbWMjs+XW
 oeJNxh4i6JVO4Kun7MR2Y3MLOaKQlGFHtVVWdauD4mt8sFUWKPxeIR4VAUazBS9VJGELZ
 FxAcFnARolsMEHhJvFWU7sHy2cXv/sabpdqQQBh5N3BGdlHw2JMVuSDtqDdAwGwv6vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804562;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=cLa68Z3vD/bxqGHo5mMfgwr4Zbsc1f8lQlxphCxlp7c=;
 b=U4VE5cHN7ahomjzwfwFM9vp9+5bV8xwbd5yskyhgLwlWO7wTnSamySrhNUWffTc6S2Dd
 nqOnG0mBTBPKpVtCOBvPTO67RxoWk4AIVCeptlEaTFKZaaRT9KEb9EKGlp17pCN71rljq
 ORlLqEvks3k+ksUK+bYE7vbB8ajlFCnpDP/KfM+5pSl/FxoFSZHLYqvOUWXhrNdVwYeGA
 l87mQQFD29GCGtUvsbFbGQ8Z1a4mPhpyD7Gs3YputbrCleNMNu90zth5ayAoNJwdYTZy2
 OiL0U/d+iRVZ810ZRuF8No23tQbsb4vzU4bVFaJO6+8t/b/HgIG2MeHqA7sMwEEbT7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Y8Uokg67; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Y8Uokg67
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09948605D0
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788804535; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jYutBWkF3O7GanLBcRtH2cKGBZOexrJLgu4x0PGONxVJjBvB1BH1ync2yh38VYK2uBgfJSk7Cr0aexL6Gb+n1rcd36bwBQBYiVKHuCF+MJdbXDl2o1iX4LiUcaNQg/znpj5vKRhn1VkVgnBmJyKaK4a1CfJTY22rCTVaRMvlsf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788804535;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cLa68Z3vD/bxqGHo5mMfgwr4Zbsc1f8lQlxphCxlp7c=; 
 b=FysvepebNL3u7Tg49DdjyEVmVdFTRdGvFHuLfGQbQnGyeBLsBBf6L5Mq8BBkCd/ObTrvjK6W5MwZgyS6TwMEsDTDXbYH5um7ICCpZ+1IMKpkB1MxZ/x2M8QLgMDc6jmKI2eOJZO5bpU0BQKS9yXnPSvpAyhlSi2ib3J685X1ARQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788804535; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=cLa68Z3vD/bxqGHo5mMfgwr4Zbsc1f8lQlxphCxlp7c=;
 b=Y8Uokg67lnOMhprlPPTXKM/DOrTEjzKybLBFLoZqWuVew4XsYkSahQoecnz9LWNW
 ysmCf50zCa+OL6FSxdwbmhWPnlsZFJmJ+I/Nwx+zS85YRgnwV8oVs1uOHsP+sz/DZUG
 P1fdX5/l9agcROVMwtUjmfis+7k0YpxTiEMu8/nc=
Received: by mx.zohomail.com with SMTPS id 1788804530810915.4821577155745;
 Mon, 7 Sep 2026 11:08:50 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:08:37 +0000
From: Yao Zi <me@ziyao.cc>
To: Andrei Lalaev <andrey.lalaev@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Hiago De Franco <hfranco@baylibre.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] mmc: cv1800b_sdhci: configure SDHCI PHY
Message-ID: <ap79pdnPCUfaG5gE@pie>
References: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.793.29
X-ZohoMailClient: External
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Sep 07, 2026 at 04:54:35PM +0200, Andrei Lalaev wrote:
> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
> communication. As a result, the SD card is not detected, or the correct
> mode is not selected.
> 
> Configure SDHCI PHY in the same way as in downstream, to ensure
> that the PHY is initialized properly.
> 
> Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
> ---
>  drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> index b756649f90f3..5c129682daba 100644
> --- a/drivers/mmc/cv1800b_sdhci.c
> +++ b/drivers/mmc/cv1800b_sdhci.c
> @@ -8,11 +8,17 @@
>  #include <sdhci.h>
>  #include <linux/delay.h>
>  
> +#define CV18XX_SDHCI_MSHC_CTRL  0x200
> +#define CV18XX_SDHCI_PHY_CONFIG 0x24c
>  #define SDHCI_PHY_TX_RX_DLY  0x240
>  #define MMC_MAX_CLOCK        375000000
>  #define TUNE_MAX_PHCODE      128
>  
>  #define PHY_TX_SRC_INVERT  BIT(8)
> +#define PHY_RX_SRC_INVERT  BIT(24)
> +
> +#define CV18XX_LATANCY_1T BIT(1)
> +#define CV18XX_PHY_TX_BPS BIT(0)
>  
>  struct cv1800b_sdhci_plat {
>  	struct mmc_config cfg;
> @@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
>  }
>  #endif
>  
> +static int cv1800b_deferred_probe(struct sdhci_host *host)
> +{
> +	u32 val;
> +
> +	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
> +	val |= CV18XX_LATANCY_1T;
> +	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
> +
> +	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
> +	val |= CV18XX_PHY_TX_BPS;
> +	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
> +
> +	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
> +	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
> +
> +	return 0;
> +}
> +
>  const struct sdhci_ops cv1800b_sdhci_sd_ops = {
>  #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>  	.platform_execute_tuning = cv1800b_execute_tuning,
>  #endif
> +	.deferred_probe = cv1800b_deferred_probe,

Is there a reason to create a new function, instead of including the
logic somewhere already existing, for example, cv1800b_sdhci_reset()?
It seems to fit in cv1800b_sdhci_reset(), too, if it's for
initialization of the PHY.

Best regards,
Yao Zi
