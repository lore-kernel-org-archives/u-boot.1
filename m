Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB1BCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57DD460761;
	Mon,  5 Oct 2026 22:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tKzrtchL_rBB; Mon,  5 Oct 2026 22:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4D0CB6069E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791240639;
	b=ooo5nXu38uhq34d73qK3+HmeF+bc0Ceds0V/zJYiTO2EI45nebRPSF0G89g0f31TSGqO
	 tAPjqzN6DPE2X/MxL1wf7PzR3Bu81NTwCEr7knJry1PdyB++WCmD3jKYSQDKhf8YSO/Rd
	 H6yGqxgHcygdl5LmBtPAxlSGXkIK7QivZkAoKpBEJmmQeA0M7NiP5nA53GqaUj+PpPkxt
	 SERLKTQdEM3GuhzXTevR9ryTWBlYseDegKwBzsQj68H4PReNp6AhfYfI0HVH463Dr2/aO
	 KDNsjMhEEGF5D4G3vMbhY5OoAkbkncpjyZ6kKWbzoOZcGrV0+jTpzBBj73I8541IVmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791240639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KjvypWjimahqK0uq+bOrgO3QIP9TuaBCD0hm3Tn7Whs=;
	b=DHcdEyf+N4jOkkIcLOkL8wjYv0uNAMLv5PTfVsXoAIRLgWQLS7ljmqT4ryd1KHmQUrQV
	 c9DKPLkRES+sp/u1kk3e4kH+6e0ARAYHuVLVbA6ZsRgXiVkNshY/iPncTp1uX4NdDLLVV
	 A93d27JLd6FPMukfg45lq42ClnxmJayOBWyEFvqpFTwKHISiV6ffLQdj1vDcuEL4S7HH4
	 8Qm9Ms1YMJApxaea6p6JKcVT51mxdu2vyPtT5WnZM0l3kcsFJEGEpYE8AJOQmgHoecuDc
	 Nb/U6Q53gSJp1D6gkITa3b0VO0snak1NfGSvcN5V2He+e97tEFAZzRWYwDRzLOWf29Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791240639;
	bh=KjvypWjimahqK0uq+bOrgO3QIP9TuaBCD0hm3Tn7Whs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jqPIFg/8Z7kSQ/NRPAlYcFI5r+jIK12zBg4Faxdg0JUQyych2VqImNHlSTVB1fqD9
	 XJ/iwkDtaI3tm1RrrWOLFSbmOuYanESm134vViIVkJbqRLRYcWhcnxuvlq95JkhOwi
	 wJ3gCSyawo1FZ3Lhe699u5FvfYpbE5j4ZGnSKe8d3QyISe0+iC3CbwxQtNAdeClaIf
	 PrY/Rzpt2URW7Uvt0g5qwYM+SSqJxtDcnvKSFKkPbVhP4RQwafr0uDeJR8usFhr8bp
	 P2Et6cNxq3GdGVPkP7AQtugmpqHctSgnQkcImEJrwOdGAdfYiJHTmU+pzTt1jIU8GO
	 glaFHNx37664g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D0CB6069E;
	Mon,  5 Oct 2026 22:50:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2237E34E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 086E440203
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2SAkG6mguUf for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9FFE840042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791240211;
 b=ADFqaaE/yeR3jC4NYBHP6dteFS2I8DtVEsCTYtpDPQVInnpZHSSli00O8GeEVndbLTsj
 OrGPhAXuOZGLRuLO+MQWod8p8rsHnztofooySjoGGqyjqXNkWrkFiAYAtG2EKnWK8/6Sq
 GKuMz96sOQV5cJbhb2rfQAH0zMgvpPh1oswebwklLpfzhPE62HKSLpdsVapLOBYM8bW22
 sTgHUeUbBsG/ftn+LeHO+zsuyKLl84dLqt7k4HCvyPFzEqwsMWphon/Tbost68NV2ODjh
 coy/AUZiorTXaBfvr8X1rvKmWNcV663ewRwN5GDlDA2njrmDWKsTvys3wz8CP3g/Emg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791240211;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=KjvypWjimahqK0uq+bOrgO3QIP9TuaBCD0hm3Tn7Whs=;
 b=WHMXkuTQ4Tt+vvvj7VAcHvnn3a8Zrr2WXcNGPvyNzuZI1DvwacFl4WYJ9aEvrrm05Z9E
 x+1ZBUJTyCVflOZdci2vG2fWpVM8bEW8lgybezSG7atrTM1Guz38vnMhb2Xzq2RYpaKKw
 mrpFomTVVAYiJYxMPbS3BICnbK9wLElGtwdbzvJnGYKoczhp7oAPbB42q5hpRaI0DvDNa
 cEB/NiL9JWkpIHpqCyrLI+uMnGeCFcpBKWh8Brgpxh9YATWB2oNgh2gRi6yPV89NQzJJs
 HWHdtODN7nAmDv7oMp4uoOnyPiOwkl+An7UMcllChX2zqNP3E1K9tkOUnVV+J46fMFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oc4Za3g7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oc4Za3g7
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FFE840042
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:43:28 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6dff7185cdeso1028704eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791240207; x=1791845007;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KjvypWjimahqK0uq+bOrgO3QIP9TuaBCD0hm3Tn7Whs=;
 b=oc4Za3g7DRVc2q5CIZvblt3T6XgFtnv3Fa9e5f/1gcTJERbuanvgrBoyeWnl7qkjOW
 XRsturMiEVAwCRHugvv1DBs0ugv6PLQUA7l3ZhgZr/PvwbaBsbWvmUFTXXMNIOwi3t+R
 BSrlV7ypy00QrCPEeGcD89VCZLHwOuGkG0eYUnTpv7Q2NFTleHKv0M/L4A0x6w0ZpzMN
 LFU2CveJrzxj/xeZzayuJuauVmg6rzsZ2+yM0U3uLXWbMM9EOvUU/1IQdWUrwItQG9Ww
 C4TfW2auFCHa4Evtc4TaGUmTtyhK8XD19HyG7KbplrG+z1EO2yPhwVdO8s+SrqwQTqGD
 WlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791240207; x=1791845007;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KjvypWjimahqK0uq+bOrgO3QIP9TuaBCD0hm3Tn7Whs=;
 b=c15O4aV4PUMEn7brhNqaa0Q5UiG7CK1xSPEi4cLuIGa8NpCWs7Y2l3IoKHVYtT1j0r
 mJPMx5+TikOBlAewWqBuO0EklyinKNBbpVmkU76XOw/kHPTzeou9Cnd+cYYc1X34j7OO
 XmH8FGTvy1qTHg/jxHUtqN9ORWYRbzNnk2yqhxJiZNbe0lNDVWjtX9SWcmazRmzrgBTg
 gHkS04mPOia5153rdokxviKlyd1fLAuM/mayhCaHPs9mfXc2TODehwi+Nk4RKX+XNs8w
 HZYok8hbwMKPRvVIwHotmMfmXLGkaYbCFd4zKIIQLMNb+1cZHIVVnc/BLmJJuHQqcWM2
 2mnA==
