Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE33D74EC2
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 13:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7057383B21;
	Fri, 23 Jan 2026 14:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQdLOe4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFCA83B27; Fri, 23 Jan 2026 14:08:59 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C7D83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 14:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-59dcd9b89ecso2704051e87.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 05:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769173736; cv=none;
 d=google.com; s=arc-20240605;
 b=lRfmXui08gg02zXIMSECGc4deUGBCsUXDTzB+iNx7k0szQweY1VioqjfmT1WB/eNks
 FyRvhaZ/Du5avMAFxMMKBDmyEaptKY5Mdni+J4fOXSNtF+AV9r8+6Wm0zbVIKE3FMp8h
 3KZeB5f2K1LMeuzAv4WNSLD5gjzqKljdZoHt4osCJ71g3t315/c9UDrty87HbQLJra7v
 iWlh1UzPYnJHfoplhiOKGEmFPOiXUqlV9nFKL5nBI/g7A3KBvi0KdfUN400GvTxoXQQd
 nrw3pMUuJnOcF3IOxNRUBgMWWOA8728XfQbBhtgkAP67LtoQy14wF5Gd6E5GB4ltpUFt
 9g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ujrOV/FsBipR7MEoDwahDiPbT1VSvkgvpwsQscDJ43U=;
 fh=jEHQ9YrjInL0slv9QHP0Tn9W7qgvCDAVcthgvL4rGy0=;
 b=S9h/DXuCzA3Tj83S0ui+ZUCzPQLSFwvg6M++MqIRsHXNC1sJjHGIEDaehoHY7tvdzt
 72G0oXJHAfslqyPISFa/0+Y7T9nqSMnczrxhesOMYYHu2x8BHQM8GA0Dvk6/sAqPkIiQ
 utmYe3nP2iYEHRed1At9KI45EsRCfnHo84t6N3etlty7EYgu6+37QCUCC5TSSUTXKDJS
 IXk3HeJBvnEbMrY/Ls950fzi3XqIfBo7WHCOjqtZ/SlQrbPJYG97R8MlPTUXLEVouJsh
 7rzhDKJsS0R5Dk4Yk7nRvzI4It3uNd7+cWl5q0ZU44oed3QlcdmQ+Z7BDNlDHsR3giiz
 VCmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769173736; x=1769778536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujrOV/FsBipR7MEoDwahDiPbT1VSvkgvpwsQscDJ43U=;
 b=cQdLOe4dmQ21ytbAUKGyGx50+tw+IJoc8SGoigLx9H2z8wHg0L1MvvLoD722DhK5tl
 c48FX0TuajSlUikpZaqiwT5fUCWjni16efxnCRiQB9Ph1cxefRNzGRq9VFTigV4cHubv
 lE6jBradFRxC6NsgBDHLRSP94lsdPQugFmC+2lPRGWTqhxqH4p+AnnEkPFjvF/VnKy8X
 e954Qm35qX9qglQAJhYUHTnP/TEU/RStb69RSHWdLRhTSXcbbCK2V70nrqrSNesN2x0V
 eQ9+6NYynSyuWbQoV7TJBBRy6eLSU3kA9pCOKKlHDsNxaC5+A5VhicWaZ/pkQb7OxPyO
 bseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769173736; x=1769778536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujrOV/FsBipR7MEoDwahDiPbT1VSvkgvpwsQscDJ43U=;
 b=FToJEW3KoKmAW8JoQNtZHpCKbUPzSmcHIghpcoPlDSjCVnSz6+fnDy0mKB9JuQiP3d
 jWqHmiTSyhqczhpV7rQMh6nu1D2hSOFg1CQB4yLBU69yiv1otuSK9wYSynukZjBj6UG1
 lCTSToxmB/X3oB6JWY0cCix7M8hLzi+nLsBaLiL4SJxkTR3Eg6uL23XowWGJXS4PCDbu
 WwKA3cD9sTndo8yMg1lG8TXhqG5lxlJLw3gVqy3n+isF1OzuBln7oT53VKpNhxmxwKBy
 z+W62QnIIYUJ5s7mi6r9ARnauX7oN9s0xXxZkmwVi/YkwORlj7qVz6ioMexUDYxMUQHm
 otTQ==
