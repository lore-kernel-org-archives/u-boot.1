Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE2C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1760830AF;
	Mon, 14 Jul 2025 15:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="fN6bSUDD";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="cdagmi05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EACE830AF; Mon, 14 Jul 2025 15:22:39 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2991482FAB
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=Ku8TjvS7Viz4TeGRamWkJaCaJw1F/vfQPLqOiI3xm5A=;
 b=fN6bSUDDjzGoK7nnwdDa9JumGehyitS2L1GRIIhdLsm9n57HGbe2XgKW28RzgeicHfW173ucY4spj
 7OYgAVTQjiNNQmfAvH+B6qoFqQZ8n1szVG5uanBgUHgzFi885wpyZxLAyEiaMz6G1MTyIFcOX4XgAl
 i62XZORGx/ZSVJT8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=Ku8TjvS7Viz4TeGRamWkJaCaJw1F/vfQPLqOiI3xm5A=;
 b=cdagmi0598YaXScnH7v9gPOA32amQ6Ri1HlgvVMI/g55nIweLiFK1B94zWrd485UCOdr1+bTGfhGH
 +mAJCVdXwznUTGXj6fslc1clxugOZRwYzLCx2OIbFryQSivboJTE2fcclspVjSeIi69Z3EN+qp70Ld
 nZbi89RfAqKKFN5Jd1s6lvqFMhPyv7jQokJR0FgQpfMGidZpywsE4Ohk+Z+9GJlM6nX5COA2hnAEOY
 FqVXyKYHpvkcZ5juuXbg2KJOg6aJdOo2qjgNxGzIK3PcL0XGyIPFb4lOKY9cnilDBM8tg5Iveu6xh/
 kHwGCRSgLYNfN1tyK9sbot0sx7s0kbg==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 99a4c1f3-60b5-11f0-ac89-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 99a4c1f3-60b5-11f0-ac89-878ee10b8a33:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 99a4c1f3-60b5-11f0-ac89-878ee10b8a33;
 Mon, 14 Jul 2025 13:22:34 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with SMTP id 6F49E1605; 
 Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id BD1AA637F989;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 6/6] km: pg-wcom-ls1021xa: update MAINTAINERS
Date: Mon, 14 Jul 2025 15:22:21 +0200
Message-ID: <20250714132221.2471558-6-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
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

The mainainers for these boards have changed.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
---
 board/keymile/pg-wcom-ls102xa/MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/keymile/pg-wcom-ls102xa/MAINTAINERS b/board/keymile/pg=
-wcom-ls102xa/MAINTAINERS
index ed5baf269a7..7d80cfbf64f 100644
--- a/board/keymile/pg-wcom-ls102xa/MAINTAINERS
+++ b/board/keymile/pg-wcom-ls102xa/MAINTAINERS
@@ -1,6 +1,6 @@
 Hitachi Power Grids LS102XA BOARD
-M:	Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
-M:	Rainer Boschung <rainer.boschung@hitachienergy.com>
+M:	Holger Brunck <holger.brunck@hitachienergy.com>
+M:	Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
 S:	Maintained
 F:	board/keymile/pg-wcom-ls102xa/
 F:	board/keymile/common/
--=20
2.49.0

