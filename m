Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68253C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 20:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C38560BA6;
	Fri,  4 Sep 2026 20:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9OTiNJNjkwB; Fri,  4 Sep 2026 20:29:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0EAD06070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788553770;
	b=B59Qc3fxGh5l960BHvFjFz7iKNFwyRZNMX6haRnqeR2wuL/2eI1k3T11JfMTDvtwW+OH
	 MytA1S8oyMSlj/PUyvihn++u3J+mJHAwbuwg9U9B08sQgD7c5n5ZLlwC9lumGO/Ufdjk9
	 xTmqzPJh9U3GejIE7pG66fJWnuO6C1Mipma2rOGQ2UQJH6DRkBJ6KOuNpxiz4Fkb4qZPH
	 /4hBgz9CTufApDBz0kCUcowMg5+eri18rBnfgpHPXewea9htU6jyOJiuVOJZCDCYA/aEI
	 I0XtMisuut1MwUz+6kK5RyHpE7AaeIBBSZztrvuE+f6CoDwkRbx1ha6iVM79KEGh1Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788553770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IexzwNfEepf/K9zBiwJI5xzaHxZ8ZFqX9Ns1tlNoNOs=;
	b=aECHmdOfDA3q4RLhUCaHpo5zLXqVKXGCWH/W2Fl8k/ZRzuWRwBdKfPkQ6VM6z/OW1biE
	 3L0YqDgrcMs22nM5UQThqw1vdH7LFiGyDI+qCceJ3nzIksPygPcakHXpKQUGJB5kRnUxK
	 1sT8R+PK8vWy7BLlZ7h19FVt901BSUkPlA32PxR5OkL5dNhep+MqqAcQuUm5cRI/9Vrv5
	 FMPLIyU3/7F+yyiJkyiDj2jbodQDZZzgAbk3Y/s/WaHfrXnIIUuQWDIYLo4JS3Z5HE5YX
	 TESVl7iymHKG7utsOLNsn34eKDXkI0NtCD1FqRUcFOHr7O56jXGJNJ2mHJr2dgV/Odg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788553770;
	bh=IexzwNfEepf/K9zBiwJI5xzaHxZ8ZFqX9Ns1tlNoNOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGDoZDlLICHjL+fdXy85thSKpSHX4hZRceOnUEze7+N8SuQlzWfrdxdd4ivAZavZx
	 gGF+OQgamVOEou7FHr6YJSx1DTou4b+oGkt09/pLjJNKYhY/FlBSPkopM3m62FZ5Re
	 XHErC/8Wq6oLgn7DmgjiDhoeuqybcQh63dkNrZFHbaekqdqXA9X/q7J2dYNIseqn02
	 lCu8Wwvzuuky6vzvovkdWPy+PZCGrxaWTUekfdX3ilE/aitbwiJo8bGOx5uuzh3uly
	 HiM+VQ6boIEwpGXTiUWFe7w4mnPT1gOxsh4lM3ZRUn64NkHxYEEEXS838Jl6wQEB1r
	 W1hLQoSxiZ9jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EAD06070F;
	Fri,  4 Sep 2026 20:29:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5607724
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1CCA81136
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yhwrikbSMAl for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 20:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5D22581128
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788553768;
 b=NXe44BzNGuO0CGHEjkO1ouzItjvgWoqAxrIX/kYBvBhLVDNq7PuKdeM+SHDtcyKsrd5r
 jfP1JG10x34uaYk6OpKEcyRCCYbkgNANBvSIdIOQpV966Hg7OHVrSRwM6KTau/uxrF+QJ
 8EvP0kYDU1sdxzgJbrLD3poqXhpAcXAUhnlxlbKy4oD04zTFo1xTVbc0VmFCw2gmCFU0Q
 NCYHjgOaFixVyBhBN1vfP2tCq+njb1CcQHntRrBie9QxMuJnt+OWUb9JPHkFY80EE514G
 xvnKqB0YG5GonfbUyGRl+yo33eOzTJzf3ms0EL/Gs9ae7Fwoj25IGnGkOEvy8gN83Eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788553768;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=IexzwNfEepf/K9zBiwJI5xzaHxZ8ZFqX9Ns1tlNoNOs=;
 b=NOElGgAJu3IJT3G36MlGXb4yCUJlLeI7kfqCmPmWl1hgNfNr1BlQgtGLvdoVhRz05Q/t
 01O6c+DAKgsNrpfhi8/a6plR2zq4YzbzKTJDNwcm/P7w7BGEtUe9NombocSSXn/u9euon
 8jVoXzPsGxBqIPhWu8le8h69ZF4Lzq4u8+CJ17b9CI/XEWOfNzO7kVTepMvC+C/4Rod+i
 EqWGlhIiuVvW+u4C3gOMckHXpXvWCbF8SeEBhOW+zypPUsiKva4KSR2OQLDdOiXzH9F1m
 O6HbuRGDaFjywE26Z71XETm7LlES67ZHpxlUK7lQJnzt2jr4Ezv/+t/bi+YQ8wemzvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Zjd760uT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Zjd760uT
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D22581128
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:29:26 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-85b293528a9so25902197b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788553766; x=1789158566;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IexzwNfEepf/K9zBiwJI5xzaHxZ8ZFqX9Ns1tlNoNOs=;
 b=Zjd760uTWMkCkK+YKcSZXrmSg7djm9IwcnJ3rESbsEYQrrAibYjixl/jdJ/I93PAnc
 WmyBSYjaSwCBInidD0T9uf9WpCGFVctv8zWUsHxy27vThQ7m6ylwnVE3D+7ohSrxozIk
 Pex9D0iVvZaDQu7k+GIO11NEwqsbwoFtHnbGdg9sUWX5xKM3u+kkWghJmT3B+UL+uQLK
 fXjidmQs3cyHXTUP4Rqmp6r9E50RATbqpfP73J1twqICM9qVngnmn8K8QaoJXYdyAgbn
 kICTIdM7L6eGfSS4lVk92oUfAvuU8Pb9othIvRamJeaUwYuQPeKoylGdC2mlI/Xnvz1R
 SHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788553766; x=1789158566;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IexzwNfEepf/K9zBiwJI5xzaHxZ8ZFqX9Ns1tlNoNOs=;
 b=ANKvPbfRZkLayccdes2jCrLX5J1klV4308f96necs9QRvKVAktCsxveSmX2E7M1yEQ
 096GxBSNIE8VrYo06lwiZZpHYdnnQ6qBvscTBDRO1WO8zXfuVUOdJtlSDX1PnxqQaC1b
 8uQZ15VP0Zm1tYlDE24IY5GWoAWZDpjkMtcGtPUgm/rQOecjO3jbjYqgndZFzd6o6RE8
 vTKMe3W2JAC+w8z6VKhzXoxNTafxDqVHzMJLPsTv1Rl9euXOcwj+52z3BQNddl6vyEsr
 HDWdPtyJWAQFzYfevbyTXMhvdoMRQYyZybHLrz92EzQtH/gZHWefPCZKZaQ9ae4cGZe+
 fZaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygic4l/KtOEouHqRdphjk1mzH2nki5smq9RSD5lry5+C7iuZSQ/KOe+meGUTqY/FKsLqaKxK0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lVcnlLAEEhzpYDMzSd0iADykeoBnEFB48jbNyn+PB7jFshuXsf
 YZksV3oMR5esbMP+a3+SdgbuO4Br54s2IUbFbwhuH2dFFJhC8j4NOJOPj3ZTl+Hv3gCZ7y7MHK5
 SgRi9
