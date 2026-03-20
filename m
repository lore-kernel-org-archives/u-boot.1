Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2074C1098797
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 15:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9633583D71;
	Fri, 20 Mar 2026 16:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W802Tsas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1CB83F9B; Fri, 20 Mar 2026 16:32:50 +0100 (CET)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AD783CEA
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-127380532eeso178218c88.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 08:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774020766; cv=none;
 d=google.com; s=arc-20240605;
 b=IGlkYbmN/MsIZ5adjsRtILgE1jJZMnWxMGd3ohQbZ5TrWN2N2RiYZj4Gc5c156qWpV
 IK8Wd+RsWP7BF9or0n2UqVJkcIVIZ84yuMfn4efNvGRrxPBOTqC0eJjIrn4cEULr5OEa
 MMK1FzPnns3DZjCdkjkcDAD0m5zJOhm0XPHg0Vd0G/r1/AAqZjARbwZTOK4j+8OLb1Wf
 CJBKs63N14SPUU3Qn+koxU2fPITMlPazuYnR7sU+voghbvbGizAfqalHOw7LEGI5GSNm
 tn8/tboAow59EJGBz5Tn0uXZyi7k28hUIjwolVOsGPxKRqZ5m4b8/9bYG8JILSmxkg4n
 TXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XMlY8k3eRPvkUk1QUIasP1d9CDBJxwEeQ4VztJxvmOQ=;
 fh=7dnD6jdbQiDzkpj99NveqitsOmFzdY487ttwbMO1t7o=;
 b=Byo7RUG6zVW5BBKE8DQoachZ+jGNKr5SEeXqyCOHXK/EiXRzE6O+CZ/jVn5zurqevM
 tOlFSLQC0FQV2zQXa9s5I2xyXQj/zscAo5BJ28bl8rwYSeHmXWooKyMX2O+VezSzbRXj
 FtfCPT6FfgwuxcNdJoPbq2yct6Um8QCCccAQ2UllFyzj8IVrZViYabjArSWFXDu+mkrx
 KUXxiPckO+kl6wEEz9CKb2lSwaeKvpeve9lTxxJiVAW+aieF4EEtaAGkqIzwXmel8IlY
 u8Oy3WhLXmjzSsFnSis6aCFy+UHwLOCGWPos2uMYJLKqufg+HKpPJRGAuN8aL8GySZIs
 7f6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774020766; x=1774625566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XMlY8k3eRPvkUk1QUIasP1d9CDBJxwEeQ4VztJxvmOQ=;
 b=W802TsasQZuTmh9MUQmwsXj5cVhx6CLx9Z+TAcOwnqLtgUDTvH3/Xm4bmFNExUtqls
 HjvG3UvDDjtMAfOhG2iF943qJ2/EF1Ys8EtIwlynjgEMzpC7gZYJrNTHhxTK4dnZVQHh
 p5vRtNVJF7NX9CeGND4jkosXfx/8ekcpOyWDu8ADRIoUolkLhDiccOrHoZh4rX1paDhY
 M+wXjbt84wl8uDsiUPJDUng6qIkhIVOp5kMouv3MN98wBHDh/BVn4sbnZuTncesMOLis
 ZYJZcSaDt0MrScqrI8mJxhpscRpfQgWEyZwljb3nTkxdCromXRfgUA189pyrN6VoZiKG
 HsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774020766; x=1774625566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMlY8k3eRPvkUk1QUIasP1d9CDBJxwEeQ4VztJxvmOQ=;
 b=LNpyzamiOqsa8+spNYuRIOvd91lkfX9YrKXKkgBOSzJld6o8nLOwCD6UBgQdpTHH4N
 l48x0fPwJz/eUtm+tHX1aDWt6fbgem9yhjlLoMEwa9+vpBinRQusEq4WpRQcvRlQPuqb
 uD7lxouCFf5nXmgpu0Wnbzbw/XhMTIvraPrXJEPaGXHTF347HG5EJqO94Z2ousiYKYUh
 sgUx67UGMQ/VolBsRMwKkgl0rc33JGbvLm185c6bo4ndJJN3/wy6GCxm5QLoEIS50yS3
 dqwN3fE9fTF89MS6krK++iexSWXJO8F45ckqSCyZpOeYppxU3skJr8pmj53cbpoq1Tpc
 mUDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgjASRVcshAmUYZ4l77seUU0ZnxzRmEU8ugriSnoZVwr1bjajrvqhu5bEM15BgWWbdWLdwTQo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+o0G55zpwXHPirZbOfK5x8n3k2V73RtB5WSrSmDZYu8efqjjq
 pVtnNclIgxZte2ochkOcE06FXYDPi79ZDTfJYokQUF5NG1rAhgqB6upQchimpA0MtKk5aV09mm9
 1kWdd8cPC6fnJoFa0GQxjWWcvOXNCzgQ=
