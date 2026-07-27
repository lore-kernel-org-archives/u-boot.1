Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1723C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 23:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D9AE810D5;
	Mon, 27 Jul 2026 23:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iG-4xyDxq6a0; Mon, 27 Jul 2026 23:25:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7A34810D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785194727;
	bh=k4t5AasgnpADJaKr48a7J3x47t2YxktZigjBGb0BZm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FzEm+4n0eKSSpvldYuVqFJ4Dpta6Gn/O/oD7zLhARKydUZGGt3VE0jdcmYFcBkn2A
	 HJ3CIccPlVjTqePyCWm5PUbqSVQchf7grFZIGmPc1aifMJEKB7pJ81R0OEXvdhrzwo
	 sCKzqwRdp3as9/lr/I9X6xyv2V8oHG+G8kZFNqdy9X78p2IAIeaSbjz4f0Ga5Hrw7+
	 cYMC1nLUGzdxHR5/gk8oX4G9z8+/CZmvJF3ZP2jMbo8LOQuoRptk4YAAwy/NyALlNZ
	 ZDY0hqGuai3Xa2Hy62cyCU26HeePDRnEAD9cTN8+DxMNvv8f/qQc2Yunv7zbJk6mzv
	 guT2RRz1CN2xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7A34810D3;
	Mon, 27 Jul 2026 23:25:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C7B1D357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD631607AE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnJiulK_Mu-R for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 23:25:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D04F4607AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D04F4607AD
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D04F4607AD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:25:24 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6aade397f0eso957717eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 16:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785194723; x=1785799523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k4t5AasgnpADJaKr48a7J3x47t2YxktZigjBGb0BZm4=;
 b=niRlhvP2T/6GFAyDDQJsOTY6g1XQTOMG8ToApfSFsMZ6fUfS2fdu8CDWVBGZUG2M7P
 QaP5lrriX2yrn9LlfMwXPGbH8KzGOwU1yzVQegjdDHso8lX6zxdf0D1ObfMqtbjbmvEj
 Sj8DgCeXz1xr/KbJBYLGU/a/rjJX7Pp8LBuSDFBwOVhTZhPziB2VfzTAu+irygNVXBwi
 glYVDxZGx0bL2BZ7BJa9vGxus8ew+M0OgbYdNmjSTeWS8opOWQODTx6ULtCqwmtumLEN
 W6Q6qdmxBOfJGmPlveII8boIuWqI5rH+YKDmFisNBYwEOxC80Zt9hABpWjs/8cKuXbSU
 0zUw==
X-Gm-Message-State: AOJu0YypHuA5sSXGnyVkik1j6dTjVRU614fAH0Ge+vANhx1eH3DbEqvM
 fpWyDiVgHMut7NM7AGr944fUk2C57aH7VN7GlXHPJKtPMdFMe005zdcT6MA0UOonZkI=
X-Gm-Gg: AR+sD10abQ3S4t+IifOov0gePx6kekOaRFZsKEZqGF8xYARK9R7Qc++rvqgXoVH25Px
 538XipPTqND+WqZnUGWwGVv36FQ5VTdg6TZj4J7+fvvRqYNRAlllDQC+TXkFLysoSPWYFTRhRPJ
 rUuilva7xs0K97Vl44s1awWiKrYcgdVta5KONWn9LStGdX21Us6s22d8ALwFJR/C+tdsYAr1+f7
 e3OGkDTZv940u9vxzGQTxaLTxrZBScXxGwf76mc3p1L2UrTavVcnar+XQxGLLciGuHld2X2FNMN
 NlWlFLVBHcfAvRZAAiwFhm76ciMFUgshIk8zxpfJdug2jeVOA3sOsZ4RjHssggvRc+rAbee99Gh
 KF0UDfsrswCvLwZKLLt2cnJv5fVYXMKQmwtmlMF4+IXq9vCuznknuV81ftZyT0/eaoWPQdTftBP
 ume5FxP7A=
