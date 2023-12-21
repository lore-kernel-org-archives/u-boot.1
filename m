Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99B2C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F41876A6;
	Thu, 21 Dec 2023 11:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RCN79fIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9AD87854; Thu, 21 Dec 2023 11:50:35 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB36987834
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1986541666; 
 Thu, 21 Dec 2023 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703155832;
 bh=FzVtfuNl6sKC4C9Lx9gIRfG2hv2oJlhazRW59iwjF6Y=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=RCN79fIO6Uu6MDvYGpK8oP3GkAMisz+TEZGQ3SAvy5w/DiALJ/Fgk/dYzV/7+1zqS
 T+Cavr4ZLFr2+PwCnzMYn0rzo4SeH65euRNPo9XnG1fT86/sjoP6fNCkuoOYQyQIby
 LOYpjikZpHYM+n1+cYl4ti1zupKW/WFb3sH/gRP+s+L+QChTvkuyjwzNcITZ2sLjIp
 biKBtVR5ww6Up+gfWgr0yh3rCoApWS5nL242WYgbsRcN5PJRVM75CYCB41KFSp6ShG
 oiftroy/7EcA/v9fQy8+H/f0p/4VYBnwvRba17N3Q9NTIsQZISbf+iG+W/glmnAsOK
 62rNNlIHMtdMg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
Date: Thu, 21 Dec 2023 11:50:16 +0100
Message-Id: <20231221105017.6895-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
References: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
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

Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/smbios.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index c9df2706f5..e601283d29 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -54,6 +54,32 @@ struct __packed smbios_entry {
 	u8 bcd_rev;
 };
 
+/**
+ * struct smbios3_entry - SMBIOS 3.0 (64-bit) Entry Point structure
+ */
+struct __packed smbios3_entry {
+	/** @anchor: anchor string */
+	u8 anchor[5];
+	/** @checksum: checksum of the entry point structure */
+	u8 checksum;
+	/** @length: length of the entry point structure */
+	u8 length;
+	/** @major_ver: major version of the SMBIOS specification */
+	u8 major_ver;
+	/** @minor_ver: minor version of the SMBIOS specification */
+	u8 minor_ver;
+	/** @docrev: revision of the SMBIOS specification */
+	u8 doc_rev;
+	/** @entry_point_rev: revision of the entry point structure */
+	u8 entry_point_rev;
+	/** @reserved: reserved */
+	u8 reserved;
+	/** maximum size of SMBIOS table */
+	u32 max_struct_size;
+	/** @struct_table_address: 64-bit physical starting address */
+	u64 struct_table_address;
+};
+
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
-- 
2.40.1

