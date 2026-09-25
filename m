Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2EC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E8CE812B8;
	Fri, 25 Sep 2026 13:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDofeviTw4zP; Fri, 25 Sep 2026 13:40:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 559AF812A7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343635;
	b=N3ZB+Leh4ZwLAIQidhUKe+DtKCZlVNpDdtkRNgq+MyawMueyYVK3x1EbqLrfWyMl1FMx
	 VlFSvvh3XbEz8Q/sacAXaod6nDYFlX4ga5bB3kt8rdzZ9NI8wftnbKyoNl8G1bqzUxep/
	 hz51nbKzx25I/CVY9+rqSOBqXxL7ZHFkYzjxa/zY52dqE4lLoJG8+9oHoEU3ZdDocWs4L
	 O85yaSrT0I/hLerE1LKFFbCdx6NFYMKvVaM9gjwsoIZNFyrtqspAUS9PfSf3VXygfPuKh
	 jsl5uQUz8oDk6yyocTJPDL37eF+bW58KBhntqOA8L+Cy6+dIdhZDaq2Si7Str3ETYFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	b=Xml3Ys/dE0sgJl0hC6PptLCLUnQeKvejzEepUn5j9XSjN8Im5u8HsIkua4RJKps/lmdg
	 5Tv0ev30Eplvr44zGytlK9g1S43W3RlStYqqB3eALF3ibrE9p/DT5YHo75qgxo7mrMFuH
	 DVLgAPpeHDkjOa1g7RORRAmAMTyTcTyWiuqbxGPvK2E7QGw3AJU9Hvpzm3FVmmaLfBOg8
	 DuHOmdNphQePdi4uEN/FIqCKGvhz8ZaQTg6Zci6hgkQdjwdzmolLd5HGwTg4qn+ekJY0s
	 hQmMNNhpnToeqhAcziqq6DvJjZ0JelsLrYWRMj3gu9CLIAhf2+mBYAIQKchg0pNoYbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343635;
	bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEIa4IsqZ5U4Xh5PKJQZ9vHAkBaYFPugLI1CaS9++YdB3De8a+Rss8CQ5h6gEnoGJ
	 WybYa9BWYqRBBR1S8vef6gH9PtENr9UOzlRLTZtWaTqOjerxmm7tMSDHuyFayedXw5
	 z025uf4IrQF1jfxIW82VKALpNuIRez7Im6Qk7fLrz+Xs0ZAU8EcP/t3WjfpVszpeYu
	 7DxufIF/6bLEZmGRx0AZX1sJ7Ss8PTih0fRb3JquiBR0p+VVgoGfEpXRgrauELgy0g
	 emvm3cmIouXk/Wr9MlbODqlOCYsYaLZ3vqGgkwlTk0wyQ/u9s68THmViQBPqY1VZsw
	 x3DWmiSR+xzAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 559AF812A7;
	Fri, 25 Sep 2026 13:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DDF3332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2208660D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2BcbBab5lIp for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0521560B65
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343632;
 b=KNvXhF5fqm4WTdne8tlEjAu2ThV3Eng9yv35COY0W5Pn1qD3Urg2PDA6WNO6K34yrA6K
 uI9H1ky6yUX40RcfRQEo8d7u6x8YEscp/ksOkQlNpqeLViITofrLe2kCp5m30j1UQzRBg
 ze0JktZE1EjZpcLHwIDS9MfxaEmJc9gWEwh0SGxxq+O83/VRnK2wLc7rQJX/yaH7ASoq9
 h2UY4X5+PA+geh67WBPueEG84k3K5rQfjgpE6aO048RUVh4sA2MQ60mAzmot46sktuMCg
 kfYgVAN/v3XZo1FXkFcjmBxsUEdx6VcSWqjyluFVYgC8+Pp7hFLe+jLjkVc+1mniUuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343632;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=VFGbIUMSgTfKXgNbUhtwx8ix/GxV1l4LAViC3jH7FflodV7NnYhJJ9QIEIEm3RXm1vLH
 SPovVD6+5NXwh+KFIz5Mgm7RsAl6KKtBM4IrWFU7rigE7hNXRvZk+CjB1xQWvv7uRNP8f
 W1TF6SUEBoaAEQWfM+ZA8f8YkI1H2t1AZKLtz2Qzk3e6PRcp66FfCWFu0H3XxifdbcFZs
 srITTY0SS7iD3y7hkwhj8kZgwnJBAZeiTF8gzNB0k0rASpl3RIWwFTmKjkXlrfVf/ODu4
 CALbu/m2SElnpWkblY1osH65ktcNLMmCY2kbHmS3Sc4Q5NiGYObcHXsWdGh3TkZf8Qg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AEPMwvkS; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AEPMwvkS
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0521560B65
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:31 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351832so533832f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343629; x=1790948429;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=AEPMwvkSNKiKloAKGod/R9GbcDG2neldUaPS94IQKq0dlt8sJaVQqPyJuSMtxBmknA
 ybk4rCE0uGkKiaERMbqYBaP25Y8R4nJp92fRHeWSnhCkq6UsisTgrnZmp5/V3hyAmI8B
 +KqZbRqNtNDlRfUQwP7dqgyJw/XinIC4wZNFwCbQmKCHUFNnBcb6+4PFsKNVbI+olwBp
 KoA+AAStYBPavK4Z02eGp/abeBdy59qutCffalVssNegJYEQlN46F40CVUVuFMw+1O5J
 fGIRBvdOvFjPhozu+3B+1w6ZSVSw4OD0Ai6e7GqdpkFdUp0Ai5/F6pQqG8D354VHB3+2
 wKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343629; x=1790948429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jmQy3tHpxJGQKlgycSlbaeQunyFqFh5QzX/konNayz0=;
 b=KboGQq0l9zIPnXEmaGoE8Hfc20CUTjTpvG4aDq/DIAg85NDH/joG6rJYL1bTeOFrth
 K2clqj8L4yA6EWMkAc8NM9AUqlumMRByp2Spmlw1cTK4oGBWuZHVMfEac8Qnzghy24pl
 Y+sWs7TpAivRPzxqaM0Hbpi4Q74HgW6joJpiixwtcxetH54mzO7Zx6lIXU9lfqC2yWZB
 c57Dx6quqa6nMixRffJqvxmhYkszto9YS7BoZhc5p3DbwWGgJC2lUNLLlaOHHDR0kk0Q
 2hUUxBwTaLNQicY0UBPPbAVC1cTVRvHpgnvoakyTqI2BOIA81dw3pKkbSmmGfRmTISrw
 +GTA==
