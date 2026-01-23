Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591ED72361
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 09:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B171E83B63;
	Fri, 23 Jan 2026 10:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n9q9P5nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B944483B5E; Fri, 23 Jan 2026 10:41:12 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6138397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 10:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso1950042f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769161270; x=1769766070;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x+JRJAU3Q68MTJ69iUFhSTgVRdpXvxG4W0Nn2fsrOD8=;
 b=n9q9P5nSuzGzCxGFn2s1m4xGUKCiZ7ChDnfxaEKcSkv0OAQgqoLhcxhPyzS7o+z61p
 WAdjoE6Xq4/ERcxKCo8vS0ewVda05MEoDZG16bfVEB7srOQdMi67hsmdXTLNc2SExDER
 rHB73Yhquz+ZA3oPP1mCBes/f5Cb/Sa+ZKg6ZvM35myhyRBMRgKs6Vsns9bbpljBTut/
 yD6wa+wnTEwliLDQKZsxeeVEdp8SHwP0bVWqU12EwL20cC7U8HDEFaaGyTL13gkEIe/p
 D/wTBC0eMVkLdga8RNR73EWMAYJFgrYy/odYN9IbKGZNfp6TMLZFZSCwNRd9WW/efarI
 eiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769161270; x=1769766070;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+JRJAU3Q68MTJ69iUFhSTgVRdpXvxG4W0Nn2fsrOD8=;
 b=dJ6oOYGgVAaPZT2F7K+ZAs4na7b6Xf2gyXhSIFAT+INuf/ZRWuqC9FTqSdyAj3Mb6x
 rCx4y6iS/3Am7sN6iqZR+7xgQW/PwziAy6XxsAgVXFRH50g2VvY3IbZD644NqaKbdjbJ
 IXf0RDwcKH+/16KUaUoydk4vjAAxFWHwwZU71vXsVvRB6AeI3+cgpFXuK2ISzV7K5ZYW
 rlCb8zIYria6Xb7P1rxY6KzbWuql3co3XbB/TCalWBQ5yzRk46WmF1n7Wjz7Yp2xPaBg
 v26BR3u/o2gmV5vqn/Obuvn3v02zZiyboTsQTSnDErr/dTPq9of0TP98hL2AsI98Ly4v
 QlTg==
X-Gm-Message-State: AOJu0Yw8ZIoQBDL1huk21/cXH9juGpYuUD32Ak1+8CsdU1hRHHrUaT4y
 6yj8fodVLNpphJ6x5f+1zz/0VR8UKNVTuNEHZ4mcDcN7g7Akv88KYbLZo2kWcx3m+fU=
X-Gm-Gg: AZuq6aKTh0jrXqBJJqch9GPHy6o3e/MSzmEucfTdHcW+vKaWkjSyc4yy226U5+ul76/
 F3Pgo/pZUWDMuvdwGGYhRQIyBAjW0l9tdL8FRe8FdeqJyzWlWeV9OWTsQVW6U9VUef6/odTyJUu
 M4uentZFxhyBuV0HXdwvl5WPfAvvdGD82bwiO3ib0IfgpQv/trbqWFVMecSzzJaORaPhDfM/vmE
 43zLEzBhNWhtep3IptDvxWuE+r+VmQ/pO+7wgFN3U9twHCgIK8aHX/3n0gGD6uBVwRMj9e+Y0gR
 C9ZCizdG6TVl9dFITgl7NBLHiUBJYnbgykF8iEa6ATbR77otPoNN6dk8cFUG13cvdwjXL7HTHHr
 HgydD+4h3A35eyl3vCxdtwAcOqaYiHjX3+PuwIMKAXMesc594Lx7DeZCRDzGP8itVPQ6ZWJ6eMa
 SmIwHgGvsKmv71BiqRXfNWVvn2hYy18pZl8fYbEkR5aYRRuzMBw5zmJKFg6W6Kcz9CGHZ7vTErW
 9GKPWyz8g==
X-Received: by 2002:a5d:5c89:0:b0:430:fcbc:dc52 with SMTP id
 ffacd0b85a97d-435b1ba2d7fmr4135009f8f.30.1769161270034; 
 Fri, 23 Jan 2026 01:41:10 -0800 (PST)
Received: from [192.168.1.60]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm5147411f8f.20.2026.01.23.01.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 01:41:09 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/5] clk: mediatek: mt8188: fix clocks
Date: Fri, 23 Jan 2026 10:41:08 +0100
Message-Id: <20260123-mt8188-fix-clock-v1-0-e355352bf405@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL73YIWmHWV6CO2tZYehkYE4d2TP
 odh5oXIQThCV7wQ+JYo/sigywJoGY+ZUabMUKnKKK0N7pfV1qKTB2nztGIz1spxyzWRgpydgbP
 8l/2Q0gdmziboYgAAAA==
X-Change-ID: 20260116-mt8188-fix-clock-7a30fe9e3cc0
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

I recently submitted the clock driver for MT8188. I naively submitted a driver that was ported
from the kernel driver, and mostly work to boot a kernel.

Recently David Lechner, added support for the clk dump command for
Mediatek clock drivers, so I used it to check the MT8188 and found
several issues fixed on this series:

- removed topckgen_cg, gates are now part of topckgen
- fixed several parents clocks
- added missing fixed clocks

While at it, I also refactored a bit the driver to improve readability,
and future additions to it.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (5):
      clk: mediatek: mt8188: remove separate topckgen-cg driver
      clk: mediatek: mt8188: fix circular clock dependency
      clk: mediatek: mt8188: add missing fixed clock
      clk: mediatek: mt8188: fix some clock parents
      clk: mediatek: mt8188: refactor driver to improve readability

 drivers/clk/mediatek/clk-mt8188.c | 630 ++++++++++++++++++--------------------
 1 file changed, 294 insertions(+), 336 deletions(-)
---
base-commit: 5a7a784c2947586d2e4900bf39ded89df0f403ff
change-id: 20260116-mt8188-fix-clock-7a30fe9e3cc0

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

