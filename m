Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED42C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BF8D40799;
	Tue, 22 Sep 2026 14:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72eqhXu2WBDY; Tue, 22 Sep 2026 14:40:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B02F4076B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790088000;
	b=QCrEcbF3roT5tgWymodIjOsQOWED+cuiI8zWOKKnkVdCpK8dckV3JJket5zRi5yra7jf
	 1qf11NQQTaVuVx5B6s61Igs/F672erOI5I/tPaVH5iYJzgP0QLYhq144iH8ScDyQnSjoQ
	 LmC9BioMhnEr1QKPoFEnptQwKFNq4tGUUJaHnucaEpqILEY+tDVVpi0PGmuaj4w1JiL/s
	 0ufvW8TAB9jCSHPRXsHU1OsEBde9Cav7NipjmKJJMC480/YFDJXvH8qZHVClmq7MbXNI/
	 n68H+SYMEbBLYMSqXgffoEH5gk+PiMtfLsZxsU7y7z0pY6Dq9QFWv4jUb9V1CJEGLfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790088000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=plTBMLuDLp0k/uM/IeV/Dc93Cu+lBycRF3nRK+sEr9U=;
	b=HCTWutBaf/TcbKFG3RA5A40ni1Iz7NkFwfuM5YiZAIpLPnrrqcO0X5llY4oRnnzFtuFO
	 0Aj2DT4JiXxSADgscWZr2BBEYgHbib9uMINjEVmHwDmyfZJ+Y6ONYwbbKAZePmEaaNyR1
	 T0L7kPhKt3xLrdQ76GmnYmzO5mXwiDdsop0PmqorTUSeS65q5XVJtECpZ71fkUL0h+5Yz
	 Ar6cJDAdBjRp7krzjBOAnI2Dasv820Qy0+zU6lK8by5Y5WYCaWcJmVywJjnsWiiTef2ad
	 WSEX3m9M8wD3kaRrIrVRhxQSr5vgzsPuyEZAUVklaQdO8syrkmSJAN4VQdiR8SEcQ6g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=KjLI6Lyb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790088000;
	bh=plTBMLuDLp0k/uM/IeV/Dc93Cu+lBycRF3nRK+sEr9U=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FzA5Pyazegz5GL5HV5ZOyQPgsgerGwxoJmkjx+lXwXFwks7hp8UsZxC7DwNxEfu3D
	 ubg+0SRmwrSlALvEBHb1dZ29G8/Y8aMrAUeLnWA5RZA+L62MQU9xM2/N2mMcD/TpcI
	 Tw9+KZn0c22M81HRv2nwDcoUF/T99PuWDzmJi+KYWXcRZ6ltAp34hi2avDMVvzrUMy
	 YHR3pK7LMco5wrRYWtdERYgDcaTB0F5BmrQRxt2Q5tGHqaF0WFxo2IE9r/0h3UslZK
	 6cZyvCqDkggVip0vudZIkI/MOZPl3Ae3toiyoL6AoMpU8E8xrOq8QCPDqmCY/ZI3Oc
	 t6LTWn54mzEfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B02F4076B;
	Tue, 22 Sep 2026 14:40:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B6112C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AA934076B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ex3hpg3ogGgm for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:39:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CCB8040759
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790087997;
 b=bXB86+Rr2ovzkwS93W/m7HowQtNNYgEcU+epzCLC/hx+lXXYhE1tqwVcETbjkDZvS8rx
 p2mb+ryE1nfx4j+1xZ1+iPV5IYZV9NjdI8jzdXbzJ+dQxPsejRMPIVIoY8UsCpVZSwcy3
 R1SIxtwkESeuF3GBE7YWM6Ew87l3BWADsGPcdwG1D4gsYPIhaYf9LX27uh86XGrEcdj1E
 HIEIr+2UvOq7n32XyPpzQcPqzUqa8sg6gufkFnHAfuOF9Gt/boS8zgNC9xjx4pyBoor4d
 o0B2PfhEcqT1dIe7Lu4Ro/GJEe8iX94h2JqHLpu5euRrsVEENTTkfzR+WGyYwJGxNeg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790087997;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-ZohoMailClient;
 bh=plTBMLuDLp0k/uM/IeV/Dc93Cu+lBycRF3nRK+sEr9U=;
 b=Em7qLaJtCz6yZztKFqxLgCHtZXnTfkUHXclFCQAnWy/jAHuMuQs4YIYLP5bnuIRAr3PO
 da8C78BPmfiRLCZHO/X1/dIpE650u/H41UhbSsG+eTWjnFTNeV55wrFfd59cd98eUwHrD
 KZo7Ge+zLkjuKFI+dSa+v+zCJJMRc+cxeyz1I5DC/SLfekp6cAJ7GUnX3gPG7k6mJJWoe
 uLbQSvsuzS2FuEDwzqXb4joJ0TI3ntDnohMywBsHpwyx6u0oVgEccw60Hob7pZ9Fcvq8s
 mYEsObra53V0SbVp47w802lmY8o0kb/ORZ/sd1AYjShMGRceXB6T72Q4PL+9i5J/ZYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=KjLI6Lyb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
