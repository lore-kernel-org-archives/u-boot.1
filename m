Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D16C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 15:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482FE87ADA;
	Tue, 31 Oct 2023 16:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0i7Eq9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB78887AD7; Tue, 31 Oct 2023 16:13:21 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B504287B1E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 16:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bcec7a304bso299982a12.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698765197; x=1699369997; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5pg3gtdy05cCcSn1+fRzLEfhLck2OaOaU8KkQjGEdk=;
 b=I0i7Eq9FBd2vpJnP1/CNazLWxJUNKCHHwpXhiiOLCoQ0Dn9btzYrFQoj8qs3WPDxhF
 V3H4FfSuPkB/8YODUoOwlbxZ8ndsBKkrueJAB95aW2wGCxcux3SR8/uVgOkKPK/2a4/n
 NAV1PWTKuC+Gj3ZmEKGkjyBtI4rDt3Fu9JaW1svIVs5QslLbHyrSawjyryiAGFUUfj5M
 8Ija3B+47YYG/5A+Pyv+ePZf+uULr1DGaNszZ1WPOBQKIiUSjWJJNv6TQLJpC/G9Qgfx
 tmUbv7bMugehIPzcwbcpasO530QRYAwOB1CzNDA0On2eEM02S2xWix1xoY1sWpEAcXwk
 GVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765197; x=1699369997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5pg3gtdy05cCcSn1+fRzLEfhLck2OaOaU8KkQjGEdk=;
 b=CfhuzJWSd48UTJDnITBOFrU18f6fJnx9Qeo7+5+hMNlCZhkZfAtVyECpliEgsbqqcH
 e7EkXLxz/SJo3PcD5OTVKH72M7JWPuBH2uB+lm5mj9TsfJwR517LDALWo5L7MlVPut8k
 vhbbDBuXXWw1dJIXFFDOk8njnKdiTQIrmnduMSZMD9UChdRuIzHKfth0/xsZVndykLMp
 b9CirwDOCb93DPBLM/pyMQGRImRcxB31c/rkRs/fatbl04LTKHptpaXnqItV8mOW7MsO
 A7xp+ITuf7/clGK/2ofS+VQ9+BpMnKOtZkhOfH5Goxmd+prmwEU0aoo837N6saNfHzZc
 HoCw==
X-Gm-Message-State: AOJu0Ywo1kt6BWqFySco99NEu/AsqxGTXPg/C1lcKuI9EOS9+uAD9s8x
 D5HZ13SKO7u3Zg06dnhXGIEvyzZTKMvYobPNbBuAREyl
X-Google-Smtp-Source: AGHT+IEC6jrpfNnDWYu75Zpv3t6vvhV6JRG8t1V/oMH179icUN2jp8tJtmNqygqOU8IWvNNV2khkthPZY2LHv1BR0+k=
X-Received: by 2002:a17:90a:cc06:b0:280:2652:d46 with SMTP id
 b6-20020a17090acc0600b0028026520d46mr9056094pju.28.1698765197555; Tue, 31 Oct
 2023 08:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231025231311.8701-1-aford173@gmail.com>
 <20231025231311.8701-2-aford173@gmail.com>
In-Reply-To: <20231025231311.8701-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 31 Oct 2023 10:13:06 -0500
Message-ID: <CAHCN7xLZ2xp97nnb4JBj8tWEd9Zhj6mYX61bjrtGKRhPOUm7BQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] configs: rzg2_beacon: Realign ENV location and offset
To: u-boot@lists.denx.de
Cc: marex@denx.de, aford@beaconembedded.com
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

On Wed, Oct 25, 2023 at 6:13=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The ENV size and offset were changed to different
> values in Beacon's downstream release.  Change them to the
> same values as the downstream for consistent behavior.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Marek,

I know you had some feedback on other patches in this series.  I'll
drop one, and refactor another, but is this one ok to merge as-is or
should I re-post without the other patches?

adam
>
> diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfi=
g
> index 7b14d225b5..534f641e84 100644
> --- a/configs/rzg2_beacon_defconfig
> +++ b/configs/rzg2_beacon_defconfig
> @@ -3,7 +3,8 @@ CONFIG_ARCH_RMOBILE=3Dy
>  CONFIG_TEXT_BASE=3D0x50000000
>  CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> -CONFIG_ENV_OFFSET=3D0x0
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_ENV_OFFSET=3D0xFFFFE000
>  CONFIG_DM_GPIO=3Dy
>  CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774a1-beacon-rzg2m-kit"
>  CONFIG_RCAR_GEN3=3Dy
> --
> 2.40.1
>
