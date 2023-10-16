Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01261CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26AC86F19;
	Mon, 16 Oct 2023 11:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448196;
	bh=wwhIfV2WhFU30sZPfWX5nAQ0AcLZMPRwI3WSU8IRoF8=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=xVi+CDt46Tkx68YtTMdm8Fcc6NnQuYyPqZVD8iBzjoOYoDHvWT9MjSgwc7yL3/ksS
	 bEV5wccZyV6wTIYpO30jLX36NvdQg9hhp1sW6yBhvYiCfUWhxE+muQSiOyGZppF8ii
	 FKqraN1ZgIwoBWEe63tLGxVYn5+qHI5ISbDJm/Twi7YPnwUsbudme3uBiQRs4D/Z35
	 sbxIzPTntswrQiU4T1hOxY9WIkDAZxulTV8KoUHRHRtB0ciLPYnEZq4RdpURLaYVWy
	 AH8w89BRWi5tQ2Ofxxwy3Hv0x8Z789nSXRnLxffYhyirUBbmXew300OI9oMShf8nso
	 IByfHNPHGMV7g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1F886BB3; Mon, 16 Oct 2023 11:22:25 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1E586DDE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTK68sFz1sCln;
 Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTK5BBmz1qqlW;
 Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id It-tw2wBA7sr; Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
X-Patchwork-Id: 1816524
X-Patchwork-Delegate: sbabic@denx.de
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,u-boot@lists.denx.de
Subject: [PATCH v3] imx: syscounter: allow timer_init for SPL build
In-reply-to: <20230803152520.728610-1-oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <20231016092225.CF1F886BB3@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:16 +0200 (CEST)
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

> From: Michael Scott <mike@foundries.io>
> With enabled SKIP_LOWLEVEL_INIT, the weak function timer_init() is
> used in the SPL build. For iMX6 SoC, this leads MMC to fail once
> u-boot proper is booted due to a timing issue.
> Always use iMX-specific timer_init() in SPL to fix timing issues.
> Fixes: be277c3a89 ("imx: mx7: avoid some initialization if low level is ski=
pped")
> Signed-off-by: Michael Scott <mike@foundries.io>
> Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
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
