Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7DDCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F28F869A3;
	Fri,  1 Sep 2023 11:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561827;
	bh=hvmQ0KKbRnzBIXeA6BLRl8XEoZX1Z6uiXVXBPI4jTP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H4N4nhnj8tHdmzDDQNWmkH9w++wKnF9wgtw0wUeXpaMiJzAipf6tTBhPg5T1ua4ON
	 nwsCiaQLl5gBUqjN4iXlFk5tv3hkK6Rp+Kskczaqkxb1wzlgetGXAkeIdM5TS7CAlP
	 sT79TkJczeMmoYQ2HHpg6ebcrzkI8lhoiTzbUqUiw9YMDuddbNaAI06FQdXJThEkBN
	 KaTln/93lwzq+ul8VEvMaTbl/j+pdOpwfM4Yxb0w1zU1v/Nov67WSigh+/7Z/NFVPH
	 ZjNVPmotDyNgj5p5PXS+LWt7MfPTDGdwZtzQVocKkaWHSxmDWP/gasVPdlxv8xCEk1
	 C90H286VRYt+w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ECF4A86959;
 Fri,  1 Sep 2023 11:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561825;
 bh=hvmQ0KKbRnzBIXeA6BLRl8XEoZX1Z6uiXVXBPI4jTP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G49ne1c0ytGQ3fnUiYzKKJtAyixeWeZ6Spt5DdP3QskcKG5Sl+xiLI3Ypqj40JYLJ
 Q5a6se1GLhXrD/xP86G17HnBcDhQt1TeydXOUX+sRHChArfVvJ4CENmZZUx5X5JGCR
 cSGmMavqVkrEWgSOhZCotxR1/W8Kbmc3E9eo1oaeopxbomOyvgheNsh+BRTjLhh++K
 EOT+AKMqxfp3D1nIPby8y3fAkgDV46FslqnV8uUoh7YVI9SZasKRrZgVfopJc5UP8H
 I1gB1dQsCNkrP/hxdMV/smejwNz7XvEvslKi8voeNefm/lfRUf3DGGM4hVFldYzFLz
 1PVASFmJymhew==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 11/17] spl: sdp: Detach the controller on error
Date: Fri,  1 Sep 2023 11:49:57 +0200
Message-Id: <20230901095003.352930-11-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230901095003.352930-1-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
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

In case anything errors out during the SDP transfer, detach
the controller instead of bailing out right away. This way,
the controller can be reattached on next attempt.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
V2: - Call g_dnl_unregister() in case sdp_init() fails and on regular exit
    - Add RB from Mattijs
---
 common/spl/spl_sdp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
index cc4fb4f7cca..aae886d2e57 100644
--- a/common/spl/spl_sdp.c
+++ b/common/spl/spl_sdp.c
@@ -25,13 +25,13 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	ret = g_dnl_register("usb_dnl_sdp");
 	if (ret) {
 		pr_err("SDP dnl register failed: %d\n", ret);
-		return ret;
+		goto err_detach;
 	}
 
 	ret = sdp_init(controller_index);
 	if (ret) {
 		pr_err("SDP init failed: %d\n", ret);
-		return -ENODEV;
+		goto err_unregister;
 	}
 
 	/*
@@ -42,6 +42,9 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	ret = spl_sdp_handle(controller_index, spl_image, bootdev);
 	debug("SDP ended\n");
 
+err_unregister:
+	g_dnl_unregister();
+err_detach:
 	usb_gadget_release(controller_index);
 	return ret;
 }
-- 
2.40.1

