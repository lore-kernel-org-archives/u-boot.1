Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD7C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32E9080EFA;
	Fri, 11 Sep 2026 12:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UZezGRYK7Klh; Fri, 11 Sep 2026 12:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3210680ED6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789128379;
	b=kD78eByxtSJOkBOKcP+7o17tR0qjEe6mGT2dj9NknxovobrB4ZKh+rPI67VTADrMNMj3
	 8ZK7iF3RqR+XVpCI+yuf45/BRE1/ZhIghUgExlq+SU0QtetgKFMvpiIOBeBFVjZ8J030q
	 STosyh93VWZkVpEj60qzhm2u9v8V2jLD+y4sFZOSNmvKb6tFiVwIv/DvdbekG9zn+qzFK
	 WJ0lDKxXjjz4kpF4k/3QPLxq4jdSQglEAnYJMHojRwpWYaDvF626Vtojxls3OTJgP+swF
	 Tk++9LNEYXGIePkfNVD0D9Go1Yhi/yp+sqFqcxIHcEHWn/qdkAieuKPYE6eo8qsZpow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789128379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eHxBbjT97HcL1TfB0XA5o6c+fqk7+rJUlFW7PGwWfwg=;
	b=aEQN4OHMmwbab4/ArnXwZeWbNyhHYc19erQ/zaMwcrXRLsY+u5iJoKMiCM3iEtI0vIbp
	 o1hwSNUcIlzh9EwxrsqOma3pmgoJjB3gUXK4j9U1bhuKQbf6mRv8iMyoTJB2Q4KBvCIpw
	 A8J+Jjx8cJiG9bZDNYIUrujYTH1vWbEqz86DpP2qsWV4HQh+ycK4ef+4REee5eqmKLC8I
	 GtQZfpE2wgievHKhP23D+DBxvAMflj43rlUPYuzrQGfvR9I0FhEOHTTP3qEZHJYwQIeEL
	 0yb2Mfb8NgVksJWcQpKwq65KBgtzXNY5A0PMEt/SVN1mqEj7GBXoe4GOCDmDDrsEBDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="c4F/iGk1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789128379;
	bh=eHxBbjT97HcL1TfB0XA5o6c+fqk7+rJUlFW7PGwWfwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiUYHWQIC7lVhcM5bjTg3aYCWa1XLK73EKkRkuwMfE3JTkgUDdlA5kl9b+XFcq8Nm
	 tgINdefm/6M4TWr8DfQPknVYURkHKs48O0s0IqWOpZaKaH0J9u692M63lGY0rdZykq
	 TzpVEMPxRUQUJZd27jMM/bXKr+eSdOyEAEG7QpRb/r7afwf0HEJmUBNxjQcvAJ6Xra
	 gR/pICTu4mVd8FtvKFaVy2f2ZeB0y923nsItwXkFzC+nlxmxWbKd/VZBbpN1Tq8IY6
	 V+cdK34tjLl3roZKsgvMeNDEeSrvnJVlKP4qxHuTdUFpKTiHD/KRXil6Cvr4JZ5dVU
	 NQLOou4CURukA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3210680ED6;
	Fri, 11 Sep 2026 12:06:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 272A7786
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1922E80EC2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOd_BdIeZEYN for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F21CB80ED6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789128374;
 b=mrUudYxDK+UlTfR+5derW1VIkXI7fk2pVIkOo4ROWgz6Hw+tR7ia4p/62MTtgMyb2c9X
 hF6DToftdDQ/jzo9ZVJ7wx6LcpMonxXc8YL9XMrHtRfOL3V5MhymAxhPn2IvH/+2+Ncoz
 1zpOUMiCLI1+wTKLwccZYxsGnb5lU+1iyv05dqZmaH5QndOzU+T+HGdPtdeSR5ZKYJo5K
 UL6kbuEnOf0FMxcV+raMHrR/Wi7TQ7aWl+U0wpuN9vUruDjH1XM97BliRe12FEs2dF0jN
 wBcPudbSdRDDocLXRtcx/hDbpAEw8rrVnOKSiwxWGMDDJ3akirEnctUGxCl9D4nBsTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789128374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=eHxBbjT97HcL1TfB0XA5o6c+fqk7+rJUlFW7PGwWfwg=;
 b=a7C9PYQnyvpQf79W615jrS+XIQ08IhmjZd2vIxwGiWE7ZCvn4B+SIlPLADeJri7AtTbg
 +4fHuyIbnxInkr4BY7T25DsZIy3dlal+VQEv3t/ZlBFFnnliFv70FdS8XCEiaI8JTIaMD
 +XURjIzLMoXC/kxUHDTW+fD0nT+2ETHi4GyxX06ZcHn1AUEV/811c3cYcp0xbY1UDh4Mo
 6sUp4s3gwJ/bY0MOs+SZO3vWnm7qVP575wCQnmBAKvlZuN+2E0KRw9l9bkE8mR2sWOj3x
 XzRY98lZWotwSGJO8IYT9GQNypLaCQkq1trQxxqqNru1SNcqdobrL/2HHOSkEfjfNng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="c4F/iGk1"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c4F/iGk1
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F21CB80ED6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:06:13 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so561851f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789128371; x=1789733171;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHxBbjT97HcL1TfB0XA5o6c+fqk7+rJUlFW7PGwWfwg=;
 b=c4F/iGk1TS9+Z5HznUIrEoykP9G35GuITR+8TTG/G8H6czvuPyO1/oO3a13M27EVxq
 Uv+tzMC2R3UYGA03SaeBQBQeiYTcaJOpQDeEG3FUovAU7ICbsdDiF0c/a1LDDlYSV2na
 qczwuH+EYm+v1mZp8oQlFp4UtKFSFEQTJy1G+uCepc01COh3ZbetmPCHnA8FSyvgskhJ
 AIUz3VuaeN1QTyth6IGf5hBCBVkFazqWsHlQHhpsOclZlrWFF7+f6/LFFnefWLyHL0dI
 dz1oB2kSdIRNBLCpweXccLHnDz3k+fEB9YiCv9ebPc49pBenF2/5oA8qHpcX08pcCpyP
 ubew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789128371; x=1789733171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eHxBbjT97HcL1TfB0XA5o6c+fqk7+rJUlFW7PGwWfwg=;
 b=hXzjb4nteho3ffSvmqRZWKvmbG1Ev9QY4gsz0kgSKg3NHutUT4W1JDeYFM+SJVKa3c
 /j18mC2Yz44TzXHqumFDbl9KrJqgUm8u0o+OTi9KpGA5yKunelwLMqd/wDzC48lIMqCL
 3oYXOjUBDDShpKpVBrzD2DUei2Qq9qndlrqMZ0IF+ckgbWX4oBb7kRuoGpEpKc7/i16m
 2SOl3s4whHlR/ZW+if2ZjrHbdQ7pTgwtQpf/CCI4N0a7exbanficnyWA1t5nr3nCbg9H
 WF5Gko7CDo0fsieFnaUaKsl+Hf/AyiftuPPIlGrt+utyinJjzyDoRPaVm9i31A12WH1+
 rvug==