X-Greylist: delayed 85440 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 14:39:55 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=KjLI6Lyb
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCB8040759
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790087954; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a/ITxV2gti0UjLn2qmnal8ArC/dTm7dJ1QlgfzhRkRZGs0C4tJw58vs2qU2s8aWt7u8c7r/Rdf0YDSvXFP0HQhViG7epZNFoX7EP2NyQLk1VpUM9spPgJXpBEsMNRCmAIsvv4hb0pIgUEi+CbuZwhE2++QmAB7O46KNI58AuoTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790087954;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=plTBMLuDLp0k/uM/IeV/Dc93Cu+lBycRF3nRK+sEr9U=; 
 b=YsStSm9BaGGTRT+SSLNB3mw+2MK8I7m8dDtYMU20XYfYIGqLY0mzuRlJ8rCUW+lF/XgcZNFnZLdAByGvzaeh1OkDQG2EqCTAy+qadf1DF3t1a0pqMOrYg48lYiMvrKiyrl9Fqu86PtJ9tBQUNvyfSA+hXHfeC7ETJIoTdMl3UU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790087954; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=plTBMLuDLp0k/uM/IeV/Dc93Cu+lBycRF3nRK+sEr9U=;
 b=KjLI6Lybq0PEhguoTTYOifDuDlxgVmBQIdoFkYBYpKQPYlMZqzFEMPU/ffuFSzN4
 n2AjEsjVL0biFH8aDVny/ZNnwXSsfujZfz9MtJfdfJwv/0+OktdG73fAKjMHIi7rnr/
 /bPoZMDsVfpKEGs2eJbo+GiXZAIaHXm7+K+IfMnE=
Received: by smtp.zohomail.com with SMTPS id 1790087952703428.2350914432793;
 Tue, 22 Sep 2026 07:39:12 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/3] riscv: Add a common memory FDT fixup
Date: Tue, 22 Sep 2026 22:38:44 +0800
Message-Id: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqEQAxF0a1IxgZUaD+9FXFQVqU0DX5IVGzEv
 Vvq8PB49wAlYVL4RgcIbaw8jQFpHIHtzdgRsguGLMnypEpLFFa7oed9nXGgYZI/utJU/uPywhg
 P4TgLhf2J1s1rXdsf2eUuwXle1dj27XYAAAA=
X-Change-ID: 20260918-riscv-fixup-memory-d8a9f5d67aaf
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 u-boot-spacemit@groups.io
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=jpWe+246US7oXbHDIeSMuVJ1+vfBqxR21zegjk21ahQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2Tfpzscl07e41V5c26Zfs3Ba6zErvQdBD+ySRKbOfy
 qqGBeYYdpSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCRea8ZGVoWZn3hK5xS9t3m
 LkNL9XmlyLmTZjQ96yreIhL7l8WhcDUjw2XBc4emTOm1f2r7apfLsTfSV0L/xnqpzZX3CneIWvC
 HlRcA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

Update the memory nodes in the OS device tree from gd->dram[] in the
RISC-V arch_fixup_fdt() path, allowing memory detected by firmware to be
passed to the operating system without board-specific fixups.

Platforms that do not want this behavior can disable
CONFIG_ARCH_FIXUP_FDT_MEMORY. Do so for Microchip MPFS because its
multiple memory nodes are not handled correctly by
fdt_fixup_memory_banks().

Convert SpacemiT K1 and StarFive JH7110 to use the common implementation
and remove their redundant board fixups. Keep the JH7110 SPL fixup, as it
passes the detected DRAM size from SPL to U-Boot proper.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Junhui Liu (3):
      riscv: Fix up the OS memory nodes from the DRAM banks
      riscv: spacemit: k1: Use the common memory FDT fixup
      riscv: starfive: visionfive2: Use the common memory FDT fixup

 arch/riscv/cpu/k1/dram.c                          | 15 ---------------
 arch/riscv/lib/fdt_fixup.c                        | 16 ++++++++++++++++
 board/starfive/visionfive2/starfive_visionfive2.c |  7 -------
 configs/microchip_mpfs_generic_defconfig          |  1 +
 configs/spacemit_k1_defconfig                     |  1 -
 configs/starfive_visionfive2_defconfig            |  1 -
 6 files changed, 17 insertions(+), 24 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260918-riscv-fixup-memory-d8a9f5d67aaf

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

