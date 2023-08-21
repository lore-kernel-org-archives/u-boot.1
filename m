Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A51EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5758713A;
	Mon, 21 Aug 2023 21:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SK1sy27U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696D387135; Mon, 21 Aug 2023 21:11:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E38187072
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5259cf39154so4670949a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645109; x=1693249909;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d6FrIzlb8TYWl8qf3d3pAAr/Z10eZOBWcaZa1vS6cns=;
 b=SK1sy27UoPhyvSFx7DRtv45bee6ImEARGOvTgmjd+02LucvT2BYVi6YDlVtdahi4U3
 ETo+Anra2s83tNlDs+/dFI8GaOTszpPZdN5jg3LGNLgigjisBwLxfV72wUXYHElQapyf
 knD6H76icnXOC/L50NRLFvP//Nim4ZIiLB19Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645109; x=1693249909;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6FrIzlb8TYWl8qf3d3pAAr/Z10eZOBWcaZa1vS6cns=;
 b=azPlVje3bc/5KmGQTs8tkU948WOuIj4JYZ0kde7dLqUBhGCU9MxNrB7vAbur8hAHSK
 FFTQSm3xzs9FXG9U6ZqZubVcIAwOAXN0l0a7d2K2/U/BgTSH1BsBZqw19RaheLhUiLG2
 mEq//GSiev5iaqt2sbkN4NvZe9KQ2IqZgB5RkbYLVQKbo+bEzEgYzRBZJwqVhVQavk7P
 pPKPLMkYMVGTo+Tv1AVslw2Ja5yP8mS08uO7c76a4SvDpqfiriwSXER0UFgCkz0cEHVS
 T+eZNBs6700bXy3GEcebAVaFFMcoB8d5JqiGdvY/NTkZxmek3Bo42GwQhge69nLSwvzk
 nlhQ==
X-Gm-Message-State: AOJu0YxQapS0AEckyZrpfQFomxe58LLz4s2DaQt0aLjdhZ82Nd/xxARq
 zmCi2jr777j5R7MvE/zyiELR9fzpV55f+r5Tya7QnZBKKqIOz1yMxm8=
X-Google-Smtp-Source: AGHT+IGl/cNby8E4igxYbiYVdNFUNE3g4gQ2i+VUV7RkW1EahWri6RTosi7PvI37KLBLGmZKZIOzqiuzZRyOtTCB7kY=
X-Received: by 2002:aa7:dad5:0:b0:522:564d:6de with SMTP id
 x21-20020aa7dad5000000b00522564d06demr6834440eds.36.1692645109445; Mon, 21
 Aug 2023 12:11:49 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:38 -0600
Message-ID: <CAPnjgZ3SvbMcbPWijcy3JCyh=Cp6X7MMC8vT2Ojk-miFa470GA@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17449
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=47&view=results


The following changes since commit 17aad803551500e1a3d87339a6559e99b7fad479:

  Merge branch 'master' of
https://source.denx.de/u-boot/custodians/u-boot-sh (2023-08-20
11:09:11 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-20aug23

for you to fetch changes up to 25a9be71ec1ca779aac8bcb1d8a363725ff0ac7f:

  test: cpu: Handle both 32bit and 64bit CPUs (2023-08-20 15:55:27 -0600)

----------------------------------------------------------------
sandbox64 fixes

----------------------------------------------------------------
Marek Vasut (11):
      configs: sandbox64: Enable SF bootdev
      configs: sandbox64: Increase console record size to 0x6000
      configs: sandbox64: Enable MC34708 driver
      configs: sandbox64: Enable BUTTON_ADC driver
      test: dm: pinmux: Handle %pa in pinctrl-single mux output
      configs: sandbox64: Enable PINCTRL_SINGLE driver
      configs: sandbox64: Enable video 16bpp and 24bpp support
      configs: sandbox64: Enable video 12x22 font support
      configs: sandbox64: Enable clock CCF driver
      configs: sandbox64: Enable PCI register multi-entry support
      test: cpu: Handle both 32bit and 64bit CPUs

 configs/sandbox64_defconfig | 12 ++++++-
 test/dm/cpu.c               |  2 +-
 test/dm/pinmux.c            | 92
++++++++++++++++++++++++++++++------------------------
 3 files changed, 63 insertions(+), 43 deletions(-)

Regards,
Simon
