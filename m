Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42175C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BE886EF1;
	Tue, 12 Dec 2023 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fgjBGs4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89FE87825; Tue, 12 Dec 2023 17:13:23 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2D0804CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-286f3e0d010so1664402a91.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397600; x=1703002400; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GeUXj6cWVdcnnPjNpbPQyDg3JqiY15kIJ9fqCIZ9CA=;
 b=fgjBGs4IJiUf8CHIcbpyQuWLboEQrPOfqZtrAR4HJkyichQeAUK/eyR1Gg1ZJi0L13
 EcrdwM5cz6ih2M8OVIggIntMPuxwFEOPgjDkBTxhhLl1SHPP2cj7cS6z7NFAkG8ewGig
 UTMTchvig9oe+Orkk5BS08E2yAcNKma5huP0F2AADWAYjBwdXrQT6/lne8ObGkmaVSaH
 Dcgm9uXAhI6gR9AuF4zNQR6bIUWSs+LJfXh3d7GYb4qeejWHMQMzTVIE92ews4YQ47jz
 7V66Vu1ebftlMr1hWCWOUoVwlU3ToCABVCqTwLJ99r3NGdjEIqpwRQ+5pKOkG7e2E2Zp
 937w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397600; x=1703002400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GeUXj6cWVdcnnPjNpbPQyDg3JqiY15kIJ9fqCIZ9CA=;
 b=g5C0E3OvaJ8aeIr4EMpIn4JZraeqKoTQoLuItqE0gBvuml2gPDfKzX3qNcIIamjxfg
 xs9tlfkvyqbZOyMW1zqZu5TFcT76B8pg2Ei8QwXE/TUruQY9EVQDdtspgBQMZlDD/Stv
 pxl4g9qpsAoAvkNyuLAr/B2EVJuy5Fovwyeqhg13Wh1CBV0gEfc7p4T2W2V65D0wZGIc
 lQQ/J/4YAcca9awO1cuNnq2VpvFHfNbN1vB9jxoKmoAnkxTDEHemnJOO488igvOKkUCX
 5qg1kaLhkvKQ14KgcRydHvPHSUZ7tGU5ROwWDQFiBodKj2a8Lrz6qHsbokBOpHYciMmr
 cInw==
X-Gm-Message-State: AOJu0YyCiIJEPGBXtmTm1mYNOXsCinfOogwUgkg98m4Gfjpvg8O/7CrP
 0oVRH8ohWLhl1Aja/HwS0LVXnQDh4phapWnHDAs=
X-Google-Smtp-Source: AGHT+IGpYz6zD+4pXPz6KdSeojMcuwjz/neIlNaz23GhSsPfr1bNdEQIyj2tuYLABYNL72p6c9fW2yTgXtRMAZQgimA=
X-Received: by 2002:a17:90a:7e8b:b0:286:8fa5:7bc7 with SMTP id
 j11-20020a17090a7e8b00b002868fa57bc7mr11237258pjl.2.1702397599714; Tue, 12
 Dec 2023 08:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20231017205816.318531-1-hugo@hugovil.com>
In-Reply-To: <20231017205816.318531-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:13:07 -0300
Message-ID: <CAOMZO5Cos_jdh+uDWiV+zw2ACAL9NoW9ver_QSw945RKvjcW5A@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mn-var-som: Fix broken EEPROM read
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Tue, Oct 17, 2023 at 5:58=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> On branch WIP/17Oct2023, the EEPROM can no longer be read:
>
>     U-Boot 2023.10-latest (Oct 17 2023 - 15:53:43 -0400)
>     CPU:   Freescale i.MX8MNano Quad rev1.0 at 1200 MHz
>     Reset cause: POR
>     Model: Variscite VAR-SOM-MX8MN Symphony evaluation board
>     var_read_som_eeprom: uclass_get_device_by_of_offset() failed: -19
>     initcall failed at call 000000004022207c (err=3D-19)
>
> Convert EEPROM-related properties to bootph-all so that the EEPROM can
> also be read outside of SPL.
>
> Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-re=
loc after relocation")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks.