X-Gm-Message-State: AFuF++mDhcqugSk9y7ty1eKQ3GbWdQDsVm1nt02tCTFoEdsRGIHgm5ui
 2HywZLCt8acJ617Nkfb/xTQTwtTrwATxeRByc8s3pneNnt1HB/VNNHu9LnctiiD8YcI=
X-Gm-Gg: AYBFou0EH8fEj5VwV6RLVMZY2zPgx9Iw71I0S6rfNTPYPt9nH26GxN5ZaGAj4GruViq
 5MpVYFa1alU8CkKKvyNJJ3tsjOte54tFNLWeJ1DKHm8nF6VwhdpccfpIwTYDaVBTcvWM33dKkD1
 cdWgJq53GoTmpnBRLPrXqcl4RZ6t9rTHSXPUFVkpoCa3YsUr54Z/1ewIT8vQqPlNtEwrjy2s2pB
 OQP7xN5A+TxwLK7WFVEBZrktc6oi1niURHVvFNy4RlRpXg2ES4hWBW3w1sJOOSX9MZrznU2FSZk
 d01cpSejbHmOZ6+Luqd9iCXOiatl/nzSiCtAhBtDxq/pDtsyEaDVTm6VAoGIf0XaYbl3Gpthdib
 PFeov1X/b7pfygMf+EY/cziDQOKdWXhY6aWPqHG4wAFPCM7OTdXDeEmSLIye9XbEPHlIAUqd7CJ
 4WztYe/7klT/y6eXp9CnKmwebXlFT9IUynLpC8fRIvE5CuPwwe49dv/spYSmXFy4garNppwyeWy
 x8=
X-Received: by 2002:a05:6820:4c11:b0:6d9:e2f3:9b51 with SMTP id
 006d021491bc7-6df34d6d8aamr10715237eaf.66.1791240207061; 
 Mon, 05 Oct 2026 15:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04d915bsm694448eaf.2.2026.10.05.15.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:43:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] clk: mediatek: propagate rate requests
Date: Mon, 05 Oct 2026 17:42:46 -0500
Message-Id: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQ207DMAyGX6XKNUE59jBNiPdAu3BStwtdDyRZx
 TTt3UlWEELATaJfsr/P9pUE9A4D2RVX4nF1wc1TCuKhIPYIU4/UtSkTwUTJGqGoPQ10jANd/Lx
 ADxGpz4/kzFjLdYWdJql58di59zv45bDlcDavaGOm5YqjC3H2l7t55bnuS6L/k6ycMlrbipeNU
 YhGPxu4nJzx+GjnkRxum8jj2zktEjc7GTEEuC+yK/afimZTYOsSd0gBYTovga4iGYxoStNJUND
 IH4anPPdfuO+zBDf1J6RzZuVpuZVGt3WllIHfLAMBaQqji7sC27ps6lLaCgVY0KzVFbDUrGQtW
 Zt/Lmur0p63D69DW6S4AQAA
