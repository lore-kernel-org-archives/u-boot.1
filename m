Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B946CA6006
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4588A60B86;
	Tue,  6 Oct 2026 21:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4C6uqWGKoYIn; Tue,  6 Oct 2026 21:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 64CB860883
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323309;
	b=NCasucMYQ4Szznuomki08PNl5rUaD2Uho/LImMDi+v7og+aulzvaYM7RDo0Iaa9liu2Y
	 qNA3cLdoe7YtQBGllMuxbytmXQ/1YC7MKHR2a0uW/JldReIdG8njVCLw9RFxwj2wb0s3k
	 ekg3Z7ulWdvPuqqdETA9fCXfiKuRYd8FX0AMxQm7iOnD9WABzfiKkbqhYlGvugqzvKh74
	 8NSC47PTL2oPY++6TGdBIj7PbbYV5sXdV7PCpopFa/ELN5NhwHgQ5pkGTYmGuJ3m3tjXe
	 omY1jQ6+V1k/Pccg2FCZSUyQilTvISqNHPfEQI0179zJmMbOlb/KAna29zThGhaU1sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MCAzCilsy/Bd14K8sk4B6Rmil9eRC6s842RNUbx7k3g=;
	b=l59eXICmthilpbJBiVOmf8Q6bpBfkmLHqK9ubo75xeRTGE927DcG9HhTVzmQj/bxldFb
	 dxxv44fheT7M4jeJ3aO3KS367IRUvRTmkB9XoVsSQA/8l6Ek0qD6W8CO56dx7YOrFYotL
	 VBu++kdvOnwO3RAwVWn69lfIgEuIWTbGujhjE9TbSWDv5QG5Ytt4WeKPB6hLcRTustnek
	 clokSIifUOB4RMz4gQCc5O8XvriDR8ey3EbXbUKtInLrKMobnYqvVR73IlkiRCVKgqQok
	 WtIOlgTXNAyVzgAh1nKlaNJYRcVX3fW8J0OeN5nj5lvr80oE7XyiuHET/QpA7LjrG2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323309;
	bh=MCAzCilsy/Bd14K8sk4B6Rmil9eRC6s842RNUbx7k3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWq8+w6X9dfBYtLbBPvkjLam8vrk5QcA6ScwgSb1Gj/NJwdvyaPNcWXZ6N9AAEvwi
	 +pxikWnSj5u0lJ+PRs99eo+gy0zy1NeW1FkJQOZMwFlIQ2m6lluWf5RgTFwpXXqmJN
	 edBdl2glqPBRbqtM/wPxCET40UUfvZGdbx+vId/il9mS2Ljd/HRO5wynoH4WFOsHOq
	 pLGDYaNQQ9cGjDFXAwtcc9Ip1Zg03BARCMm5R0+ZZHmkQfEpdQ9w3lyt/gyAIAcxlC
	 2Lh/3emGYtPgjEr1JHS1535BDnAwoVuPLYVuwMGY/qncRJNaMiBPQJUvA9uXs+3BUM
	 y3dAQbvkgFuxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64CB860883;
	Tue,  6 Oct 2026 21:48:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D3C632F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A83E80E33
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id By4cHb3H6BjA for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56F7B80E1F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322652;
 b=NKtOwASB0FyVUGLg+H1k01Gk8MckpZUiNdukrZt+CoyMwSpfaDMtoH3dJLF6BuEFekRW
 fXAL7dCb4t6iqvXVP5NPXV5HU9puNJd62pqps42XsxxkdaWjwd70b9RGb+r1fsKdd8DA2
 V1yBH07LJssPA+muGuScqhn9GYYbp1IQV9zTffPw4p2byLqJkGL9BzA03MZzKc3zqosxD
 uvvzccjP7ko6Gf9jSxyGy7sbSUyU9VlVk7+pFrgl0MpeguRKleEcTZ39YkyioReCNJfpk
 g/VEN7KJsmTiIcw7gRSfmD5anJJsAOtv3N1J38ayG4cUXl6LjpJBSZgdGFL9b6yP+nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=MCAzCilsy/Bd14K8sk4B6Rmil9eRC6s842RNUbx7k3g=;
 b=YqLluZqex07mY1f56twg5Nul3Z76Wwi7rARpM2MX1rcMhC9Ld4pHHmFy4Py1/Kn6D9/v
 GF2YYHc/cpQaXwsuw2eCMsezmnUYawHwCjo4mgzJZYiaP1CrBIXSU4Vgm27xhETclQ4lE
 ltU7jr3oBkXpd+FxGH387qiT10cYMhgWivIIiFW9FzRB6EuoycodY6IhApQZMTMpmC5ee
 +5VZeUq3Dw1m4mLP01+CKvhNbpdqhet9hTXhIBUz28hdYuWmR3PU5b6nOxCsFXYMEqKR4
 EI2f1CMAnaM85Kk/T2inIvPUDhxIXnKYgL0JklO2xVWeYvnXFuZ7aBAW6SmfUzm1pPQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hOVxDeXX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hOVxDeXX
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56F7B80E1F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:32 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f432ac553fso2160245a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322651; x=1791927451;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MCAzCilsy/Bd14K8sk4B6Rmil9eRC6s842RNUbx7k3g=;
 b=hOVxDeXX0iNL0gp0eqOVJ7Cx466O5Q9x/kppLG9dV/KmTlWhKzE35lHaYQk18ghG/N
 zqrA5iwY1B9Yn/y1Nxg9p1Um3cbiDerRn3M87UPB1r3nPMZa3jN9WyATaMKq8IE/Ir42
 VdA+P0+oBibnAdrmnJd7LQQJk8B3gnXa1DBNVlRiHBDJqi8DEHx8Q4gCeghjVw31jLJG
 9sb0IEW88/xHsreIWwt02v1cLFxeCoVf8eLZWUUM/4IDDfqwHeEHDFF+9jDrFa7gdySO
 VHNCXl22s1NGGmLPH516OZl8WDUMnVsNnX80MQcS56KtAi+CZs4vCMaw5bLhB79f8RTo
 LSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322651; x=1791927451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCAzCilsy/Bd14K8sk4B6Rmil9eRC6s842RNUbx7k3g=;
 b=VcEEHiHalbT8NSQTSECj0HzlhQHplAQOxFtNHc8rWcbmikw0vAteTBF50SUbZtGkRA
 +gAjRn+w5KQ6Z/x6zUrE9Cp8R/xBoC1z0g623gEWuJ+HKohjaW9dh8l7n6qr8WvIVib6
 IlPlPXYLhiZQ35lhrnxEdSJGPsluaMuloDdQx/MgpOGH9XzwQUoW+mIqnxQ7snovm/s+
 9x/2hp71bfIE6cEgMoeBIoufCS1WPGatImgX/gN7bWuOPiNjSzCHdsLmRm9bO4lT+rC0
 +m5MVCk9rELRkKALEIHRIvIrEUaU7cBQrGK4ZmXb6QHslcoWRFczT53pRceguzPEQhBn
 izmA==
