Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961A1CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5939B608F2;
	Fri,  9 Oct 2026 16:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCR4Byg77-VE; Fri,  9 Oct 2026 16:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69688608EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562580;
	b=c8PfVDeYF/IHQtacRotBUbGUXfisH26z/HeQN3pJnbKHHUhD3AgXaYm6ExUx00PtXx2L
	 rsEYa1QNtY1kiwxBrytMpqmIl7mUvf1pRwYqYAc/BzgvyCbHyMIC69N7uHU3ARxa10XxR
	 UhPkIr7DKyY2Em4VoDUVOirZCU9WSE6zGM8XEZVs3xDuxfPwhtUhPC1buhlgWBM8znybe
	 ZuLeXKJuJygl2htaR2ulwsuTEB7rgge6BFKicyBGH/wFexLq+5e1RBbObv1M1LUYerL2g
	 5UjzlCsgW2MGc+gsf6QOn/+9qveci3dqJeRP6wHERU4MY6RcxzlgrUTTRRduEmZX75g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YIRAacO/cITeAkpimymcENnl8EPRX1bWpLRjyjUbvCc=;
	b=ek2vhrjZG9nN6xxpBHIEAs3cgjEfY8UxusFTUv5UGwEz7wTnZB+AskYfXMYG+ED74af9
	 uKowFbJCSKC7/tHcSg9nywD6F/LAWl6E2uzBaElmEA3IddaRLEL0y4cBl4dlI+O91BzRI
	 O6D4lbdBT9imp3ji+qFK1VYo3sr3frICMW7ByCu7yRQabrABZloBHSnZq9f7T1TQQoxKI
	 7DD9BwlExJnYvNqPk2YahOgch33Z1TeE1+Duxk3wdBlWUMfC+phUU+S8c3XyyByN/FluL
	 FV3NhTG81vYyNN6oDfo8W6h8pUfsVRTgBLnoO7U4+7pqp0V7cHAt3BH195GVL7j1eEg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562580;
	bh=YIRAacO/cITeAkpimymcENnl8EPRX1bWpLRjyjUbvCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDMRaG/NItnXu8uElMDMpHFofSey+kBzT3wGkXZnQQz1BVAsaxUkNXSz43yyFisDt
	 WxL3Nv5ZyRB3y6tzh7P7OOoSLfxKruYsTyLlnaqC4RkJuNwk0KonPTVCNrWWOL5NJD
	 nEXpiuO35QfOPmBjeGoa542q/StO+cDerYIUOLbKOg048dlIenwWsx+x3qaCki2/gI
	 8GkxayEKdFSiVtjVYMV+FyOqE+4c9WDA7aIqcKWwhGDjCC34+eAdB0WlfDNycVMqXd
	 fONnScTSLSsE0UYZzYQY5OORhT5F27tbOQCIprOmF3einGoJLmliy/4Ioa39bjqQ8i
	 I5Puvw7Hv/clw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69688608EC;
	Fri,  9 Oct 2026 16:16:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 283E5184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ECCB81416
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQxZ8yWU3bgA for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EF1A81412
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562570;
 b=Z7iJw7xtkGT+hLt/sq18bdFNfeLYWdmI6Y6UWVQ0bi+XRVuJ0gCd95WcCNePzikRNKPE
 w2NAa8jhVnct6I/pjBY+v3d0Uzc9qxZ9d4VxZKzoOK/nHHpKlvOr77QzdMbN92TVJPlK+
 gD+XpAFkQ/KmBmKQUp8hGjkbkK5uhGeXNP7yz0Rqq7XUJZFXnSqzIdHJcDKxE8SRdhrC/
 3P9swYQ9L+2Nfo7PM5fk6ejEiPV9Mm8aFxLXeRTVswQmXfXnZLQReT87Vidsg1ML8GGSP
 xab3+vQIEu7NeOCD6e2rWS8/TQBI4gjypuILfq/O0gtXoWYGnrtNKv3BQUZPuMf5dpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562570;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=YIRAacO/cITeAkpimymcENnl8EPRX1bWpLRjyjUbvCc=;
 b=Eb5NwYIi9jSFkvCx6Bj7qChZTluZPoM0M4EuBsxJrwoh5l8HSci6ePxZpbIKgvVMO/Az
 59WfXVhttXEMgm/P1Zx66f8E1ooyZyj7NgsV3e7V4T2di7r7Rwj+HJDh+U5+WrMfLx9a9
 9DLwE4RiJwrNnbNWDJiEsxkEBlKBJGVlvy4f5wKRVY0q9STXwjU5oPR1EVKsrt61Jrf2E
 XOljniPahVb8vit2JnfwGkiaatbjthz6btw3esvGm7l1g6N5WBwGJfveotaS5oqkscDWw
 QBWOfWH8uKkVv1mvEKmRPtck8vwDBvFoZPKzUkbSc0u2/So1JA4HJaKGRw1doTBcAYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SR4fSQ4Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SR4fSQ4Q
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EF1A81412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:10 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-504ae5941faso1265800b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562569; x=1792167369;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YIRAacO/cITeAkpimymcENnl8EPRX1bWpLRjyjUbvCc=;
 b=SR4fSQ4QINEOpNNCKM1+TbGH2+nIW4f3oN3O2qvLD4Wu+UsjZG6axeJ3NvjGQnB1rg
 CDW1d22AJ0lYhJH7Zmxbd5fj7zpVAVSs/Ge5geUDG79/3pGzVl2r8GzUtzxfKhrwzxwv
 DrwxISznkAt+Zu4MJhqKYd8xIvjk3ZkKdSBt3PLy5Yh2lJCj5OSVy4zcYQsyT2+DqnYl
 vEuHO5SPeZM4nVH79XzQojmE+ij/RoWsN4x8pOV2O01L+jV9F8loDrnxlbaXbHpowWDd
 fel/exKs0pP1bCiCrnhTuiNSreUmiUQD7gj693SeENx7NpCsIiWkzI5TWoG6B7Spd7bh
 okDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562569; x=1792167369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YIRAacO/cITeAkpimymcENnl8EPRX1bWpLRjyjUbvCc=;
 b=qMzbTQiOHW8pJ1GcrZLrkkUWHX4GvlhIqBHJBVEgVuPSwSB8p1zDxQzq6eA7rEdCze
 5E5p5Mar8oavdbItBQarH0PE12y3KWdJmtdykAWw1PxcBUW4rsxM3ffj92bH38IlPHlw
 HHLKptvYlHMpZgvw/Zp1/Zf9z7HmJk8w25iSn/Kc3hBU8FB/XeWiLtm9xNmzU+N0NlrW
 fBQ4jVNqItaWzxn8ZP89r+7hfyaGx9SIhKD3pEv9RtEb1SrCT0f7j1N6Ny7AsXPvCpS2
 RaTLzW63BjHEjMo8RH+OM9kwTGLGamvq1lsROoYQ9Lw5MCYnIE/0mKNmjBa9h2itiz03
 vzYw==
