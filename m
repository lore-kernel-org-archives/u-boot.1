Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5D606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GVOszno7;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=rUCN70R/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78E9B60F5E;
	Fri, 13 Nov 2026 02:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSFc-gjRTC0n; Fri, 13 Nov 2026 02:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E79BE60E68
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537297;
	b=KgVnTejEF8QaQYbtx9H1pn6FF8JcbEUgAR8+pkhUpZXJXYlSsgwpRyNcFO/SpX06AI4W
	 OMgp4+bq0zBQWsbANiF1nEdqOlZj5GJIDM0O3c7nlKfT7tnERhL1XyT1JWfqO4Eoc7tzZ
	 jPDka2VKDU80+UvHpA2F8spdLnxky28fTXYv4KUXXFe2fONAuso207snFnAX2XkzbYihS
	 Lv8hDAgY9jOuyTx/hZk3lYsfquw3epyqMSpemaiGPdNOzqvzHLVQ43djNj4UutTxwQ3/H
	 pgTF4qpyPZqZCrETsmJiXu+NrEy0zzI2PfcZxa8QR2ApL+YWYmFKul2a6AAfKsST5Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+Et0zpcTWeD2vdbeyDdR/N40k0elNDE2Y5ce4+DIZn4=;
	b=HmZ1teuMt5hVpNOQy4qBfd9QIstwXrTvVgSbGTpDsNLb8TB0iMfm/0ZmfDtVXnXWAgaW
	 Vsn/kgWX4uxvz3VocB0lcQzXKLCmwlNn1ouO6Lzl9OHB4O8M6TzJCbfEjyD9R78S90IHJ
	 c1fAnK3xObVNHyKufXvQLSrag4lqi+Yfi0B+h/hPc9GsuUJ3TDQrksy9P1vzt7rv8p5aa
	 0sYECz09uUTN33SPFM5wIQKPE8ksJtrLWltkTR93h8H0dpEbgGjAQAVW0G4Grdttjxb0c
	 LViR9BoWSqAiPm5jPNNlBnsRPBnGR0A+hCES96i3BIS7u7Fy/6OWnzfatbiqIfb86dw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537297;
	bh=+Et0zpcTWeD2vdbeyDdR/N40k0elNDE2Y5ce4+DIZn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GVOszno7mONY7ZCSYADPYN6n9ZEQeeluHDrmzxH8LyPHXwngV/gNS2U1JC4SHRdpr
	 ME9gXybjQXkC5upDRDxjc3EEvKgL/Oy1+Km2L1TNgjZZ89HDAVO1QomPhFICsbuHaw
	 8XJxYdVfgYITts07lG0rcvxiTXwUGmw4E+JU0dm6v6yB+YIGhTUsX9zx0cDDQ0UZ7J
	 Uo3Ar9nmNPVlrumGKnyiUTkUq0x0J3kTcXf4A25Nk161A/McfyL5SFHIEGCHRK/wVC
	 wWrtVmFxlGsJLos6tUV9bs4mJlCZdy8RVCb8KYPiHqZgX3ylACF83q/8fFetScw2+x
	 3oLgQ7+OwxfqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E79BE60E68;
	Fri, 13 Nov 2026 02:34:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 819622FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7361240D9B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbCnmNSAk4jc for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C03D740D7C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=rUCN70R/
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C03D740D7C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:54 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 3EA364C8C9;
 Fri, 13 Nov 2026 13:34:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Et0zpcTWeD2vdbeyDdR/N40k0elNDE2Y5ce4+DIZn4=;
 b=rUCN70R/FsNV4flBJqva1C/mmZ/Vvr2a8B3noRd/lupuik4SIln2xdTQP5n4Jl+FT2/+Yu
 4VW+v9t9rZo1QnW2dUefpUk3M5JYxas4kAPkqVMcdblxxsvBmnADZGpdMBpLN7NGY2aHhl
 F8isuAP2+UXp2Qou/0GFs1AN4bp0KK8Kx/DD0dWg3+Qgf41QvLP005FCreeZOxlSQtkwNo
 nilbOndVRb8trRos1z8a4M75PYI4xwdMiVkmJOAlE5G92NvPSLZqk2KtUQre+SL01KHN7f
 UqPwqpArAigAk73yt/Hnhzf6hiO0g91KiCHSKrk0/O5a7a/uf4PWHXLlBjeFmg==
X-GPT-Reason: This email is classified as legitimate personal
 or business correspondence. The content is a technical software
 patch description (adding NVMe boot targets) which aligns perfectly
 with the sender's identity (Alastair D'Silva) and the recipient's
 mailbox (alastair@d-silva.org). There are no signs of phishing,
 urgency, or marketing; the message contains a standard "Signed-off-by" footer,
 no external links, and the From/Return-Path domains match the intended
 mailbox.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 24/26] sunxi: Add NVMe to distro boot targets
Date: Fri, 13 Nov 2026 13:32:34 +1100
Message-ID: <20261113023236.569054-25-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add BOOT_TARGET_DEVICES_NVME to BOOT_TARGET_DEVICES in sunxi-common.h
guarded by #ifdef CONFIG_NVME so sunxi boards with PCIe/NVMe enabled
automatically probe and boot from NVMe devices.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 include/configs/sunxi-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index 49d5617f028..3d3413fab02 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -184,6 +184,12 @@
 #define BOOT_TARGET_DEVICES_MMC(func)
 #endif
 
+#ifdef CONFIG_NVME
+#define BOOT_TARGET_DEVICES_NVME(func) func(NVME, nvme, 0)
+#else
+#define BOOT_TARGET_DEVICES_NVME(func)
+#endif
+
 #ifdef CONFIG_AHCI
 #define BOOT_TARGET_DEVICES_SCSI(func) func(SCSI, scsi, 0)
 #else
@@ -221,6 +227,7 @@
 #define BOOT_TARGET_DEVICES(func) \
 	func(FEL, fel, na) \
 	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_NVME(func) \
 	BOOT_TARGET_DEVICES_SCSI(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
-- 
2.53.0

