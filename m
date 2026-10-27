Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF8606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TK4bTQcB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahffP0oK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EE246068F;
	Tue, 27 Oct 2026 17:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ae7cgvv6ZiVC; Tue, 27 Oct 2026 17:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 900A560699
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123865;
	b=Cy+xiX6YcXsXKiEK3qBnKwBcnf5J9Ot4LLpQxiJfr4nWOiPWEfq6mGMgl0gEIct/LDb4
	 x4lNudysUwmse0F74iA7IGnES8sdCLp3OOlZZsixE27Iy6Cr7X8APbsKSDXd9BVkFlyUj
	 tU/WhTbuDdQ6gIK+qblpdGPq1DsG8p9jd2qpwxRoK2AMQU8opSgN6yMVTZ2uxCoPslgPL
	 iBwZQ4rsbgzmZiikuVibK542ZWpP3zgAZZtISf49krpN9aUuhL0jeGBKdBxcpI7pnQXfA
	 G1o6Bv1FE1s31PLOkiVwxbie9nEaasYZRfyfytQfd2t2ZiHnM1UpHwJ7cPOOhlnjUCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Yxwy1V7XaKan7emNn/VNQHYQ3dK8I2gTTxDqyWi3GPQ=;
	b=YCD7phKiLwC75a8/ghH3aSVWAOfgoTNNW5EEUWUuovKIkBt+OuSpc6PPs9lsdAqzC7oI
	 oUtjNSEIcyjyD4UNsU53gOa2S5NPwQMuikDgk2E/Wg+g6fFbZo0RC8vzrru0OZ/0eUgmb
	 ugVdyHUO6mXNE4L0+qnfp3socplqq3otyDFSfT4KqMFoQhz3OtRdE1KywoZvjzB2DNXP7
	 GmVdn/Fw6VgpW56vXDC5O7q3BA3SAKJYK8ZREdlCFXBnTdS9sKKkdBAGp1FucZdkRc+M8
	 xw5M32y+IG/DSWA4r+U3hsaUg/wMoPmF0TY8cGXYPOsURAD/dMXs5U4fWWkdnhuNMHQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahffP0oK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793123865;
	bh=Yxwy1V7XaKan7emNn/VNQHYQ3dK8I2gTTxDqyWi3GPQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TK4bTQcBwDEgrxl1evGpooPBjiGqeugc2OvlFPQer1Ja90qlrmUX7AoCpgMEkFwZL
	 nvU6VLnSolONj6pF3nHLgQb/sm/EpS4yvEqbVHIR3+MTNXml8f757i5BjOYlZsrg6t
	 hL6TsVAX7dcec9D+Io3q4yNi3Bj1/MQFckZOnoXUEFrkiDlTgeKzYtU7qrFPTaywEg
	 zlSdTSV2NCfB0/qBOJvhA0bnLd/nCx++GejqEk/TYkMbh55r8mG+HET96ncTkWl5VE
	 +Up1MKK59ljaz1OTstBthKc/p8pmnpJPl3kz3dPLN4s1LfV4ajhjaLLPPCzQlzz4KE
	 niK8/v+rq57IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 900A560699;
	Tue, 27 Oct 2026 17:57:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D06472
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82FD660699
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWW8ilhzFTEO for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 037D16068F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123863;
 b=MAVMmKAj8bVvVX5PnDOElhtavo4Q5YueDjHKWyri/BgtkS4WBaWMN5QMGFRUYWvXDoc9
 P0KtsX4MU6ZOxOUWOaUVl7OVSb8j5de26+tkB2VDqvcS5FtdTrxT68kZ031Ag1xWH76LN
 +iBGtuzHH+KaCNX218dyMuI7qwC5FrRIHtJuXZv0C2Tu4W3i/P7arPl1LNpEg7H1ccoSl
 MCl/naOwVwe2EF1irVn5u9N+e2ZEhi+OlF20oMVbzT1afTUVF+u7IVablSdbp+w0iRAd0
 SyopzYcfp957f6rNREpgux/UWYNmD1m76VV4txeBGt/RJavwUCU8Z22nWlX5IjXTjgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123863;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Yxwy1V7XaKan7emNn/VNQHYQ3dK8I2gTTxDqyWi3GPQ=;
 b=my4WvxK4FAwPfv5vb2P3ov2TfK5Y91ehi/Fi42WeRyYNlWPF5UuntESOpfo7GJoiGcDL
 Ufm3v/i+lwJXV30SACIl2tC1ejr9xqerp7EXOhiiTeRsO0UBuoKnSMA8Hffeq4uSSYakq
 5oUQjYoSWc1x2t1FNLr4/o6xu6TMosXvISxV7PU5NdVcdyvz04I5lLqSAPc7OkVlqPz6Y
 2jOw2P/zFWbyS90JjFgiz2c1u9+j+yY9OzvkvL2YUhQs7sj1vuMeZ37sEyWsg7FSOhJ0i
 PJoXJ8i7Q9MQuSaMPEDSwYZTX/OeURR+8GWDaBzLoBZv2TdE/jVQnVDFEgKy+ggWINA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ahffP0oK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ahffP0oK
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 037D16068F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:57:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3832360142;
 Tue, 27 Oct 2026 17:57:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793123860;
 b=G2kKPDAM3Ab0iA1gI5KWVVD+gwQGWE+MBXWFBGkZyQrqsBf7sQppCk1vWWh5S1vEK4Xx
 N0Hf5zCxvG+TmPkypXm25rwlg5tXtzSTsMfeehMwgHuOmUM0QK5XUTC3oWeF/A4MVUF2p
 VWYDe1wzx7dZa2vsbhcLrcbMyF2cTRtUbdQNVX4kim2fMewocd/SK06DsqPFyy3R8qOUr
 0j+PD9UBf8MAEh00wXJST0Z2vhW9PBPQXhnpf+Ei2n+gs26fHGrL+giVni++JeMDZYP8T
 MdtIiiDQ4hj+kelkBKzgRHDnVC/I8PYbmmf/5QFoS4aE1iOoAJ2klcJmCVUFRlqytUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123860;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=Yxwy1V7XaKan7emNn/VNQHYQ3dK8I2gTTxDqyWi3GPQ=;
 b=qu4Ws+EAH5vgc8CZkz/syfkTzYYut/jt0F5I7Uh27y2tdAZxugf5FJNuV6WQMDGnLegQ
 4uIQixg60tw5VgS50e3+2IPYm0mWyuCzf0KYAdoZgENDcz6jT3Nnl0hQgsWu0l7hUZuQV
 XO2UNqHDn8nTJXop87g0qAUR/Gifw5QWuOOtJKjFCk0CtyEVFPYAsHsv/TMf+0lz+8LlS
 EqQkmw7mY+Jf9UkoSqYQ/9LfwoHXMtSbw7ezKO29OxzYXIz/Rqe3mGlpoglq9vDJFC51Q
 NfkTQD76rBCtAjEo5Rd3zo0T0asRZtW4uG3+4RVvOzA54qSHPqbKCuPMUylwhVxz+zg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DD59C1F01825;
 Tue, 27 Oct 2026 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793123860;
 bh=Yxwy1V7XaKan7emNn/VNQHYQ3dK8I2gTTxDqyWi3GPQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=ahffP0oKrmghHJB7nmnOZrWHJK3dhbDS/ysHPkPkc4WNHl3PS0oUWSv6JVcZABBwO
 dIaswp2QQjFkLd2fJH6Go23chPz6wozdZL7UItfGPGOi9gZ1dX6Pybm2qhjKsXm19X
 8XYrmuks/tqb3dNftuyTiu6InDrhw7olD5wjvkthhpfpApfazYPO04OydWo+dOBztO
 qDbDR/FtRpiNa2UuHRpwHjAlmqMMs+9iFBsThyCuvQy2CgVE7FA8V5sp7EnSeoIbPZ
 ESQUXT6611F7lNqhA9TS/qnsFzQcG8pHy/CvkSEV+b6fGftGgjB+6/pkxq6zZGsP9O
 q6HE3hsA5HQ6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6A74D451B0;
 Tue, 27 Oct 2026 17:57:39 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 27 Oct 2026 17:57:37 +0000
