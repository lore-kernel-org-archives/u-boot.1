Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92865CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51E2B80E75;
	Mon, 28 Sep 2026 15:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CyFaGcS5tvTd; Mon, 28 Sep 2026 15:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E618780E25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608001;
	b=WiXfjC6UkgL1OaZBqJ7bvckuOafycauM/KOPRY1Xu88dQNCXz4bZWYFJ0s1Cr7qkkhUt
	 PnnoPGQDYwkLw9EoqoyTYKWKLWpzW+/OnJXE0KlKeYoXH3SxHO/o4SAN64ySn+/KBoHl7
	 Wwptvqxgmi0vZ1WP3kEu6mjmc+SPN/H3vakdx+/Bnl0qeKClIF791KNs4QCE2Dgj5Tx9i
	 VQH7qrZWJ3o5J0dXyjXGu7TIth8Tua/BKv9jZz/aJy7ZpbJDOzvvvGCQ0eVrW3CWX1nWJ
	 Zk6hFD3GfjTDATsGNx/h9u7RnX6UJtd62ggHgQ3CdHlAskaCCX9bORUaZ25Zz2DoIow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z4IPe5K54vKTjxQ16GAzMWeTq6uSpNXUR6uCYdUJ8z8=;
	b=Qepsl5RU9CRAGSGLOaKblw7RwWS92it2YwifVN7NvwZj9i0S3PuTrgpfnQNXc1MMrHFA
	 0FcypldVn2+958NjLCCCDvq/LB+dMrJVyOfZFpLmH3vgwJf0+xqisf/TKMQdhYSX4C5tq
	 4A14KQdo3GghamOhOvNFdJnMai2mF1x9ub0h2FIIEBm09WEu8cAOL6mXN3RVzVE9Djb5P
	 MkbhY/+GHfNk19icoPpDyouNPZCgb2tBCUgoFB9tfIHt88ZdIaHK9BqfQj8/YWeaJdsfV
	 X8waZq+WmD/yksDczDDgqXYE5bxX0JU28ZgTJa837oPDKApBHdRjx5MK8Am7ncftnPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608001;
	bh=z4IPe5K54vKTjxQ16GAzMWeTq6uSpNXUR6uCYdUJ8z8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uifBUQD06AYYX9yavX/Jr3qd61EyDMsAWMiPYxlJUx70ylUOnBJOS6c+ckVrW9ppR
	 woFSDy3ZSgh5KGffwmndCOCAJxoOmfhmx84Y71cjF9wMhHutamJCIZ+UMnArAMBWOb
	 P+7YG+lnZhY9NxF6ZyWXc/X34ZJOLqJN2k1bkz7+hFAN9+GLpCt8B8ETBnR+yvZ1EC
	 jfhUSoXVaPUKMnkzO95deVFm+pU/8f/KyA42uP/qSvyMJy2RVtlygxyrR1VdH5aKO/
	 qmk+Ki1ycc17fnLKjYuFx9Iw+rjmw7Fry0lQGtA6tzLhw0U/uEihvU5cSQESRyA/J1
	 /w/LazgP/d2Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E618780E25;
	Mon, 28 Sep 2026 15:06:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C9F24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78CBA40675
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WH6-FM2ROQa3 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 859AA405E8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790607998;
 b=lyMUf6skWTYRDxnywAlmwWSI2D9C5QIAJB+PMtAlIRiydfupG+A2GJnzcrTj5ebtuJcF
 rtctZzk+KOw5B52C/E60SYMAUINaWyX9CTh1EDhu4sWHFIm4B6TTIrcHcLri7O3xJ7ZH0
 l8IR23ybK9ALMg91Y3km6CP1al3RfQ89HcKpeURSazmkzGBcnRfLHMoXMsGmj2FC1HZLh
 M/py/86gKFhDlAv5apW4dpLCsxxjS4m94wJSN9QS1annztlPa2moRCFeOoWCPvntPMwTh
 D6rgT0Cu/YRxfeBzEind2lzv1IlXpeTQP6gkrdDjqY3qbd0ftEQbfxBrVwCj9BDgL3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607998;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=z4IPe5K54vKTjxQ16GAzMWeTq6uSpNXUR6uCYdUJ8z8=;
 b=l7y+1cWRFFXxcmZWWTceXnUHB37vqDQGAaPjXH2R8hQIPH0eEBntN201zg2FB7qGmuC3
 th7A0dEFq8Iq3wuWPtmXJCAO43/96wUXD1SHOY5ncVWbzHu5yCHumngQue7syB9ZqJBhs
 IaAPfTFNWifpHUqm2pCtJ8Ypenv+ABB2u62/H6rEqk/dDFE36WkqvUC7eCCkQDr7+FX0k
 T4vLbOSEd2bJ3UOEkvppArB0Ll8chW8z+bS2Y4YxbQiGW2VB2PTDNRoWQW2Ttom/JcfO3
 NSSaUQVvDL40lNkdTVsTMEXD5tlg7djxdae/+SJDdWKbKjC0/h+qfNUQEQHZflo5oZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="j2K+X/Vg"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=j2K+X/Vg
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 859AA405E8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:06:36 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso746305e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790607995; x=1791212795;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z4IPe5K54vKTjxQ16GAzMWeTq6uSpNXUR6uCYdUJ8z8=;
 b=j2K+X/VgH+ORaA7Iso3dhPv1QjBWvppxm0IGvR0bcOSjr+QUefE2B6qclC4WJigVdD
 gWBaHnE3DCi7DPLgeT4ekEpv3tdEr4QmtoYpzHBCSqnHTv6nAj+U/wYJ7YKiVdHOedO3
 2aQzY3cUXN+wxQOgGskGhSrWK1irGOrWyq7aEPiRrDbBgBbWcAyepreXxAfZTdIWqqAG
 USE0J9QIcLX2OayE1BHm7lTeMRjlwa8SpEcN+Y/RgjeTXB4ZsRqCYg590gmu/w3ygXia
 XUJMTzV8pjyeD2/IXVv0ZxOKH2MqskKEVWY55oZlc34hwlrPH1YNH8bPPnerppOdFvJx
 2CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607995; x=1791212795;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z4IPe5K54vKTjxQ16GAzMWeTq6uSpNXUR6uCYdUJ8z8=;
 b=1Bb6mXDPgLrl1tSyXWBIer6YTMimKfEPC0BVekSWgHbRQFU/n91fOLQSN7VSxvQKih
 ftPLkQKPJCDhygteQMEmhJFTiFnozvocp8ghX4qXFPISnRlNqlhzWc4+mrrGbD25g35C
 hbkBe0XdKaICLjKXPOI103dRuftRwfdZB28vte38GnOdkiRBpylMn3jUpxKu5MhliKfg
 yzASWBHLbgEf/6YR8uH9YX5XVk310TWOUap/otDq/ekAYErTae8SSX0Fk+Erj3k3zppI
 tHgS77U+V0NM1Yt9O1vehU+icLuh4GuljgozGiBLYGEctSOdjk7GDwdUtN4jn4Gg2k7n
 WlrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcuklBspL3qa3XZzBT5bXUaPyYHNjR+ISGWpKRipcM5B6zwtHB38P1UgL6GzL7l8J0CotOyWk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nKFl/nm4L/+U0nQPkngRlHYhJDZOtKXHdlzYnQvN1MEM6VMIjG
 hXLeI5sqGAl65H+XdveJ/bAYj9mE5ALoRw4OEjuas3GVcLv0I2iRxGAaG6y24xByx4I=