X-Gm-Message-State: AFuF++lZn5v7aelY7T5JGdRRbwEaxkQT4ZYdLkwZTZgq7fkn7RD3TTyw
 ojXyQ2gVKrcHvEHlSI0rBJkeiAMhqJdjyFc1gHIw0nkoBXhxmhFTMMWOjd45DUM9KN8=
X-Gm-Gg: AYBFou21RlvA9oORbUUfwphCOAijGgzQIfXR9NRAHA12cLYtQNWWeOgz4ax1yK/1VRE
 OW9dzaxj9zDDvxme8O+ch7W/SlEeLTp3gyIrlb9JLA0jHn1JkNkSrFY6WnwbqF1fe6agO47Iz4t
 tzgPqdlYY7Lcfa7fqt8wZEcS/VmXAhm8Da5c1OC93YYJn9zmay0wxt4KRkF8qAYjDaeSLI2JLl7
 0Hg+7rttaCo0bjF8uzArrZKvcuqlz6rofX5uY1VFvOnH20lVljA87BqNxuxKxrVhS+8vRFHnl4e
 UO4oA8H25teDFC29ECJ7AKT+zNvXSMkRDFF0nIuVWz2KKjUsBoc6cI8SvtD/j7FDdOQPnDOwZNJ
 xJtOy7S/x1qi8kREGNfA/QUy7vabgAfkZv0el0NZr+GuXYsLV2kWkJyV4DJau4bvi6xczneW+gt
 NnBczNgATpXSd31P92ICi0ad8YqN1zHsXfZY2oV9nrjH1alklzr/RElbzeKyp0UXYdPWzsJnFUn
 rCf7IV7A1KlhN4cv5ng5qF33nCMSC6Ob3t/LqWysux/zIxqLmXlRruiMqoEiNoB+ygqbupip31Q
 lKrACxr45/K8qus=