X-Gm-Message-State: AFuF++n2EDt3D50PASTsbMbDNn1ftkANzY/3GFpGxTP7nZ31vYXf7FMd
 MitK8cdnKbh97MzpWlJSbWX5lf7nTStiR4XN50iuWbxxgZ/pJ0MQbSfuPqWfUGzQSRk=
X-Gm-Gg: AYBFou05leS/Y5SmQ7JMtP4HVPeR1EES/532C/ARluWB2dpoTgkTOWsLzyExPaM0K30
 +vkamLqS5MualKShIbg5DVypJh0JbFUlxby0gz7PNgGPWgmenicAmXTMm/qlfGjkTBWkRvhKIV+
 NSDT9q2Jg92BjsIWystcxJeOC6zLbLAKTxlfk88wMJJ5i3NwBKB7qnyXwQJnL0xO2zn/ytqJ0hM
 SX6oYSC+S0arAWqxy2bPo0rgiZGqE7cK0Eg+jCZLdWt79kQJO7AfNhJ4TpkSVxv52OqSR/bMMBT
 DvugbpmcCJhMxmwAa+oOyX61ehxzAU4lytdu89s2k5Qi/D/Cvr4gNCcC8nkXEdqiz5XmCcNtDMJ
 1GZ3Olhaaw7Fk60WaHjH4airs0K/78bm7vSlxoeoZdvQrvzcSd5Lz/PZq+7hH6zFTs99ERtwsOw
 OPWRzbcN20IY4f5zx5EeAzMz6nUjx5dR0lNi0DoA6J8zm7FAxl/ZYQseYjedefaY719FWq9+Ic2
 K+/CuDLlBIJaaP0/AO3CUEZI2aBbJCgcWBZz+qcuV39NhT/iYILdpW/gv//jRYXJ6jwKALoyFb8
 FcNJ9kSm+jD6cQCSPAphQONPjLSSzMjA5W4y/0lKHlTxlgao6HhT5S8=
X-Received: by 2002:a05:6000:4010:b0:485:ac96:7273 with SMTP id
 ffacd0b85a97d-4887170e2e1mr10038999f8f.10.1790343629202; 
 Fri, 25 Sep 2026 06:40:29 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 25 Sep 2026 15:41:59 +0200
Subject: [PATCH v6 01/12] memory: sort the Makefile alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-1-29e626b213e9@baylibre.com>
References: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
In-Reply-To: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

The obj- list is sorted by config symbol except for ATMEL_EBI, which
sits between STM32_OMM and TI_AEMIF. Move it to its place so that new
entries have an unambiguous spot to go to.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/memory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 77294fac69d..d5f5b073672 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -1,8 +1,8 @@
 
+obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_MEMORY) += memory-uclass.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_STM32_OMM) += stm32_omm.o
-obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
 obj-$(CONFIG_TI_AEMIF) += ti-aemif.o ti-aemif-cs.o
 obj-$(CONFIG_TI_GPMC) += ti-gpmc.o

-- 
2.55.0

