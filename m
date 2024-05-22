Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3260C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FCB87E0B;
	Wed, 22 May 2024 10:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="A9IKeLb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF99387FDD; Wed, 22 May 2024 10:04:41 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FA387E0B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B26DC1BF20B;
 Wed, 22 May 2024 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716365079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0izYuSn/yVGz7ZsBNukZQ5bST+LPh1eMv5GDoojlOqE=;
 b=A9IKeLb6k+HNahV8WZ31yz9sNksRnrohz4QaefDziqrDQnFGYAVh42RY+TC77BNWJ5pnJH
 SL6VlMoC7nOGxVs2xz9RVvZnzOJGmnbxrwUVD7G0aCrvrgIOIeoVpPI77fmI+JXM/CucG5
 Lg6kiolnCzSQGeZrWMdTaHNs1azwxYOVp1WwFc7mWs/5R4FQjA7oK39vigWQnoVluiMWM8
 hLDIZoV9ANQiFTXV2/PZaNdwx0pGznBfB+y7unC3WFS1OcP9/OvQfSuMolK173d8ff3sxM
 2qFZR0sse2eiTf33axHBcclUv1uq473bv0nYR+YL5M+KuFnQVq39eTNZcCuF3g==
Date: Wed, 22 May 2024 10:04:36 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>
Subject: Re: [PATCH] include: extension_board: Increase overlay file name size
Message-ID: <20240522100436.707dd4f2@kmaincent-XPS-13-7390>
In-Reply-To: <20240522072100.602612-1-d.schultz@phytec.de>
References: <20240522072100.602612-1-d.schultz@phytec.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
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

On Wed, 22 May 2024 00:21:00 -0700
Daniel Schultz <d.schultz@phytec.de> wrote:

> Upstream overlays like the ARM64 TI
> k3-am625-beagleplay-csi2-tevi-ov5640.dtso can easily have more then
> 32 characters. Increase the overlay length to 64 characters to
> apply overlays with longer names.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
