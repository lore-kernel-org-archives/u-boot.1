Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D92C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 12:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C4E060817;
	Wed, 16 Sep 2026 12:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXuZh7xi776K; Wed, 16 Sep 2026 12:27:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 478EE607FB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789561630;
	b=iRzN5VuBfyQHYjymowO7ztmTi28oGUUs+ha8E8lQHIN2DigomKBgsagVsEkgYB5cQPt9
	 gK2ZHPg/ItLmzc8MqL+NGqc8n8D/jmiYBVxJOQzWGw0GdLpnhHVtvhwBy97WoDiMo8UNO
	 byU+vxDsE9i6K95a21yiDQ/0rGi3Ra2xaX0YVH+4OY7lJlcGXygqpTLiVZZrF3vhqLA36
	 9j60/uIdZBavMBhHtzU1bAO2K3SgOEvJwW9foK2+IAkveV7NmQ7V7fwAHD0XbEi8nBF36
	 QTGzsLOyUhq5pIUVO5koo59My/CybdUZQqlMUznfavrA/8t7gqOn8XTPixOJE/1r1Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789561630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=upbT/fDlP+vUHchdQEU/h00SJtNGNLLBiSn7g8hlxSE=;
	b=M8Ytm2uahphz6QXmIdxNEeB467EfYd4Ar3uxk3qD2nrfY+4b9UZTHFoaPRKL6U6Df1p0
	 sqUy92yAVP6pVi77JWnX+tZBT65tGjF1QLubBtQ4L+LaNtfZUt7+TRnCaeRjCNfoqwQPj
	 T9QXur1qj+OpRe8df4pknwUBwoUxk4dmtG1L2EqC1iL3yQu7MOMRZEQyJeT/yUhONtxvn
	 /FeBXsCd3tNep6SXinaYlKnlsXL2GSAXggQUE6PIy7uOp3u0BYFfFx9ARabgo6ouYdLBy
	 bTI9Gd9zlBhuCd8vip+smdKBxViKtAJQ8dMXAJwDP9za60wDLx6ezLYFEcVevwFnjkA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789561630;
	bh=upbT/fDlP+vUHchdQEU/h00SJtNGNLLBiSn7g8hlxSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxH3x9Chydkeh5sQ6rA/4VLXEyAixDm2cwnQsMwIP8igVgJ3TQIlzEwlqgl3wR+uM
	 zdYPWNUnF8d9OtIM9m5ZPXVB8P9tDCFR05aqFPuRoP0zkonBnNzhv1xO5ankv33coO
	 PQv8cvjGAF3I90ZLzjo1Z0ym6H6gqFqc//JQEJlf1GfdhQF9+jZwLWmQslVJLFM0hY
	 GCTEfPE8yJOYkQFFHA+/6/njBWz/jrxc8uhLp6lBy4dBWj7PEr/44bzeLinPC0SxUf
	 BaMvxWpEtaIeVNslTdILq0L+o5Q+tPrS+r/IWn/fEzTAIf7x+OAWdF4F0txhI8s46w
	 FSVTxut33+uww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 478EE607FB;
	Wed, 16 Sep 2026 12:27:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0C6C352
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C28D5406DB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ddid7cidG880 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA4AB406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789561628;
 b=VEhMYa+4AjKsAOWO5oG65akUf2X7koSRzP7YzXEnwHoESeXRmZYOOW9UYwgXcVNIJl2w
 t5pPkFskLwv8l8Sexi4IX8QfOmIupQBjfb3SVs0hazY5fynHzeT/r/xmpQaP5Em+deFL7
 AqDa7+t9Exd21nVqCRHWo/sj8D/WLfnELmAmNoucYcBp4InRfnU9tUKJtb4IKc9ZDP4tb
 mQ7P+HpW0YtQ1lhp5dOdJL32qByNS7fRE6BsMe2eeNVZA/jS6kEwrRmpkhfS7vE3isqvw
 RIax4yQmPSV27IKlFLGLCmXxto/TaKcJ/rO8OLVyPJ0EL8Tg60upWJ2+zjIoANJxpzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789561628;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=upbT/fDlP+vUHchdQEU/h00SJtNGNLLBiSn7g8hlxSE=;
 b=WcxHgkjF6soV0F3a9vSfBAZQD9Fv9fux03xlTDXsmLCT5k7jqVLRHJqdsybZ9dvoVI8U
 O6GCpjJAJV22Kd2Sx9T4OoxWOXjzlVsCAuRUZFbaFIFlMQHUIeLFJt5wjWsjsc2SYu+GZ
 Op43q46OPDyLDJvdYaWbnATjAkUWLFq6bjO61Ce3RwyGECbYl/643/rQ+iYaFav3ncJib
 g+wq3mienP99woy8EbRqyQHA9mA17KRTvzFgCFAxorx6Qr3zOepRUdI0EaRhgEYuAlICh
 vQXf8ufmvwt42XTjgNmxMA2xSWCzFKnaeAk9PZCZZnAj/DMRxlZ4B3aIL3ArLkFTG/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oHo9vpKz; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oHo9vpKz
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA4AB406D8
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:27:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BB4960234;
 Wed, 16 Sep 2026 12:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C68F1F000FF;
 Wed, 16 Sep 2026 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789561624;
 bh=upbT/fDlP+vUHchdQEU/h00SJtNGNLLBiSn7g8hlxSE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oHo9vpKzpH9Fr7Bdss5beQghKUSqf5QxQGGDMhTwEkvw33KJkYMqh/xLigTzSNhj5
 KQ21xy6MrF6VC/uG0IcRGaowX5flvJvmTXs3I2MAzvB2ke36rWdAgEJ3npeyc+jdI3
 l6qadmTxeEvUZlptCoHu4g++3G6TnDFmK0tUMDZAnSCmp/qHvte80NpsAadZY3w/wY
 BLiIRrb92Sg978nqxr25DQgGoGUe+TGk87INK+TkY0hiPc7J465chMXLCyUSlAQYEV
 Epwth/c/iN2iRvRWMgOjDopoSCm89H1PwbNN8nGO8GKODk8KIcDI6fzFyGGTbQnG9C
 zhvf1NnZeegTQ==
