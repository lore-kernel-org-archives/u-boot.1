Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E89CC5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 666D440D99;
	Fri, 14 Aug 2026 14:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KP187BaGevwh; Fri, 14 Aug 2026 14:31:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74CF340CF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786717899;
	bh=BFQfjLq1HjeQKMNRrWLt/Z5TZcRpTXN8PLPU+YRIySE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nuqxpd2c+qvhx/udV8gfju9OEADx5AIaU9pTyCT5GHM5I0KJIu2TvXkVToul1lgje
	 nJSyvo0N4niW1ncheE76ftyvHsizeJBPowPRxSyx7Y3OKDjLIuQh5YZcAq6fupmdeI
	 2H+J5J3Gr1ys5sd9WmZqeUBxK9I1hlYit+IcTqavfEPW+ynchG+IM8RoqTkNIeQyCC
	 xsIqJs7qqydUoc2B50uAvH9VEz58ZHztDjKpgD0eYAuzrmX7B4zn3v2v9w4GEAIflJ
	 WJOKlr0vgCr8srW++HUUUGtv0Pu6G+r7Y0xCVfa38F6NaUWalAozUiPw/hGcNz7YCg
	 XDdm7nXtaDvDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74CF340CF5;
	Fri, 14 Aug 2026 14:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F6F33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5D3480E0D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHeScxqyZ69x for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:31:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EFDA880B0D
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFDA880B0D
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QNklLi0g
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFDA880B0D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:31:34 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b01562adbdso652477eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786717894; x=1787322694;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BFQfjLq1HjeQKMNRrWLt/Z5TZcRpTXN8PLPU+YRIySE=;
 b=QNklLi0gNscMOmJoi+MZKDWVuKT4+2ciZWy1E5hyykrpYeenx/xTFXSKyLSf5mbPSu
 nJVW8QrnGCH1VpxtpXys8VFfL476OpknQBOf5fR/mJSzk2fDfBEiRUqgSi+dx5UrYC5H
 qxgL01idKaLxDISnUC7cg+bFUaPsnf3Is5y+uOwiey6fJhdAlj/2BmXRegdB6p237ubU
 dnH3INbHjX7TxbAWlyEgJNuxWagZ/xxuJ0Qw6SvafW7flYjrmAOLCOHt9TtO4y7ZJ/On
 CSBuJFp1Cql7lnp9xmcC+5RDy/ODIzgSrkhTuaOE2RdD2r0Ew+3+EzEWrmgBfW/fvmRE
 ef5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786717894; x=1787322694;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BFQfjLq1HjeQKMNRrWLt/Z5TZcRpTXN8PLPU+YRIySE=;
 b=RwM1UNWv+zaj70476lduaWllmEpLl7YxCiWP8I9oX+000ENRiB3X+AyG8yEp2UcxFw
 EqBNyarwRjjvyy0XJY7vRgq+whF3fjxv2J23c6c856/rBbCYYkAUmeWdAX6WuwjOMB9X
 TJevlPHJA6r1H9M1sguZ4ZaSUndpYJapdqJjEhs0fBbU8OWudXDitsO0mAUptsqUqWzP
 UXiJAWtUL9fH2FFAIfDi+LurXHskeQW/LkvagvQRmdpEShYqsqc4R+vCI+cbkfIJXov9
 JoqnOUGOXeZcss/2l+Z/mfCvdZxOwsvK3743uCWMHIPpJX68d8ViD/HTJj/umk4fXdwN
 hWaA==
X-Gm-Message-State: AOJu0YyGiXmbuY3tJ+inxvXcmoWg1Hh4eggBCG/4sEWZMK3cmkg36pa1
 ZuevgZ3gOde7QQDgulivXyoRMadOYz0WwgFl6wgVAgK2IianYRdSqazUtZEZ1lC1CV8=
