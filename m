Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB9DCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABED8620C;
	Sat, 23 Sep 2023 20:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495112;
	bh=BcaAxXMS1i+upIM/lhzc1XJ5f5IzUyuNizfXi0fPYYU=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=XIPUw9lQ+ESn9ipvIds0M/3p440L1umE4dXShCEKSBsM9DkCauQm0M85QbNRq5CeG
	 qk20AdF51TnNNgImPrfFjswlz5qWIDp6P7uSzxWleO5qv23QMFqXV6K3PYhrtYVzWP
	 vem3ebKS++jdN3dgp7ODfiy/lzX/qlw2JdfhxiY7t3m+bb3OYvyjRgdmS7yaDwsqgA
	 triWYj6yn9eVYbgB7pHhRDkfcU7YlVrENEflnCjcbV/U3JZBgefRjO3lfxU6GgFqX5
	 Ks8B0IPGAoAxQCj3CFQMKRQ/TYa+Ukau03oL7KBU/USzjdz/oGjXp0Xw1yoVSwTHyB
	 FfyePCPEEvnkw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDB986963; Sat, 23 Sep 2023 20:51:51 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B1486199
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RtJC93xqJz1sBqf;
 Sat, 23 Sep 2023 20:51:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RtJC93b4sz1qqlS;
 Sat, 23 Sep 2023 20:51:49 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id vxeePbJgo_rY; Sat, 23 Sep 2023 20:51:48 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Sat, 23 Sep 2023 20:51:48 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1833093
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] imx7: Disable CAAM Job Ring 0
In-reply-to: <20230912151100.1735378-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <20230923185151.EFDB986963@phobos.denx.de>
Date: Sat, 23 Sep 2023 20:51:49 +0200 (CEST)
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

> From: Fabio Estevam <festevam@denx.de>
> Trying to boot a fitImage after a successful hab_auth_img operation
> causes the following error:
>  ## Loading kernel from FIT Image at 88000000 ...
>    Using 'conf-imx7d-smegw01.dtb' configuration
>    Trying 'kernel-1' kernel subimage
>      Description:  Linux kernel
>      Type:         Kernel Image
>      Compression:  uncompressed
>      Data Start:   0x8800010c
>      Data Size:    9901752 Bytes =3D 9.4 MiB
>      Architecture: ARM
>      OS:           Linux
>      Load Address: 0x80800000
>      Entry Point:  0x80800000
>      Hash algo:    sha256
>      Hash value:   28f8779bbf010780f16dd3d84ecb9b604c44c5c2cf7acd098c264a2d=
3f68e969
>    Verifying Hash Integrity ... sha256Error in SEC deq
>    CAAM was not setup properly or it is faulty error!
> The reason for this error is that the BootROM uses the CAAM Job Ring 0,
> so disable its node in U-Boot to avoid the resource conflict.
> imx8m dtsi files also have the Job Ring 0 disable since the following
> kernel commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch?h=3Dv6.5&id=3Ddc9c1ceb555ff661e6fc1081434600771f29657c
> For a temporary solution, disable the Job Ring 0 in imx7s-u-boot.dtsi.
> Reported-by: Eduard Strehlau <eduard@lionizers.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
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
