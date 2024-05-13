Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34178C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667B5883A0;
	Mon, 13 May 2024 20:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="pSWWvaZz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDDQXC2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87183882ED; Mon, 13 May 2024 20:13:31 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD37882D5
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3D23711400B1;
 Mon, 13 May 2024 14:13:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 13 May 2024 14:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624007;
 x=1715710407; bh=z3B6dviYyp7BMaVggM04PCxnwCEGC4IX9N2JtsCA5yA=; b=
 pSWWvaZzvyNID0fr6kitjM0bnQC2b38qECrQIOECYPtuHpCEpsKr2Kj32oWzqe1i
 Btvs8fVYadUBi4Ll/pNB75ndcN1Tj/rVofHzRVxR3vRWVJemSKcf/bY440Zn5XFl
 5l8abB2FHWEg96rr1nmdU9qyMOpa8DDb5iC+qcoMREVToU0L4F8/T5TcSspBhrcN
 0cFuxbHMtJTJ+m6vAgXbTmZdwqslciLj8Z/GyoVd0Q76KgAiiZLHkLN3PRW1/K7k
 O6a3E3mOz03A6ua7Ooje/8wlM9N6F4DbftIQF8/4G2nHGmbgabC4xE9DBbAxzL8w
 Xu29z6SBqWVbRprjzAQncw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624007; x=
 1715710407; bh=z3B6dviYyp7BMaVggM04PCxnwCEGC4IX9N2JtsCA5yA=; b=j
 DDQXC2HVRfPgTPYjkQNTGAIg+N0m0kl5KOUJcpNKea9qg/8l/+TPklb6toco9ZWG
 0FT9c2mPoUJiiynTtRZoUxMGoE/RfSQBPqZogSSgaPgSlQZyHsFri4acxrXxIUH3
 BDysUEs6TgC+HS3d7/OQEXyD1LJQtdtcFYxZaV2OBaxgv+3wicHY/5EObajN1Qjb
 v09qp2/D7HHCi9hNkbvb8TuV7Po43J86PbY0cjTDrG4jHY0HTBvVXF+X/JP1AwtK
 lMUVet4Bi/MlqWX7omLBrajWGNBiUZJV9/P6rI/EEtsT5ewU0ogGpE9En5eJ13EF
 b+2rcGXu3XW9Wpbm0Sgnw==
X-ME-Sender: <xms:R1hCZo2XO9NnTiRbXBbTaRkZiw6ppVAlzWzaCmo1A8IKVQxnPQkdrQ>
 <xme:R1hCZjFRer541pwLXfSdbrZMOSrf_FHdNT-qBFt2L5m9_IXdtO8-Q147J0_aKGNCH
 RS3O6Gvoj-RXXbkIVo>
X-ME-Received: <xmr:R1hCZg7wkk0GWvW6SHVN4D0wP7KOP2ceYCswyldvXl-4ltW94EyKq2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:R1hCZh02CME0tE6pYjjige8tjrtbZD9D_FzoEiGwkXrR1GHEx3Elyw>
 <xmx:R1hCZrHcHNbOn8slZfYrkOIXY3JODt-I7U4wfwQYaIbExmA4hZMYdA>
 <xmx:R1hCZq-Zo4rmIvb85piEfuwrx0mVAcFnvbPejn5zfRrGWQfg0YEt_w>
 <xmx:R1hCZgk7reUO2xSsGCF1Ng8VFwcU4XY0dOoF9JgClT4iCpZ-Aiom5Q>
 <xmx:R1hCZj_9p4c7hSqlpSLdYx0mhG0pEdP5e7aMwo3wEkqwGR8KAP5JruBg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:25 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:08 +0100
Subject: [PATCH 11/13] dts/upstream: Add Makefile for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-11-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=C8gD7IB7KO/1v73B7QkR1vu8asFECiTxJxXrxkTJ1W4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOO5jMfScqate2gXsOrhaaV9kvmpETsvma78bbhx8
 Z637vxOHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRfw8Y/vv3bb9leEjG/3gq
 WxrvrL93G2b15/+SnH0my6/7imhdQwzDP7X/lw/syj2Wb+T0qVbHp0ajtjT2ilVQlWi7l5v3A+u
 NbAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

It is required to make OF_UPSTREAM work.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dts/upstream/src/mips/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/upstream/src/mips/Makefile b/dts/upstream/src/mips/Makefile
new file mode 100644
index 000000000000..9a8f6aa35846
--- /dev/null
+++ b/dts/upstream/src/mips/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo

-- 
2.34.1

