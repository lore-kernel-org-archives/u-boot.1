Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78629C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE3F84CF0;
	Wed, 15 Jul 2026 16:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Fa7OTHNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A4084CC9; Wed, 15 Jul 2026 16:30:40 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CAF884C23
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so335724766b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784125838; x=1784730638; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRTKSZhCX67VfW2vRcLwplBsWGwbf4mFCLLdBHPaBLw=;
 b=Fa7OTHNCgbbXKt3RbXtjp4YmhIiwOLPpzoUdBR/SewJLvqzkdmif4LxVshknCqRNkQ
 JuHsmn4QFLaEZ3YrMY9oifhaLSysGTT+IDIq+bb7Xxln26w+ftMiRxKInzUgOfeKULCr
 miMHLWMBBvuSj5eYm7MT0rrHPjyLSB40hCOsPUZ1wl2gJsYivqKpM0X2ePNCG+a09hSR
 qf9rxsKMLLVGxC1DZvtsb26rHBQL8zaw7/19qy61l6z6ilUe6dqAfSNlh6a8l+iCbSZI
 Ui/8hwAuZxipBQk47yaD1n8mbPtOhASQOJ8euwWRCuLQ5zD5keZB7mXWN8pYZwc0KaHR
 pGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125838; x=1784730638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XRTKSZhCX67VfW2vRcLwplBsWGwbf4mFCLLdBHPaBLw=;
 b=Qh4yJrk1DeXBxDlBXFwTwRMNBjtYIRK2eaUDjMoMsTClRB2SLyKuft0bcnRA9EZlSO
 hiFUP0hWa6sNdJ8+OH7dV7W1Q6GhVp2nZ2qRQr6UyCI7GO3h4aX0L+Cx1HLDDDogQjAW
 zSjefLZbeQfYF09qieBn6ujO0CxkHm8nO7qu42+btVNPmNlvj4BGEY8AE9OHKA7eAoly
 yeAusv3Ul3StL/pBlyLdIf7yDydMSlpTZzRs3BoIi4odMv8C3vYIn6+hfDe4UISEisCf
 YO0bArl2OkgsBwNmBhNFRPVaM/3oEIecX5WJKrV8+rxbNfVkY/tbxmZh+I/WAbjJeA3I
 4wDw==
X-Gm-Message-State: AOJu0Yx3vMd8O3heYbk4qHDe27ZqSvD/NKEphGcIbaIkMS3uIJ+2HECr
 Uq1DJNuat4SsTBUV+oj6WQ543ZJ9Rns6oSFRJ2ChWKUUQubicBk6c+X8LGoudYf6az0=
X-Gm-Gg: AfdE7cnVqN0rG6CbDX3DC+kkyf0/IXcrW64elQqGeeHXdLMV68JccSIbYtYf+WQeahq
 c7lQYFgfxb08tojgzSsbKG8yDw+cR7uCoU1OamNil7NAhloiQVYXPQpSwBShwPBXM/nXlkX6pLh
 VjdDMJyJ8eRvlshNYc0hD0k+G1HrmLEGaevgu4ONe2PgLRozAr2/UZuFnXm+Rl0m24jNdnX640t
 EIGUZoDthdU8ZR8sFKK/tMnP2OKwTlFN2PXdwXJJ/HsgQBA81MszmkK9dwkdky87LilrZzkmJYS
 fjLdEYm8aHx4aY62Wyaee+wrAebEhFRCG3wGJPZbvUd2zfi8W8YLR7UGSKJPfKlV1ntEfOxjQ2W
 /5TuvYFV7dHUvSRBLax1xCTs03I/2fFfSpC1V1svQe3/AbtU7wuEl9qddqVdzwKu2q189H6G3sL
 qv1QPV+3Se0UgLAWYRbyckwJgJk4vmIhwMTm47db+P4yM5oG/yyRDuIc9kbYCK5MEBhLM=
X-Received: by 2002:a17:907:3d56:b0:c16:7606:4cef with SMTP id
 a640c23a62f3a-c16760651d6mr289232666b.13.1784125837962; 
 Wed, 15 Jul 2026 07:30:37 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871262casm44827966b.6.2026.07.15.07.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:30:37 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 16:30:32 +0200
Subject: [PATCH 1/2] clk/stub: Support qcom,rpm-proc with smd-edge child
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-clk-stub-smd-v1-1-af9232571ef9@fairphone.com>
References: <20260715-clk-stub-smd-v1-0-af9232571ef9@fairphone.com>
In-Reply-To: <20260715-clk-stub-smd-v1-0-af9232571ef9@fairphone.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784125833; l=2146;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=5OkeGHvP4XIOBmCF4zhSLpcVFFRLTtUO8th5bCsLuFI=;
 b=U94VsP1hY9kRFrbr78yXPZM1443WMGFjPjy14PzzhI0TBuGsvkJBqBTWXTqQU1U4u/ECwg0lW
 4B1yBmkLjT0DhQyNd2UsJRSKEHygAFQorceNmKJAZknualizt1nRLkS
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

Older Qualcomm SoCs (e.g. msm8953) have a qcom,rpm-proc with an smd-edge
subnode without compatible, which breaks probing any devices underneath
smd-edge like rpmcc. Manually find and bind nop_parent to smd-edge so
that probing of child devices can continue.

Example devicetree hierarchy:

  /remoteproc -> qcom,rpm-proc
      smd-edge -> (no compatible)
          rpm-requests -> qcom,smd-rpm
              clock-controller -> qcom,rpmcc
              power-controller -> qcom,*-rpmpd

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/clk-stub.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 4a6c71016da..6daf0efa8d0 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -9,10 +9,10 @@
 
 #include <clk-uclass.h>
 #include <dm.h>
+#include <dm/lists.h>
 
 /* NOP parent nodes to stub clocks */
 static const struct udevice_id nop_parent_ids[] = {
-	{ .compatible = "qcom,rpm-proc" },
 	{ .compatible = "qcom,glink-rpm" },
 	{ .compatible = "qcom,glink-smd-rpm" },
 	{ }
@@ -26,6 +26,40 @@ U_BOOT_DRIVER(nop_parent) = {
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
+int rpm_proc_bind(struct udevice *dev)
+{
+	ofnode child;
+	struct udevice *child_dev;
+	int ret;
+
+	/* smd-edge subnode has no compatible, bind nop_parent manually */
+	child = ofnode_find_subnode(dev_ofnode(dev), "smd-edge");
+	if (ofnode_valid(child)) {
+		ret = device_bind_driver_to_node(dev, "nop_parent", "smd-edge", child, NULL);
+		if (ret)
+			return ret;
+	}
+
+	dev_for_each_subnode(child, dev) {
+		ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id rpm_proc_ids[] = {
+	{ .compatible = "qcom,rpm-proc" },
+};
+
+U_BOOT_DRIVER(rpm_proc) = {
+	.name = "rpm_proc",
+	.id = UCLASS_NOP,
+	.of_match = rpm_proc_ids,
+	.bind = rpm_proc_bind,
+};
+
 static ulong stub_clk_set_rate(struct clk *clk, ulong rate)
 {
 	return (clk->rate = rate);

-- 
2.55.0

