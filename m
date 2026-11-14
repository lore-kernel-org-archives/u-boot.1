Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF3606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w4ZhBRXh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKM5LHKt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B872740ED4;
	Sat, 14 Nov 2026 04:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Xb3dPoGc6cP; Sat, 14 Nov 2026 04:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF4BA40ECA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629114;
	b=hmKCP3jLJfNaFnCil8iElNL3nBVNoc+2WtfGnvTvl9bBY5Zyw98ScN8ftLZMjTcatvpi
	 m2/L2x7iIoFPv1ZnXRcI0lVa+XeB4sAu5Gmcb8VVbBUivdt46Z5IH920Dd6EKT9apZcvk
	 aINS5Et+ZSJdGZFD0TyoAQVZpO06rcchfvzDDge3NvOkS9hgfMNePBACfMvb9UF0U8fwZ
	 c/STH+5toAvTm1Le6EOtab94nz/xQH5FxM4l1eJPrhmvHuym3psHjjaO9ag7VToyjkT1n
	 k+0tFx1nFCCNiPcr96PubUtFO3Ah2fyqcxT7D2Ep1fUCxeoHPPBMowNUI8M9vHc6IUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=P9er2Ry2oz6osUtKbZMOmAiLtrT2zxiih9Ukw09znRA=;
	b=h3bcNQlqF2U2xMxsep+iVt1KFy2oHBezMoeQsW32s2n5zwBB1fVVsYgolYCzkAn34iqv
	 jdyGws3g+fPwAHErX/ouxn5+g1WpvegydOAJgQBY+nyG1IavScaSFti6/1OUF69prUS5L
	 SVdrtdvrtjORRwb3Fx9QMW97T7htU/HZTKGgE1c+R5P7wV6E6KE++YLKdbk3v+6IfVuOn
	 NEhgnSYH3q5IBKETDR6sbg9XBc6Tu1RrYZb9FpIG5BCBINMxfAN2nNqvFX/JjOWBwdO3w
	 oLSS9FU7BMW+N+P0aiBH3WgpD9setNFa10HbdWqm2tAJcOEqorkXw6I0OIreI/Gj/eQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629113;
	bh=P9er2Ry2oz6osUtKbZMOmAiLtrT2zxiih9Ukw09znRA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=w4ZhBRXhlILtm3RAfVeS3OJH+EbQd/EV0f8WeIeCWXWvSBh8EfRC7+HcZy5IEpupF
	 5IMJxeGuA2jXVrtfl20sb3LY4G/4PeYvjYMq0+Pqf9iF0pQ5jeYCB6J1aVFW3N6wX6
	 picEjwy1kYfxa0C/nGlAxDmGQ+vqn4wQHKxWbvknRifXU+4pvLwFRNd6TfyLrQ82b6
	 oS+AbcuI43s7qBDkbo2+LktrIUxnz11fV+EaI7tsHLyswwEIatcGSA1Nv7H5XLW2GD
	 Twyni6RGmSt7u0qB5xk4lDlHlqqDD544W60ZQzgbaWXsu4ItxZtRPdDE/2Pf+QVvIk
	 fPHkOtzXdysRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF4BA40ECA;
	Sat, 14 Nov 2026 04:05:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AD552FE
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D1CE40506
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vAhZOYc4CSd for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 930A14025F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UKM5LHKt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 930A14025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00728463E3;
 Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E27421F000C4;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=P9er2Ry2oz6osUtKbZMOmAiLtrT2zxiih9Ukw09znRA=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=UKM5LHKtTdAk1s1ZuhzYOhekV/3Q+7J6FA1xfGW058ZuypiKrEMse3h2dTqKZMJNz
 SqpiKqoEieeQTUZDYIKRKekshL3PicNDj+L2zZjnHLAWUP0HPAlAR5nooIca7tWShu
 6lBKE7rD37bxifB4biOUlWZ9WfJET+aLJ+2MidaQjhj9APM3B47N2ZgAe5O3qh+9c2
 SAbir3vxgkrNE31gDu6Ut2KgvC4MgBxaB18OOrYmO0SBr7D/snyLi0B4Ep3MUvu12t
 KBTCXdZ+3RUYFnHvaHyomZ364qZufHAj5tCAS/lC7Zva+vCfO7pMioQMRhLcQXpGx0
 vlEgE13aX9U0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4040F49C23;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Subject: [PATCH 0/9] Qualcomm SM8350 support
Date: Sat, 14 Nov 2026 02:21:54 +0000
Message-Id: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MT3eJcC2NTA93i0oKC/KISXUujFIvkFGMLMyNjYyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgD88cxYcgAAAA==
X-Change-ID: 20261114-sm8350-support-92d8cd386233
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=2755;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=V7Z9MNs4lz2ZkPc5+wizpyhZZc3+q5IUGdEJ9guSD3E=;
 b=GUMj3q9aRHN0LvBY/OGUJ61soVOoVBqhfFfFOZ46HzOuxw2yA5oc04nkUHayocuGOpY45bvNj
 laRV3uPH7WmA2DNYEbO59coBu6CxbBNSJvE8XT4Vux9e/4cYdLKKCTv
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This adds the Qualcomm SM8350 (Snapdragon 888) to the generic Qualcomm
target. It is based on v2027.01-rc2 and applies to qcom-next as well.

Patches 1-3 add the GCC, pinctrl and interconnect drivers, limited to
what U-Boot drives: the QUP wrappers, UFS, the primary USB controller
and SDCC2. Patches 4-8 add the SM8350 and PM8350 entries to existing
drivers, and patch 9 enables the new drivers in qcom_defconfig. The data
come from Linux v7.4-rc1.

Tested on the Razer Edge 5G, chainloaded from its ABL: the console on
the splash framebuffer, UFS (HS-G3, two lanes), USB fastboot and the
volume-up key work, the SD host probes (no card tried), and Linux boots
through bootmgr and systemd-boot.

That ABL takes only boot image header v3 and resets on the Image
text_offset of a qcom_defconfig build, so the test builds set
CONFIG_TEXT_BASE=0x80000000 and carry the board DT, much as the patch
"board: qualcomm: add Moto G10 configuration and boot instructions" on
the list describes. The board DT is not in Linux yet; sm8350-hdk builds,
but I have no HDK to run it on.

---
Demeter Barna (9):
      clk: qcom: Add SM8350 GCC driver
      pinctrl: qcom: Add SM8350 pinctrl driver
      interconnect: qcom: Add SM8350 interconnect driver
      clk: qcom: sm8350: enable shared RPMH clock driver
      gpio: qcom_spmi_gpio: add qcom,pm8350-gpio
      iommu: qcom-hyp-smmu: Add SM8350 compatible
      power: regulator: qcom-rpmh: add PM8350 support
      phy: qcom: Add SM8350 to QMP UFS PHY driver
      qcom_defconfig: Enable SM8350 GCC and interconnect

 configs/qcom_defconfig                        |   2 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-rpmh.c                 |   1 +
 drivers/clk/qcom/clock-sm8350.c               | 281 ++++++++++++++++++++++++++
 drivers/gpio/qcom_spmi_gpio.c                 |   1 +
 drivers/interconnect/qcom/Kconfig             |   7 +
 drivers/interconnect/qcom/Makefile            |   1 +
 drivers/interconnect/qcom/sm8350.c            | 271 +++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8350.h            |  25 +++
 drivers/iommu/qcom-hyp-smmu.c                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |   1 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sm8350.c         | 101 +++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  30 +++
 16 files changed, 741 insertions(+)
---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261114-sm8350-support-92d8cd386233

Best regards,
--  
Demeter Barna <me@fromdisposition.org>


