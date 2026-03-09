Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83312FCA191
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0381183F82;
	Mon,  9 Mar 2026 22:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YWDQFLQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1DA83F82; Mon,  9 Mar 2026 22:29:20 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCDF83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4042fe53946so2869711fac.3
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091756; x=1773696556;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kHCQ4JAr1+xGovJxKSgcvGP9X7TIoMeMAdc9EZiWnIw=;
 b=YWDQFLQcc8zZGWJdsXoD0JNQOq4buLqNZq2aL6nDqzfOVtvQ83J+XydGuvFURYg9UI
 r7V7v5HkzgZEz71EeWKiycYiAySa0ZM/qrDi6Yz0pL7pJeK3h39g1zFgenrhi7DoDg9A
 aIK3IyUN5lCAWtlC2l+I4fXiVGs7TYa0/B5nmRstwZlWFBvnyCZB1zR93UgUUQlAPhmq
 XTC+gpOlRlyPonEbU6dIMMtyddG6eCfJsJQpxsNfTew8tyzrVyO1TyrTYBiw/2BoJa4H
 r5wNwio/d6zlQ0iCfJOY6jb0ZWFzfwuVFhvBjmA3/vfGgUDtYWbvRCBNWuCZ66TbMwpK
 OVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091756; x=1773696556;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHCQ4JAr1+xGovJxKSgcvGP9X7TIoMeMAdc9EZiWnIw=;
 b=rPCf7F1HN24UJ617+/2Ge5bygxwZAyFlDumC68SXulL8gNdWSKlWh8472kHjiGAoDD
 s9XyewneAlm5sjGP5haNIviSWAg1z006aCr0qHBPpiWkGGu6gCr8XbFjIGBbbLzdrSnT
 Eh91pgmvT+6LwmzQa8bXWMFheKzVape/12aDYpx19UyY4nI6ZZ8q5I1+YeCMDqjfrzt9
 2TrSV65ShY1mg0nmlKJk6vfivP7ZJQ5HPjnQPjXLirVgq7dYb39TYSEVLwm5U1ZI2bUB
 vZNW1f5HxX0rUY12qotEDTVVvYerovaNGTwu+cA2DX7c+17iuu267Z+wDbA5qSoSH5Id
 PqhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSMKVT3yqVq08PpR2ZeymfanFYoycPUnI8xQKzKrop8uHr0lPD7MZsCGUf7Klw6f87HoDzttU=@lists.denx.de
X-Gm-Message-State: AOJu0YzIAt5wNLks7McN9a3mlX6l1y+I0piKoqTvaNRLFmZHn4tJ9PVV
 WoMe/So55KecI0oWOsAmvSZIfKXxSMQh4lrom7bnm1Ks+KlB8qhvtVhkMkVDgEuKQ277JLJY2DF
 Inlmq
X-Gm-Gg: ATEYQzwHWU7lN9r1Y9QDSSCFZLTorpnwXM6OXizD0OBsdTn96CVM6LsxVJ5zdFt3iAH
 tUfP/ulwKT8U87uUdu5VhzrgPy2rfVRb+gGGnkiCBNEPquJtaWxAFM9uUQ62yaLGuI0BGNtFbVT
 krxDuhpLjfu2kCGY2busaMT6AR93wsRzD+d1lgvfdMK4rBIRKPLB11oZwFuJEDAcfty/MlKxpyI
 h2DHyfqZ4XKqi2Ll14L3n8OMGmhwsHA1KcK/qGuPO5lM0s/3geWJ2UMxX0txiLS3nEtIl7kW8yJ
 IKXtfaBPSxqT0X5vcYC5lJyTtmj0HkTl/6Ev/g0mz962eagW7JZJG/TBtfS+QPNpporF2zTRIeG
 TmvHsHipore4gWZPoC7pZwndxRFHIlNXk2zreojIatBqKv+/LlB4bAyIlu86gkZXyQYoDJ8HrXq
 mW3prOrSIuvrPvKV0Wy2FIYhY6og==
X-Received: by 2002:a05:6870:5251:b0:40e:fb61:26e8 with SMTP id
 586e51a60fabf-416e43a95bcmr7184444fac.36.1773091755687; 
 Mon, 09 Mar 2026 14:29:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 00/13] clk: mediatek: unify mux clocks
Date: Mon, 09 Mar 2026 16:27:35 -0500
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Q0U7EIBBFf6Xh2VFK27XbGON/mH2AdtglLVCBk
 jab/rssa0yMPvh4J5lz5s6VeHQKPemKK3EYlVfWpMAeCtJfuDkjqCFlwig70Ioy6KcRdBhhMUp
 uoJcVZu7QBA+lkFXDkQtJKUn7s0Op1sx+P92zw48lKcJ9SDR6z7OiK16+DFWm69CW7THJbD96i
 DVQQGwb2Q4Dk3R4E3yblHD42Fv9epP9hTp8H+tQ24g5im3m3sMa+ARy4meILMEFaypRH2X5LNh
 vuOA+LVutVegK69RZmSeDayC3Whflg3Vb/mAsc69/PCuWyVoxWTc01aoH+sNKTvu+fwI+YBRwn
 AEAAA==
