Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D738CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0F1960834;
	Wed,  7 Oct 2026 22:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBreR-oYdKGH; Wed,  7 Oct 2026 22:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B776060A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411386;
	b=NCVOpT51uwurNgjycp3FXesQNpr4kqo+1aMMFKqgw8GBY/AwbWPdfi4vKljiv0zDvqOd
	 wsgs/6zT+pgB/dLflArWaXnaishKHL5DurtvDjzPLymN25wSoiSJLKydTDCVDmMCV6c+D
	 JVgeFS7Gf5/1hq3HUBmlox9J67e+y2yt6cHmiIwNAf4txYevRhsq/phH2eRw/FGQ29C7Q
	 zG9sj7xNFC8dCCu04r677uWOLl/QKVsVNWcfW2haiQVJNXz6GuWKYq62sgx+K7pHaT+X4
	 p8s7Mr/YWO8RyLFUphOaZ2ZW6stghKYugQBmlS6EPvFJn3J1hLzkXNAyVv5bOkNfBwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
	b=V82lTTqbFu/GPGv5M83sz95jo0vS9pwBYHc0RNeWPfgp0kG2s6uCzZyn8/PHjJcRADg6
	 wYRpzPKusMg8vYXg6qspkD/z0yQzVAGRKK16Z785eZvcu7HFcGtEs/ILVbFiK9L8tk/7c
	 O7lmjP+s1X6uMJdJyeYIeSlERm9Yl8hA7TWCNJ4mLh3efESAb7+IKoTgX4Bjp7eALsZ/q
	 XktHwBATJ1RDDFAjFJele9D8jH8uYSHOmMiHtgbMVCvG2DY3AYDPRMwMzkfchekWU++Ng
	 BawNUW3GWCRV1mmCKcBIHpyUVeDfXo2lT3YPSrjN/MmPRXM/R5KkjuIRx5nfDVkYDjg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411386;
	bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CXzu8mnO5Vt1ysV38RjaBDdU1AXm3Uk25zloJKAICDoTDakqU33G1HGL/soydPtb3
	 KWGB7mFLUe4GqA5fik/arHwICEL/Jxe3vItiU0OnYCOuoNHT9wThN7G3EWP3dT+88X
	 xPZlmJi1v8DnUUA5lXXANaaGghiCBVUkb6Oo4WbnCpUBwekJo5ICSLtXeDJF5Oyfb4
	 OQuEITWnXuLC3HvGRALLYcbrqr1oF+9hphsWwpioPZf5ceXmyAvtSG/vOL4/DXdXgg
	 00SfCAd3ASZA7s4Kd6t/ggFAM0PUd4KKf6dZwGiXdPGL3CA8h6fXLPoyryrCKZ1+Vh
	 tz9X5bHadn8+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B776060A41;
	Wed,  7 Oct 2026 22:16:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2C8432F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87C75400BE
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FANr6BOd2oSl for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 652E74004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791405389;
 b=NYb8Akzr1Wij672BwZQpudMsywlZa3M+xNa/BDrb5j6czgEJoqdF0erzQAXAmrnGvF/f
 I4Ufcb0ukksBV4eVImGkJfyShIEH8OzkwWcreNXnXcm/EwHdyYQOjTsikD9IlbO9FW2ML
 0ZUkp3ieWFQs9H8WD65yQPXF60FrXyAE7mtBIouCqxTidodcOtGZg1OiUpWcNpH5kQb5C
 FALlaOfatIitQNfiptEGCOHgo231PZfml3MnF4buSwDMu0bRPEFJc6juDpGvTUxCz3Fgw
 7qUeDdAPGvvR759gJHC2iTP6Nyw/6QUF0T1eMXzgSLk9OmBIK2+8OXvngX51Ie1mDPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791405389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
 b=YHNoBYXn6RsozisyhIC3vVta2m1DXQgK85e1tbEhXEIiV6vWGIlifq+TciHPnCaxp+Ur
 Nj8RFhPmA6JuIwjMBuonwQN3tUKhH6cgk5YD8tpJVy79MlE1vZlUbkk7Ii07bLWFnHQNB
 JF2BDt1+Tx3v42tiVfBzRkh/T7KyU66zGoFR4AqE8bci70kINJ4PUxcdg2HwRPEUIkl/C
 0vgDafarwgvLSvMR0Vt+/m8s8vbOt9HGLfPX6iDqw/TQh7re1hgkIq1tmvpm53BZS+RgR
 eM+R5S0uwfhNuwtfkdDp+SpfjLRYYwammlmvXUwttxmPtG5vDHfPMqZvgvfVl1Dfkrw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=I2q9+zuA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=I2q9+zuA
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 652E74004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:36:28 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5ba357a1929so2220895e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791405386; cv=none;
 d=google.com; s=arc-20260327;
 b=Ei4wvDaRL3ylPOYpP5DF1a+pKlaRtHngPqsGd9p4E5wS+34/OP/idiEbDZV26fV7fr
 IjJxcBRtiSucgnyts3SW4+nyuCu5Qau3itvt/UJxOkPgMkNQrVMvJbcl/qkhP6TfkZ8j
 r7No1DcZuI/llKBycUQMty/o8WSKZKcSmfQnTLGE6JoSNQ8g0FKAD9WRbuPCpsszKdj0
 3O39qbtQN0y4gHU/7DJwSmCY4s84I6I6FRk28O2FEY2BrM0F9hDN2+apoZ9IUEcbqvJS
 RdfR+KYgUjD5PhZuus8i7fNyNp6NxqbP9t8UjsfjNLrF8zs29EJ3aBes/YGE2iJSs/Av
 osnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
 fh=i3Js6Kxi1DPMkSJ/e96zidsdWhIlUoWjNXLRjXPCSsQ=;
 b=SV2jaUneaQCdfcVIa3s8a9YK/Cw+JHDnzRcfehw781Pi2KBR8NSde4FZ4WX1l8G1c4
 w0wdwV7rFUhBfDSA3d0sC8jLwsF8+2rPFS2fAybzT32bPzYyuB8iMpW2Ta9xrGRplFBe
 eIwKdq4z5yGdO1h7gwqwD7UcRGiLiK7uqcuM3WCdX23VOZNbPl9talbvDbg70oEGusMg
 MQC5gtxyFZqHcvUZ25RYa1yeFUdIN1pSA/oS5cIL2eYN0vP3hFAk+dP8Ja0cu/6Qn5ji
 IQQfRul1I03cSA22xkh3DWSAcUcmzHccsJvCD771TQQ3X/txnKS3Ie92OxGu7qfgj73K
 RE3g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791405386; x=1792010186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
 b=I2q9+zuAXiLMNoJJgLF1qMQLP9I5RjyxLEZS4ONhM1olDhGJBBirLwk532VInmZRCi
 prXY2eNWweY25g74LRhXKgY7bi03wOrMiW5IR5NWwPhvP+OXBErbD5ncG1DrtWSGnNV/
 ltplyNa7Mo/YgEBYFKkvmgXwC+E5nc2Kv94SiB1+lLO4mMTSY6LNZ3heVhNXp+QEmkGE
 UsIA/esJOuS/VT3R+1kbFD3Qc0BBnT6RNpp7TUnKhu7BglO2GCJXq2ZIx2GnkfibEFQp
 qwnw+q11mdprCHlI5CpRcfmARati5zJRdl7Y0Icr3iII+G/+pS63KAEEdXBrqmNsr3mv
 mOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405386; x=1792010186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4WyQ0HH2X8CKloexiJ7EaNoBwCtP5mLjsc2/BKFKjOI=;
 b=q1FTulZ0FGuCmRg1s2PgO77VbolxmYHtUWDE5mOsKLfF+DQ456YN3yzuSd3MrbYwWY
 9HFiscrUO15V6KxA+cO/SVLbQGjd6Qalgt4Kn7QD3Y7ODtEGgYghAKDssMuZvPSZH5UA
 goEpm0wXGd1ayb2zXmJMqG2fLgv7XJBkKmWHWhw8ZhFTjBZhQogKRNjOErgccHqEEWvL
 4qEzPJRX49LdcL2l0T8bi32o1oaIEVdAMShNVVDo+MgNUQoFNCRLbIFdiZnHzice3pq+
 J+FiPvE3POiXNxYGshHQ3E0dGhYzNS0D9X3qCmazPbQUo3VRVQ1C3DC59DBPRFj/71mk
 fo7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJa3hbGL8WNo3es0/G7dbk8Nv4ifoAzzoEpclJABnZXZEM7Sxk3tpk2LR2IFA8o/rTqHEjJaw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIHjvxXcM1+rqn+R5h9cNbf/ctlZke0BBOOriDNvJj/avdFAXuJ
 4gxN0sLhT3d4tdZtQCrZAmaxHNa68J4S6LH47WUTBYposQlnLHWxQe0hCJGntDsJmkUoXUInZT0
 SM48LxFJXEJG4uhKTdpfuL9PP+PtZy/0=
