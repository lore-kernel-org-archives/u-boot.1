Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9441ACCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6E9839B5;
	Fri, 31 Oct 2025 16:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="RMLj+7Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C694F839B5; Fri, 31 Oct 2025 16:24:19 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster5-host2-snip4-7.eps.apple.com [57.103.66.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B0483980
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPS id
 5B12118003C4; Fri, 31 Oct 2025 15:24:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=/Ec2owYkcj0185YXlpI7Ti+MnyXztjTi0zH3m2bYtiM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RMLj+7XuXHTC9/8qs+CHdxI14322pXzVdNwbr2hvkYib7nKNxj7VESTgywDecHGAsbFxoxltLABxeBQqini4SBk5K3/NI/eNOM27THm2yoMuv/WUhCno7+DSyjSICAhCJWP5eAfnH+WSOMlIL4GxuMYmteLrOOl1vXlu5HBDgbTxTwmmucjftjKeId4ge01hbiXUWhCZO9sISIzMhIA2fhiFeWHbyUtaqVgLHfCXdP0wIa7XLdHoQ8xAgVqyiWOLs90rN6HYUbl8x6XMmi+oLzix2qjG13wlCEqbMyoPStE3sNIzXZ2DcAgVU4VOnbnYtN0xD5Wuu3dJJfCmIAxYVg==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-2 (Postfix) with ESMTPSA id
 4D26C1800237; Fri, 31 Oct 2025 15:24:11 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Beiyan Yun <root@infi.wang>
Subject: [PATCH v4 2/5] doc: bindings: use upstream bindings for aquantia phy
Date: Fri, 31 Oct 2025 23:21:04 +0800
Message-ID: <20251031152348.60571-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031152348.60571-1-root@infi.wang>
References: <20251031152348.60571-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzOCBTYWx0ZWRfXzf2Byfk6F+N8
 LPQMB+SHJLpViFYmektrJaLfaiGY7yZFMKNu04zbj2Esnd1tISko4HxgqCZZd9A8l5UzgiddkWU
 ab6yZK/ySTisYAtLrCqxSpUJ1d968MYvi52yMkIG3rHeiDB4s9EFF83wu1hCeDElmGu0v6Q/gSe
 2EerE+olLcP6EVnqnfpIhmQuJXqM5RvGZuETWzeYqMXnqsc5hvYX6EAga0rW+z6RhzqcxOWN1EL
 9ybqANJnNv2BmSbqomigxrfqXsQLcBGbVn64gDQmyCO4N2k279bJ+gn9n4YM0Ea7X6SFApKnU=
X-Proofpoint-ORIG-GUID: C3plNZjuC7EY8pXm4kiZ-hyHoncMQjNj
X-Proofpoint-GUID: C3plNZjuC7EY8pXm4kiZ-hyHoncMQjNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1030 mlxlogscore=996 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310138
X-JNJ: AAAAAAABJ8B4SjEhdL6eKn+Ks4ODgxVbLSPcoC7GLmsQNh/rgp2RLlb67kAr09WqZ5B7kQNAEusaZpRG30Ov3RAFrxCFg8iQi1f0hmBYC58eVOF15ipKSlTGb+YzFf8KeGlcUOCtkQwiqSycvpxtgLKLEYKwccZ1JSkLCMT3H2FkcWnpzlXGf+rwmJVgUIOBXudA0CtAg9+0wwCUxptqRNWrPV4kPLv1KN4+ZOB0UIN4FqYGecymFybGy5bCVFxJ/o8Kv3GmMykYdKy8Uho2OM9qS484t+DHosRMayffIU+O/XTPfCjk+j/2m5Pe6aUWNJLFFyZq2OEG8PckcG1h9qcCK7XTJ9nGbiSexhFjWOOv580pZk4LgZF+btwYqU2l38IvB4+DjVkZAr+JHozRyPUYwuBdFtkv9T6qqTpVQziuAI53a8Hi25vgZMUS0jOJGWOwwCb1vDgMKpK12JQibWiUdrNkgiGH1h5x39yeHxOqoexq/GiD5TlM9rAGO6YII0EBswv2Lm6eHXxfAu6shF5MEd/CF768JJ6WSBMgdcGYmzWFd2r2HUVN9sjGlvxxrv7SnzjCUbbYFo8l5RDTZMlSqiLl1MXy09flCdRPVRshl/2Xu6Q/1JI8a0K1BqfZ7zMmtVLOsqHQnjGVYhQt
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

(no changes since v2)

Changes in v2:
- New

 doc/device-tree-bindings/net/aquantia-phy.txt | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
index 7dd3d45df12..80de0e8b158 100644
--- a/doc/device-tree-bindings/net/aquantia-phy.txt
+++ b/doc/device-tree-bindings/net/aquantia-phy.txt
@@ -1,25 +1,16 @@
 PHY nodes for Aquantia devices.
 
 This text describes properties that are applicable to Aquantia PHY nodes in
-addition to the bindings in phy.txt.
-
-Aquantia PHYs allow some flexibility in the way they are wired in a system,
-they allow MDI pins to be reversed, LEDs linked up in different ways, have an
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

