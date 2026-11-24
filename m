Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E8606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=StzYY9kY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=ofDLrHYL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AD04607CB;
	Tue, 24 Nov 2026 07:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HU4OzUU2OFWP; Tue, 24 Nov 2026 07:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA63C60789
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795506017;
	b=bFCveCqAcn4c+UPNGEG/TsLTXMZRktI2EhqO6rebE27rFoEk5NyxhYKgk8KLQemCdDVn
	 tdU/Nspb5YMQDRoJ4B5NE0JXA099ZgKJmaBE0f9eXN3kMatRzYPKa1sZNm/+vg0Fc/knI
	 vFwYuGNS9/EJXX5amSGFORIhxR7sVnU5HBL2BtV1rdjKaarbspgHiFVI16blVedvDTpgA
	 yzBisqOPYLLBVg5PdRWALhokhiDZESLA9V1aq5wG7D+PBm3ZNErpgS2/QDkLmDYY7e8Xw
	 /iDafLhNpFFArvYIK5n4o6dQkyVPXXYSXM6t2SIQa5FDsV31ecMOuSUeLHuayDB8LLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795506017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=imAMIv7cSs8NAVVHWLQ15xko17szTVEAkM8o2PWqL+I=;
	b=nnP3E9cMykMPomdu7p4zLkXvSI7VCZ6Xuu2JVF7XirJ+2K+8VrUSDXke5/WNRTfn31Qb
	 BTT9MxyIysnuZhjP45kZgiyhXQEzuPlDC6+qc1okH6n8WwLajEvi2EhIjEL7omtcW3zV2
	 IvHsjRhxQCscSr/KZ/HhdUil0Gw4jYjXMHB2xhjNkSSVn4LzxIrtIc47gRmPPR7x2z2RN
	 a/hoCi8Ex5S6E9y1D/HZ8Aeq6qPBqSBCBUHWJMbsxzfRi7Ko/A6DzH/6lRn50t8LyUPPw
	 8pDwQdJdB2OQ8GX//clHJcu0qvlFIABUz7AlapnVXEuYPOKV2gyrM+yDATySd87fCJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795506017;
	bh=imAMIv7cSs8NAVVHWLQ15xko17szTVEAkM8o2PWqL+I=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=StzYY9kYwzbAv/D7ZS8RxIcekQtVkZPpN+/vrMAKJErPUkUn/ViRbpv0chZC+svXb
	 p3XLIoyq0Ctqwz9fDk8FVeivhjKSN08OkRyOohTjT82DTi0ld8BqhBdvkTR6gaa4Iv
	 eeFFj5Ih6UwWDpU3py2uA64VbxDh3p9ya3hXQ2mwyQygvz4oekHQYNBNT9TGWjuTNn
	 GUKv+0mfqXmi460hGPBkCa8hmSDSsCo0CTfbVYzbjFz19k4hFS86cjSsgFw/5pwx6E
	 YVkMs7TRISU3Il1baIEs/g1jE3csMYIv5nxxuHqz4DPC5jEyTvNb2iiL8Y3c/GaVYO
	 Ju3ygpgBzgyzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA63C60789;
	Tue, 24 Nov 2026 07:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0838AFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA0B1400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1u9lhnZiVcWV for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:40:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2761240068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=ofDLrHYL
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2761240068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:40:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ofDLrHYLfAfaKuoTb4J7DoEuh6ltHCfbj+VDhtOPn8xPYEySHMqSB6374DguPbVsijh58AedwfQnBi91D/576qOA0kbGYYwF0KH1NUAk6uLpdPVo2w3VfaXD1SIfc36EEdPg5KiP9DzzCsTFGwILCRRVmM4pLMjogsC2PXCFJ9c=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=imAMIv7cSs8NAVVHWLQ15xko17szTVEAkM8o2PWqL+I=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179550597942598.25598397447789;
 Mon, 23 Nov 2026 23:39:39 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 24 Nov 2026 15:38:04 +0800
Subject: [PATCH] clk: spacemit: k1: Use generic CCF enable/disable
 callbacks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-k1-clk-fix-v1-1-fca6382fdf48@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CMBAF0KtM/ppJOo0B7FWMC6lTGDFoWjQkh
 LsbYfk2b0XRbFoQaEXWrxV7TQgkFSEOt6lXtjsCwTtfi/gTj8LxOXKyhdNZ2tR0vnZOUBHeWZM
 te3a5Hi6f7qFx/g/Yth9iPc9wbgAAAA==
