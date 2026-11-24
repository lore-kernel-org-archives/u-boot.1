Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DE3606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B1GWKdXn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LOkLUwbI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D122880CBA;
	Tue, 24 Nov 2026 19:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9C4nzBEWEvwS; Tue, 24 Nov 2026 19:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F226E80CD9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795549967;
	b=F1R+AHzwk04kOzpmJ/4RjYWPEwuXGIG2QQIXjEnFIJCnHFvhy0KaB5wRNeP8hUAbAymV
	 RKdX6/Q+XT7H5m+K6av6bzVChDajGBNqDc0/85ZmCsbh1IBnZKhFNHFYOw3c+HZQoR+6X
	 vmsvfjDkrOUX0TRhCCxb3Lzj9QmY46SKaJlVZ1s+o56h9DqMJIYcvT+NFd+JP3x0SftYA
	 VowPUeETlQR5JK+sGBPK4edw+ETSLwu2+DLHltn5+D17BsF8rDKNDIDEuYoPF31nrpD0z
	 ftNww/NeReyU4hlxyXlXwmrIrpyXZmV6E68zruGvL4Gi/YjDjf/8q/WFRdMP8J5gxsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795549967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3c3dXDx76WMCID3x9HvDLiXhZX4AkN8l/4DTtD18U70=;
	b=h5gXx4aFMEG9dkLDP1mMwynBHoTQNUM/tY3Rw+HAnlCmAMNKQ40MtZibsp5DQahw2uzd
	 sl5lfSiiI7C89jKajgAdJCUfEshUszgTJiCFYPqSWh5AiOGIb72RrWQ2xcsnOrAvFJlw9
	 7fn+DIIszT5US+Eix9tWZULb/bMBVrySm5cY1CzYmzOyE2KvQkA8VfrIUzw6lPZ6z0ZmT
	 XE6myzNRAPBSO14nktmLlX9gCaBQZ8USWkry5HJgroxK5IISGW+JEs7tiGuY2fDKv5cAb
	 EqT3qcNqV0pvqdB65QEceBxJBa3K5MAEk99TLWVKVYOkbrickp55XGk+8OUYP4CDIGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795549967;
	bh=3c3dXDx76WMCID3x9HvDLiXhZX4AkN8l/4DTtD18U70=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B1GWKdXnhgGd1VQxl39afnguKlUoeZyn6Zh8p5gpcloCmLAX4gw8nKmedKUP6KtGF
	 +8H1mFrwzAQw+jTDskq8FxO7fSca1Zba1FKpNCKisBmfi/vu08tUwzlC4C8pR5TUSS
	 B9w9iSlgvsOePGL1JIPyrIukxqIWsHduyouyZp2jzdrNVT2xzCXtZpx27wpDtmPfxX
	 cTWL2WdQHaNSFonpVKC7Qfq+NVcrGz8ftf44ExcHNkKqnLHnk8fw961kdaRSBI8+7n
	 YK5jnzVyXVCX86MZuPR6+MIZ+dZ0cxAsz3itN6bbVHJvxJNCwyoROAp4ldgBaG+E+2
	 UHOxEdxP2dalw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F226E80CD9;
	Tue, 24 Nov 2026 19:52:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9769026D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89467400AD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQIpibmlNeiw for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6328340071
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=LOkLUwbI
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6328340071
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:52:43 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5be3d5927ceso7050182e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795549962; x=1796154762;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3c3dXDx76WMCID3x9HvDLiXhZX4AkN8l/4DTtD18U70=;
 b=LOkLUwbIq1/bfqaT28MB36HY4dI+yRbF0Zs6lKtMzZdM3s6JCHAoGzfMS3lE9lfCse
 6XDWKXWm0eizIVBgBcPBFmZVdSdEOtHmxvnLFBVUQg2g+5VCH5jKfBKObkpecysohV1i
 Ib9NjK0kDcZzK1fAAgWfLU1J8EwitS6hzqMsFA9gTZS5Mq7juiJK/Fqva1lyrO+NCvGb
 aqBFkDUGeYaWND0eWWuxDsCMPvz4IcsLBh6xoGe/P72tSrudiF6TCSWDhENrLxOnObhj
 eM5ct34BuQivGRKVfIXexdz4MaxzxojtpRqM+7WCIvtIk2i8kZ9USuXW/EWtzaAisyA8
 tMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549962; x=1796154762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3c3dXDx76WMCID3x9HvDLiXhZX4AkN8l/4DTtD18U70=;
 b=cOAMv5W+HpZ7WoS9pEYH3Smw5jJUgXks6ZWSsVk6zQY+Q1kjLebuCCxKJxQd6eAB3E
 F3DLHETLfVpMOEl+fSQk/p4iP7/mz+oEiUXG0ROU5pE6JSSHzDcGBpp9E1VRV/LU6ZoD
 vxwCB/X6ruFGx1NWqI4ijxLeQ6VswokLAQ8mv7beVhmFph9lcJosNjgUvROrt0I6wtzM
 Db08acWqn0dSNxMOPqIB3CjQ0eQo3eJ+n7wmYJH0fM9CRtntfOzCvtfDaSKmIFfofdy9
 FnJTl1xTrWWLxlyoqB8YyML+c8ZJuiy0pVLQIGuDLjbvU5rY9P/QBVrauFGzr9vLYq/Y
 NpRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFBY4u1sQqCkkqWnh8RXQuKVU6oQIa/G9rZ2S7V4R5dZsQUqf9ndyc4i5OCFO4dNPtrXQEeKM4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9HpSLkb9Ov0irRz/wBmVAIM1g4Q2IvA0HmbNc6070Nc+3T4zp6
 dbj9whSm2nGPj8FEy03zBwOrItHaeRiRuhxdMgP8NJadma/x8lrdC0swAW+t6Rbr
