Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB614C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EEF0409C8;
	Thu, 13 Aug 2026 15:22:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KA6IjVV_s_5S; Thu, 13 Aug 2026 15:22:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 832BC409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786634567;
	bh=FDCRFnXGJK3v2vgenbb4QGGNFlDbaYg32JcwWJnCiIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=leOV9om7HpH9lhqQ9z5ZQE1B4dYGD6ORU5QbNZa535gYaMWbAUOpvZ8gEeQJ77oby
	 lcYLbTzUuWpX/7RO/xfu+1F9qX1J0lt/jr3M/HrOMctf1SLdRVfH5MR05DNcw2q1t9
	 gfGFdNGP/ZGg5KSi0oc8E8z8rNttI8yhncrgYclNW74XDy873KOqZi+k+QARo0nFgW
	 m5MKe/CyQ3XY7UkiL6oR1TcKkCtsVyV4uuczJx/XqfRJwkO2Q3AVhgzr6gUSHktQ/2
	 rI8EuDUmffN4pNjH90K672rBKDWG07YLuz9YCY7oxQbcSt+1Dw0tO+T/Zsy9vbnfgM
	 VOIdBWVmC3WbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 832BC409A8;
	Thu, 13 Aug 2026 15:22:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5757388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB16D6082E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:22:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xir-vBLtRyz for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:22:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BACC0607F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BACC0607F0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BACC0607F0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:22:44 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4af81963f35so1062011b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786634563; x=1787239363;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FDCRFnXGJK3v2vgenbb4QGGNFlDbaYg32JcwWJnCiIw=;
 b=lGGHgb4NZUgVvRiuwKzazP7EhyuppvyeOfqNGu/daFiTyEoXpG+vRKYGxj9b6s0wMg
 Y30o154jYh/0hNoJjnr2VcZUOYVm7VPN/IbjBDfjp3vv5ZDk81chP9exzapHW8k2TwiX
 IDlfU9QZF/h+oUQc2Nc2dqg8WAa26bKLv51xS+AdYyBEd7w/rqYuAPBHLmfihWHDDsea
 IIhZ5uGIsCVtJoXapfPcNAt4xL48sKtPQS/xzMt4Hen0KAMI7K2baybNX3WR8tUvzMoU
 KyhNuKsCbDDXOFafMJZlqZLLOMONRIeS2dYgnUVlp+geXVVTOLyJXX30si4sHXwHIiIp
 neQA==
X-Gm-Message-State: AOJu0Yx/P7Uv9eY0Oyph2zGchx7UukdVBAFuQycp7LZNq2KUw7cdSLoF
 8+FWmHx8GUcBFvTiUf5TiejuysstiasmaaT3m706P3y3Oo8kAAKnCeKazSBdJmlZ/JpCx/zw2KR
 Zdc1aNbs=
X-Gm-Gg: AR+sD13Lvr1sDnYD8cwuCXRxmGVUcBUMMf8Zdttzj0MQzUr9yWeWiDiezIqWzsxRF20
 CiorluMzFdUXjzkdmnIAiL1L2Q7/vtSAymVEQxxBByrQumy7gXkoyknBC4rsrgolVtur21rQQyS
 NS6TG6gAzMRAY/qg7tWlb1ZGNMo/lAT6Gb8FtvRPpLok7zBuzLIg+Sbejjezv+vpCioMkrO5i+6
 QjQe/9RWM6Xme7bMUp/TkylXJ4z03Mytdfn0FjTz1jHVnmgXMHxcKpXAw0OEfoyjKU1SW+KM5jD
 MWcQsPEIN4OzqjMOQIIEEZxP9p2gmBzmBKoNKDSerLZiBfpjyValkwF5Bd25dRNXKtFUIJVJfeo
 SQawRXz5b6pqZb6fyhQHvcqA/BUT3nnJqB2ZGYRTmT9+JtsR8l6CxK4nAPtjqhwq3S2luai/YLF
 fZNcBGwTMePr+ijUSp+Ct6xsBQg4tZW7VFoEkkjbzJqJoC1S723zmqOwhmVJUNGRg9inhJqFioy
 aY=
X-Received: by 2002:a05:6808:3845:b0:4a3:ff0a:e407 with SMTP id
 5614622812f47-4b227a25098mr5409278b6e.15.1786634563165; 
 Thu, 13 Aug 2026 08:22:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b22cfb1ea5sm1824971b6e.16.2026.08.13.08.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:22:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
References: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
Subject: Re: [PATCH v2 0/2] i2c: add HDMI DDC driver for MT8188 and MT8195
Message-Id: <178663444817.2270888.3268955205999905451.b4-ty@b4>
Date: Thu, 13 Aug 2026 10:20:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aGSY47bYdMMKZ/iADc/skC04VWAM4hZHXOj0Qoxi5So=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfeE6xnZ2ppcBfS7BXZQCkSz764WuI3NDOVbHR
 MEqt51QR8aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3hOhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjBoH/AhHRU8Lk/pD9ciTWRnis1oLfOIeKvR4nPjROiN
 oNkUhWHbE8yWgmRXoQ+ECc6eaYKNj1kKjlY3OVsii9eENIaEfHreQsgnNje3i85xEenZiou0hhl
 q+3et8WRKlugxS2E4CuDFewUZUqjlq07uq7oxZm1Vqpx8b3R/nUA31KgoY7V/bzV1yduhnTx8Jq
 1Hoq4ONp3rC2jI7/PjV/hyiZOfo0eeQ5KdTzL/1WXPdBFCxbra6E/11zmwiF5XowrWCheWiaaQn
 +FWSRWTWcfk8q3DhgM5+27uHXUd8tnQUwyjA4Jmmo9L9pN+t1l9TXtfnb1EfvysEjmGSfkMfOVN
 UtaI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786634563; x=1787239363;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDCRFnXGJK3v2vgenbb4QGGNFlDbaYg32JcwWJnCiIw=;
 b=m/Q2aq4JvGlyXWfajXPK0itLZzajxz3EaDpu5SZFFq7+8IGL1xSPOuhQSWKRMUx+Do
 bFFlTOdq6Z21rTDRkswb8wq2t7vtER/DYftxeU5cmMJFkkUXp4ve1JfzORuYQ+b7MQK6
 c7KZHHdbcl0w4l1fKHp3kB5dKW5OMcn6HGDpA0KC50JTnxErtFpYcKrnWz+oCO8MMM6Z
 NYzVLBPXnluiVjcaq7ZitOaP+ypZW91l+69TpT3dhZhNSBoHJmIIMPqek5UfHwWQHOEI
 sxmmZ4xD4xDjyOXO7/ce4r3CH8bY1YzmlLmA9fuxio1ayCHTIa/bTRjJTNr93mAIaNkB
 6tzA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=m/Q2aq4J
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

On Mon, 27 Jul 2026 10:43:44 +0200, Julien Stephan wrote:
> i2c: add HDMI DDC driver for MT8188 and MT8195
> 
> This series adds an I2C driver for the HDMI DDC (Display Data Channel)
> found on MT8188 and MT8195 based SoCs, such as the Genio 510 and Genio
> 700 EVK. The DDC channel is used to read the sink EDID over the HDMI
> connector.
> 
> [...]

Applied to mediatek-for-next, thanks!

There is still one outstanding question, but since the same issue exists in the
upstream Linux driver, we can address it in Linux first. It doesn't look like
a critical issue.

[1/2] edid: add default EDID_ADDR macro
      commit: 5fa1de058293f4737ae3eeee6683dd87f5542360
[2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
      commit: 71142b57cd1afa78117cd5be8baf071392599939

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

