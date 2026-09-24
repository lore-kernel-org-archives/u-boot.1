Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65087C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0333E811D7;
	Thu, 24 Sep 2026 19:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ogwp7ZWVo-7K; Thu, 24 Sep 2026 19:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 00D54811D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279027;
	b=JmoY1cEHKuVY4P1Jwj/GG9Ww0p8ezg7oV/CH1mYf6mgWGNMlzcBR1ztFC4MVGSXV5NCR
	 6sXNwAuXFTTs/fVouDOpaEmdb0UKFwx2k5Hx8Bx8P+iwbricMcz6zcJdHTAo2dJKNUSw0
	 yY7jkeERAQn5BtvTaGkZEAB8Ke2y51qS2aaXCWd/7mHH4oPSj1ap6Sb4IOcnQyD4BHBgy
	 eKieWjm49+BMsitRoOnJ21HCFJZGIAMDOdrju6POyXe1jGY2hXM3vlFmjyywP1AGThMtd
	 Ni92Y0U8cVhvt7svxQrjTCw316+SkLHQ0bIbStSWtuQFFeFuFRXXElDWQOJ5dTMWldg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lFnWXB7NzNj5Ku1khOmNVOWz7d2NBvj9VMqh4W9tV/o=;
	b=XUp5PZ1x8Sp4z2K49VfyVVP+joUjaDbcTAG2B3B98yG6ciQ1YDXvd7QWvAr/Qo6SbC+5
	 VSahCvjXG9+4EtK1GNbtNF1AYTzeRqaMq2dHW5Owq1c3P9KvV+lOt7dBkhE0Aa8zDvVd0
	 Dh2Smfirb9gz8pNDzoHKiE67wsJgFxF7ZE9RLaOz5s/8TrqSVynr+L6cqFmzuYy52Jxrf
	 HvILOTGDdNuXjNsvujTNkkMhFOxqvtqKlQH32aEDymiyZm9qYzzOOl+atPv6NF9rAHdWd
	 M1pPbSwZzLHPwg21YuI4pWnVMQTlDZzo6wptmbvXWXfTEf2Rqg/ETHKiyW1EPzl/0ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279027;
	bh=lFnWXB7NzNj5Ku1khOmNVOWz7d2NBvj9VMqh4W9tV/o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vsrbr04iVSHQII1OL1znmwfMw/bGIxSTNre8G08ojmw3l/EKoHTZ2gRWzbjQ33piW
	 PiJfryxjOZewsG810A8Jbe8wxLg8LnsMopBslpNqta3WM07LwPC5hqF0Nvg3UC7PqN
	 EBuxVEnL6THLbEsovukzoR0ogee4lFwUt7dqrJMm3tJhz92xU3kzBq44VYnwkq8ONZ
	 iSzItZMdwdMibiDmposDHnYp+5pgKZ0y3sH08DQnL/l1u273iM6mZCI+rglpxevjxQ
	 VtMzkTP8toHBKHF77zWHuB//8Ap85JIgkjRFmLBaN/R/NlZ1LN2PH8v64NCR+qvh3c
	 66twvOc7pjZTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00D54811D3;
	Thu, 24 Sep 2026 19:43:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C755355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E2A860BAF
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3n1b3aEOepkJ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DFAC860670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279024;
 b=BMuxnwEuhhe4TR88YdpY39zF3SCZoH5MPEv1O02GVgDTwInI6AsicsiJcITsUHlzhN8X
 lGB8Cb25lzG36td/BIGDPvBJidrc0Bydfj1ESf63tWe3IcoHDBCbWti1HF/14ztjrLa8t
 P3Zt/JSI1tDMQ/Oi3Iv5AQ5ujBPmQjEGFIHvO/rERO08Qe4NapBR+tTqpeFHS6+8iPBOj
 hIYPPU+F6rcdJ7BG3ScR9LNYv6F9BrKHhGzJ2Lc17l+KWIpg+vw2/X3XHSpcvP7jodoTC
 iG5ydodNuTUDuz8hy1q2FplqpoVH3GnUN8SNlB5aWkI+WgjqQcOy+HI78SFRlPZTEyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=lFnWXB7NzNj5Ku1khOmNVOWz7d2NBvj9VMqh4W9tV/o=;
 b=jBuh0RX4bkcmDeprXJtAWmBk2t8LddkV/od3HkroFmUrxB5PPCxl4OX+tk3HF5eImekl
 pAJ4RaBNL956Tk0+pt382hCrSI6EYuz69AOS6t+R4dKUjl2+n4rPBfPQYW4it3aUdBYLh
 3ROOGFIvVcjKZlHyn6ILDDVKVKdeUqobYMOe63da7jeFZ4WxOTp7sm/8zi4CAqgeQ4JeD
 uuXBJyosz5RxnjkJIKH+i+DR2ExL4mGMTPzO53gi8Kfv+TI430yDGVdYyVgyc5rSGQMz2
 U5Ly00sJkstDC7ZIIVic/jsBBi833RwS/ECICzUUQWv2SK8/C8d/UfXSvyy8QqOVW/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QSTKDDAM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QSTKDDAM
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFAC860670
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:42 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-80199394f52so75094a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279021; x=1790883821;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lFnWXB7NzNj5Ku1khOmNVOWz7d2NBvj9VMqh4W9tV/o=;
 b=QSTKDDAMTVlPuOMEVGd+u9/qpdxmJAutwBxbZZUBn3JXENU5lSMMwphGpbbj4Vj8zo
 HFGf45+u/0hP9Dt6779x78Q5VjCOnXUXXgS1EsdWYlnXSvIvPZl5TBZKvGx9eZeJjx8g
 7v8laHgekvObiOp1j9uYJBFRmE8pq1EkVwe58wpPIjOGGCYrVphKodtyK5M6RwhSPxbq
 KtrBKZ3gKjNuSVwc6kmC2Ftd3iWKVBaPA+N6Y6xl+1rJX0NZezjQGmCQaPwlT32Fz4nN
 DgGYhkjNTqfiz3e1lQ+DR/RZFeYy6EwU4TImnv16At89erC/j1mRVWm+9GlL/gn0h6Gv
 Udhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279021; x=1790883821;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lFnWXB7NzNj5Ku1khOmNVOWz7d2NBvj9VMqh4W9tV/o=;
 b=hCkX4WHvo0jG3LC5bA1TAOrH3JOwzaycJO4EgJVvtGXL0vp8tybgkKt9u1D4wZlORw
 6sc3xHVYHMXdkZTCplhoBfi/qy0kWiCThDCh1e3dZ3iyrSmIjdXmNaeQ5yWgutheZEUj
 I5dsvTvmT+NRbaBPOAf+EqQDBr88g73EkmCttC3NUjlW48P7qmYEZyCDwr5+fjQVzWE3
 EAN2p+IGNeR8O7RCBWwvVirNvRcp1sdyUK7sfmEeQwKjjGY9X46LU7kfcUreraDFJxGC
 Og9m+0UD+GQ5GLM7V51054nWiabEbNme6TCLWbSf7drl9wjTk4k0/b9nkZPAMX6JjUMJ
 Ru0g==
