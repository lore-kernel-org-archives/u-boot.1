Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E065CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B4240665;
	Mon,  5 Oct 2026 22:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k3DGOIoJ-QFS; Mon,  5 Oct 2026 22:50:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4492C40648
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791240641;
	b=N0Q3XxQSI7H3srF2iCPoq54NVkM+1ohTuLStK5XMTRJUDxLhE/crQRDxrpE2xytJRIfY
	 7LrQSH1US5FreC12lbYWD289ogHWOponcNdBD+6oF6tjNcO5Tcarun69ZF2BTX59kYMZ4
	 JIMP9UWleE2Fi0HPpSBtDIFHLblJu6NHPBKkQchmTUBsj00T1trQWodWOgjMuhCjKY1vW
	 AwwC6Sqt/hujZz2QVWaM6dojvF2q7lid9gesT1WB8jvVPYCseKuhFTmer/xkTfBX6mWEW
	 xp+angIW5dH2osaOKa2wBpKm5Kn81BBSX4z+fQ4qTqfHP+FfhqlkplBGcbKBOWFrPrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791240641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DNf7bgmuee5gjA4fybLDGFK63b+7aW31Uxf7e/rMX1E=;
	b=YUKrcWbf8efR37qxLCiSDQtMJvEa8PSSOtTCDXsP89Ar9Rm3y24K74WygYQqY13+8bMs
	 QomsQ4dqSDrEQjWRPFGfn21MC2cQF1w71Ho2TIPClXoktbKa4+bs+kKLxjCAOk9qJHkFn
	 soA8SDoFN3Cnywil/r00xHI+xo7HJyTJHKWZUF0KjPH62NhzY2LnfjjtKJoeuIRgXB1uO
	 qY6/dTlFjCFEY/w+l6qUo4cN8dzFWJaMV09xJ2wGemvoNSuyh2FgGmYaVy0WtND1AmFx8
	 88A9jVP/PYru6mns2uGZRgByFGr+dYy1cHqNEH5cJLiygLIGtcd/UxkvOkTR7r1KinA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791240641;
	bh=DNf7bgmuee5gjA4fybLDGFK63b+7aW31Uxf7e/rMX1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dI/FBs7xR2k6NmEm7SKpT1qtaVb2i32KSzox5GkuoQdjeE3z7vaZDof0CtIRgvTJS
	 i7BnZ7C1ePjuEWb29x160rADUuAvUbwNpr6Ii5diGihN8Re66zlCkzcrQBretu7tow
	 kD5eHlOqikni7bl5MzjWLmJpgfTJpBYDKfppAcwkm4b1RFZoNZq6E36Y0QEPdIal9k
	 Hs9daPGEAfuuDBYX0yB2a2bxc1yld6ysd+78YJqPq7FE+hVFCTT2SO+gF9ucIHQFwY
	 gK7ytScj76pW9lM2wn8TjlTMHwxpTKjCiExE2xLXicJJmfGXxWmJjVa75fKcHRrFNo
	 XYU2axz4uVfkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4492C40648;
	Mon,  5 Oct 2026 22:50:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48B3C34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A69A6069E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OY3GLDGur_bf for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 655ED60699
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::1b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791240211;
 b=r2YCq+lpIgPT00F7UCoxhZ16NdhQe9DNR92uNTXF4vd+Gif/L2NeRPhOQaf1EdJul/A5
 W8B557Fn2vRKYO8aDDvHvTkJGaN5NQiOgj/tf+fZWt+ibMke70pAehiX49QNPj46FzK6O
 4pwvO7sWl8c7FllDXyiRB7h1oFFNkbd3YU6SRVtqO2O1dexek1/3ef5Ri3NNfTTqNxRzf
 m2ITdfclHwQInNqqnBpzSP4M1gdSIXK+6vBKvd56yqUSjlVug/XYSzzLNcHTm1ab2IeQV
 SXF2xx1pG/FIyHd7HN1Emjny0LTjllQDt8bpTFSYnfSDe8Vkcg0vpjOViaZM906jmdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791240211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DNf7bgmuee5gjA4fybLDGFK63b+7aW31Uxf7e/rMX1E=;
 b=ohenK3/K8v3ULcTvXQV179vjyCHkcSMyNAnqd6+mtqM+reF3xV514wHouQh3dVxeuT+c
 0Vki344StTcngw56UifpcGq7Z17RK85fkJE5YcsBDvLTfXc1hfjA6UryjvGw78zVdyuel
 +T0REY5WecSay9pB4HYYL02yu/dVyI6nPuEpjoqtIW5PCr2FiS/6408fsZY8+QOlOcquy
 acqEDfd2MF7W2FA2FZvkbnmKivIu088f24TfhZR2bQxxKHYA/QVwarG+9eBbMDFDQTZxr
 btv4fH/BABZjLlc3bm4aac6J+PtlL806jujLb8fbmzzArAVavsX/DvR+TLAjsEGIOoQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OnhUglmT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::1b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::1b; helo=mail-oo2-x1b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OnhUglmT