X-Change-ID: 20260924-clk-mtk-propagate-rate-310bcc157ef5
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3421; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xTIigCCVx8BNaSucM4lTKjOHvKh5Xc0dgPNbYnr6tEA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxCfo/TdbP73wyV2VbbAViE0N2r/y0NefxPFRq
 kkfcdxY5vWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQn6BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3OAIAII7aTvgmKagXy3E3Kq9iytRsMIuf9S4OvT8M8r
 6VLmZVg9n/qNGtuyXj91vhgToYR2+SMss925ZmhWPanALnmeB6igLJ7v4DI9yrtXQj44ru7QoSZ
 2dCCLiYBzgpJ80rjfsIHcumEPsZmzxUvtAONK+ZAkq+RIjZe8nnQ4wULfWi7/bjNaS3RWnc7fi5
 BvEp0FWiX6agcQD90qusqyMlHXJQi/gthA4JCaQFPkhfQZcbjUIeOUiDsIubbsmXufczGjKR5xq
 cICj2zOxSuOnzEiQG0zzA9E6X+z810OoGrA17pO3S7UWn1I7km3/eBFBZsNyaDPCn+BCDyEDkHq
 pFyk=
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

We will need to be able to set the pixel clock rate for the eDP panel
on Genio 720, so as a prerequisite we need to implement a bit more of
the set_rate functionality for the clock tree. The way the eDP driver
will work is that it sets the PLL rate first, then sets the rate of a
gate clock to get it to select the correct parent, which is the PLL that
was just set to the exact rate that we need.

While implementing this, we noticed a few bugs in the existing code, so
we fix those first.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- New patch: pass the input rate to mtk_pll_calc_values(), so that
  mtk_pll_round_rate() looks it up only once.
- Explain in the mux rate request comment why the selected input is not
  enabled.
- Link to v1: https://patch.msgid.link/20260925-clk-mtk-propagate-rate-v1-0-8c7169b4eeb5@baylibre.com

---
David Lechner (4):
      clk: mediatek: don't truncate the requested PLL rate
      clk: mediatek: return the new rate from PLL set_rate
      clk: mediatek: pass the input rate to mtk_pll_calc_values()
      clk: mediatek: select mux inputs by rate

 arch/arm/mach-mediatek/mt7629/init.c |   8 +-
 arch/arm/mach-mediatek/mt8516/init.c |   8 +-
 drivers/clk/mediatek/clk-mtk.c       | 306 +++++++++++++++++++++++++++--------
 3 files changed, 247 insertions(+), 75 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20260924-clk-mtk-propagate-rate-310bcc157ef5
prerequisite-message-id: <20260929-clk-mediatek-cleanups-v2-0-b296bf3a4a93@baylibre.com>
prerequisite-patch-id: f7d20fd912a63ecd5f74bf715b9440dc51943b20
prerequisite-patch-id: 17573db457a9724fd00a382b6b47041d1e3925b3
prerequisite-patch-id: af5cedd64f7bba7516ad72ed60495245918ba5ea
prerequisite-patch-id: 1dfdabc642d685aec02e163eaaaf316f013f27cb
prerequisite-patch-id: 01db7b89d970b31f8b7f300182c177ef182e258e
prerequisite-patch-id: 2d62bec1fd01c1aaa374796fc331c81c9b86be91
prerequisite-patch-id: f603047a5fe691eb4768638b1dd2c860fcc1093b
prerequisite-patch-id: cc0884d959385c6eda0b1584b9e76d66be401905
prerequisite-patch-id: cb3934029d3adf3d1c67fa93284229476b589e65
prerequisite-patch-id: 4851327632c9d0e57fa8220b619f2f8da63ab014
prerequisite-patch-id: 818bc3d5cf951c4dd6740a681503c29ca89169c2
prerequisite-message-id: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
prerequisite-patch-id: 46b77492636ad6a60e34f290ed8563dcf4438134
prerequisite-patch-id: 70625bfc712fa2d4b9f27b46c18d4dd58940c5fc
prerequisite-patch-id: 647593cda7ed838507a19315dcd2591c526265e4
prerequisite-patch-id: a56141abdc8666de730c913b072ae174af13217b
prerequisite-patch-id: df75ef6ff7531c8cd25ac2258ac3c5c600886bb4
prerequisite-patch-id: 5e1dc7764ded4b0fd5e999bd75a25884a13ccd0e
prerequisite-patch-id: 92d21ec1e2bdbb1b46f1c74a1917408cfaa865d7
prerequisite-patch-id: 55fb54aebf06acdffcaad16b32560473da088e0d
prerequisite-patch-id: 76645ab8a56e3363ef78c65e59a252a3692e7a86
prerequisite-patch-id: d44379cef68a1817282358087bb4103fd6d86bf5
prerequisite-patch-id: 004b1897736569cf060d929c2d47790edf09a742
prerequisite-patch-id: 0dc729831dc5ebf3f6ce3905db5109e7223db713
prerequisite-patch-id: 88a278a3840d5f9b210f58effe6f5b61126cd5f1
prerequisite-patch-id: 393d77072a0bc5d2cafcb672e6a071226422a253
prerequisite-patch-id: 2b0ea0b5f5e178cf0d2af8c307bc1ffe500f5358

Best regards,
--  
David Lechner <dlechner@baylibre.com>

