Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB7606A326
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JHKqD2Xu;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Zlant5jn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA03B6061D;
	Sun,  8 Nov 2026 00:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjB1sdDpocWI; Sun,  8 Nov 2026 00:42:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC6B760619
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794098579;
	b=eaP58QPhyTtjQMfjVfzR2hmSlEr05D0yBb7XJtE7yX9hy+WDzZ1KlHCXGWbS4Lm1VkoF
	 kXOcd1tPCGQvWQZd0v8vOUQxyrNQellGGsPrDh4+QK5xOANm+XoDkbMkZT6ff5ITL922V
	 blLjrvX4kkvZBvWNAWZpTIgsjnTPEqFzj0fSTrblgVr/96Bso+YoON9MI/9oouY/kVXXW
	 03qcPhxbyMrWno6qPzMjIoSvpMDnKcmejTMb1uOVz+mjqgW9Qm/fLqLGP1+YQi/VVF4aj
	 20H2l5/JgSBiJ1wqGUmLnOKd21PoebcugbwuLfUt/kR2kHRj/+hbo2+Kb9oEmIewSyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794098579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BJJtvqGOS5V/7FXTL2oVPjkTuQn68ltb0EqC5KBALPo=;
	b=kSSPG2k+zMBFifM54pKnPNNDff1Bh6GxCXwQPFZKUh+fMi6kN/Tm8wMnz2NFDfpGCd3V
	 rVMVkbOoOsq6DFl1fsWh4ceoqTfkK5NVopBzn528c4LPrn0kIFzY7HhSnNqU60RsWKqCn
	 C2MisKQ59xPAymSbEgQUCXRtz0GPSk2C0PaWajCjlAQEw1ZiOq/V6QG9+d+Cif2rNJRk+
	 Z/m6SuwEFFZIIpfftW5yy2BLVavjh644MS/UJtiNmsAdjHNDNNdcNTfl23K/T+YMgSGE9
	 e7w/TNmUuhUcrr0MWLw8AXTjKkvjtzKMNmKLEeYxDI7zd9XKKY6nvQlH1xbiugdsMiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794098579;
	bh=BJJtvqGOS5V/7FXTL2oVPjkTuQn68ltb0EqC5KBALPo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JHKqD2XumoJQC69T3Thrn3ugq8z5b/yns3Iqr6j5vPIN4cEha8KLwTegW0bXvUlOf
	 UqtdyI7cpNlovtBVNUqkGyKR26Zc9P2nZYsA5pM/lVxduif2hteomH35+AJtbaCMHU
	 6kXH3p2EVXJDxkMM4u2JFo+vnbieFm9Jf2yVFHfqwo6EHSG/PrqxPhwuteEWw7qHEl
	 E51pvWzBwHqVDtWHAGqmCE41McXGlkxKJWw3uePvTpM83TbwQSgxdUF/mtBp5w/IM2
	 8g7K8jESnAh7H06AXKO+VXcKXEPaKTfvIC5UTxAgK+cq3W9/NezEUW7eSophhoVVN0
	 CU5JCXR39v/pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC6B760619;
	Sun,  8 Nov 2026 00:42:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F72E251
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CE0D80E7C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWe0ePoMvucS for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 00:42:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF76F80E7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Zlant5jn
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF76F80E7D
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 00:42:55 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b335eeb340so291687b3.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 16:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794098574; x=1794703374;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BJJtvqGOS5V/7FXTL2oVPjkTuQn68ltb0EqC5KBALPo=;
 b=Zlant5jn1X4KJPOH4UsuX8u5RWoodRUgpoFN2oWhdzi6HlDlooW7X1BI5mqWuhXleI
 fCXUqPR0A/m5u8tbKMhA96F2n981M72ZW6TaFooeaUSHFEwkACjfJubKIekYFu3UsmmQ
 0t4vRG+EoehROCrSLdAv8ND6mgwSve89uWsyvfu8x4zWXhFg8YtwbWwgXSPWfaguSO9I
 IXOthAhehDoP+Pmt9jTMIGFYn1DCWCtT7uFPfciGNSEmnVUNFDmLBUXtgV4ZtdF5+jly
 mUzBrl5HEye/Secdtu06cJ3pdHKQPJu0fyXVchenGlstMRK+dPmksQ140DAZAKe2x5Nd
 CLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794098574; x=1794703374;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BJJtvqGOS5V/7FXTL2oVPjkTuQn68ltb0EqC5KBALPo=;
 b=bgu+WgpCqOPKFBvEmnOfB6CdZh/3qjjmy94rMaKKJ8HHrnFOo8r2/uUk4uKO4i36cX
 o+NRmIA/zENHI6jULIJ0uUzkAL5AG6l+heZOnqXbKEXKaX+JHYlYsIuISm0JJgTmiXyG
 nMU+vtVM7EeAn9gRmt3lKpp11g9KakYbFH3wM/u7V3izFwZk9ZDhXxxbEnH9KGZnwPza
 epU7xz3DX/S4NUxxdoLzO1IoLTygbXAAoastbZ8uf9aJBv3/5TY/2r47bfa8F6/tOIRm
 th7zUm6NddQzhmennZAPAXuwDHmxsAc0yngWW/kSk0rUNS+GAp6G597CrNcfwqJV1/Te
 CUvg==
X-Forwarded-Encrypted: i=1;
 AL+hErFRVKaY/OU9BBfa9TqiiH5It0g/FzFWL2KBC8eAk4kDyLANMKjLBggqn+5kxbgK7bywxBFuvPk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/t+glxq64SLhRI1bXdrg1yAkQasdDQ1WzKQp3/krgS9jA5fcAb
 0bL0FcgERwySw6lN+tcbuLvh5CZZHYV8PM4zTyrpVJuFhzruYye1NNlg1LkM9wUuSDU=