X-Gm-Gg: AYBFou2ySEik+QeAsUs4ERKMHfrJo54tJlk2jnzCvJ2J+fGfu4IS/Pyh6J4KY2QVBUQ
 EmyjmQUHura1VEDI4yqggc+D/7biBqhs4t0V80ZlSliByP+tLlhY+Bihb5Hgnz9TkbSEwfIAo79
 iUguNihW8DXG0/TdB7N0bBzpniu0WSxv10lAbzGijWzlY5imYpYM7RFaThxjkqSHnnmFNAfxhjT
 2LTXKVe4z5bD5lO1a0Ucj2SKWu2A9Vb3zyz3kHoTpk6xW7FlDROiUaqG3sHepl7I96mtGpGVYd1
 cMbXzknQv203jOKRIhvet1SEG11uLMa9Q8Cajeiwg3LlP0OH6ZzAVYSYrG1rIm7hLzhb/hTfe68
 NncSg01/u0NbBZ1RTM6XxyljxHmIPTf93vdvwxFKUAjnNvCR8irvjfQg=
X-Received: by 2002:a05:6512:3a87:b0:5bc:b962:ccb2 with SMTP id
 2adb3069b0e04-5bcd074b8f1mr1283369e87.63.1791405385817; Wed, 07 Oct 2026
 13:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261006091716.487384-1-elena.popa@nxp.com>
 <20261006091716.487384-2-elena.popa@nxp.com>
