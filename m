Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41031C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C064088126;
	Fri, 31 May 2024 08:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGfQ7C8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE128829B; Fri, 31 May 2024 08:40:21 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD65F866E7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c1aa8d302fso1135940a91.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717137617; x=1717742417; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qi8blXzDZ3eCuGNMd3zyJwYmUtaaieMODwdO9oIseUs=;
 b=yGfQ7C8qLbCNkUwhVmGxNborLz4nRVxz6dei2IX6aNG/Vk7MBuIe4duglE/7tBmcgO
 w6O3ifu0Wch6ej8vU/9jWzfnXdjLOnaqpx2DOSft25EefrDwDrRizA2ww+/cyfGRnyu/
 bG48OpWkeRSSAXmwNwq94cIImQ9nFu5qr9nUxzLO6CzehvP8cunUGoWinzW8Od/Bv24L
 AyRmVBV3CDfpYgJ6HjUyzoJ0WNxc3lelgjqcZDO0Jn9FnBikYbO4cEPWfDrzhcTimjYa
 vlsI0APSWnLEfRNkIwRIcpdSVF+oAW8d9vSOoBp3cg1FOIvdXRjqSaQwkvQz2OMr2TZt
 71oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717137617; x=1717742417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi8blXzDZ3eCuGNMd3zyJwYmUtaaieMODwdO9oIseUs=;
 b=LioemzYB/exlpLViMiSTwxQv91hOysBWLIRpy3djF6mjPjZ1emXoQO+DNcJJv2MiMh
 fWD1rPNSlg86hlKKj6KelVFptJD00r+oHYd7V2g+B1S+wtdtXoVLIST1Tw9L8Ck0tyl6
 NOtgJHjGQiW42JB3st38G6COXaqST+RMzsYa1OnjN2Kgq09rncisXsE0DJQwoNZI0Evq
 XnzCFaxQAnoCz+dNUwBnC6nv95hz22k/jml9N1mk/+yXOG1hQdCUhqkcAunHdU3o2sBk
 hxBH1lIrTlvyRTID0LdzmYB+reSHh0dIuOpp5nqGp64fCkmMqlACEAR3JFLHTgxDva0y
 DzlQ==
X-Gm-Message-State: AOJu0YzVdqZi5U4a+hhjcmOWqIS62miAjRI3irxVRHXUn0rnuKU1MzYQ
 gPqLgMPIVmOghgw1+HztHcvD0TdLYkel7RxPuq/OohQ1V+ReiOhIiScm8cYyn8poyjJB0wswzwE
 Je/Iliovn9Te3qeI8F2d6hl+3PMFC6Q2I8fHSig==
X-Google-Smtp-Source: AGHT+IH5oy+5VJ/JKfPCmeuqZOQzxDj0M9s2kr5cuWgMwHWNz0Z1+2KH7z1zJqgBhoClF4YBSiDpr+6WSISDlqgDmo8=
X-Received: by 2002:a17:90a:3482:b0:2c0:19bd:543a with SMTP id
 98e67ed59e1d1-2c1c43ee447mr1692688a91.9.1717137617248; Thu, 30 May 2024
 23:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-6-raymond.mao@linaro.org>
In-Reply-To: <20240528140955.1960172-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 09:39:41 +0300
Message-ID: <CAC_iWjKL4XCQFhhHTHZbnuuhuD-8JUxRnMZKnpnfBCUz12g-0g@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] md5: Remove md5 non-watchdog API
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Would be good to get an Ack from board maintainers here

