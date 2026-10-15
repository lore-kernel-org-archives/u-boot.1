Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF3ACC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D4BA80E47;
	Thu, 15 Oct 2026 13:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3ssTEme_9xa; Thu, 15 Oct 2026 13:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9442A81212
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072523;
	b=Zi/CHDhrZ6p8pcIQOV6i8qS88R6EBXQ5x0T+6WK9FT2pTtp1pw1Vowg8znrurmBl9oQT
	 gGWRVFkJyTiliiW/Ix9bAmbTE91qeTQCNADWUOiz0XuJmxRYH8nrhSV2jQxkXmSWspKQh
	 COrN9ZPHMJzlff+lwGSTNuiLSAdjnV+3YblpT4spQfDdyWJicyJWUJQTs4iFLYy0PNDSx
	 wQ2/1xB2REXtQOsMHlrwwJdF+n9ADLsVgjc2Xx5HhMT4wHHzNBao0yQf2OBlnkRtUUzTP
	 uleY6GjQB9kRwK2oSd4sUbY/cn5dqvRYyaLEMIyQVhwDSOVj4k+OHKhE3Q3V0rHNgUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=51xIQ0nESqyq1vcBMmaOen+8eMuqkd8Emh/zaZSNQNA=;
	b=LXL4p28RAPbBas0a6PM/0YZTFbxrV24PBdt8CpmrV4LeCBy6iZHGUelRoYlpsd0LK5L0
	 fIdA7T/BBR7YM8XaW3t0uVQhiMJpugzpA1d3cIXwaejnf8MKvSmrCa6sfbTW7XxZpdRaf
	 ZTOzpAy9YejFY5Lqazts1olNDJDko6kbJj4jjALrXI+UwViry3GF1X6EHkCv0C4VIKY4K
	 drxmaYfX4zGvgAGQewThJCb4BW+7YBV8Vdd8XXfwJVu8GcRdp6l0t9r89xP9H5W1ZhZMs
	 8G0H0ZkagJdULG81M+R+4CWsLloT+iSclFhg1BU9hlsj56B+aXWKmULCNngPi/ntttQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072523;
	bh=51xIQ0nESqyq1vcBMmaOen+8eMuqkd8Emh/zaZSNQNA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yTLxZpQioAARZ2h2voTXmvmX0M4+kSiX8Qc5ck7LmH49OukbxErpiz3kAF8+TAb7f
	 u5QcpZ3EdFmaW/2XknpPPGK8CQn0ljfNTdDpfAJXUMi9l/gN41pKcDuUete0Tel6Gv
	 +pBhLBv0OGRAxfz9N/K1PFLqJayAPxqxcjcinbcWGi4al3ZjJVS1cu401oXRz7T3UY
	 vB8p9t6qKyL/aRQMAdoPNccoB0maBzyhOQoTxsVBs4a/jnL8sw2po/qvyW2xe3n1Dp
	 tb7XZ3p9eKYcmlJ6wgictmwMA2mMeEIBK/WyyJ4fP1/H2RsU1mi5rjwpVgCKqJRi18
	 hHkQmoZWQZgZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9442A81212;
	Thu, 15 Oct 2026 13:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1C8A2AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7F71403B0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5RSficM7uqlN for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E5C8340098
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072518;
 b=Uq1wlkg4xsUU0lr9GG6jNhqD2EX0drIbzkg0Q1N+ohQ3l8k4OtxrDmiVk6iKzlia5P1P
 itzItR0wHx4MvZbAoTRDtZWaIgV+oz+ABF4g+AShqNHBxWbfN8lRBmDR8iqpHD1rQ99+i
 yzLoXBQmMDJVeX2Y+YSwxFcF57Q4Iu/0QPhE4ZDTH5k27hQweDSUmM211u86yj/yb8zv7
 GBtQbjSbk0yS2M5G4MvqZkpzsGAe9zta+CH8+fQ3sAtCy9vIxjJtJYmDZiSG6u30xkxJu
 9tymAhqxg7GADQ2SRUUoBuj+44UYyCsfoD2qOfpNW4pEIwXCv67wkKmQAC7/zyJ2PZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072518;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=51xIQ0nESqyq1vcBMmaOen+8eMuqkd8Emh/zaZSNQNA=;
 b=V7oIcMS41cwHMDT2Cl4L7AI9gu7zVZ6g24TZU9aMray5JBzpi0MT4Wd03tulUxi038wl
 6HBlmXEcWQFr+YWDhufPMlkc4pL83tXMIlVv303ocDrPTTe1kaJWbyGe36SVFVM6IshA2
 e19GY2jlZo7G3reuZxAtg31sWfUAVzOsEOnuUlnGg+6DxhLWIEZHcR1zk+VFaEOrSg8EU
 kUtOwW8vmb2VSol0pS5uG2KE/d2DVS+nnIssQZRMyoifySx+r10MC+FROeqIKHsganrBG
 U0i7ikvy+KaHfQN5nyzP3jWzaBxfRSqx4VRw25FFKtQj1cUOOpa/qA1p1DmgIFFCTCw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mH2Em7vf; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mH2Em7vf
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5C8340098
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD16E60200;
 Thu, 15 Oct 2026 13:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2239D1F000C4;
 Thu, 15 Oct 2026 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072514;
 bh=51xIQ0nESqyq1vcBMmaOen+8eMuqkd8Emh/zaZSNQNA=;
 h=From:Subject:Date:To:Cc;
 b=mH2Em7vfmV3Pvjt/25E0HRLU6W2I1w+gDc+b06WEMOyQ7lK3jgUL9wjWWr+r8FoNe
 MmRPTS0gvAnsRSrWGkP00qLWJGCRxqoyd8i8+ymwyVSf21GlciCAdNnLHYr7T3wTXR
 h9TMhRs8tsxoLbcois9dzJG1e/LfgmWWMU5LnlD1w1MqUytoUNr381bkLrPZG3brdg
 Tzt0uOm9PY2p0A87xBrUijA9JOIlu9xpQE0vUq5H4i02iwcOX0Q67QbROoRUFNzuDF
 BFCqJo0Q+cuDzMt8zwaRi3v76r1tIYgFJiVEioSs0LVu8HG9i1of7Q0iLW0saTJlSS
 HJE+1h8gUvZUg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 00/10] Fix AVB pytest suite for sandbox
