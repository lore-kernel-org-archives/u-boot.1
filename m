Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EFDCCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 23:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C934383A5E;
	Wed,  8 Oct 2025 01:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="coZzHSte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADAB8397A; Tue,  7 Oct 2025 21:35:02 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A32F838E7
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.petazzoni@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2C7F44E40F5C;
 Tue,  7 Oct 2025 19:34:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F3F0D606C8;
 Tue,  7 Oct 2025 19:34:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C3E4C102F217C; 
 Tue,  7 Oct 2025 21:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759865698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fR4r9Dbdw3CcRnMYdSEPn87qZUbhU8sOgS0FW3nujeM=;
 b=coZzHStesyEoCA/lXEFukupNegRjEMQH3x2M5X0LLJtFiNUAghGHF3+rBHk49tYU2P+9Vb
 jKbUAZxXFne6ot2i0qMlsWA5zW1Zrn95dTDKmzRq/KancqnPjLq/6lYVZ3BUqn601G+hjt
 QiKEh/QmAo0FnKW8xZGn362pmPwMKM8wWbWfxv6Wpblsg4jep9tnIsagWSpP8lxK4qLeAT
 8X9ouqOmybWdAEHyZfMP3VqIlLU+OampzN02uBJuD89ZP3Ggsk7fE79SNcYpeBaV1wq4Gw
 GSWaEnZJbY/pqByUvAGCtu9ijFrW2hALrP76BT/XdjybJaka3uKhQnK3Qm7iyw==
Date: Tue, 7 Oct 2025 21:34:47 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jagan
 Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>, Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth
 <praneeth@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/16] board: ti: Convert cape detection to use UCLASS
 framework
Message-ID: <20251007213447.4d3c5a1a@windsurf>
In-Reply-To: <20251007182938.368bf435@kmaincent-XPS-13-7390>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-6-458b8bf85325@bootlin.com>
 <CAFLszTj3j6bcm6PG1GLAHa6FfjpKOKL12P_ae4WZsJL4hbh-HA@mail.gmail.com>
 <20251006214428.GD298503@bill-the-cat>
 <CAFLszTgLd7gHoU04QKAgHWNFQz_CS_XfeJCBkn58fu3UxUyurQ@mail.gmail.com>
 <20251006234240.GF298503@bill-the-cat>
 <20251007113213.75efa663@kmaincent-XPS-13-7390>
 <20251007141148.GJ298503@bill-the-cat>
 <20251007182938.368bf435@kmaincent-XPS-13-7390>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 08 Oct 2025 01:50:35 +0200
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

Hello,

Sorry for jumping in the middle of the thread, but I only have a small
comment.

On Tue, 7 Oct 2025 18:29:38 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> I think, he means a driver for each type of custom extension board scan
> functions (4 until now). The U-boot devicetree would be like this:
> extension_scan {
> 	compatible = "bone-cape-scan"; 
> };

I'm far from being a DT binding maintainer, but I highly doubt this
would be accepted by a DT binding maintainer as this doesn't describe
HW at all.

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
