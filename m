Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836C4C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E887F88692;
	Sun, 19 May 2024 22:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="PO1gGiqY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NK5EdZLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223B688691; Sun, 19 May 2024 22:54:04 +0200 (CEST)
Received: from fhigh6-smtp.messagingengine.com
 (fhigh6-smtp.messagingengine.com [103.168.172.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDAF488621
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F2D391140110;
 Sun, 19 May 2024 16:54:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152040;
 x=1716238440; bh=zIsXvlCvAdc9XGQjqhmky7Xh+KcCpzvj8gbvSjnO1Io=; b=
 PO1gGiqYTAutD16u9AW+kkVIdqFXmOeG7cttHbqqaJjbXgRm+HYvKoXJVfY6GIS6
 r6oSLwvRSezSatD/LDlT3EcqkbbbOFq1UeSOBlCd3KBVEfjJSb5fikOeMuNtWe33
 GoYFtgcaMzNOyYlLUwz3A7tbMf8W1OdA9wUJFznk6sAkzSUfeRvunQBw7iOHNN9A
 A/x9ywXbR+2gf08BGYSO5U55ulDsc2lDB/YRyJBT7j6yrKl9hXiOiHrqz1tJqTjC
 9jIGl8tkh4NchuthN420gyeXzdfGpj0DHMhEOt0O0ZDeACJUC6x7MEYVXGEnImx5
 qDWI4LtOKoMxVrnr3s0Xcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152040; x=
 1716238440; bh=zIsXvlCvAdc9XGQjqhmky7Xh+KcCpzvj8gbvSjnO1Io=; b=N
 K5EdZLhxw4qPj6pgnW6kweKdEsV4ixyqEuq/nNbZ+TKtpdNeakYUyTc+X/pcmQKa
 9X9JV5+2qcwh4k1/TIVXpRIo2YBgEcRH3UzrIyxSdJViBDgKyyda5YMqQ0HlHMWf
 o/B+ELcx/SZjAMUXduzUeuR+K6f6CP0PBsQzAVpJiqhQdneY1AOmxomEVzbQNCqY
 Q8mkWs8kqUxszV6jAva/hPAm2U5HVwDNPQsgHcq2peKyXqKBQznUjJKJpqNeYDgB
 cpGfTFmJRra23DyuPNlm8LUaCn7ER6XbTcySiLzPwvg8U0FvDVGlKOWbT3fpauph
 x0tleRR0JYLHQ/5SDkXKw==
X-ME-Sender: <xms:6GZKZk0wt7aYRc6HXCkL0GxEN2ApkdsK_nEymekKeCSieBwyQXrl2Q>
 <xme:6GZKZvHaVvadCQ6aUGdAkemFq6GePS-nLlqIcryPR620mh4HoyDHVNhbx5v6MfIo8
 PyW3bkzwHeY33s0Crw>
X-ME-Received: <xmr:6GZKZs4WPLfY9oK2eZrPUiwKOhA045HXZNUukQ29Ee59iThRN4Evwus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:6GZKZt013u_zqSlPry6tcncJGaGc3L89D5BEnKDYthlTc7Oqrei2xQ>
 <xmx:6GZKZnFBAVADXQRKf7CdyHiaHIEUZT2FdDqXBLcwIR-HjpDmElz4Uw>
 <xmx:6GZKZm__ZgRCr9S6uNaDKOqMN0rL8D4XvPSD96qDnEZWZDhum4UFTw>
 <xmx:6GZKZskNSpi-fZZ8kpDg8rFDYW4jgPglk3ce8KMlqal75jxDQRbwtw>
 <xmx:6GZKZs5CNUEzP9VM5-U6PmmE6Y-oueS9XoigQoKcjfXehG5k4Z9bGUgk>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:59 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:55 +0100
Subject: [PATCH 08/10] dts/upsteam: Add Makefile for xtensa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-8-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=730;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1qY44IV7TxVWagBAMK1fqEpEPKDKCDWxXcz6sfAlmuo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHvHwr5x3bUqcGms2plozn5U9Kxy4o4DEsmbeZIL6
 p5lTrndUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNJD2P4X271PyF1c3C2l/rD
 kMNWa902Xqw1mvH+467fVk7mOfvvP2H4K+Ftf1v8icDmBx8n6HH78UqxfzZTP1rw/PSj2RGJUxp
 F+AE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

It is required to get it xtensa OF_UPSTREAM work.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dts/upstream/src/xtensa/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/upstream/src/xtensa/Makefile b/dts/upstream/src/xtensa/Makefile
new file mode 100644
index 000000000000..2a81acb32bc3
--- /dev/null
+++ b/dts/upstream/src/xtensa/Makefile
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
+clean-files := *.dtb *.dtbo */*.dtb */*.dtbo

-- 
2.43.0

