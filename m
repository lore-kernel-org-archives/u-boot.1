Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E10CA5FE6
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 00:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED94D40E02;
	Sat,  3 Oct 2026 00:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmYmjEDawZHx; Sat,  3 Oct 2026 00:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8FA9840E09
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790987732;
	b=oNAttjUP8duJXZFjTRiXnyk4iTb5HVbQqg3lcYzGSPEfMtEbkGrOR0SZG+jBIq57Iajx
	 WMpyEZrJM9UyNOVUC1OCLbdoWc5IlSsrY5b6XPPgsl9q0Zyzo5jGZZlqyR2RKPJ26/OWX
	 a07at7BussnfJzAXwOB7GH+L/es9ShvntnrAVZD6rSWzFhHZKo5YXivrbikODs84tdVXr
	 6rvJQXaIoLLE64fJw9OXiFSdx9r+pa6zfYHK9tGhbJVq3tvwb/8xuNTac+qOyNrNJCX4q
	 E1eI3NUW9vW4OCJWxhsvcIoQ4kq4V7WLxU9aoQl9RaFsJ2J6Dq9y8rsHIPgatzk2J5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790987732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u5cpvw7e1SvXrtCfBRvTH2z6P0Kf0UAFhM5Yq9FMrNA=;
	b=lT9NwuC8oY2emiuTcU03lGYVZQgLZ2o73eEV68d3E0kpHy8/jfHKJXnIThvRzZyDy1jE
	 7SPwCVmAjIQsaAG0uWTOTL+XwP0ZJbCGJn0QPUzZYa/g+Iq8Tyk9oUZozu9E+OVGScv2E
	 husQ0ylsK3Wod+pzlVpiWSxpXZjb/QSl0vhRzrJVTwFkia6HubfxU14KSAa3zdDM8RJpS
	 lRJQVRIV8zKtLsfdqwK+i83/mdHnPa2/rxPDQw1Sp3g/XjFFmXI7ylB0RHWizOL647CkW
	 0XODsHzfH8nUCVkBDMr8I3wriD3+Ob6wfHZYgJMg8uCnLGNqZzmVqP+siYtHNeL+V4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790987732;
	bh=u5cpvw7e1SvXrtCfBRvTH2z6P0Kf0UAFhM5Yq9FMrNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hguAhEXnAgrvPy3lizICqRvhS/piv6VLBIAxHBhZ7TL9Rs+PEMmFb4P6vWIwjsY3Q
	 jbbB+d7cKtVTXb7hS5Zo+1+EsLrWAtrhqQtIaN15xfS+Bkx3HYNzzRvSvbH1nTllTA
	 6j8KDtCrnLY0qn9Emrm7mGcmRRjykvWXHq/BxJFDgB4MVGM4KVzCgbQ7KqmiJy7PkU
	 bFKfF2m5WXUU2B4wFwTxyWlrcPCCkkJnvZh88tkQ5fHNose6w4bYkUv+swwXl9UIkc
	 kqeld1vdXmb8EhSE/4hCw3qhGIEIM/IEugwRyajEEHtRaCJ4hMNyvX0c9xuXYIchZx
	 E2GWGh4XbPN3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FA9840E09;
	Sat,  3 Oct 2026 00:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C71AB32F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9173811ED
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQbcf8wR9Prg for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E72B4811CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790987730;
 b=MAU34FH98j0PGXBCyli1jp1GZjDegW/HrguTc2wRwZYIDiB/FSosKSV+Ct6IxfmSSGGp
 wND4c5ZfemhBApa9rISwPvPdWgpzzXm0KJmaXEkHhNnbhbPWbe8UX7T9R26CL093K/ajc
 bX3fwsjcVZg7/DxyHjVLtJeOvtedijNFNspZJKPcQ8Xp9K2PiU4ujRIj2z+OwXw8thExr
 xOtInIa7htaH6lNyV8lKg105EyHQQyRwA/M9QH5wajeFLeIJvjZkBTsCkKdwYDg+GrwHl
 p+cUMHXZrKq7x7i6jy6s93V5DwN5S1Al53ilaj4x9LIp2zeSP+BhGkvgGQLhGe8Q4rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790987730;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=u5cpvw7e1SvXrtCfBRvTH2z6P0Kf0UAFhM5Yq9FMrNA=;
 b=UvgPXWnho90iEYDFSyZZCwGQb4GXNdTrzvmNEbdBUuiHmdc6EexXGucJqO07x9UjlXcd
 tHHywqg/CnGobq3JzKa26jIbg05lpxeYVWqVwWnYNJ3EtwUAgP585AFPllIjTJlcR9NGx
 NDtbJ1rJY4qpK/YxDr5jdbnPmXcdJO4PaCgiCTpDifA/oXZf5OAW1UkyJShgwu3qrcZDt
 YMaK5uxS/ukbnkf04aLLw6sZvLLIK2OCPndaUmgV0x+GuqmIHCYMBCUuMmmRiIZRzkm4T
 5k4OCDq0osJqIHBnRP4WtDLqXRf0/Kg14q/wT7GGFbijk9NrxB9fGQTwfsLdkKpOlBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d1W1OH8h; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d1W1OH8h
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E72B4811CE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83E8D60AAF;
 Sat,  3 Oct 2026 00:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADF51F000FF;
 Sat,  3 Oct 2026 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790987728;
 bh=u5cpvw7e1SvXrtCfBRvTH2z6P0Kf0UAFhM5Yq9FMrNA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=d1W1OH8hx/1Z6Xa4K50FK1gycEx0FtZrG82Blf4WbnZXO+DFLn4beuFIjbvYLBE6h
 YAvC6ztw1enwtbbFq5oQ5bcgPBz9vGnuaIQuV3PF01jJxqOXf9eXzTJg2m5p8WkErR
 fnP9IOznYvj8ja/1kPJCIS/Mj9BifmpIYNzkccLQPucUfX1yPepvaN0n0Q78ENvr4Y
 yk7T2Th1Fi6WU+qGupZYvDUULbGI8vGZ40oFWFQUWJiQEg79OtciybLd2u6tmpAAxL
 ynR+G8DrSi4/DaxmpmlHmBGA7EIKXb/Rj36nB+5SViRoQOM5v2Puw4ALEK/VLjc16e
 /4PACmygRc7hg==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 03 Oct 2026 00:34:41 +0000