In-Reply-To: <20261006091716.487384-2-elena.popa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Oct 2026 17:36:11 -0300
X-Gm-Features: AclHuK9XrMfGiQctKc0EaJfJEEQC-2VOex4HZgDabboltfdG4Uue92iNwBMdAAw
Message-ID: <CAOMZO5D_qC04huMKjJHNzYxio7mtgZuaseOBKdCQg_DdNB9eyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: nxp: add MR-NAVQ95 board support
To: Elena Popa <elena.popa@nxp.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, sbabic@nabladev.com,
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com, 
 ilias.apalodimas@linaro.org, laurentiu.mihalcea@nxp.com, 
 cosmin.stoica@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Elena,

On Tue, Oct 6, 2026 at 6:17=E2=80=AFAM Elena Popa <elena.popa@nxp.com> wrot=
e:

> Add initial support for the MR-NAVQ95 board. The following peripherals
> are supported: Messaging unit for EdgeLock Secure Enclave, messaging
> unit for System Manager, uSDHC for SD Card, GPIO, LPUART.

Please make the DTS patch the first one of the series to avoid breaking bis=
ect.

> --- /dev/null
> +++ b/doc/board/nxp/imx95_navq.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imx95_navq
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The underline is too long. Please make it match the title length.

Please check globally.

> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ mkdir ~/toolchain
> +   $ wget -P ~/toolchain https://gitlab.arm.com/api/v4/projects/tooling%=
2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.3.rel1/arm-gnu-t=
oolchain-15.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf ~/toolchain/arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-eab=
i.tar.xz -C ~/toolchain
> +   $ export TOOLS=3D~/toolchain
> +   $ git clone -b robotics-0.7.0 https://github.com/NXP-Robotics/robotic=
s-sm.git
> +   $ cd robotics-sm
> +   $ make config=3Dmx95navq cfg
> +   $ make -j$(nproc) TC_VERSION=3D1.5.3.rel1 config=3Dmx95navq all

Typo here: it is 15.3.rel1.
