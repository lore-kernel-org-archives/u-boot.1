Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F1BE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A658060C;
	Sat, 11 Jan 2025 01:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y7io709c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119C58077F; Sat, 11 Jan 2025 01:01:58 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76F280785
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso16748095ab.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553714; x=1737158514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLNpEHbXDFYER1Eoo5giPZH0piO6CUmHZPZQWcsggRM=;
 b=Y7io709cvfsSRDgd5YjnzCRZilssHrhpKxGh2a78L1R4lP/XrAS0Bywui8xehybu49
 8tcTiBGsfnSYutqHTlcVqSWpYqg1DalGyVuCYhE9fpo28kS8UUKHE/VD5w12r91NAbd+
 I8sWNFUGtALrTZjBb1lqo8CH3Q/Lcl3djay2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553714; x=1737158514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLNpEHbXDFYER1Eoo5giPZH0piO6CUmHZPZQWcsggRM=;
 b=fijou+Owq/XDaIHyl0no1s4V2dktpiTlH+4+OXJyRehG/EhhB+/4qosly5+z58wcxO
 V94VzqEZru4e5wk9B+2A+uNjABeR8uv2aQ2fdH7pql+UGQndnM+5AMuqKEmPSzfEGw9f
 bMKEx051mmdC7kr/ROLXZReFjwHj5kQT7562BQ2unoEBa7WSsPgjnYmRzxmFj+xryZKp
 MciwRWASjUn6uNvOmf4EblByr53dlEtZua5kualVDqd8cIEz4JIlQ2JEzr6Macn4bjBU
 zfclAIDrgS+oVS5KaQAiaAZFE5yxLzxfpGBrPhLVcyxOUcGmEoHqV1cL1A5J+jbvsonN
 /lQQ==
X-Gm-Message-State: AOJu0Yxhmh0uygkMWwMK+LkinLW8Rwpw6nmo50zq+3fKeqA+mBgkaYw4
 v6VjgKV2Vf6CVO7VPOS8YS8ymHiO/L+csOqZfYN3ct7PIBN9cVRdXAZDy8FTcbuU4npWFfo5h/M
 =
X-Gm-Gg: ASbGncu1EWGsZ1Guuche+xKDToMEYfYfGDZ2MAdUH2pdqdtzs5CjR0xpqVJKjsiWO77
 qdJhlVAabqQ3INfD9cJoUw5McpKWJolz+caF4IoKnRocQF/lwVY/zdM7jOOztU7OaCFqp+stEJe
 fCnBU8fD1OLubKW8CCMQ+0LiucSdfbsqZbc2ZRkZyRCew5I3wHECmi5Wn/euEqFusBSQ4cHLwUu
 M+V+yiihNirra0vBdGFw+orrIBzCdw1PCkwBeRslV9b3vKsJnQMamlBrjPZVOmxQiFu4k6s8Iu4
 xaNh4Hrbsftv5IXS1A==
X-Google-Smtp-Source: AGHT+IEl2BkcP25kcOfdZMfRGJ6v2qJygvl6DwJ8+nzVJHwLrhVjI+Bs4qwYQTVfpSqd1P1JImhd8Q==
X-Received: by 2002:a05:6e02:160e:b0:3a7:e732:471b with SMTP id
 e9e14a558f8ab-3ce3a88ace0mr95913565ab.11.1736553714014; 
 Fri, 10 Jan 2025 16:01:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 28/30] dm: core: Clarify behaviour of ofnode_name_eq()
Date: Fri, 10 Jan 2025 17:00:27 -0700
Message-Id: <20250111000029.245022-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

