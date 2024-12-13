Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48196E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D6A8012C;
	Fri, 13 Dec 2024 12:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dXYFYtQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C7680192; Fri, 13 Dec 2024 12:06:29 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8433E800D6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30227ccf803so17634211fa.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734087987; x=1734692787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yaz5lOinv9MKOGdw4ta/+w1CTO453vhoCGOkKM5wXiE=;
 b=dXYFYtQL5BLUBM2JkLM8durIqxAV09MKaYWzdsRC+AZvT+xk2LVjd3AwQeJrc2apEC
 yXA22cXdFvPxxru6nAvxIENFgPqXIIo19XTgLI0eBK6s3HclMei7aPTsSP2hEncf/mmj
 lq5DeBU6h4Bsw3gg9EnrOdD+wfcEQzXnFaXrABdlcdkxoYK2bfGDA5UmrZrKtepxXivE
 iX5UBJN/apxxEE00Aa1m3mqt0Y2l2k1RFoXaA0Uv9J77ElyM/bvBF8oPVxPRQ6dhHwBN
 pyp6bSHECcEgTA3d6m/rtWIulSImkpkTW95+MelZPpFfjYuqdHdhCMgsNwoZ6K/spqPA
 6TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734087987; x=1734692787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yaz5lOinv9MKOGdw4ta/+w1CTO453vhoCGOkKM5wXiE=;
 b=o2IPpXExEpiMhONIuyLpnfq6TZxMW7wgLwfdt043ATZs2IRZn645yaP914N5uAOcCL
 QFIZOqHfwBIC9WZfgLgstcHqE7nwYxekuClyKBBtreW16qmprdBAteqi7p83UpXONhsd
 hzDzNe8ENWPX8+eHqYkcl0l9cPKnlBRswYhBygEnmFRF6jOoC/rPIFDdtj6seVR99W7g
 n7JAgZsAQsTRtLaR9iLMPDTFndXxnk1KB/D/gPu+JoRbztj544efpGg2b+/LOH1ram4p
 yCGDchy2Iiz1uuTGkKmqsXUSrqgCmmxp21jrvSNHoPT/uKF5P3+5cgcMM71cVbplgBQl
 chYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/M8cFszJ7ccMz6h6hrFEI/1Ta8zikQWSZXzD3Lsg+ctauqLfTfSYgN7t4FNh2VlxEzBqrdc8=@lists.denx.de
X-Gm-Message-State: AOJu0YycKyjz/OlIig5lBR5WYEOK31WEz71F1KQn1VDmjyEVTaVp97jW
 fv7Y7DfNf1u/NhlMur1cWv6VZ8zCzTu+mcNns5AsGxWn67xmy188hUArlwKXZphxtJvdbtgz8EG
 0yU0hkXtyoLDLtc27OS4iUn66XXsehQ==
X-Gm-Gg: ASbGncuV4gDKHuuixG8dI91DTEmoLOFtEmt7nm8B5Ecu/NdP/PyjMi3Va650tpFHasj
 cZlVxiVUTNCNUpUk8mOUJChS3McqPmoXo1fXl51E=
X-Google-Smtp-Source: AGHT+IGqoPeWWcpVmWH85ZpxzwTR6U+8OCrorL0LTF8o16yZoqjCPYIpH40QBKkITh0mxSwcoLH8zLpSiXmQMsk7djE=
X-Received: by 2002:a2e:be1c:0:b0:302:244a:da2c with SMTP id
 38308e7fff4ca-3025459ceaamr7595251fa.31.1734087986418; Fri, 13 Dec 2024
 03:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20241213102321.2166920-1-mwalle@kernel.org>
 <20241213102321.2166920-3-mwalle@kernel.org>
In-Reply-To: <20241213102321.2166920-3-mwalle@kernel.org>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 13 Dec 2024 12:06:14 +0100
Message-ID: <CAEyMn7aLPzD-GmzqTcHDUj64i=yF95p6bEMb1YQ+tfEfMHQ-cA@mail.gmail.com>
Subject: Re: [PATCH 2/5] board: sl28: increase SPL_SYS_MALLOC_SIZE
To: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 thomas.schaefer@kontron.com
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

Hi

Am Fr., 13. Dez. 2024 um 11:23 Uhr schrieb Michael Walle <mwalle@kernel.org>:
>
> Increase the malloc size to 2MiB because our FIT image exceeds the 1MiB
> limit either if BL31 mode is enabled or if another device tree is added
> to the image.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

Thanks

> ---
>  configs/kontron_sl28_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
> index 35894a10cbe..eae06b546da 100644
> --- a/configs/kontron_sl28_defconfig
> +++ b/configs/kontron_sl28_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SPL_MAX_SIZE=0x20000
>  CONFIG_SPL_BOARD_INIT=y
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
>  CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x900
>  CONFIG_SPL_MPC8XXX_INIT_DDR=y
> --
> 2.39.5
>