X-Gm-Message-State: AFuF++muqiTqX0RE65QH7Wr/LVow4KhecQ1FokFTLTAo/CtRVzW13yoX
 GsX/99pPdACy4uEEWcsazgtupLi6oC3hORfLLQgOxKRNAcyRGeb5mlTgu0tWK5ey0CM=
X-Gm-Gg: AYBFou1oUVpGKC3cpGrPzd84zIzyD/vz6m4/vM9QmiQfbLUmn18b9Ad2/NI5LXoAuM7
 0BncpncIKZXpuVq+7J11RRHlYmPs9Pp/Gtpctkd2S79u8vCTap4TL+V80VAKNpu2hEyXaMcH1cD
 PtSt56n+3H4HClS+YyZd8kK0PnmkNHvUjbTJmGAcbbitizYBohkLhYnZQ5AwT6hsRluSis1LcrN
 AxrtEi/vW1mvNKGX3rgm775RGiMm1Tg5RZLqXBqkDk8IGBBm8Otth814pPeBX4W8RqzHxR4rxAL
 2d0kFGs2RN+vkmYjJxsm9dABtB1T4gTehZ/oILa1k1PsvMwEIuzXk/wYtaed8Rq8nkFkZL6/r5W
 3kMhPrUL3SrCwvQk6e2vQicIMDBb/8L9YbSmzfe7Vwktd3rJCd2oq50IZ4e153fgNSn+jv0c7Pg
 S7D7XrgAdBueW1ecdPTUtXHdf3tZimETF+Z1PFz8JGz0sbMrlyxqLjOgywFU4NUns59Yfo0eP2P
 NWsm3t2tVva
X-Received: by 2002:a05:6808:f8c:b0:4f5:1cd4:d2be with SMTP id
 5614622812f47-4fc3fc7a9fdmr656731b6e.0.1791322650549; 
 Tue, 06 Oct 2026 14:37:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:16 -0500
Subject: [PATCH 4/8] arm: dts: mediatek: drop the USB port 4 VBUS regulator
 on Genio 520/720
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-4-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=vGDF4gyNPouvwfOpWsfeAjrwbqsqQWgPJQi6J3GmO58=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnqb9/l9FwLt8GLmprtcrVkNbgpglUR577Ck
 gvIhxnXZ66JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp6hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhlEIAIN32fEra3sPXjb1SHOIK4H6f10pa7DoRUjP8Fx
 1vYLHvD8KrFeBE8YhDq1RU14Xrgqe0t+WFpE0qsQocG7d8uRX9U1sk3tGaZwPQBJ20+b2A0JGO5
 FRzopZAPxVHr5hv8PAVS1cwigTeobwcxNVrLwqoHdthSOaV9SjCpVOQ+YHKtHWQsvihPA0MMOP+
 qlAsHGUBiZK/Wth9aa6W2JKlAWCbWwxMMTRZe833XLmSsPGVy5sXzMtTuTDjdDuLLpi3O+EOo8F
 afoDYYmSTMbN49nTea+OoVqWxu8O7EdJoiUGS/U1FUJy/EO89Ie5EzrAx0dPF63RL+aFWh8JsR9
 2C2g=
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

Remove the usb_p4_vbus regulator and the xhci4 vbus-supply that uses it.

GPIO 87 does not switch a USB VBUS on these boards; it enables the DSI
panel's VDD rail. USB port 4 has no switchable VBUS, so describing one
only turns the panel supply on whenever the port is powered.

Fixes: 32dd41059c83 ("arm: dts: mediatek: add USB/PHY nodes for Genio 520/720")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 123133b0eb8..b1ec5aba082 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -55,15 +55,6 @@
 		enable-active-high;
 	};
 
-	usb_p4_vbus: regulator@4 {
-		compatible = "regulator-fixed";
-		regulator-name = "p4_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&pio 87 0>;
-		enable-active-high;
-	};
-
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
@@ -401,7 +392,6 @@
 };
 
 &xhci4{
-	vbus-supply = <&usb_p4_vbus>;
 	status = "okay";
 };
 

-- 
2.53.0

