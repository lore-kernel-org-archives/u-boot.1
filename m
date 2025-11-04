Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86941CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83F6835FE;
	Tue,  4 Nov 2025 20:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="THs4Ug7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EA88004F; Tue,  4 Nov 2025 20:23:46 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host9-snip4-4.eps.apple.com [57.103.71.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E7E8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 BAE4A18000A3; Tue,  4 Nov 2025 19:23:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=EeR+cj91HDAeDLnnOwe4XRj77CbdbaMjEjWCp3lvWIE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=THs4Ug7tYjoe1OU69KqdTqOIo7faSjY6CN4FxH+fRFdFx0mVlaUDwEZVLlzjSjVm7x83pYSeH8Dk6axlie9CsjP01jiaiuXDpmYDmt1nm3ApthmhspCO8hkKo7uJL4ZHzkpOTzu6NhSAI6dGZyhptkoe1CXq+Kwv1OInpR2PNDHhlUMv3vhv6x9XAbfIOWXTSGvDn/EVwAhfadZ/LeJnSp52LCzPFbQvvwgR/3WT7qQVl4CrcsqVsXe/iwwMUkODLQhj0in8Vg6F6y56zotTqSRNKhMK/wa5zWBh3Fl+JyajXPT37mgJsqdKt6xrOLNuTAAoshzmspCpf8DU6dfDuQ==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 989561800107; Tue,  4 Nov 2025 19:23:41 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: bryan@bryanhinton.com,
	trini@konsulko.com
Subject: [PATCH v2 1/2] configs: Add rock5b_plus-rk3588_defconfig
Date: Tue,  4 Nov 2025 13:21:52 -0600
Message-ID: <20251104192354.2232191-2-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104192354.2232191-1-bryan@bryanhinton.com>
References: <20251104192354.2232191-1-bryan@bryanhinton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xg0zJEKemBie0fW1aQ_0xfyyV57NS1tl
X-Proofpoint-ORIG-GUID: Xg0zJEKemBie0fW1aQ_0xfyyV57NS1tl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2MyBTYWx0ZWRfXzIGRitfpaitW
 328zurwnf7a8ECDlXmmNDkWC/1vE44xxaF8VeCr+0DCDDeIwry5B2K4uVGCASkyqROim22RviN0
 r3P00DNtTI0pevc2dtoKXdLqPAmylXoYWR0WAX70JjcxJFyP70yR3sUSIAoe8RW1KjBYLhEfp46
 cxVI1OHivxiITrtTAhoPZwtQmTFtRIieb1wpriArRbS35C0DAFESw7iIpohTQw+jU1fHZNPdzns
 PkXlrOULYh9lvp83EulamfvP0zJSy/8IsRLNQLfdnYssbJYZ0etfHHci7EeIIU/8RaYqDw+ARae
 ApG585OqnWXxqdzl0H+
X-Authority-Info: v=2.4 cv=BtWQAIX5 c=1 sm=1 tr=0 ts=690a52be cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=yyIQ4Ub9AAAA:8 a=NQM7Lt6TdcjYKXt3pWMA:9
 a=QEXdDO2ut3YA:10 a=rzDBUVUxiSc7n6oCI6VQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1030 spamscore=0 mlxlogscore=755
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2509250000 definitions=main-2511040163
X-JNJ: AAAAAAABsPZ7uvR0aVUrRNC82svsUwEgHUzmOOwfvwQI8CI9Vl9AWvtIUKI4f+YrJw7CvqJ6GvzixlvW5UiLQoOH0pBmnKNQkjrgiyx3OGcGUNEQ6rnX+7BJLhnpNxVbSLYI1EZeNgoB5AzttMuh1tNL5KVab01QpSPOHtrVm8+9rH7tOPJyDZVKZYO+NH22rfNj2cMowMmxFLxkCAf891AP7vYgr9tQC/DIqcDjNvLJiCbjXk92ZX4fzkQgatGgFFREku6ZfzEsgIwvaf5pshY6V6/KAHbvAu8xd7EzCNuXT6fUCeHGP3oZEwg5AcA5uqfUpQAvo/AlgNeMOPayr53GTixipiCQtxOV0K6v7a7waa3c9DN8b+tJXK3rx8UIhI68/DSRUlgzs8Y0gkatHDhfzYBkaFNrNf+WYaFNM1DIKw4h1x0S9U4OSUR7H91i9CMyjrkacysl2vYxVUHEl8KrFP6UQE4rSuY8H1oaWoBDc+3fdxW72eEmfxlIbsondHm9i0VuEBSbdtMhkx0ojP42WwHj6e3/KLdUYW1JHwB4T81dpfIEjaOHBs7clJttnzp90ehDrZ7kzj3EWj/IwBg4aF/7ST5T/6RfZIXEtv12YZNmF+9VTbWq6X9Q7g==
X-Mailman-Approved-At: Tue, 04 Nov 2025 20:26:02 +0100
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

Add a Radxa ROCK 5B+ defconfig that augments the ROCK 5B defconfig
via #include and sets the minimal deltas to select the 5B+ upstream DTS.

Tested on ROCK 5B+ rev 1.2 (32 GB LPDDR5), booting U-Boot from microSD.
Build/test details:
  - U-Boot build string: U-Boot 2026.01-rc1-00243-gd128b673cfb2 (Nov 04 2025 - 13:08:23 -0600)
  - GCC: aarch64-linux-gnu-gcc 15.1.0
  - TPL: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
  - BL31: rk3588_bl31_v1.51.elf
  - Verified: control FDT present; `mmc list` shows SD/eMMC; `usb tree` enumerates.

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 configs/rock5b_plus-rk3588_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 configs/rock5b_plus-rk3588_defconfig

diff --git a/configs/rock5b_plus-rk3588_defconfig b/configs/rock5b_plus-rk3588_defconfig
new file mode 100644
index 00000000000..89cb7fc20b1
--- /dev/null
+++ b/configs/rock5b_plus-rk3588_defconfig
@@ -0,0 +1,5 @@
+#include <configs/rock5b-rk3588_defconfig>
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-rock-5b-plus"
+CONFIG_OF_LIST="rockchip/rk3588-rock-5b-plus"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b-plus.dtb"
-- 
2.51.2

