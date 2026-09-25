Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519C3C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0DDA40AF1;
	Fri, 25 Sep 2026 13:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FtyQlnxet_Gg; Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 93D6540B2B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343640;
	b=PvI162xPUwuMUwIZe+PUNPiEvzIgOoSGyXW+vvPn5ILLz+xM2edBBYon+KM3viE6g4Fl
	 saiByJaaFwY/tLlaP5WkPoqIs/KjaNuQR23LKEHTDiuwIJZeJDuUFphRR7mlP0n8x4S4b
	 7fPHxzjZkDg0fp9jrl6xBMbwkl30AUbllPrxEWK+YawtBaWTsOJNPAdixHjlbuC68Rssj
	 +0SY6T3zLgD9ynHmNM64LSe9WWuKth9x2LLdZcox4IKliWgRT6wsAp65K1U452Ch/9f00
	 QAAydeAc64fATcvqGn9f6CZ8SqHhL7kPDtlezgHNF5JFlsGw3zy+PRXBINoX4o40fMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VdzSc0TTcV24/9ZgHt4sgrvuX1VaKaHrXWmEwYjP0Gw=;
	b=f1+ptcf0gD8kkEH23IX8neMxM0E9EWfiLj/cbYnvNCWrScyjsceOhiAe07k0PBuK4xI6
	 4M/p/dCS17iCU064Ei2XdCQ6jVfefglKwTZ3OkbspprPntdUftBv0X1d/yF7x/09yBztL
	 tHxqM1bCaZYo1uEIB3aNEdVLjay8dxnQwnlU4ebrESG//np5dS74KygknYxMRNmG41hZX
	 /2n0twTGGSw6K7RhF6HK3q3ROuf4ftLQr7krChdr+RsSMuD2mt+wOFOQX+t4JnKpsF5a8
	 3mZf41ih/UJvONiTAKDt+YyTzSD6ecmpys4w2ct0/e7d4gt1n3T2vjhoiHn0R9Z4BaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343640;
	bh=VdzSc0TTcV24/9ZgHt4sgrvuX1VaKaHrXWmEwYjP0Gw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M8e5O7azGAV5gvMhx/Rn4Cvco35EaN0U0gJtQ6Jty4Helv7n9E6cUTNU0IYre9KvH
	 bGtZiHngyz1Id7Azjv7SVd47rQtrykp+TPluf2Gxn2FBW900r+qBaBr+sSpQN57X3n
	 dM5nhUaxYPbFyxdxt9MZt5OAvNst74g87vnhgycarzHOD2nqB7PuLovgLYMDbE8BwB
	 X+45OH5TxSi+9Ncg8aRxBQfsomPQDRHKo3wWMWQKF1rxtA0/DSjBFc47fSEnj09Gcc
	 UUIaNOsY9THgAAIKXLzsfLjggpuWRFiyGhSbh1nakLAnpw/IoRWFgxfkxFWphU9wrB
	 JV6VTg6K7zufw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93D6540B2B;
	Fri, 25 Sep 2026 13:40:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB457355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D21DD40185
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFIjqQuUdGV4 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BDD6940042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343633;
 b=owXRA39B7b5WMvYBWg54GJ61VWYqtBZZBxn3tRGodKEskST+DfFx9UYd+1ksHXAbTjzM
 bM5NcyV2mNd3NPbb/XoFqhP/kVaAaB6VKDGrmPtnaAUwQBEpVi1GDGE3alN+dHQzxfSGI
 ss96RyeP3UUEdDfcb3CLBwdlcAttC2lO9wSpVmxEwfa9RLN7/ZOtUB2AVk6zcixeWIgL+
 bjnqLFIGZYsf1BYWq6v45Q7K9+jdG98VJiC40YtWfCdEsqf4G5PpDMQmsNDf4/IXmigjD
 TkbPq83HuRH3LXnE1Zp7tlpuyfjz/8LBX2mXIGT+6F9oUsKnEBaSPh4UFbT1KkfsNTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343633;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=VdzSc0TTcV24/9ZgHt4sgrvuX1VaKaHrXWmEwYjP0Gw=;
 b=ZjODuycJK1GtfeqmjBqLItrOS5gjoyFLCkG94dS7tGOvayAoGzpadtnUDdLLSD3606IS
 STGhGqviMmd9ot3E3EkY2JbGigFPMQkOhGpfhYibqslFIQX/bg7++UEuJ2fF0fAgQ0z8b
 GtqWiAbSINP2rITun3Ni0dMCpld4ONaJP2G0NhcN+7OXURE7KCu6ZKTLlCdUOkUKm6Q2i
 QFo24O7GPbX/mihw+5zB981F1I0uU3+dpL+XE4JxFno4Nn4yoeplTlth2Nn+/O6/X2wxA
 SRzj06DfEiwdo62/O+awjTu7LRCmyB+bsO0dJlV3OSSxQjl7gK9OYXyDYH/ml+T4SQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="K5Ty/5Ld"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=K5Ty/5Ld
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDD6940042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:40:30 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso6555445e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343628; x=1790948428;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VdzSc0TTcV24/9ZgHt4sgrvuX1VaKaHrXWmEwYjP0Gw=;
 b=K5Ty/5LdGnCPAjvtYS9SEptLvj96SIOr0qECy5LJVC6t5obQJuX24n4h1TnPBkSBn9
 I6r3TyE+1ZoFKw88J922jAmdBaCOINfDumd7Sq+L81QqeTwxZanNm2XU4p+HHzA8llyW
 dm3j509KRUBiawiLTIuAJwRjMumabeyLrr7ecgtDGc5A/FZhERKLhNIDZ114Suz6uqMf
 mWf9j82NJUpt1Dy7ewnJ9511wfB6SS9lPEUfgPV8bk2bMf0XYPytJPNWltgBFDmG012B
 EsqcEz1ZhvhJzWP+dZXHg8zj1p4bxdOe1CDyt+/6mcdivHamGn9h/+ktEyG8FrOvkRH/
 2FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343628; x=1790948428;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VdzSc0TTcV24/9ZgHt4sgrvuX1VaKaHrXWmEwYjP0Gw=;
 b=CUmMZfbtHUXsGP/bpgyIqPcrZXbfpFbH087vBxAKh+AgyUmSz4ZXrHrFt7t+iRWfrj
 J7tE6jgIZZCu/gBHVOs7RA2l3vMEZQTf7evQxL8XnFcH1kcwLGCNM7yrJT2xkhIVG8pN
 pSscndiNY4S+NrUMJ8nAFhw4YPeME449wniPNsP68zL3b0EeObqjf/5ZUKwTajZ+a6yt
 4itKkX9KP0pGfq4FlH2K8Uk6JPbNlayw5Lt4p7JVAQuLuyrektYk32FNYlIp++d3j3v+
 N8v+9TP52Y5upXZ6d5y034kfWLCy+neKM519iPxosHMLQlN6418vsdd3jRKBrSMQrqez
 cOJw==
