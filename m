Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636B606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aR9IdH8o;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=doeU78Bw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E9B813AB;
	Thu, 19 Nov 2026 15:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDizLy55a1jP; Thu, 19 Nov 2026 15:26:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B601C80F84
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795102007;
	b=QYXzTVdvXVwDzHIClS5LTzMspW3hAXX6mFRHM/sK0Dv0rRhz/t6nRax4pRi2SqNY8OY+
	 b3feOV2mNCGWsWGFQQIJhcUDINi+tgKohdQPwpb4MIgvQ5xCPYAy+x+KenDFUHabq6Cro
	 LXLt2eN9qYMT6D0gkNIResHBkA7lrQKRz7amuggFUq9Fea5IroqA3iyx540Yr7H9gA3SV
	 pnh11iSr7tD4Uu3+suTMRJ0M6JBrpyXW/aCFWbS6KmQ0Njp7TR5m8wu6arabNjhDE0gNx
	 23gwcoPjau5W2sU/oqFjR2E7ktCk1Vbh5eaMMR6XTl+0CoqXR5rmmz4KAx/CfpQtcRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795102007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I1pjm1Tb5KtvSTt4AV8S6tj4ZvtuNXTrXP6dOUPAmnQ=;
	b=fxTTNKlJPsc22VF5XXfYFfmctWs0UimwV0NxGwuHrD/t9BQnxHFKwg2FszwxdxylgCdW
	 T2EBzEb9g3eTX01nvxiINfk3L6v1NnYDwa6riF+T+3eayM1RXo9pri4XsxZ4bTSSWYY0i
	 RfK2cRB52whzMNjqOarzZC58NrwhKqPeV/vr6T4WtCBt8hmxWzcmRfwiqiFuzyuQUI1jA
	 /oqaZFheR79nCM6tdBFYekBvZQJgGyBhf/pktNxd8my051BoZqZK2fBx0UWt8tbAYueVb
	 XO1HDTUhwMpKSP5k5I1ltz+xXSUju8N/O3j7AfU97UTCC2LfxeICERIeTCLzXjJNBow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=doeU78Bw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795102007;
	bh=I1pjm1Tb5KtvSTt4AV8S6tj4ZvtuNXTrXP6dOUPAmnQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aR9IdH8oNtJGuB7SFB5CPPQtB6it4xgO2zdHEtSpKDPKX1vKwE3EK5DNzMH2Zjmkh
	 3VCmB7SE3WRNJhk/g8SJGXf6CcdAVPDXey6g9/fPXDvJFjgepvU7jmIoViDsSaKfMb
	 7ItH0LPCBaJhmmiGXyKjufqnt8TGNccGIVpxA8LqnHuI3OAvj4PdBoqiwQH+9bVmhc
	 4BJW9j0FN7TPCsgZgetvW3NRJ67Y1tvuxKQ/vcZodQvnu0BIVwRFzIcsMb0jxISUz4
	 uEdG+f6PiYFbXOEYrL2+IEQKS60W9LN5G1F987TEotkuPdvq//zvCdjuv6mTgbm4kq
	 ijvE5fY+VxJRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B601C80F84;
	Thu, 19 Nov 2026 15:26:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1F3B465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 939CC80F84
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huP4bPMAlfpe for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 335BD80C95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=doeU78Bw
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 335BD80C95
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:26:44 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b30ff12f84so16177867b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795102004; x=1795706804;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I1pjm1Tb5KtvSTt4AV8S6tj4ZvtuNXTrXP6dOUPAmnQ=;
 b=doeU78BwzvaSRSiIlHcib1JfdXOCAoObsAWAashqGSQETS9fdZnGlhxayMU5p+7Piy
 iGtQNpVLhAG07GRcEzZsqT9iywZ23+7VDWcYGzs/VmWdR/Rp4GvjIQIRnfpfthVj0Utk
 b/gbPj/Wkp9cC363Qn5LVrw2zBZZzBk8wjxaTgznWglQcZAckac/1rkQqcQH1Jw/nksP
 uTKx/1kApejM5FFL9Qz+3V4Fkcxrnt6sjVfXWgzMj1fN4KPvALkhgE08zfLKHJCfIyc3
 w6Bv7UdTPKXrD2xWKAZgck3Nut273u4aZpJVj/2jykffEJqccsvQg6nY94ig6zUZTRly
 ooBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795102004; x=1795706804;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I1pjm1Tb5KtvSTt4AV8S6tj4ZvtuNXTrXP6dOUPAmnQ=;
 b=S+KlVPSuyg0OfyXrEvVMUP3ScwMkswKcHXDI41tw3CzcqQbXABqgHsImxbehkpW0Fj
 UXC7/SeLhhIlBkcYyz7KjwG68qnxrss5NjUo9RoNmIT8uHXMoJsnMWCRpsQKXEP9t5uk
 FuqvaKm2liFctsnLZkpsNmAK+6D6INHeez2sh0aM3+iMlirOJE3hCgNo7z/oH+b+fMYN
 Mf0iIc7DMF8qYb2vH4hh1/k9dTjibCPduYFmIg6PwCkaDrMWIrboADN2hVbzz5D9c4+v
 2JngL5c6pcmFK9H7NRbaphXemTvXpVmFuC4Ju3kqoPEsOEDph2f9IvVjIo1UON0ZwXP5
 SfCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH9AkXTK29fE1T9wGEN5YkQhkE/KDQdCpO7maYhdevZWgTZRLfx1ZrnQFjBgQ3tfHCDn32PDZM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tdjehsRtuKMAO+IXHiZAYboOl/UUjkw1Q9ZW4NlIe1ZO4C7s7
 KltpQ6yq+tFvP+UDTFh7+fMPNARBLzZHJpl5GBnxgVZygkJVfNJx++WOtf5gEy5H6EgMrFhqwSa
 ascfsYa0=
