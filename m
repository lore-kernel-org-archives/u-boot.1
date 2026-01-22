Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA52D625F9
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE196839DF;
	Thu, 22 Jan 2026 09:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uHdiS0dr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0137183A6A; Thu, 22 Jan 2026 09:58:46 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8239980077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6174C600C3;
 Thu, 22 Jan 2026 08:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9B4C116C6;
 Thu, 22 Jan 2026 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769072322;
 bh=qNUcP6Ov/fqyLOeslJsJLRi/TRO8i4naSJwrTtuVIlc=;
 h=From:To:Cc:Subject:Date:From;
 b=uHdiS0drPaEGF6wT2241iKXPuEv2RW0BAAhrx1sC5S+0PoyfbAKmNArFlHk4g5OEy
 8fxgl9MlfoqHEHr/d+qLh0wOQ8tdYEDzbUDv8QnmzE0pl94UagZG2AHA2J2gPC0Eaq
 PJR+AKN6knGR6V3AQ8d8ctwldqkLYxaExSwAIY+ttT6l3rlk7agZPp6OHowckWUNJh
 dhxzgV+1hsjl6+RLTR3EeyOH0V5Ua85Ns+RPrsEuaybG96eh5CEf83aUjWo8yA3mvT
 Bim0QFvXnH71XEe4wqLiLOfmqmZuFcnTBql++t1749xnm8h3tyni/Wb50drCNuy1D+
 5ZPnsYR/exUtA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 0/3] mach-snapdragon: Enable OP-TEE support
Date: Thu, 22 Jan 2026 14:28:03 +0530
Message-ID: <20260122085806.542149-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Introduce TF-A and OP-TEE config fragment
    
Recently upstream TF-A/OP-TEE has started gaining support for Qcom
platforms. RB3Gen2 being the first one and more to come. U-Boot in
corresponding boot flow is packaged as a position independent executable.
    
So, lets add a generic U-Boot config fragment for Qcom platforms to
support TF-A/OP-TEE based TrustZone stack. Build command:
    
$ ./scripts/kconfig/merge_config.sh \
       configs/qcom_defconfig \
       board/qualcomm/tfa-optee.config
$ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2

---
Changes in v2:
- Add new patch #1 to export OP-TEE message UID check API
- Use OP-TEE message UID check API in order to perform the DT fixup for
  OP-TEE.
- Switch from new defconfig to a config fragment instead.

Sumit Garg (3):
  tee: optee: Export OP-TEE message UID check API
  mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
  board/qualcomm: Introduce TF-A and OP-TEE config fragment

 arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
 board/qualcomm/tfa-optee.config     |  4 ++++
 drivers/tee/optee/core.c            |  5 +++++
 include/tee/optee.h                 |  9 ++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 board/qualcomm/tfa-optee.config

-- 
2.51.0

