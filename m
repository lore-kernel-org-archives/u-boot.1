Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A27DD0E6E5
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43B08404D;
	Tue, 25 Nov 2025 15:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZEF/P5rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4980384073; Tue, 25 Nov 2025 15:09:36 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B9283FD6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 123141A1D34
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:09:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB47F606A1;
 Tue, 25 Nov 2025 14:09:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74342102F081B; Tue, 25 Nov 2025 15:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764079772; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dtn2bng9NaeThS4yCq/S3Hg4fK+lmZ5DEI1ZZVwpdlQ=;
 b=ZEF/P5rnoGcVO0QYo8rJzi5isx7N1Op0VZUI090GvWNmhYHruOus/RcL+P9mD+ata+Vq+u
 cJsVUVBEikmyF14uVK23UhhZQ9qvr/PibQt4Ie5jvo/Itxwvt4v5nkksJwauADWRdwcbC+
 zW7tXcfMSzgvSIr7nP7Bw56LZu0xynqqc17pGVnjQxjhQ6sxgYiCI6EYsfPRlGoi1Rizc5
 aPkMnB1sqCj9iLoQMCLDPBkgifoztCEoK105ilq95MhtCZSCJZJsEq8IogZFWyVom3VKX6
 FEHAMPIQg4Ik5y5eImBPkjyBaZ+E7e0E0GGZcSGMPZwzDLlqy8BAV1ILdGuOUg==
Date: Tue, 25 Nov 2025 15:09:30 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] board: ti: am335x: Fix DM_TPS65910 condition
Message-ID: <20251125150930.7e3c518e@kmaincent-XPS-13-7390>
In-Reply-To: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 25 Nov 2025 13:55:24 +0000
Maarten Brock <Maarten.Brock@sttls.nl> wrote:

> scale_vcores_generic() calls functions implemented in
> tps65910.c, not tps65910_dm.c. Change guard from CONFIG_DM_PMIC_TPS65910 =
to
> CONFIG_SPL_POWER_TPS65910.
>=20
> Fixes: 0b9ff0851592 ("board: ti: am335x: Do not call disabled PMIC functi=
ons")
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
