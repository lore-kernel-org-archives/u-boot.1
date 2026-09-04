Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC310C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB9BD40C8D;
	Fri,  4 Sep 2026 14:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lj5YzNZGky1x; Fri,  4 Sep 2026 14:47:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3CE0A40BFA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533255;
	b=cTWBlzqCCgiSOBj5as8ExaD5Jbsjk0m8oAwRp4qDh8cjLylC+9Q7OyT6fNAlxzFTTtEI
	 7auXK81tETqP7TghEqNIO1k6HEGUFcEEupjd3mjAOeHm8mTN7uUF1jFcvO2nppw7yeTY/
	 FquNccszQ18eyxcQB9i8lwUDJtl9V1bossz2V7nrbGod+UcWnP0C7A9HSQXQAtXboTpz+
	 Uf9rmxpICT173jNGiIOM+16SOEkFBn6mycm5NMU9OkaVlW+3bSFT9KrtQ+2PvD3cryKyB
	 848ldC/BGxBpgoxrmLURRdq2eQ6mKoVXY0KrgdXGzjqA0Y3gy1qn+sEkz+3VrNXwqVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5/jrBLaMTtXfJbs+c3h2YlEhImx3sdGvN3ec6y3eH/Q=;
	b=N81f4lQVKqrttSkimFu6xYacIF/F0IiIMWMWv1MCQ7i3QgI7yZNha6O+fnyJ0jN6XYEM
	 dxX2ECeSa2UwVovPT9ZrYTQYZ9oR2317FJoudcXW6tVws451rtV2YETzwNxx+8/OqXMXS
	 cZconEg3YdvR2L+FQCHYJcvbHD6Zd0mdHq0spA0e1XsXE5xhDj7oO9jf3mOAQrsjpKgtW
	 tT4v4FskmocuGG4pA4tfDNTUTFh89QMHIC7hyFKgRb+F6oMSjoN/wVQ0U+H9PjIOMs7r7
	 Vsn19em0LsOX/WL8NMnTAeeA5y93xk7PvxsEKcm0mYotj5g/0ij/LCVXsKX7phTN6mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533255;
	bh=5/jrBLaMTtXfJbs+c3h2YlEhImx3sdGvN3ec6y3eH/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWE5MTFET8z62wjC6b97fVuEM0RBVB9k3r6Oo2ysYRssVU0A/3pxH2XxrqQmGO3xE
	 +X3lglRbAn4N817my+GaS27YwSLhQSoBYORj+lRds3Dp5J6bplgSQrLitBSkfkJ4Gr
	 anlHUOmlcHKkOEkgdZ0ASa3H4kgHsWuArHIPagXJrkcK7ByS1FZHMkF55MiPvEsfC1
	 O0XWHXHDaPbFFn+jD7FV4Km25q6RLHzrFYL+eGfJcrAI8gNeaVKP1ah9hWpBfYqlqV
	 V2YdZ4ooWwxxfNwfyrpEMM55K4uvOjfmJeh/kiSvLhYR4NTMfMYadG/TC9FRxxVXva
	 /aFuhCOHeym1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CE0A40BFA;
	Fri,  4 Sep 2026 14:47:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3905410E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36F7940376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUqyiKHsw_S3 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5C384404CE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533249;
 b=Z0QRA71fAf30q/UgSpIAFnNKIVOCWHt768fmrNlyogrAEP+NUEZONqEGPCjQ5q/BBWVg
 xZJ03Wg35hJ57kQdHpUE5Oo+g2+Zc1ndJ3geTmEJNWs6RrGxyIaVUSmUXe823DZQUIoNn
 oH7Ortt0b9b3EdkgyFMuVVH0FW0mAYYzwmACsSeqyv3MSgzFijlqjlNhWqwzSDFKuHxmp
 KWv+7UhNgrV1nlGJ89nbIqwdJo3uZ0Asqz1Gp6PaxsFnrfFcPQQ5wDkiXrFEPto0VZbrL
 tMsHqeNSij/dhdBVAGkCjPA6O31Pu/CID7/WpqjymfXtJ/d02IGW6Ghb1Dd2vjwhaOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533249;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=5/jrBLaMTtXfJbs+c3h2YlEhImx3sdGvN3ec6y3eH/Q=;
 b=eKxr6/WOVmz0xMVEYQ/GgmrgK7vqtEY1S/u55qiXfQm5zks13RopDTDfe7G9ZMRcw85x
 yZIEAwTGuDUDRBkCqy5Rg5RAhptFBDq9xLfaTGY5NRpLPCIVGI+5W40PBRxV7ufbnPgDE
 jAquYD8/wzHFQxetKg7RX6Q28YF/48ACwP04Hg4dVDbb8s4CbEnHmZTMyz6ZGk2TgqJVK
 tGS7CQS3zn3FqCuwBaQOV2nIfL5i3Fl78p5WLihxtl56Asoxf8LoeJ9VZJCr8Yws/f/zl
 AQqcFaCOeykNdbB9Qct7b4RgsW2D5Lt1ZoVyFf2Lu35eF4hLA1F0hRLggqKfMLzFA9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gHyVkGvN; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gHyVkGvN
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C384404CE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-467a6834028so633715fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533248; x=1789138048;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5/jrBLaMTtXfJbs+c3h2YlEhImx3sdGvN3ec6y3eH/Q=;
 b=gHyVkGvNlaoo+23lQHnVSUuGHsgrvyCOjBw8s6qKQrwnINlvxEnFLNrREcaXbygqoA
 jlkCu019C4PlKWsO2bnxTh4CGkiBHuLEXO8SvYMH9Nc5e1MQAusIBx7dJqbHIKKZ63El
 YkznkQ+tlGF9XhLCYoR5fdyOQ0d2W54dfNDaPIqhzkz2GbM7Spu9qWYVto+yxTHAOuBR
 GFbuEG74pZsJMyJocfDZ1nC0mOlQ2PSDMO3EnFCP7L/wu5ly+pNtEOt2aNkLYkUOyHFu
 dTBmdJhIIpK1BMQ79aSe3U6kFm7zYS6GiJmf79QsxCo8VJZMIgYWf7uIyLYnbQzQgzJQ
 8jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533248; x=1789138048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5/jrBLaMTtXfJbs+c3h2YlEhImx3sdGvN3ec6y3eH/Q=;
 b=bDsldRmXvTPk+c6PhYIwAnW1XhYOB5nql0G5zVIQHNrqRF3tibSP/fGmo8KlGrtvjL
 GGfnSRshSJsjspjlmJhpOd/qOipw43Sch3r048s+Kk93Q7DeYJ66/DaCNlbP2ga9YA3+
 ugH/W/BeZE1EW7oBnGlXVsACujI/MdvSRkI9fK4hMV23c4e/CrrUmErU0l2DxtTabOoi
 J5FpMY3VSdNSYRClDhBJGpXMNOPSeYLmLMHk/a7lCG3ueThcyoU8RsQPJuObdoTwWsRc
 1JmYKZa/30MjVQCQ0+5BiFKAurW0GwNMjh12ZK4rfjUzb4MVoe2MQ/r6uv4aQBXybyGb
 PWrQ==