Subject: [PATCH v3] spi: sf: Probe a flash at the requested speed and mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-spi-probe-speed-v3-1-33e056720925@iav.lv>
X-B4-Tracking: v=1; b=H4sIABDm4GoC/3WNQQqDMBBFryKzbkoykahd9R6li8RM6kBRSUpoE
 e/e6MJN6W7eh/dmgUSRKcGlWiBS5sTTWECfKugHOz5IsC8MKNHITkuRZhZznByVi8gLZbDtTVu
 TwRqKNUcK/N6Lt3vhgdNrip/9QVbb+r+VlVAihM6SC+R86K5s8/mZYQtlPGQlsfmVscgYsPHeG
 Su1O+R1Xb+BoFOf6AAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13174; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=X3x8oOVTPgY1MYNTLnaUm3JJ+kOwGo1CYOle8Sz+VLg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkPngm1eujwc6VfWd93VGvHybnT5CxlUuN//VhYlNY5L
 2HG6emGHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAiGf6MDC/2t/vIX//39bXj
 OfYd0+Sfzz1bwn6z+sGcpZuqJokEJogyMjyZkHjg3J+XJ4MWizI684lvkFjL97It99/1IAbJR+d
 U17ACAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

'sf probe <bus>:<cs> <speed> [<mode>]' ignores the speed and the mode
for a flash that has a device tree node: the probe, and with it the
JEDEC ID read, runs at spi-max-frequency and in the device tree mode.
The requested values reach the controller only after the probe, through
spi_set_speed_mode(), while slave->max_hz and slave->mode keep the
device tree values. Without a mode, sf probe passes
CONFIG_SF_DEFAULT_MODE, so after the probe the controller runs in that
mode rather than in the device tree one. A mode given once also stays
in the controller for later probes without one, since the bus still
caches the device tree mode and the bus claim does not reprogram it.

