Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA0AC79F8C
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 01:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F5BF4057E;
	Mon,  7 Sep 2026 01:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ntiW3yEBXX7Y; Mon,  7 Sep 2026 01:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AFE440562
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788743632;
	b=X9IsJIipwcSeUeO5Co1riHvH8e6UWh4m9U1mhOe3pQYVn70B4BuMS6qWIsI4jL1vfO70
	 8PFFTnpHKtQ//qvsze6InmH2YuOyo7wG+WQJBaFjq0wFwsEjE/GJvmvJXDznlZLvZwVrZ
	 5EF1o0gBqNheqyiah9OmDB9krpZWc76uid9UBKvz27S7Rtrnp1PVgRXSP+6Ot7C+3ohAk
	 mPVq0zgIai5ahdAeNgyHWMtzyUd+Kx1n876yTFpMC5eKFqWYSrHECA4gCmLTPy9Qj4jp4
	 auMN81sl6QIMb0oMZ5s9O9G3WyyRr73U0Y4OjKTmWCduOMY4xAYqmOWLYYo73jB2UhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788743632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nFg6c263nvglo8IB6ZvOfkHTLKsDcAINqXhTVjqBwS8=;
	b=o0c+OHw3a3RnwnQ4lW0vXZeLkZmZXs8X5qCw1ftNSPp58n+qi/GfrJkCb8FstHKnHxAM
	 uvq4a4X/gy72VYrh+xwsCtVi03EThp4AoPlYOOYYcrNW4TKePXkBaAYBFzvt223x17bJ2
	 7eYc4NEn6vHz6rijKABEXnuTDD9bDcmskWq76AXG7tMWzB8uZIYnvCc5sZHbcXRC1u6/u
	 z0pdlR3BMxCdHido6UjTSyetapXYm9IRVUcUmSXBfqIUI52XG3oyVrB9CT6GFGRY5hOwz
	 IBewdnFdn6H0gyXgBbb6+itmkBHMFL4HMekTDK9alXInAzYw1zgprd/2ziCBvO0km8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788743632;
	bh=nFg6c263nvglo8IB6ZvOfkHTLKsDcAINqXhTVjqBwS8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qSVhq0Ecu3z5Ojj/I/DL4quqovZCH6otpJS03cd5YkHq8/LjxtopBw3F2EImiHCfJ
	 7l2q6o+XzmFkzscmpZpjB7UDUZehEKEojXGTj3DW/uutFe4aErtir4WcIlkZBfmT2w
	 tmKPmoCcndXDGFFuBxGnOv9xCKEdYae0uuRySmYOXwLF/zLc81QHon2fJiMqXKf84/
	 Qi1oISP/eQkFe+i7j8V+n+1rxF5ekOZPSg+m8ZdT8Cn+OihvkUTYUVPetnDu5pHBPp
	 Fpx26pWlpc6+b4Nj16Tvbq4Xpxfof4unmk6ppOqiSMdEWELf7PTjiZXpb6nwZvl1vr
	 GWgJlOK/zswmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AFE440562;
	Mon,  7 Sep 2026 01:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C24F9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29E68605F7
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCRHnpOy9JPo for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 01:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F509605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788743629;
 b=LOQzhNh2VF1a1UTzP2GVda49VVyduw32JL3uci+to3y4TSZAKT1HilpB/VnifjQ0eahy
 tVNYVwIvaUc0dEkiCl6LZ//Q2EZmN5/d1umwC1Nt0jxX6d/We1k0skpl3Qtq3Or26TNxW
 gBoPy2x5lTS/kXtlTqXv+Gg3JnSiQ+I/gAdCxqaLDB71xoPki1xSwD7HohUHzKQ/xZRg4
 2flQ3fQdfs2b+fkgDDYNYrcc73c1+/fvZ5wcLoufaM8+BXQE+CQtDV8ZGsNqv8mfGiOgr
 Yl1Jk2h3gp4VA3S6p966/j8+awX5Y869Sn25HKCz5lvMgpSoGNFqMMEbfCRoxox2Aow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788743629;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=nFg6c263nvglo8IB6ZvOfkHTLKsDcAINqXhTVjqBwS8=;
 b=AsqiCgYOgQxXbTO+nwdedGySWdf8ih063nMYcSHLdgBaqg4nB2aAhNTKpBL7U3l/s++A
 LqB2N65UD3sucR2/xP95GQfEogRSlZsR0xtd6YcylDqoS3mVhMFuPgFowoqsDyzhmb3MU
 exgYp2BX9T+gocKAH+1JjYK/2zpABNF5B+C1haTj1Q98GlosNv9PMWVh8jzkJQQayngh/
 VyLA1QtLt08kshOS3eW6LRATEHvrTQ65XEiLT54lZ6TZTm3lzK9LKtKTP41f7Q6qxcfPR
 uEVK0rvsTkPmLxqvRqzqiFTivUhML/Npafa0TLxYJbsjheoJVe6wYFo3ZjxJhPgUhSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="kfP0DiO/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kfP0DiO/
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F509605F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 01:13:47 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66fdf2a9aacso341024d50.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788743627; x=1789348427;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nFg6c263nvglo8IB6ZvOfkHTLKsDcAINqXhTVjqBwS8=;
 b=kfP0DiO/b91UGfMcyy/+ehcbz0VZ6kyuFISjRSjSUDCRJE0pVyI0JJjm4hdvEDvlBw
 bfrOyxb/ljo4Hs/ZaG83Foi5KH9EUhh2QQP0B28XisnKBjq+haKIQqjgtchCcG+Tx2RI
 m4L8Lt+2irdPxbXBtJsHrB9zdKqgCpB3k2HGTSCQcrLMgXPmhBxewp4lSKKhZXWraPlV
 CXAQs+fzR3Y0mdvrkqdRReTR2gJp8DmWl7ION0C7mkf1sp0znEB3B0djHNDU38yeQjGm
 Zki43crxz552/MhnEovUJuS00jmqt27NpMufCUkyv1eK/mlccUWTL6l+UCKrmv0ou1+B
 6dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788743627; x=1789348427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nFg6c263nvglo8IB6ZvOfkHTLKsDcAINqXhTVjqBwS8=;
 b=r5u5XFBbdXq9D0NMpbERfq6MkUs36HcbgQlYSOIRLmZrNLm33NFPRc3z3GWWQMDgIe
 9FCyWOUTEi6ELfbRVlTQoblCzYpna4wVJQv1KC9KUZJXkq72wvdkFI/zYpoTVLOaYxwU
 mkJRzHUvkgXeQiJ114owxuexJB6wh52ve/+3FXsg+wH77RN9WjcuP2dTyuvtseT5mnYk
 asXwr+7Q1AEhjhCCd8gvFDGTwT8FZWMe19NHD84ybe8XNHxQuBdU7JBXF+JXNfS+Pp0K
 keRzAiJnXEXlHfw0XU/cdjm3SGm5zs3KlttEfUeC3LwUXRxExwOUgRKXBYtI895kM7jN
 zWTw==
