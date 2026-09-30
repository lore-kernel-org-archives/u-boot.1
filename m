Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372BCCA5FBA
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 556C780981;
	Wed, 30 Sep 2026 12:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFz4bw4FuCq0; Wed, 30 Sep 2026 12:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 124A5806FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772736;
	b=c8ksGo1ldnXmlDdKZaxtjJT3XktopA4bsBVyRmaFDby8+MAYIXblWHd7qBO4pjbebBTj
	 h9V92lYHyeXPZIc6EzXufufx0Xg7s56cfTUasjbpCnKpIlHx35paqL/tumqwWdZ0m4zTh
	 kUBWb9hRwtEtSFmSuuxryhNnnE/Rr/JF0wQa7fkWpCjIpQqjK364wNMG6mDVXx7FsJf3w
	 vmS1GX3cLou5WYnvAGFvvWp+D/QaYoz1Y/HByraDxTnEE3WRtj2zCbFRC5NFf4atBUOtm
	 +l3JXVOksjRgMaS9NNQ2vjGyQwG5QLxyg14Jahtwib3WDfrrsnEi5eLjxSwWsGFiFng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BKCoUTNSVhs5LcuDpIPcoR+Rd389P0aWF4Hzr8z7dJ8=;
	b=PdXHBC/aeIzeBx346bGWVq/my/YvshwwK1o8q/131Voyz5axGL72TRxj2Yyy6ZCWjI8P
	 LOF3q1FnDKOZjyFRpIBt1FlUIpp6HicbK/FCk/Gi1mV1kfQPJf/uHRGP1TgJPmWpeCONA
	 w8wrMOnzYW8NjsKhYi1n4A4BhXc/kMqbNwR4f/wjzjIYWyeA8UeNrgHlqeujEdh8Vy0/n
	 1OtmoFx+3/FLg/X4GAgJS2TPsH2pgH04lsJeLX4zJ6YEFE2uqUwiUo6TsH/bb8SW4ECnW
	 kKXO4rK+IlTeyDiVxdFt+/4Wo5NvXLdvbHH+x/Ir7/u/y+YhIkuVcZhIGL7hOMv+L5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772736;
	bh=BKCoUTNSVhs5LcuDpIPcoR+Rd389P0aWF4Hzr8z7dJ8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eHT+4PnD09021u3/rHiQWnNcQiZNwSDJl4CYyJ5NY02NrQTk2EGFylJahMvUSmI7v
	 MU+2kWST9sXiczPIjNk+oZOqrfB0IFaFxepNAZTAcmgEP26bRpIujeBl7NwqZGEa4p
	 fNANt+nSsIvG4pbjrNRul8M0wLsJshZQN5aHb/Y4LBkkEGcjIRprD+Fitou7F5fDjy
	 JpmEsFejWCkqHG5dkkAXFm18OGNbPhXSyGerZ+bKFIvpHeQjNKKms5GbrD7BnJX3Z9
	 Qj8/QdLuUOekdLxM/rjSqZkyNVv7ZTF9T7g8tRmL7VmdsAM6YIkxljULX5puZwPLKW
	 dX3mcEhww4KiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 124A5806FC;
	Wed, 30 Sep 2026 12:52:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 869BD24E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7788C608A8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXh9KdH_CTTx for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 897826086D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790772731;
 b=ZR7uU+hGlXEyqy8Yp2iHHJoS3FqV3GBasM5idUnZ2OJ7SO9SwA6xRxrI+fbC8Y4KdTg6
 2+Vp27AJVecd4Lf6DKnoRXtf+ZATMxezrZBVtv6FWJ9l0jHYf67vO0JoMyPeIrVbkQqa5
 bMjx1NV7XE3tnCv2JqMjRte/wq5PB5chkM31bC9ZUj+v5xZBAGK+kpShlMZFUpO+2KGhI
 ivYh1KcpxHZDcUuXgRzEvTJ2xdFRe2phE76LoYGI2AHjgHekFQfiEg1xF0GRcxTDE5kdt
 2nHyZu1Tjwu6XzbhGGTJXUqhqpYQO153NjDs0GzosWPivqPDDhCmchlfFGpvNApG5Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=BKCoUTNSVhs5LcuDpIPcoR+Rd389P0aWF4Hzr8z7dJ8=;
 b=OgC8fGnGXI/6jUC6snZ3fqIWKDn6sjoCsMp/ryT7Nz/56+GuOHD+jjUusRuUZPMcG474
 duZ2kTjCST9C1Bo7AufJ4+/zFevdRFI9V5LSE6Wo3G3oohSzYjD6dhHhJ3hjygJT1oGLU
 Lp9GRhugYbH0IMhdLzfBfvENwmJcJrHTwNpYumBeqWIHLCiKeGQ3CXBoxIEx0itCCW2p5
 qAY++5BHoRAcaai7FGKmjbc+lZM6xazjDazbOrpLOycX9xpUu+c+W4PEW4ByddkmV9VYk
 ytNjCZaPBTllKZ/9hgyWwkemhkeC+AMOjuHmn5LeA+r/40/DhV4LzieuSmPcSKKXmIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ocitdEpI; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ocitdEpI
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 897826086D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:09 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b017a3be3so554385f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790772727; x=1791377527;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BKCoUTNSVhs5LcuDpIPcoR+Rd389P0aWF4Hzr8z7dJ8=;
 b=ocitdEpI2W0smOTdlaix2Rzohm/iBIXWT74KEP0Tq+Ia/Rdej/GD14R30fMqLx4JOW
 urcS1dKPeTC4Z1FhMyog+nr6ECJwbX4kYbtUMGrqXTQ07m3UC1bgnGBcmIEvwtSi9tqr
 ryMoXuj92WVDhN78XDs4zQHuobaBUiwmimhrexAxLp6wFBhLbd+InO587qyvLDXy+A+W
 JD/x2eEjYKII7gCwJ7MxMKwNlkkyLqThNdT4oqqWVG2g3Tzj3u6xWZ44paBqXy+QO1wV
 XSKXPFVSqOXQRLqK+oxoKXLSJAOtUKDFs+KXVK7+G66O88LVxJukN57Dv0Yq1gI4iF4q
 DzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772727; x=1791377527;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BKCoUTNSVhs5LcuDpIPcoR+Rd389P0aWF4Hzr8z7dJ8=;
 b=FhTOcebmLjAhDD7Aw1rCstxEdDHTOaLRnx8DDuoD1+KApntOQFlwTS3tblBgyXvaTU
 uBodOYny0q8bjffAno5StqdIcEyxXzYdhE+qrn6inpew6FOtcC9imkSQk029hM50fG05
 ynTYxsdToqESu21x4NOeHHUvEkoxFkIqqKdPOurXluQ8LDDT+YIUJ/TUfgg9GRMn4vWP
 PYz6gu3LjiOsm08WLKmIMKYKJeVKaDypKx1wqWO8Wf9JO9noGAxnaBk5WsYY7LIrC42b
 nWMzqKlol5Elui2nLCyCe/d9gTdxJelv+heQQixqYUV7nrpmBvoTaQHJAyYdYIGUqZJo
 MRLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy9y68+FJB5R3d5xLXUXOu3/MWJyzkGu4LVV8tzF3GybzWx175hbor3ytTYycllf24URCPyyw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mULWVn0ZGb47vVDHIeEzxDGjX/WGT8RrqMAUZliXpz/vumR97e
 eEUW8+JtCfAjeqDXKYM9bTLyZFTyJSaP1K+xi2EiPpKOqcNZF3QF+tbFuFd3Vge3F7A=
