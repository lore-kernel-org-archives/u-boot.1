Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E917E784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7320871AD;
	Mon,  2 Oct 2023 17:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="R5xkmv6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B508E87166; Mon,  2 Oct 2023 17:21:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E887B8719A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id E772566072FF;
 Mon,  2 Oct 2023 16:21:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260115;
 bh=gqbPNdyYP+ktRQ7UyBZJq/nLzivabyDiSzTnlKtbDwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R5xkmv6LapqlYfQRFW80iAmSv62vIIuQzYqXqLHG+cZ7kzAaFshxZ46/ZLMYpxgkg
 mD1szMrb22mGwOpADH1eRjz7CBWfUJrNjLoyIzzXe6Vp2UUluLVnglDt26cXzaFkS+
 MDthcvkWJeIXz5tCY88dX6Qt29js4DXcIVhiMlxxCRNxblf7qDMHUhse5qHoJaUVdZ
 C5nJwifYdvg6Ck3NHEZPv/Z8Rb1EMneH0FxLN+eSXQXPOdaiLg2wW9rW6bOgfnCog/
 B5Y6nvWxuwTwc8HGmeI8X2m/Is1bVfPV73t7lwAIxjamu2cDF1x4QnlwWfjkEJLCTb
 zxdrx1azKTXLg==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 1/6] sysinfo: Add IDs for board id and revision
Date: Mon,  2 Oct 2023 11:20:05 -0400
Message-ID: <20231002152142.76516-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002152142.76516-1-detlev.casanova@collabora.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
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

These IDs will be used by the sysinfo command. The new IDs are:
 * SYSINFO_ID_BOARD_ID: The board ID as an integer
 * SYSINFO_ID_BOARD_REV_MAJOR: The board major revision as int
 * SYSINFO_ID_BOARD_REV_MINOR: The board minor revision as int

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 include/sysinfo.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index b140d742e93..13815600ae6 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -47,6 +47,11 @@ enum sysinfo_id {
 	/* For show_board_info() */
 	SYSINFO_ID_BOARD_MODEL,
 
+	/* For sysinfo command (all int) */
+	SYSINFO_ID_BOARD_ID,
+	SYSINFO_ID_BOARD_REV_MAJOR,
+	SYSINFO_ID_BOARD_REV_MINOR,
+
 	/* First value available for downstream/board used */
 	SYSINFO_ID_USER = 0x1000,
 };
-- 
2.41.0