X-Gm-Gg: AZFdTZfY0UsVbT+2oBPgNCJMw9HNNLq9Bx/RX4vNPJmTz+R8HNsc7oUrKFsmODDZy+A
 lewI55KSUWWJqF6tZDWc88cQFe+l57YHd+5c34LNkQIFyuQT1cjJUdDulkI6fu4NN0Eth1OHPF3
 Xt1dpqV/MyLcAYm05q36eRG/zPg18TzhG3WID6TqjGj5anW3BsUfGsa/gPLsNTMeZknzlT2W4B0
 jDv40aXVdi3BBS4Dv+E/iUyhr5IHpv+Eyp0pIMOW91VD6dWG+1wCWMnIEJyQ0YC4pcxB5+8Tegt
 JUNrtwnzU9uwCxwPk/KzURg61SZRNPOrenhYK1yzq3JfeeFnrCwsOCwcligE2IH5VJp5Q3Ihj25
 DfCkOqLuSDJOtx1ksrTXf4agaKVb9l+uiD+HBA04QQ/+atMlhcs4AXxvpvowWPfWtI7P15qIuEU
 nXopiuv2se5EV6zNFlVKak09f/OXFMJ9AEkC7PFbM8SgavNE54SnMKqWZ+txZlvwbnaeRm2nxIN
 oYaa2Xwqh/i/uCGWLSjvABU9lW3BWtsuQ1oxE/m7RMsmec1r0Yo/+4nu/G6mynwQP3NxPKkxIh3
 O6J3yucenRtOOudaocQ0pKazM7rY/Hs8WIGOeBpxXEVyfibYkWXh185IGRB9zXHZUd2zlwdztlw
 LhR4=
X-Received: by 2002:a05:690c:e246:10b0:8b4:f24d:b6f1 with SMTP id
 00721157ae682-8b52043cdf7mr183177b3.16.1795102003655; 
 Thu, 19 Nov 2026 07:26:43 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm557187b3.8.2026.11.19.07.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:26:43 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 19 Nov 2026 09:26:26 -0600
Subject: [PATCH v2] riscv: Disable M-mode IMSIC and APLIC nodes in DT
 passed to next stage in S mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIACEV/2oC/32NQQ6CMBBFr0K6toSWIMWV9zDEQDvIGNuSTiEaw
 t0tuHc1eZn/318ZQUAgdslWFmBBQu8SyFPG9Ni5B3A0iZks5FkIobhFS6jvtpte6Qz4nideVKI
 3pTJFoyqWmlOA9Dist/bHNPdP0HFX7YkRKfrwOWYXsef+LyyCC15JA50ayqaum6snyiO4XRPAx
 Vx7y9pt277YfCwJ0gAAAA==
