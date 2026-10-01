Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA6ACA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 10:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27477812DF;
	Thu,  1 Oct 2026 10:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrNtULqNiBp7; Thu,  1 Oct 2026 10:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FE7C8129A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790851117;
	b=OJVf21G58aKWP9MZxpdjvtBIZq/YCgcuy4/NBI4Wd0DmRyEDWSwnu4ieB/YbotjUCnOj
	 aYiEMya/we5Vrj6aL96zvQ2Qle5kRjwhrp1p32VnO+WfkNAuzZ8GnVZj8rBN34qAH7ZZO
	 LBTL+h57kNPVOJyxvx2cqVosaVXD93Gm2yxgaNNU6EavP9cB3QX2K3MctxHjL/izly5OH
	 a71fadzJY7En5W+0KMbTpDBqkFGcoP/Fa12fe3zNj0TQnvhdFrbZHcklLAKSjPo+GCMHu
	 0dxo0/REaER1gCLrpB0q7Ku1pBl7dtwtJKWiOu4wl+76B4qdHTLtPZY8ZXEBh5cLVPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790851117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O0RFfDvUgqALHWjTGHPhnAHkSk2q/lOC3IBd/pNEGGQ=;
	b=pyshtqvkDHqz7ra2gbgrE7rOl9FY7nVMT3y+q1yqbpBmtxB+kgfZ8Rh5XqsgFXts45Di
	 3Eun/Rd5anPc6ZUblDEPSAWd684ULZYg+j3srZ+vxzO2h9DMr+4Fj2Tx0NvcNfKfgcrK2
	 Ix72w85W64QLteHKuEgdM4KqsFQrWtnM8xY4z8UmBj6XbJzFxYIVbY776/21CkZ+jRFXj
	 aZvimbcBKa8pIpWtvBUnW4ozTRTabxXwizPh1EE/SWEp060MYuhzhwSt0rBgkF4kxvRZP
	 J4k2gHg9UAUAKj/7QOcMWK3OLGlzzQUH/pX+brIM6LcmKng1B7gOI762IdxFm4b+gsQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="aI/zUhV/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790851117;
	bh=O0RFfDvUgqALHWjTGHPhnAHkSk2q/lOC3IBd/pNEGGQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rtAHzZN3ib/hP5hlrCLI6OXTy74JVXSSg+N/BEOY3E9ADEK1D0XXkI+0iGhBeKB8h
	 DVJy3HrWH08lwZXRuYMRfMTf28DIVcHURcaBRUmcSVkY8Jm2N6kLNx7RDIXquHYPDu
	 mxjnFbBhNe6igsB8HulJMxfJHFVMONx+FPKYhzuQa19MPawo4lGE+y5SSfRK5atYFU
	 egoYqrtcabKrHwQVF0X9P8jf8+FrL2KwldfYimj8DEBYWcz+7MTxyI2jjDn9gv5OL9
	 1ZIZkKylnEi0U4SPGqIZ6GItYDBPoHMwZPQGP1FjfW+BtEZ4MljyEZw0ltr8hVVG1i
	 uTLxex95PWCpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FE7C8129A;
	Thu,  1 Oct 2026 10:38:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 815A71A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 10:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72E208129A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 10:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9JGBYNHQSvFT for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 10:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0895881295
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790851115;
 b=OFSS4OJQ7SMaAuJV9Vzz1bkkn0X2ebfL6xTKjyrn0pkDdp46ZuOKFZiRBO4Vg5jDy4tO
 LlXqTmmThVaw8wDNd97/Dv/rKyZn7FozqRxeUwhuh5iHnItHX/BnEuAAwHKV30JuHlDka
 xStO5+e6z/BPSu3aWda7qiRtqPvxM7AUCcLwO9qU3Q3pIACQ8jVsGp/otythhQinPfAZc
 b9DQbfXgJRr5vztGjuhz9QxgO2vG5Q66qnr9mJGpnyMSiox1JD1OIy+3B8rngRNbwYtr1
 I6hAwFy3NnJyfsXBR5E+TEyv0r5jCdJ8FNbzIEX6dtZVSDrOy1jGL3ZR5CcYWmM6X0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790851115;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=O0RFfDvUgqALHWjTGHPhnAHkSk2q/lOC3IBd/pNEGGQ=;
 b=DHHtEW98jO5kH5ToUBOCg9gF7e5ok4UavAPzCT9PIzhHFcw5xtGiwWofJqKViM17QZm+
 FD5WP6PVgnLfT1Y7i22g7OyOapU4n6xtXTCGi3nL5APokK/NEP2ySeP91KaJhGi2A2ZPv
 LzlmxKsy8Y92SDZE0+L29Lf69GXW5jIbG3degYkdQTFAmGk+/5uoqYBIB/yM93m/29WOM
 JibeJjZzwzLpY8s3oE8xkmwgmHy4XMfVX4bPaKwbbVELvGfccfzx9sCCW7+Eojuo7xhv9
 mwh2QCVxJ7Bj5g/ZPQFig/gKOVKdfpBURBhfefzHKdXVE1G3XpjSK7yYI+PuhLq7RHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="aI/zUhV/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aI/zUhV/
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0895881295
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 10:38:34 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48882c1f2baso2154308f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790851112; x=1791455912;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O0RFfDvUgqALHWjTGHPhnAHkSk2q/lOC3IBd/pNEGGQ=;
 b=aI/zUhV/7f7BVgvqdqhpfbBp4HE7fhx4SESxINlEM3hd8Oh+43bfG2jYptw2ik1eQO
 c2tltjrUu3uEC4k2aBmfhTs4jYVL2Bf6/jcpYHiCdOfsWUOBPXiURbt6vstgHMm1apIg
 QO7KM7IHevIV2iGoAUuH8Znr3l+aKmtTcF/M//5sXi3ubd+N71VPIfSs2x0YiCyrJgcW
 9k5pn+pnkV0aWQYSmBrBcH/qa7rZFAID+/JAVFtdNkHCgnJImFM6X942xRD9fOKnwudk
 +WASE6pwZZwx+XQ2fr+u8EMBH7cDaNQF9Er2BIgW2cmm2rxFFpP+CgEYUAmClS++kzVK
 BdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790851112; x=1791455912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0RFfDvUgqALHWjTGHPhnAHkSk2q/lOC3IBd/pNEGGQ=;
 b=hY6SgzYsGIs1iDfnZLBK5o3k7Jdet6KvLXfOc356quPsTuc5aX99WbvhH+L/9tKQnA
 HN2snSdNSXJLHXEm1CqLr0ZV/aZjwg1E0lmI2RCoplI4AbYm4GyR4k+fX+PzWrR8Xt3v
 B3zlGR3fESD/uW2QW8bw3GU2mltjXNt7fdH9iMITAtBM4b9WAdAF41c0zJ+l9H++GIf8
 0C48hiWSN0sbWvLb4hhMi0SiMu8yfC7hYq6i3NnVdO8c1OAtKwkBg2vl3bTyfyT5iHiq
 EO72oStPCYcbO6PD9hUWCbRF9aui7JpWIF2A/n8KtxUpxIS88bQQ6UesVNLxmOcEYEBk
 YcmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXuvEc/2A/wOHx/6RFYkV3Ef6tr8DG+ENDh6Nk2gEER6cRCtX8Qx8VH6jIxSKUdICJRzNcAdE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL98TVuVpE9IhCHs3G7B+SavnnyA8t/bo6GrJi2d779ch7kFguI
 Ah0GBYnC2OPHbkcLNp2eCIaxShq+ayXD+p//rpqsH1sRzKum65YkSXsVb5BXAZGtl4U=