On Tue, 28 May 2024 at 17:12, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> We don't need an API specially for non-watchdog since md5_wd supports
> it by enabling CONFIG_HW_WATCHDOG or CONFIG_WATCHDOG.
> Set 0x10000 as default chunk size for MD5.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v3
> - Initial patch.
>
>  board/friendlyarm/nanopi2/board.c |  3 ++-
>  board/intel/edison/edison.c       |  3 ++-
>  board/xilinx/zynq/bootimg.c       |  2 +-
>  include/u-boot/md5.h              |  7 +------
>  lib/md5.c                         | 15 ---------------
>  5 files changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index 393c5a447d6..f203499f544 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -264,7 +264,8 @@ static void make_ether_addr(u8 *addr)
>         hash[6] = readl(PHY_BASEADDR_ECID + 0x08);
>         hash[7] = readl(PHY_BASEADDR_ECID + 0x0c);
>
> -       md5((unsigned char *)&hash[4], 64, (unsigned char *)hash);
> +       md5_wd((unsigned char *)&hash[4], 64, (unsigned char *)hash,
> +              MD5_DEF_CHUNK_SZ);
>
>         hash[0] ^= hash[2];
>         hash[1] ^= hash[3];
> diff --git a/board/intel/edison/edison.c b/board/intel/edison/edison.c
> index 11e7f74e47c..1583d11c74d 100644
> --- a/board/intel/edison/edison.c
> +++ b/board/intel/edison/edison.c
> @@ -33,7 +33,8 @@ static void assign_serial(void)
>         if (!mmc)
>                 return;
>
> -       md5((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn);
> +       md5_wd((unsigned char *)mmc->cid, sizeof(mmc->cid), ssn,
> +              MD5_DEF_CHUNK_SZ);
>
>         snprintf(usb0addr, sizeof(usb0addr), "02:00:86:%02x:%02x:%02x",
>                  ssn[13], ssn[14], ssn[15]);
> diff --git a/board/xilinx/zynq/bootimg.c b/board/xilinx/zynq/bootimg.c
> index 2f55078dd76..4b2245c0618 100644
> --- a/board/xilinx/zynq/bootimg.c
> +++ b/board/xilinx/zynq/bootimg.c
> @@ -136,7 +136,7 @@ int zynq_validate_partition(u32 start_addr, u32 len, u32 chksum_off)
>
>         memcpy(&checksum[0], (u32 *)chksum_off, MD5_CHECKSUM_SIZE);
>
> -       md5_wd((u8 *)start_addr, len, &calchecksum[0], 0x10000);
> +       md5_wd((u8 *)start_addr, len, &calchecksum[0], MD5_DEF_CHUNK_SZ);
>
>         if (!memcmp(checksum, calchecksum, MD5_CHECKSUM_SIZE))
>                 return 0;
> diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> index 3cfd33a8e56..3cb87328175 100644
> --- a/include/u-boot/md5.h
> +++ b/include/u-boot/md5.h
> @@ -12,6 +12,7 @@
>  #include "compiler.h"
>
>  #define MD5_SUM_LEN    16
> +#define MD5_DEF_CHUNK_SZ 0x10000
>
>  #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
>  typedef mbedtls_md5_context MD5Context;
> @@ -30,12 +31,6 @@ void MD5Init(MD5Context *ctx);
>  void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
>  void MD5Final(unsigned char digest[16], MD5Context *ctx);
>
> -/*
> - * Calculate and store in 'output' the MD5 digest of 'len' bytes at
> - * 'input'. 'output' must have enough space to hold 16 bytes.
> - */
> -void md5 (unsigned char *input, int len, unsigned char output[16]);
> -
>  /*
>   * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
>   * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
> diff --git a/lib/md5.c b/lib/md5.c
> index 34343cf8e23..2d8977b2e85 100644
> --- a/lib/md5.c
> +++ b/lib/md5.c
> @@ -262,21 +262,6 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
>         buf[3] += d;
>  }
>
> -/*
> - * Calculate and store in 'output' the MD5 digest of 'len' bytes at
> - * 'input'. 'output' must have enough space to hold 16 bytes.
> - */
> -void
> -md5 (unsigned char *input, int len, unsigned char output[16])
> -{
> -       MD5Context context;
> -
> -       MD5Init(&context);
> -       MD5Update(&context, input, len);
> -       MD5Final(output, &context);
> -}
> -
> -
>  /*
>   * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
>   * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
