Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6806ACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09C1B40761;
	Wed, 14 Oct 2026 14:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KsuYeX3bbjaf; Wed, 14 Oct 2026 14:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C4FD40755
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989257;
	b=MjHRrx4HLU7t7THA7VMVSKQfI7F6chS0peD+TB0BOrrqpMcoQ3/BNNKnpMJ45imnriBj
	 Q8t6vjUHwQuRIwHqyoD2XANsp3XUTdhe/WCULS20rldl4e7tlEKLqnYvqYJmZX+KvCaON
	 12gc2PUGZztViBw2jhJhUizkCCLEILqzRQTbod6UNDYUTyi1SLsdwZg0PbVk+sHLroNYU
	 ZSArQV27jP+zYhdpIr2pNfbAdks3iyyyEtwvReAi9olGSNP2DbDp15rGhoQR5WKXBFDEw
	 3wbZKytaZzeuxabFGomwxKXnMcdWtP/PRaIenJaFa4vsDLNwmF8EtzXdF+OmKuALrow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KzoLG/HL20p4DN/j9odftMOKSn4jDtm0raBVFzQrjcc=;
	b=KC3UkcaxiuLGbyDvjoIsnmOBXo/VQ9xYhy0H1lL2h5tSJi2lb+NEkqZs0dKVbuP8aiKA
	 tib+Sdw+KYxKP45OibmZvXyBFh1AQY96Ij2mQjlAsJisJOVJucTxyentQ2HE1SJysZ4LO
	 QK0BpqPt57DwxE7W4W/gImW+EGpl0wZekU65RtP3Oas5z2+e5t4hn1vsIToN0nnfF760z
	 d0SDDlpgYOx1hK1ycFGPGj8hEBoeeMP1iVEmd9TRJdD3BfA1Oy3KRd5/TyvFzMxbVQpfH
	 8PS3YsByRwvEqoUXPpAkU/KO/QBj3SwM4OmuPtcvYDjszfhjGix9pg7g0iAWBnSyObw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lA+eqK2L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989257;
	bh=KzoLG/HL20p4DN/j9odftMOKSn4jDtm0raBVFzQrjcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tKY8mVrpupHIGVlIZThvuGjP0kFHm0DpFj4QNNxJWmJ0XpIgQmSwc/ulrXUCCh7T7
	 AFAeZM7u/eDOIXGbx7ihwfI/0Y9t5sVPUo7MVTp2R09X1YCB4KnCHPyk5jkFSY4EIq
	 1Ug7qsomGsnWlU4Cyj9WqdkB7AYvLFxXjwwmB2UJ7T20aw0/Ot3BUHr9jhVUHh9V+V
	 rVqDaWpxnvSz4A8Haqm1r/kxdaymUR6Et8JGkBZENUspPxEGfpNRHqK5M4PQT2iONI
	 8wLmHVs1xB2VCS7YaHc8wnR+Qm33vabEZLqLesxTGQ1zXhNGlIuka559eGQbitVCgS
	 z3qd54F/4C6ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C4FD40755;
	Wed, 14 Oct 2026 14:47:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D80D1255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9F7540755
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5Z5I-Fmj5d0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF15640752
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791989254;
 b=Md1tw1U+k9jw08kX79URdGEHQy+/n9oEZfDiKmtDSV2Q2c+/acxwzgcsDgJdRjh4vxxX
 b/zH8QLWgf0Tc99rY/o+dzBYkVQhCfYb6Au71iP4Ji6jUJxHzgQowwBO+5q05FihmZe+9
 L8Ggd8MGtsB468e5KbNaQFwW+60spJz5qL6NpjrVjQlLAdhEgJGM1wDlxFCyZNznXaFN3
 VNKVGtolROiHHxBfRmv96UflgCMoyqfgpXYvmgcuZTpLWfoYtc7VHoDrox2vmcSQ1gMkB
 GUdb/i3ofdKzGzpur6ai+h2sjdIdR0aSMngWEIPg3moeFtXt3Au5HOODmZ1GLu0UVAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989254;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=KzoLG/HL20p4DN/j9odftMOKSn4jDtm0raBVFzQrjcc=;
 b=BYECDahmM8yi+isqAxILe8oPJqqz0YpbiuwbsElUjbDG8DK2gUFM4xUMIVWfDGC/Z5zs
 8ZUjCqt802jsJsZN87aCMJxp6XNs82jaayL0f9GIkcBbADfhaVuaXmk2ME40EnVYfpSY5
 5AxI8PxAqoqSNfRiLglKQczgnDkNCF79ZFgjpnNMBB7L5spI0wnAfDhqGrhUGjuydoX3b
 WkcWx9WGaGHvtEqLIfSP56lDlyjhKlzTY9pylbKl1ojSts0BbfYmbpvfvBpiNHS/0SyHO
 rt7mhdViQo0Oflq794YSfz1h3oTy+1QOdqsMCYqilFUnV1b0a+s9HG3/QS5CdMq3VpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lA+eqK2L; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lA+eqK2L
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF15640752
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:47:34 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-14394530ec6so3237959c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989253; x=1792594053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KzoLG/HL20p4DN/j9odftMOKSn4jDtm0raBVFzQrjcc=;
 b=lA+eqK2LPPpBUzVrqb9ULy8M2K646o//pD0hQ9iKJvReZ0SleC4/MwPGKBlaSBSipY
 NgjtYM2wFjCHMbXa3E73OmbQHToqP4XnVzhkXbn2aY1PIv5nqIRtLElq2AqQ3FGr1VXP
 chyBu83Pq7wFAc97NJ92bsulJlBikDEVoVcS6IMlyvCfxWWPYVqKuIf6BEi5QkQm5P/D
 +BxyHViy8p1tJyj/3glBLzKed3CKQLwW1yEFKoOsXUcU7GhQsGf3jnjCszf8dwQcRxkR
 hBtC+RZ8DiWe1/IYNFVkN/iz2OdvzhQSEzsjGGCssK87M6aOPv07G1o9KAudRSPH/AaK
 eOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989253; x=1792594053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KzoLG/HL20p4DN/j9odftMOKSn4jDtm0raBVFzQrjcc=;
 b=zKffh1lpu2BQyDWsG4DPHfEMut6IwhaCq2fiSNNuFdL9J11/5rRoYAhaVTpPNrIBaG
 reYFf+MuFjLWktksCQzVvTib0lWdfr1zVtS77NSdBJFIyUqIojbVI04JUs6PkZOuMVvx
 9TwZ+e4puVk/tTTxzq/DlnMMeKWKz1vIYfwoqna+151WwpuJGOkt3UYZlGNMekd59zFm
 KVFTYRaKQ4Rrd8rz3IDByhXdDbVu+BQblc09azGN1g375yY+kVLz7gi9wK4e1sGH74ya
 kECHqPPayDxmlVcTZ8X9iw9MEwfbC5uuGDlkF5OFkP8r1WqvL00K8nATLgG7bpCGdWqp
 bBqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxJkSTYDhLRabLhxw2CwOydHarD9AqEeDHYI9cjopij0lEqjzS1G2BKVfu3aY717aSyIcnnOE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKPmvblr/18N+b7y12vu+AFDcazP5HD0TA7HRrJ+PrnH20QCp7/
 d3DG2RTS5/byKQ5xfX4Zjt0VBwQwDS+g7OosamSWAjuOeiyMeeHo2B8X
