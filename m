Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC860A383A
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s0EHJ8Q1;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=DalLnm1+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB3E7813AA;
	Thu, 19 Nov 2026 15:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_M_aak8t2fb; Thu, 19 Nov 2026 15:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFAAF81372
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103244;
	b=bhMa9Pd9RHsx9b8xSGA7S/GA6WGMQo9k6IJpXPBdiNwBLkAkmvABnpp8qPlrE5VM/x9F
	 yEk6Z8joaoqQePLmkeSx4gqlKUU93YOLyVnfhIaWnHnjh6pNTQqK6g03vbYzaAqZglVjB
	 0jSGdlQmekL8uwtQipc+2xdwBfMMv8rM1NGwow1vHqLMGq+3Qw0Rco11QVnOLv5zZS15G
	 4r7Z4g7WrJkQWc3nFnzvvog67duv5TlElbkwl4UCBB8QW/ATblDYgYzHyTB8E1O69blZm
	 rsgFSmKCVKvI4gI5PLqADprBBheZIWGcMQaZ0L7mJCGVr8cWT4+EbxRujAhUNYDt91w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=H+lRxMYC6QLTBd/FXFieeAUwsQl9oiwdu0lHvqR09U4=;
	b=IZGFGnf/x//+LJCS4lLALvxi0LFpqCf2algCdsXBdr6lhk6kZhtVuE8QuEmparuBITfH
	 G+ABgx6A/eX/nXtRM73vAAZoelpUlwKniD7F+unfMdA416PrigFU5/LPJHUEjaGZux7fW
	 b8sh7mxCNObKDbdc8AVKLPBnbr7cDkKinytvtCsmP0LJ60nzRCJ9gjpWYUi/mDjYPJqJI
	 l04FE3md54tYN3FN9AAIUDCzG+/MnfggaM4tAD+7r4w8hgObeRa/+/FjTKr9K4YaD5pJR
	 CvZx5I8iVWEW0E31qvHXGqqG4Bv7Wu6cWQu9aII49L+msHduhJ0HY4u8Nl8Ztw8OgnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103244;
	bh=H+lRxMYC6QLTBd/FXFieeAUwsQl9oiwdu0lHvqR09U4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s0EHJ8Q1T7UViI/qVNUbfooshHZkeuIvpRSHo4QsIfC0KLcFuvyZN1QVzuyh72SOF
	 TOIBlJqjv6wRxUnlZSoiV+dhuQdnktECGJl3YrTJtCGUd7TvLDaiTNRt74RzaGImp6
	 mj7OakgJeNERus9GdayY0YhIc1rjY6lSjczZLMYEt0zU3a0vgDIb+pzdVLoLroasTx
	 i8pGm5cbrnELidnXU6ZNn3AP+fXxMBlZid3bGiLcLylDz7kzdGkU5GzEUfu3cJqOux
	 2rtyjQf9Z3CNseKHWtndK33M2EKsnAJ6OhbASsCB2aUW6nX2CZZj4bwbXbLT3GY4kM
	 sm94KvZA8TEUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFAAF81372;
	Thu, 19 Nov 2026 15:47:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8493D2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A9F140562
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnq92GHaHJHB for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2EE7C40556
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=DalLnm1+
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EE7C40556
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:47:21 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b4e2fcc300so24397837b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795103240; x=1795708040;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H+lRxMYC6QLTBd/FXFieeAUwsQl9oiwdu0lHvqR09U4=;
 b=DalLnm1+1USDXJWMngwKkT21SYNzVZSwgBYNbZWPqIvHZeOorOMDVYrycaa2KKTjAq
 kVPcO2gjOuRmqNGge2CCoTeVHOmLdd2O0iPNu1+CvidE238azjpVRyk/hA56izLY4gkG
 iR8y+Ed8H0laKevenhvtOOSpHDTVRr2rUwF+L7zSJClYLFDBUiWowLApf5qzfdffzogX
 4dotnJnqWzFc2IwULC9Y8QLZKCixz2xtW/ecb3t/4bqsU3kU+srl72h2UUVq7RxSnlzB
 NczopAuADU93cNZlcDHGpoWRbzedtVTSYBkB/zsdsjJU9NpLC7cFznJ4MsdKAds4CJt6
 6FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103240; x=1795708040;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H+lRxMYC6QLTBd/FXFieeAUwsQl9oiwdu0lHvqR09U4=;
 b=D2B3p63rBo1mRbF8dNGgrcpDNy+Jl0W4nYOtNetJEnY69aSuZZ3QPsc4ZhIWYNEkNK
 jXZilZKGKD+bk8/No7/6otSve3ATz9lio4PFC/iyAcEHoCpfEB7OkUspmnXmZfKs1499
 26Zcg8XrtKltFaz5Jg07oLkMrmCN8i05L9AowO+CjbVeiBf9+odfEP9i+pH3eo6ZbKUw
 RfchZ+9sdmirzXRF3var9uQvvdn+SDSxMYZwSLbGfxL2a6CSsV56Q0RO4BlLPrZbncOC
 FmcakbZpGXiZjOE0VM4x0YwsHTrS8uV8YU29nUsAZ2X6FberYljPKIUsCAV+B7KRdGW+
 G4yw==
