Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC9CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC11D8702C;
	Wed, 18 Oct 2023 20:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653090;
	bh=0BLY7vNsb2AeiROaxjoNAhqQDkcyCcio4XtRPlq/dVA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xi9ubkBgb0zI4n+gvQeSD3PVVg2t7VeLWIfBZ27R8ZXhxke6U9f0SaLrIP+ootjud
	 8lNOASOfo/Y0aBxRC9blsQ6EOVnb8O6uqUKxiMinz5rg9ydDTeA5Rys6/S2MEnzDet
	 x3rPOwmgCHT/pMxtrhHIq3kjULz+UscD3JXkKvrYUklbT8acmth/hhYVLHXydS7Ami
	 d+TmGYE5Kee6YP1V9Lsncf0Hvz76taNBFlP7MjJU80rXcRUUr8wXeVtjiZoJRf1pvC
	 FWPOh0h210L7jgWFpwNiLlNnKEpXOr4o26kgOc42RTr1RG9b4Qb34TpAZQKQs7GkXX
	 PsGq5qHTHUp2Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE5E8702D; Wed, 18 Oct 2023 20:18:05 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8216087024
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGg14H6z1r1s0;
 Wed, 18 Oct 2023 20:18:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGg0FYBz1qqlS;
 Wed, 18 Oct 2023 20:18:03 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id RT-ekqWZauan; Wed, 18 Oct 2023 20:18:02 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:18:02 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: =?utf-8?q?S=C3=A9bastien?= Szymanski
X-Patchwork-Id: 1843179
X-Patchwork-Delegate: sbabic@denx.de
To: =?utf-8?q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] dm: adc: imx93-adc depends on ADC (fix boot)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <20231018181805.9AE5E8702D@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:18:03 +0200 (CEST)
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

> The i.MX93 11x11 EVK fails to boot with following error:
>  Model: NXP i.MX93 11X11 EVK board
>  DRAM:  2 GiB
>  Error binding driver 'imx93-adc': -96
>  Some drivers failed to bind
>  Error binding driver 'simple_bus': -96
>  Some drivers failed to bind
>  Error binding driver 'simple_bus': -96
>  Some drivers failed to bind
>  initcall sequence 00000000fffb8f28 failed at call 000000008021e0d4 (err=3D=
-96)
>  ### ERROR ### Please RESET the board ###
> That's because since commit e7ff54d96303 ("imx93_evk: defconfig: add adc
> support") CONFIG_ADC_IMX93 is enabled but CONFIG_ADC is not.
> Fix this by enabling CONFIG_ADC in imx93_11x11_evk_defconfig.
> Make sure this situation won't happen again in future i.MX93 defconfig by
> making CONFIG_ADC_IMX93 depend on CONFIG_ADC.
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,        Managing Director: Erika Unter =20
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
