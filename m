Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9063606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A3BnwWUq;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=INPHCNJ3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7AF606CF;
	Wed, 18 Nov 2026 18:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLU1sy0gcJCi; Wed, 18 Nov 2026 18:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A1D260658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024880;
	b=nMw6FO6jSFgVWcK8h21lWfgW0YdBuVmV8O1aVEHBpirI9X8H6YKjeaRZ641qORmXroAw
	 zpn5BKyuxR7zpG6aBIzJBlgBL1+u82olqbhvstRVEAvsa7xw7H5i3rq8kpynTmlXB0usO
	 p3gYZTT0b40Y8SAdQHJS98BjX+yVpxrEuVSJ6FXzaPaaGckTmUJE1u/gD4sg/JPEnvwXO
	 +nYaP5qeAKGbJM3icVEoVpvvN2C9Xkk7yxtQxOJ4VBlHL7PPEQcWNc0HAkcTdX/5EZSEj
	 jd+KjJnH54eslbx5GP+1SlwNNnG9VrLAKPxGRU7vWpXUER4fsBE5frbW2LLP9kntiOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5C0okh6trukmeeaOIfmUWM/1ZOe/8VMFh0Man0hg6Rw=;
	b=huYDfrCb6BbUWksQxd7Xm9obyB5dbNRPm7BTteZVIkEf6nluaMv9thNSL/X1JHo0y5C1
	 ivLyWbfkq9T7+y8uqfVOT5U7Y3yJU/EvY7iUA6aHl4oSDgzaLyKWLbp8On38T7oq0lDux
	 uevSU8OP5FStOpIliSKgzy1uOY3nF9xW8InbZ2XnN8GkDbbjYXpcYW0zI9dGFZ+9VP1Sq
	 /Mjx/RPwM1NSR0PVtz1v2ut/iNHcOFV6JGJgocGdrlihW4tJTtr4NgrPa5BazBZM0WSY5
	 rsQ/BzB+JN3IkJd7SAexGJP04bZnRTZj5ga1NQ+fh2de65ttAgRnapXc3rneKhFXyTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=INPHCNJ3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024880;
	bh=5C0okh6trukmeeaOIfmUWM/1ZOe/8VMFh0Man0hg6Rw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A3BnwWUqB9Yb2G6b3Z+rMZau0XVYqNGNvv/Ut18/moLfYgfDtgIYllSgNT41VEKyX
	 rBB+Dsx61dTPjfNtsg+tY6ynnBIxS6QP1jlAqMSuPQJivdM//sajhhzl4o414Zq60w
	 DhD+q1OZP9N16m/ZEWd+UFWgrQcTW5WziOvzvRDceJnPb0S+pswdv5X+hNdPJ+GF6W
	 M5iLwvnVORC62vzDHpUsLoxBaTcJYgTym/Q9319Sj8IYOUw1qNrhtR2XOENCtsFjnO
	 sijPAj1BEpl4pNZXoJAcI+B8vojdJWYDjLzho/YlDMmmx6JAiA80S6FnVneZAgiiON
	 0I7jWwzXjpHyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A1D260658;
	Wed, 18 Nov 2026 18:01:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1FB19F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A31E760658
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWOlpCcNTWVS for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 18:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71D9860622
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=INPHCNJ3
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71D9860622
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 18:01:16 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0d126f631so12585537b3.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795024875; x=1795629675;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5C0okh6trukmeeaOIfmUWM/1ZOe/8VMFh0Man0hg6Rw=;
 b=INPHCNJ3Ba3Jn1pMW24t2s/WMaF1BNNnc5YSPPajDuwgLymIhi4g78orHrQeDOdEJq
 jF/YKJxOSZruyn+WR4iNEBfx4jN8wIExGsB1TcpO7BAjjXjFMLHRj6g4/F3B/W+IVOZR
 RjcAWi9/S8hdNMOgMleNOcTg6szFOc9K89xwtB9g2OSxckxbJWY5le8Aew6b+N+GlNs9
 1C66JrbukqSh6CEb+0WKQHURLd9IEjKdzU7sYtAUcP9eaabsKoh+hi8wnkj2d2hqzBKG
 RFxLYn1TXPIwe3rCiDVXgcLptUwlyZ/tdrp6TexwUhzBMkvPDzGAqT7CzC/OrHpINJXM
 9S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024875; x=1795629675;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5C0okh6trukmeeaOIfmUWM/1ZOe/8VMFh0Man0hg6Rw=;
 b=Qe3XizBAbD6ujBFArEZwusKOZSE1dZRY4ZBM5FfIWfrjtZsa+gjEkqP6TtfTl9cdll
 ij/oDvSMgOSb/+0K8q7hLhgG/X7demJRG8r1kRDHQ4qObdSRi7fvWAbua3N/giFNyq+D
 04lN4tNENoA0FMgPrpPdwevGeDrz8UCAA6SDt5H0KR02eehBBQIstLBMDZFXRDgMdTsG
 EDA1Pr+IfesY6GSBdvT/qCotk5avHP211tLZRaDkgE/23kN0jQFeOZ2KbniK4zU+Hb1M
 8BecHVBoUyP/r4RJHRaEet3U/wC/xXjJC6THb6g40CNIlAT5jqTkPJ4/ZHLxxd6aO7+M
 WG3w==