X-Gm-Gg: AYBFou26PSUI8gM3Qt7eSigTY2fkgVNhwQH3UFBnv3W/MvOMdSWlJVyB3e6aWO5CZZr
 yhn+SmT9ikaarHqR6Qv7z+fQx5KBLJEzrbMyEIrSCorx1vmu0ScAyHyh1nCZX39/mL2hOsn+4wr
 XabLyCBESjpWEESpdir9kS5fEHjZpjx+7KIqh3pok89FZYH1QOmG2uiHucZ4rDJQsZFMOWbDgsu
 fsoszFT5B2gkpk39dHrvrZJiQbuE3Leqrn+9N8GIjgXxwUHzfABuVP7h+qAa/nU9TTyGiEaY2HQ
 Po81vC1Gggh/iDKpvP7Upijl6iXOM9XIQ+RQOAmg+SAY3CZIcpNWwNUIwqgYcPVsG5bFVDHBWK+
 Q0mDIDPshsz0MKflZ3rxJJ5gflajD0skRkm6hEtQ73B7/xaRJ1U3ya+X3IrYAdqH+ncdTofHcKf
 XcVPBAX04SNyI1MBgMvkskcPlA0adKEaFXJpn+bIQpveYCksUXhmkzB8uDZWF0Yn6LR57Tmqdqb
 LNmoQRlUAWvmi4UjO/arNfA8HVdgP4e8tTZRwOlzAVuZDAyzfXCmbX3Ug7dNBZ008igc7nf4OyQ
 AQi1FuhAF7iucN1RSTxqTTqoMvCdTbJ+yYZXZ3CTp2Ru5w9fwx0oIQ==
X-Received: by 2002:a05:7022:7e08:b0:144:fa58:95d8 with SMTP id
 a92af1059eb24-16a61a6ebb0mr29889036c88.27.1791989252859; 
 Wed, 14 Oct 2026 07:47:32 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm44840639c88.10.2026.10.14.07.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:47:32 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 1/4] cmd: Enable qfw by default on QEMU RISC-V
Date: Wed, 14 Oct 2026 22:47:21 +0800
Message-ID: <20261014144724.1763675-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
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

The QEMU RISC-V virt machine has an fw_cfg device, and when U-Boot runs
from pflash, QEMU passes the files given with -kernel, -initrd and
-append through it rather than loading the kernel itself. QFW is only
enabled with ACPI today, though, so these files cannot be loaded.

Enable CMD_QFW by default on TARGET_QEMU_VIRT, as on the Arm and x86
QEMU targets. The existing "select QFW_MMIO if QFW" in the board
Kconfig then picks the MMIO transport.

QFW brings in QFW_SMBIOS, which selects BLOBLIST, and SPL_BLOBLIST
defaults to y with a fixed address that the RISC-V SPL configs do not
set. As SPL does not need a bloblist here, disable SPL_BLOBLIST in the
two SPL defconfigs.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 cmd/Kconfig                        | 2 +-
 configs/qemu-riscv32_spl_defconfig | 1 +
 configs/qemu-riscv64_spl_defconfig | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e36406b64..f8a471c3a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2599,7 +2599,7 @@ config CMD_QFW
 	bool "qfw"
 	select QFW
 	default y if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
-		TARGET_QEMU_X86 || TARGET_QEMU_X86_64
+		TARGET_QEMU_VIRT || TARGET_QEMU_X86 || TARGET_QEMU_X86_64
 	help
 	  This provides access to the QEMU firmware interface.  The main
 	  feature is to allow easy loading of files passed to qemu-system
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index d1c43575c..790bcb72b 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -17,6 +17,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
+# CONFIG_SPL_BLOBLIST is not set
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 04dec72ce..5c1ced65b 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -16,6 +16,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
 # CONFIG_BOARD_INIT is not set
+# CONFIG_SPL_BLOBLIST is not set
 CONFIG_SPL_MAX_SIZE=0x100000
 CONFIG_SPL_SYS_MALLOC=y
 # CONFIG_CMD_MII is not set
-- 
2.43.0

