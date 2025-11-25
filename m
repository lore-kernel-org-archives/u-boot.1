Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3148D0EE11
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 18:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D05A84101;
	Tue, 25 Nov 2025 19:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="moHybHZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E18C84119; Tue, 25 Nov 2025 19:03:47 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BEA840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764093822; x=1764698622; i=xypron.glpk@gmx.de;
 bh=LpD14//xC45vCDeUJQqqv0pHCXO0mT1REEvNFUm1qy0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=moHybHZthxylzpMSOWCwEIpD0k2HQNp/sYYjhp3SXmT+AsJ+pBElt8i72HgzuMn4
 YqpdLP+ofrgMuPVMQbEW8WIhsT7z98cFhPjxbGiR3dBvKH4c2hl88d2zjll758b1S
 iNOS2nSVziMyybmLKua6YGvuSdTQPhU/ziRla0sMhkDiqiRqARRQiCaFDiyeRUbL4
 IqjvaXFnh15niURvEsGFqjrOuPifnCZFuQKtS+xsrfvDKLsD81jyxCgrpoR2VOMfm
 w6oCFIWUqikFpe2r/iof31xXXFm/0L0fL3lOs7T6LTEkGpxrNB5YMeL1XxIxjcBs8
 KDagL2thg4d9Z5CCgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.120] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1vQQ5t2cAN-006lza; Tue, 25
 Nov 2025 19:03:42 +0100
Message-ID: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
Date: Tue, 25 Nov 2025 19:02:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4gDuGz0XenokBOq0/PYO8yNNuPKFo8RRGkKW+2Es+CK3614ZBh
 dxi5CV9ltQzYVocC4OkIeL8Ig2zej0sZ8oCzn8B9HHBwaISIENzrRp3xfJgEW0eSCtzindX
 R119ls9tm0crubx1dCO+8KQ4787OdN9UnZbEGTvYnJTnR0hQ8O1CLDYgMVhhWA3aR4LbLOF
 Lj0SqFqk5fQ0T874GweAg==
UI-OutboundReport: notjunk:1;M01:P0:AtXTAFdFPNw=;EKb4Duz9e78Uv3o8kKYvIlXI2R7
 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
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

Hello Jagan, hello Heiko,

When testing U-Boot origin/master on my Raxda Rock Pi 4A serial console=20
output stops after "PMIC:  RK808". The same can be observed with v2025.01.

The serial console works as expected if I disable CONFIG_ROCKCHIP_IODOMAIN=
.

The problem seems to be specifically related to the bt656-supply.=20
Removing the line below also fixes serial console output:

diff --git a/drivers/misc/rockchip-io-domain.c=20
b/drivers/misc/rockchip-io-domain.c
index a0573c52193..b0d78f2d4b4 100644
=2D-- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data=20
soc_data_rk3328 =3D {
  static const struct rockchip_iodomain_soc_data soc_data_rk3399 =3D {
         .grf_offset =3D 0xe640,
         .supply_names =3D {
-               "bt656-supply",         /* APIO2_VDD */

Best regards

Heinrich

