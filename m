Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B76CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DB7830E4;
	Tue, 14 Oct 2025 14:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="ep7+mpT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AF8831A4; Tue, 14 Oct 2025 14:13:38 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host8-snip4-2.eps.apple.com [57.103.71.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B651830E4
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 365141807508; Tue, 14 Oct 2025 12:13:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=JEdtJ9VLLNXAQhMV0vPNdH1bD7M3kg8zhL5/YH+fufA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ep7+mpT4VCx6ti8LqO0mOywYsxcY7fS0caDhYVPmyjuwe/EYVuU2hBlee9roO728seRCjWwrNtndEetw2pUjtzmfFCwt3S7fFn2hPpSDdjv+uhu8crv5idAZGrA50lZE9uIUf4iBin7cHA6jvAK5voXSi7WJYl28AhgMwDSZya2XKXlaMRcK+Nz8+BisiE1G+e28+pXilDp/KRzCyMayBXEOaEjTcpqI3lsijkYnupCDZcKJUDKigVBX3eRS9FmBA4MuNV3x/Vs+CfLg8IC8CN0gAoCXwJ6tJ6E0W6Vgtp1L9JRes5metfNn46vK1emhELz9S6cF36mJkrykgecX1w==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 F28FA1800126; Tue, 14 Oct 2025 12:13:30 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>
Subject: [PATCH v3 2/4] doc: bindings: use upstream bindings for aquantia phy
Date: Tue, 14 Oct 2025 20:12:47 +0800
Message-ID: <20251014121318.453701-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014121318.453701-1-root@infi.wang>
References: <20251014121318.453701-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX6PqQSoJ0n/g6
 gFsaaASs5iZ5SDf//tP6GCd6PYnd7HpS0EB0KWB5Filu+mHuMjix7aBPyrA8SSNeOb5tp0SLg8C
 hf1hiAF3VVQucO087rmMsHcO9xlRIiDRoFU7AYdwx78cwsIQeR67eVTyoX300EBljtO302Rjv8l
 npFDYAv8nkUyR0gGHqrrDpUYqTyHCbQ15pKXZWisE9BA+RwEGjAs/J1kiYqB6/pLMy9UznobeML
 NTrT2nMzY36tDcQ2N1h5jH9VM6vrIHoxYnFuGaYaiyXGV1IXAByzsjxq4JsEIXPTusIkWvbdM=
X-Proofpoint-ORIG-GUID: AEIcTurfFwXNRYMZwESVkUWYGwqC0qLO
X-Proofpoint-GUID: AEIcTurfFwXNRYMZwESVkUWYGwqC0qLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1030 suspectscore=0 phishscore=0
 mlxlogscore=959 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140095
X-JNJ: AAAAAAABBX+jkYChMbRTS4Zccyg96PzmJuPCB9KNeyFCKmQewuZFklQ3002pTEqm+TBviEIbC0NRrR8R21vl+PupZU8LIK+vILdX5eYI3h/LbxWmNB8s8Sqm13XbJpU35dNJ9AtkzfRCCH6YhwRdaBx+3mv9j1sQoSfhuuecnUWCNdcwm/kgkwB5wlrdNT7UMs9d15+IvIUMmj5A6ULFhDGLkl1FcYSzQlMZ2yK0X2bRWT7vFCdY/zstkqDyQkf9UUTebLXzvfqigM16Pf4/HXF10cBitnVvdyZyyAtkMTwioE/VXD4PEXRRx+VdHOI4eSsm8OYbxyvqqUxMA1q5YRDdMlBZYdWu+6CS6LWPsERgkugXsFEl7wpjqFz+eaJ1vQFb/ss8QD5MD+wtl8pUfDxavAPaMMuRXtnkNvPoxQpYXySdYpXry/ku/SK8jcbTCSRTOwINJeyXkzpydoHqqFvSiLn1i0AK8g/1fl+lU5ywFZP6TXU+r8dnWAgCola5JbCxKFcGlYwTEh2JORDLyH/benThuGnwu6vhwPS9PI4Q73uE4UQvEvWGkpbSC6IWWaxTsAu16QMx4ATbS1tz6TYw/J5OUM7zUjMaMdR2AA==
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

