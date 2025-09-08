Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B45CA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF73E82C84;
	Mon,  8 Sep 2025 18:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lun+wqbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B8F83045; Mon,  8 Sep 2025 18:44:10 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9559809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1DEFA1A0E26;
 Mon,  8 Sep 2025 16:44:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9E9A6061A;
 Mon,  8 Sep 2025 16:44:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BBCBC102F2968; 
 Mon,  8 Sep 2025 18:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757349846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aquzqg8rUorc8l3oRTF1a8uA/sjMgfbBMos/WkjEUSU=;
 b=lun+wqbeeGG7VIaGY0WVpul5uwSB1opuI+ZXoxyD9EOVjkQpSTDuXDxzwBlzgq2fu+8+S3
 bL42f6OQ05aKOSSESxkUUa1+lxkjeBVJcG0CIytVF+NOHdOG2BKnb4n0YuywtLY0YSLp5K
 UJEvcK0sBjYnhiA3/DrZwFLqD0/FvW+Dq+fUPC26yONbwMv0/MQ9vjWfD6ychfUaLMXBtJ
 mQw+lktHZvWfqW5Die9Oh3zH9ZB4XcTSfaVOs6jEMyR8ot77TOG5a57PV5a95cYlr10loT
 l5OTctnyL4ydlfgOASqZopxWkUzoDecCHyBO0yKQQ0GVwEmjJ3sWDYt9N37hbA==
Date: Mon, 8 Sep 2025 18:43:42 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250908184342.7ec9500b@kmaincent-XPS-13-7390>
In-Reply-To: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
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

On Mon, 8 Sep 2025 16:05:04 +0000
Maarten Brock <Maarten.Brock@sttls.nl> wrote:

> When PMIC drivers are disabled their functions should not be called.
>
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>

There is already board check with board_is_bone or board_is_beaglebonex cal=
l.
Is it not sufficient? Why would we disable the PMIC support if we are using
one of these boards?

Maybe the only relevant return would be in scale_vcores_generic, as it matc=
hes
the case where the board is not known.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
