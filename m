Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55897CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 21:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB95760B9E;
	Tue,  6 Oct 2026 21:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwYSgAnH9jIC; Tue,  6 Oct 2026 21:48:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 10C6560B14
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791323312;
	b=l5XXBKGvFwOYVCHU7hBMGVA/ORSIxhzL0HKgy2m5EaA8fobZw2vbAtosQlDn4HCrBqfF
	 4VsoTp3EdKS8i66qq9n0QCwqonWgS+XOMOzOQ5l/4PBsLuJyS5Yd4t8q098mw9dgiKKbI
	 gzpfstkykCkFeyLrY1uA18UTquMT+iYvNETSyPdgMK8WSUCVKCsqYXKsVEli/Tx+O7FWT
	 M92y4+wRe2azZICOBh5IS2ZHE4zpJFiniICw6h34zPyFiC4P+6g0MONF39NQ5cEccIn4O
	 hbEKIdDj0QQJPMhZVYy2gMVsxw4tJAPcfj3qXAJusgAUS3jQ4z0TJot3CzNGwBbUzGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791323312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bNGJWT4QJA2F4OZAvVXVT/UHZIt+wkBSB4irSPSuH/8=;
	b=CVh5LRxqe2lEQ0aT26VHikUVzWRrb+fYReh5qW58bLsegACuKBGGS6t5OvAxmrQUzWfn
	 1r4odfrwGcW9aAIS+dH8Pgp4mthBxglsOvyS+LQDdIn3LozFyn30n9lbTXRJ0REwWLF2x
	 1n53hKFLLKFOfsZhbb6VU5U8I9ntPt3OrJalltcgGwdyqadt4S6zeR+rkRbOWS00chJS+
	 XyvY6El3FoAFoHe5rLe8W/n1V2W8t6Aqdl6GxALYDE0ADPUBzCe24N/eh9jwqxqKbAsoH
	 sUAlZhvCuZ5M+BbhSPOvL8zuNJhgiZA5JfOqzDhu/3KvL65WUpT4loArF9s2gzJimyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791323312;
	bh=bNGJWT4QJA2F4OZAvVXVT/UHZIt+wkBSB4irSPSuH/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x1jQf0dow7dEi6FPygUPGW8Q/XO/hmX72Qv8BlWiH49I7UNknGl9HVM6q7nk1QXfE
	 6ao2N1taizNAXx9dS4BPVZWvqPvO53ynPfurIZjqKf6l4WnrZ/phqmd/J4esIVYlff
	 SuMkRuqP2zzC8T/58pzEIhZysQC9KFTMGWOXk80Xn7DF0Ybyzov8Jcc1JMD62IgcAb
	 bQh/QhEYtpwDQ397H+X3nqsagHazDbGKJymWcwFjHg9ZYjqCotrkJO50cYPTiWfKLa
	 8KSyBZRF/EQYBoq74YQZGv3PSnaM0bjMhkrxOJq4XNDhd70MlDiredw2lcm3vZ0PWp
	 NPjkPZf+4nVUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10C6560B14;
	Tue,  6 Oct 2026 21:48:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2779232F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E2DC402D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppq4kE0ji20N for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 21:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5589040210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791322656;
 b=pBETdQLSSxm2JKQ72QnL7XBS9eZyxBV4wivtXVpF4+Um487FdlEs0Ea3hCIqA05VDxSJ
 kCvkETL4I/0Zqf1tWEoetKaJnrhr0K3cmLf2+b1dB01i0DkjTDSLT2vcn5nU9SGrlBZ7v
 Ac8spnHJCxxa68r9MYvrWyeDbHh411FwPnlbWySaP2wAmXz5lABOOkOX27aqifCLNis9E
 lwkg4N+wkqLSXf27xZns7YH21yIASckuXnsEoKPzLcNNwhtPq5c37VlkITOAw9Nm8G/YH
 74WLxEZYAaGynF6HxpDgv+vgAEl8r0eQJytrmOexmaYDXyi84s01ZpAVEIIpbYNhZYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791322656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=bNGJWT4QJA2F4OZAvVXVT/UHZIt+wkBSB4irSPSuH/8=;
 b=XOfuKBwzq6Q3HU88UVXcIA4K99qNRolU/8v7oxsr3AURzhZqRf609ag1QFF0u9UE4mSP
 mWvb+WnyDQhtLTmuKU6TOm/SUfJBT+cBWxmT8djOUr6LJsGHzqNtu+qO8ghY9d1joFLYG
 utVQF0n6bVovg4akpS4ewAY+p9OwZzZRhs4i549xoAEszEYsnFVhgiVpL8QbuQeleWKwP
 U4lGeKwcVNTHezKgv/EVVWBuW/j2YZtXUGIu7pfqnBCzdIMFm0kvg7DfLNHTU+wOKXz3D
 /RP5tLFupOAYHqppXhWDwntX7Qce0AIX399EPaX/xkCb3TpXyhRKfFHWTzVY0vbAwZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=guIIYtiF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=guIIYtiF
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5589040210
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 21:37:36 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4d198f1a591so538477b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791322655; x=1791927455;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bNGJWT4QJA2F4OZAvVXVT/UHZIt+wkBSB4irSPSuH/8=;
 b=guIIYtiFIISUMJwhCERiRxdv0YnLoB7cfZOEJx1FrLYLZXeNuEgANd0agb3jHcG2+f
 oZyOSC3BzRz0fnzAxUywcsnvdUusFhaN5KQd6m3l8txm7E+VAlPGnlijGT1gvBkH0ehc
 /DoxFa02bzlEtYrN9xC4duU1vEfBBMi2bip/8Dl/EUciYN2X6bZbeq4eWUs6LY7R9Nne
 DPSL87NIXsqVlBKLjOH2Qg4gJbZfzwPazeXfLyYovlTxT5BUiejonji6AygHE+K8ocgN
 X+4rSm21QmME5BeP52JnrlSoTpPYsZYwPcT/byImRBbemphWtLfwBxfEVd18LXau8m2/
 K5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791322655; x=1791927455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bNGJWT4QJA2F4OZAvVXVT/UHZIt+wkBSB4irSPSuH/8=;
 b=IAH9LIhgQ4CeP72/teHzxBoPdgcs8Pqtn4DT3hDIrCGeFA0K5hAdIhoQSjids40j4u
 myS84Mojz2Qmo2gTzWPxl5VyovYokLN8OHjX2MT5u3TZBW7rdCndndA2AaeAq380iKzS
 TPoeup9k6z/q3KHo0T1nXax+DbZQRnQApSgxfTTt0rzzFLKmEF/tq/TE2ljxrk5t9Ggn
 2zvzLM88QLZXsWpq6pTF+jEy3kLuTDD5bvoLt9o7sVLTnYV7MWm1oKNB3HKN48Z1RKUn
 mBDakxJ+dq+xhwlVq3C0fzFhSDzw2g1vkh8nSiuY090cB1Ctoe0jJiLfo9dYlso45nCH
 qTHQ==
