Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3698ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B1D84962;
	Mon,  1 Jun 2026 14:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rIJ0md/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE34847B0; Mon,  1 Jun 2026 10:13:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6321A8486A
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E7A04466C;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 080D6C2BCFB;
 Mon,  1 Jun 2026 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301573;
 bh=tMQjCY4t9y38brpMB105WJcWhKQR2bPmrP0FCBMg+Z4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rIJ0md/aNQMHdupGrcJwXdl3BNNJ+dlSwXc/z9tHxq0cv73qA8BTYNz4DHSQOnenO
 OHmFN+cE3EyqKBqyK0p7rveT7PG3KARuY6r0r+q6h+pv+MLnrFL4l+0LfqdGV9PDRq
 xR75/hGiIbE4lLkdHcjVFx0uLWVNaEZLcHU20s6OfhG0JEitauoFoY4+o2pCVPRIGt
 BoiKld5epSaXCBLIzJX1PIGIPn0+m8IDfbi9CMAXYtQypkkqxOzh6Tjn3IIvDQC2n2
 fSZfmeBKoGgcwSBgSLpSvoUDGauluTWUIsBGzDPQkJLcD9zL3AWuZsLkq/y1H48iA6
 gikFBBIUYBUuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F2163CD5BD1;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:55 +1000
Subject: [PATCH RESEND 14/16] clk: qcom: arch-agnostic pointer fmtstrings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-14-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=1199;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=arEZXUejhz2XTT4qW5woBRmseXPtJT361FuxHNEfPWE=;
 b=YGl6s7PYpglxC0Ra9nY75aSB2l0cLhQD/4/Kc9HWWB+sV/W/HW0rrPnuafrWqPXb1VLm3uUyd
 1eq5pHfUWP4AHV1aZRfQKoKCZgVaJLQgkePvT+SpqIvlyPOkpfPz0pk
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Cleans up some warnings when building on arm32.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db744..0f8c7155784 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -77,8 +77,8 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
 int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
 	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
-		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
-			priv->base, id);
+		log_err("gcc@%p: unknown clock ID %lu!\n",
+			(void *)priv->base, id);
 		return -ENOENT;
 	}
 
@@ -115,8 +115,8 @@ void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
 			break;
 		udelay(1);
 	}
-	WARN(count == 50000, "WARNING: RCG @ %#llx [%#010x] stuck at off\n",
-	     apps_cmd_rcgr, readl(apps_cmd_rcgr));
+	WARN(count == 50000, "WARNING: RCG @ %p [%#010x] stuck at off\n",
+	     (void *)apps_cmd_rcgr, readl(apps_cmd_rcgr));
 }
 
 #define CFG_SRC_DIV_MASK	0b11111

-- 
2.54.0


