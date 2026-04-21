Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D71DF5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58088422D;
	Tue, 21 Apr 2026 02:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="kd+B49Gj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="bACh3pQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326678422D; Tue, 21 Apr 2026 02:05:20 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36345841C8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 108191D0014E;
 Mon, 20 Apr 2026 20:05:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 20:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729916; x=1776816316; bh=1aObSlj/8YbT+dQbgi/HF0KkZBHxZY/G
 UzwpMupwSvk=; b=kd+B49GjrmS+6Jxmk/HB6a3+uW2jE/sXj3ulOPLToeZa0k0y
 7/MjWenDL/HCglCzAiWVxA4fPUhdaVsNDpZdFa0CGvMJEd4LqnpNg/X4PisUK/U6
 piNRwv8ceJAaVFSgoq/foh7fSPcSrKW9Fa3XHFlm43QhRkDeVKSK+kZgQ+tnT1Mc
 FSmjZclOtLQq0wCVIv3D6un5Zqk8Rk8CwPxj/vw0iQPrIIC5X3HyhdiL3SoQDfp2
 4omt7OTvLhPpUWnxVzK6uS30BcwSru2jg5G9a60XL9mUbSZSW7HBCa5CXelEwI7X
 V729LACKV7TxdqcAwG4Sb4KcWv6KOxGXTleBbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729916; x=
 1776816316; bh=1aObSlj/8YbT+dQbgi/HF0KkZBHxZY/GUzwpMupwSvk=; b=b
 ACh3pQGKB+WZUu0b5mxEROXFiPJyQptn0zZJxIZ5b7+wKAt5eYEHTuNcARYM3oz4
 x0Za3s4qe/445ShcE4+K5LlZmS4bHnWA5mSxYF4rfzwUUtpXN5wFOXrnFhZYZWpy
 V1saHZwV9Ol1e0mQnY9ID0vuVyRKToex6gI9aNjYIJ4mGlbTGjjCufyW3JVEbefg
 oxg8nGFzYebg15GW9xXszXw3/f5N3FRoBgj5yzVD5SorjOhTwRB1FEWGt8tapswV
 l3UEo9fJwKnqpFuQMBGD2/VmDJrXwS5plzMpgGXpEA4TqlYP/SnJ8JWhPPQjyqwn
 XKojd/4yHf8Keo8wiCe1g==
X-ME-Sender: <xms:PL_mafUu0U82GOVVLtQItLqAA0ubvxPKRF9QLbaRg7RXTCF-2bNijA>
 <xme:PL_macjRqbkioQF75nVNyJXjr9s8D7WrVXf528oXT5z3zeg3ddJaWvAPEvK_xjZrE
 iRQiw3zccUA2w3-wRSQQQVB4FPeSewQqBtlB4NkpndyVaupuOrNJg>
X-ME-Received: <xmr:PL_mafoxqPX4_tU08X_pjB65OKOPQgTRbsXGUxJsX8stSVqL_XJh1fovpzSfyn-y4UV5Ytr_gYnKpnlEkYLmAToJBW8yOMrn9F0JBUBVtqtHQWkRj_GQVpaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleeludcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:PL_maaGZnaVJKZ7cyhPdjwrClKfILzNbFl7nur8AXXdKf9PUDpYQ-Q>
 <xmx:PL_mac4LlCOXtz-OjRclEeIUbROiRgzGeoOvllcWXduVfVpjrxc7eg>
 <xmx:PL_maacBWCbsHaaOp4uiURvbge8EuknqcneifRi0Xyzyrh5JRlKd9g>
 <xmx:PL_maf72jjBCqacSJnpA4VJGtR0AokcSLCRaE93bmFT3BWA9i87diw>
 <xmx:PL_maTLHoR5u280QbDr2-oQMFRNR39GW2yU5aHQpw7f5VM54kMpv5TMZ>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:05:14 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:41 +1000
Subject: [PATCH v2 8/8] board: ten64: start USB stack in late init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-8-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=1327;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=TPWdvqlQepSQcO7LoQh3hD0+aSCtRzXHIKjtVPFi40c=;
 b=7qveUDw25Sxg65k8M9WVGT8cWA+Rio/s2tEh1gWHAqftGoeWNjrGqd3IvNQnkPRF+gmO0l5YH
 IbCAtrhdmdhAZjlPoCxbBaDaAraKXmqYyoQotB6y7vRrtrXaPrdTFAx
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

There are two reasons we need to start the USB stack late
in the init sequence (before handing control to the user /
boot sequence):

1. When a USB hub is present on the board, we need to
do the required sequences to make it usable

2. To make USB storage devices 'visible' to bootflow
without further intervention

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index ee2a4005739..29faea3dadb 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -31,7 +31,7 @@
 #include <asm/arch/soc.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <nvme.h>
-
+#include <usb.h>
 #include <fsl_immap.h>
 
 #include "../common/ten64-controller.h"
@@ -239,6 +239,13 @@ int fsl_board_late_init(void)
 	if (IS_ENABLED(CONFIG_NVME))
 		nvme_scan_namespace();
 
+	/* Ensure usb storage devices are available to bootflow.
+	 * Additionally, if there is a USB hub on the board,
+	 * it needs to be started to become usable both in U-Boot
+	 * and in any booted OS.
+	 */
+	if (IS_ENABLED(CONFIG_USB_STORAGE) || IS_ENABLED(CONFIG_USB_ONBOARD_HUB))
+		usb_init();
 	return 0;
 }
 

-- 
2.52.0

