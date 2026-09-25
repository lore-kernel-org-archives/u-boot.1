Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48852C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 07:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0536181216;
	Fri, 25 Sep 2026 07:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y15CBVW8JbMf; Fri, 25 Sep 2026 07:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 287C6811FE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790322082;
	b=mOEOet8H7mxGm3PzSL6qVfmBwhu0L96dEHySm3UCsgV6+BrOgURfXs71UxDiT0HR4Gl9
	 bMc8ZUzQQEkqXuzeJivmS/qp6jbtotjIovzhPjoNjpzq06GzQI3zlu8AdCAky4sN+/Ebf
	 ECgBNOcG/hCa3khDvtXOB14dX7ordh2SQGFusfYWTfl1GcrSyI5QK2TLsl+sCoUeAQLPf
	 OxxqHTwb1v2Jp8NZkrA27OFVe66Np85hHopWefx2uKwlqp17US/noedwmu3rD97dDwaS4
	 4Gab+r4GAQs0Kvs9aMmI49PU9IyNck5FSG0oSuCt6Dvjn1cwd7LbnqgCxLrLHx9ZcAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790322082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3U5KuuWSeeDG/8Zip24IYYm72DmyqsM55qhzx5S8ojY=;
	b=jH0abV62vwfrNKUjL8ABTx9cC3VbygGa509+7YE7hbWfAFHSig2ZLTFdR2+ZXPBs98Tf
	 V3gZBY1UM9tka8gglff+04E2TzX9hWbyz+IxQ0pXm/C+eW73vFEIdL5fF8fDfn5y9RYra
	 pJkEtfPZvcBn9U4kF34xCcqIqBYQT7KJqhJw9JD2gKN6ezDZ9xBZiCuFcMtSO04TJG86x
	 dmjZ20BWsjBChbsrJBsQdPoNRvmDu6EGWVA0aIpix8+8swe3olVL7dAQmuV+z62tLQUGW
	 58e4QXa9YUVoMZk6TRjyksd1YLbnFvfTOw+eUEkdPQ/WfL5cTBGL4eaJS9VeX60YzBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DimxSJk6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790322082;
	bh=3U5KuuWSeeDG/8Zip24IYYm72DmyqsM55qhzx5S8ojY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NCDmW3ySc6LyVIUrbaKqLQZ+c5lMe4mnMQTf2h2gxVOUeeSR7a17WAzCFfvHsjQNd
	 FaMz492Z+og7uZsev1SvQRTECAoQ6f1gbICP8pkLSbO2rU1dzxLIFyE6cP1GhZFbLo
	 j6BiWK1qCilaicqBlUuWnlon1QG9IN9XL+3Mq+F2hOKlyoMeb1f8rT5tOsNLMKGTO4
	 GXclgNVJguAtauov6kLyH7YdHWEuFBrab/zX1e8H/Efcx06vyZMaxe0WbKdKe/Sv4+
	 KqYWVot7ukwszt1FRrErB7VhzGnhrNfcqwBmJ7KZqJdszpvm88UmMSgEIiOaa2pIeL
	 SZlqipvZW++pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 287C6811FE;
	Fri, 25 Sep 2026 07:41:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03EE332F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA175811FE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waAR5mLWVNHy for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 07:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D19FE811F6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790322080;
 b=E+RR688QPJ/+3DmEk+E0+bqSNg1M+SXJjammscyh3+7lSDdnr+enHnZjhgeRLNQZZHYF
 o2yJGrx5+uVQMcwhUITcpnW5pFMmdM1Jn8XtMk7imIQY2qDX5rKAP14lSi2jQLgXh+fnk
 l6wDo8Oyi4SMXUtvNHfya2deYpzOJMbckenHm5qsA1E24oJu3t/lUZ6cLHTWj0PiH2iqp
 pW4HjLoH+XbciOkJ4/8bQ9f0XWOSjaX9Tw4+ktH/hBY04sBU5o5QifSZ1evSKVB4L0EP0
 dBs0cAbIiy7TNCkCnDJ7N6xa4127KWATV4Y9EKYomWiopKHAU4mMVh0J95VFNgYk93w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790322080;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=3U5KuuWSeeDG/8Zip24IYYm72DmyqsM55qhzx5S8ojY=;
 b=EzANH5qQ79j5Ad1t6LYkGsFhjnNIB42lllTWcTshKvdvXXehBfNTnEWlok3hpbr/HIhk
 Knn2M+oYT4H7oJRftgpLhoyx9Ags1FMeQ0cKPlXr/nFSVxh5s4k5eLPzM5yx/uJyxQwpQ
 lsUy6As5q3BGuSPOO7NuVvt6FxnIClY8g3O6ZIqyos4CXR9348C62CvfPLFLV0Qd+/1bn
 dTxRojH9SB0gH2fBR2flqrcgZMoKoAhpVPMYiGItxMukdTjtSuFP95jU+H1ITwzixlx5L
 nIrSxDrz4vLSJEOXMDsY11pQ0yB2Cl+BS/ZYOftC1D2l923gx/lww+4b9vN7o7u0uoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DimxSJk6; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DimxSJk6
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D19FE811F6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:41:19 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48881a62e09so46554f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790322077; x=1790926877;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3U5KuuWSeeDG/8Zip24IYYm72DmyqsM55qhzx5S8ojY=;
 b=DimxSJk6n8tbNHUD2MjyZCr3EX3lsfU+dC43X500wjT/g0d+zOl39Ly9oq2a1HA39i
 COqhutieZ2E1qfrHH8IKz/cIQ/KtmYFygi4puUpgd7rgcIlju2n/VsSZqeD48sYQJryU
 ++fE0Gko5ksNd71bkMD7dExysLIkohzUlXLc5rcJX7i2kWOUvw9mPYt8XK8uoIK+EBpF
 lH9vvv0aGKaAu0HX/95IbNbLAQOyN/W6vSBiEJ5eimaoaoXQnbojPAMmEDiKcheYf/AS
 m53EdmggcFfM4kanMmPcsHt5fHUjn4r3Bwy8Cp8TYTQXia7AvBeTmw4aauu0LNz2+Rk5
 8yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790322077; x=1790926877;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3U5KuuWSeeDG/8Zip24IYYm72DmyqsM55qhzx5S8ojY=;
 b=yhXrMBx1VKwZqetjFuzAqa5/64yiZ+pQVHlzPts0ALQa9ec1vR86wZwNVDahzg3xG2
 XFk8VoMAtMiUkEylp9WYEt1tTpHfUYle1jM2patMoH0MXQw/WSqLEWWRDedgtb27/SWl
 5aDgHiPNmb2T0nZRYZtqhqdiNcc2289CN9tWqp3TjbASug8rsWUfz1YzQd5dzjWo9r4Q
 lQSj+gmwtw3ZP7uMchf43ci9yTTjVUgVhjQs/7G6pr0/JzZ+yk2Z7R4Pzr+iQDFa/ewh
 EA1ZeOvp2vBdkXKbU8ABJt9nJmnKajvxMA/GDUVO8TUN328k8kzdHvHlNq0FMxKDhb/h
 UmnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz02vfxeOc4bh53Lis+mk5ekYx0IHrlKLPdgvpyaNmrLHjedQMBLZCYHFOGH4RWcXpb22abA/s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mkJk7ixBIA1hoexI8YJllpcnBm6elNMAKLfIvG5rEbTUmE0DN7
 WOMiqMkox3Uz5qmvuKANVIjj+1l4c7N5FaOAIob/1CtmtMQdbiwZKa8ncig1we/7/5dNkEyP1kh
 81wWnzMs=