X-Change-ID: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OyQT3bqXajkOWuLrJhW2ov5Ah2fNAS14EppW1LJSCrE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprztNkSP1LfpLDQfYOeCAqKVhJJGOcZQHzvfIe
 UQT5+miBTyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87TRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+XIH/389SbSwho6Tcu3mQA08hBbIjgRnUE3QdbA/4Z+
 ZZTsHuB6djUG1xF8Tn9dNOhIGkXs6GIvjz0I13Qw67s/Rn4F/5HaQeRd2gErKk+NGu+IGoJiJJ1
 h7Hb0NZ8glSzczFT0C2U2XWKYb4d4wBtegSY6ereiU1CLT/r3Zp2e2FBFDX342gyX3W2efDj7wG
 o2RfZ7IAcLnE0FaNdZy1GIqqKxVe4dp9rmECaWTIEwl0XlPQ0GTpqHla/hYyJz+8PKXmzIAPSob
 jvqGTZ6xwd3DTGOkdvAUHbSJ8Fjs4CBFwNkZaNsKMRLTyuTGPfdxkmIBye9vH72MRa1NJ8Wgnvr
 +sSo=
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

The MediaTek clock driver currently have two ways to indicate the parent
tree that contains the parent clock. This adds to code complexity and
makes it more difficult to know the "right thing" to do in new drivers.

The plan here is to convert all mux clocks to use the more robust option
of using struct mtk_parent to specify parent clocks. Then we can remove
dead and duplicate code and macros.

The conversion to the static const struct mtk_parent arrays was done
by script to minimize the chance of error (and save time).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Rebased on updated dependencies.
- Link to v1: https://lore.kernel.org/r/20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com

---
David Lechner (13):
      clk: mediatek: mt7622: convert to struct mtk_parent
      clk: mediatek: mt7981: convert to struct mtk_parent
      clk: mediatek: mt7987: convert to struct mtk_parent
      clk: mediatek: mt7988: convert to struct mtk_parent
      clk: mediatek: mt8183: convert to struct mtk_parent
      clk: mediatek: mt8188: convert to struct mtk_parent
      clk: mediatek: mt8195: convert to struct mtk_parent
      clk: mediatek: mt8365: convert to struct mtk_parent
      clk: mediatek: mt8512: convert to struct mtk_parent
      clk: mediatek: mt8516: convert to struct mtk_parent
      clk: mediatek: mt8518: convert to struct mtk_parent
      clk: mediatek: remove CLK_PARENT_MIXED flag
      clk: mediatek: refactor duplicate *_mux_get_rate()

 drivers/clk/mediatek/clk-mt7622.c |   88 +-
 drivers/clk/mediatek/clk-mt7623.c |  147 ++-
 drivers/clk/mediatek/clk-mt7629.c |   71 +-
 drivers/clk/mediatek/clk-mt7981.c |  231 ++--
 drivers/clk/mediatek/clk-mt7986.c |   10 +-
 drivers/clk/mediatek/clk-mt7987.c |   75 +-
 drivers/clk/mediatek/clk-mt7988.c |   79 +-
 drivers/clk/mediatek/clk-mt8183.c |  584 +++++------
 drivers/clk/mediatek/clk-mt8188.c | 1522 +++++++++++++--------------
 drivers/clk/mediatek/clk-mt8189.c |   12 +-
 drivers/clk/mediatek/clk-mt8195.c | 1349 ++++++++++++------------
 drivers/clk/mediatek/clk-mt8365.c |  450 ++++----
 drivers/clk/mediatek/clk-mt8512.c |  620 +++++------
 drivers/clk/mediatek/clk-mt8516.c |  704 ++++++-------
 drivers/clk/mediatek/clk-mt8518.c | 2088 ++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mtk.c    |  104 +-
 drivers/clk/mediatek/clk-mtk.h    |   62 +-
 17 files changed, 4106 insertions(+), 4090 deletions(-)
---
base-commit: 36add050eea439f0b2a15e4ea0d3a8e21216f159
change-id: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
prerequisite-message-id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2-0-b253b49f17b2@baylibre.com>
prerequisite-patch-id: 15ac11765ddddcf378e0e227a9fb5876636aa8e6
prerequisite-patch-id: 90b4781a99ea5eb40eb6c943dee86dd8a9fabe06
prerequisite-patch-id: 150153a03fa40f8f9d790526512f7341a7d95eba
prerequisite-patch-id: bdc28e831956d0a487c62e11d1442a51b9548c25
prerequisite-patch-id: 08b3b97b5870fa4c5eb435f5b19762481a94c058
prerequisite-patch-id: 291f87bf8033440b0c79a03055cec7e1317216e2
prerequisite-patch-id: d3ff487de22ca508a65613bebf8cbe0e61005a31
prerequisite-patch-id: f0e2edcbe17f6bea4bd4e6ceea49cbf73b7568d7
prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547

Best regards,
--  
David Lechner <dlechner@baylibre.com>