X-Gm-Gg: AYBFou0uj9HV6EKEeawkAgnAA0DH0yeJWo3QljHycXoxjNatmInr8nwVVLq0Z5a6slO
 QNoQu0Z7Q4RDgkH8upQLhhIRz1w0wyU5Of/EF9QB4AE674UQsTdfzdvrC69cwhDL3wpk62udRTA
 rpHSavhr9zHT8+EKfmq17g0iyOxOtBmCQyyBoCS8rdgs67N+nd8CWXx8lasJnTO3wRHYjMK8JVd
 4ONB+bhFeLFW9bFbUoQnPrJg37CSW07AF9DphPDGPk74yvGpXif81SEbodQ8u//QSpyyeu1L38c
 tPE7pEKvpw0htKV1JUOgN6eE8F6Lpwxm6N3wraE7jqakOCO+18Vnv+6vEfbBe2erOjr/UN7RO2W
 3UPKAK9bPaQZi0cFuPCADAa8YzjN2nhz0dClh1uFqNscSuW75g7iSPZ5ABGxd5TeYwVAgw9ojkP
 ZGJM6yyIqs3YChD1zQu6SMGLkCsxOHWld1baPHr5eU7E0ho9BTjYmEiZzDGyDOxCXm89mT7InoS
 voiU43qouC+9T1ShGWSb6JbOCbynisETGuvq8MAiEssvRG6Ecu6BNx4vnAx/nqcY3TZjSim7i+N
 P2Dwz3+Lpmd2lQ==
X-Received: by 2002:a05:600c:3152:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a01b12603amr22596925e9.31.1790772727194; 
 Wed, 30 Sep 2026 05:52:07 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm9928905e9.0.2026.09.30.05.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:52:05 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/4] Add Genio 510 and 700 BootROM download agents
Date: Wed, 30 Sep 2026 14:51:32 +0200
Message-Id: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QwW7DIAyA4VeJOI8JTEQgp73HtIMhZmVqmg5It
 KrKu4+kPUyr1KMl6/MvX1mmFCmzvrmyREvMcTrVQb00zB/w9Ek8DnVmIEALKwX3HusK8fmcSyI
 c+ViMsoIPyAME00qNDtCwCpwThfiz4+8ftznP7ot82cT7RqLvuV4ttzXmMBP30zjG0jc4gBNBU
 AAE1A5JGquptYqs6VRLqkMVJLmNGiln3HP75h6rHmPz+cgD5uKmqfBF89o9KIdGYkcDvDm8HKN
 L9FoL2JZ8iLlM6bK/Z5F74R1vn31ikVV2nQ6WlECvzKO8wB8N1FMNqmYC6FZ3Bj3Yf9q6rr/sE
 QloyAEAAA==
