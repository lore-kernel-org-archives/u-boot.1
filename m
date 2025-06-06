Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B09CC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D7B828F8;
	Fri,  6 Jun 2025 06:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hprwHNyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE5182977; Fri,  6 Jun 2025 06:28:27 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30940828A2
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id F03ED25EA8;
 Fri,  6 Jun 2025 06:28:24 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWbcTC2ET6Av; Fri,  6 Jun 2025 06:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184104; bh=vvbvvzGbzfxe02v3Fo7d1NSqGrnQD/frqKIR4Nbhb1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hprwHNyHUAe5GW9gWj0UccAUT2EYfdjuj3tm3eMcnKlj+ph9dqTUKooVURe203s1d
 WFdNZMYL/xfc3ONzGg79codqtESjH9NjC0BGktblRszX4kg7cnj1uWiAPBvAhCnOq2
 U7TOVY3hKVm2IIoyN2UfciKEFYkVRjW/v4CuHYu3gaghWAbfacU+xkujElwppBR3u7
 91udCmnf1mrBACEfwLInCoWclY3tIjxC0HQ4qdXEzlkUuQfXzAsDJPrxjwHW0q4Nmu
 VcCIDqD7L4lICWa6gCC4gkoyY+/pzur2NScnBAbNXN7W6Xh93H4DdBzsNYbnzsbdS9
 wp/XDQH6b8z4A==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 1/5] riscv: aclint_ipi: Support T-Head C900 CLINT
Date: Fri,  6 Jun 2025 04:28:00 +0000
Message-ID: <20250606042804.64311-2-ziyao@disroot.org>
In-Reply-To: <20250606042804.64311-1-ziyao@disroot.org>
References: <20250606042804.64311-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Although timer component of the CLINT isn't fully compatible with the
generic RISC-V ACLINT, the IPI component behaves the same.

As the CLINT doesn't have corresponding riscv_aclint_timer driver
available, let's try looking for a compatible SYSCON device directly
when no riscv_aclint_timer device could be found on IPI initialization.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/lib/aclint_ipi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/lib/aclint_ipi.c b/arch/riscv/lib/aclint_ipi.c
index dcd7e5e6b34..1c9a2d70301 100644
--- a/arch/riscv/lib/aclint_ipi.c
+++ b/arch/riscv/lib/aclint_ipi.c
@@ -29,6 +29,10 @@ int riscv_init_ipi(void)
 
 	ret = uclass_get_device_by_driver(UCLASS_TIMER,
 					  DM_DRIVER_GET(riscv_aclint_timer), &dev);
+	if (ret == -ENODEV)
+		ret = uclass_get_device_by_driver(UCLASS_SYSCON,
+						  DM_DRIVER_GET(riscv_aclint_swi), &dev);
+
 	if (ret)
 		return ret;
 
@@ -66,6 +70,7 @@ int riscv_get_ipi(int hart, int *pending)
 
 static const struct udevice_id riscv_aclint_swi_ids[] = {
 	{ .compatible = "riscv,aclint-mswi", .data = RISCV_SYSCON_ACLINT },
+	{ .compatible = "thead,c900-clint", .data = RISCV_SYSCON_ACLINT },
 	{ }
 };
 
-- 
2.49.0