X-Gm-Message-State: AOJu0YzclvBFdBuc+kv2InaWMi5B1Cxgu4BYOL63S/SgUnWBBWF9DOcT
 9aRvjop6hXCgiDuVRLy4TgYOIzP8yLm70sVf074mS4yjlQroAZHGtUDDsiYWyt6jDBKyvxeRDS0
 QauKfjLHwkCPcnPAEq4wGjbcSGzlNYhI=
X-Gm-Gg: AZuq6aJcWwZCCdJBRVK1Xzy/FNPKqJI2AJOSYYRL4CJPGskadQRqcMqMsL+fnLC/Xsy
 IFLqjUe+bwvSZebnPdzvUyDeujnu1iW0cT6f8Rc2OOlveyvJV3pKw1OYipNr6l6r/FRkoGpnmA7
 KtZeoff8XCZgAg002FhQ/KmrLEOcuUUV2y3KLFWJX5LUJZkKCPiVyGPrLXEsA6GCwS+ELK3yz3v
 u1SPKbd5FA652fzlw9Wzw75zvrYjqE2fl3c6hOnAn8IqfrcQh7nVSVHyh1zFQCsWopJLOr6+Zt4
 Cco5yY/7qDAQAbd9l1FF0dJhTgqIo5s3k9cJ
X-Received: by 2002:a05:6512:118d:b0:59b:b478:f160 with SMTP id
 2adb3069b0e04-59dd7d14b5emr2321683e87.14.1769173735582; Fri, 23 Jan 2026
 05:08:55 -0800 (PST)
MIME-Version: 1.0
References: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
In-Reply-To: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Jan 2026 10:08:44 -0300
X-Gm-Features: AZwV_QiRBB-5RhzEopxO0wz2WGGABUq5rBpL-Nz_yqnHS9LTfMZzf-yhmTUfjzY
Message-ID: <CAOMZO5CPMsWDR-yKVyfx+1+iCGkVxh3wh_zpVV7njoDMYg-7_Q@mail.gmail.com>
Subject: Re: Toradex Verdin AM62 boot failure on recent master
To: Vitor Soares <ivitro@gmail.com>
Cc: u-boot@lists.denx.de, vitor.soares@toradex.com, trini@konsulko.com, 
 n-francis@ti.com, b-padhi@ti.com, afd@ti.com, anshuld@ti.com
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

Hi Vitor,

On Fri, Jan 23, 2026 at 1:54=E2=80=AFAM Vitor Soares <ivitro@gmail.com> wro=
te:
>
>
> Hi,
>
> I'm experiencing a boot failure on Toradex Verdin AM62 with the latest ma=
ster.
> The last known good commit is a4dc1c3b7d56 and it fails to boot at 64662b=
99c0eb
> (current HEAD).
>
> Looking at the 35 commits in this range, I noticed that the first commit =
after
> my last known good is 85f586035d75 ("ARM: OMAP2+: Pad SPL binary to 8-byt=
e
> alignment before DTB"), which directly modifies the K3/AM62 SPL linker sc=
ript.
>
> Related commits:
>   85f586035d75 ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB
>   8b0ebe054bb3 arm: Update linker scripts to ensure appended device tree =
is
> aligned
>
> Could these changes be related to the boot failure? Any insights would
> be appreciated.

Does reverting 8b0ebe054bb3 ("arm: Update linker scripts to ensure
appended device tree is aligned") make the board boot again?

I noticed that this commit broke the boot of a Rockchip board:

https://lore.kernel.org/u-boot/CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg=
06WtqEg@mail.gmail.com/

In the failing boot case, do you get any SPL message at all?