On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
the flash does not answer at the resulting clock, at any requested
speed:

  => sf probe 1:0 1000000
  jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff

Add _spi_get_bus_and_cs_at() to the SPI uclass. It probes a slave that
has platform data with the requested speed and mode and restores the
platform data right after the probe, so the slave keeps the requested
values and the platform data stays as the device tree set it. With
dt_mode it keeps the device tree mode. Add spi_flash_probe_at() on top
of it and use it in sf probe with an explicit speed; without a mode
argument the device tree mode stays. A speed above spi-max-frequency is
honoured, as it already is after the probe. The other callers of
spi_flash_probe() and _spi_get_bus_and_cs() do not change.

With this change:

  => sf probe 1:0 1000000
  SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB

Add a sandbox test for it.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested in sandbox (the new test fails at slave->max_hz without the
change, and at the controller mode with v2) and on ROCK Pi 4A with
U-Boot proper chainloaded: sf probe 1:0 at 1 and 10 MHz detects the
flash, without a speed it reads ff ff ff at the DT 108 MHz, modes 0
and 3 detect it, modes 1 and 2 read ff ff ff. With v2, modes 1 and 2
detect it, and the next 'sf probe 1:0 1000000' reads ff ff ff.
---
Changes in v3:
- Move the override into _spi_get_bus_and_cs_at() in the SPI uclass,
  with spi_flash_probe_at() for sf probe, so the command does not touch
  the platform data (Simon)
- Probe in the requested mode too: in v2 it reached the controller only
  after the probe, and slave->mode kept the DT mode (Simon)
- Without a mode, keep the DT mode after the probe as well, instead of
  switching to SF_DEFAULT_MODE
