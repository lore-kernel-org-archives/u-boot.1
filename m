Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E6CFB5164
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B53883E36;
	Mon,  6 Apr 2026 22:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QFBGfdUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BF9840AB; Mon,  6 Apr 2026 22:37:34 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A1883C2B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbec19732eso862473a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775507851; x=1776112651;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=acMrPZu2cuSlefpA4hGZJUY5Kg3wSP5wJ1haAbINhhA=;
 b=QFBGfdUD6z8A7xbEHE18bMM0k1NNfOXkmxli6v/XeUP+k0TDHgF2fnS0NMJeqQnx4p
 mN1QDsQ2ypVW0qSdF2M2rt3p8RwBO7kPmPuxAKFRV2PZ+Z8lGolfi1vwIc7zt9NGSoyg
 DsWbUH91vJsHvThbFxvNfRgLFHNOY/XBS64WPfwLW9axEktgrMyf6HsM6XbXiArS9y2r
 sEm3zthK1fZ+k3xeO1uqSI1RxhcK+NGLEmy8VwtnEB/jymuFJx/g6kQSv5M/Sa3HRN49
 xwIn5J5yUjnbS/vytyrzafJm+EygJ4ZtnxQINegRGM8lA4odE1qozFkj9dufYABQ2jGO
 3MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775507851; x=1776112651;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acMrPZu2cuSlefpA4hGZJUY5Kg3wSP5wJ1haAbINhhA=;
 b=QYiqOhNY9ClKbkBCUr+gkRFx3qWJrGO5YUPZO+leroCpOXnJetOetuNTZLgnKVQkED
 AqCoXmPESFQ+rExCm+6iZhdJr+9RIEV7C0YXvzgkj1FQdkq6zn8vlNaED9igedgpIgU8
 LHgvWyx0t4OSqFEBNhIW58qDv3fy6271ZfVQFVSHA3b7FPnd7WT+UDEIdijNrEI/xnVM
 RIghcyKxeYUHMJUEXP0cIlM4K4VF32Qj8IZlbHKJC+nId5XRjeJGODrgKK0D/+utn4PJ
 gYlJAoxp7WRbT+f5cQ6o+OwrjzR+A8f9fNiO40qpJT4tLDNyucSPCiuWlgpsSDEz8aad
 77tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVghV4RIrsIl1mDYpWFkTDkAqtItdLpLLOGBLvPG4Tt786Q6gOWvkYlhb6BcAfbmknEO8IQx+c=@lists.denx.de
X-Gm-Message-State: AOJu0YyF/hjecxyzEvWoWmT7BaZAjy03czSpmd2tGR9oE4+eOYn8pBnp
 Sbz+yEZlyyevhebbzMsT4BrdOHKVkgkA9kVQ64uW0EtYONskmDzucMK88UYnD2WDWZ0=
X-Gm-Gg: AeBDieut6a92/ibxYD8QtwjdXMwGP4vZM/9XIO5RAwkvToeJxIEdqBPVAb577Kh9mwG
 6Bvb1oqd3Cx1Wr5ITP1uPu9xRPf/Wh6HFaHjFn5ISecF+mFhDKrg2EGxJEpUdO1uU68Guwn0Pv6
 stWSL3iVf7X5JMTm6Kvrv1pnB0yYcuzQf/CASZ7mg0BiIyFZu1qyENAay1BvT5Cv8Fh0Li7oPbg
 t6KrcSshClBgmdh+13WP2vFXAa+6tuT0YX2cKbGPFum1PXMQWuz9Azwg/5tRjTBgEsyXay1rL02
 e2bhInE3ZLQkLtryxKGFtDPGCAkOTAolCd5dr8ZGnc8lKf3XUDzXlu0RwVyMzyV+LawLxU3sZ9Z
 seLOcJtvEX3wE8sPnGT27VV1GWp4lOx1a5yB4GFuYyF41e2lk9LsQKQwFvVtEqYQnpr3ea0IzdR
 +/Kok0aKosTaO17S0Y299AZ3ihcek9UqMhv3NHdA==
X-Received: by 2002:a05:6820:4c81:b0:67e:2de7:529d with SMTP id
 006d021491bc7-6821d747d9amr7342046eaf.9.1775507851369; 
 Mon, 06 Apr 2026 13:37:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68386edba6bsm5359048eaf.14.2026.04.06.13.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:37:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] arm: mediatek: enable SNOR on Genio 520/720 EVK
Date: Mon, 06 Apr 2026 15:37:08 -0500
Message-Id: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAxA0atI1hNoS1XwKjKLqlGj2EqjIoh3n
 zou3+L/C4Qik0CVXRDpYOHgE/Qng3Z0fiDkLhmMMoWyqsBlm3EgzwFLo1B8iGi0ds7lNu9tAyl
 cI/V8/qf197XszUTt9pzgvn8oSrELdgAAAA==
X-Change-ID: 20260406-mtk-genio-720-snor-211aaa545f4b
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RaM/1Ed+NNCIf2133JGQ7Uej3Kz12afpPqvCLjqDg6c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1Bl2aZohBvOfx9NUKcBJjzOghgY4Bwqu5iKPQ
 xa/QbnMFgKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQZdhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AwqwH/1GC4/7szY/xDS4mdPiu4lcxKq6XXllS4ZWWezp
 wkvdLNdL55Fx/al3jo6m4QSB5pFZPJLvr5b9rPZ5MhceDERIPggdvrtQjevWkJnltBRYI4DqSTC
 xHWnMafJxIJ3X6HuSUCFTlE10rgJNpWkE+DYi9ztPUbnyFYIhT7xR4WKWC7/K4DXKGxSBjEo+xN
 iys4xQSkrtTw0uNRzI1vwBMp5njF6GAfaGvg4G2QlhaCX4PdDUpnEypS8KAPp0tSoWYcNT51Kro
 OlzwTU36HHUE6xdG8AUItiFpVTJpp7ynkLRCsPfMsBOmOdceFv9F6S57ss/bB5Mt0t+0kwbHR/1
 e2+k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add required devicetree nodes and configuration options to enable SNOR
on Genio 520 and 720 EVKs.

For now, the common config for these boards is in the mt8189.config
file since there aren't any other boards using it. If more boards are
added in the future, we may want to split some of that out. I think it
is better to wait to do that though so it is more clear what is common
and what is not.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      arm: dts: mediatek: add Genio 520/720 SNOR support
      configs: mediatek: add required config for SNOR on Genio 520/720 EVK

 arch/arm/dts/mt8189.dtsi              | 17 +++++++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi | 31 +++++++++++++++++++++++++++++++
 configs/mt8189.config                 |  6 ++++++
 3 files changed, 54 insertions(+)
---
base-commit: 2e9ed23b3c4fb75dee8b87a72968f318c97a9438
change-id: 20260406-mtk-genio-720-snor-211aaa545f4b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

