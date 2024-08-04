Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C3BC3DA7F
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 15:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C65887B4;
	Sun,  4 Aug 2024 17:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MLg266tO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA30A88804; Sun,  4 Aug 2024 17:06:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09D288785
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722783967; bh=HXbg5HlfezBWQ2sWwBCWPhKuTAbQ0Ax6fszCBReCcSE=;
 b=MLg266tORultfbnypNk2SS2ubiLXbBCN9iyrHv/DZ2nT//xglTNIIQcRh2xrsU6tgWfXyrlM9
 0ZIrVH78pudIIqs7PazebOpFPtT7L91eGa2yrzTIc4AotrK8PRSLovsVP+JGWhRDWUwFDnjKD6Q
 CcOkR2Qs0DfBvS28odAX0QFbpJklXL52fdHHDhjjq/mkow5kA+4gcUfieti9Ak66zsBpMZHN4wR
 c5DnsOM8JRIQOxH90baQ77iLFzTU3eXKYqQZjOj6GMw1QS+pEpPuHlDTvykOfesIqZzysF8YMGV
 JVK/uhNfSXFat709Gkt8k5WoJQWWRQNsrvhZN3U2VeNg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] dm: core: ofnode: Avoid multiple calls to
 ofnode_get_parent()
Date: Sun,  4 Aug 2024 15:05:50 +0000
Message-ID: <20240804150556.3519995-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804150556.3519995-1-jonas@kwiboo.se>
References: <20240804150556.3519995-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66af98deb04314fb234e2fae
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

Until a live tree is used in U-Boot proper after relocation, use of
ofnode_get_parent() will trigger a call to the very expensive
fdt_parent_offset() as detailed by the function documentation:

  NOTE: This function is expensive, as it must scan the device tree
  structure from the start to nodeoffset, *twice*.

Re-use the returned value from a single call instead of having to make
multiple calls for same node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/core/ofnode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 4d563b47a5a3..7e3b3719d18f 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -762,8 +762,9 @@ static fdt_addr_t __ofnode_get_addr_size_index(ofnode node, int index,
 			return of_read_number(prop_val, na);
 		}
 	} else {
-		na = ofnode_read_simple_addr_cells(ofnode_get_parent(node));
-		ns = ofnode_read_simple_size_cells(ofnode_get_parent(node));
+		ofnode parent = ofnode_get_parent(node);
+		na = ofnode_read_simple_addr_cells(parent);
+		ns = ofnode_read_simple_size_cells(parent);
 		return fdtdec_get_addr_size_fixed(ofnode_to_fdt(node),
 						  ofnode_to_offset(node), "reg",
 						  index, na, ns, size,
-- 
2.45.2