X-Gm-Message-State: AFuF++lmGiiM10eCj14iAiuQgthPwa7YtbFOCTQWpx6dci1dl9gZcFSY
 u8r4q6Ew8ec4+OfEM3suT3B94xhYY63kc5o/FeS+DVaLVn5Zg/z5M3UgZf0eAgkKn20=
X-Gm-Gg: AYBFou2VNAV1oaAmAcWgIjniBy9eGsKWi3/ypAPsNlGN9FH5J3Uq5tjuu1gkbleJDFX
 2wxe8gjb/FBvePBCFZEMrctYSrI5nc3CShkkSBy+hjFhBOQ9XiG/fRh4navNDNymYRYwV1IrYeu
 cbxcxXkjbYQXC78tqtQgSNAs4Np0mOhc5zqof/4Tqx5UOo4ne2tjz85IhZa8ZGV7SiQpX2QHLFs
 PBhHKxLZI94BGskUBoXAkdUKB7Spns3VDNNl44CJiuAOxp/7GfmlSeGtRNgQKV/8BaYIas70+uU
 AEyRi9p3uJqubaYw/8Tnn2lQfB8C2xF9bYFSzn1LW5AQDhN6QJPSoGjcfC0TRZ99aG9Q8qTu7lt
 sh9jQWf7yqUbdki9ZsQCtfFHLZU9jvRNYdn8Dw6CV8OBPSA8ip5SLk+4Tl1hgrKYXgb1UhFVyM2
 S3qaWaajAuowqAyqmMN5/Dn9s7uV0gn4yC7SDTwJb1UcJUAjAOV2vmlXxSXo1p7TvNs1pOxixTk
 9eG
X-Received: by 2002:a05:6830:6d18:b0:7dc:db3c:1d82 with SMTP id
 46e09a7af769-81780694c61mr3557499a34.10.1790279021198; 
 Thu, 24 Sep 2026 12:43:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/15] clk: mediatek: merge single ops into mtk_clk_ops
Date: Thu, 24 Sep 2026 14:41:38 -0500
Message-Id: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQ6DMAxA0asgr7EUAmW6CmJBUwNmCCgGhIS4e
 9OyfIv/LxByTAJlcIGjg4UX6xGFAZi+sR0hf7xBK52qQidophHnbURh202EyyqYvZJImTbOdVa
 AD1dHLZ//aVU/lv09kNl+J7jvLx39fVJ2AAAA