X-Change-ID: 20261118-mimsic_maplic_fixup-051bd38d0985
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When U-Boot is running in S mode, the DT passed to the next S mode stage
can either be the bundled in DT U-Boot and the previous M mode stage
use, or be loaded by U-Boot from some boot media. In the former case,
the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
nodes on an AIA system (for example, OpenSBI does this fixup). These
controllers are to be managed by M-mode software, so this is done to
prevent S mode software from trying to probe them.

This fixup doesn't happen in the latter case because U-Boot loads a
fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
This gets rid of prints like this during linux boots.

[    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
[    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
[    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)

[   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Changes in v2:
- Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_fixup
- Drop most references to OpenSBI/Linux in commit message and just use M-mode/s-mode software
- Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com
---
 arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 6dfd1a2d5b8..49f5b3b5bb6 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -117,6 +117,85 @@ int riscv_board_reserved_mem_fixup(void *fdt)
 	return 0;
 }
 
+/**
+ * riscv_node_handles_mmode_external_interrupts() - Check if interrupt controller handles M-mode
+ * external interrupts
+ * @fdt: Pointer to the device tree
+ * @offset: Offset of node in DT to check
+ *
+ * Return: true if controller handles M-mode external interrupts IRQ_M_EXT (11), else false
+ */
+static bool riscv_node_handles_mmode_external_interrupts(void *fdt, int offset)
+{
+	int i, len;
+	const fdt32_t *interrupts_extended = fdt_getprop(fdt, offset, "interrupts-extended", &len);
+
+	/*
+	 * Each entry is <phandle irq>. The phandle points to a riscv,cpu-intc
+	 * node, whose DT binding sets #interrupt-cells = <1>, so each entry is
+	 * 2 cells.
+	 */
+	if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
+		return false;
+	for (i = 1; i < len / sizeof(u32); i += 2) {
+		if (fdt32_to_cpu(interrupts_extended[i]) == IRQ_M_EXT)
+			return true;
+	}
+	return false;
+}
+
+/**
+ * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC nodes in DT
+ * @fdt: Pointer to the device tree in which nodes are to be disabled
+ *
+ * On RISC-V AIA systems, M-mode software manages the M-APLIC and M-IMSIC.
+ * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
+ * could still be enabled, so fixup the DT to disable these nodes before passing
+ * it to the next S-mode stage.
+ *
+ * Return: 0 on success or error otherwise.
+ */
+static int riscv_aia_mimsic_maplic_fixup(void *fdt)
+{
+	int offset, err;
+
+	/* Disable M-IMSIC in APLIC-IMSIC configuration */
+	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") {
+		if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
+			err = fdt_status_disabled(fdt, offset);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* Disable M-APLIC in APLIC only configuration */
+	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
+		if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
+			err = fdt_status_disabled(fdt, offset);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* Disable M-APLIC in APLIC-IMSIC configuration */
+	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
+		int len, imsic_offset;
+		const fdt32_t *msi_parent = fdt_getprop(fdt, offset, "msi-parent", &len);
+
+		if (msi_parent && len >= sizeof(fdt32_t)) {
+			imsic_offset = fdt_node_offset_by_phandle(fdt, fdt32_to_cpu(*msi_parent));
+			if (imsic_offset >= 0 &&
+			    riscv_node_handles_mmode_external_interrupts(fdt, imsic_offset)) {
+				err = fdt_status_disabled(fdt, offset);
+				if (err < 0)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_OF_BOARD_FIXUP
 int board_fix_fdt(void *fdt)
 {
@@ -165,5 +244,12 @@ int arch_fixup_fdt(void *blob)
 	if (err < 0)
 		return err;
 
+	/* Disable M-IMSIC and M-APLIC nodes when we're not in M-mode */
+	if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
+		err = riscv_aia_mimsic_maplic_fixup(blob);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }

---
base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
change-id: 20261118-mimsic_maplic_fixup-051bd38d0985

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

