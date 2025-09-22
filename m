Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B3DCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268DF83447;
	Mon, 22 Sep 2025 21:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AD383445; Mon, 22 Sep 2025 21:20:56 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB91683423
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
X-QQ-mid: zesmtpsz5t1758568837tc5061e5a
X-QQ-Originating-IP: CoRmPSUyOF0EuDGs3ojWi/Q8whCV8e6SuEQ6008fEWI=
Received: from debian.. ( [218.1.219.45]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Sep 2025 03:20:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12673140078698010598
EX-QQ-RecipientCnt: 3
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] doc: bindings: add Aquantia PHY node's "firmware-name"
 binding
Date: Tue, 23 Sep 2025 03:20:11 +0800
Message-ID: <7B7BFF5CA2A452D9+20250922192021.268592-5-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922192021.268592-1-root@infi.wang>
References: <20250922192021.268592-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:infi.wang:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvH2zBBgt3uTMTwhQo7G83tkDI7KHgKPT7DzoTnhECV6mQ+Af+KFOqv5
 9wxnvMPW06H47dpZayr+3bghGwKCe8xlUNi6TlSpEpual7FonIIogIE7jBJDygCdVujHv48
 k3lndKmBBN/X2TWtzIIc3tjcM2E3nxkk3Qm8gOT9hlxTUEVwM44tc2z0EyrH1ZfISq/FWFY
 C2wgP7Es05aPoZcRAZ4yEjrZhgMF7LOFCXR33JCfWal0nHtp6+aUwRjgnZZrnQDU02Erl4x
 TK/x01pxJdNn3lNJJCBVGKnI6+ctchxnXAgDw2yDj7hfPkWMg9r+EKmRKx7L6y3K8kUaw/T
 /yaazSGF8iMBvGPwx6kBH18p+EaJz61+kSBRqTJ7wp0cW+7YTixVli1xJ+1NJgbcBOavq50
 Zt0C9riHvutF07hQRFk755Vnodbdrf3ZYOfoVT4eEE4z8IxhOD7XELui9a0JPrEqFcKJQ3j
 1UMrPdSVpC3LVmM4mtNeAVThkYHoJlPW/oH06+x8X21wq9ufmtWTK93Nmo/7lSqVJh2EP7H
 pY6bFt8TloiifiraAupZTuVAEjl2lXnSlC9xjHuOjtcKLvBtEGHnO938U65vgKYNBRduz07
 6/ar1A6w55Rf4CJsidh3A25ryYurq2yhgzGrRj3ThKP++vocTQ4F4EI1u+xNcWr+1LFWL/F
 187LjeB+8Z9h4k+btBFUKvKFgPjSm3+CoP/tUxn3EncFC5etHZjTJxyRWmtxjfknHHEmfFj
 Wn/+8PpeJw306i3jWWRUCQFic4bVA3ORXV1Fi21XLIj0GA4D2yQ3YDZu2XuAy+dO+Keia9V
 dw91GCHKjSyXOc2a6/bN8s+65uDLf01E0Iud7fjWGTjvDLj4rb+ZvbkmU6LdKO5SB8aKDFg
 UDDkxv1uS+a/n2JxXfTYmoQ9Sp/q+00c8nmZBfXPhqDgHVLpRIx0Ab5baUzO88YXedaPPx9
 RSsEsg+I5NREzBf49uBwu1AaxwuJzdyO27LHHbHsD0vDcjw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 22 Sep 2025 21:42:39 +0200
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

With the switch to generic firmware loader, "firmware-name" binding
was introduced to define the firmware filename.
Provide the document and usage examples.

Signed-off-by: Beiyan Yun <root@infi.wang>

---

 doc/device-tree-bindings/net/aquantia-phy.txt | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
index 7dd3d45df12..1227c04d04f 100644
--- a/doc/device-tree-bindings/net/aquantia-phy.txt
+++ b/doc/device-tree-bindings/net/aquantia-phy.txt
@@ -11,15 +11,45 @@ a custom firmware is needed for each integration of a PHY.
 Several optional bindings are defined that allow these configuration points to
 be driven by the PHY driver and reduce dependency on specific FW versions.
 
+Aquantia PHY's firmware is often provided by PHY-resident SPI flash; if absent
+or outdated, U-Boot can upload firmware over MDIO during PHY initialization.
+The driver uploads only when the PHY reports missing firmware or a fault.
+
 Optional properties:
 mdi-reversal: 0 or 1 indicating that reversal must be disabled/enabled.
               Firmware default is used if the property is missing.
 smb-addr:     I2C/SMBus address to use, firmware default is used if the property
               is missing.
+firmware-name: String containing the filename of the PHY firmware to load
+               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is enabled).
 
 Example node:
 phy@00 {
 	reg = <0x00>;
 	mdi-reversal = <1>;
 	smb-addr = <0x25>;
+	firmware-name = "aqr-firmware.cld";
+};
+
+Example using the generic firmware loader:
+/	{
+	chosen {
+		/* Select default firmware loader instance */
+		firmware-loader = &fs_loader0;
+	};
+
+	fs_loader0: fs-loader@0 {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		/* Load from MMC0, partition 1 */
+		phandlepart = <&mmc_0 1>;
+	};
+
+	mdio {
+		phy@0 {
+			reg = <0>;
+			/* Load this file via the selected fs-loader */
+			firmware-name = "aqr-firmware.cld";
+		};
+	};
 };
-- 
2.47.3

