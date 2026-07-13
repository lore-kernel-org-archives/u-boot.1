Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A682C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CCA84BDE;
	Mon, 13 Jul 2026 15:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481D884A49; Mon, 13 Jul 2026 10:46:11 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78588494B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 10:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CBC620003D;
 Mon, 13 Jul 2026 10:46:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 368D8200039;
 Mon, 13 Jul 2026 10:46:08 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BDC7318000B5;
 Mon, 13 Jul 2026 16:46:06 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Mon, 13 Jul 2026 17:45:48 +0900
Subject: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
X-B4-Tracking: v=1; b=H4sIALulVGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nj3ZT88rz0osSUVN00C2NDy8QkoxRz0yQloPqCotS0zAqwWdGxtbU
 AC4g3oVsAAAA=
X-Change-ID: 20260713-downgrade-f8319ab2d75b
To: Simon Glass <sjg@chromium.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783932366; l=2206;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=k/5kezQXN1lLVoVw5aA81P1fCOnXgU/n97eeFzd3CWM=;
 b=em1IPGI5hANqrizGyDIb/IKVoiO3G59ym3gWYhXJz/glGDsk4nVU2a2FH12iyxyjgXTvrD2Hm
 qqj4KGUuab/Awolcj7GsaH9ysipw8LL7SmbPME9H9DigVuej5RTmxxe
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
region via lmb_alloc_mem(), it may receive -EINVAL if the region's
physical address falls outside the LMB-managed memory range (i.e.
below PHYS_SDRAM on platforms where U-Boot does not manage the lower
DRAM window).

A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
resource table) are placed at 0x88xxxxxx by hardware convention. Those
addresses are unreachable by U-Boot's allocator anyway, so failing to
mark them reserved has no practical consequence -- U-Boot will never
accidentally place the initrd or FDT blob there.

Printing ERROR for a condition that is harmless and expected on many
platforms is misleading. Downgrade the -EINVAL case to debug() to
suppress the spurious output while preserving full visibility under
DEBUG/log builds.

Real failures (e.g. -EEXIST from an overlapping reservation) continue
to be reported as ERROR.

Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 boot/image-fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9e0e0f93edd34ae9056926883b1a802858e179d9..2175fa338f55110862100fa9f491a0957e85ce56 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
 		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      free ? "freed" : "reserved", (unsigned long long)addr,
 		      (unsigned long long)size, flags);
+	} else if (ret == -EINVAL) {
+		debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
+		      (unsigned long long)addr, (unsigned long long)size, flags);
 	} else {
 		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
 		       free ? "freeing" : "reserving", (unsigned long long)addr,

---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260713-downgrade-f8319ab2d75b

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