X-Gm-Gg: AZFdTZfmfkeideMzmijgf84jA0XlXTl8vfOBntka7DZM+jLnU+dtHiuc1oGRaeMz+r5
 Et6o3HSdzRCH7jb1gCiRFkD4BpwPF9rsmciG99ZgZfihDezBchhnCCfnm/7axJAAWn241PDocIl
 8iNnjtBgvPgojdrqr5OYzq4yMoutS82h4CpvqA2MoTyFfKJQ1c9w5BoZJZgvBaPC7ZD4fCULMdh
 gZJDRz+2ynn2/azsv7QbZVC1MJrRRV8R1FYMc4UKofGTyXGtjvWc4ilmcUnMPJcrXmISf4kcv/x
 Sk4WNFPsuok+n4vsXcDLyRWmStFlb3SoTscFiYCmIyqxMGAAXk0YT6d2D0UcCKtaBantu2R0cxj
 1Fyy4lGybBB9hl9RE+afzILqNfd+1dIQWV0gA5fD89DKhEbukCg126Sr2pWT9piG8G69vhDjz6U
 mLz76OIulbZoqXpOUv0MJ1hbJeH+5NevJmcmrxyqBCFa39qGDcVmNJIhMQ6oc6G+LYXZ7IkF4s0
 VSjcaN+qJ8hvb/In/37Ou/6hU8asq7dpG7dDFlSldE4B5UgX6omDHBfIbGMKwdwgGsTLJqCA7cy
 hdtSpQ6Ccv2w2H1kO/DX8YkH7ZXU5zu31VNxbOUlsbwhYmieiZKsl0YhFan+vQNU+QObQly2rDl
 lebHAyW760P+Q
X-Received: by 2002:a05:6512:31c3:b0:5bf:aee8:7b4f with SMTP id
 2adb3069b0e04-5c1bc80fefcmr4758027e87.27.1795549961541; 
 Tue, 24 Nov 2026 11:52:41 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm4057216e87.53.2026.11.24.11.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:52:40 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: Tim Ouyang <tim609@andestech.com>,
	Leo Liang <leo.liang@sifive.com>
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Han Gao <gaohan@iscas.ac.cn>, Kongyang Liu <seashell11234455@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hiago De Franco <hfranco@baylibre.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot@lists.u-boot-project.org, Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 0/4] riscv: consolidate the T-Head C9xx cache operations and
 CSRs
Date: Tue, 24 Nov 2026 21:52:33 +0200
Message-ID: <20261124195237.692679-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series consolidates the vendor-specific cache operations of the
T-Head C9xx cores and the machine-mode CSRs those ports use, and
implements the whole-cache operations.  It is a prerequisite for the
upcoming Allwinner D1/D1s support.  However, no definitions have been
added yet that only D1 would use.

The series adds arch/riscv/include/asm/thead_csr.h, with the CSR numbers
and bitfields the T-Head ports use today.  It also adds
arch/riscv/lib/thead_cache.c: the renamed thead_cmo.c, with the enable and
disable functions taken from arch/riscv/cpu/th1520/cache.c, which is
removed.

The whole-cache operations have an earlier version in Samuel Holland's
d1-wip branch [1], reworked here for the in-tree ports.

[1] https://github.com/smaeul/u-boot/tree/d1-wip

SoCs select THEAD_CACHE.  For the L2 operations (C910) there is an
additional THEAD_L2_CACHE selection: the whole-cache operations cover only
the L1 of the calling core, while the address-range ones already reach the
L2 and every core of the cluster, so only the former need an operation on
top.

The code is built for both U-Boot proper and SPL.  Where an operation makes
no sense it is compiled out: the D-cache ones with SYS_DCACHE_OFF, the MHCR
ones when U-Boot runs in S-mode.  CV1800B is covered too.

Build tested for th1520_lpi4a, including the SPL link, and for
milkv_duo.


Indrek Kruusa (4):
  riscv: thead: add a common header for the C9xx CSRs
  riscv: th1520: use the common C9xx CSR definitions
  riscv: lib: rename thead_cmo.c to thead_cache.c
  riscv: lib: add the whole-cache and enable operations

 arch/riscv/Kconfig                 |  17 ++--
 arch/riscv/cpu/cv1800b/Kconfig     |   2 +-
 arch/riscv/cpu/th1520/Kconfig      |   3 +-
 arch/riscv/cpu/th1520/Makefile     |   1 -
 arch/riscv/cpu/th1520/cache.c      |  34 --------
 arch/riscv/cpu/th1520/spl.c        |  96 ++++++---------------
 arch/riscv/include/asm/thead_csr.h | 105 +++++++++++++++++++++++
 arch/riscv/lib/Makefile            |   2 +-
 arch/riscv/lib/thead_cache.c       | 129 +++++++++++++++++++++++++++++
 arch/riscv/lib/thead_cmo.c         |  45 ----------
 10 files changed, 275 insertions(+), 159 deletions(-)
 delete mode 100644 arch/riscv/cpu/th1520/cache.c
 create mode 100644 arch/riscv/include/asm/thead_csr.h
 create mode 100644 arch/riscv/lib/thead_cache.c
 delete mode 100644 arch/riscv/lib/thead_cmo.c

-- 
2.43.0