X-Gm-Message-State: AFuF++nGEdORDDIoQtJyeD0bQk3m5gn98oOfw9bc6W/9AUC82c5yIf+e
 6IHyLgsotrtuIKlziguc9enAq0KhRNkozLPvg4ghPvH3hGtLSfLakoxhbpfuK1+geEc=
X-Gm-Gg: AYBFou2YTyBqiemIq5cbmL6GLMWAhlrHtCLpxRf+NqXot3Bu56CXSint+t3/VOWir8+
 8xhSTEVLysO20epHEYDf6bVN+lHt2IZ022Qt/9W4Z4dEHeqZcS07Yh9F3e5MVM9Q7u3bqTuVcmu
 xtZ/tknKdyJWGccZXxvRHQhI1SeqxpsB8nQKcoF4KoI9wzlOfuwU5tk/32ikTMiU+1i85Gs1zrs
 6WRErmBqjsEIIurySWnh7jwICBtAzGFr/OAk0MQ4cJPqQyGfvuIALdqb5avlWa1VmONzhd+Ceh4
 XHHzflomGxkYihFmBmtaP3BeLG2qLJNvGZrfIwnpYaVnsUlpJsJMIXRgMRON1suVqQWmlNhrVBG
 sIEWCIHkupWFnt7T+/bQ04nzc4abwtHiwa5MFwbpDTvO9n3FtcuaZQHmJOqKxiTYCdhPdu+jhg9
 pnqh5pCLHkoibWVS/Gh78APtCFZ8M+Mv6Y71a1RuEcOOSAtb+/ciTZ+QTn3XSYapta5g==
X-Received: by 2002:a05:6871:a84f:b0:46a:d6a3:8c22 with SMTP id
 586e51a60fabf-47552a618e7mr6193426fac.12.1788533247795; 
 Fri, 04 Sep 2026 07:47:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 09:46:30 -0500
Subject: [PATCH 3/6] power: domain: mtk: support two-phase bus protection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mtk-power-domain-mt8189-v1-3-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5725; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VIGsupdbsvwnNrGkhziouCrjN+Q+LLAavyfjUfhUYEM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtndDS06HXeGBQs+UOWKA28tVMiFmh0F8hoDX
 whE2l9IRjWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZ3RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhAUH/iLSDTlzVOmNllvoT/Z1ml2+UjlTAG/ApDgYHAH
 u/du0/0/TawwTSSgkmDd2HnPy9Qe4cfi4Ce5lmxUag0YWAbn3PlxlXmpQ0U+uJ2//ir31jCq2at
 Ad1Kj+Jqebo8ZviaLIWo3j0Ye9LrdAggRCH3tbkPzWsrUW2RzpBmsgU8FpKAn7Q3QEmJYtxfSu+
 Qswv9mM/opH8QqD5yLTA3leM4/iiEcxQbf/yHvkvmPDBWRybOka08PyAyyHYpTh4weEjq4lQTdz
 WgbgkdZ0wBGJ96OcwgNOXxe78lLIieS+15N+W2DpNfao0PisE4aTzrzPlSMLraKHVaJ/IT7A9yz
 FMGQ=
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