X-Gm-Gg: AYBFou2uQNH3e4x3gv9FKZr5DyFAIxtyo4KpsTwJDKHJv7XgMxsOPmN1ktGGaYZ0syz
 /DsBINkUyo7U14lESTvkIwURgJtWJlit/s7XEket9ULYczfOGdkstWRvi+MIOHkQyV2hmZQLpIs
 yun5VtpuaZjYlEZwni/ci96rxiTKaMWmFF+wLwf1qJuGBbuZIxCfekMwVeVi+MXbUjt922CYnlV
 eqXbcYfcpiAOMC+QuwnO+j8tMQkHu/RWyV3YVqXSR46Dw5tLs068+YLrz6bOBBeqxqgwiQ8H1WU
 Sn74apjrzsGOHuthYJdtGaXMt+k2g/BFP2DJ10dRIqqwGsGiLg4+EociiSoF+Z+vG4TMHT/Bt1L
 WSP583cWSH7v26XrGTfES0A3terVJWp+detWjeX7rngwXNlcbm8pDw8jhJrc1vSkyhE6fwutIJW
 P3Y8naQSBoifk0Ryq7BgVkQaDPc+QbMQPdUIEv7XSIuLnqprqO3Z0XD/sUrF4uYVnpyRmGM2mX8
 eMtB/Ln/i51cyoC8sPps3oBC7F+nlsUycdPPp455DMDZf+2S/nUh0z/BQdKG/sBsR5uEkOs/fns
 Kk1UyoKD+u+/xmWgIUQT8NigSmLqwOceVnl/kFUKMg9uVQvrETDqVo0=
