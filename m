Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823AC02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D158D80C67;
	Wed, 29 Jan 2025 23:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zBRAvKn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E8A80C69; Wed, 29 Jan 2025 23:37:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C291E81F69
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738190218; bh=820QW0A6oQZ8PRk4GXhTAT53GgYhbgbrcyS8DUYFUoo=;
 b=zBRAvKn9Le/3YCPDj4MTea00UKZ04vYpyv86NeKzq0BWbAdkgllhdEvXd9HAoc4X5/KDMd4K7
 pJv7GZBqXaEDe9UACM70eHPlnbOjf7EaHq0r1IE2r86lc9biqWmbRAHVajYgg+rDEWOleLWfEFu
 IKw86bQVWc2xePrS8zkxbyyQVh2JZ4KZ9uuLyY0LgVA9nYeCwpMdhFdze8NxTkR6beEqUnyQ6s+
 5PowJX9WTdweXBeFoWgXpQ4psJMypi2QhDwVl5q6fA40tzYvyMMFzRhNczQ1OyWJ51otnQq1COx
 hc5DkiSxzrepUbnjeow3g2njhOJ6C99WpsZHKy5LslgA==
X-Forward-Email-ID: 679aad873590a80aa97f8e27
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/6] rockchip: mkimage: Print boot0 and boot1 parameters
Date: Wed, 29 Jan 2025 22:36:29 +0000
Message-ID: <20250129223641.1888833-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129223641.1888833-1-jonas@kwiboo.se>
References: <20250129223641.1888833-1-jonas@kwiboo.se>
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

The v2 image format embeds boot0 and boot1 parameters, the vendor tool
boot_merger may write these parameters based on the rkboot miniall.ini
files.

E.g. a RK3576 boot image may contain a boot1 parameter that signals
BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
for the high precision timer.

Add support for printing boot0 and boot1 parameters, e.g.:

  > tools/mkimage -l rk3576_idblock_v1.09.107.img
  Rockchip Boot Image (v2)
  Boot1 2: 0x100
  Image 1: 4096 @ 0x1000
  - Load address: 0x3ffc0000
  Image 2: 77824 @ 0x2000
  - Load address: 0x3ff81000
  Image 3: 262144 @ 0x15000

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index ad239917d2bd..324820717663 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -62,6 +62,8 @@ struct image_entry {
  * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
  * @images:	images
  * @hash:	hash or signature for header info
+ *
+ * Other fields are not used by U-Boot
  */
 struct header0_info_v2 {
 	uint32_t magic;
@@ -69,7 +71,9 @@ struct header0_info_v2 {
 	uint16_t size;
 	uint16_t num_images;
 	uint32_t boot_flag;
-	uint8_t reserved1[104];
+	uint8_t reserved1[32];
+	uint32_t boot0_param[10];
+	uint32_t boot1_param[8];
 	struct image_entry images[4];
 	uint8_t reserved2[1064];
 	uint8_t hash[512];
@@ -491,6 +495,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
 
 	printf("Rockchip Boot Image (v2)\n");
 
+	for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
+		val = le32_to_cpu(hdr->boot0_param[i]);
+		if (val)
+			printf("Boot0 %d: 0x%x\n", i, val);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(hdr->boot1_param); i++) {
+		val = le32_to_cpu(hdr->boot1_param[i]);
+		if (val)
+			printf("Boot1 %d: 0x%x\n", i, val);
+	}
+
 	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
 		printf("Image %u: %u @ 0x%x\n",
 		       le32_to_cpu(hdr->images[i].counter),
-- 
2.48.1