Received: from mail-oo2-x1b.google.com (mail-oo2-x1b.google.com
 [IPv6:2607:f8b0:4864:31::1b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 655ED60699
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:30 +0000 (UTC)
Received: by mail-oo2-x1b.google.com with SMTP id
 006d021491bc7-6c72bd8a02fso1485853eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791240210; x=1791845010;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DNf7bgmuee5gjA4fybLDGFK63b+7aW31Uxf7e/rMX1E=;
 b=OnhUglmTDC7ocAjEvY3+vQ7nhsUz+wwHZbCTbWafc7IID5UOnnP3P++L+j/7gYcr/X
 LNYsMcUFMFjy2P+bAvWZb6rLyFpA7sTbQ3Ra2Qqo0PoAT7IbOnUn4qFq+R3qad3pv+4L
 EYwdwiQgoRc580x8465ikBp633bPXhNC7oPLbUUxhHN2lY2dS/A8paTuJedIDMuys7ml
 ltA3nI2Zd/RQutzjYD/zMqAGYoGX4zCP9pLw3y6p0AGsHcuKrXMVgwpXG8CpZvXxt3L0
 68h+ZsGNh2Np4dxAyTy+XmVtGGlAjRzbGuRo00EMMQlSkp0JofLSQQbHeg6dEIb0tiFS
 CS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791240210; x=1791845010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNf7bgmuee5gjA4fybLDGFK63b+7aW31Uxf7e/rMX1E=;
 b=D0CsIGIn1D1r2aYUkRVREIRrB9xgn2ndiszk0ciTgKqmK/4Umh3CocA/NHZ/BvkmwE
 67wRwGJPc/VkreenrcLiJpGlcWK35mEWvWc23cVtbrrSbogOMwgz4OCvGiC89JHsIInI
 IE4usWPu3onx9mezQ326oYhvxKctrXoVQTeAds64I/iOnLDVuSISFajIVz7jEPqiQLH1
 Mxz/3gORGaPWwMZ6ICTp6jUV7swjjBsoR0n15BRZj9QH89cmD+sPke1FU2Rxp9oR5qfx
 OKgjksB9VK+oRrQHJdinVxKHJvNgIx+/CRUdvvDcLHjzMI+juyhxdLCXErdFmY4uhRtA
 Bi9w==
X-Gm-Message-State: AFuF++lmlTRAj+buirMNDcnBvovV8Oxs+6G9GdniOyjoMt2FZZ2DwQxh
 yIZGkQTF+xuYKwqo4a7GeSFAwQ3vLElsqFe0bf6XnysFMp0KWKQVjqjMPSoGN3lvdbg=
X-Gm-Gg: AYBFou3KRawMFWeWb12TMuPdhH1cOlilYofBnBAT3oCOXE/8es+6h4UeS+OpxRNlZWv
 kvfmHDPDA6rUKyUGwfURkQV+O7sM90HcG+aLrVq5Bb6U1lkwpqU4iOTB4V8fQ1SE36qYKFMzrw+
 N9oz7fucXwcf/94APcCDfhQ6w9CthbW5shDiTO9e0viFINbfu0emAX3B8K/CmZ5/Ouv2N6Jb+P/
 EmkRRHo85HsO/8glj6vnLIMC2bYW4QvmXq9lsMnGcrczodI+NKiVrxQezQvCPul/59UVly7YiOu
 bToWjQrfxTHolvHP6+sQOT2ZJM/Qt4fH+aOokAHsHhoC+7gMussXjCUYBaoHw5WjtXPW1Qv0nVf
 rqh7DBZ/TouyiRrDY55RYbtAIjcSkis9crnb6FOZx403ykJ9EEEFx28ZRnCR7IYcKeElzwSoEvw
 3MzEAVyS0fPHzvPuGGC3QQEDkBZp0z1L4x0U4zML+9UrWYCRweSH6+W0ZFpJH7QF+iNSSQQX3+4
 Y0=
X-Received: by 2002:a05:6820:4cca:b0:6d7:d8af:94d8 with SMTP id
 006d021491bc7-6df35a4033emr10240246eaf.61.1791240209932; 
 Mon, 05 Oct 2026 15:43:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm694448eaf.2.2026.10.05.15.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:43:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:42:47 -0500
Subject: [PATCH v2 1/4] clk: mediatek: don't truncate the requested PLL
 rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-clk-mtk-propagate-rate-v2-1-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
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
 bh=c6zZB35P0CFC9/nnJdOSGG6g4Spqa+QQpqSnWMcEHs8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxCfv3ISvWOSzyYfhdPaJaybgKr4cCBRrrNtLr
 6RuKVu1OMCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQn7xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4RMH/2zLvfDE8aTtkZUEM7gSU8gouW5uQcag8DBP9YU
 kJuo9k85cezazfRDFsKbK2o5G/UN0Xet7xw0RFcezSd5Y0yoGByXE+uoPlesNCIUcYP3aHpU3nj
 fH/ExHDDni8+eL8hmDSSKywXejmsiY5TTSi/6KvBff6eX6i0N9A9K6yDNI628ZP5+/Y9VmLrdu/
 4SJvOM+6RkTJ90zBoBOQsucU3i2xCRufrQ1y8yTjg5KcUDau4sE7/5D2smNKcFX3tAbbPcMYGX+
 RZWA3hJp+xoRnOoOzT2Pt6sYa9H3RSeucwaNmi4gr+njKF3BkcgXybApVg9g4FGJ6MuajKjKYfl
 SSL8=
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
2.53.0