X-Gm-Message-State: AFuF++mFSl6Gg0278Sznd480xD7lErr5ZQkFzylIDa9Dgk12O4P6A5Q/
 GGcn/U8yuYsOXVriixokQstunSgMXmOOQodtFGBPFaAC8WgDEm/D2J6GMnVvE8cuGy0=
X-Gm-Gg: AYBFou34hp4xC7S4aTMy5fOw6+MI1Dwfqm6qO+AtPhJQLf6DOZjLXJr8cgooWjh1SH+
 pqX6d4NEa7fcQDEIBn4/H9Vral78r6MmpjuHR6jqi4Ndz4G46vYO27/Hukp2bTkOSLkShueQ/pt
 41zwHve2P72SvqygjcvwfAvGwx4h3lWEj/v/onUFGSfiUGC3c1HdsG3aZKD9frimHc+6uugSSVU
 +vOWNZ5SsaYptSAGnoEbpb6sZ1XAJcN1mGHDvKgGZ+DB4YQvKYNdYzVoN3laXCOr2lXb3ZKqT2Z
 S/1A6EJ8nuR2Fwo10qKtcz/9KPl33dDj9QXjwWeJmgVDTdN3hXTf7fnrWnLUlsKDk0vCJAUR7Bm
 SUiKh4PvGg4ceYWXtDsRRp+SPwaQxiqTD1MxxKotK/9jMydAiZ5+c06ewJiDznLBZ6uQkgx/kgx
 8KClp7IFFPSZfhR0B53YF41IYRkk0Wcjm37UT6bbqI/b9gRrab8glcz0hxF5EaBMLvg1NIvh+TV
 8DVa32I77Cc
