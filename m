Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD639C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3F5889DA;
	Wed, 14 Aug 2024 13:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2257F889B8; Wed, 14 Aug 2024 13:00:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 68C2D889BA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A47A5DA7;
 Wed, 14 Aug 2024 04:01:02 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305233F58B;
 Wed, 14 Aug 2024 04:00:31 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 01/32] alist: add a helper to check if the list is full
Date: Wed, 14 Aug 2024 16:29:38 +0530
Message-Id: <20240814110009.45310-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

Add a helper function to check if the alist is full. This can then be
used to extend the alist.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Do away with the alist_empty() function, as it is no longer needed

 include/alist.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/alist.h b/include/alist.h
index 586a1efa5c..68d268f01a 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -82,6 +82,17 @@ static inline bool alist_err(struct alist *lst)
 	return lst->flags & ALISTF_FAIL;
 }
 
+/**
+ * alist_full() - Check if the alist is full
+ *
+ * @lst: List to check
+ * Return: true if full, false otherwise
+ */
+static inline bool alist_full(struct alist *lst)
+{
+	return lst->count == lst->alloc;
+}
+
 /**
  * alist_get_ptr() - Get the value of a pointer
  *
-- 
2.34.1