X-Gm-Gg: ATEYQzzem6gUoYTV9lPeVk3EsO66oUQM0vKLQRy8DVIlNpXqIay6v3Hv5JQBZRUQB+i
 HAnYdU0RF4/+e4cU8uqAJBWjOt0IomQaz816e38ed27FF9bi6ogWbHrYzQiHJQQCgpHndmw44ln
 BLWCXqEL7nGcT3tG8zvUKj+AJS3MnqxJe6o2cRHhS3vmx4RkT91kNXia75uIkBJUzmZzFn7H2tM
 EwBTzgmsl3aU8CEgIioA/yh9RS370WkP0Zplc1kczQYJx/Pk/XnqS8R4oaN84wGNFdMIejrOb36
 jQdw6SBFbC6ESl/OX5sDJiOd0otGUCFzAFVkokLicMFOTGfJYEnsj+4pkZtCoZMrezOwUAbbWuW
 g5sCLUZbOcKDgAW7hdDOE3y+tc1I=
X-Received: by 2002:a05:7022:612:b0:12a:713b:8964 with SMTP id
 a92af1059eb24-12a726655fbmr1710415c88.11.1774020765985; Fri, 20 Mar 2026
 08:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
In-Reply-To: <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 20 Mar 2026 10:32:19 -0500
X-Gm-Features: AaiRm50Jdwg4v1zhIRDTpw-OIq2dp1fcBHgJDyOuV8qOxvEn70Wy9VGn1ABRORA
Message-ID: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: Anshul Dalal <anshuld@ti.com>
Cc: rs@ti.com, bb@ti.com, nm@ti.com, trini@konsulko.com, afd@ti.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
> >  CONFIG_SPL_LIBGENERIC_SUPPORT=y
> >  CONFIG_NR_DRAM_BANKS=1
> >  CONFIG_SOC_K3_AM625=y
> > -CONFIG_TARGET_AM625_A53_BEAGLEPLAY=y
> > +CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2=y
> >  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
> >  CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-beagleplay"
> > +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-pocketbeagle2"
> >  CONFIG_OF_LIBFDT_OVERLAY=y
> >  CONFIG_DM_RESET=y
> >  CONFIG_SPL_MMC=y
> > @@ -44,8 +44,6 @@ CONFIG_SPL_I2C=y
> >  CONFIG_SPL_DM_MAILBOX=y
> >  CONFIG_SPL_POWER_DOMAIN=y
> >  CONFIG_SPL_YMODEM_SUPPORT=y
> > -CONFIG_CMD_BOOTEFI_SELFTEST=y
> > -CONFIG_CMD_NVEDIT_EFI=y
> >  CONFIG_CMD_GPIO=y
> >  CONFIG_CMD_GPIO_READ=y
> >  CONFIG_CMD_I2C=y
> > @@ -53,6 +51,7 @@ CONFIG_CMD_MMC=y
> >  CONFIG_CMD_EFIDEBUG=y
> >  CONFIG_CMD_PMIC=y
> >  CONFIG_CMD_REGULATOR=y
> > +CONFIG_CMD_CACHE=y
> >  CONFIG_OF_CONTROL=y
> >  CONFIG_SPL_OF_CONTROL=y
> >  CONFIG_OF_UPSTREAM=y
> > @@ -90,10 +89,6 @@ CONFIG_MMC_SDHCI=y
> >  CONFIG_MMC_SDHCI_ADMA=y
> >  CONFIG_SPL_MMC_SDHCI_ADMA=y
> >  CONFIG_MMC_SDHCI_AM654=y
> > -CONFIG_PHY_REALTEK=y
> > -CONFIG_PHY_TI=y
> > -CONFIG_DM_ETH_PHY=y
> > -CONFIG_TI_AM65_CPSW_NUSS=y
> >  CONFIG_PHY=y
> >  CONFIG_PINCTRL=y
> >  CONFIG_SPL_PINCTRL=y
> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=y
> >  CONFIG_EXT4_WRITE=y
> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> >  CONFIG_LZO=y
> > -CONFIG_EFI_SET_TIME=y
> > +CONFIG_SYS_MEM_TOP_HIDE=0x4000000
>
> Any reason why we are using TOP_HIDE here instead of just moving OPTEE
> lower in DDR like we do on the 512MiB AM6254atl EVM?

Sorry, that is now a legacy setting before OPTEE finally got moved in
v2026.01, as this had been developed thru v2025 u-boot releases..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
