Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2353C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280EB88306;
	Mon, 27 May 2024 14:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ORmjgz2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3885588315; Mon, 27 May 2024 14:08:26 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1558987EDC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6220E2000A;
 Mon, 27 May 2024 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716811703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abs/lMvca7ZTVRlXt1rw8xnREo33kf2l0xfDwI8RdGo=;
 b=ORmjgz2HAHPpuoEyf7TgVcsDK7/UNpouv762lgdvw25dUkLDi06iw7BxqiYaHh/F25CX8g
 IyTkJHKbDLXH5Xl/geAb1mBmn89HQ5R8JdK/rPAiPgTAlbfWtVQ8a1+bl/3B0RDe2lXRai
 CtzVKo/4SO516mNV4nKH6S9bh23QSzjgkkUBbLG4p1rMNpCR7/ir3noPlWTtlnAP3vTkUi
 M+WUhM9a8YJKNhcT8cSXDZUuBvwYe0Oyrxwry9Yj6+8/Yelc36JE6ObADcXd/fRRTT+dvc
 18kpt/+G6S5FCsOyA8DXgz5+CKQ2Q8i6JKxV04Cf8MEfW1fmOFo8MITh9XGE9w==
Date: Mon, 27 May 2024 14:08:22 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com
Subject: Re: Pull request for tpm-master-27052024
Message-ID: <20240527140822.5df66c3a@xps-13>
In-Reply-To: <CAC_iWjJo+2wQBw5+a3PJRf6X4X2akTuW_EuC+0_A_NsSmoMzVA@mail.gmail.com>
References: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
 <CAC_iWjJo+2wQBw5+a3PJRf6X4X2akTuW_EuC+0_A_NsSmoMzVA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Hi Ilias,

ilias.apalodimas@linaro.org wrote on Mon, 27 May 2024 15:01:10 +0300:

> Hi Tom,
>=20
> Don't pull this please. Miquel added his r-b tags in the meantime,
> I'll queue up a new one

It's okay, I thought you just merged the patches in your tree, but if
you already sent the PR to Tom it's okay. I'm fine with Tom pulling
this version of the PR.

Cheers,
Miqu=C3=A8l