X-Gm-Gg: AYBFou16Z8xTgttIrxNmCy8JZ1wmrcduKnZnViDqXzJAd6NSsPKSe03w/WWgqSxJMov
 SoeJWXDUv+ay50wIy/EZKMFWSryhmCFiQD62E+ToaSLaTs0p7gVNBFmqBWMi3/z1izIB46JEGyM
 tWaUZJ2nMUEk57gSw2YHkD6qbXo9fdOu0GW8xQbysGMqoR/08Oh7tccRz6O9TXCXx+vw9hqlNmx
 DDz6TbZGfDfz4KnTeNaovAqu7lfA7NnA+8YvA138ar0Di5XP8zeovZ4fSUUQML/muAh7etf7Tdt
 9t5kcnIWRxD/ziLJE/2Q1cWnfXHLqq+YYJ9YKx+ONJVM7OituUSh0iVrF9FFcL+CftjovaQ2fev
 iZWPxjl8lOY9EeKu0PxdoD656V5omDi1ik0oecV6BwGa/+bgjnDEnkQi+dZAijSAUgMqdBrn8mv
 oTFZg1dnRRJ1Q2l0gNG+u/gvT2K5MBIouQpn28jp5fzmUdYuge4nZIly7REZPT0xz8Ig3LYRTgA
 7rvrOZrSrnjrUdG9vWnPvxR0xq35vU00Z292p0YhsjBvwR7VHF7bSDGiXnuUx+cIfK/+RCouQ/X
 9RSmUKa+RLst+IhXWTWHCPRpsagMO6f/08e9NUi8b3y7bD0ILC7mcm0=