X-Gm-Gg: AYBFou0Yqjpum89AQfEISfOehcGXoPQihKOBMkvGxpRM7ExTXQ32cU4Q/WA8FE6/9r9
 Q4NqpgCLkvz8b2LxFxI0mGAptxd0YrQ38GV7TL9YTg/X5208zPruemW2gyplghDJWqzEUWp0f2E
 dukyIksv1xFCXVLZqVrrinx/nZi4kIGpKKS4+1ROJKhzMNAnokNRQbYkMOtIaYaGAAGJRSP6sEH
 Wwj5vw3O2iQ0JQnBWHYu8qFTcHaaPWhLGg/90RH836b3Z1W6GEYIgHI61LXRlgUzQrWtZFMFJOE
 B713xI7SuG2OGcTehCtS4Bzh2pFqU3NXY6X7CHNNZqUaiY5CAJCwUTclujXZm/s+x0QCTA8azUT
 NOH8MzdncRoISVgJt2VZnPDrRcoMYbJ3iOrWl3K0oXhj02Gleih4d/geTOihfzR3AT/5tl4dvw2
 1jB6rlIDcp7LVP8CpcJ50WMWGskl1QkSs1Wv7c7jYWo57k9iuylIYXakiR05WjIHpqmQFK4/TI6
 SSkey4bk+niBs4Xm29yTNgSwXZ7VrUe8+izeemcg1TtB7KvuoE=
