Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B031ED0C61D
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323A388A4C;
	Fri, 25 Oct 2024 16:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emY0UZj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537868902A; Fri, 25 Oct 2024 16:49:28 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719988870D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so22837161fa.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867761; x=1730472561; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYnajsWZNNg6BW3th3lt33F7HnBt2xEmxq9LSUBNNBs=;
 b=emY0UZj34/WRI/WU3PUXjJo6oloUuAb64XbF1TTDv5bvc98HaggaPTeGsNUM/hHxtz
 uR99KKwUGi6SWPUIOad2EMZJLlTEiivg9ZzwemfR03t6m2dfHsy4AMf83fRdUa1+/Swl
 SiK0CxogI06Sww3oVdaQXbxMm3RKNuNhYG1uDVQUbZuEZ5SZNDEB+QS4Env8H9xJboMC
 71fWkuIX/6IY/r6MrG2R/ZZm+M8SjhlCT/dJmJpw//sv/Szjshz3A+i9vnJ8A9TiB8xV
 F6G64OvSCAaH9/DYPeM/HLgyLa/JTNLRJGkl58AtbwimA7pH3sRXIKY0hwvvII//zWmS
 1cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867761; x=1730472561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYnajsWZNNg6BW3th3lt33F7HnBt2xEmxq9LSUBNNBs=;
 b=PHgSA3TVfU8xTQDEXomZUHDVlG+mAZq6qvniOBRBl5AWFTO81Zl3O/pIaU1jqBf55g
 2hD0cNV+tDmTsPyWt67DaF3tMr4mnZJdfaZKxTH8yWxGlKbwv0JS6d//9f4f/hHTFajM
 zbJGB/LXVVSko0ca5LomDUxUdKeqImHZ2MXkGIVPJpYotGiXLw93GF4ue1KTrC/Xbwec
 VlcNeg1cpIXyZkkrVs4VhqgS2B2DPGXktJ3RoFcUgqHxEqL+vnx8bcrCOoJLpo6FavhO
 VlHdb4Ofdr+/p4iG46nSACsCuuObCpc35iovksRoshvRdXCwimclzVKuzU6yplN5S8W9
 wA9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsVrBKFl4LIPsjvZG068p9sgKyirHNDiKuA5oBCodHul6qbKeaTfzlus0G03ffWjY8JEj50q4=@lists.denx.de
X-Gm-Message-State: AOJu0YzySGy0MS60Kei0rmsw9X1T7dkD/7tNjWeYZpBC76Qd0QCWRVG2
 aT8tIbK3BkpURPBIEQxVYrUq3LnZJo+gXFMpAaA45WwvaqofWsyp5OjyE4M1V/jRGJjCmd7dYgq
 yn4s7GL3j2TYNcjk9/kFjpBT8re1R5w==
X-Google-Smtp-Source: AGHT+IEnPJ1SRbIbgRzoYMuVn6HkRU6pRIzFBaACJHrKJZ+77O8O9hOkoipkgIq2wTvt45P4iPLjGSldvKCCeh0AzUs=
X-Received: by 2002:a2e:b8cb:0:b0:2fb:3445:a4af with SMTP id
 38308e7fff4ca-2fc9d31133cmr58008781fa.21.1729867760400; Fri, 25 Oct 2024
 07:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241023115350.8413-1-hiagofranco@gmail.com>
In-Reply-To: <20241023115350.8413-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:49:09 -0300
Message-ID: <CAOMZO5A17cnb+sSh687xHJw2kFkWz2Sn_LUN8Zt=mfKhho8_Ag@mail.gmail.com>
Subject: Re: [PATCH] verdin-imx8m{m|p}: defconfig: update fastboot buffer
 size/address
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
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

On Wed, Oct 23, 2024 at 8:54=E2=80=AFAM Hiago De Franco <hiagofranco@gmail.=
com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> Remove FASTBOOT_BUF_SIZE from verdin-imx8mm_defconfig and
> verdin-imx8mp_defconfig to use the default value of 0x7000000, aligning
> with other Toradex boards.
>
> Update FASTBOOT_BUF_ADDR to 0x44200000, consistent with the value in
> previous downstream NXP U-Boot releases. This will make fastboot
> applications continue working with upstream U-Boot by using the same
> address.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Applied, thanks.