X-Received: by 2002:a05:600c:4e53:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49fe66c8288mr238662295e9.4.1790607994683; 
 Mon, 28 Sep 2026 08:06:34 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm235270105e9.7.2026.09.28.08.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:06:33 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 00/13] mediatek: add DSI panel support for MT8365 and
 MT8366 boards
Date: Mon, 28 Sep 2026 17:08:37 +0200
Message-Id: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42S22rcMBRFf2Xwc0/Rxbp4KKX/UYLR5WhGmfElk
 u00hPx7ZTuhaaHgJ7FBLC3tc16rjClirs6n1yrhEnMc+hLol1Plrqa/IERfcsUIk6ShGrpJcyn
 2Q4LxHnyOkOdxHNIEdSAoXfCKcFYVxpgwxF8b/+fDnvNsH9FNK/T9RsKnuTw87dcqazKCG7ouT
 ueTVMooqV1DLbPGYPCBNJJzT4O3wjVBCS1VHVZUhzmbzfh8+vZJ+AYX7OMAXBKwKfaXeYRFAAF
 Oa0EN5TI08oc1L/doE34tT3//H06Bu9+gQx/NhLcS0PTzmGGhBVd754JG3+jgDuGY+Khz7bGb7
 3EjF+zgbuBTXDCtaAoiWEs4ERjqg6byM3ocngvJD52J/e5qS6leUasbccyV/uU6Xl+2Yrs4xm0
 B/sgS0FwRhV6wmpkjbE22RWpXWFtg7XMqy9BmfGqveB8xtZ1xaXhvWVrBudLaE3PIXNNmVzY93
 iFPJq2Tu3miSLiG6En52cJKx8R6K53UjDhxdHwreF8uQQmY/iMpQuDquwiLLMqsQcmkZZRj8w/
 54e3tNzfGrLWEAwAA
X-Change-ID: 20260918-mt8365-mt8366-add-dsi-support-4f0e6cfd7032
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

This series adds DSI support for MediaTek MT8365 and MT8366 based
boards, such as the Genio 350 and the Genio 360 EVKs, in order to
display a boot logo on a DSI panel. It builds on top of the following
series, all sent earlier:

 - the Genio 360 EVK bring-up [1],
 - the MediaTek clock cleanups [2] and the MT8365 multimedia clock
   driver [3],
 - the MT8365 power domain support [4],
 - the MIPI DSI PHY driver [5],
 - the mipi_dsi write_seq helper macros [6] and the startek
   kd070fhfid015 panel driver [7],
 - the display component helpers introduced by the MT8188 HDMI
   series [8].

As in the HDMI series, the drivers here were inspired by the
corresponding kernel drivers but were largely trimmed down: U-Boot has
no DRM framework and the goal is only to scan out a framebuffer. The DSI
driver locates the pipeline components through the device-tree aliases
the SoC dtsi already provides, the mutex, which has no alias on the
MT8365, through its driver, and the mmsys through the DSI digital clock,
and programs them directly.

The video pipeline looks like this:

         video uclass framebuffer (in DRAM)
                        |
                        v
                      ovl0                overlay, the DMA master
                        |                 reading the framebuffer
                        v
                      rdma0               pass-through, no DRAM access
                        |
         +--------------+--------------+
         |                             |
         v                             |
      color0                           |   MT8365 only: the colour
         |                             |   pipeline, every block
         v                             |   programmed as pass-through
      ccorr0                           |
         |                             |
         v                             |
       aal0                            |
         |                             |
         v                             |
      gamma0                           |
         |                             |
         v                             |
     dither0                           |
         |                             |
         +--------------+--------------+
                        v
                      dsi0              DSI host, and video mode timing
                        |               generator once the panel is up
                        v
                   mipi d-phy
                        |
                        v
               dsi panel ---> backlight

  mutex0 : hardware SOF synchronization across the pipeline
  mmsys  : routing muxes (MOUT/SEL_IN/SOUT) between the blocks above
  larb0  : SMI local arbiter gating the overlay's access to DRAM

