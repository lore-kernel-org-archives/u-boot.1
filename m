Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C393CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 15:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B99A683855;
	Fri, 15 Aug 2025 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfZjbxyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E21C83865; Fri, 15 Aug 2025 17:04:33 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E2983845
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 17:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-74381fbd6f3so582235a34.2
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755270270; x=1755875070; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jBszfFSeDxxTTF502X3DZmSkXnxPwhqmFIyy8iU+eUw=;
 b=kfZjbxyLK2QKkVpPa8K61Uv/Pt4Ewgf7Acg0KmrJpo3jTa3g9gx00SzYLlBNBKx9ll
 D7b6UiE3ZuspjTEQ29giLrlxpxgnCTLcYlYYj5otBYe1ylc/qnUy30M9rl0ZRD65Q6xI
 CIYSHjInfY/zP2RQ2S7E+1lEm0E7qr8llVMO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755270270; x=1755875070;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBszfFSeDxxTTF502X3DZmSkXnxPwhqmFIyy8iU+eUw=;
 b=MQqLffa2yYsOdKyV0GICW0U4pluQy5gm+FmE+GQsJUzacOWlRrIryyS+iJgd+A4Bpq
 gw3ETT1dFrZuaW4jAyW+0f8N1VlzC8WgQ0zKzn8io7sHNTAPHq8lAXCOErZGn4KvA5ES
 kciDhPQTDhQIj94N3bC31fT+te2Ou0kSBzH9aWFyvu9zqUHgw3VFy8a6kncL5l/MUbua
 2QT16B2kYzZ3YEEqLBogWrwRFpSOiQErDa5RGqg3UkPIUXzTA0H82nrZHIe0nHv91xI8
 Wg/Tgd9I75nHKCeiXnHnrkyFLZ/QGAkNKnPwkjq8qL3FnviQBPbWjstjmiZ2hh7U+W1L
 m84A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy8A7oBfWTTyH1MMCt14D2EM20ZiGMQtRBtb1M8pqxcASyK3TpVWvRNPihGIPGbacVSxSNKjU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn1RY/gbW9/ayFj3J7SXeWyhHgFiQwOKbPkx/s/fkV6GSFXWPM
 t3s1BDOe1zy9Td1RoK6StXPQMb7TzY5MaDvdyWGqBwfFZZECCIPvpURVtjt0mueW9MA=
X-Gm-Gg: ASbGncvVZcZ4uiLcDpt47T7uybnDIpH9ODOaL23+MldZSwtN4CJzsFDZO6LHKkCyNju
 +yq6uYyx5iQ6kdk9sDXpO+Ctyc4Z4tvJIRw3AqcwlP4GXxpJdEHh/lt15P+B9KFU9UDD+LkeQ/L
 kI9nwCXxdnevMhXXW6DPso1E9VxuG1ciyBD22hnfeKHaC8wp55aM0HpWVHe7NOlpO3lDUxJ50iR
 pn0aTndXm+YG3XUfpz11T5K1FFt01nqmS8FJY6shJ/JGr3hsSyUZJ/ijI+9d4RY1vOnzC7Sd0rU
 //WO2i+CDjt0LVMlKn+QZw8uuw+3ekN0JzVed2mr5VBRP3UlFxf3Aw4H068OCJ5oW2ng0R4glpg
 74kVliPprQF7qjDIetB76ObHwvucjQ4rb+6h6oS5gzU6n4K7/I6iZ5JpP
X-Google-Smtp-Source: AGHT+IFcXRsRP0MuajnVGC8vEYKigCTlR/ovOzhJipyRWQWW8C2j52yeHzYLTkrYi8jNgWlvGdTFug==
X-Received: by 2002:a05:6830:4996:b0:741:b263:4ded with SMTP id
 46e09a7af769-743924da068mr1599344a34.15.1755270269644; 
 Fri, 15 Aug 2025 08:04:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439203b5ffsm328048a34.25.2025.08.15.08.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 08:04:28 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:04:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Fabio Estevam <festevam@gmail.com>, tuomas.tynkkynen@iki.fi,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl
Subject: Re: [PATCH 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
Message-ID: <20250815150426.GQ124814@bill-the-cat>
References: <20250814165932.1584854-1-festevam@gmail.com>
 <20250814165932.1584854-2-festevam@gmail.com>
 <20250814175041.GN124814@bill-the-cat>
 <e47448fb-feb7-4ca9-8d81-e29f77d81d82@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LYfHMuhoeO16JoP/"
Content-Disposition: inline
In-Reply-To: <e47448fb-feb7-4ca9-8d81-e29f77d81d82@siemens.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--LYfHMuhoeO16JoP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:51:44AM +0200, Jan Kiszka wrote:
> On 14.08.25 19:50, Tom Rini wrote:
> > On Thu, Aug 14, 2025 at 01:59:32PM -0300, Fabio Estevam wrote:
> >=20
> >> Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
> >> work.
> >>
> >> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> >> ---
> >>  configs/qemu_arm_defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> >> index d5890bf87fb3..db60f7de6da9 100644
> >> --- a/configs/qemu_arm_defconfig
> >> +++ b/configs/qemu_arm_defconfig
> >> @@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=3Dy
> >>  # CONFIG_DISPLAY_CPUINFO is not set
> >>  # CONFIG_DISPLAY_BOARDINFO is not set
> >>  # CONFIG_BOARD_INIT is not set
> >> +CONFIG_SYS_EARLY_PCI_INIT=3Dy
> >>  CONFIG_PCI_INIT_R=3Dy
> >>  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
> >>  CONFIG_CMD_NVEDIT_EFI=3Dy
> >=20
> > I thought Jan was doing this on arm64? But we should probably imply it
> > under BOARD_SPECIFIC_OPTIONS in board/emulation/qemu-arm/Kconfig.
> >=20
>=20
> I'm currently doing that for qemu-arm64, but qemu-arm will be just the
> same and is planned as well. Actually, riscv64 should work as well.

This stanza will catch both qemu-arm options. We don't have a good
common file for all QEMU so when you've got RISC-V going it'll have to
go in that Kconfig file.

--=20
Tom

--LYfHMuhoeO16JoP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ9MdwAKCRAr4qD1Cr/k
CtmNAQDeB0hyWbPf0zJdwzhptA8exjaddJkWigyz7gFjFy+QQAEAhDHQKCb9bn5k
Mk/JG2j6mcH2hpe8/Z/LnlmD6wDFwg8=
=qn7v
-----END PGP SIGNATURE-----

--LYfHMuhoeO16JoP/--
