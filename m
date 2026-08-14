Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5924FC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF0E81117;
	Fri, 14 Aug 2026 11:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NabnsYSFxFPs; Fri, 14 Aug 2026 11:21:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C86838117B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706494;
	bh=NbfPJvTMOC/VB/gsgspxfyuxzyRL37MBFyM4mDeADWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQn1rqffqli6NcCuYs2rrMYgDo4aoHQN8gdcDYfa/rfAOsYZDyc/g1Js1Y1T97DgU
	 1L5V9eq7EoOBEjzkVyJMzPwt/WIXj5meHrxDX9sq6KwTwDydctHJKgxJsy/ERGk/N3
	 lwrUxF1mIh1ztxU+eSWLy9X9NiaZrkeEZWe3IG4Me3/W5bMlTeUgI25NajkPd65Lzc
	 SjLhJ8vfvkfSDlkUVxxgSaq0jhnnDa7TwtkSlbaMFu7n/AyitZZ/WzYqhNkEJ2lOp/
	 7wogfxgoVNXaMQoo5XfAkLvKzrGzNbckEPJFXZJ38OntBwuuRwIhm/Q6ip+CO3Vd7T
	 FwtMRItwUqazw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C86838117B;
	Fri, 14 Aug 2026 11:21:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95A8C139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C249405D1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nfke8jqnli6A for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 90B87405A7
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90B87405A7
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IOKFK8bA
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90B87405A7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:27 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so422488f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706485; x=1787311285;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbfPJvTMOC/VB/gsgspxfyuxzyRL37MBFyM4mDeADWs=;
 b=IOKFK8bAZ/sjzv6xljvXaS68lgkLxHl8Dxxl7Mzz0fvKEsDV65rJGIh+P797NesMEl
 QjUtp+S4auwN+G3b3+c3F8ia11TTGHVL65dtmgginnAFUDuIOJh2UXz/Vz7ZNSfTrpOp
 O1Wya0mDH0AIqStXyigfRv+oJtxPmm+g4SsNjjjqDf/I7bQ2WSy6z0oJIpVUjOQPnxMu
 N6RCqNYxAO4AwE8OP0Eh2hDI1TS8je7oEPIHo5B4vAvOQ0OcA/F3/8rLGX47Ax4HNrVL
 pzykuz+7IZCoeoxghfdYYKyA6p4rf9HpnZq/Mt04KhHXXlkQUsuxhOEjV1ldRz9+JNgF
 bK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706485; x=1787311285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NbfPJvTMOC/VB/gsgspxfyuxzyRL37MBFyM4mDeADWs=;
 b=aZNHg8eZ89hTtBmM1O6Ukp7IgLHU5LO/db7MXoWYiRLCjy4aYyX0/jUjPg9FzBopCm
 7dNlX4hBDSIW7OuwxMiV+zyMaz11nIbvymrBEI6N0WciTJBL+fIPrFQpWMo8mgx13ZJP
 Pdy2vr8qjUHHLNdhZEcuPbioj77fIeaPY93D9tblopheoeK2ZBHTVpKcYWf6WC+YM8Lk
 R5vRhHkg12JrwKWQ/+eFDMg/6MQWoik+aTFvEaIE9P/SKO0YX3nDyBUCGry+MDjyw9FS
 SMxyDD9L4MoV3dwVU6elaYvc418xXoh9q+aogRLs+QiJwWqkaiekpVTsOytVQE7gSMlG
 LCxA==
X-Gm-Message-State: AOJu0YwrVl0Q+4lgOfbNI9hKYRunLGM+IEmd5MhV2PWgJVwIZ2w5lAc8
 udc9i4VHsQspX8QYMljwSGwmenv8wGsTBRHFuBIkHR7y7A6tY5GE8iT+
X-Gm-Gg: AR+sD10DJ59/nvqLx33toT17u+veXXS7cE9QXTvSwGn3sTtsF0cwwT79vAJrPB16wch
 PXNKHx7A8B8IAUGzU4VLP0zQK/bkPAM+CO0nE2+uTKyLsvpcqoM8sdnWKQ/xiyrkpTf0x3/M7zK
 pJaKv+96kfCjxDZdfMyuSaCbchPD46/nsikyk+AzlNnQ3bJsBDMXTL/KU+liLMmSapsD4vhL0mk
 J5SPQjZnhYGkQ7XvgOWI69qZZ5f6ppCTBZHzr7M1xw/9Wut39PZpOLfOgRD99Ti/rsPxMPuBNMx
 7hMC6Iw2VAR7CvQjztVFixceQ5gbQHjuzPqkrii+eqoHQoUIYkrEZB+Z1FjuUGBuDzUQG8q+LEs
 u6pvz//UzglFFd2QFz29mIjW5DA571hrhKIgqsxx/In9UX8YZ6oj/+dRoEvCae1YY5pke1nb384
 KloSQy1GsyzX0QBn+R5LWphrGZDixoqvks+KHyiztpCNC9bqLnOV/X3goRu9lCRgRyGXAcqszvj
 lID+V39xkJMT2yq2Uu+ILFgO85VhdNF68qL5bhKhURPFdworeO5O/6+shn46BJ7nxfpP+49gOar
 iAExXkGnaxQ2iGB6Dejym9f2PXLPx7MNveyjKnwspGn7Qba8
X-Received: by 2002:a05:600c:828c:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-49989345963mr44769135e9.10.1786706485371; 
 Fri, 14 Aug 2026 04:21:25 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:24 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 14 Aug 2026 13:21:20 +0200
Subject: [PATCH 5/8] toradex: verdin-imx8mm: Set WiFi DTB as default for
 new PIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-get-rid-pid4-table-v1-5-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the Verdin iMX8MM uses the Toradex product ID table
to determine whether the module is a WiFi or a non-WiFi one and sets the
DTB accordingly.

In the progress of decoupling from the Toradex product PID table, use
the WiFi DTB as the default for new PIDs.
This change is safe, as on non-WiFi modules this leaves the WiFi and BT
devices unprobed. Further, the SDIO/UART signals are exposed to the edge
connector on non-WiFi modules and can be used on the carrier. However,
no Toradex carrier board makes use of these interfaces on the carrier
and it can only be achieved with a customized board. For customized
boards, it's expected to override the default selection by setting the
'fdtfile' env variable.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 4e308084968..93c26476081 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -71,7 +71,7 @@ static void select_dt_from_module_version(void)
 {
 	char variant[32];
 	char *env_variant = env_get("variant");
-	int is_wifi = 0;
+	bool is_wifi = true;
 
 	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
 		/*
@@ -79,12 +79,10 @@ static void select_dt_from_module_version(void)
 		 * module with Wi-Fi/Bluetooth make sure we use the -wifi
 		 * device tree.
 		 */
-		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMDL_WIFI_BT_IT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT_NO_CAN) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_4G_WIFI_BT_ET) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WB_IT_64G) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G);
+		is_wifi = !((tdx_hw_tag.prodid == VERDIN_IMX8MMDL) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MMDL_2G_IT) ||
+			    (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_2G_IT_NO_CAN));
 	}
 
 	switch (get_pcb_revision()) {

-- 
2.43.0