- Test the controller mode and plat->mode as well
- Link to v2: https://lore.kernel.org/r/20261027-spi-probe-speed-v2-1-2f27ddb6a03b@iav.lv

Changes in v2:
- Move the override from _spi_get_bus_and_cs() to sf probe, so only an
  explicit speed from the shell changes; other callers keep probing at
  the DT speed (Simon)
- Override only max_hz and keep the DT mode (Simon)
- Test through sf probe on spi.bin@1 (spi-cpol, spi-cpha) that
  plat->max_hz and the DT mode bits survive (Simon)
- Drop the wrong v1 claim that the next bus claim returns to the DT speed
- Leave the post-probe spi_set_speed_mode() from e2e95e5e2542 as is:
  SF_DEFAULT_SPEED takes effect there, and 117 of 153 SPL_SPI_LOAD
  defconfigs set it
- Link to v1: https://lore.kernel.org/r/20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv
---
 cmd/sf.c                    |  2 +-
 drivers/mtd/spi/sf-uclass.c | 33 +++++++++++++++++++++++++++++----
 drivers/spi/spi-uclass.c    | 41 ++++++++++++++++++++++++++++++++++++++---
 include/spi.h               | 23 +++++++++++++++++++++++
 include/spi_flash.h         | 18 ++++++++++++++++++
 test/dm/sf.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index ec9ebde2aaf..fb5b9627444 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -146,7 +146,7 @@ static int do_spi_flash_probe(int argc, char *const argv[])
 			}
 		}
 	} else {
-		flash = spi_flash_probe(bus, cs, speed, mode);
+		flash = spi_flash_probe_at(bus, cs, speed, mode, argc < 4);
 	}
 
 	if (!flash) {
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index a9db5296b2d..7b487b8aff8 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -44,12 +44,16 @@ int spl_flash_get_sw_write_prot(struct udevice *dev)
  * TODO(sjg@chromium.org): This is an old-style function. We should remove
  * it when all SPI flash drivers use dm
  */
-struct spi_flash *spi_flash_probe(unsigned int busnum, unsigned int cs,
-				  unsigned int max_hz, unsigned int spi_mode)
+static struct spi_flash *spi_flash_probe_common(unsigned int busnum,
+						unsigned int cs,
+						unsigned int max_hz,
+						unsigned int spi_mode, bool at,
+						bool dt_mode)
 {
 	struct spi_slave *slave;
 	struct udevice *bus;
 	char *str;
+	int ret;
 
 #if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	str = "spi_flash";
@@ -60,13 +64,34 @@ struct spi_flash *spi_flash_probe(unsigned int busnum, unsigned int cs,
 	str = strdup(name);
 #endif
 
-	if (_spi_get_bus_and_cs(busnum, cs, max_hz, spi_mode,
-				"jedec_spi_nor", str, &bus, &slave))
+	if (at)
+		ret = _spi_get_bus_and_cs_at(busnum, cs, max_hz, spi_mode,
+					     dt_mode, "jedec_spi_nor", str,
+					     &bus, &slave);
+	else
+		ret = _spi_get_bus_and_cs(busnum, cs, max_hz, spi_mode,
+					  "jedec_spi_nor", str, &bus, &slave);
+	if (ret)
 		return NULL;
 
 	return dev_get_uclass_priv(slave->dev);
 }
 
+struct spi_flash *spi_flash_probe(unsigned int busnum, unsigned int cs,
+				  unsigned int max_hz, unsigned int spi_mode)
+{
+	return spi_flash_probe_common(busnum, cs, max_hz, spi_mode, false,
+				      false);
+}
+
+struct spi_flash *spi_flash_probe_at(unsigned int busnum, unsigned int cs,
+				     unsigned int max_hz,
+				     unsigned int spi_mode, bool dt_mode)
+{
+	return spi_flash_probe_common(busnum, cs, max_hz, spi_mode, true,
+				      dt_mode);
+}
+
 int spi_flash_probe_bus_cs(unsigned int busnum, unsigned int cs,
 			   struct udevice **devp)
 {
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index dd1843ffac1..b8f8e021019 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -476,9 +476,11 @@ err:
 	return ret;
 }
 
-int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
-			const char *drv_name, const char *dev_name,
-			struct udevice **busp, struct spi_slave **devp)
+static int spi_get_bus_and_cs_common(int busnum, int cs, int speed, int mode,
+				     bool at, bool dt_mode,
+				     const char *drv_name, const char *dev_name,
+				     struct udevice **busp,
+				     struct spi_slave **devp)
 {
 	struct udevice *bus, *dev;
 	struct dm_spi_slave_plat *plat;
@@ -529,12 +531,28 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 		return ret;
 	} else if (dev) {
 		plat = dev_get_parent_plat(dev);
+		if (at && dt_mode)
+			mode = plat->mode;
 	}
 
 	if (!device_active(dev)) {
+		bool override = at && !created;
+		uint saved_max_hz = 0, saved_mode = 0;
 		struct spi_slave *slave;
 
+		/* A flash reads its ID in the probe: probe at the requested values */
+		if (override) {
+			saved_max_hz = plat->max_hz;
+			saved_mode = plat->mode;
+			if (speed)
+				plat->max_hz = speed;
+			plat->mode = mode;
+		}
 		ret = device_probe(dev);
+		if (override) {
+			plat->max_hz = saved_max_hz;
+			plat->mode = saved_mode;
+		}
 		if (ret)
 			goto err;
 		slave = dev_get_parent_priv(dev);
@@ -588,6 +606,23 @@ err:
 	return ret;
 }
 
+int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
+			const char *drv_name, const char *dev_name,
+			struct udevice **busp, struct spi_slave **devp)
+{
+	return spi_get_bus_and_cs_common(busnum, cs, speed, mode, false, false,
+					 drv_name, dev_name, busp, devp);
+}
+
+int _spi_get_bus_and_cs_at(int busnum, int cs, int speed, int mode,
+			   bool dt_mode, const char *drv_name,
+			   const char *dev_name, struct udevice **busp,
+			   struct spi_slave **devp)
+{
+	return spi_get_bus_and_cs_common(busnum, cs, speed, mode, true, dt_mode,
+					 drv_name, dev_name, busp, devp);
+}
+
 /* Compatibility function - to be removed */
 struct spi_slave *spi_setup_slave(unsigned int busnum, unsigned int cs,
 				  unsigned int speed, unsigned int mode)