X-Gm-Message-State: AFuF++kEuyNX+Lew0EvMwNhgtiCa7QERX2tmfnh2k7FsAez5B9yMfTsR
 g4gDUkB57BJ2XRoZl+aeDqVKCluToFCShvj/GPMiufZ32C7ipEb3jO4AkLMG6cZrSxU=
X-Gm-Gg: AYBFou2CCqp/CVmk+I1LUoIML35NC7ISZPRVrJnGnjNi9nvY1W/g5pG7Ew5PIK4xvJG
 xv/WNLeWO3NUL5tb/67eBELn+ybMj5yqfhezRnb4pfFvV5NRZCcqxKz7o5raLcZM2zXphSaUJPW
 a2B5Vj7qx6Ml7qxIdaruo5HIGOf7fCY/LJscsjrA9e8ilQd4MPuaKJm7LCnvchJRxhgeaDb8gPZ
 r3eobZ7eUa2+bq5rVIIQWS8g/uL8A3ZFn2CRPGaCxC1f2ngh44nVrtzz9m0JLObIm+xrcEn+6kH
 VFM4xsHcmmxHbz7e3XTLchu2lvvxT7Jiyn8hqJTnrpOg/iv3psLGIrdCVcIIzxUsJS/xBd+T9r+
 cgu0M5w3Zb9L1NQhAaMTiijCP+2pdNmrPc7sUiS8C0eQzIxject6tITmtaf1zwowBFG7nhVwXJi
 R1fyc36VTdhroWN5A16b2ntvDt12Lkdf+O65WDMLysXp6MYfgmyrymtecj2/O2Z+ckQV+v4ydv1
 UInjqDBTPl9aUIfq5zJKQ0mM2Hws3SON4grm+IwhaFE86mHuXmDMK5/OVcZSpog5QgtjCu8WMu/
 FRTwL9IVqU8LhOCGQMyaJLwuoantebYVepOicFYxrd1TbnB8ps6Ei24=
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49fe66d1663mr101492195e9.12.1790343628165; 
 Fri, 25 Sep 2026 06:40:28 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm6599776f8f.5.2026.09.25.06.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:40:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v6 00/12] mediatek: add HDMI pipeline support for MT8188
 based boards