Date: Wed, 16 Sep 2026 12:27:01 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Wei Fu <wefu@redhat.com>, Scott Bambrough <scott@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v13 0/7] spacemit mmc driver
Message-ID: <20260916122701-GKC266329@kernel.org>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
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


On 20:36 Sat 12 Sep     , Eric Chung wrote:
> This series adds MMC support for the SpacemiT K1: an SDHCI platform
> driver, the SD card device-tree overlay, defconfig options, and SPL
> boot-device selection from the SoC strap/config registers. The SDHCI
> driver is usable in both SPL and U-Boot proper.
> 
> A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> write images to eMMC.
> 
> ---
> Changes in v13:
> - mmc: Sync the definition values from upstream mmc driver.
> - doc: Only flash the minimised partitions for SD boot.
> - Link to v12: https://patch.msgid.link/20260906-m4-v12-0-89eb5a8f879d@riscstar.com
> 
> Changes in v12:
> - dts: Drop all upstreamed DTS patches since they're merged now.
> - Link to v11: https://patch.msgid.link/20260905-m4-v11-0-235eacd94fe0@riscstar.com
> 
> Changes in v11:
> - spl: Fix the read_boot_mode() that returns both boot mode and boot device.
> - Link to v10: https://patch.msgid.link/20260824-m4-v10-0-5e0adcb1edb9@riscstar.com
> 
> Changes in v10:
> - pinctrl: Move all pinctrl patches into a new patch set.
> - Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@riscstar.com
> 
> Changes in v9:
> - spl: Enhance detection on booting from SD.
> - dts: Synched upstream DTS files for K1.
> - doc: Create SD card image from scratch.
> - mmc: Avoid to use CMD18 on SD card in SPL.
> - pinctrl: Drop "fix drive strength configuration".
> - Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@riscstar.com
> 
> Changes in v8:
> - doc: Remove SD card.
> - Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@riscstar.com
> 
> Changes in v7:
> - env: Drop env support on the mmc series.
> - dts: Sync upstream DTS files for spacemit.
> - pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
> - spl: Fix DTB matching.
> - Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com
> 
> Changes in v6:
> - pinctrl: Fix drive strength configuration.
> - pinctrl: Fix pull-up/pull-down configuration.
> - pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
> - spacemit: rebase on latest upstream branch.
> - Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com
> 
> Changes in v5:
> - mmc: Split CMD23 support out.
> - mmc: Use read_poll_timeout().
> - mmc: Set pinctrl state based on selected timing mode.
> - mmc: Remove the condition based on quirks.
> - pinctrl: Fix power source argument.
> - dts: Add missing power source on mmc pins.
> - Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com
> 
> Changes in v4:
> - mmc: Add CMD23 for write.
> - mmc: Fix CMD23 only for CMD18.
> - mmc: Update bulk release operations on reset and clocks for spacemit
>   platform driver.
> - MAINTAINER: update the maintainer of Spacemit K1.
> - Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com
> 
> Changes in v3:
> - pinctrl: Fix "fast" by "uhs".
> - pinctrl: Add syscon dependency.
> - mmc: Fix quick by capability.
> - doc: Add SD boot support.
> - Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc
> 
> Changes in v2:
> - cmd: drop patches on eminfo & tlv_eeprom.
> - configs: Enable ADMA and SYSCON support.
> - dts: Use vmmc-supply as vqmmc-supply on the SD card node.
> - mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
>   read/write, correct pinctrl state from "fast" to "uhs".
> - mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
>   transfers.
> - pinctrl: k1: Add new IO power domain configuration support for
>   dual-voltage GPIO banks.
> - spacemit: k1: Use FIELD_GET() to parse boot strap mode.
> - Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/
> 
> To: u-boot-spacemit@groups.io
> To: u-boot@lists.u-boot-project.org
> To: Yao Zi <me@ziyao.cc>
> Cc: Huan Zhou <pericycle.cc@gmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Siu Ming Tong <smtong@axiado.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> 
> ---
> Eric Chung (7):
>       spacemit: k1: select boot device via config registers
>       mmc: k1: add sdhci platform driver
>       dts: k1: enable mmc devices in SPL
>       configs: k1: enable SD and eMMC support
>       MAINTAINER: update Spacemit K1 entry
>       doc: spacemit: flash on K1 SoC based boards
>       spacemit: k1: fix product name detection and DTB matching in SPL
> 
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 +-
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +-----
>  board/spacemit/k1/MAINTAINERS             |   5 +-
>  board/spacemit/k1/spl.c                   | 148 ++++++-
>  configs/spacemit_k1_defconfig             |  22 +
>  doc/board/spacemit/index.rst              |   1 +
>  doc/board/spacemit/k1-mmc.rst             | 268 ++++++++++++
>  drivers/mmc/Kconfig                       |   7 +
>  drivers/mmc/Makefile                      |   1 +
>  drivers/mmc/spacemit_sdhci.c              | 684 ++++++++++++++++++++++++++++++
>  10 files changed, 1136 insertions(+), 148 deletions(-)
> ---

For this series, I've tested on Bananapi-F3 board, which works
on both eMMC and SD card, and so with 

Tested-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>


-- 
Yixun Lan (dlan)