X-Received: by 2002:a05:6000:992:b0:487:8ef:2fcf with SMTP id
 ffacd0b85a97d-48871759745mr8689120f8f.38.1790322077620; 
 Fri, 25 Sep 2026 00:41:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354c47sm5268957f8f.15.2026.09.25.00.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:41:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 09:42:41 +0200
Subject: [PATCH] clk: mediatek: mt8365: add multimedia clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBAAv0J6dhNaQwW/YjyU7qqrFHTbEhPC3
 63KcZLJzKIiCVNUx2pRQjNHnsYCelcpf3PjlYCxsDK1sXWnLYTU7m0DDhFCHjgQsgM/TP4BKDy
 TgEfjDq3vG+y0Kp2n0IXfv8fp/OeY+zv59A1vhtArl3natHX9ACZIiMiaAAAA
X-Change-ID: 20260916-mt8365-add-mulimedia-clock-driver-cd2a78cb5d91
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Add clocks for multimedia, used to enable video. Imported from kernel
commit f00b45db02ae ("clk: Switch back to struct
platform_driver::remove()"), which is the latest commit touching
drivers/clk/mediatek/clk-mt8365-mm.c.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This series adds multimedia clocks needed to enable boot logo support.
A series adding DSI support will be sent later.
---
 drivers/clk/mediatek/clk-mt8365.c | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 0d74561ace0..1f545dd829c 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -756,6 +756,74 @@ static const struct mtk_gate ifr_clks[] = {
 
 MTK_GATE_CLK_TREE(mt8365_infracfg_tree, ifr_clks, ext_clock_rates);
 
+/* mmsys */
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MM0(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &mm0_cg_regs, _shift,	\
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_MM1(_id, _parent, _shift)			\
+	GATE_FLAGS(_id, _parent, &mm1_cg_regs, _shift,	\
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_MM1_EXT(_id, _parent, _shift)		\
+	GATE_FLAGS(_id, _parent, &mm1_cg_regs, _shift,	\
+		   CLK_GATE_SETCLR | CLK_PARENT_EXT)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_MM_MDP_RDMA0, CLK_TOP_MM_SEL, 0),
+	GATE_MM0(CLK_MM_MM_MDP_CCORR0, CLK_TOP_MM_SEL, 1),
+	GATE_MM0(CLK_MM_MM_MDP_RSZ0, CLK_TOP_MM_SEL, 2),
+	GATE_MM0(CLK_MM_MM_MDP_RSZ1, CLK_TOP_MM_SEL, 3),
+	GATE_MM0(CLK_MM_MM_MDP_TDSHP0, CLK_TOP_MM_SEL, 4),
+	GATE_MM0(CLK_MM_MM_MDP_WROT0, CLK_TOP_MM_SEL, 5),
+	GATE_MM0(CLK_MM_MM_MDP_WDMA0, CLK_TOP_MM_SEL, 6),
+	GATE_MM0(CLK_MM_MM_DISP_OVL0, CLK_TOP_MM_SEL, 7),
+	GATE_MM0(CLK_MM_MM_DISP_OVL0_2L, CLK_TOP_MM_SEL, 8),
+	GATE_MM0(CLK_MM_MM_DISP_RSZ0, CLK_TOP_MM_SEL, 9),
+	GATE_MM0(CLK_MM_MM_DISP_RDMA0, CLK_TOP_MM_SEL, 10),
+	GATE_MM0(CLK_MM_MM_DISP_WDMA0, CLK_TOP_MM_SEL, 11),
+	GATE_MM0(CLK_MM_MM_DISP_COLOR0, CLK_TOP_MM_SEL, 12),
+	GATE_MM0(CLK_MM_MM_DISP_CCORR0, CLK_TOP_MM_SEL, 13),
+	GATE_MM0(CLK_MM_MM_DISP_AAL0, CLK_TOP_MM_SEL, 14),
+	GATE_MM0(CLK_MM_MM_DISP_GAMMA0, CLK_TOP_MM_SEL, 15),
+	GATE_MM0(CLK_MM_MM_DISP_DITHER0, CLK_TOP_MM_SEL, 16),
+	GATE_MM0(CLK_MM_MM_DSI0, CLK_TOP_MM_SEL, 17),
+	GATE_MM0(CLK_MM_MM_DISP_RDMA1, CLK_TOP_MM_SEL, 18),
+	GATE_MM0(CLK_MM_MM_MDP_RDMA1, CLK_TOP_MM_SEL, 19),
+	GATE_MM0(CLK_MM_DPI0_DPI0, CLK_TOP_DPI0_SEL, 20),
+	GATE_MM0(CLK_MM_MM_FAKE, CLK_TOP_MM_SEL, 21),
+	GATE_MM0(CLK_MM_MM_SMI_COMMON, CLK_TOP_MM_SEL, 22),
+	GATE_MM0(CLK_MM_MM_SMI_LARB0, CLK_TOP_MM_SEL, 23),
+	GATE_MM0(CLK_MM_MM_SMI_COMM0, CLK_TOP_MM_SEL, 24),
+	GATE_MM0(CLK_MM_MM_SMI_COMM1, CLK_TOP_MM_SEL, 25),
+	GATE_MM0(CLK_MM_MM_CAM_MDP, CLK_TOP_MM_SEL, 26),
+	GATE_MM0(CLK_MM_MM_SMI_IMG, CLK_TOP_MM_SEL, 27),
+	GATE_MM0(CLK_MM_MM_SMI_CAM, CLK_TOP_MM_SEL, 28),
+	GATE_MM0(CLK_MM_IMG_IMG_DL_RELAY, CLK_TOP_MM_SEL, 29),
+	GATE_MM0(CLK_MM_IMG_IMG_DL_ASYNC_TOP, CLK_TOP_MM_SEL, 30),
+	GATE_MM0(CLK_MM_DSI0_DIG_DSI, CLK_TOP_DSI0_LNTC_DSICK, 31),
+	/* MM1 */
+	GATE_MM1_EXT(CLK_MM_26M_HRTWT, CLK_PAD_CLK26M, 0),
+	GATE_MM1(CLK_MM_MM_DPI0, CLK_TOP_MM_SEL, 1),
+	GATE_MM1(CLK_MM_LVDSTX_PXL, CLK_TOP_VPLL_DPIX, 2),
+	GATE_MM1(CLK_MM_LVDSTX_CTS, CLK_TOP_LVDSTX_CLKDIG_CTS, 3),
+};
+
+MTK_GATE_CLK_TREE(mt8365_mmsys_tree, mm_clks, ext_clock_rates);
+
 static const struct udevice_id mt8365_apmixed_compat[] = {
 	{
 		.compatible = "mediatek,mt8365-apmixedsys",
@@ -773,6 +841,10 @@ static const struct udevice_id mt8365_clk_compat[] = {
 		.compatible = "mediatek,mt8365-infracfg",
 		.data = (ulong)&mt8365_infracfg_tree,
 	},
+	{
+		.compatible = "mediatek,mt8365-mmsys",
+		.data = (ulong)&mt8365_mmsys_tree,
+	},
 	{ }
 };
 

---
base-commit: c7926635a0a0fca54087118fb1373b0551a1bd07
change-id: 20260916-mt8365-add-mulimedia-clock-driver-cd2a78cb5d91

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