Subject: [PATCH v3 3/4] configs: spacemit: Add K3 default configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-00-basic-spacemit-k3-v3-3-dea68cd1bd7d@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=dlan@kernel.org;
 h=from:subject:message-id; bh=8zylICfYNLF9nRCMjr4pqRcR/Y79kAiclxgg75nZmwo=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqwE3ABpTgTVv0rMfqjfHAhgzbLWbEyTlg2avUE
 eeYq0HdEOSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasBNwBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+36Kg/+P716anfj/Rel33o4Zjph2hDbaJUZCekIB5EaiugdNxUL85PTiZvjQ
 vSNr/8/wXmc29ommr+Hr1TN/xAjiG81hBs2cD/3jII/VicMb1do0rh4jWAVI4rU3WGtC1xMR/+w
 qIs43HkaDHNLTwEaLQmlSDIBUuaVkwieJxhuwI3hC7QsI27MkH2VpdL82DtH/EOhyLBrXdQdSca
 fxDjXzZ3cMyYouONjbWQaQJ0PvhO0/fzxVgx5SUjtIAhXFCwafre8RxBvycLjQSdgINdxmdhIlp
 r8M/Kobp9DeBe9758pUxBKTqJ0o7rtY3veIyBfxLZNsUKI4BTpjGQrRjZzZve3HM7aZBIaIV/12
 xqflVMb4/HvinMPicSGwlWb9lEHFEWtZgadjXQCZe2mVqEbwnN78B37Xe1uCE0KHG+Don6aL/ck
 OhagtuirJ/3abCGu+3lUz/0EfeQf28HfoY2fTibtt+HwdoioZsK6yDq9bGiyo2Q/kebTzDrRfAS
 JAR6ZfhlF+IDxUPLLJytkxwr78a62FhAn/cvsqgfAq8X5eiUHmUcPtEkaXFzMMpW1zvdDUbxG1e
 v0fFY8O2gm2ViCOj4O9QBGRunSOpEVN4MblSObKn+YjnBWgeCk0lwwGFFe/tjHXgujBTtveTahY
 tSf+WGNfTkxlfrNOQZ8ScVcERm8AIk=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add the default configuration for SpacemiT K3 boards, using the
Pico-ITX device tree as the default.

Configure U-Boot to run in RISC-V supervisor mode and enable the
platform clock, reset, GPIO, pinctrl, I2C, PMIC and regulator drivers.
Also configure the memory layout, debug UART and basic filesystem
commands required to boot on the platform.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
new file mode 100644
index 00000000000..a6d1f35a93e
--- /dev/null
+++ b/configs/spacemit_k3_defconfig
@@ -0,0 +1,51 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
+CONFIG_SYS_BOOTM_LEN=0xa000000
+CONFIG_SYS_LOAD_ADDR=0x102000000
+CONFIG_DEBUG_UART_BASE=0xd4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
+CONFIG_TARGET_SPACEMIT_K3=y
+CONFIG_ARCH_RV64I=y
+CONFIG_CMODEL_MEDANY=y
+CONFIG_RISCV_SMODE=y
+CONFIG_RISCV_ISA_ZICBOM=y
+CONFIG_STACK_SIZE=0x100000
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+# CONFIG_BOARD_INIT is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
+CONFIG_SYSCON=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_CLK_SPACEMIT_K3=y
+CONFIG_SPACEMIT_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_SPACEMIT_K1=y
+CONFIG_MISC=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_SPACEMIT_P1=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_TIMER_EARLY=y

-- 
2.56.0

