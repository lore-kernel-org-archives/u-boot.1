Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0891CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53E8280E56;
	Wed, 14 Oct 2026 14:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJcX1y5bJC0r; Wed, 14 Oct 2026 14:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00F9480C42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987471;
	b=oDKRF5AO0G6UsBgqJ2RG/SQ/m4jZeHJ2Ud78HNLDaBPKX0HyP+N+NTGEzgp9d3inRVST
	 eKwG1/eIfQMjqf6lDUjLEY8y3t4JxkFWbR5HQZ6qGlSQ4+Vh2/uuzYuZLX5G+/uxt5RxY
	 ilFesJfrq49taEOjp+2dlTr5AuQGX5q5v4egv73/TE4NpvuTu1r/UtBP3uTvqKTZLhlvm
	 0zSR+PLU91cw2GPm4IL2Hc2Fp3x45Wy6abrBGp6QP6lMsNk+QYHIPZALP9MER/EhhZdp7
	 LOpwTiUGX7ecnGesdArGoTK/U2HHdOT6Dq2A9w7HAMFJwAgqtpptJacY6VXoJRN0zng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kf71ZTTJP6r+vb1YBCZOtf8aUcCAVD83lvlsCHWgDfs=;
	b=rEkKfIBDDDNfnTT6qeH3JQoNwbrlLeowPmtMxTqTa6Qkw2jA0Rk4rRwKSzc8Q8ywV4nR
	 35vNq92m+ZP7W4UrdKuiPg78b9/CEcNJv80yIkFaAZ+XIqDQXhn92jV6/oUWIIGqMwN+i
	 rqdpxdlyGrcGOddmhgqIhPGZcKO5dX1wh0jI8wkl497PnqfH4WzkbQTixxfMtRbaXCO7W
	 16vnSyfQ7+NsKiqhRRAKVGoU7jHmor83nInAxEtpITXvfauIhMuVyuzfaFj8jLHvkncC6
	 wY6dt/LV92qMbyWK2sJiH53HPt4COBoh3eHZX1TDWu2AGSY/mE6F90r+7OI0MbCGRGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987471;
	bh=Kf71ZTTJP6r+vb1YBCZOtf8aUcCAVD83lvlsCHWgDfs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sob3Q7kLPLeZG9ESeDdAzcWaz/1GcL00ZMWXixqrVwtYx/vwnb8h/PIkkut57G6RY
	 8R3PY/QHmg9LSMDRX3b7fV7VooRRcvKbU5J8T1TVc0tu7sqVKQY0RDtbbzoJ4RCE7M
	 dVHthAcqSMH2eExh76zzY92MFPki0W3zJ7qjJ4oIWU+Iub3k/0S22j9pmxEmPzc+ga
	 VnfZrudUEfV+uLfts5VIe6QG57IdojtdGqxEC3N8bLW8CCSJZRw9hsObnYs+isayRH
	 rT4mDIbxmoZnDWmfCHX6NkkfZMAX8Ygyp0VzALj67AZVl4h/fQ3F6/oSue4ev4X43K
	 LTueI2pGmnIYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00F9480C42;
	Wed, 14 Oct 2026 14:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D3971518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F1C5400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRXwL27qvt_P for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B35B140063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987467;
 b=AvboB/TFBOeXqDslB8rOZH5Og3aOciujZPf2N+3GSukGLl6YEKyT3FOETmonEc8bR7Nw
 6a8PqI/tP4VK4u1+GpfaQdPmermT67by3Qr56xV6MsUh9h+RnrGOqBd8YenkdnY0vt38Q
 TyMQO+L4oiDEAaHkntN87EwlpB+lXUjClwfoHKcLJlEiTUX6LddtITsbYHcMGHVxTMZxy
 YrmcO1lEwxSVQ2ltGCEb8ZhKdN3aTn1Nc9b5ft8QjIqyoOz8b9fE8tbV6+VbzTyeDskMJ
 t+juakk/dQvbo03oC3/pZmQY3gG0lVgB2cV0Q2GcN291CRA5khyYmhwHBQjx/6UQwBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987467;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=Kf71ZTTJP6r+vb1YBCZOtf8aUcCAVD83lvlsCHWgDfs=;
 b=hLYtKnXXwmrWgwOfOuORFhOgBZDiBrp01bQvmWSdehqhXvVVhOCN/jEJrHzfQB2tHaVO
 bLffzFiVWMIMU2VXgncWq/fQ13DVUDGEH4FnVEmpY2JWJImX1oNSpf7Zr40c6Vi6nU6Yy
 GL3nY4fvxxpevbSVgs2u7xQcPF9zxkOPwYnUQzxi5Yk/J+nGwWzSxvBkdTJF06FFmPYW4
 q6HCB+pceaU5sqDZcOZ1gpuIumFrFY8fZzrZkCNjKxvRo8+eCjRILq9ZHAgnP8bFwK6co
 PFJos1ZbUxf/I1hVn+gJpT1bvSHRQa2B5orOnTtVvpUQsHdBHi1/X5F530vssTehYSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b="wB/uKnuR"; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=wB/uKnuR
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B35B140063
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987468; x=1823523468;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=9qjgZbbnMi4cDu25SHo+bJbn4olvUErbCwz7vQYi9xw=;
 b=wB/uKnuRTiWrtsu5YcalxGc7OeJti64x1ykbJztrcGjIMzvgKGwIgKkV
 H16Qlw76wzxA0sJDFGF6JQCHpZg6nox3B4x+HCXiLooRWdQ/8BkU879J0
 shtwV8W0/LurZOQPDyump8d/CU19Giove4xUQyOTLpsF54psAdURnkVsO
 OleKdsL9WdeZMBbC2jWj8CckuYSPyFbr35ZvpPfalcKnJGnl0/Z5fW/73
 dMs73DEDAdcJXuVt2csueeIdeoFhwCDwMTRhZp+5b4F3891TAEk2nIBT2
 mdJV8uBMDZEulRjULsTvLco2a6nJrT2t36OJ5BxiXinvYFuY8CeaupMdd w==;
X-CSE-ConnectionGUID: mONI9iIhSTKGOkn2Z1mqQw==
X-CSE-MsgGUID: 3c4UAZKTT7qtzibrEYbMyQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="296448570"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 07:17:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 07:17:46 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:42 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:12 -0400
Subject: [PATCH v4 8/8] configs: qemu-riscv[32|64]_defconfig: add RPMI configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-8-d53d34a49780@microchip.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.3
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

Add support for the RPMI shared memory transport and RPMI clocks to QEMU's
M-Mode defconfig for 32 and 64 bits.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v4:
 - Add this patch
---
 configs/qemu-riscv32_defconfig | 3 +++
 configs/qemu-riscv64_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index 2801e0b216cb..9ab43adb0971 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -16,6 +16,9 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SHMEM=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index a32eb95f2973..50aa0a18c059 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -16,6 +16,9 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SHMEM=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2

-- 
2.53.0