X-Received: by 2002:a05:6808:10cc:b0:4f4:dd0d:207a with SMTP id
 5614622812f47-4fc435f48a4mr659677b6e.4.1791322654175; 
 Tue, 06 Oct 2026 14:37:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc4953f89fsm389386b6e.12.2026.10.06.14.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 14:37:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 16:36:17 -0500
Subject: [PATCH 5/8] arm: dts: mediatek: describe the Genio 360 EVK panel
 VDDP rail
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-mtk-genio-720-dsi-v1-5-7fa10e9c4506@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qP42CWIhQqK6peHINpxuTYjW6iRPnjTwTNrjAvL67C8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxWnxAxEhBzJOUyv2osR6twRn68GnFgeTUeG1+
 QMQNu/AOHOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVp8RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3isH/ivI3xmh4bFdnzgzVXGcgO8D9zyX1qzdwWHz6L+
 FF8Y1brVhtAIsP6jM058lo8cJ/tpAC0SIL9vuxa9t6E1C5QESfOBwp1V3hAR2XzRTiyFkLh9+8L
 0Z0TWNhb6+AN8h/ggZUoHoqcLjqwKQua5MTfxokaSMI/g8QmIcylcWL82touIR4wj03JB1PRACX
 MVD0eY1YYcOtMQ6g/qCEOhoNgVY3dxeeKp0kl6rrp5FCwH+pgIe4CKyk3PDGn6/oON33zWy8kna
 YhmeVFBkSkY3RtZBJgjbvTMkgGKDl0rxB3lMIUsjaSSF2uBF/fOyyqzXI6dEJSXB8c+mKyb6oVz
 xW0Q=
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

Point the panel's vddp-supply at regulator_dsi0_lcm, so the panel node
describes every supply input the panel has.

On this board, one load switch feeds both the panel's VDD and VDDP
inputs, and its enable GPIO also enables the IOVCC LDO, which is why
all three supplies already share one regulator node.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
index 37618b8605d..4dde560f495 100644
--- a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -74,8 +74,8 @@
 	};
 
 	/*
-	 * Panel VDD and IOVCC rails are switched by the same enable GPIO,
-	 * so both -supply properties on the panel node point at this one
+	 * Panel VDD and IOVCC rails are switched by the same enable GPIO, so
+	 * the -supply properties on the panel node all point at this one
 	 * regulator instead of duplicating the GPIO across two nodes. This
 	 * works as long as we don't care what the voltage is. Technically,
 	 * there are two separate regulators though.
@@ -140,6 +140,7 @@
 		pinctrl-0 = <&panel0_pins_default>;
 		backlight = <&backlight_lcd0>;
 		vdd-supply = <&regulator_dsi0_lcm>;
+		vddp-supply = <&regulator_dsi0_lcm>;
 		iovcc-supply = <&regulator_dsi0_lcm>;
 		status = "okay";
 

-- 
2.53.0

