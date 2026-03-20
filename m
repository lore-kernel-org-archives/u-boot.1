Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0A1099B56
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698F883FEC;
	Sat, 21 Mar 2026 00:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Iz8Mk8Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C164B83FE1; Fri, 20 Mar 2026 16:45:54 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E8583FC5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+casey.connolly.linaro.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B23A438CA;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31556C2BCAF;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774021549;
 bh=4VToLEIlcpguQCubwutmR1dREZwgVMGL3KSDZR9py8s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Iz8Mk8Xc4cuxj0K0PkNte9v1FrmRU7PIM8nDicMODyb9mwdSmX3Z1td9WwTIGKjIf
 XvuVy3TpTdBqjpuArnNjTEJyT94qndBlyEgig+9buEredtYFyJZeGAeFND4FaEBD9z
 N7VDPLaZv+d+11sL9rCpmNY/au6h/YCc86mAe/cNc+YggEBXvcu9/Nuo+QAGG5QRIk
 L27YPbrD8Nvg/7/bDMJytcYNxF6gZI9nAY8tvbTA9ktoETdQmys2K4OJeyeGMMY3ze
 BFnfJKFdal+7QCMoh3xxAH5K4abXXiGlnAsC1Z3mixQ8q7dChtZvryxZ6Q5gBXPBWu
 d2OE+iuNIFW5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 22E1A10987A1;
 Fri, 20 Mar 2026 15:45:49 +0000 (UTC)
From: Casey Connolly via B4 Relay
 <devnull+casey.connolly.linaro.org@kernel.org>
Date: Fri, 20 Mar 2026 16:45:41 +0100
Subject: [PATCH 2/2] qcom: rpmh: don't error for SLEEP requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-casey-qcom-rpmh-serial-fixes-v1-2-b81d05832eec@linaro.org>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
In-Reply-To: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=WjorGVF/iuEZ/FpHOQ1r5KECPmJC6p/Q/tEa6oJzdIA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy92WvWMN8rOabybl0y42P+ZW8duiNvp1x72a0+jy1h7
 /I10jEbOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE7Bcz/E+8P7vgxLkasZWc
 H3/0fPpoPneNO8eT+DDZwDUzDk3osi5hZJjaU/R8A8ulZ5K6+6acjXScXr/l9hm1RP/s5yrLe+K
 OJXUDAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Endpoint-Received: by B4 Relay for casey.connolly@linaro.org/default with
 auth_id=688
X-Original-From: Casey Connolly <casey.connolly@linaro.org>
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:11 +0100
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
Reply-To: casey.connolly@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Casey Connolly <casey.connolly@linaro.org>

Just stub them out since the caller might also send active votes. Since
we don't suspend there's no risk of missing votes here, we never enter
the sleep state.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 8 ++++----
 drivers/soc/qcom/rpmh.c     | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index dce61f262292..0b821cc6f9d8 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -260,10 +260,10 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	 * U-Boot: since we're single threaded and running synchronously we can
 	 * just always used the first active TCS.
 	 */
 	if (msg->state != RPMH_ACTIVE_ONLY_STATE) {
-		log_err("WARN: only ACTIVE_ONLY state supported\n");
-		return ERR_PTR(-EINVAL);
+		log_debug("WARN: only ACTIVE_ONLY state supported\n");
+		return NULL;
 	}
 
 	return &drv->tcs[ACTIVE_TCS];
 }
@@ -389,10 +389,10 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	int tcs_id, i = 0;
 	u32 val;
 
 	tcs = get_tcs_for_msg(drv, msg);
-	if (IS_ERR(tcs))
-		return PTR_ERR(tcs);
+	if (IS_ERR_OR_NULL(tcs))
+		return 0;
 
 	/* U-Boot is single-threaded, always use the first TCS as we'll never conflict */
 	tcs_id = tcs->offset;
 	if (!read_tcs_reg(drv, drv->regs[RSC_DRV_STATUS], tcs_id)) {
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8c222324c66d..b55e23c4417d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -59,10 +59,10 @@ static int __rpmh_write(const struct udevice *dev, enum rpmh_state state,
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 
 	if (state != RPMH_ACTIVE_ONLY_STATE) {
-		log_err("only ACTIVE_ONLY state supported\n");
-		return -EINVAL;
+		log_debug("WARN: Only ACTIVE_ONLY state supported\n");
+		return 0;
 	}
 
 	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 }

-- 
2.51.0


