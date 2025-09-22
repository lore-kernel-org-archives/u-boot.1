Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C1CA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB48B83211;
	Mon, 22 Sep 2025 21:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0558883443; Mon, 22 Sep 2025 21:20:51 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451FF832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
X-QQ-mid: zesmtpsz5t1758568831ta4655ce6
X-QQ-Originating-IP: Fq5ITHJWsjrkiKvNYCiB85WZzuCrxpY/dnv9TsO5K2o=
Received: from debian.. ( [218.1.219.45]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Sep 2025 03:20:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5887580862384762391
EX-QQ-RecipientCnt: 3
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] doc: bindings: fix aquantia-phy.txt typo
Date: Tue, 23 Sep 2025 03:20:09 +0800
Message-ID: <B13DC3B6B66510F3+20250922192021.268592-3-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922192021.268592-1-root@infi.wang>
References: <20250922192021.268592-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:infi.wang:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKkKo7I1HxIeXha8jx2zljAInekgw5ZI3fyMNnDdF5f9zGpYSmRg7cYO
 HAxPlgPbamC9LyA1jVJ55NbcqcGA7UDkmFx7BxepkeMAVO1nwn5xx6bxgMgE9w2TzPyrlWS
 W7saQKCd0dsqzAGGcmjWbo3eBxBqGLdSqFUWsWM8fIsW4LGe/NBIzT99+jNOuWEklFd5RlN
 wclMe+P2dzTJcULOfgwp6eUaZG0orj9qKum1w/eIsPr76RsPL+p8cVURGjzl/bq4/H2ATOq
 L/xuZboMMPqXCRkvOaivvTobesXoYiZiR8n8PR9iW+IKR3cbccnS/UIjrArxhgT+YtnYUZO
 XiANXyyvf9eIW1lJNgwp03za/epgEeH/41EYFd2aSI2r8ADq/nSim95IqeHqD3/i2Q0+UA6
 w/mmDmcJkS4vuJ6I7mbtgwyzwL0WfoyxkYt7OLXs52uvn+sOiOF9FZyne2ryd71qtm/5m8L
 5hh0e3CaxPH5+j8q7AaqQHh/16Bjc93yc7R1GC2danP2tCAe3BrB1wxAxAKFdwId6JCn6uN
 iz8n5Gd4EDZIY88eF7i8ag0gY0Wa4sVhpAXNhXFrOq33A77yUCEF+gysh8BWLznpLKBU3Cx
 anY5qCYWNOvattBFM5//lCbEN0jy/Yf0R9ilt9jzionSfkPThseSzDogZSXGg53loW3z47I
 szhND0M2o0jh5NqXuwZq3miXe2cw7/ekqMzxita/F49nUUZwfW5R0tpLv4a/7pX0GVE+51w
 nN6EJiROZthXyqE/xXEG0w014SIZ9Ino2JtnHFTNmUNEoeEcfsL+/W1u/tXeBzXhgXhm4d2
 NGST17ACOcsGV+F3tOTg0AiAZkFBk0dyGNwnpMxutVnsAs2TXOA/0E/LMCOTJ4miUW0mRov
 he5NPh2AOAr4SE6sMOhZz8kCKXfcTpUqlsJlVvKn4s6D9YAKfs3dHqlzn99mhKNWER43bFg
 t5OFwFnj1X5jsfQm2G6A/cnZHCMaOdpe+CerJEWZdlaWwrXf4jvpW5M0Y8XatjR7aGdrDl6
 A5XpVSOA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

Fix typo: "weays" -> "ways"

Signed-off-by: Beiyan Yun <root@infi.wang>
---

 doc/device-tree-bindings/net/aquantia-phy.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
index 89ce61e05bb..7dd3d45df12 100644
--- a/doc/device-tree-bindings/net/aquantia-phy.txt
+++ b/doc/device-tree-bindings/net/aquantia-phy.txt
@@ -4,7 +4,7 @@ This text describes properties that are applicable to Aquantia PHY nodes in
 addition to the bindings in phy.txt.
 
 Aquantia PHYs allow some flexibility in the way they are wired in a system,
-they allow MDI pins to be reversed, LEDs linked up in different weays, have an
+they allow MDI pins to be reversed, LEDs linked up in different ways, have an
 I2C slave interface that can be used for debug.  Normally the configuration
 corresponding to these is driven by the PHY firmware with the downside that
 a custom firmware is needed for each integration of a PHY.
-- 
2.47.3