X-Gm-Gg: AYBFou2b0cqqx38X/GOYa59vqVGSfqy5+pmF5R2N5zJsJr4URCJctwq/R9qX/mR2F8Z
 1Az3ISe/V6Dwh9tspZslhZqHRI6tm3so1etnqmoFoa7YSkg0AtUQMJgWa2C57b77XYKMi43r5fN
 0aCDuAYlQCjDsnVB11J/30D1An7bUOcY1NYf68BCXejJYovovo4KwIKIc3AL6j3kJT1AZCo2Wba
 me1c8yxRmd5b3nWf2b+0n1dnJDMDpGPgH3mKvdHjn+6q/chBoL6NBO10ItJAPa528b0aHqVzO0J
 r/c6If7clSbC1OIs+5M7gCOVoa1w1QFFVcE/VLTGuz0DgwAqoIkl8X+ddeSX7lXczKCXfoo+yyV
 U5HvQ9xhqt7Zz+33BumurhlGHgfMEMWVwGiq54w9STuCkB0gdYKO9k9uBm0PXAR2pxVYAycgyBi
 8TO15xq8AZT1I3bKC/pML3pjhVJqKzzwYmeMHND2xPOItr4okEwWfjwdQodj5dYXKfXEBGtZzKm
 YuV78KNjdpC0IEac52joB2Mt9tLTXoBEMGTBA0/3bDXaCOH+gOrtBg2Ng8fU5Xd7Z5AmUe69Kcn
 9jVX6OvhKZKeyiEps6gnv9fHeLG6o8pabgSUzhuQ8yvUXX/BOPNsovftt/Ask+c+ejmkXPlUR88
 UcondrAs=
X-Received: by 2002:a05:690c:e211:10b0:8a8:8d90:a66a with SMTP id
 00721157ae682-8b36caf64e9mr1396627b3.87.1794098574185; 
 Sat, 07 Nov 2026 16:42:54 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:974a:b1a3:b1b8:ea0])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b97dd68sm658485d50.21.2026.11.07.16.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 16:42:53 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH 0/2] riscv: Add support for M-mode IPIs using IMSIC
Date: Sat, 07 Nov 2026 18:42:00 -0600
Message-Id: <20261107-mimsic_ipi-v1-0-c08bdd2bf482@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjF72oC/yXMTQqDMBRF4a3IGxswgiJuRURMcq1X8Ie8tgji3
 pu2w29wziWKSKi02SURbyr3LcHmmfh53B4wDMlSFmVtbVGZlavSDzxoQh2mxgLOeUgKjoiJ52/
 W9X/ryy3wz+9B7vsDpO+dXm4AAAA=
X-Change-ID: 20261105-mimsic_ipi-d6df81eebbce
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Tianrui Wei <tianrui-wei@outlook.com>, 
 Sean Anderson <seanga2@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Guodong Xu <guodong@riscstar.com>, Hiago De Franco <hfranco@baylibre.com>, 
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-boot currently supports M-mode IPIs using the ACLINT MSWI device. This
series extends U-boot to support IPIs using the M-mode IMSIC present on
chips implementing AIA. The ACLINT spec was never ratified [1][2]
as chips with AIA use the M-IMSIC for IPIs instead of the ACLINT MSWI.
One such example is Tenstorrent Atlantis, which does not implement the
ACLINT MSWI.

The IMSIC based IPI driver has been kept simple here and supports
systems with contiugous hart IDs from 0 and a single IMSIC register
region. While more complex IMSIC register layouts and hart ID numbering
is possible (OpenSBI and Linux support these), existing hardware out
there implementing AIA do not support these (Spacemit K3, Tenstorrent
Atlantis and the QEMU Virt machine's default AIA config with a single
socket).

This series can be tested by enabling AIA in the riscv machine
(-M virt,aia=aplic-imsic), switching qemu-riscv64_spl_defconfig to use
M-IMSIC for IPIs like this

sed -i 's/ACLINT_IPI/MIMSIC_IPI/g' arch/riscv/cpu/generic/Kconfig 

One question I had is whether I should add a new defconfig that tests
this, so that it can be run in CI.

[1] https://github.com/riscvarchive/riscv-aclint/blob/4e570bfd3201f2c09e5afd290b5091526b0f099a/riscv-aclint.adoc
[2] https://lists.riscv.org/g/tech-aia/topic/connections_between_aia_and/107177435

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (2):
      riscv: move ACLINT MSWI based IPIs to separate Kconfig symbol
      riscv: Add driver for M-mode IPIs using M-mode IMSIC

 arch/riscv/Kconfig                   |  28 ++++++++++
 arch/riscv/cpu/fu540/Kconfig         |   1 +
 arch/riscv/cpu/fu740/Kconfig         |   1 +
 arch/riscv/cpu/generic/Kconfig       |   2 +
 arch/riscv/cpu/jh7110/Kconfig        |   1 +
 arch/riscv/cpu/k1/Kconfig            |   2 +
 arch/riscv/cpu/start.S               |  32 +++++++++++
 arch/riscv/cpu/th1520/Kconfig        |   2 +
 arch/riscv/include/asm/csr.h         |  11 ++++
 arch/riscv/include/asm/global_data.h |   5 ++
 arch/riscv/include/asm/syscon.h      |   1 +
 arch/riscv/lib/Makefile              |   3 +-
 arch/riscv/lib/mimsic_ipi.c          | 103 +++++++++++++++++++++++++++++++++++
 board/openpiton/riscv64/Kconfig      |   1 +
 board/sipeed/maix/Kconfig            |   1 +
 15 files changed, 193 insertions(+), 1 deletion(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261105-mimsic_ipi-d6df81eebbce

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