X-Forwarded-Encrypted: i=1;
 AL+hErG/IYvBUFPhauTTa2UU8Aa4J+GMPerSv12XfDwsDbmPzf/OsCas8H2VaN523gdpZjU5cZAySBk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+OANdQlXC+kqPSjv7hOqSu1e3VkcrJFEmHuD2kJpLLvAzqNnxu
 YSARfyvHSPMJ9u0e65dVxFZH92HpRE45uw574v4x0+P9SXvr9EfMWpyMjqUefGlDCp1+A/Yk4a5
 2wicckPg=
X-Gm-Gg: AZFdTZeh05MfklzVyv7QvXJeaaYU2sJYXKjEmTQDfbtNY5/CpHbUPx7ZEdHd7LhoC8S
 A2I0FDjHQHq7c6AiWwvEq61yzVDgMyXIZxuhkdaVflF64wjCPQi+mhCkIBXNn/Eg5/uNg6uK9Ga
 /jrufSYVUXoCVga+O9gWKz0U+t2Ps3X0EFv+JDYNo4Ns2WpDzN6jeB4GEe0TH+fZ8f+Lm55i805
 3ZthYcHxpDgZTWNFCpUX8q2NEfGWTRgW1GiFwBY+aqNG1KAAxqw3fgonL09WnkI/TpJmOiLw+Kw
 KQlRt7jC+phWXr+8acaxeGk/6LKsG6dU5qTiKw9hOHuJFOBAgamtAiWxkckgm54GzjLwj9KJKFz
 6oNollFS7Pn6S16WHVFKS1uTOTdsbw9r+KYkKgavsBRXyWJa/o6F0hq9xg485vNVnhAHpcuqkEZ
 nYFgZ7rUkkLZF4p7Unf21Z9kLy1wuR194amTXPh+umpRVGvLCyZscYs/vvr6g0fNdgoBFxrJ/8+
 uw6HD18fb2BeKNzMZFlMs7BzjUTU1VNX0xSHdvQKyMXIpzoap1JJ51kznsCZrPSKlLf3xWKZDH/
 XjuhuNcZTFPDaU7v5gqa+/m7sxEbI4Z6f9IlJCvkUtncwBpb3F1uvZGDDY1bfBDPRVLArNB9dT7
 aHv8=
X-Received: by 2002:a05:690c:3502:b0:8b3:2250:aed1 with SMTP id
 00721157ae682-8b4fed54c5bmr14314617b3.26.1795024875035; 
 Wed, 18 Nov 2026 10:01:15 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4fe031343sm21648437b3.9.2026.11.18.10.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:01:14 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 18 Nov 2026 12:00:57 -0600
Subject: [PATCH] riscv: Disable M-mode IMSIC and APLIC nodes in DT passed
 to next stage in S mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIANjn/WoC/yWMUQrCMBAFr1L220C2UoleRaS0ybaumBqyVoSQu
 3etX4/hMVNAKDMJXJoCmT4s/FoU8NCAvw/LTIaDMrS2PSGiM5GjsO/jkJ46E3/XZGyHYzi6YM+
 uAzVTJj326vX2Z1nHB/n3LwW1bj4HZe53AAAA
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When U-Boot is running in S mode and is used to boot linux, the DT passed
to linux can either be the bundled in DT U-Boot and OpenSBI use, or be
loaded by U-Boot from some boot media. In the former case, OpenSBI fixes
up the DT to disable the M-mode IMSIC and APLIC nodes on an AIA system.
These controllers are to be managed by M-mode software, so this is done
to prevent linux from trying to probe them.

This fixup doesn't happen in the latter case because U-Boot loads a
fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
This gets rid of prints like this during linux boots.

[    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
[    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
[    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)

[   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 arch/riscv/lib/fdt_fixup.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 6dfd1a2d5b8..ce8c18a7b92 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -117,6 +117,80 @@ int riscv_board_reserved_mem_fixup(void *fdt)
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
+	const fdt32_t *interrupts_extended =
+		fdt_getprop(fdt, offset, "interrupts-extended", &len);
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
+ * riscv_aia_mmode_imsic_aplic_fixup() - Disable M-mode APLIC and IMSIC nodes in DT
+ * @fdt: Pointer to the device tree in which nodes are to be disabled
+ *
+ * On RISC-V AIA systems, M-mode software manages the M-mode APLIC and IMSIC.
+ * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
+ * could still be enabled, so fixup the DT to disable these nodes before passing
+ * it to the next S-mode stage.
+ *
+ * Return: 0 on success or error otherwise.
+ */
+static int riscv_aia_mmode_imsic_aplic_fixup(void *fdt)
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
@@ -165,5 +239,15 @@ int arch_fixup_fdt(void *blob)
 	if (err < 0)
 		return err;
 
+	/*
+	 * Disable M-mode APLIC and IMSIC nodes in DT passed
+	 * to next stage if we're in S mode
+	 */
+	if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
+		err = riscv_aia_mmode_imsic_aplic_fixup(blob);
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

