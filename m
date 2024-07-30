Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D96C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 11:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9331887FF;
	Tue, 30 Jul 2024 13:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98C26887E8; Tue, 30 Jul 2024 13:11:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8F3468780A
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96BCD1007;
 Tue, 30 Jul 2024 04:12:20 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE663F5A1;
 Tue, 30 Jul 2024 04:11:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/5] linux: list: add a function to count list nodes
Date: Tue, 30 Jul 2024 16:41:28 +0530
Message-Id: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add a function to count the nodes of a list.

Taken from linux 6.11-rc1 tag commit 8400291e289e.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/linux/list.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 6910721c00..0f9d939b05 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -547,6 +547,21 @@ static inline void list_splice_tail_init(struct list_head *list,
 	     &pos->member != (head);					\
 	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
 
+/**
+ * list_count_nodes - count nodes in the list
+ * @head:	the head for your list.
+ */
+static inline size_t list_count_nodes(struct list_head *head)
+{
+	struct list_head *pos;
+	size_t count = 0;
+
+	list_for_each(pos, head)
+		count++;
+
+	return count;
+}
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
-- 
2.34.1

