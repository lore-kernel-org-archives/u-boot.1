Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAA6C98325
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCBDF40B9D;
	Fri, 25 Sep 2026 16:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OhebFxcLQhuf; Fri, 25 Sep 2026 16:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2604F40BC2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352019;
	b=CLjSBRYeCkdV1vVgm/VGinfYyTA/3CxEkHCE+gxiXsoj6GFwPwstHMsXuKh0SmeB57U8
	 QI4Q4WOiw40qYDSnEA4x/q8OxlcVnDSQp9KSgyaAJFW4eMIiSuozejbLCP6s11l+a6G7J
	 M9Nr1E1DbGaD2gCDm2mMOQurUtEFPMrCwIav+x63cg+CTv6MjuLDDscbODSCUiwHVKC+M
	 6nkmyz45qS3wIWFdc2mkUunRYaEYWWIYukX4PaRmvPQv9KH8qWTQ5Vzsipyx4LYo7s0er
	 Yeati+diRyRtmzQri8gjEfRXOU3y91LtxpnqEd8WT4Mm0doRj0GJJF0QvHuupJRQIWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tYITwhZUC2rDbA/6FGBJlu38jbp1DPAixyPJbd+rfCg=;
	b=bukCsHuDEr7bmnw1TYmZb6DA1Jw/lNdOZtT1nXPUQppupeRMEY0jXLIa5t7e0aId0sEC
	 mizflQNu8OjqXNlK2gAoampZppM7TgREU+CVUt7Nbx2+K+0C38MY6MvwwHX4SdsBPbDcf
	 fidLm+mmZKl5lYdjP2LCOOJbAxPDRyyKusmp+Y88yGwPHqIqpJBySEdzlllaucuzRbkNA
	 hkQhbdVIvDj0pXe1bF+CGSZPocpXMEpTSz6JrKOZCqmF997dvy75cviJ0Rzx7aJw3h2xm
	 3WfE6TFkwaQLKzwQbO7HyMerzMCb7fW5Ed3/8dv9d2hjxw1XZWLDjV+Q/+fyy2Kt60Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CpZx53VY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352019;
	bh=tYITwhZUC2rDbA/6FGBJlu38jbp1DPAixyPJbd+rfCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uhEhwx0c/jYgbwYo9dW262w/Gcq7mYf8FhhqP1+2Z1ZYq6oK3yn1PE1FjimqL9EBJ
	 CT0QES8psqU3sCDxEFwRO8zrn8XfPABTtmduG0Js7W0fWGfbYPEsWyjoJp+VkUuxjx
	 eO4wpHjPlhWJokVED6Y3gZqstaqUIeZKVPeYuJjS5X4avwkhMqcxQTNPy/ng/qyXAU
	 cQF8zk+4F1Vof7PKRtv1seQb28aV5igeRUdqH4ySWJ6BNqxKsxoGwKLS4VfFF+3fvf
	 vGCs/BELp4YU1/YDtkppSKJ7KudjvOWDEtmGHdUOPphuHE7BynZJ5B+lp2BjWB0NR/
	 Cn0VQbLe445TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2604F40BC2;
	Fri, 25 Sep 2026 16:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD8C935A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C38A540BC2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDbE3MTnlWQ8 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AF5EF40B9D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352015;
 b=R3xUNa63lJGF6Y+3mJ7TJ/W7N25JuykZ1PNbcuEZ0oNBSyxtppMpEG9R4MflozsLT/HH
 mpPJ5aDlVKwpt8Gwzgw33P9fTV54VTsoNeBux5l/bJVR/kHbBNDhoj1sfAAVE2GZcsULq
 zKLWywKis9htbmAwQE7Al+SJS4jYTBCuedi9DnPwwn/APoTMRs30pienNW6jDrXKY00Yo
 +naOPpZpC5KjI5B5sZ0rrGoBRqGkK8QJJzb/CurdmS7ba4ohbB1BSf3EY+HdbWxzjwnZt
 yMJQ382RrU76U+glWcqznC19k6llAK9JTuptSFy2+r0jFvygwpvMk/BDR5nsrSSN4+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352015;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tYITwhZUC2rDbA/6FGBJlu38jbp1DPAixyPJbd+rfCg=;
 b=fcpMzoOw/IXPstsIBN+AdgKbsZQ/915e60okaulHqHap9Z8QldHPYoWUwP7mmopaVBTS
 PbA9JSXs2o9VzfJq9W5wwrXaue1ufZtQAgrlSm6PUKeLnVH8MlTERSG4qyl4DDfX2lD7+
 KfoKrVSZDcPl7opMR4zVMPc8XrR5GxiqTCH4CPiyuA64O6LjFBMEHuE2HWOGgYgk0d3ZT
 BotGdRLbh55F3QpinuHm41JG6EYmSyQ46UoJ/cAkEZsqoXK8p9OEbSx55cIZguixF+H+x
 tGCrKUHLLwnQwu0u+p989Q/qLYYI1/DTxKoeY8YE3vsfnLASZI2FCIW8hxOwPJX81gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CpZx53VY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CpZx53VY
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF5EF40B9D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:00:13 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-8167e0d1f90so651384a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790352013; x=1790956813;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYITwhZUC2rDbA/6FGBJlu38jbp1DPAixyPJbd+rfCg=;
 b=CpZx53VYDU2oywAGP9ICDpgMEmd9eqQqeUYFlQHVuPFkqerpVht9QeGWSr5FlvRV9g
 lDEzFPLOljZYlxKkKTKI9cW8w6G75wc0KFWtLRD6Ut355VEm1q40MFh+34/PUx2vgm2B
 bpzKBQvQFNTR6qJS+MW/vtE6DUelLz/fVM9fpNwQTN3x9Dh306eLCfK/BiHUhHqjojvd
 KYpyYsiicRLBGNP/zxqkjQj156GFuV1PBXVYsRAMI24NNUEtqDIiTkVMMl7kZw3iapHK
 HKm56EPc4Ukb+Jj2Rwgjwm2Uxa27VpDRWBzyiivq/zbFxzp/e+ZO8NWFpQHackPNozAR
 IRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352013; x=1790956813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tYITwhZUC2rDbA/6FGBJlu38jbp1DPAixyPJbd+rfCg=;
 b=0bbmxsGz0EIOLtuSQF4cI1vajLF6flvxgYSJOqlSMRPRsHZmysso8H/hiibYmCm+gP
 SGPus/jd1ylXQOXaWthm/UaW7iNkdVsQR7GwGVPbnd2OZnBPFmay6+KTcNlXfFDxXca7
 uO8PUp6OzdxVXM9bcN+ra6odwW+yu0ZeBLeJeBPEQm4gUy7AeSCyODuS8n/AKr44y2Gr
 K1D4tWNlX3YwvMMiLIw+B1hLEASRuD8kktOPXjsoXhyTsEPgNinQ44wGwBLKqs8VrryH
 8QBWFSSVnBnhZvJQ63CMsPinwLTp6zSQdaqxzFOvuExhKhwbX0xXikKbX5wrDN7r76yI
 mMgQ==
