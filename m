Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C26D17121
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7578D88EBB;
	Mon, 21 Oct 2024 20:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KVDPx2Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABEC88F3D; Mon, 21 Oct 2024 20:01:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7538A88EBB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B91CA40A5F; 
 Mon, 21 Oct 2024 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729533687;
 bh=EnV4YUpnorQRUhJrQ9WBhvqSctRslSjazHIHKRniykQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=KVDPx2DgMibzbApOFIwXqsjvVnRGwGYog3p+LV9iymDhLD9TU9QE7NGZZBK5sItJJ
 +h8PO878Ce0t1cahvD8hlDaRjcmXJrn1N5RNBjLjmX7vr1rUDYVC2l4d8rYuHT2oiT
 a7wNEkrqd74lznBzdFuDgghVGbQcmWRXgKTEhd8weLRNCvsXDXhwLAXqwaZK+gK+NX
 YQUMViF9MjSbIN1yDOtEjprNwXEaYRZsjjmaT8oAaBn+kN78OiCVEO855mTFQIwJav
 ZZORgEDXc8EZlTE4AbTXnPLiWAH+Vo1s3YfoAgRB+gZ4KGXt1/l7RmthzNg10V6qgy
 q5cXC/Jpm/QHw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] doc: do not include K3 boards twice in TOC
Date: Mon, 21 Oct 2024 20:01:01 +0200
Message-ID: <20241021180101.18452-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sphinx writes a warning if a page is included twice in the table of
contents. Use references instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/ti/k3.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index c3513f0aee2..5d01f487622 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -32,19 +32,22 @@ K3 Based SoCs
 
    am62ax_sk
    am62x_sk
-   ../beagle/am62x_beagleplay
-   ../phytec/phycore-am62x
-   ../toradex/verdin-am62
    am62px_sk
    am64x_evm
    am65x_evm
    j7200_evm
-   ../beagle/j721e_beagleboneai64
    j721e_evm
    j721s2_evm
    j722s_evm
    j784s4_evm
 
+K3 SoC based boards in other sections
+
+* :doc:`../beagle/am62x_beagleplay`
+* :doc:`../beagle/j721e_beagleboneai64`
+* :doc:`../phytec/phycore-am62x`
+* :doc:`../toradex/verdin-am62`
+
 Boot Flow Overview
 ------------------
 
-- 
2.45.2