X-Received: by 2002:a05:6000:609:b0:485:8c17:9771 with SMTP id
 ffacd0b85a97d-486eb31e7bcmr5008854f8f.51.1789128371485; 
 Fri, 11 Sep 2026 05:06:11 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm5824487f8f.37.2026.09.11.05.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 05:06:10 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 11 Sep 2026 14:05:59 +0200
Subject: [PATCH v2 2/2] spl: mmc: support dynamic selection in raw
 partition mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-ccaione-upstream-part-dynamic-v2-2-295fefc9a3c4@baylibre.com>
References: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
In-Reply-To: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Boards using boot metadata to select U-Boot should not need to configure
an unused fixed partition number. Add an explicit runtime-selection
option within the existing partition mode, retaining its loader and
platform dependencies.

A failed dynamic selection must not boot from an unrelated filesystem
partition. Reject an invalid selection for this MMC attempt while keeping
the existing fallback behavior when dynamic selection is disabled.

STM32's existing hook implements fixed partition selection and references
the static partition settings. Restrict it and its MMC2 setting to fixed
mode so dynamic selection can provide its own hook.

The board hook owns hardware-area selection, including access to metadata
and leaving the image area selected.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-stm32mp/Kconfig        |  1 +
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  2 +-
 common/spl/Kconfig                   |  9 +++++++++
 common/spl/spl_mmc.c                 | 19 +++++++++++++------
 include/spl.h                        | 14 +++++++++-----
 5 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index f45010ddbd0..bea4a1b6aaf 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -175,6 +175,7 @@ config DDR_CACHEABLE_SIZE
 config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_MMC2
 	hex "Partition on MMC2 to use to load U-Boot from"
 	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+	depends on !SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
 	default 1
 	help
 	  Partition on the second MMC to load U-Boot from when the MMC is being
diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index 2229ebf5eeb..c1be468cb1d 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -61,7 +61,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_RAW;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
 int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	switch (boot_device) {
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..9e1c23ea0f4 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -576,6 +576,14 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 
 endchoice
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+	bool "Select the raw partition at runtime"
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+	select SPL_PARTITIONS
+	help
+	  Select the partition at runtime instead of using a fixed number.
+	  The board must implement spl_mmc_boot_partition().
+
 config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	hex "Address on the MMC to load U-Boot from"
 	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
@@ -609,6 +617,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
 config SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
 	hex "Partition to use to load U-Boot from"
 	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+	depends on !SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
 	default 1
 	help
 	  Partition on the MMC to load U-Boot from when the MMC is being
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3e637f5adbd..d538fbb9c41 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -303,7 +303,11 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
 	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+#else
+	return -ENOSYS;
+#endif
 }
 #endif
 
@@ -432,8 +436,15 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 #elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
       defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) &&
-		    raw_part == -1)
+		    raw_part == -1) {
 			raw_part = spl_mmc_boot_partition(mmc, bootdev->boot_device);
+			if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC) &&
+			    raw_part < 1) {
+				ret = raw_part < 0 ? raw_part : -EINVAL;
+				printf("spl: partition selection failed: %d\n", ret);
+				return ret;
+			}
+		}
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
 						   raw_sect);
@@ -468,11 +479,7 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
 #else
 			    NULL,
 #endif
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
-			    -1,
-#else
-			    0,
-#endif
+			    IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) ? -1 : 0,
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 			    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR);
 #else
diff --git a/include/spl.h b/include/spl.h
index 08a84536f51..2877d120d27 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -599,13 +599,17 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device);
  * @boot_device:	ID of the device which the MMC driver wants to load
  *			U-Boot from.
  *
- * Called before loading U-Boot in raw partition mode, after any Falcon
- * attempt. The hook may select the hardware area containing the image;
- * it must leave that area selected. It may run for each MMC load attempt.
+ * Called in partition-number mode after any Falcon attempt. The incoming
+ * hardware area is not necessarily the user area. The hook must leave the
+ * image area selected for loading and any configured filesystem fallback;
+ * the loader does not restore it. It may run for each MMC load attempt.
  *
- * If not overridden, it is weakly defined in common/spl/spl_mmc.c.
+ * The default returns the configured partition, or -ENOSYS with
+ * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC. In dynamic mode,
+ * zero or a negative error aborts this MMC attempt without filesystem
+ * fallback; SPL may still try other boot devices.
  *
- * Return: Partition number to load U-Boot from.
+ * Return: Partition number (positive in dynamic mode), or a negative error.
  */
 int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device);
 

-- 
2.55.0