X-Change-ID: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Genio 510 and 700 need a way to provision blank eMMC and recover boards
with unusable boot firmware. Add RAM-based fastboot download agents that
can be loaded through the MediaTek BootROM download protocol without
relying on the installed bootloader.

Fastboot in U-Boot proper is preferred when the complete download agent
fits the platform's BootROM payload limit. It provides U-Boot's shell and
boot facilities as well as flashing. The SPL variant offers a smaller
executable payload when including BL31 and U-Boot proper would exceed
that limit. Both require an external DDR loader and run fastboot from
DRAM after DDR initialization.

The two paths start USB fastboot at different stages:

   Fastboot in SPL                   Fastboot in U-Boot proper
   ---------------                  -------------------------
   BootROM USB download             BootROM USB download
   (host -> SRAM)                   (host -> SRAM)
     |                                |
     v                                v
   DDR loader                       DDR loader
     | Initialize DRAM                | Initialize DRAM
     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
     v                                v
   SPL                              SPL
     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
     v                                v
   eMMC provisioning                BL31
                                      |
                                      v
                                    U-Boot proper
                                      | USB fastboot <-> host
                                      v
                                    eMMC provisioning

This series is based on upstream/next. Generic SPL fastboot V6, applied
to u-boot-dfu-next [1], remains a prerequisite.

[1] https://lore.kernel.org/all/179015047421.246261.8241758059641679018.b4-ty@kernel.org/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v3:
- Rebase onto current upstream/next.
- Separate the boot-device conditional cleanup from DA enablement.
- Use normal VBUS detection without changing the MTU3 driver.
- Apply the SPL agent's eMMC preparation to the U-Boot DA, including
  reset-pin enablement.
- Reduce the U-Boot DA heap from 144 MiB to 16 MiB for sparse flashing.
- Document that enabling the eMMC reset pin is permanent.
- Use wildcard MAINTAINERS entries and clarify signing and heap-size
  rationale.
- Link to v2: https://patch.msgid.link/20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com

Changes in v2:
- Rebase onto upstream/next, which now includes Genio SPL support.
- Align shared DA filenames with the mt8370 Genio naming.
- Use fixed USB peripheral mode instead of the private force-vbus DT
  property, with corresponding MTU3 driver support.
- Limit RAM boot to the U-Boot DA and use phase-specific MMC settings.
- Separate shared and per-agent configuration, and make DA and normal
  storage-image configurations mutually exclusive.
- Build the SPL DA entry only in SPL and simplify FIT key handling.
- Keep the SPL allocation limit large enough for sparse image writes.
- Select the eMMC user area when resuming boot with SPL fastboot continue.
- Explain the preferred U-Boot DA and the SPL alternative for tighter
  BootROM payload limits; clarify DT requirements and continue behavior.
- Link to v1: https://patch.msgid.link/20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Vitor Sato Eschholz <vsatoes@baylibre.com>
Cc: "Pablo Sun (孫毓翔)" <pablo.sun@mediatek.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>

---
Carlo Caione (3):
      arm: mediatek: simplify SPL boot-device selection
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  64 ++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |   6 +
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       |  16 +++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   |  62 ++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |   2 +-
 arch/arm/mach-mediatek/Kconfig                     |  59 +++++++++
 arch/arm/mach-mediatek/Makefile                    |   5 +
 arch/arm/mach-mediatek/download_agent.c            |  83 +++++++++++++
 arch/arm/mach-mediatek/spl.c                       |  22 ++--
 board/mediatek/MAINTAINERS                         |  12 +-
 common/spl/Kconfig                                 |   2 +-
 configs/mt8370-genio-da-spl-fastboot.config        |  21 ++++
 configs/mt8370-genio-da-uboot-fastboot.config      |  29 +++++
 configs/mt8370-genio-da.config                     |  12 ++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |   2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |   2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |   2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |   2 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 135 +++++++++++++++++++++
 20 files changed, 525 insertions(+), 19 deletions(-)
---
base-commit: ad2b0f0ef2a2a6bae1896e493e98734e37a3f1eb
change-id: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
prerequisite-message-id: 20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com
prerequisite-patch-id: ebe0842a87ef1a27c9882d7c45823b37ef84e5a8
prerequisite-patch-id: 7df6bdcd4e7a655d86db0447593b2bf36050b049
prerequisite-patch-id: e98c322def69bb8ecec30dd41c05aa62040b1008
prerequisite-patch-id: 553ddc59d4de9ff9f1949875939979cbeab2eaac
prerequisite-patch-id: 8d8c1917bfcee87fecf6077a117c8a11cc402cdd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