Date: Thu, 15 Oct 2026 15:54:50 +0200
Message-Id: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LTQqAIBBA4avIrBtQ6ce6SrSwmmo2Fk5IIN09a
 fnxeBmEIpPAoDJESix8hgJTKVgOH3ZCXovBatsabRq8SW70acaNHxLsfd06S0433QpluiL9oTz
 j9L4fnJhEKWAAAAA=
X-Change-ID: 20261015-test-avb-fixes-9a4682e8057d
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=kIro3KXxLmxu4SUyEdcqGAq+iExXJ2+EloZ1RSQ0le0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns+rM0evKwBa5tcCRbIROj+dZQBYj6b93GsC
 qJgDDJM8ReJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPgAKCRAZDR20Zk4Z
 NSh5B/9sDsp1hy34YEFMdb6ubA6HKc6tSLtVaxTRgkQwNyXIV1yBOgvoR2cI3dVfOB+mnV5yFNP
 3DNoOq8+xZVHQ6WW3vcA/FiPGVKKjRSjG5OLq8rxvQzP5klqcWuLx4j9DFM6t3NcAywrYEwKsx4
 DsQCeoVVk4hqzYCMdmQdH62izeH7XA2pRbSm1GSqIgJFFS+wp8hW5bBknlzPHaI9bgJCDDfucEF
 88dQNS6iKwR6QWsJAbQphTag64PlmPKWmC1en+3Rt8FeJSN1HHKfrXA/YXm0sZjFLe6H/gVMTDH
 jCfcj6KEy0SVYZ8ngYBNA/LfDrd4O/4pPYN5sD5LwDPfOc+1
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

The AVB tests have the following limitations on sandbox:

* The mmc1.img required by sandbox is not created when the avb test runs
* mmc1.img contains a Fedora image, so avb verification cannot be done
* The tests silently pass due to bad usage of string.find()

This series improve the test suite to have more useful results on
sandbox.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
Mattijs Korpershoek (10):
      avb: Use map_to_sysmem() for flush_cache() address
      test/py: android: Move android image creation to a dedicated file
      test/py: android: Drop verbose printing and unused return
      test/py: android: Use for loop to create the images / update disks
      test/py: android: Add create_gpt_image() for image creation
      test/py: android: Add setup_android_v{4,2}_image subfunctions
      test/py: avb: Use format specifiers instead of str() for mmc_dev
      test/py: avb: Move mmc device number to a pytest fixture
      test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
      test/py: avb: Fix find() logic when matching response strings

 arch/sandbox/dts/test.dts                   |   8 ++
 common/avb_verify.c                         |   3 +-
 test/py/tests/test_android/android_image.py | 104 ++++++++++++++++++++++
 test/py/tests/test_android/test_abootimg.py |  77 +++++++++++++++++
 test/py/tests/test_android/test_avb.py      |  70 ++++++++++-----
 test/py/tests/test_ut.py                    | 129 +---------------------------
 6 files changed, 239 insertions(+), 152 deletions(-)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261015-test-avb-fixes-9a4682e8057d

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