X-Gm-Gg: AYBFou3jeTg3H6uhedPFYz/nfCEX0TnaUuMi08Usd1pMyDWWy9dH6/TBYt68a5Sai7A
 vL7zl6/f/RbdwEujxY+D2tH/y4rlJKMxJ6n+DkjPxe+zJSHFv0nyVPScOoZrzELYW68CK+cMukD
 fmq6BY1mpPTTyKqIcvLQIeRAycQ3xFm4DLQVjOW4iD+fRnY4Y2eucghbXpmEJAW4t4QXsW9umPJ
 wgn07K960XdVlPflaJtWY9cv9uSvv5PYTKyXM7unK23bAtLSqf69eocEp34WqGrbfvH4Ssd7Cvb
 1DpHnIm+rpHkK8rIcoxHPZ0ndjm+/hEI+VnWZdRWdYQw3OIXWLyLA5flMzvQkFRhXNPpKYeZHyY
 /egdHsMSXs95MqReygz6B3E1LgRWMOZjF4Ya4IH7PJSu1Ed5BBei3fsTqhvWQKk+rNjnnoxa9IQ
 b8xSR7meN+NvzNfOyJn33Vmc3MvOOWLUjVPylv8om/eop9TYOeVT/qJ26jRSLeOfelXY+07WZ8H
 1+q39367NkxhMCtAzwrbCk=
X-Received: by 2002:a05:690c:15:b0:873:5c6b:a31b with SMTP id
 00721157ae682-8735c6ba5cbmr7788377b3.21.1788553765701; 
 Fri, 04 Sep 2026 13:29:25 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::9ee7])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0efc1sm26001637b3.45.2026.09.04.13.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:29:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:29:21 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <apsphFWUeaW6MpJF@hiagonb>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com>
 <ao2Iqsq-Xp4dQK4c@hiagonb>
 <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com>
 <apA3hSs_P_NYkOCM@hiagonb>
 <638029f8-37a7-46e9-aa3e-9defe840c639@gmail.com>
 <fc19ff71-06ec-4bae-8684-9c6f1e6be5a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc19ff71-06ec-4bae-8684-9c6f1e6be5a0@gmail.com>
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

Hi Andrei,

On Sun, Aug 30, 2026 at 05:29:59PM +0200, Andrei Lalaev wrote:
> Hi Hiago,
> 
> So, I've dumped the registers using downstream U-Boot and yes, Claude was right.
> By default, downstream driver configures the PHY, so the PHY registers
> have the following values:
> 
>   # PHY_TX_RX_DLY
>   milkv_duo_256m# md.l 0x04310240 1
>   04310240: 01000100                             ....
> 
>   # PHY_CONFIG
>   milkv_duo_256m# md.l 0x0431024c 1
>   0431024c: 00000001                             ....
> 
> 
> With upstream U-Boot, the same registers are always 0.
> 
> Simply setting `PHY_TX_RX_DLY` to `0x01000100` is enough to get
> the SD card working.
> 
> The attached patch contains the backported PHY configuration from the downstream
> driver & upstream kernel. Could you please take a look and check if it
> resolves the issue on your side when increasing the clock?

First, apologies for the delay on my answer, it was a busy week.

I tested your patch and it works fine ;)
Thanks for the fix. Would you mind sending this patch to u-boot ML?

If you do, add:

Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")

> 
> Thank you!
> 
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
>  };
> 
>  static int cv1800b_sdhci_bind(struct udevice *dev)
> --
> 2.55.0
> 
> 
> -- 
> Best regards,
> Andrei Lalaev

Regards,
-- 
Hiago
