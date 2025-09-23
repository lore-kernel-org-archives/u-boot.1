Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328E9CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 07:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7791480050;
	Tue, 23 Sep 2025 09:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="gm/dVWoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAB783390; Tue, 23 Sep 2025 09:13:37 +0200 (CEST)
Received: from outbound.st.icloud.com
 (p-east2-cluster3-host9-snip4-9.eps.apple.com [57.103.77.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE988004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 17D67180060C; Tue, 23 Sep 2025 07:13:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=BWKFYXyZjKVAK6jrJRUukBLNWWzy1xgQLVPXB3TeUOY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gm/dVWootOf06ZRZ0diN3Oe97pdf0SihchckDeF1w/Mvg6TXf1aSlpJClx0UCrGlqNFQRqemrG/E7QNwHdNZl5Yi9QQsFR5c43OFg/DvXZB8ryUZkJ3p1MwLthw9OUlntDBAOfIEwyKHCdypiaDVM/1BlW+r9xTrmJWJ0WPyb+msfOwgQlvykPhnngb7FTcQZ/OXHl2pROxlp7zQiniwuBkTgF+E4JjN1OGXHCyTePJ/zg/hS7t6XwyPxevJn7sZ24o15cS7Rj4hBaVTxjA+Pb9Mt/fdf2nW0J30Rdt00zDuLvirbciuP32k812DaXZZlOPYWVgIQZtCaqG0Tdlgdw==
mail-alias-created-date: 1549370554000
Received: from debian.. (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 AD9F318002AC; Tue, 23 Sep 2025 07:13:28 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 weijie.gao@mediatek.com
Subject: [PATCH RESEND 0/4] net: phy: aquantia: Switch to generic firmware
 loader
Date: Tue, 23 Sep 2025 15:12:57 +0800
Message-ID: <20250923071315.276114-1-root@infi.wang>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA2NiBTYWx0ZWRfX4ZmLCd9lL58D
 7+4fDzOOBlIHkVLzkkelROplf+Qq0PQkiyN1uh7c1Igv8JhVPe4V4i+MGUzfsR2YOoD5PF1jySy
 ZdpQK4WWizpoEs/ft1ULP5bnPbvx8sCisS/tL3SdA/Rdrx0HF0sWpomZCVDCQgd58wDuJW7jmgx
 TMgnguYFf8Aw9Abt1qCRj12YvqnOAeQXdLHnWqpsXOHi+lm5oazFz5QZZTexbeR67w2qn6JsN3k
 eIt4e8+qP6LDH+39ilt40XkS8Q/Fh9mEnLWs8iswFR5IW6RxyLgE65abhlpXyNG4HkhaNilwI=
X-Proofpoint-ORIG-GUID: daINNo8PAQkGXek9IEHUPD-2zLlk9WMM
X-Proofpoint-GUID: daINNo8PAQkGXek9IEHUPD-2zLlk9WMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=724 suspectscore=0 malwarescore=0 clxscore=1030 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230066
X-JNJ: AAAAAAABKPTbPUqb79KZrCJ5kXaZc/BAjkYqXqd5nF2VELlTVMaXnopXBW9dc+U1V6g6MgYXbTWUn+PxvvQzBxEY2MpimNZStGoTCSRdXigoJDeFcMscqvzsvNv0U5SdnrD02O+NZUouzcasZb7sFE/8oeb298Z7jlJ9KSIjqwNE6JF/EfAMAnvyDEVNNja5B/jqCsQte2iteufhbJFFoWxKPEZNdoD3wLf1eT3K+scxFsHk0AnaydrOgSR7bwKEkREtmC16pWqwf5u72LWbfA7AuaJCUiLtvUgf+9EZ9NWOvxB4yCo5pd5sj5DII6M+OwCbwO4R13mP72gz33wdBVPIvspD6wW/WrQ3zjzgpUZxsIQz5qcNc2hQQ3HtwDeLFwrIeLUDG9zs/d1PJW3J7NpmksFB1q19kbRvMmTnQdufkdIYqmEGApJ1TKbx0P5xJijTUBXLkf2Ej4HBB4HBzkhuLOlbVj3dwrPEyCqBz8D6WXDMtxDm15jg75oF1B/LH6kWYeUCtbfDWgbJI017VdHIu9TrbMg8qOO2oBrWJyQqnURdKUkek7bw3+dMDppxp2lkq9Wsud3A6/UAN2MiFm9+vRJqDk8qeZJ5hUMFemta8oEWqiO9VpkD8r5DnZ3N+fU3ux1q0DSxVqiYWRirL78rNY9qaiH3XhAW0jwuNqK+nV5a2Z+amA7WAp2GyGfbM745perZhZKjUIYVZjslAwjiUv+UGArpyExvGw==
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


Hi,

This patch series refactors the Aquantia PHY firmware loader to use
the generic fsloader framework.

The existing loader is limited to loading firmware from an MMC device,
which restricts its use on many devices (e.g., routers) that may use
other storage like USB or have a UBIFS root filesystem. Migrating to the
generic firmware loader allows firmware to be sourced from any backend
supported by the fsloader framework.

The series is structured as follows:
- The first patch is a minor cleanup, switching to the phy_get_ofnode()
  helper.
- The second patch fixes a small typo in the binding document.
- The third and main patch replaces the custom loader with generic one.
- The final patch updates the device tree binding documentation to
  introduce the firmware-name property and provide usage examples.

This change has been tested on a Buffalo WXR18000BE10P router, loading
firmware from a UBIFS volume for Marvell CUX3410.


Beiyan Yun (4):
  net: phy: aquantia: switch to use phy_get_ofnode()
  doc: bindings: fix aquantia-phy.txt typo
  net: phy: aquantia: use generic firmware loader
  doc: bindings: add Aquantia PHY node's "firmware-name" binding

 doc/device-tree-bindings/net/aquantia-phy.txt |  32 ++++-
 drivers/net/phy/Kconfig                       |  19 ++-
 drivers/net/phy/aquantia.c                    | 124 +++++++++---------
 3 files changed, 103 insertions(+), 72 deletions(-)

-- 
2.47.3

base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
branch: aquantia-fsloader