X-Gm-Message-State: AFuF++loxn8Zy8liM8yHczrdhDeyhXaFrB7TMgbEtbBuVoY7F+9YEzuL
 1cVAD/O9cvtSsxVbEgPed+HLpoioiYyv/2XDgvQDMcD2aLMEZ8K8KqBZl8RpKFxAUh8DZZSrZQu
 mvEWA
X-Gm-Gg: AYBFou0eYn29MkoT86NDnpLobdmY2j8CpFYheWZeOjL3SYZhaqFjy7Wh6eBzvpQijZ4
 LDwfWdIhDYUPE32KatuSBfMtSr+428V+qCDaJydAdiAKVN+eBE9GCOUL9SsvWsFLYaVBBGC8bCV
 bkJutFemuCPXspwwaryTIlbZi1v5JBrovoWv4Prq4N069s7y8ODQhLKp+ZlJ8IBzdIlhtOk83dy
 Ee8IE/mPNYmDaGXp2RbHh4IIvPQSp0oLbU0s8ysvSwRLZyMVgkXJpTex1PuL7Oupy0M3erUy18l
 l/ked7eL4KaWPEFssWGxyMiz3gIVwyNtKlU99CDNROkrKvTiCxpcP4xScfHctLacEF42+djuSUN
 1XPtv3S4SAKAbW68Ieun8F2Jz6QxVE1G+BiAUFQbQ6TQTKRpHEhNFesjRrMlakOPG/LtA0fngjE
 Z8G/zL7Pg6XumBwlPlT6rB0vxrUR5eoF5JhheFjQDHO8kROPihCAY+PCUBo6i0BsSPOZSKNHBOS
 Hc=
X-Received: by 2002:a05:6808:309d:b0:4c0:89e5:da46 with SMTP id
 5614622812f47-50c54177a6bmr2287465b6e.32.1791562569040; 
 Fri, 09 Oct 2026 09:16:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:16:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:15 -0500