The MT8366 drives the panel straight out of rdma0, without the colour
pipeline, which the per-compatible driver data selects.

The series adds the smi_common support and the larb port control to the
SMI driver, the pipeline components (overlay, rdma and the colour
blocks), the mmsys routing and the mutex glue, the DSI host itself
(UCLASS_VIDEO), and the configs enabling the pipeline on the Genio 350
and Genio 360 EVKs.

[1]: https://lore.kernel.org/u-boot/20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com/
[3]: https://lore.kernel.org/u-boot/20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com/
[4]: https://lore.kernel.org/u-boot/20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com/
[5]: https://lore.kernel.org/u-boot/20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com/
[6]: https://lore.kernel.org/u-boot/20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com/
[7]: https://lore.kernel.org/u-boot/20260819-add-panel-startek-kd070fhfid015-v2-1-0bdb6c6820c5@baylibre.com/
[8]: https://lore.kernel.org/u-boot/20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (13):
      memory: mediatek: mtk-smi: support smi_common and the larb ports
      video: mediatek: add ovl component
      video: mediatek: add disp rdma component
      video: mediatek: add color component
      video: mediatek: add ccorr component
      video: mediatek: add aal component
      video: mediatek: add gamma component
      video: mediatek: add dither component
      video: mediatek: add ddp component
      video: mediatek: mtk_disp_mutex: add the DSI pipeline
      video: mediatek: add dsi driver
      configs: mediatek: mt8365_evk: enable dsi pipeline
      configs: mediatek: mt8366_genio_360_evk: enable dsi pipeline

 configs/mt8365_evk_defconfig             |    8 +
 configs/mt8366_genio_360_evk_defconfig   |    7 +
 drivers/memory/Kconfig                   |    1 +
 drivers/memory/mtk-smi.c                 |  223 +++++-
 drivers/video/mediatek/Kconfig           |   32 +
 drivers/video/mediatek/Makefile          |   19 +-
 drivers/video/mediatek/mtk_ddp.c         |  130 ++++
 drivers/video/mediatek/mtk_ddp.h         |   22 +
 drivers/video/mediatek/mtk_disp_aal.c    |   54 ++
 drivers/video/mediatek/mtk_disp_aal.h    |   31 +
 drivers/video/mediatek/mtk_disp_ccorr.c  |   55 ++
 drivers/video/mediatek/mtk_disp_ccorr.h  |   31 +
 drivers/video/mediatek/mtk_disp_color.c  |   50 ++
 drivers/video/mediatek/mtk_disp_color.h  |   31 +
 drivers/video/mediatek/mtk_disp_comp.c   |    4 +-
 drivers/video/mediatek/mtk_disp_comp.h   |   13 +-
 drivers/video/mediatek/mtk_disp_dither.c |   89 +++
 drivers/video/mediatek/mtk_disp_dither.h |   32 +
 drivers/video/mediatek/mtk_disp_gamma.c  |   51 ++
 drivers/video/mediatek/mtk_disp_gamma.h  |   31 +
 drivers/video/mediatek/mtk_disp_mutex.c  |  120 ++-
 drivers/video/mediatek/mtk_disp_mutex.h  |    9 +
 drivers/video/mediatek/mtk_disp_ovl.c    |  253 +++++++
 drivers/video/mediatek/mtk_disp_ovl.h    |   45 ++
 drivers/video/mediatek/mtk_disp_rdma.c   |  154 ++++
 drivers/video/mediatek/mtk_disp_rdma.h   |   30 +
 drivers/video/mediatek/mtk_dsi.c         | 1220 ++++++++++++++++++++++++++++++
 include/mtk_smi.h                        |   19 +-
 28 files changed, 2735 insertions(+), 29 deletions(-)
