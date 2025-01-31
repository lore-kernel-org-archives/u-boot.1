Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FD7C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 17:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72FC580F95;
	Fri, 31 Jan 2025 18:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="UeETZTEM";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="GUxkRZqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50BB80F9A; Fri, 31 Jan 2025 18:06:54 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686B380F92
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 18:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=UeETZTEMnK7ki7XtbwHPuAfmAfiJVP0fZGDbr6cEB69r/Z11RwRsTBPuSjlcCNRJxc/QGrWiKQ8c1H+oRkbwy8GvABVrDMH1CN6QsJZ4CqZrBoeMHGjDIrLQA8C4aEcvy3pqljY7jkMNbpwYk5wQS+GriXWnoY+7VIUasT9tG2Up2Y+4E5qb+qQRiF0Fpz7R07YqUy8frHYKegnT4R0idMzQqyU14QDgpUn7fgjDeSVvTd3BwFxBhKnA9U8qmop5/dbr+JnAXEf9K/Pab1VHrXmADNS6ZG0r7KA3oF7iXJxUBubENiXm9jAKFQysr448FDh7JN23SVr6sWopq3eBPg==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=r7rID+TPQsjLbmnYdPqXNaj8U5PsajPWZWh460bqgzA=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=GUxkRZqAIHOYZfrIfxbYCrxeVCvC/pdwRTDreWQ9lsQg6b/zApXs5VdHmFreA8fqV+jH01qmXKDCRfqy51OjOgWzXV+cvsa0blELdzdLEtfXMOLtM5e0C71d1oWO+tAMZnQRxOjenx10nZPy4rr5FsCvALvnQcrq+rN2JsPbXoC6k9QJpRGGamBvqcMasX6m1OOf05XOqVyzBkqKxR6DAAU73Ry5DPqR+0SppEMN1+oiLoMzYXimEPMMuvoJ8AD7x8YearcR43P125kae21ZCXbCsxxa4mY/dCCZjo2/cqI2opW41uLX8NFUBITJhbKXUpTlZADZ0IgvPMCtiSY/Zg==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=r7rID+TPQsjLbmnYdPqXNaj8U5PsajPWZWh460bqgzA=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 64912779;
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 31 Jan 2025 17:06:50 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Justin Klaassen <justin@tidylabs.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH] rockchip: nanopi-r4s: Enable second usb port and fix crash
Date: Fri, 31 Jan 2025 17:06:13 +0000
Message-ID: <20250131170622.747101-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

The patch enables the second USB3.0 Type-A USB port on the NanoPi R4S
board, which prevents a crash when initializing the usb system in U-Boot
and allows both Type-A USB ports to be used for booting.

=3D> usb start
starting USB...
Bus usb@fe380000: USB EHCI 1.00
Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0

Signed-off-by: Justin Klaassen <justin@tidylabs.net>

---

 arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi b/arch/arm/dts/rk33=
99-nanopi-r4s-u-boot.dtsi
index 69800cc368d..931499b084c 100644
--- a/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi
@@ -36,3 +36,8 @@
 =09=09};
 =09};
 };
+
+&u2phy1_host {
+=09phy-supply =3D <&vdd_5v>;
+=09status =3D "okay";
+};
--=20
2.45.3

