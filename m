Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2DACAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 19:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCDC83526;
	Mon, 22 Sep 2025 21:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF9383445; Mon, 22 Sep 2025 21:21:10 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C331832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 21:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
X-QQ-mid: zesmtpsz5t1758568829t80b03e50
X-QQ-Originating-IP: 0fmr6b4teOiCck6lURhA/gsG77uckhe1KQY+alVMTgY=
Received: from debian.. ( [218.1.219.45]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 23 Sep 2025 03:20:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1978170554533727436
EX-QQ-RecipientCnt: 7
From: Beiyan Yun <root@infi.wang>
To: u-boot@lists.denx.de
Cc: Beiyan Yun <root@infi.wang>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] net: phy: aquantia: switch to use phy_get_ofnode()
Date: Tue, 23 Sep 2025 03:20:08 +0800
Message-ID: <4DE4F2A2E02C441F+20250922192021.268592-2-root@infi.wang>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922192021.268592-1-root@infi.wang>
References: <20250922192021.268592-1-root@infi.wang>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:infi.wang:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MquWYBNX9BcXcLtmsRy+LMqJFisS5BeXWxfu2CYhigw57gW8oar0tf+g
 DvfG81l6RmpDQETOZNYanfgy5/snwDkgB/L2rXxcugVska3710IbD1qVTcSHXPpVvxZCxY+
 E7YP2oQ2QMRcbFQ3coaPmuqwMPppufVxZw5nb3q4kKuL4BPoKcdhjCuqgvPbf40xetqVGLv
 R4FKMtNZ3tHNYCT3aNqcJTqeh6NyOtszgAY1kv1T/CW6+XSixD8cSmmVPCMZdy3u3HjqNnj
 ss6K7M7/vJr/0iXaUPkuHYMjgibhYLinFo51qbcWBmuFSCt3ct3zoNLM04rEAzoW0u+MUWX
 IXSQlR9FI4j0eGCJXIc9XIPZsgo6kwAaE8C5y45klVecXLFS7nY3S6vmBPPB/usvuZr1aOg
 og427QK+3Xkxv6D1VjbvPBI842NmSrlVtaS7Mi/gB8VzAlaraKmGkdjUfL6RMVA39/ZsXxU
 R8cAPG0b8KFCV0ZNU3H2KfE0BnKrl0AwI+VyeRM4kW2dxwcuAyWTjgSRgdN7u6xQ737YPZ2
 vAvb7r7W7msAaN7Jt4gDt1ZoUt/Jn00a3NtCOv5bUz1Fk615Xm3BsDaciY8xGmHdL76H2iH
 Jg3l3YP/yBT8u9uBzZvAUwXo9Wm/EZdB70O99GxJBnhYabesy1LtbB2Y5t3Id+FooZnqLVl
 MHTFydDBjg2p6lMXcm2nBqkg7Do9uePk1a0vB3ZRfhTyQ6DsMu5fEBe/rpFl5N20rvSMzOl
 69OYohaZ3JmMDlHoaDZg1JzlsRFxpMROf86m9X8u3+vkLOpvtQY8fL9gK/+NEAnh2tLZOwb
 ghW2d9S9vIAlAAnt0qMoc7llhd6kN9iQgVx7do9zm081YKrItrKBgpTgZbGylDbJ5DBQ6HK
 xDSkEyvc0XoEw9HbVQNo1uANc14dK6B1/945ZlLaqbVFOA0hkxZPiOT9Z/L/eDwTrkN1PnB
 C0oeOucsUWSZObVV6Ym9Q13WLvi1RXads9kxCjqQM2lChvsBBDsBmucqI
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Use PHY API phy_get_ofnode() helper to get PHY DT node.

Signed-off-by: Beiyan Yun <root@infi.wang>
---

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