Date: Fri, 25 Sep 2026 15:41:58 +0200
Message-Id: <20260925-add-genio-510-and-genio-700-hdmi-v6-0-29e626b213e9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Qy07DMBAF0F+pvMbIHr+74j8QCz/GjRFNUFIsq
 ir/jlNArVAksryj0bmjuZAJx4IT2e8uZMRapjL0LeiHHYmd7w9IS2qZAAPNDOPUp0QP2JeBKs6
 o73+TYYx26Vho9BqiDhY4i6Qx7yPm8nmteH75ztNHeMV4WtxloyvTaRjP1xsqX/Z+6sD+X1c5b
 fOoZEhGZafZU/DntxJGfIzDkSyNFW6mBb3BhGZqiyHwkLlJecUUN9NteUsVzRSWO+mV4MGtmfL
 ehA2mbKaJIsjMtPVKr5jq3pQbTNXMlFxKCNkZwD/mPM9fPewQ2jUCAAA=
X-Change-ID: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

This series adds HDMI support for MT8188 based boards, such as the Genio
510 and Genio 700 EVKs, in order to display a boot logo over HDMI. It
builds on top of the HDMI PHY driver [1], the DDC (I2C) driver [2], the
clock series [3] and a clock fix [4] already sent earlier.

The drivers here were inspired by the corresponding kernel drivers, but
were largely modified, mainly because U-Boot has no DRM framework and
the goal is only to display a framebuffer. The HDMI driver locates each
pipeline component through the device-tree aliases the SoC dtsi already
provides and programs them directly. The framebuffer is allocated by
the video uclass.

The video pipeline looks like this:

             framebuffer (in DRAM)
                       |
          +------------+------------+
          v                         v
      mdp_rdma4                 mdp_rdma5      two DMA read engines,
     (left half)               (right half)   each fetching one frame half
          |                         |
       padding4                  padding5      (bypass)
          |                         |
          +------------+------------+
                       v
                  vpp merge (merge3)           recombine the two halves
                       |
                       v
                 ethdr mixer (ethdr0)
                       |
                       v
                  hdr back-end                  (bypass)
                       |
                       v
                  vpp merge (merge5)
                       |
                       v
                     dpi1                       timing generator -> HDMI TX
                       |
                       v
      ddc/i2c ---> hdmi tx controller
    (read EDID)        |
                       v
                   hdmi phy
                       |
                       v
              hdmi connector ---> sink

  mutex1  : hardware SOF synchronization across the pipeline
  vdosys1 : routing muxes (SEL_IN/SOUT) and the sizes of the
            clock-domain-crossing wrappers between the blocks above
  larb2/3 : SMI local arbiters gating the RDMAs' access to DRAM

