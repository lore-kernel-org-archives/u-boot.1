Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0DCE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A8C8071F;
	Mon,  6 Jan 2025 15:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FhR1Iwbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822B28056D; Mon,  6 Jan 2025 15:34:09 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3EF8070B
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a8f1c97ef1so50801605ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174045; x=1736778845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLNpEHbXDFYER1Eoo5giPZH0piO6CUmHZPZQWcsggRM=;
 b=FhR1Iwbm+rGpYxwvEo219TUndMDZa4lXUgmIVBPfoWKPEjiwy0vUDkCKNtBej/nN2Q
 mDxCOCBClq1pFhNa2o8smcSzbIWe5gqramHVvnMGZUFIit/EAfYWdLDzux11mWVcI00u
 tYE6frKzCnbNo8iv0njMlLXTJlG7z+S37UkRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174045; x=1736778845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLNpEHbXDFYER1Eoo5giPZH0piO6CUmHZPZQWcsggRM=;
 b=XerYd7ca3cdBlorlh+aW00YfNbgWYEvJvYhNsI6z2USD2ZKhTrWQbn7UjAs6qfRvva
 OvOCiavhkU3FLk3NDrBRR9y2kBqtLFabwDkhD0CSm0SLSEc9hYQ4n2f/R0w4Mk2KRqPl
 mBULkKKSVd6GExlvyxMWiI1UnWwRzcnhYSWhFJomall8maczUwixcJmOm6L1DF1e/V/w
 VDRUu4ceyCaA7IaizRokBPZjABre4fzx9yPV1xnplAw/Q3adrNv5T2pbjSjMrPkVOkwS
 zeIf6qIvYcJOLtD3T4FNG14w+w/+AyT6BOeHyPDmG464NgmaeHveq6KaOZU8aK8HLfHZ
 e9nA==
X-Gm-Message-State: AOJu0Yz3s22Vo/r3uUkLcq/1IYBEDuWQ5+jhAvsftak8iRRguXclGq7r
 QauMbEa+zY+Xvyy0zwC2ejnxUEhOpX+4qrOttxjmA6fRZh8++bt1tg//rFmsLhbWoltbAEwczIU
 =
X-Gm-Gg: ASbGncsFfE9q5KtbM8Vg2Dt7kC1aoywvV6m9OB/hcQ7hGeqR1aaB2Q7fdKMed8IVvyM
 wGqsF9ZiZDu10NplOREh6R4/uDhslQgtgWQ2jXNlre+U4dknPXrHObanlcKFEx0Yji4Udi0LFa2
 fm4h2fLOxgqtTFy+qgXspDXgx/vmeoSGuTbXGTnHYXmPvnAf+o8rirRBX/I4OtQSv2TLisNUEUv
 I2qSSgC50zSlq1vsXDL3SetI3wKjtYgXXbUmvscvcw2niJgBtUz2P2FD6Ea2NYoCcdo7eDKuf+e
 TlhBnrrfHzGqnmKqlQ==
X-Google-Smtp-Source: AGHT+IE3Zuc6Ozr+yNsrzZCHeyO2PO7SR8btHgCigTLtwuebncpKIotDaB5vkqnuqxZ1Ni5WeDMjBw==
X-Received: by 2002:a05:6e02:3b84:b0:3a7:bcbf:ba99 with SMTP id
 e9e14a558f8ab-3c2d2272e92mr533118965ab.6.1736174045398; 
 Mon, 06 Jan 2025 06:34:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:34:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 31/33] dm: core: Clarify behaviour of ofnode_name_eq()
Date: Mon,  6 Jan 2025 07:32:27 -0700
Message-Id: <20250106143229.3023771-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

This function is somewhat ambiguous, so expand the comments and add a
test for the undefined behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/dm/ofnode.h | 7 +++----
 test/dm/core.c      | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 024ae4cd289..6d6a6fef8ef 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -386,11 +386,10 @@ static inline oftree oftree_from_np(struct device_node *root)
 void oftree_dispose(oftree tree);
 
 /**
- * ofnode_name_eq() - Check if the node name is equivalent to a given name
- *                    ignoring the unit address
+ * ofnode_name_eq() - Check a node name ignoring its unit address
  *
- * @node:	valid node reference that has to be compared
- * @name:	name that has to be compared with the node name
+ * @node:	valid node to compared, which may have a unit address
+ * @name:	name (without unit address) to compare with the node name
  * Return: true if matches, false if it doesn't match
  */
 bool ofnode_name_eq(ofnode node, const char *name);
diff --git a/test/dm/core.c b/test/dm/core.c
index c59ffc6f611..d40916ef588 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -186,6 +186,8 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assert(ofnode_name_eq(node, "mmio-bus"));
 
+	ut_assert(!ofnode_name_eq(node, "mmio-bus@0"));
+
 	return 0;
 }
 DM_TEST(dm_test_compare_node_name, UTF_SCAN_PDATA);
-- 
2.34.1