X-Forwarded-Encrypted: i=1;
 AL+hErHlKyvLpXR0RW9aAJusL+4KlpLJ8iezu7JT4aniwarSZVDUuwrpaGnv3ccfqQMRlCb5TtdJdUE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9jnL4Aa7ur2rQIL998DMvp9oP4wtZg5HN2Ji8+rE4qsoIjATSr
 wkBUPYr49kjtrVpk7IPv53QXekTXsl7S+P4zT+YHAuB6/uZz8EIdebCNuFJ98C4aMxU=
X-Gm-Gg: AZFdTZcD25yPwwMnKDg4GCoj48xMBSPjqsik1Bdvho162bSkkLygb2crkNI9Q6wY9+K
 uJOERlIjEvJy69Bo7PmNA3hh8Qw7OFQ/ryyd/VsaO6mPe/46b/ij0SdKilZ8itKEpBrCqwSZJt3
 U2UAAW1jpqDAkDDNFzKrwAXoJuCuLMkH9xV3ElMW+ntBL9yQ1Zcx3YeoYlnaytU5r0Fdz44/OIY
 hG/0YkA6teqjrzrSwO1TpSU2ZekocweQao40pWtNrvHqzMGGTPX0zgpwK+L+Fy3O26ueYCmqwVx
 6iMJsMffeX6zWiJzYYXrp1iiicygZj4S+r3fBLcwSNpu9bpZO556enJikmy6FsjilAOxC8iJ4B1
 HkTzk+GCMtpnQ1EPN4b1LNtBu02ieSlqmqB3vQbaOw9jApIwTJHkzQUaUH1KweM8uvWkt9Zz9Gt
 YednXrJZV6FXa7O3VVTU5kFLSc9rkSNUBd5ofg5llGB+qsF3Dta7smEJInI3hxRdV+TDUid2bRa
 VdQoRu785VtSjK+Ek7orLVi670jn91SfmDpq53K2u20bEnc0xzt/f5TJMpZdmY75NnsHlgAu9Jr
 QBqcpfROMuHIV1TgvigA6STh3mhewyqMQXVStoSom3QhN4z3n0dxlwlwpvD6Qj6IJBrnPLK381S
 C/q8=
X-Received: by 2002:a05:690c:498d:b0:8b4:f218:75d5 with SMTP id
 00721157ae682-8b52049a6d6mr393567b3.50.1795103240609; 
 Thu, 19 Nov 2026 07:47:20 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b5202fb08csm786667b3.24.2026.11.19.07.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:47:20 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 19 Nov 2026 09:47:07 -0600
Subject: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIAPoZ/2oC/33NQQ6CMBAF0KuQri1hikDrynsYYygdpMYW0gLRE
 O5uixsXxNXkZ2beX4hHp9GTU7IQh7P2urch5IeENF1t70i1CpmwjJUAwKnRxuvmZurhGUarX9N
 AswKkyrnKBC9I+BwchsWmXq7f7Cf5wGaMVLzotB97995qZ4h3/xtmoEALprDmbS6qSpx779MRb
 WQc2jFtekNi18x+NbGvsaAhE5gdZQuyKve1dV0/K5Qv6yABAAA=
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
Changes in v3:
- Reword commit title to say M-APLIC/M-IMSIC and drop references to M Mode to avoid any confusion
- Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com

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