X-Gm-Message-State: AFuF++nMCAU0y3Pgq4z3EFhSjx8OaiyqRJFuFUs7VXEfMUhBzGVQhypT
 bvubK+O6ibhELl/kPgjVfIuTppuQomGNLQYPbgrnUOaF/8q+TnVpLMxo
X-Gm-Gg: AYBFou3i37BUMA/txKHis09NkRspnWMdyvnUaRFEjjmlAA65dOrSh+1tj4MODcgZ/MB
 U9DY8fOt/CEJd6YcHYzA226SCFmPls0YD/2raeEHkdMNeDaiFTWlJGS1xOER2QtqQRwbHkbyPhO
 LWY6CkuKfuOIfIt5UKCmVtgpQowoqud9iQ23x8rGrgCNR4HAZ3Vp5Uku89CY315Y3rqJKGUAtk3
 Qw0/lYQ2XedNRl47J6UkPw5ohs3uOEHFGOVYpW7L5VibAFpzoTpgCRIV0U5tgR7EJMsbkkK7KuY
 kybs7kqSVVVbUiZYco7ZCz9h2eiZZnvGRm5QSpeqaJ7EtbOufuuMD0F0xdHtygvU8tI6/wDETn7
 PmSMf4bzr40sadYaaloka5GJcZc3ZfcLGTFnh5GQtndnMqjrM3kd+1TaEto2GjhLlg3m+Nd3KYE
 7aGLktmPzNfo61ZyHAEEfi1a9MGEwDDyGJcDG6TscJrLO+HbZD6+Kpkb2MfJrEGzG3qCrfQADBg
 h3jUwvcHYs9RIh7yqnX53vjxSOpdKxWogpgMg==
X-Received: by 2002:a05:690c:319:b0:841:8f97:e898 with SMTP id
 00721157ae682-871288e0f77mr93941787b3.32.1788743626780; 
 Sun, 06 Sep 2026 18:13:46 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a803:6c49:a12a:bd33:6635:9572])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-871493155d3sm63503677b3.16.2026.09.06.18.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 18:13:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, alice.guo@nxp.com, marex@nabladev.com,
 Max.Merchel@ew.tq-group.com, stefan.eichenberger@toradex.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260906