X-Gm-Gg: AR+sD13GS3RlyETfY/7e30ucVtx20q8V96KvrXQVpnrG3ULzMMW93hvizRqhggUqZIS
 q5YlbPkpXDf6Kh01jSZCzGRAoAhIMrQio/LyDP/J0I0JCqVYIO9CSRDTyd9aj9Sy6MQjGQ1lbMM
 ZIit272zE1Az+HoNgFPvSL56q021z0n1BsKcZyXff2w0iecDsBKYqLhW90a+puMBRUr1wTqRYpo
 2dQpPqHgnLex8Zsvh2g1kaGuErd7VRkmh7gMDOAz/pBeqxR4h8J9EcsDrNsYkE8pT0/tSrB/iis
 DcUCnWX7rxAypvfrwHLcCN3oHISBak9dnHdVsh1cbfOUamSlNX00HV4aBi+k8fZz3be0H5gzFE0
 kkKcNNWHcm0q2sqL4YmelbuntVKbFJfHI1uxyspBonzF0XONpBP36tjtT3W29mp5lQIkswaMEV6
 GRdiaL/m09IddAbFNzJPqFWgY033jO/PftOxU0seJSApu+GEx1jfPVuj8vukZwncMuXg==
X-Received: by 2002:a05:6820:808:b0:6a1:8125:ffd with SMTP id
 006d021491bc7-6b0d68dd9a8mr5022473eaf.30.1786717893841; 
 Fri, 14 Aug 2026 07:31:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0dd2e52d5sm1389717eaf.10.2026.08.14.07.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:31:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] clk: mediatek: mt8366: add new clock driver
Date: Fri, 14 Aug 2026 09:31:01 -0500
Message-Id: <20260814-mtk-clk-mt8366-v2-0-5e9e952de8d8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBREf4XctTVtkRZZ+R+GBS0XufKoaZFIC
 P9uwbWryUlmzqwQ0BMGKJIVPM4UyI0R5CkB21bjAxnVkUFyqXjOUzZMHbN9FzNPlWLWNJkWXGt
 +1RBHL48NfQ7hvfxxeJsn2mm37I2WwuT8cjzOYu/9lc+CCXZRGfJGyFzV5maqpSfj8WzdAOW2b
 V+o5pP3wQAAAA==
X-Change-ID: 20260803-mtk-clk-mt8366-cbf571077097
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=RRRQq8HC3ADjCnXjuwKb26+X8GqugpU00g4FLOzjBWA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyavxniSGPwP4odIvA8V59xPR0mToBgcl80zU
 uHbWKnhuryJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8mrxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2ncH/jvaZ+lBhVCrgGrIyonbhwF50uDzG/Bj19XcFaN
 5FUnkDKwNIjh2XQ3o7EiSU1RVXsP71ilxARXkFidh8Ev3kvAyeAcOcIiGCu8XfkC0BXQSIC6KAP
 usp+g6TPbjH8hP9OHmInbgBaL4hQPLMAaWz5BlJ2RPguN8p37PnoSSCi7lI2kphMUz45DXzUc2k
 b90LZbI4GwLtwKp8N7AduJSn3IUOWTQdA3dASvnlRxRMvhcsTOQySHGbOg3XuB9jhKsWs4N4j1X
 71vxxvOrga5XDJGU+njAFLOCamHzs0wunZtJNw3L7y3KzVq4YSDtyFQ4UGwUiULr6WDc/Rql6iP
 QeZ4=
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

A new clock driver for the MediaTek MT8366 SoC. This is part of the
ongoing work to bring up the Genio 360 EVK.

v1 was based on downstream U-Boot, but it turns out that it had a
stripped down version of the clock driver that was missing many clocks.
This has been updated to use downstream Linux as a reference so now
should have all of the clocks.

Previously, we sent the dt-bindings include in a different series [1],
but include it here now to make sure we get the ordering correct when
we apply the patches.

[1]: https://lore.kernel.org/u-boot/20260803-mtk-genio-360-bringup-v1-1-606ee60755b5@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Picked up dt-bindings include patch from [1].
- Add MAINTAINERS entry for dt-bindings include.
- Added a bunch of missing clocks from downstream Linux.
- Link to v1: https://patch.msgid.link/20260803-mtk-clk-mt8366-v1-1-465e0f1286db@baylibre.com

---
Irving-CH Lin (1):
      dt-bindings: clock: add MT8366 clock header

irving.ch.lin (1):
      clk: mediatek: add support for MT8366

 MAINTAINERS                            |    1 +
 drivers/clk/mediatek/Makefile          |    1 +
 drivers/clk/mediatek/clk-mt8366.c      | 1561 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/mt8366-clk.h |  473 ++++++++++
 4 files changed, 2036 insertions(+)
---
base-commit: 4e93493a1b9c1866abcd46bb41bbcf86edd940bf
change-id: 20260803-mtk-clk-mt8366-cbf571077097

Best regards,
--  
David Lechner <dlechner@baylibre.com>

