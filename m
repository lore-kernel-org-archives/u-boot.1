Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABA3C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90EE6405E2;
	Tue, 25 Aug 2026 00:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UmdqoQWyoilg; Tue, 25 Aug 2026 00:26:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787617598;
	bh=+eXY+W3J9B2V5CpbYWUC8504O9HaefvJpqj0/Y6VcCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUC6vPvEMu5eY0rQ7XEKhuQ1xQNkSuD2Rl7Zzr6zRW5/HAcd/yLiWIVARlgBgWs33
	 RWu7Xf+JOUHblnib4osFHC2riMZOeUHiOPx/+jCsh2yxzRw1TeNbSl+iAbD9GhU9O5
	 ofqD850OlnNzUP+cpq9Z90uppUUyeG7Q2n+x+x/8TuC9X6yXKee/8952I/C7hP08L2
	 Mb9D+ZI02UZDGw32miqAylSZxdH4/sNmCw6RAckBfqzlHyMVUy3MGT2ctx4hh6DKCg
	 QxeDRrmUFXG7XF0IJWVBv0cUSDLCEK1nbmB6YkZWYEIbynNIXNNH6L1FbbUc3USiWG
	 jfs75t5azFdMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C012A405E7;
	Tue, 25 Aug 2026 00:26:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 288374B8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06399405E7
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id haz5XaWmsGnr for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:26:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iVkn4OuX
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0D09405E2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:26:34 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7f434cc1c5eso3922635a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787617594; x=1788222394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+eXY+W3J9B2V5CpbYWUC8504O9HaefvJpqj0/Y6VcCI=;
 b=iVkn4OuXxeMj/Ft/o8SbuGGerSRBlojtmfaJV4J0zGdvod6UI49Fr07IsBxsDHFLWs
 LjvOFNGFGKWnhtCwtfou4LAdjo7a2pz3p769hDb+v/31cQZE6Nc2s6zialkrS1VUEge9
 IQbVqtkVUbHaBTgCLQyVVUvBzMPfBfIqCGSPC97CmXSC50S2c8lCx1nNJbOvY3CPo/LM
 TX+Qjycy9bCnY+4CHoeBatMzALTdpL3bboXli2yFViGYhSgeys/m5MBAggL8ikwdxFmv
 o+7rBoOF9ZbdaGsTYjJQluG4y7ugrSz9vPzwYvK+aj9ISRHR4c9tTeZahLZ/5/gCgzZd
 vxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787617594; x=1788222394;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+eXY+W3J9B2V5CpbYWUC8504O9HaefvJpqj0/Y6VcCI=;
 b=k4NwNfJk1RYRX0Ak6etB4tmV4FUMUrbxV1oRq/V8GYXV5lJBxa2ZCYr6KLU5qS+hpU
 T9togGL6AFfBlsRNclZNMIDQbexFXsrH2tA4hy9fC4Redm1zAqKyO96NXYF2XrrMizmB
 Kk8kszTtciklw2NfLwDpJVmEx9Um6LB6XzvB9YdJuIYeWA00zFQ8DrLPHY7dHRbk/uAw
 fNwNzKwC9e9UD/BXBwzjUAfa+LMmSiQyvIt12eHXtCZyUxAZnj2V3JLcAvKKhUWokPCj
 RYqGHWxjvO9NPnsjTXPjPXKlh269DJi2ifGWnRD3yvSKDWBKuWc++LgoqtVnYcnmc09P
 dsVQ==
X-Gm-Message-State: AFuF++lQE4t5aQaPPTWxmsl3dYlpjuAc42AanA5WDibJWWt4RlT1+Mb/
 URud4rnooBsSM4lfyPSwwIRKHNgfSysf9M2devINv/wiOwZRAhYul0Em9tzUz0WZv1Y=
X-Gm-Gg: AR+sD13WkTnLoKgu1DDPNwkhj2b+tIjlZk9+hb3/0qw4voPlOzWVSTHAIxrTx5Op0Dl
 aU9llAZDHhu9aOwcIWOFagpGbYDhkpFEMjzuSIUEIT/oYtxzzN2WaaVqSyoQmcxutDRRbowADY6
 KnEIeXGxQU9A3azqXBmFSppEkUl8UhKZPwMPBpc5pY/h+P9gnZvgig1vPDqIwlZHTmA0YSrJJuG
 YX+MGq9pJuHUKRlDRcSdxW+49btFBiOigCaVO79/kk4xCwuEciYLyMiwoFBtgX74G/UC34NcBXq
 sKuIcmHUIKcfKA1hCfagUVjoc+6jlf/d7EUiR4pxyDd6qNppqpj4C/nouKerZEYZgsSm1U2ZWwX
 RB3ZEr49WZFO6qc1X8JoRMcR4uJ+9jbhPlqp5F3SPS7Kph8HuB/Z9Cfy/Iqsxh/CJQiLGssBcfG
 A60rE6obFUX9EmN31PnDMQKqw1XCOAeBUgu2wCouCQqiiFm5AUdY0b0MzY4lgG36U2/Q==
X-Received: by 2002:a05:6830:7102:b0:7e7:8dc0:3951 with SMTP id
 46e09a7af769-7f46144221bmr35227595a34.8.1787617594021; 
 Mon, 24 Aug 2026 17:26:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fb1db63sm6211761a34.12.2026.08.24.17.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:26:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
References: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
Subject: Re: [PATCH v2 0/4] pinctrl: mediatek: Kconfig cleanup
Message-Id: <178761758314.2485046.3222118451188096373.b4-ty@b4>
Date: Mon, 24 Aug 2026 19:26:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=w0/a8QYCsTHtjsYznTlsvPwRe+/dJG2D1zoynsiy/q8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjOExsQzwbvbxF6QMAXsGSRaH8EUGr0X6baKCy
 A10yuHq4qCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozhMRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnnEH/0zZ/n08zUwRytsUgeaaA7wXd8EO/Bijuuo7U0e
 J+FqvfONK/VTs93NB+Rhbs4fyj/LvEQvymApXfBbe6+5kO3kiCnfeoSnPIgdpMQhuriag4gXHRi
 9wFv4/2zmjUej0k0iPVX2M/q99tDTUqkfs7npxiCLSv2Hc1VWokkHI/hEZ6QgRKrVAYy1yMoFIa
 QgpOBvUAa28kz7cCz4MYjXeowyFZYPD/vE48MMXvxp9XvasoHSlA2pHejSp9/0Bq29PKenD7gX7
 tIpoFizNsCXunZM0hA6GxHfXCb/7cGhNcsnd+uCeJPrQAvEONrLWhtRqTlrV1TfD39/Habsm1GC
 ZQ/o=
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

On Fri, 07 Aug 2026 14:16:28 -0500, David Lechner wrote:
> pinctrl: mediatek: Kconfig cleanup
> 
> This is following up on some suggestions to cleanup the MediaTek pinctrl
> Kconfig before we add another new SoC driver.

Applied to mediatek-for-next, thanks!

[1/4] pinctrl: mediatek: select PINCONF
      commit: 186a142207e7b8c3f559cb91cef19d4b19c71153
[2/4] pinctrl: mediatek: remove PINCONF conditional compilation
      commit: fd017c4974ae2313c74bf8aa94a0b7bc4d974134
[3/4] pinctrl: mediatek: simplify Kconfig
      commit: 86ae242f246dd6dddeb01588ace0526d2638e962
[4/4] configs: mediatek: drop no longer needed PINCTRL options
      commit: f807d57664ae2e6128e9a17dcebfd45b8de3a77b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