The series adds the HDMI TX controller (UCLASS_VIDEO), a set of shared
display-component helpers and the individual pipeline components (ethdr,
merge, mutex, padding, rdma, dpi1), a minimal SMI local arbiter driver,
and the config that enables the pipeline.

Tested on a Genio 700 EVK: the U-Boot logo shows up on an HDMI display.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com/
[2]: https://patchwork.ozlabs.org/project/uboot/cover/20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com/
[3]: https://patchwork.ozlabs.org/project/uboot/patch/20260715-mt8188-add-clk-add-display-related-clocks-v2-1-0aaf7accaeb0@baylibre.com/
[4]: https://patchwork.ozlabs.org/project/uboot/patch/20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v6:
- dts: dropped the framebuffer reserved-memory patch; the framebuffer is
  now allocated by the video uclass, sized for the largest mode
- kernel-doc for the exported API and structures
- <linux/bitops.h> where BIT()/GENMASK() are used; MediaTek spelling
- SMI larb: refcount enable/disable
- component helpers: larb lookup moved here from rdma
- ethdr: program MIX_L_SRC_OFFSET(2); enable the mixer last
- merge: read-modify-write of CFG_37
- mutex: Linux names for the SOF and module indices
- rdma: retitled "add mdp rdma component"; datasheet names for the
  downstream-only fields
- dpi: fix inverted HSYNC/VSYNC polarity; clear YUV422_EN/CSC_ENABLE
- hdmi driver: DM_FLAG_PRE_RELOC; set priv->format; yuv420 bypass only
  clears HDMI_YUV420_MODE; document the HDR back-end routing, the VDOSYS1
  power dependency and the 4:3 VICs
- Link to v5: https://patch.msgid.link/20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com

Changes in v5:
Across the whole series
- Dropped the dead colorspace/colorimetry handling: only RGB444 8bpc is ever produced, so set_csp_depth/csp, the YUV
cases of the AVI InfoFrame, the YUV420 downsample path and the DPI CSC are gone. That removed the only user of the
include/linux/hdmi.h added in v2, so that patch is dropped too.
- Programmed the resolution- and DRAM-latency-dependent registers the mainline kernel writes and this series skipped;
their reset values only work at the timing they happened to be tested at. Retested on a Genio 700 EVK.
- of_match tables consistently use "{ }".
- Include hygiene: <linux/bitops.h>, <errno.h> and <fdtdec.h> where needed, unused <video.h>/<asm/io.h> dropped, #endif
guards named, redundant "struct udevice;" forward declarations removed.

Per patch
- memory: new preparatory patch sorting drivers/memory/Makefile, so the larb entry lands in an ordered list.
- SMI larb: moved to drivers/memory/mtk-smi-larb.c with its own CONFIG_MTK_SMI_LARB and UCLASS_MEMORY
- component helpers: added mtk_disp_comp_update(), the read-modify-write counterpart of mtk_disp_comp_write().
- ethdr: put the HDR video back-end in bypass like Linux' mtk_ethdr_config() does; "vdo_be" mapped by reg-name.
- merge: mtk_disp_merge_config() reshaped to the kernel's (l_w, r_w, h) and CFG_1/25/27 written unconditionally;
documented that the single-input no-fifo mode is unreachable from this pipeline, hence untested.
- padding: clear all four registers in bypass mode, not only the picture size
- rdma:
  - program MDP_RDMA_GMCIF_CON and clear MDP_RDMA_COMP_CON and FLD_OUTPUT_ARGB
  - reject a stride too wide for FLD_MF_BKGD_WB;
  -print the framebuffer base with "%#lx" (it is a ulong);
  - resolve the larb in UCLASS_MEMORY.