X-Received: by 2002:a05:6820:151e:b0:6a1:55f8:6bcb with SMTP id
 006d021491bc7-6ac90d406a5mr1286387eaf.38.1785194723445; 
 Mon, 27 Jul 2026 16:25:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766e66674sm14810638fac.3.2026.07.27.16.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 16:25:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 27 Jul 2026 18:24:55 -0500
Subject: [PATCH 1/2] serial: mtk: use ulong for clk_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-serial-mtk-clock-fixes-v1-1-1d5542de3d28@baylibre.com>
References: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
In-Reply-To: <20260727-serial-mtk-clock-fixes-v1-0-1d5542de3d28@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Mb40+lRYxbw/Va5mwGh7d/jIAGVqWzyz0k3Y4JE6l9s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqZ+jTQKNDrd9hlfKEEb0lpZHKuqrWIIsn4xJpT
 UtbNiXqz5mJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamfo0xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGJYH/jVosgygqn+dQAq8O46sHx4kxKJSiXsFnMQKNm7
 lVMgtLvZCcBaxMk3yagPIY/3veM0tphcpjjnV6phhudyuyiItx/oylsUEDeqrB8XhoqTXsdDm1F
 tLnXL76XTMs4C5y2VR/phmNGOv3r7cYhg5kbIJG6UBvnDdKFK1k/pyEbrRp3stqBGi4DNWouMPz
 QV+THqS//ZAJfsYG/a3QMp1MoqSY8u+WhUBt3C2w7Z4uQRDCjE6Yc22n9cZbQYsVnhA8TSIEy7y
 cP1UoKHhOKMH1LrCmOyry1M5F8In+p65l0M1RbUDp6z5s0LuBFh6DokmRUO4SfDcJIaKR1U9Xmb
 X+JA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785194723; x=1785799523;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k4t5AasgnpADJaKr48a7J3x47t2YxktZigjBGb0BZm4=;
 b=XhFUQ47bvJ3hzPCJUEcghms4GUg956tjSAwa2pCtyM9AA2tNwZuYDiEccHBpqq3V5x
 P5DNPegUa/64klSy1i6r4Sf6cwoxXh+P8WSui2e5BrPwjrfTBYQV8UIF05WvnleZo37A
 do4aLw7utDNdl6K6OEmMFUNTvuEDBe1XoNo1ccoNK5JC7kt3QXCbYDFibWwZXbp/pu9w
 c9bNheemKp4+p4kD3pfT8eA1xB5UywC/x5blHPZH+zTSaPtPnArv59f4iekXng2SnDJA
 i48JsToPTX+NEueun1HNFFaO+xjTpgzmUerK24Ub6DxfGAYo1qDoOPWTuAJAMa6m80UR
 J3DQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XhFUQ47b
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

Use ulong for return value of clk_get_rate() in the MediaTek serial
driver.

IS_ERR_VALUE() does a signed 64-bit comparison against the range of
possible error codes. If clk_get_rate() returns an error, assigning this
to a u32 truncates the top 32 bits making the value smaller, defeating
IS_ERR_VALUE() and producing a garbage divisor that hangs the UART.

Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 01cc415efdd..64b3287f8eb 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -213,7 +213,7 @@ static int _mtk_serial_pending(struct mtk_serial_priv *priv, bool input)
 static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
-	u32 clk_rate;
+	ulong clk_rate;
 
 	clk_rate = clk_get_rate(&priv->clk);
 	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
@@ -266,6 +266,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
 	fdt_addr_t addr;
+	ulong clk_rate;
 	int err;
 
 	addr = dev_read_addr(dev);
@@ -282,10 +283,10 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 			return -EINVAL;
 		}
 	} else {
-		err = clk_get_rate(&priv->clk);
-		if (IS_ERR_VALUE(err)) {
+		clk_rate = clk_get_rate(&priv->clk);
+		if (IS_ERR_VALUE(clk_rate)) {
 			dev_err(dev, "invalid baud clock\n");
-			return -EINVAL;
+			return (int)clk_rate;
 		}
 	}
 

-- 
2.43.0

