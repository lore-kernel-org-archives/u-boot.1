Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15671C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B808309E;
	Mon, 14 Jul 2025 15:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="DIU3d4Jn";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="fDfINVLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAA08309E; Mon, 14 Jul 2025 15:22:43 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ADC8300B
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=0HAW+C3RG39G0M+3v4o0pIJsLgRBCgmBsrtp8VX16I0=;
 b=DIU3d4JnCVCQssdaKfi4kSj6vX1kvipkAVW8ePfAX3hElRmaIllH4bJdysrj0OVN+yTPCSaiaN3zN
 HAWCYnBKF5uWVa1DpKcL6IJCAWnZkLgSn37HE+2Nh9u7lzCuiSIRfezb8IA+6aH2garu6itZM/zpE5
 co6U4Lnvzc4KQnEQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=0HAW+C3RG39G0M+3v4o0pIJsLgRBCgmBsrtp8VX16I0=;
 b=fDfINVLrcKhMrERZYCNJg/Op+5bzPE2KWftK7mGhywQimZNRbtYA8W3TEdPACa91VZDJHzG84jnep
 rjZC5Jrict7m90qJYt/NLHQv14Z9HUs0YoA4wdYpd5wCu2e6XK41jOUahZQtOovgB21JbUPdaVfmsE
 uXe0taQisXymklCbAO+ZFve+lfue0+I1plzHujO8wF1tJj5kmYjnpEzZh1cDGYMZfJKEutkxsON02N
 X6NiVC/CDCCp1LN1h8iKN1cZkRfsgASucIswZnN93DDh27THX1cyOgP2t7rxtdzzCMU6XLArIKLLFD
 8cqUcdkPAnWHdpGPORBr7V4nsO2SMiA==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 9c3c94e7-60b5-11f0-ac89-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 9c3c94e7-60b5-11f0-ac89-878ee10b8a33:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 9c3c94e7-60b5-11f0-ac89-878ee10b8a33;
 Mon, 14 Jul 2025 13:22:38 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 26D904024BA; Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 8CFAE60B7D47;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 1/6] km: qrio: fix set_gpio read/modify/write
Date: Mon, 14 Jul 2025 15:22:16 +0200
Message-ID: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>

Setting GPIO by reading the value of the GPRT register, toggling the
correct bit and then writing it causes input values to transfer to the
output. Here's how (example):

1) set gpio 17 and 18 as input.
2) set gpio 17 output value to 0 (read gprt, change 17 to 0, write).
3) set gpio 18 output value to 0 (read gprt, change 18 to 0, write).

The problem here is that because we set 17 as input, and it's a pull-up,
when we read gprt in step 3, the bit 17 will be 1 and not 0.
Instead of doing read/write/modify, the solution is to keep track
internally of the user set GPIOs, and replace the read step with this
static variable.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/common/qrio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/keymile/common/qrio.c b/board/keymile/common/qrio.c
index c8299483299..f8f8d5edede 100644
--- a/board/keymile/common/qrio.c
+++ b/board/keymile/common/qrio.c
@@ -18,6 +18,11 @@
 #define DIRECT_OFF		0x18
 #define GPRT_OFF		0x1c
=20
+// used to keep track of the user settings for the input/output
+static u32 gprt_user[2] =3D { 0x0, 0x0 };
+// convert the bank offset to the correct static user gprt
+#define QRIO_USER_GRPT_BANK(bank) gprt_user[(bank - 0x40) / 0x20]
+
 void show_qrio(void)
 {
 	void __iomem *qrio_base =3D (void *)CFG_SYS_QRIO_BASE;
@@ -72,12 +77,13 @@ void qrio_set_gpio(u8 port_off, u8 gpio_nr, bool valu=
e)
=20
 	mask =3D 1U << gpio_nr;
=20
-	gprt =3D in_be32(qrio_base + port_off + GPRT_OFF);
+	gprt =3D QRIO_USER_GRPT_BANK(port_off);
 	if (value)
 		gprt |=3D mask;
 	else
 		gprt &=3D ~mask;
=20
+	QRIO_USER_GRPT_BANK(port_off) =3D gprt;
 	out_be32(qrio_base + port_off + GPRT_OFF, gprt);
 }
=20
--=20
2.49.0