- rdma: kept the datasheet name BGRA8888 over the kernel's RDMA_INPUT_FORMAT_RGBA8888 (same byte order, i.e.
DRM_FORMAT_XRGB8888) and TRANSFORM_0 bit 15 over MDP_RDMA_CON's FLD_OUTPUT_10B (that bit is in neither kernel driver, it
came with the downstream U-Boot code). Both documented in comments.
- dpi: the CSC/matrix path went with the colorspace handling, and MATRIX_SEL_RGB_TO_BT709 with it; mtk_dpi_hw_disable()
is now used, in the HDMI probe unwind; mtk_dpi_mask() replaced by mtk_disp_comp_update(); local types renamed
mtk_dpintf_* -> mtk_dpi_* (this node is mediatek,mt8195-dpi, not the dp-intf variant) and the config parameters const.
- get_unaligned_le24(): moved between the le16 and le32 helpers to keep the file ordered, and split into
__get_unaligned_le24()/get_unaligned_le24() as Linux has it.
- hdmi driver: above 340 MHz, tell the sink to scramble and use the 1/40 bit clock ratio through its SCDC TMDS_Config
(offset 0x20 at I2C 0x54).
- hdmi driver: sink type taken from the EDID (hdmi_monitor) instead of always assuming HDMI, and no InfoFrames sent to a
DVI sink.
- hdmi driver: zero the EDID extension block when reading it fails, so the parser cannot pick a timing out of
uninitialised stack
- hdmi driver: propagate the generic_phy_configure()/_power_on() failures instead of logging and carrying on.
- hdmi driver: clear the GCP AVMUTE, in case an earlier boot stage left the sink muted.
- hdmi driver: the VIC is now looked up in a table keyed on the timing's exact rounded refresh rate; an unknown timing
reports VIC 0 and no aspect ratio rather than a wrong one, and the AVI colorimetry is "No Data" as CTA-861 wants for
RGB. Also set A0 in the AVI InfoFrame, the active format R3..R0 is only valid with it.
- hdmi driver: mtk_hdmi_mode_valid() also rejects interlaced timings, odd widths and pixel clocks outside 25-594 MHz.
The pipeline reads the frame as two halves and feeds the DPI two pixels per clock, and the PHY will not lock outside
that range; rejecting them here lets the EDID parser fall back to the next detailed timing instead of failing.
- hdmi driver: no data islands towards a DVI sink either, the GCP and null packets are gated on hdmi_monitor like the
InfoFrames.
- hdmi driver: dropped the infoframe buffer size checks, which cannot fail, and collapsed the three-way HPD state into
a bool.
- hdmi driver: program the vdosys1 clock-domain-crossing wrapper sizes and the mixer input padding. The alpha half of
the kernel's mtk_mmsys_mixer_in_config() is left alone: the mixer layer runs with MIXER_ALPHA_AEN clear.
- hdmi driver: zero the framebuffer before the RDMAs start and enable the DPI last, so a stale reserved region is never
scanned out; video_post_probe() only clears the framebuffer after probe returns.
- hdmi driver: dev_remap_addr() and a void __iomem * for the register window; extension_flag instead of a raw 0x7e
offset; the 150 us settle delay moved back where the kernel has it, so it does not fire on the disable path; "display is
not connected" demoted to debug; the cached struct display_timing dropped, timing and buffer parameters const, "inline"
dropped from the two static helpers, includes sorted.
- hdmi driver: retitled "video: mediatek: add hdmi driver".
- mtk_hdmi_regs_v2.h is a verbatim copy of the kernel header except VID_DOWNSAMPLE_CONFIG, at 0x8f0 per the MT8390/MT8188 datasheet and not the
0x8d0 Linux uses (a patch was sent to fix this on kernel side)
- dts: the reserved-memory and the hdmi "memory-region" phandle are a single patch now; SPDX (GPL-2.0 OR MIT) ->
(GPL-2.0-only OR MIT), node renamed framebuffer@72000000, 32 MiB size documented.
- configs: drop CONFIG_CMD_I2C, the DDC transfers go through DM_I2C inside the driver; the commit message notes that
CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so CONFIG_VIDEO=y already brings it in.
- Link to v4: https://patch.msgid.link/20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com

