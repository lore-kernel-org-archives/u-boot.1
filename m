Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D48FE784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 12:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD5CB86DDA;
	Mon,  2 Oct 2023 14:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="o1TnmgcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E499A86DC5; Mon,  2 Oct 2023 14:43:00 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440F386DA2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so25126285e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696250576; x=1696855376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOskK65F9KaiM3oNZzN9ukBgXN6DMDb9L5SWpkUBrqY=;
 b=o1TnmgcQytLNtDvr+qTM9f5+pupIOsWmxdAuH1vIcwsEw1c6KCDK7RzfjWlHbf2Rmh
 2M7uWNclj3PKxSCRfCjg0g07pl9YZN4WeyxyjaPpGkxJMhzaH4bR7hgvSsEuVkuceCmk
 DR8OyFVuP/EAYbcrLRygDTikDLUDT687Fq8i3vPUoTH84WLuP8JOZnsUjL8+WdP+rTJL
 dgN86gnnA3sSsswhA4sfvZ25oEs928InRRtvtME5xTB34PKMNzFV2fbxBJkgvLhKMSdj
 JC2w8SOVnEsk2Mh4TFpsvO7Hd0pS2pKTCaKXQ9YNwUWYPIPVD8NOnTwfErciORmxTTXy
 BM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250576; x=1696855376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOskK65F9KaiM3oNZzN9ukBgXN6DMDb9L5SWpkUBrqY=;
 b=iMGH80F+z/Gh/nytn4F3Lb1HpAy03ynhoofjR/yb2zgbZMViAUNMkoGs9aorN8NgeR
 /HMPhX0JcXecIcq/9RdRRXC5KnW+3pY7qqHHXomSOaeTo/5ZyDQlOJmD1/wdGVJHQn6z
 bwJcfELj8aHau9OiG/gObyL0ZUseMLzr4Wcf8dQ7QJRR95oAQts75HjBv2p9i2wZuYu2
 JKHA1nAFzQ+pf+fQi+j0V49lhl51KRudiZUcZ2x6HTnsd7WXs6KG5pqtXncn/wPa6HHH
 YCyHwvryiCaMxqaFfUY2iZcCfKk1Sy33jNUqDoiDQX/wz3EU7ZoLOeVoEN1V+QtPtqFG
 ReUQ==
X-Gm-Message-State: AOJu0Yz+kAMtCzJwK4xAypuRbEWYVlj86alAjGCgFRs6UAAzmOxjCjCU
 6Utcdqb3KRhDPkPHbos+ihhvXxHIuYkmf8MNqZ7xrQ==
X-Google-Smtp-Source: AGHT+IF/CWz3q8QuX/o9m9sFmJRk4FRmMk5qGZUfRvnRd7HSXntGYW3tptDwXVENv6UQ98ROaR6peg==
X-Received: by 2002:a19:911e:0:b0:4fb:9f93:365f with SMTP id
 t30-20020a19911e000000b004fb9f93365fmr9436545lfd.38.1696250576426; 
 Mon, 02 Oct 2023 05:42:56 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 e8-20020ac25468000000b004faa2de9877sm4719316lfn.286.2023.10.02.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 05:42:56 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 2/4] cmd: tlv_eeprom: Add support for do_mac() command
Date: Mon,  2 Oct 2023 14:42:15 +0200
Message-ID: <20231002124217.68220-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002124217.68220-1-artur@conclusive.pl>
References: <20231002124217.68220-1-artur@conclusive.pl>
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

The existing mac_read_from_eeprom() is supposed to be used in
conjunction with CONFIG_ID_EEPROM=y. However, when this config option is
enabled, it also expects the do_mac() command to be implemented.

Provide tlv_eeprom's implementation of the do_mac() command. At this
point only the "read" option is supported.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v3: new patch

 cmd/tlv_eeprom.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 9aa9b070473e..3e9972e506b6 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -1088,6 +1088,57 @@ int mac_read_from_eeprom(void)
 	return 0;
 }
 
+#if defined(CONFIG_ID_EEPROM)
+int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct tlvinfo_tlv *eeprom_tlv;
+	int i, eeprom_index, maccount, devnum = 0;
+	u8 macbase[6], *octet_p;
+
+	/* Only the "read" command supported for now. */
+	if (argc > 1 && strcmp(argv[1], "read")) {
+		printf("\"%s\" command not supported\n", argv[1]);
+		return 0;
+	}
+
+	if (read_eeprom(devnum, eeprom))
+		return 0;
+
+	maccount = 1;
+	if (tlvinfo_find_tlv(eeprom, TLV_CODE_MAC_SIZE, &eeprom_index)) {
+		eeprom_tlv = to_entry(&eeprom[eeprom_index]);
+		maccount = (eeprom_tlv->value[0] << 8) | eeprom_tlv->value[1];
+	}
+
+	memcpy(macbase, "\0\0\0\0\0\0", 6);
+	if (tlvinfo_find_tlv(eeprom, TLV_CODE_MAC_BASE, &eeprom_index)) {
+		eeprom_tlv = to_entry(&eeprom[eeprom_index]);
+		memcpy(macbase, eeprom_tlv->value, 6);
+	}
+
+	if (!is_valid_ethaddr(macbase))
+		return 0;
+
+	for (i = 0; i < maccount; i++) {
+		printf("EEPROM MAC Address #%d: %02X:%02X:%02X:%02X:%02X:%02X\n",
+		       i, macbase[0], macbase[1], macbase[2], macbase[3],
+		       macbase[4], macbase[5]);
+
+		/* Increment next MAC address. */
+		for (octet_p = &macbase[5]; ++*octet_p == 0; octet_p--) {
+			if (octet_p == &macbase[3]) {
+				macbase[2] = 0;
+				macbase[1] = 0;
+				macbase[0] = 0;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static int populate_serial_number(int devnum)
 {
 	char serialstr[257];
-- 
2.42.0