X-Received: by 2002:a5d:5889:0:b0:488:8568:bb02 with SMTP id
 ffacd0b85a97d-48b0250efc8mr8289391f8f.23.1790851111963; 
 Thu, 01 Oct 2026 03:38:31 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0db6a3b7sm2593220f8f.41.2026.10.01.03.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:38:29 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Royyan Zahir <royzah@gmail.com>, Vivek Ray <vk092kumar@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next
Date: Thu,  1 Oct 2026 12:20:32 +0200
Message-ID: <20261001103822.11971-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

A small addition for -next:

* Improvements and fixes for some Qualcomm clock drivers, particularly
  for sdcard
* Fix dtbfile env var being truncated
* Work around rpmh issues with bulk writes
* Teach the rpmh regulator driver to enable parents for regulators
* Correctly set the blk_desc removable flag for Qualcomm mmc devices
* New defconfig for SM8550

Successful CI run: https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon/-/pipelines/1413

Applied a minor fixup (removed OF_EMBED from the SM8550 defconfig per
discussion on the lists).

---

The following changes since commit ad2b0f0ef2a2a6bae1896e493e98734e37a3f1eb:

  Merge patch series "dm: gpio: read GPIOs in of_to_plat(), request them in probe()" (2026-09-29 10:36:18 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git qcom-next

for you to fetch changes up to c3342df7ead8a8d585996fd36ccea62d9504db4b:

  soc/qcom: rpmh: only allow rpmh writes of a single command (2026-10-01 11:54:35 +0200)

----------------------------------------------------------------
Balaji Selvanathan (4):
      clk: qcom: sc7280: add SDCC2 apps clock support
      clk: qcom: sa8775p: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: sc7280: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: qcs615: use GATE_CLK_POLLED for CBCR-backed gate clocks

Balaji Selvanathan via U-Boot (3):
      clk: qcom: sa8775p: Add SDCC1 clock support with frequency table
      clk: qcom: qcs615: Add SDCC1 and SDCC2 clock support
      drivers: mmc: uclass: Set removable flag based on device tree property

Casey Connolly (3):
      power: regulator: qcom-rpmh: propagate votes to parent supplies
      soc/qcom: rpmh: properly fix synchronous requests
      soc/qcom: rpmh: only allow rpmh writes of a single command

Royyan Zahir (1):
      clk: qcom: sa8775p: enable GPLL9 before SDCC1 high-speed rates

Vivek Ray (1):
      arm: mach-snapdragon: increase compat buffer size and warn on root compatible string truncation

William Bright (2):
      doc: board: qualcomm: document SM8550/QCS8550 building/flashing
      configs: add sm8550_defconfig

 arch/arm/mach-snapdragon/board.c              | 18 ++++--
 configs/qcom_sm8550_defconfig                 | 19 ++++++
 doc/board/qualcomm/dragonwing.rst             | 13 +++--
 drivers/clk/qcom/clock-qcom.h                 |  2 +
 drivers/clk/qcom/clock-qcs615.c               | 84 +++++++++++++++++++++------
 drivers/clk/qcom/clock-sa8775p.c              | 76 ++++++++++++++++++------
 drivers/clk/qcom/clock-sc7280.c               | 84 ++++++++++++++++++---------
 drivers/interconnect/qcom/bcm-voter.c         | 16 +++--
 drivers/mmc/msm_sdhci.c                       |  8 +++
 drivers/power/regulator/qcom-rpmh-regulator.c | 35 ++++++++++-
 drivers/soc/qcom/rpmh-rsc.c                   | 70 ++++++++++++++++------
 drivers/soc/qcom/rpmh.c                       |  6 ++
 12 files changed, 334 insertions(+), 97 deletions(-)
 create mode 100644 configs/qcom_sm8550_defconfig
