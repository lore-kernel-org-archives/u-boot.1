Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD249CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 07:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169A880050;
	Tue, 23 Sep 2025 09:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="IEPKt4+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD0E8350A; Tue, 23 Sep 2025 09:14:17 +0200 (CEST)
Received: from outbound.st.icloud.com
 (npq-east2-cluster1-host6-snip4-10.eps.apple.com [57.103.77.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9B88004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 5A0381800287; Tue, 23 Sep 2025 07:14:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=Tc6QLRJnyAozMMY/trEOgt5lLEVUSy36ORrEC6ebZP4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IEPKt4+ZP3Qd66HBL2AYsihOnYPdjuON4sT+wNbYwy8hQhJfoWTM0tMsAo4jPPi8hJWzAw+dfk8g083WqrpWATdXXtyL3Xnq5sJD/SBIeIn7yTaR5jCDjBSEHhroMPGBJRK1J6kMmElIN6xq9gEGWQSj2reGnWWGalWEg4K0hf12HkITVUUjxfNsizptXdQ6HHr91fno0gZxAoa0eLNv9aIpKYlXOM3STm+bvoyRtNAXGKNbiU+qwXg8lIhBhed+wpaN0KCthCdEVwXNMtgiU6q0xeE7f08ZJV5HIFf+lLIU5PpKGs9lldttWVmU0+M6zW84kdQGhrosmtZcESobQw==
mail-alias-created-date: 1549370554000
Received: from debian.. (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 26EFA18002B3; Tue, 23 Sep 2025 07:14:11 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Date: Tue, 23 Sep 2025 15:13:01 +0800
Message-ID: <20250923071315.276114-5-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923071315.276114-1-root@infi.wang>
References: <20250923071315.276114-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA2NiBTYWx0ZWRfX9596QnRsiDf0
 EnGxS7+0CoqXX8zAjcRHNl4YvZr0SlTURBlqmW77A96SQDlou9RbyPxxgFgRcOUUelEjDIxNPaw
 vTF9ER/6QfWba7Ydb9rOpZJbCbSY2zxbARKwtCDlrdqmoVwu86kd8fyu9Ow1anL1B1G8Ecp3z6R
 l0gXqFokjsE3FseomanDNQlFhV/T2xVJ4EeX30SsLkdVVhBFcIUGXH1cXo9KuoiEs3SscyrrDsE
 XR50Wj2v2qUPyGYNY4+spteiErBKqbs5avpe5G1QNZI7A3Z4t7TvR6rGqZYmdR3kcA4Y8iJwo=
X-Proofpoint-ORIG-GUID: 9IdJCZ-NwBA0YlvCzYXuc1c8nLQh-f55
X-Proofpoint-GUID: 9IdJCZ-NwBA0YlvCzYXuc1c8nLQh-f55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230066
X-JNJ: AAAAAAAB8J46gOvUWbk0uJVJIUeyEsbcv/sPw/KA4LfMJdqY1SQBk0mrBhyHkYNpSARZhcKpSdPmN3cIKZwvk8HHzncImqPV2twnc0IjuRaBTZPACCC6w5Sl7ntdaxN1m1e7/Qlh+8Ce8pmsn6xuPxSLUqJlP3Q6EAMrOO7rzBkXcdPXIjmwSAyAjb4jczXM9QmEn3an7p7OhG2qMiMmMKDP/cF6LAgJ5WHYwavxbRpekQKf0gN/hNfzl5hunoDbUMxen376hgE/0RRNvdQ9Y1dZyRPeprvw5VvV7U6yqUQNXYv2beAhzg4GNRFeTtgSw/V6bhgcMRQx+AMJHsnhQb8g6BW5o1zDDi/i2myf2052VEn/0RB+UO0v/UqPNxm5fgqt1u9pZO67QbG3SRtIdsx/oEytOdnnc1dePnNLUYLt/FYqCe27kg4mxWPAeiwF9khS8J/OZMAWWeRLjaLslyUlWY4/twz6lo+SJlwDvYPLs72Xa67q9y9y/8QGv/oIS32oTSvRYzjdWYASxHKTmTmuh3Wdd1WA735HsHD0uJIslQPETu0X4Q==
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