Changes in v4:
- refresh config fragment with savedefconfig: remove CONFIG_VIDEO_LOGO,
  correctly place CONFIG_WATCHDOG_AUTOSTART
  that is enabled by default
- reword commit message on patch 13: remove useless mentions to larb/vdosys1 aliases that were removed in v3
- Link to v3: https://patch.msgid.link/20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com

Changes in v3:
Across the whole series
- Re-based every register definition on the mainline Linux kernel definitions (upstream names, values and
BIT()/GENMASK()/FIELD_PREP()) instead of the downstream U-Boot ones.
- SPDX fixes: GPL-2.0 / GPL-2.0+ -> GPL-2.0-only on all new driver files, Makefile and Kconfig; relicensed
include/linux/hdmi.h to MIT (it's a partial port of Linux' MIT-licensed header) and added the full MIT permission text.
- Bind on the generic mediatek,mt8195-* fallback compatible (shared IP) rather than the SoC-specific mediatek,mt8188-*:
dpi, ethdr, merge, rdma.
- Makefile/Kconfig header cleanup: copyright set to BayLibre and the obj- list sorted alphabetically.

Per patch
- display pipeline component helpers: reworded the commit message (probe and enable sequence).
- ethdr: use the kernel's parameterized MIX_L_SRC_CON(n)/MIX_L_SRC_SIZE(n) macros, drop the unused *_CK_EN defines, add
BACKGROUND_RELAY to the datapath write; keep the downstream-only L2 select bits behind a comment.
- merge: rename registers to the kernel's DISP_REG_MERGE_* / MERGE_EN; keep the downstream-only CFG_30 behind a comment.
- mutex: make the register offsets index-based (DISP_MUTEX_*(id)) and rename the helper to mtk_disp_mutex_config_hdmi()
so a future DSI user can reuse it.
- padding: rename registers to the kernel's PADDING_CONTROL_REG / PADDING_ENABLE / PADDING_PIC_SIZE_REG.
- rdma: use the kernel's FLD_* fields with FIELD_PREP(); take the stride from the framebuffer line_length instead of
recomputing it; error out if the framebuffer base is above 4 GB (the source-base register is 32-bit), add larb configuration.
- dpi: import mtk_dpi_regs.h verbatim from the mainline kernel and adjust the driver to the upstream names (DPI_RET,
DPI_INPUT_2P_EN, DPI_OUTPUT_1T1P_EN); keep the one downstream-only matrix value (MATRIX_SEL_RGB_TO_BT709) locally.
- include/linux/hdmi.h: MIT relicense (see above).
- hdmi driver: move the register defines into a new mtk_hdmi_regs_v2.h imported verbatim from the mainline kernel;
correct VID_DOWNSAMPLE_CONFIG to 0x8f0 per the MT8390 datasheet (mainline has a wrong 0x8d0 — a separate kernel fix was
sent); remove the dead deep-color code path (the driver only ever drives 8 bpc); drop the unused length argument of the
infoframe helpers; check the RDMA config return value; resolve the vdosys1 syscon via ofnode_by_compatible() instead of
a U-Boot-invented alias.
- dts (reserved-memory): drop the unused splashscreen carveout, keep only the framebuffer region; retitle the patch to
"add framebuffer reserved-memory".
- dts (hdmi override): drop the U-Boot-invented vdosys1 alias (resolved by compatible now) and larb2/larb3 aliases
now resolved using iommus and DT directly inside rdma component.
- configs: use CONFIG_VIDEO_LOGO (show the U-Boot logo) instead of CONFIG_SPLASH_SCREEN, since upstream lacks the
plumbing to make the splash actually work — this also keeps CONFIG_EXPO enabled and drops the now-unneeded CMD_BMP /
BMP_24BPP.
- Link to v2: https://patch.msgid.link/20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com

