Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16816D2594B
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E9483F8A;
	Tue, 27 Jan 2026 07:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zq5eaq6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B9983F8F; Tue, 27 Jan 2026 07:24:00 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E956E83F85
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CEF8B60051;
 Tue, 27 Jan 2026 06:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560C9C116C6;
 Tue, 27 Jan 2026 06:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769495036;
 bh=PU40n3cpKwbu5yQEM8G/gAoSDcpqgncvg/6GbVTd5Jo=;
 h=From:To:Cc:Subject:Date:From;
 b=Zq5eaq6rx0mk9YezPSWnBFFX1GwchMfGVKmKrHk2yy9WjJ30eoDRUFpGNWcVdwOp6
 xnztL3bgxLMFmXjc8ljOIad6D6WnXWwza+KXdVVCMLKwsMAQl8k0u7U0poVunQ1zPl
 0L/scJai0EFtt02gPfFHWqtjkT3Xital8TTyT0hE4CdFfGZpU7Le30ohoNeq4BP/8b
 ohhrFiRKoMWak/qcKN1NrMdL7RbHisf9o2+QuDMyB1xIDNdSN3/b9HUEmBG0sL4jv0
 6TyaC/JkcCqhbEz8LcCUqJuGdkCtmMgd7B/bYQWSsrfnKGhhenGDWDSTqVGKoCtqPC
 HKAP5cdt8yJYg==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 0/3] mach-snapdragon: Enable OP-TEE support
Date: Tue, 27 Jan 2026 11:53:38 +0530
Message-ID: <20260127062341.723966-1-sumit.garg@kernel.org>
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
Changes in v3:
- Incorporated misc. comments on patch #2.

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