X-Change-ID: 20260924-clk-mtk-single-ops-75410cf38279
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3074; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xX740ixVHRgoEDpee0pmw7oGVcD4XMB68LImtKjSO7w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtXz7Gx5gfMOoLDqHpiGUa3BzRjkA9e7uMtvFJ
 ctUj26nLPSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV8+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcLIH/iiX2P+f3jf3a84lqUm+Nhx8lpckUVaxk1SDACK
 L9bid7apsKFDKDkxpehqc/D7j1czh1exYnBzZCCTsLVxgh5gktEAAMshH2sSYl+M/zIEuoH7xsG
 4kU9dXdiWofSewqLqNj+QcLCKHzTxbjDMgoT5gDeQPBPlhqd4xa9evqoDCQi2sTKNyySjjftC2w
 opEhJ+vEdGWrUjX+3IOEBtOvyv8Uz4XIxVjTkVSw/MG0/Z0aqn0pqLDIH+AXw5FIKcrUwknfzfG
 Ue4EmqPZNfdViPN7v2pvGQvGIqhkUSA8RJTjAfknIQHNp2JChluqncyiK3Qj/mbZvgaUt+thAQk
 bwXs=
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

This is the final chapter in the year-long quest to remove duplication
and increase consistency across the MediaTek clock drivers. Most of the
clock ops now are duplicated code that can be combined into a single
functions. So we do that and then consolidate all of the mt8xxx clock
drivers to use this single set of operations (mt7xxx have some extra
hooks on certain clock trees, so they are not consolidated here).

This depends on [1] to apply cleanly.

And if you happen to be working on a clock driver for a new MediaTek
target, all of this will be available in the mediatek-staging branch
shortly to base your changes on [2].

[1]: https://lore.kernel.org/u-boot/20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com/
[2]: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (15):
      clk: mediatek: add fclks_offs to struct mtk_clk_tree
      clk: mediatek: merge the of_xlate callbacks
      clk: mediatek: merge the enable and disable callbacks
      clk: mediatek: merge the get_rate callbacks
      clk: mediatek: merge the dump callbacks
      clk: mediatek: use a single clk_ops for all drivers
      clk: mediatek: mt8183: merge the apmixedsys driver into mt8183-clk
      clk: mediatek: mt8188: merge the apmixedsys driver into mt8188-clk
      clk: mediatek: mt8189: merge the remaining drivers into mt8189-clk
      clk: mediatek: mt8195: merge the apmixedsys driver into mt8195-clk
      clk: mediatek: mt8365: merge the apmixedsys driver into mt8365-clk
      clk: mediatek: mt8366: merge the apmixedsys driver into mt8366-clk
      clk: mediatek: mt8512: merge the apmixedsys driver into mt8512-clk
      clk: mediatek: mt8516: merge the apmixedsys driver into mt8516-clk
      clk: mediatek: mt8518: merge the apmixedsys driver into mt8518-clk

 arch/arm/mach-mediatek/mt8516/init.c |   6 +-
 drivers/clk/mediatek/clk-mt7622.c    |  10 +-
 drivers/clk/mediatek/clk-mt7623.c    |  10 +-
 drivers/clk/mediatek/clk-mt7629.c    |  10 +-
 drivers/clk/mediatek/clk-mt7981.c    |  10 +-
 drivers/clk/mediatek/clk-mt7986.c    |   8 +-
 drivers/clk/mediatek/clk-mt7987.c    |   8 +-
 drivers/clk/mediatek/clk-mt7988.c    |  12 +-
 drivers/clk/mediatek/clk-mt8183.c    |  18 +-
 drivers/clk/mediatek/clk-mt8188.c    |  18 +-
 drivers/clk/mediatek/clk-mt8189.c    |  40 +---
 drivers/clk/mediatek/clk-mt8195.c    |  18 +-
 drivers/clk/mediatek/clk-mt8365.c    |  18 +-
 drivers/clk/mediatek/clk-mt8366.c    |  18 +-
 drivers/clk/mediatek/clk-mt8512.c    |  18 +-
 drivers/clk/mediatek/clk-mt8516.c    |  18 +-
 drivers/clk/mediatek/clk-mt8518.c    |  18 +-
 drivers/clk/mediatek/clk-mtk.c       | 379 +++++++----------------------------
 drivers/clk/mediatek/clk-mtk.h       |  10 +-
 19 files changed, 144 insertions(+), 503 deletions(-)
---
base-commit: 8189f1c305fa8af99780a84dbffc34d2f0f06743
change-id: 20260924-clk-mtk-single-ops-75410cf38279

Best regards,
--  
David Lechner <dlechner@baylibre.com>