Changes in v2:
- Add a common `get_unaligned_le24()` helper for reading 24-bit little-endian values, ported from kernel
- Add a common `linux/hdmi.h` header with HDMI colorspace and colorimetry enums, based on the corresponding Linux header.
- Refactor the HDMI driver to use the new common HDMI definitions and unaligned access helper.
- Rename the mixer component to ETHDR and configure the ETHDR before the remaining display pipeline components.
- Add the SMI LARB components and configure the VDOSYS1 routing directly from the HDMI driver.
- Switch display component lookup from phandles to DT aliases and add proper error unwinding for component clocks, HDMI PHY power, and clock resources.
- Refactor HDMI register access and InfoFrame handling.
- Improve HDMI mode handling, YUV420 downsampling, TMDS scrambling, deep-color handling, and InfoFrame generation.
- Move framebuffer/splash reserved-memory definitions to the Genio common U-Boot DTSI and add the corresponding HDMI override node for MT8390/Genio EVKs.
- Drop the dedicated MT8188 VDOSYS1 pipeline component and its corresponding DTS node, to avoid having 2 nodes with same reg address.
- Remove the unnecessary `dm_scan_fdt_dev` bind hook from the HDMI driver.
- Link to v1: https://patch.msgid.link/20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>

---
Julien Stephan (12):
      memory: sort the Makefile alphabetically
      memory: mediatek: add SMI larb driver
      video: mediatek: add display pipeline component helpers
      video: mediatek: add ethdr component
      video: mediatek: add merge component
      video: mediatek: add mutex component
      video: mediatek: add padding component
      video: mediatek: add mdp rdma component
      video: mediatek: add dpi1 component
      asm-generic: unaligned: add get_unaligned_le24()
      video: mediatek: add hdmi driver
      configs: mediatek: mt8188: enable hdmi pipeline

 configs/mt8188.config                     |    4 +
 drivers/memory/Kconfig                    |   10 +
 drivers/memory/Makefile                   |    3 +-
 drivers/memory/mtk-smi-larb.c             |   89 +++
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/mediatek/Kconfig            |   22 +
 drivers/video/mediatek/Makefile           |   15 +
 drivers/video/mediatek/mtk_disp_comp.c    |  123 ++++
 drivers/video/mediatek/mtk_disp_comp.h    |   95 +++
 drivers/video/mediatek/mtk_disp_merge.c   |  154 +++++
 drivers/video/mediatek/mtk_disp_merge.h   |   44 ++
 drivers/video/mediatek/mtk_disp_mutex.c   |   79 +++
 drivers/video/mediatek/mtk_disp_mutex.h   |   21 +
 drivers/video/mediatek/mtk_disp_padding.c |   49 ++
 drivers/video/mediatek/mtk_disp_padding.h |   20 +
 drivers/video/mediatek/mtk_dpi.c          |  372 +++++++++++
 drivers/video/mediatek/mtk_dpi.h          |   34 +
 drivers/video/mediatek/mtk_dpi_regs.h     |  247 +++++++
 drivers/video/mediatek/mtk_ethdr.c        |  106 +++
 drivers/video/mediatek/mtk_ethdr.h        |   37 ++
 drivers/video/mediatek/mtk_hdmi.c         | 1027 +++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_hdmi_regs_v2.h |  263 ++++++++
 drivers/video/mediatek/mtk_mdp_rdma.c     |  185 ++++++
 drivers/video/mediatek/mtk_mdp_rdma.h     |   34 +
 include/asm-generic/unaligned.h           |   10 +
 include/mtk_smi.h                         |   37 ++
 27 files changed, 3081 insertions(+), 1 deletion(-)
---
base-commit: 677a768c91b2baaefdf09633d1fdb5c9f758674f
change-id: 20260701-add-genio-510-and-genio-700-hdmi-ca62c6b8210c

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

