Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F7DC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E81871C3;
	Wed, 20 Dec 2023 08:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="O+Cvo459";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5821D874BB; Wed, 20 Dec 2023 08:17:22 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF5E8700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9D5CE0002;
 Wed, 20 Dec 2023 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1703056639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBi+8NL7aE/XRZED3MqrIc3p9l2z2kSeWHJGCwCuiVU=;
 b=O+Cvo4591OIgVVq6asdrH1hS+zDMLhGXgs8JiEiI+QlBo98Rt8fCd8S7GN1yPJ0VcRdLwl
 3v6KfKW+HKekpuGvj5BQwcK/ziuf/22EMCZR6+kxNRODklgpAPWvePigutFecov13JmxKt
 GIEld6cfo0cokWr4WVsNWqPD4LQUisg0qLCgaFoPRsyeKTmKV7yfvTA3+fh4QGQm6HCvEt
 be1geQbgJzIU3rKhwYtSZtM1NIDwM8m74BraPimkr7ime7QvmUpdUnRvevL0S2PMBT/nG4
 Vo0VVUfL8eqRCLyeUFMaXAT4EikQ9IumiBibwslHrjpYD7eBpMS/TJF+NKdd4g==
Date: Wed, 20 Dec 2023 08:17:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem helpers
Message-ID: <20231220081717.0afc17f3@xps-13>
In-Reply-To: <1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-3-zajec5@gmail.com>
 <2023121929-salami-pessimist-c943@gregkh>
 <1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 19:16:37 +0100:

> On 19.12.2023 19:13, Greg Kroah-Hartman wrote:
> > On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote=
: =20
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver le=
ss
> >>     mtd dependent
> >> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells =20
> >=20
> > Shouldn't this be 2 different patches? =20
>=20
> I used to maintainers complaining my patches are too small and not the
> other way ;) I think it happened two or three times with mtd subsys.

A single patch may be too small if it's alone and we don't see the big
picture, otherwise I have no issue with small patches, do I? Anyway, in
this case I don't mind the patch being split or kept like this, just
keep my R-by applied to both if you do indeed split.

Thanks,
Miqu=C3=A8l
