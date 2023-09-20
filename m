Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47DCE79CB
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC28B86A2F;
	Wed, 20 Sep 2023 13:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M67q/ycL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F83B86813; Wed, 20 Sep 2023 13:14:35 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573F486A2F
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 13:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27661abd326so245996a91.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695208472; x=1695813272; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7picsXvg+Usa99GGpn1tX7vxbnFYHkWmYJmfDoK/goQ=;
 b=M67q/ycL3zwSj9yqb0hF0+2wLwCOZO3wE+K9cAvsPKHTAnpXTc4jWdMe7QqHmpYVSX
 d4sj5qo0amMzM7siTnUOlfINttMsCZz/jv60ydfvdTdtxF90JuN1SKmW0m88O8O/8rFe
 HqP3A6gnKgFxdSb7NKQgPeZTpo7uu6a77SBsEr7CpAOXHLAoSTLfrx5HDQgNHOSpUGB3
 TIsrC+lpCVH0CiOt5mmXoFWqVsXORMChXfg3URtHaAkpOwPERStv74hyhHXswy1kIb2H
 GdDAIolpf9faTBQ4QyRNQQ8r4+smxrk8JMoGq5QuwhsO080+bACmf9HDKVzKC/UDaakb
 nDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208472; x=1695813272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7picsXvg+Usa99GGpn1tX7vxbnFYHkWmYJmfDoK/goQ=;
 b=qB/aj2jdlK+9fRdm2ip0WEgou+N8ZU+OupyMocHvPJVAWvhwxu5Dn0eUxR9AxD5GPJ
 nH5W8yGV6TH7I6SxSQT5Gs+8UTfvI5MIDMPa/xeH9feTTEmeB7I+/aKwpBS9GEHqmGCH
 p460fonS+VzTdZuAXqSJAQnSXNUpqQyIP2ouw2zInEsgC33qYQcKTsSh4QasXtsU18j3
 4r5JB0ro2I40pcXSTVK3qfKw3Kw9zsuQo7Q/xOeQzpYE76uWhZJdqjcmH/OTREO8+7ym
 vUQXBkl4tMUIPBPO8rd2rvl+E2rH0+7xkkVNwDe9QaD5z7zaaJkjDtntTbj7sMwiFcid
 7v3A==
X-Gm-Message-State: AOJu0Yz+BaRAhBTt3BiqVzwWf2oq2Bld5QKwZCCz/ByJ747n4YEO3ISe
 HvQGyG/2CIKwec1LCIMaacjSnGt8X8JM4Upy4xc=
X-Google-Smtp-Source: AGHT+IGpFFbtXFM+WbGlBseVLk8+Xlo39Ae5TrFTZm/Hheb0pHUAXBPD0bjhEnRCkm7CBKGMg35UTSi3C0dmoLxbouA=
X-Received: by 2002:a17:90a:6f61:b0:26d:4ade:fcf0 with SMTP id
 d88-20020a17090a6f6100b0026d4adefcf0mr2118696pjk.4.1695208471649; Wed, 20 Sep
 2023 04:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 08:14:19 -0300
Message-ID: <CAOMZO5CZpjkh98m8f1Tr1etcw6PMu_6LH-mgv9V_KMoXvXOeuQ@mail.gmail.com>
Subject: Re: [PATCH v2] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 uboot-imx@nxp.com
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

On Wed, Sep 20, 2023 at 7:34=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
> tacked on beyond the end of the fdt structure, is expected to be (fdt
> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
>
> Now, when the FIT image is loaded from a storage device, it doesn't
> really matter that the flash.bin that gets written to target isn't
> quite that big - we will just load some garbage bytes that are never
> read or used for anything. But when flash.bin is uploaded via uuu,
> it's important that we actually serve at least as many bytes as the
> target expects, or we will hang in rom_api_download_image().
>
> Extend the logic in the csf.sh script so that the csf blob is padded
> to CONFIG_CSF_SIZE minus the size of the IVT header.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> v2: use dd instead of truncate.

Reviewed-by: Fabio Estevam <festevam@denx.de>
