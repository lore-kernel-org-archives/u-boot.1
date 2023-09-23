Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A47CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2452A86B40;
	Sat, 23 Sep 2023 20:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495129;
	bh=ZPh4bEi0p2aMEG71VP/RarYcrY4BJElJ41guPYvQBMQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oqXO8CXUL7bItqsdKJwdzaWvO9Cslk1+nATqtE4WszsGMqnolFVVtFXAm2B+1FjNz
	 Ge1WjLJYzrNT9R44Q7eKuW8iOsdhKM7h8ukgJpQ6t1x89kO4cmGSoNF8XEyGorT+ek
	 fU4enrVSUm4I7fBrvow0D+Ig6QrqhKZIb5M9fzIEKAnh0FgnLOSo8W5hmWRprY1LVg
	 bKfrkebcerYuWWotcBBAmu8nKE+aU3j9H89nbmlnjn5DlFDysXPuDY3Z4vv849ToeT
	 g1/l8VRawHM43SnAOKnzWMKyEHStP7LeBRNqkhKO1z1CznBDSMQCB1o3ulPA6tPb93
	 DDB9NoB57zzOg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17B986B40; Sat, 23 Sep 2023 20:52:06 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19393869B6
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RtJCS643dz1sBqf;
 Sat, 23 Sep 2023 20:52:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RtJCS4y44z1qqlS;
 Sat, 23 Sep 2023 20:52:04 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id s-jcC531LaWZ; Sat, 23 Sep 2023 20:52:04 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Sat, 23 Sep 2023 20:52:04 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
X-Patchwork-Id: 1828395
X-Patchwork-Delegate: sbabic@denx.de
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,u-boot@lists.denx.de
Subject: [PATCH v2] mach-imx: bootaux: fix building with disabled bootelf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <20230923185206.D17B986B40@phobos.denx.de>
Date: Sat, 23 Sep 2023 20:52:05 +0200 (CEST)
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

> If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building ends
> up with a linking error [1]. Select LIB_ELF to fix the building
> issue.
> [1]
> ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
> arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_elf_imag=
e'
> Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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
