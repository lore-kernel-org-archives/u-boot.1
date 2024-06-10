Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB1C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D6E885C8;
	Mon, 10 Jun 2024 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IiC25k3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16F78859A; Mon, 10 Jun 2024 15:34:16 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E38188556
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026451; x=1720618451;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nUPnZpMRXSZt76LS3PxvgZx6I+TZRWYpCup44UvBlIE=;
 b=IiC25k3qgNSV78Du4WOwvL8ade7TCLHIsvhXJqTRuE0OdBw/O+QUknnBMC/aoZ2A
 58i9OBaD9rKxTskijlI9kyn8V6NaF7ATRy3b4tsnF1zCsLS3UFn+nUlEsT9Uty0T
 KcV9oW2PBoMsM4qV9lcvyfKFg+0yIIhRcypNzDFMRqI=;
X-AuditID: ac14000a-03e52700000021bc-ef-666700d30f7e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C8.7D.08636.3D007666;
 Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 11/13] doc: board: phytec: phycore-am62x: Add USB DFU switch
 config
Date: Mon, 10 Jun 2024 15:33:50 +0200
Message-ID: <20240610133352.2473414-12-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWyRpKBR/cyQ3qawalvXBYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 ODrjAVPBW5aK7b8nsDYwfmDuYuTkkBAwkXj18RqQzcUhJLCESeLRzZtsEM5jRonfjU+YQKrY
 BNQl7mz4xgpiiwgESfRe+sQIYjMLeEhs/bsBLC4sECxxdOIFFhCbRUBV4kjnJbAaXgEriVWr
 /7NDbJOXmHnpO5jNCRT/sWYvWK+QgKXEok9rWCDqBSVOznzCAjFfXqJ562xmCFtC4uCLF8wQ
 9fISLy4tZ4GZOe3ca6hvQiW2ftnONIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUl
 qcl6KambGEEhL8LAtYOxb47HIUYmDsZDjBIczEoivEIZyWlCvCmJlVWpRfnxRaU5qcWHGKU5
 WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGLfzps61X+od7/CvfuMdxh8GtRqFj+bufPPN
 dk6ZWAnHwv6nsxZ9+eX1deLutns5560Ky/osw3lWmpqwFlXMbF596kZxj6Koxqr83PjrshcV
 DPv6ReW63hc+/yFp8KjnwuepeqeePmn+uSZq4Y+dmd4OU+Qy94bclrm9pjcq17L1huSy11eS
 s5VYijMSDbWYi4oTATu+L7dnAgAA
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

Provide boot switch config for USB DFU boot.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/phycore-am62x.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index bc6d5246694..f8870657be0 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -151,6 +151,10 @@ Boot switches should be changed with power off.
      - 11011100
      - 00000000
 
+   * - USB DFU
+     - 11001010
+     - 00100000
+
 Further Information
 -------------------
 
-- 
2.34.1

