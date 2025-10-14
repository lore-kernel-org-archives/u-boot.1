Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DA9CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979A38206E;
	Tue, 14 Oct 2025 14:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="F8SGr9E3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9CB82FC7; Tue, 14 Oct 2025 14:13:34 +0200 (CEST)
Received: from outbound.mr.icloud.com
 (p-west2-cluster5-host7-snip4-10.eps.apple.com [57.103.71.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAA382991
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 DC737180A609; Tue, 14 Oct 2025 12:13:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=i5NARKSZ+8fzmHvnrkQdZ2Bm5H0aQz3YrLz7iEvMrkQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=F8SGr9E3U9NFGLNQwtKLTz1Mhcmn4wYhbXmaNdmoBsgJW5K4q3o0bE5j18WKPFvZVBGNoDGB1vashU7YfT91a4RXfi+VLU6payCqbVO/rZuxBgAaijV67pnqSluvO3U3CF3t/qYFneKwjW9f8mYU1l6dXnaQDlvL3B+8JoPLKM2qqsZKvVAA9ErcO8Hk0JDniGcMWBO1HxxjO/y3v1XseiqPcx+Xy8nQDJ1Was89hAOXE9z54xusn7pTOpcdNt/iMPoxELjK7By+7O2kcmyx2ynwu8XFnIXbfC9zkH9xOPn/GhiiOoO3rK88/9GJw3/Tveg9gJzNaoOHYXOTl6430g==
mail-alias-created-date: 1549370554000
Received: from debian.. (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 C798C180553E; Tue, 14 Oct 2025 12:13:27 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v3 1/4] net: phy: aquantia: switch to use phy_get_ofnode()
Date: Tue, 14 Oct 2025 20:12:46 +0800
Message-ID: <20251014121318.453701-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014121318.453701-1-root@infi.wang>
References: <20251014121318.453701-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA5NSBTYWx0ZWRfX18+oeSJ0bQaA
 9gtGQd+zZwan59fEzwC9XXjWNFaGXZJGfvPfFFVb/VWE9I6gJ3gJpeBMLqk4d4jdq4HXBgWv8NH
 aDyznYfAUbA6nW8CI6j1Stal5nH1AMSK+pNvxszRqqCw8FLwYTqIP0lpmwTTcfIp/sjiWlixlbI
 lSgxBGI1hOaqUhzObJt6HwQItAvbVUqVhigzvwUClzJxBRlc6QoJ2uezfGZ8ZNA8Rw3ulKzbzE9
 7rzfUiVBfz2nPYd7ww7KGHAOlui7y//MizNu0sODFEu3a7G08ng60WbZOrmvSWIJNd6qB4DI8=
X-Proofpoint-ORIG-GUID: zcpkCnI05eobULr8jrZPeGQaLFOASzAv
X-Proofpoint-GUID: zcpkCnI05eobULr8jrZPeGQaLFOASzAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxlogscore=649 mlxscore=0 bulkscore=0
 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510140095
X-JNJ: AAAAAAABNeGiMpCpK9RwR9QJ8gyxnmvqDaL6NsGd041ZH+9Y4RI7Y66pgiM1YUZZDJMVfTpOtYRjmdm1gKAJB64fv8395U0cyP4ZLoBsnu1RSVVAP9wDwL3mG50XCK5R2CHeik4gSXvbfBZKw7r5o1mZscWZPaR6oIDoCMVDRlLW1MvV8EkRsC2A/2iDNxWsvcAdUPn8vUyJoHKACSO/eHGPhVfmeZlJiO/mV6xktxQsJ92YDR8/9YreJ2KQ4ZH298rsvMt4ANJeK6wfU3VMw6sTjrTkUY1WYo4X2EjjMUwkynE58mPxaXduq7PY/fHNjQO2TFVF4HqaYjuNeLLiAEHagZZuRiakW1/PgaIsEuL9BC44RyiFrBIovZiYbrPWOl1JuArklCX8UPCMOxyK6u0kf9oMAavmu5rKvTr8DbS364GDXSe2w5me8sWKOHVmw0CPg2uQh9SA32uTnHJMK0iS+V3RH658JZ+5I2kMnL2lOOeBYKqNM4d+9Ei3j3NvCVx8WsyJR/V/t7taHCfR7GUJjNJjnuWGz53rf6vk9HDSAP+2IdOPZhRWpnweSPw89i/PoecT48My0yiNrNGl/e6rIEB0WJ1zphEMryFStJ/U3IG888bNo2rh/CEu62RdyANwmVsqDS60ynaZyuVHaQgF6FcNZWWBlhwJojUrzRS5zdxC7uvD/Tc=
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

Use PHY API phy_get_ofnode() helper to get PHY DT node.

Signed-off-by: Beiyan Yun <root@infi.wang>
---

(no changes since v1)

 drivers/net/phy/aquantia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index f63a13824ca..903fcd667f6 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -338,7 +338,7 @@ static int aquantia_set_proto(struct phy_device *phydev,
 
 static int aquantia_dts_config(struct phy_device *phydev)
 {
-	ofnode node = phydev->node;
+	ofnode node = phy_get_ofnode(phydev);
 	u32 prop;
 	u16 reg;
 
-- 
2.47.3