X-Gm-Message-State: AFuF++l+NbQyl4B81P2TE5nVuh5Pg9tWn7NNWFavHOQ0JsQ+8/+cS9Ma
 cPQJgVTCeeA25zPm+JN7UMRcI+8T1rsmULmdqVAj4qG3R11xexy5PgzmrjpIn/F01k8=
X-Gm-Gg: AYBFou1qOMBMC2JTvllWTDmcINWTyyh81a76QiXUNDrrV75IVXz5meDzRsJKqjjAz+2
 v7LSDhPIOk7D+18yQu0npVqDA6t51tERrjgZIFXx9Y+O+bShsc0TbGlrYXKFBwtbSKwtAIObI0v
 E9MG5z0yWXkHkLgBpIdvTcg/3QwsKcEGykiydKjF5IK5vaH7vLY/YlTAawSi/LrrBsDgXfu4Wcj
 HkSZKgoln+EJraSvm51Hxa59DJl7UgUEVic6aTpKDcyWZuyhsds2ZbWeoZHNkxYer4OLEiQTq1Q
 DiqShGsTcsCIpmO5cQRdOsjb0GipcIto+KYF3smUmIz841LWcZ04QRuYJoaKPCSX53EAikXkZOs
 8tgOkEupAowbCTjbxm++1WzSr/7lwcmvHaTWjIDAno6n04lHSZsOfjxr0evY5u6JPkOoVj1x9TU
 Xj0Ek3Cn1hy1CBU9t66ijuC/AXKQj9+usJiqsZ0TGk0fGb8dG+e1ArhHZ2vZ4sf5L7G12qiycjj
 jw=
X-Received: by 2002:a05:6830:90f:b0:815:40bf:e777 with SMTP id
 46e09a7af769-81781d92d41mr6962149a34.13.1790352012632; 
 Fri, 25 Sep 2026 09:00:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ecea:a30a:390f:322b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e6211cedsm2469164a34.3.2026.09.25.09.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:00:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Sep 2026 10:59:36 -0500
Subject: [PATCH 1/3] clk: mediatek: don't truncate the requested PLL rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-clk-mtk-propagate-rate-v1-1-8c7169b4eeb5@baylibre.com>
References: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
In-Reply-To: <20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=T/Mt9LRx9KYwufEg8OYyd2joSx7ulJQPVOFcMth55G0=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLK2zSoVS/x/uDyqLjEm/+qXieWik2PSZrskz3L7G61ey
 Wp6QHZ9J6MXCwMjF4OJmCLLG4mb85L4mq/NuZExA2YQKxPYFJmUnNTkjLzUIoekxMqczKSiVL3k
 /FwGLk4BmMKaUPZ/6lIpOw+2K1TrqTH1qsvFr1cTvn3LlTd7xvaE11Nv/Yq7U7Pr8Gnm7V8b4ua
 GZKenx99+GCp7iT/v/wVBn0sfi6NcnrVGGzE+Wsjgc9lo84LIY92314R5yJx/xmtrstjxYbLIc9
 ZpjKwe66KrD3FlsnWKn3D9rrVlRvgzl13rfkp05X3TfcLpecWyZ27krF0mut8//rp4MlS1Ztlht
 zmvNpdetjbkTT+37ecraednx/07Xcu5NE2sLJ+wL9BSVo8XOMx8X11dIO7i0vPq66pf5iUyP6pb
 PelVQeethJDa9t3fVR9ec+7iDI5LTjl97FVSctKzhemX58h3XbnNEr9wSVMUe2nKbNXLrpLe78o A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Take the target frequency of mtk_pll_calc_values() as a ulong instead of
a u32.

Clock rates are ulong, which is 64 bits on arm64, so a request above
4 GHz was silently truncated before the clamp to the PLL's fmax could
see it, and the PLL was programmed for whatever was left in the low 32
bits. Everything after the clamp already works in 64 bits.

Fixes: 0bd7dc74d2ff ("clk: MediaTek: add clock driver for MT7629 SoC.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index af5a210073a..b3f4a07c8b9 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -512,7 +512,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_priv *priv, u32 id,
  * @freq:	The desired target frequency
  */
 static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
-			       u32 *pcw, u32 *postdiv, u32 freq)
+			       u32 *pcw, u32 *postdiv, ulong freq)
 {
 	const struct mtk_pll_data *pll;
 	const struct mtk_parent *parent = &priv->tree->pll_parent;

-- 
2.43.0

