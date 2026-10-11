Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAEDCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8132A80C88;
	Sun, 11 Oct 2026 22:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1fEsszLn4SV; Sun, 11 Oct 2026 22:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFD0680C67
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757850;
	b=ebcSg9qXl1CQKTLBVosro0KqN7wGLEjTUYtdZbZmyLVzfRCymz+25LBn4UvFn0HkUmJR
	 UYbmPHyyZpDD8+akYwbp6rpunBOyXNI7a/WchXxKk6EPG16tUCyq8NRe1GdPxtOqxcKPL
	 mUvmg+QYYcwnY9zGTiGkt34rWoLbvGN+sZhc3835D/dMsVxiLKBYY48wqFh8O7qUjFt6u
	 mL2JtBA3mYzOWmo3U+6WswL8BdSajrWD7rOdasr/fZNpkR4HIk84jtQ6drq267gJeMl8c
	 xRznhN90v38S8tuYMIPThDeqohLIFrZ4QNhlruktNMiOcjftYaNFbxNGnMu4/V94E7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HV7sqRQE9BSHzmJQSYicRz1lHGwrt3iJO7N2NnX3edU=;
	b=RWgrJLwH7JAWflzu2GFkyybpeVO9mtW3gu1cSB4g44aikobgWOpSg5g/W6T/Bwbf2Em4
	 2YhnE4saG16JJPsKAcSDjmqWsn3Hb9u4v3KFuvsLlyUyHqNj7PZfoD4ks0dccRwgZEsJ4
	 56VuFqweF+Fj0aBtKgWQHRHbPIqhclqVMTyE53AWgCU+PDGPfGF2c/tfgPgEA08q64mlH
	 fw2jOid20BKW+ZaHrf1y1Oa4Hf5h61bibPdtpja0YGeWgp0Qm3bAus9abjem9fOga0LZ6
	 qTZ93ayr36sl9maWL91X1HOSqKRoGcHxKEcUOIkAY69Sxoqdz6M2oUf0lY364wzfPkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TWVGd77z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757850;
	bh=HV7sqRQE9BSHzmJQSYicRz1lHGwrt3iJO7N2NnX3edU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KGSleONT4ni6Z987+/WkH4eGJqefMoQEd471Z+1SdR/ODoQDCVThQeGDa7N1tTosQ
	 eWw9o+fv3VQZVwB0afDPOhvQgPdb0/XLfUEkOLAgVtbc9hWTuyyy8sehJtcL4CBP8T
	 6BU0d/eb8e8sC1DQ5R6W9hYXSV9OqsWthMFYLePjPF+HxI+lnDBxZe/AEcvH3rPakW
	 zLlI77d0hWBQgnzvrx7cEuAPwqgQnztLZ7lVIe+OxW5wt5MpbLLQk2t1+27GOjTl1B
	 wiwpihvJTClPuSXhX8nJjJo0jrOqUtSjWhuhPS2l/8OR9nZik3TRXAHADy5YJ78pXm
	 pW16HxfhwMAlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFD0680C67;
	Sun, 11 Oct 2026 22:30:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07ABE1DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E790880C76
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLGJowhHdFTa for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44F5180BDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757848;
 b=Tp9QeJ9X7UjkJIDJrHDl63A7Lkq20dinAHfgkdTfxfL4lJr9D5TGThGH1N+gcoTnGW6I
 SXfCiTcSb67kVj1xILMlnksdkB8EkkMk5K4wcaTO95Ui/XRzrIIzPuJaYGkt7IVsNrlj7
 0hRyXR6RdK77YRn+oxBXCQDI6g1/TigbZJFDvpD3RzFPEyUwvIsOMMMLw9bW/U38IJHLw
 ZtbAQE4IO5WMLwOqGdt0DmbNf1jntbFoH89zZUO9l5YJkh6Yjoxq/oisC8Tbu/h4buixF
 UdZgpAtsE1+U4i9sxOs+4ZOp+fVhcRdM2Ws3mnxJfXkD0dhgO28Vk0RBscBUNlCGkJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757848;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=HV7sqRQE9BSHzmJQSYicRz1lHGwrt3iJO7N2NnX3edU=;
 b=T/H5xcc8fV3GCkplFkA4yZUqADc2ptkkAwX7GwV9wY5rFrJ2BHmi+qRN4Ac3xdSuFNZh
 MUo+6TG2JfjhnMAAsLzaPXGAGYEZxUuBLRO5enrqSkiNl3G418SPjLtn9O9DaIC2K6ag/
 Es904hiaHNpeM/DHsnZJSYulVmg9WU/+LKxTJ/FcB9DyG3+Dnm5Z681e5CnrARxtWqvk8
 pFRjt3mXdxzZzzrnjl7yIMD6MM3k81tfc/CsxS09lInonorBSmuzREJajUASdftE/tGhu
 dtjLpyHz20EJ8A+cNtA8us2Z+xfbmkSOXb0op9ZFUKTe2JHgZsYlGaq4sRJs9RdHRnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=TWVGd77z; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TWVGd77z
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44F5180BDB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757847; bh=HV7sqRQE9BSHzmJQSYicRz1lHGwrt3iJO7N2NnX3edU=;
 b=TWVGd77znKlYQSX72KVZh6PvBbL+5jt7k9PVpI9GaaAIoYa1I3EbWlSCXInSoaMzvuO1/HLqk
 QrI8o/91pUGFhAq9CgMkS9BX3gSdUrbUf1shlLP5wlzMDhWK0zeqXBzc2LqxjHJuCC/YE+qVdnx
 0Cwqzc62tBY+Ayu/Z7kGkdZwT9jWO3qV+sp0p9Mx38NwKCZByW+9FseYS0Of4EpqteC5yPQJ7n6
 hfADaMxywrf5PuIIM2YF8bBKLH5KnQ/X5PrR+rDT5KnXlZo2Kv+VoyNIU1CjDnFkauttt7WQ6/J
 TU7XZvE69Dg8JAJvO6GWkgK6I7ux/iRjRxvFR2rHjzMA==