X-Change-ID: 20261124-k1-clk-fix-f918f7b26001
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4061;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=IRcLL4M+SwaWABNWzgF1tRBuKBpFcQONTRlnM0JesZw=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJZ7Q3jMi6zrqx0m1JueEcuLqjp60fuN0ne3+d7fj6e8
 XmSk31ERykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpADe5geF/XZDfcqkTE8yb71d7
 GifY7JMt3Xnyzeb1DadPyXA21a3LZGS4674vJcHv/Il9q51vqq2VaanL/NOcZZzHfbXxdYbJuhY
 GAA==
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The custom enable/disable callbacks look up the requested clock in the
provider's clock table, handle its parent and call the gate operations
directly. If the ID is not found, they still use the caller's struct clk
as a hardware clock. The gate operations then interpret it as part of a
struct ccu_mix and access invalid register mapping data, which can cause
a load access fault.

These callbacks provide no K1-specific sequencing. CCF already handles
clock lookup, parents and reference counts, and dispatches hardware
operations through the registered clock's callbacks.

Use ccf_clk_enable() and ccf_clk_disable() to look up the registered
clock by ID and delegate to clk_enable() and clk_disable(). Return an
error for an unregistered ID instead of accessing an invalid hardware
clock object.

Fixes: 3aa2882a3e1 ("clk: spacemit: Add support for K1 SoC")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
I found this while testing SPL pinctrl support on a K1 board with
Anand's GPIO/pinctrl SPL support series [1]. CLK_AIB and CLK_AIB_BUS,
which the pinctrl controller requires, are not registered in SPL.
After retaining the SD pin configuration nodes in the SPL device tree
and attempting to boot from SD, enabling these missing clocks caused
SPL to crash.

The custom callbacks crashed without indicating what operation had
failed:

  Trying to boot from MMC2
  Unhandled exception: Load access fault
  EPC: 00000000c080a378 RA: 00000000c080a4f6 TVAL: 0000006b0000306e

With the generic CCF callbacks, the same test returns an error instead
of crashing and reports:

  Trying to boot from MMC2
  Enable system-controller@d4015000 failed
  spacemit_pinctrl pinctrl@d401e000: Fail to enable bulk clks

This makes the clock enable failure visible. The missing SPL AIB clocks
need to be added separately. This patch only fixes the callbacks.

[1] https://lore.kernel.org/u-boot/20261123193714.5096-1-linux.amoon@gmail.com/
---
 drivers/clk/spacemit/clk-k1.c | 58 ++-----------------------------------------
 1 file changed, 2 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 20b8595aa3c..ae2bdcbd18a 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -1501,66 +1501,12 @@ static struct clk *k1_ccu_apmu_clks[] = {
 };
 #endif
 
-static int clk_k1_enable(struct clk *clk)
-{
-	const struct spacemit_ccu_data *data;
-	struct clk *c;
-	struct clk *pclk;
-	int ret, i;
-
-	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
-	for (i = 0; i < data->num; i++) {
-		if (clk->id == data->clks[i]->id) {
-			c = data->clks[i];
-			break;
-		}
-	}
-	if (i == data->num)
-		c = clk;
-
-	pclk = clk_get_parent(c);
-	if (!IS_ERR_OR_NULL(pclk)) {
-		ret = ccf_clk_enable(pclk);
-		if (ret)
-			return ret;
-	}
-	ret = ccu_gate_enable(c);
-	return ret;
-}
-
-static int clk_k1_disable(struct clk *clk)
-{
-	const struct spacemit_ccu_data *data;
-	struct clk *c;
-	struct clk *pclk;
-	int ret, i;
-
-	data = (struct spacemit_ccu_data *)dev_get_driver_data(clk->dev);
-	for (i = 0; i < data->num; i++) {
-		if (clk->id == data->clks[i]->id) {
-			c = data->clks[i];
-			break;
-		}
-	}
-	if (i == data->num)
-		c = clk;
-
-	pclk = clk_get_parent(c);
-	if (!IS_ERR_OR_NULL(pclk)) {
-		ret = ccf_clk_disable(pclk);
-		if (ret)
-			return ret;
-	}
-	ret = ccu_gate_disable(c);
-	return ret;
-}
-
 #define K1_CLK_OPS(name)				\
 static const struct clk_ops k1_##name##_clk_ops = {	\
 		.set_rate = ccf_clk_set_rate,		\
 		.get_rate = ccf_clk_get_rate,		\
-		.enable = clk_k1_enable,		\
-		.disable = clk_k1_disable,		\
+		.enable = ccf_clk_enable,		\
+		.disable = ccf_clk_disable,		\
 		.set_parent = ccf_clk_set_parent,	\
 		.of_xlate = k1_##name##_clk_of_xlate,	\
 }

---
base-commit: ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6
change-id: 20261124-k1-clk-fix-f918f7b26001

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

