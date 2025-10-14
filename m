Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF8CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC107831A4;
	Tue, 14 Oct 2025 13:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="lWXOZtao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD05B831A4; Tue, 14 Oct 2025 13:56:30 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster4-host2-snip4-10.eps.apple.com [57.103.69.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C463D8206E
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 2A092180B870; Tue, 14 Oct 2025 11:56:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=B4vcHzKeAOsP4uUGgDl3QqMX2TStIQmPn81DdZV3vpM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=lWXOZtao1Y9twyPEoWzNM3zFx4/UDdmFm5KauQhFX3ZHp3Yvl9JUmub1FLbu1XDR8ugHqewxN+MzOJL0wxVJYkVLhyFhMcK+5unHmiACf8RM6QRegQYkWUTUMHS23HDm8poUp5PeJX/A6gZ/KXa13EAiNOvT6bSn/8+OfomCVBa8SES5y0bpIU13y5Se7GfBVUZ9bbGAi4fd6ki3etvld0TJ5jQTf4qGyk0mT0WhcsQVG8jNrQPhoWauVOwCGsu2hwfruNviUvZJLIIg9aTmqexWPqHzdp85tscuRKc7Gxa40k2smBZw14fbeXkcwcr3Ig07LvvHbxaLDNi8xFgXDQ==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 2C3EB180019F; Tue, 14 Oct 2025 11:56:22 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>
Subject: [PATCH v2 2/4] doc: bindings: use upstream bindings for aquantia phy
Date: Tue, 14 Oct 2025 19:53:58 +0800
Message-ID: <20251014115604.194150-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014115604.194150-1-root@infi.wang>
References: <20251014115604.194150-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _ukTIfJWC6g0BWq74d8LX7vldVTuM10_
X-Proofpoint-GUID: _ukTIfJWC6g0BWq74d8LX7vldVTuM10_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5MyBTYWx0ZWRfX2jgxD3H5Uc3s
 fRPg5DmxgZQAYYUddjt7l6gosne5y5Lif0QBMMsmJ+UOAZJQpB5fEQoYUyp3sqwTY0YdHkHAVT4
 k3rNbVS7+OwuxCYrbkO6d/eXRBQqs+g0ROtF4FlsmvteMHXyx4FF0NxwP522N6pTricUNSplykE
 Ch4Y1dOYoNmBgv1SZx63FQBXRWSkMY+LUsYrQnmdpuqT7JTryB3ZbbesiBLjK1ezuYNCuxqabLa
 CC/222ZbeVZAH2b1LGHzB8qbbLwrjqAggU9SS/OmADLFeWc1DTQJNojFqJuqOlzZAJmnA52mE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=943 bulkscore=0 clxscore=1030 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510140093
X-JNJ: AAAAAAABbtGxa1EXpJOA5xIN0+wyN56C9UBOU3CRfdY6jhdRnVkxWCie32jwHQyUOprhx/cbtlc3SQEj0jhhDjSDCEr7bwmPlM2cFgTTcv+cCd5xj2PQKmeQc/RS7bGTwuVW7rg38xMQwCKFLKXLeqDW3TqhEc7lNg9lgClKkGebHj5RE42a6KrKPFkghsGW8NdrFNfyacKEJyj0MLg4/SxPIuTcHQ95UDO0nlsa9qnnP9tNbOLKn/VZZ+Xd76FKZqJ6I6gci5ScqZDwtc/eyMu0uH5Tr3Fw/ZRuMkXOC2ooXHczTAmhQiVDvVYTi0NSmOGR4Kh7voQk7o7vAXK15/rEcJZsFBByXp7QvvKvSuTewQL8OLnJz2JmItIRBYH6lbm/J5RdorNbE0Ru9+1PqeNsqsOpFaL5+ROAEEXhDe/L+FV+2IAJCaWmXU7tHcN9bUVQGcrtUMxPHkSh6nFpHaDC6MQS3o/4GZgAagrMu3MivmEOwh0dyrbUV0fMLcadyMNzV1Dq2r4wokC/xtiERQN8F3iczIE5MDoJc6DvyLLFZVAccj8u5PRqRlVidLE44DM1B4fpsmG6mR/7ex/F3tiDOOrnGLMJG7WhR9EoXo0=
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

Prepare for the switch to upstream bindings and generic firmware loader,
remove reference to upstreamed bindings, also add a firmware-name example.

Signed-off-by: Beiyan Yun <root@infi.wang>

---

Changes in v2:
- New

 doc/device-tree-bindings/net/aquantia-phy.txt | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
index 89ce61e05bb..80de0e8b158 100644
--- a/doc/device-tree-bindings/net/aquantia-phy.txt
+++ b/doc/device-tree-bindings/net/aquantia-phy.txt
@@ -1,25 +1,16 @@
 PHY nodes for Aquantia devices.
 
 This text describes properties that are applicable to Aquantia PHY nodes in
-addition to the bindings in phy.txt.
-
-Aquantia PHYs allow some flexibility in the way they are wired in a system,
-they allow MDI pins to be reversed, LEDs linked up in different weays, have an
-I2C slave interface that can be used for debug.  Normally the configuration
-corresponding to these is driven by the PHY firmware with the downside that
-a custom firmware is needed for each integration of a PHY.
-Several optional bindings are defined that allow these configuration points to
-be driven by the PHY driver and reduce dependency on specific FW versions.
+addition to the bindings in upstream and phy.txt.
 
 Optional properties:
-mdi-reversal: 0 or 1 indicating that reversal must be disabled/enabled.
-              Firmware default is used if the property is missing.
 smb-addr:     I2C/SMBus address to use, firmware default is used if the property
               is missing.
 
 Example node:
 phy@00 {
 	reg = <0x00>;
-	mdi-reversal = <1>;
+	marvell,mdi-cfg-order = <1>;
 	smb-addr = <0x25>;
+	firmware-name = "aqr-firmware.cld";
 };
-- 
2.47.3