---
base-commit: 677a768c91b2baaefdf09633d1fdb5c9f758674f
change-id: 20260918-mt8365-mt8366-add-dsi-support-4f0e6cfd7032
prerequisite-message-id: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
prerequisite-patch-id: 71076a51cdbb0a378913db95aa9ec892aa114510
prerequisite-patch-id: f3c5dac3ef2faa4c107f3972c343798f2890edbd
prerequisite-patch-id: 10d8a4c6afb5d2038385b46eedf6fbff2ff522ce
prerequisite-patch-id: a35f239e99aa1e874cd33547e40a6189f629f2db
prerequisite-message-id: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
prerequisite-patch-id: f7d20fd912a63ecd5f74bf715b9440dc51943b20
prerequisite-patch-id: b5807d4ac0a15d0f945c09b4635f7c56b3b7930d
prerequisite-patch-id: 949d2176be96c2c32517c3a76422c5f30bb647a0
prerequisite-patch-id: 1dfdabc642d685aec02e163eaaaf316f013f27cb
prerequisite-patch-id: 01db7b89d970b31f8b7f300182c177ef182e258e
prerequisite-patch-id: e23bb502e727a57c7a2da50c358c43031a0362e5
prerequisite-patch-id: f603047a5fe691eb4768638b1dd2c860fcc1093b
prerequisite-patch-id: cc0884d959385c6eda0b1584b9e76d66be401905
prerequisite-patch-id: cb3934029d3adf3d1c67fa93284229476b589e65
prerequisite-patch-id: 4851327632c9d0e57fa8220b619f2f8da63ab014
prerequisite-patch-id: 818bc3d5cf951c4dd6740a681503c29ca89169c2
prerequisite-message-id: <20260925-mt8365-add-mulimedia-clock-driver-v1-1-5fbb0305ef46@baylibre.com>
prerequisite-patch-id: 1a9b3e76a306f0f2a31a4af34439f1203bb6f66c
prerequisite-message-id: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
prerequisite-patch-id: b507a239269358ce28fd861bfbe83a7e2d37fa4b
prerequisite-patch-id: 3ddafe994065cb677b83cfbc641dd493406c5ebb
prerequisite-patch-id: 6c10fafe32155e48413c3488b0e6ee490c6749ae
prerequisite-message-id: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
prerequisite-patch-id: 35dc9ab519c2e14dbbe2b154bce4e6507e479aa9
prerequisite-patch-id: fc28319e86784585d682ceabba2b6e02e490f8fe
prerequisite-patch-id: 231ff3bc35bd0836302ca9084e7221f29673729e
prerequisite-message-id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
prerequisite-patch-id: cf35ac4802976971af68bd0ce1dc0ab872fdb661
prerequisite-patch-id: 9f6aca2bfde84a5d84329b77b3b9af8898b18e4a
prerequisite-patch-id: e7bb7ee54b88b6d6e00f74fe84b1c81d00957051
prerequisite-patch-id: d4a530120b1a93d68e4b17c6e1fcf2878e784454
prerequisite-patch-id: 18b1bbeab6808decceaf5117b3e999baf4495e1d
prerequisite-patch-id: d50e7e28a399c303226ff08c78e60749930a7243
prerequisite-message-id: <20260819-add-panel-startek-kd070fhfid015-v2-1-0bdb6c6820c5@baylibre.com>
prerequisite-patch-id: 51445ab9f18ba145a34b2b610d26110a22fcb5b7
prerequisite-message-id: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
prerequisite-patch-id: 35fb945433e1734704a4cb25ea288d7b5caffb08
prerequisite-patch-id: 348b3295a242695dd16c2527ce8667f57d0fff0b
prerequisite-patch-id: a223f40f31425ce8e432fd0e3260ee88613abcba
prerequisite-patch-id: 38180d82dd86189cfbc33b5cbd324875a687376f
prerequisite-patch-id: 0e2d6678db7887b43b6ffdaa9d4ed24fbc719036
prerequisite-patch-id: 5eb0e3c8d9b298f8ec4435c53743e700be18f5d1
prerequisite-patch-id: da04e31cc822013abf83eb11e99c96bde6c80789
prerequisite-patch-id: ec4a63c80dbeccf5856717bc5e9f8f68ce24aaec
prerequisite-patch-id: dd32ef13b415d318e99dfb82804c2023b215e461
prerequisite-patch-id: 97961b61667804b5e8b4d27554d0eea19f1a7011
prerequisite-patch-id: 5bab7633cfd540d9ac842a8e27549fb9d1b8582e
prerequisite-patch-id: b0a14d18708d59e8cbddbb2c1c29798cae70500e

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