diff --git a/include/spi.h b/include/spi.h
index f477763bdc6..698ca8c8358 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -644,6 +644,29 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 			const char *drv_name, const char *dev_name,
 			struct udevice **busp, struct spi_slave **devp);
 
+/**
+ * _spi_get_bus_and_cs_at() - Find and activate a slave at the requested speed
+ *
+ * As _spi_get_bus_and_cs(), but a slave that is not active and has plat
+ * (from the device tree) is probed with the requested speed and mode instead,
+ * and keeps them after the probe. Its plat is left unchanged.
+ *
+ * @busnum:	SPI bus number
+ * @cs:		Chip select to look for
+ * @speed:	SPI speed to use for this slave, or 0 for the plat value
+ * @mode:	SPI mode to use for this slave
+ * @dt_mode:	Use the plat mode of a slave that has plat, rather than @mode
+ * @drv_name:	Name of driver to attach to this chip select
+ * @dev_name:	Name of the new device thus created
+ * @busp:	Returns bus device
+ * @devp:	Return slave device
+ * Return: 0 if found, -ve on error
+ */
+int _spi_get_bus_and_cs_at(int busnum, int cs, int speed, int mode,
+			   bool dt_mode, const char *drv_name,
+			   const char *dev_name, struct udevice **busp,
+			   struct spi_slave **devp);
+
 /**
  * spi_chip_select() - Get the chip select for a slave
  *
diff --git a/include/spi_flash.h b/include/spi_flash.h
index 2e703e85250..1109df01700 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -108,6 +108,24 @@ int spi_flash_probe_bus_cs(unsigned int busnum, unsigned int cs,
 struct spi_flash *spi_flash_probe(unsigned int bus, unsigned int cs,
 				  unsigned int max_hz, unsigned int spi_mode);
 
+/**
+ * spi_flash_probe_at() - Probe a flash at the requested speed and mode
+ *
+ * As spi_flash_probe(), but a flash with a device tree node reads its ID
+ * and runs at @max_hz and @spi_mode instead of the device tree values.
+ *
+ * @bus:	SPI bus number
+ * @cs:		Chip select
+ * @max_hz:	SPI speed, or 0 for the device tree value
+ * @spi_mode:	SPI mode
+ * @dt_mode:	Use the device tree mode of a flash that has a node, rather
+ *		than @spi_mode
+ * Return: the flash, or NULL on error
+ */
+struct spi_flash *spi_flash_probe_at(unsigned int bus, unsigned int cs,
+				     unsigned int max_hz,
+				     unsigned int spi_mode, bool dt_mode);
+
 /* Compatibility function - this is the old U-Boot API */
 static inline void spi_flash_free(struct spi_flash *flash)
 {
diff --git a/test/dm/sf.c b/test/dm/sf.c
index 0ec02ac694b..f24457ecf33 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -106,3 +106,45 @@ static int dm_test_spi_flash_func(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_spi_flash_func, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that 'sf probe' with a speed and mode probes a DT flash with them */
+static int dm_test_spi_flash_probe_speed(struct unit_test_state *uts)
+{
+	struct dm_spi_slave_plat *plat;
+	struct spi_slave *slave;
+	struct udevice *bus, *dev;
+
+	/* spi.bin@1 has spi-max-frequency = <50000000>, spi-cpol and spi-cpha */
+	ut_assertok(run_command("host save hostfs - 0 spi.bin 200000", 0));
+
+	/* Without a mode, the DT mode stays */
+	ut_assertok(run_command("sf probe 0:1 1000000", 0));
+	ut_assertok(spi_find_bus_and_cs(0, 1, &bus, &dev));
+	slave = dev_get_parent_priv(dev);
+	ut_asserteq(1000000, slave->max_hz);
+	ut_asserteq(SPI_CPOL | SPI_CPHA, slave->mode);
+	ut_asserteq(1000000, sandbox_spi_get_speed(bus));
+	ut_asserteq(SPI_CPOL | SPI_CPHA, sandbox_spi_get_mode(bus));
+
+	ut_assertok(run_command("sf probe 0:1 1000000 0", 0));
+	ut_assertok(spi_find_bus_and_cs(0, 1, &bus, &dev));
+	slave = dev_get_parent_priv(dev);
+	plat = dev_get_parent_plat(dev);
+	ut_asserteq(1000000, slave->max_hz);
+	ut_asserteq(0, slave->mode);
+	ut_asserteq(0, sandbox_spi_get_mode(bus));
+	ut_asserteq(50000000, plat->max_hz);
+	ut_asserteq(SPI_CPOL | SPI_CPHA, plat->mode);
+
+	/* Without a speed, the DT values apply again */
+	ut_assertok(run_command("sf probe 0:1", 0));
+	ut_assertok(spi_find_bus_and_cs(0, 1, &bus, &dev));
+	slave = dev_get_parent_priv(dev);
+	ut_asserteq(50000000, slave->max_hz);
+	ut_asserteq(SPI_CPOL | SPI_CPHA, slave->mode);
+
+	sandbox_sf_unbind_emul(state_get_current(), 0, 1);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_flash_probe_speed, UTF_SCAN_PDATA | UTF_SCAN_FDT);

---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20260930-spi-probe-speed-1628c684e624

Best regards,
-- 
Igor Velkov <iav@iav.lv>


