Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4817FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69B48852D;
	Fri, 21 Jun 2024 21:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LVs6mJx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B67287D10; Fri, 21 Jun 2024 21:52:16 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1850188548
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb7c8f114eso93295439f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999532; x=1719604332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naDgqdu7mW2Mx9lFuVgEdvG4UimeXe7WE+sb4FUcbww=;
 b=LVs6mJx8DZTFPB6rF7VzirEQK5pyqVMY5EWF7Z8n8RKz/XeRLtH5/bPOFezCmonTAq
 JYlPKoKYzLbvngwV6USJmD1pS5s6IPW6y9jpYwPVi4FKYlwNqR4ZiW9+ZqFtf7Q3SYOK
 ztxyCnAyLrtbMIq9/37mH8/wXUmsed4Rc0A6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999532; x=1719604332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naDgqdu7mW2Mx9lFuVgEdvG4UimeXe7WE+sb4FUcbww=;
 b=wavSKiZq/WnBnQQYyWH2RylSO4Aw0iK14eBE9zbNPxW+NEaxL7Ezjf8uLSEm/2r3OX
 9Eg3XJdAUZJAoO1L8dATjR4eocnzRVKRmGrkryFC12BeIrOPoQF+0slNMwGWowNtC7de
 nwdKUJrZCENxdJ8B7cvbuC5EQQYeGwozZS7LwD8d0xuMDtxIf0bhziCLZV9siU79elBU
 y26xS/ucOIKcLkVsd7zE7gEC92gwBNV/YlJFiSX0JMYzcW+YNVHmn6BC5StefShgCs3Y
 f94qX0BrnlBzadXW8BnbXFHgPrMyEfhGH6IEH1ir9MCoge7nc4ePl65lNuTYfdWuITU1
 GWlw==
X-Gm-Message-State: AOJu0Ywd84ShIf3A+EwqMyx2qnpJ9VzAXjbRND38/7bpO97IojPWLAtd
 zyN/ZsHpgncmqWSVjGrtzaUkL++8dHe8/zhu0B70RDj1uzK2JcSfESgU0K6EW6LkE9yqGgdDd5P
 aug==
X-Google-Smtp-Source: AGHT+IGNhYPze0Iq5f8USet+0E0ADWbNT1RpwiyPBBZXsNaeQL5kLWrtWEWNWe+2i1m3E+2axtw3qA==
X-Received: by 2002:a05:6602:15c9:b0:7eb:906e:e3ee with SMTP id
 ca18e2360f4ac-7f13ee5c07dmr1090150039f.12.1718999532672; 
 Fri, 21 Jun 2024 12:52:12 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 03/43] binman: Regenerate nxp docs
Date: Fri, 21 Jun 2024 13:51:24 -0600
Message-Id: <20240621195204.2675252-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

Regenerate the entries.rst file to include this recent addition.

Note that more docs are needed here, to actually describe the entry
type.

Note also that the entry type needs Binman tests added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entries.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 531a92e2e0c..ecccf77d112 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1528,6 +1528,28 @@ byte.
 
 
 
+.. _etype_nxp_imx8mcst:
+
+Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
+-----------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,loader-address - loader address (SPL text base)
+
+
+
+.. _etype_nxp_imx8mimage:
+
+Entry: nxp-imx8mimage: NXP i.MX8M imx8mimage .cfg file generator and mkimage invoker
+------------------------------------------------------------------------------------
+
+Properties / Entry arguments:
+    - nxp,boot-from - device to boot from (e.g. 'sd')
+    - nxp,loader-address - loader address (SPL text base)
+    - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
-- 
2.34.1

