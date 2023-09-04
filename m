Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1CDC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 03:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25009867EA;
	Mon,  4 Sep 2023 05:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YR9soDcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02588867F7; Mon,  4 Sep 2023 05:07:36 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65874867B5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1238691a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 20:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693796853; x=1694401653; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCpsT7g/cHOyp71odNG6Dp9vWl/BVDCRnYyx7EC8RtA=;
 b=YR9soDcpgC8DgF1FHlzA7JI1z9UZpDoBw9KVp19Jy78hv6+KDZXBd4y5qo5zYnw1x4
 BLiLVkNzdRO2CZfO/csBAv+BjoFoVNRtiw9byI7YgDbC4T7IhCo88HypFmfn7F15xv7G
 RUgb7RpOVUPPBvP8P7zzkPaZF+vGiKR4qC3QxjOuaMMeCAVuWYUfz4EV7MuOvk6habqR
 gQFPzC6oHcOtSts/Wsq0Bq/TDLb2taNuvNMvWDvvEP/KMDeE8X56xyRTa1dSrUDKUN2j
 KfCqkzmvKhCVxIttLvRPKrkC6HYR77F6vSnsTFRiSThYydlAOAXS6bgffEOV9iTcn1Wf
 Vfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693796853; x=1694401653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCpsT7g/cHOyp71odNG6Dp9vWl/BVDCRnYyx7EC8RtA=;
 b=DIcxMUYWchs7fmKvb1oni/khvogkkSza5XAuwOcwyWeisqv7261y2FKGtRl7cYVYPR
 /kqiei8UpQqPTwgh6DDHWztV2nEzz4FofvL982JtUIe6ixmhBx3f5EqN0oaQ9xg1TUoI
 o73Ykyr+b9oxZAyAZ0oHOnqmbJWw31Ns3wlpyP363oz4m5IIa6wCO8amlnjf2lMpTvR2
 oFc47Xr+v2ZxFFjYwUXDGGcDTztOP/OGLBsyAEXH+7yi7Lu/3BxLbZ2KWL5WpV11C64z
 3zSEU23KGTpJ9LWOUnK2KekMOGNhWu5jUJwGrVJDlsGoRteTo2XjPBxcgCAve3G0O5gd
 XJBw==
X-Gm-Message-State: AOJu0YxpL2OXx5yHWmof8J7+h59fDLK78dVo5IenXGDOqfxGvFdp9jA2
 d88WEVvdT1n7zoPKDpcknRwivooqP1cw15tlN5eiCrC+i5WX0t7e
X-Google-Smtp-Source: AGHT+IFVryTTMD68cSkaX4ybkeEbPiYEKF/KfwUGDb61GIiimhu8BRKx1ZK82aLeRYCMdktYs7DfH2knRC8+R+q6fw4=
X-Received: by 2002:a05:6402:2027:b0:522:b112:6254 with SMTP id
 ay7-20020a056402202700b00522b1126254mr5541634edb.4.1693796852596; Sun, 03 Sep
 2023 20:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230817015754.776507-1-sjg@chromium.org>
In-Reply-To: <20230817015754.776507-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 11:07:19 +0800
Message-ID: <CAEUhbmUaE--7hn=ybJ2cofjYkH1cfO2m4=PQ1auTy9OOjrPiyg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86: coreboot: Update cbmem table
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Nable <nable.maininbox@googlemail.com>, Coreboot ML <coreboot@coreboot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Thu, Aug 17, 2023 at 9:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This changed a few years ago to include an overflow flag. Bring in the
> new structure.

s/This/Coreboot

"Bring in the new structure" does not sound correct to me. The
structure is not changed. It's adding a comment block and some bit
fields.

The commit summary is not accurately reflecting what is changed in
this patch. How about:

x86: coreboot: Document cbmem console struct

>
> This comes from coreboot commit:
>
>    6f5ead14b4 ("mb/google/nissa/var/joxer: Update eMMC DLL settings")
>
> Note: There are several implementations of this in coreboot. I have chose=
n
> to follow the one in src/lib/cbmem_console.c
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Drop __packed as it does nothing useful
>
>  arch/x86/include/asm/coreboot_tables.h | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/coreboot_tables.h b/arch/x86/include/as=
m/coreboot_tables.h
> index 4de137fbab9d..0dfb64babb96 100644
> --- a/arch/x86/include/asm/coreboot_tables.h
> +++ b/arch/x86/include/asm/coreboot_tables.h
> @@ -299,11 +299,24 @@ struct cb_vdat {
>  #define CB_TAG_TIMESTAMPS              0x0016
>  #define CB_TAG_CBMEM_CONSOLE           0x0017
>
> +#define CBMC_CURSOR_MASK       ((1 << 28) - 1)
> +#define CBMC_OVERFLOW          BIT(31)
> +
> +/*
> + * struct cbmem_console - In-memory console buffer for coreboot
> + *
> + * Structure describing console buffer. It is overlaid on a flat memory =
area,
> + * with body covering the extent of the memory. Once the buffer is full,
> + * output will wrap back around to the start of the buffer. The high bit=
 of the
> + * cursor field gets set to indicate that this happened. If the underlyi=
ng
> + * storage allows this, the buffer will persist across multiple boots an=
d append
> + * to the previous log.
> + */
>  struct cbmem_console {
>         u32 size;
>         u32 cursor;
> -       char body[0];
> -} __packed;
> +       u8  body[0];
> +};
>
>  #define CB_TAG_MRC_CACHE               0x0018
>
> --

Regards,
Bin