X-Forward-Email-ID: 6acc0e114548822a24c17484
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 18/37] clk: rockchip: rk3588: Use SPLL_HZ constant
Date: Sun, 11 Oct 2026 22:28:53 +0000
Message-ID: <20261011222930.1085075-19-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The SPLL rate is set to SPLL_HZ (702 MHz) in SPL phase.

Replace '702 * MHz' with use of the SPLL_HZ constant for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Update commit message
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index aba200ad2390..662ff44397ac 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -777,7 +777,7 @@ static ulong rk3588_mmc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & DCLK_DECOM_SEL_MASK) >>
 		      DCLK_DECOM_SEL_SHIFT;
 		if (sel == DCLK_DECOM_SEL_SPLL)
-			prate = 702 * MHz;
+			prate = SPLL_HZ;
 		else
 			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
@@ -817,9 +817,9 @@ static ulong rk3588_mmc_set_clk(struct rk3588_clk_priv *priv,
 		}
 		break;
 	case DCLK_DECOM:
-		if (!(702 * MHz % rate)) {
+		if (!(SPLL_HZ % rate)) {
 			src_clk = DCLK_DECOM_SEL_SPLL;
-			div = DIV_ROUND_UP(702 * MHz, rate);
+			div = DIV_ROUND_UP(SPLL_HZ, rate);
 		} else {
 			src_clk = DCLK_DECOM_SEL_GPLL;
 			div = DIV_ROUND_UP(priv->gpll_hz, rate);
@@ -942,7 +942,7 @@ static ulong rk3588_aclk_vop_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		else if (sel == ACLK_VOP_ROOT_SEL_NPLL)
 			parent = priv->npll_hz;
 		else
-			parent = 702 * MHz;
+			parent = SPLL_HZ;
 		return DIV_TO_RATE(parent, div);
 	case ACLK_VOP_LOW_ROOT:
 		con = readl(&cru->clksel_con[110]);
-- 
2.55.0