Add a MT8189-specific feature to the mtk-power-domain driver.

Some domains split their bus protection policy in two: one part has to
be released before the subsys clocks are enabled and the rest
afterwards, and correspondingly re-applied in the opposite order on
power off. The MT8189 mm-infra domain is the first user.

Add a subclk flag to the bus protection data and a
BUS_PROT_WR_IGN_SUBCLK() macro to set it, then run the enable and
disable loops twice, once for each phase. Existing entries all have the
flag clear, so they keep being released after the subsys clocks are
enabled exactly as before.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mtk-power-domain.c | 30 ++++++++++++++++++++++++++----
 drivers/power/domain/mtk-power-domain.h | 19 ++++++++++++++-----
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 8696ac21245..24b4991e469 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -83,11 +83,14 @@ static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bp
 }
 
 static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
-				     int bpd_size, void __iomem *reg)
+				     int bpd_size, void __iomem *reg, bool subclk)
 {
 	int ret, i;
 
 	for (i = 0; i < bpd_size; i++) {
+		if (bpd[i].subclk != subclk)
+			continue;
+
 		ret = _scpsys_bus_protect_enable(&bpd[i], reg);
 		if (ret)
 			return ret;
@@ -97,11 +100,14 @@ static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
 }
 
 static int scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
-				      int bpd_size, void __iomem *reg)
+				      int bpd_size, void __iomem *reg, bool subclk)
 {
 	int i, ret;
 
 	for (i = bpd_size - 1; i >= 0; i--) {
+		if (bpd[i].subclk != subclk)
+			continue;
+
 		ret = _scpsys_bus_protect_disable(&bpd[i], reg);
 		if (ret)
 			return ret;
@@ -189,6 +195,15 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	val |= PWR_RST_B_BIT;
 	writel(val, ctl_addr);
 
+	/*
+	 * Some domains split the bus protection policy in two: one part has to
+	 * be released before the subsys clocks are enabled and the rest after.
+	 */
+	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
+					 infracfg, true);
+	if (ret < 0)
+		return ret;
+
 	ret = clk_enable_bulk(&domain->subsys_clks);
 	if (ret)
 		return ret;
@@ -206,7 +221,8 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 		if (ret)
 			return ret;
 	}
-	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA, infracfg);
+	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
+					 infracfg, false);
 	if (ret < 0)
 		return ret;
 
@@ -243,7 +259,8 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 			return ret;
 	}
 
-	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA, infracfg);
+	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
+					infracfg, false);
 	if (ret < 0)
 		return ret;
 
@@ -260,6 +277,11 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	if (ret)
 		return ret;
 
+	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
+					infracfg, true);
+	if (ret < 0)
+		return ret;
+
 	val |= PWR_ISO_BIT;
 	writel(val, ctl_addr);
 
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 09f9fb3e5e9..ef2603bbdbc 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -72,6 +72,11 @@ struct mtk_scpsys_bus_prot_data {
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	/*
+	 * Release this protection before the subsys clocks are enabled and
+	 * re-apply it after they are disabled, instead of the other way round.
+	 */
+	bool subclk;
 };
 
 struct mtk_scp_domain_data {
@@ -112,7 +117,7 @@ struct mtk_scpsys {
 	struct mtk_scp_domain *domains;
 };
 
-#define _BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, _update, _ignore) { \
+#define _BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, _update, _ignore, _subclk) { \
 	.bus_prot_mask = (_mask),				\
 	.bus_prot_set = (_set),					\
 	.bus_prot_clr = (_clr),					\
@@ -120,19 +125,23 @@ struct mtk_scpsys {
 	.bus_prot_sta = (_sta),					\
 	.bus_prot_reg_update = (_update),			\
 	.ignore_clr_ack = (_ignore),				\
+	.subclk = (_subclk),					\
 }
 
 #define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false)
+	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false, false)
 
 #define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true)
+	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, false)
+
+#define BUS_PROT_WR_IGN_SUBCLK(_mask, _set, _clr, _sta)		\
+	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, true)
 
 #define BUS_PROT_WR_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false)
+	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false, false)
 
 #define BUS_PROT_WR_IGN_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, true)
+	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, true, false)
 
 int mtk_scpsys_probe(struct udevice *dev);
 int mtk_power_controller_probe(struct udevice *dev);

-- 
2.43.0