Date: Sun,  6 Sep 2026 22:13:40 -0300
Message-ID: <20260907011340.6031-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit 75df64103873fac09642860cedadaffb8cf6b2c7:

  Merge patch series "Fix logic of OF_OMIT_DTB and remove useless dts files" (2026-09-03 16:12:28 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260906

for you to fetch changes up to d97390107f52447aa109b38106c234f55ee19fee:

  imx: imx8mm_evk: Indent the config with tabs (2026-09-06 10:25:49 -0300)

u-boot-imx-next-20260906
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1194

- Add support for the i.MX93W EVK board.
- Revert patch that added bootph- properties on the TQ Group boards as these
changes landed upstream.
- Several cleanups on Toradex i.MX95 boards.
----------------------------------------------------------------
Alice Guo (5):
      imx93: clock: add 900MHz entry to fractional PLL rate table
      board: imx93w_evk: add board support for i.MX93W EVK
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 Ethernet PHY Wrapper
      net: fsl_enetc: Add 1G SGMII mode support for i.MX95

Marek Vasut (1):
      imx: imx8mm_evk: Indent the config with tabs

Max Merchel (3):
      Revert "ARM: dts: tqma6: add boot phase properties"
      Revert "ARM: dts: tqma6ul: add boot phase properties"
      Revert "arch: arm: dts: tqma7x: add boot phase properties"

Stefan Eichenberger (3):
      configs: {aquila, verdin, toradex-smarc}-imx95: remove CONFIG_SPI
      imx: verdin-imx95: remove unused WDOG_BASE_ADDR
      toradex: {aquila, smarc, verdin}-imx95: add board_fix_fdt

Ye Li (2):
      imx93: clock: add 450MHz DDR PLL rate
      board: imx93_evk: add LPDDR4X 3600MTS timing tables

 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              |   32 -
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi             |   36 -
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi            |    4 -
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi            |    8 -
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi     |   32 -
 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |    2 -
 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |    2 -
 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |    2 -
 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |    2 -
 .../arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi |    2 -
 arch/arm/dts/imx7s-mba7-u-boot.dtsi                |   21 -
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi               |   24 -
 arch/arm/dts/imx93w-evk-u-boot.dtsi                |  171 ++
 arch/arm/dts/mba6ulx-u-boot.dtsi                   |   26 -
 arch/arm/mach-imx/imx9/Kconfig                     |   12 +
 arch/arm/mach-imx/imx9/clock.c                     |    2 +
 board/nxp/imx93_evk/Kconfig                        |    2 +-
 board/nxp/imx93_evk/MAINTAINERS                    |    2 +
 board/nxp/imx93_evk/Makefile                       |   12 +
 board/nxp/imx93_evk/lpddr4x_timing_3600mts.c       | 1998 +++++++++++++++++++
 board/nxp/imx93_evk/lpddr4x_timing_3600mts_ecc.c   | 1999 ++++++++++++++++++++
 board/toradex/aquila-imx95/aquila-imx95.c          |    8 +
 board/toradex/smarc-imx95/smarc-imx95.c            |    8 +
 board/toradex/verdin-imx95/verdin-imx95.c          |    8 +
 configs/aquila-imx95_defconfig                     |    2 +-
 configs/imx93w_evk_defconfig                       |  172 ++
 configs/imx93w_evk_inline_ecc_defconfig            |    3 +
 configs/toradex-smarc-imx95_defconfig              |    2 +-
 configs/verdin-imx95_defconfig                     |    2 +-
 doc/board/nxp/imx93w_evk.rst                       |   72 +
 doc/board/nxp/index.rst                            |    1 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
 drivers/net/fsl_enetc.c                            |   20 +
 drivers/net/fsl_enetc.h                            |    1 +
 drivers/net/fsl_enetc_xpcs_phy.c                   |  695 ++++++-
 include/configs/imx8mm_evk.h                       |   22 +-
 include/configs/verdin-imx95.h                     |    2 -
 37 files changed, 5121 insertions(+), 292 deletions(-)
 create mode 100644 arch/arm/dts/imx93w-evk-u-boot.dtsi
 delete mode 100644 arch/arm/dts/mba6ulx-u-boot.dtsi
 create mode 100644 board/nxp/imx93_evk/lpddr4x_timing_3600mts.c
 create mode 100644 board/nxp/imx93_evk/lpddr4x_timing_3600mts_ecc.c
 create mode 100644 configs/imx93w_evk_defconfig
 create mode 100644 configs/imx93w_evk_inline_ecc_defconfig
 create mode 100644 doc/board/nxp/imx93w_evk.rst