Subject: [PATCH 12/13] arm: dts: mediatek: add an eDP overlay for the Genio
 520 and 720 EVKs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-12-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3312; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=g3tDO/wj3mRU9k8POYaU7Jj4hCpOSJ13L/fo3cROOyY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRMjTPblHri/gmLYIW5i77BpTMBYp9vjU0QMU
 UmGNbhjL0yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskTIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATwUH/2U3TvO9EIbxjDjIR0yqtbEq0r4UBHX3qYUU8Sb
 pf1nk444Sjms5b4kE0VHTh+PqqO4+P6FbivhJ30kyJlzOz7cCFSc2kUPrs4MpWAn83lHcD/zTnO
 UwPDnGah4EQ5kogmzYX6E/Uc+DFk3KolJrrdomHsClyEWBu0za6m+ZiTF2Ap9Cq3CU8hhH4TvRW
 ELYtgQFhh19+XEIVkFdIoSCTVBjyhs5XxxXIaxU9bnQcGCVc5QulLh5xuQEKWeDE1KazxhunxhN
 zd3LCoRhtpmXAXAcVEgphbBSihGXpQKo24K/KP8zxpWeaCX88cSUe2miwJCfwoqRiCRrLzo8B27
 aJMY=
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

Add an overlay that drives the panel on the EVK's eDP connector instead
of the DSI panel. It only changes the status of nodes the common include
already describes: it disables the DSI host, its PHY, its backlight and
PWM, and enables the DVO output stage, the eDP transmitter and its PHY,
and the eDP backlight, PWM and supplies. The two paths share the display
pipeline, so only one can be enabled at a time.

Build it into eDP variants of the Genio 520 and 720 EVK device trees,
both with and without the UFS overlay.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                     | 12 +++++++
 arch/arm/dts/mt8371-genio-common-edp.dtso | 54 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6759224389f..f309710570a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1047,8 +1047,16 @@ dtb-$(CONFIG_SOC_K3_AM62D2) += k3-am62d2-r5-evm.dtb
 dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb \
 			       k3-am62p5-verdin-r5.dtb
 
+mt8371-genio-520-evk-edp-dtbs := mt8371-genio-520-evk.dtb mt8371-genio-common-edp.dtbo
 mt8371-genio-520-evk-ufs-dtbs := mt8371-genio-520-evk.dtb mt8371-genio-common-ufs.dtbo
+mt8371-genio-520-evk-ufs-edp-dtbs := mt8371-genio-520-evk.dtb \
+				     mt8371-genio-common-ufs.dtbo \
+				     mt8371-genio-common-edp.dtbo
+mt8391-genio-720-evk-edp-dtbs := mt8391-genio-720-evk.dtb mt8371-genio-common-edp.dtbo
 mt8391-genio-720-evk-ufs-dtbs := mt8391-genio-720-evk.dtb mt8371-genio-common-ufs.dtbo
+mt8391-genio-720-evk-ufs-edp-dtbs := mt8391-genio-720-evk.dtb \
+				     mt8371-genio-common-ufs.dtbo \
+				     mt8371-genio-common-edp.dtbo
 
 dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7622-rfb.dtb \
@@ -1071,9 +1079,13 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8183-pumpkin.dtb \
 	mt8366-genio-360-evk.dtb \
 	mt8371-genio-520-evk.dtb \
+	mt8371-genio-520-evk-edp.dtb \
 	mt8371-genio-520-evk-ufs.dtb \
+	mt8371-genio-520-evk-ufs-edp.dtb \
 	mt8391-genio-720-evk.dtb \
+	mt8391-genio-720-evk-edp.dtb \
 	mt8391-genio-720-evk-ufs.dtb \
+	mt8391-genio-720-evk-ufs-edp.dtb \
 	mt8512-bm1-emmc.dtb \
 	mt8516-pumpkin.dtb \
 	mt8518-ap1-emmc.dtb
diff --git a/arch/arm/dts/mt8371-genio-common-edp.dtso b/arch/arm/dts/mt8371-genio-common-edp.dtso
new file mode 100644
index 00000000000..13385968a18
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-common-edp.dtso
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2026 BayLibre, SAS.
+ *
+ * Drives the panel on the EVK's eDP connector instead of the DSI panel.
+ * The two share the display pipeline, so only one can be enabled at a time.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lcd0 {
+	status = "disabled";
+};
+
+&backlight_lcd1 {
+	status = "okay";
+};
+
+&disp_dvo0 {
+	status = "okay";
+};
+
+&disp_pwm0 {
+	status = "disabled";
+};
+
+&disp_pwm1 {
+	status = "okay";
+};
+
+&dsi0 {
+	status = "disabled";
+};
+
+&edp_phy {
+	status = "okay";
+};
+
+&edp_tx {
+	status = "okay";
+};
+
+&mipi_tx_config0 {
+	status = "disabled";
+};
+
+&reg_edp_backlight_12v {
+	status = "okay";
+};
+
+&reg_edp_panel_3v3 {
+	status = "okay";
+};

-- 
2.53.0

