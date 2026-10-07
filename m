Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E37CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 10:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E29D940556;
	Wed,  7 Oct 2026 10:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fxb_mgBedIy5; Wed,  7 Oct 2026 10:39:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D517240528
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791369581;
	b=n0NeWE5WyOjCq82/y8UVaJMlhLTZ0D0YvnKiTzobH3sBZQs2EcTOMXG5mYFFuRu6IvGG
	 9KeM0I0HTYWczFE+yPE/85HxW2NzaSQa7A0nESMkkcVzdbIhNYBrEDm2ApuuSXPFvTwyC
	 tMPsFOrjusewrnClJRIDlEHetARIR09Tfl7kKnOCA76Fg+MXPTAnA2Y/nWzR81Yz7Faxi
	 +AzSiA7qUrDvwuSV3NuS7nzrEp2g0zToZz9E6uueMpXy8pOfXCXEWs/lNaosNKk0Amjik
	 6TaLnWZeBHB2TQWKoP0efrASJUjvn5GyWUWzP4azUxbtqv73izv4O1e4O+NxNbuq1Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791369581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A8SFMXls5ErntyjfRrNJ1EXdvhrL4XVMcOcKXDoTh5k=;
	b=XgLk+HpW5V1PbIOuwvAUwUk/vntGpZ1xOJP12mpHyjtCUY0xODc4vQsr/iJ7ge7Q1sFf
	 jKMVVCuUj5CI64nvDAWiXz2GGVcZSDKYX6BVOi+CR2h+xxoXWn5aMBQc7rcAuBK3Hi9xz
	 vAsLa5QBCqzqChK7kv4T8nE38FtbH4VadqMjIKAHKZaFZVZH3kQTDVgLj/5jcjv+IRqrO
	 rfMzzj+dmRffDUoZ/pIlHDUYNMv+AB164Ib9S5Te3ZncbjgzW+lISBIxWwhdSwvjqsc9A
	 kMAfpzX4kBsx8/ktXE2HsvZhB6XraiXhe+LM9YhVEZCH7LdOmshfU8ST78e+AmR9b1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791369581;
	bh=A8SFMXls5ErntyjfRrNJ1EXdvhrL4XVMcOcKXDoTh5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cqCFP8k7VcGq3NMNdKVxxTPkjrlN6xcz55QCOEM97sdDKZZHXz7bmtslT8SGgBKgM
	 /sDmu2XUVcjpA+bqCIWrX3bBb9iCXFsA6BkLjANSpJqJQqCrqhnm4ghg3TD6ZRiJKt
	 fzYydjKJvgONamys5mrUy8/fjJtFXag8EgHcCbhBZQdB27SPmh623xaB4Q0Q35YVU7
	 5p+S9CGB/wFiZPg7jCvQczrG+tXcfxklaAjApDWs3cW0zWjVt0GdYoCO2ra9XiLyjB
	 qks6E0Jca7qz0mOYSPhFt2IdRYM5/S4Alfmg9O/ISM9qHunJFXS76fP+GK3z47qiG/
	 bm3+RPhqDgBmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D517240528;
	Wed,  7 Oct 2026 10:39:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2EEF2E0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8E6E40080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:25:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HumE3EpkOFNh for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 10:25:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5E5CF40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791368726;
 b=YJN6iXZLzxLu4IiKqQsfZz5kUkjLc6clsy5/Y+BvfQxQ6SWMKNhdc5kJE7FUEmpUUuXe
 dgWJfNRzDsp/qut34alQSh1nxQ39Bo3nA5NXSCUBLdGLr4N7WE/9LsW//YCDmRCHI/87o
 xb8niW+5RX3NBAKAgvPyXNWwGC0MFpPYHkfZOdBoErwV374RbNie5a4l9Ys8gwgVT7EfV
 5A+ua95bbS/dU+9aeO3AlHzF/x1ZMXekfp3dmQGCck8Swd9EJfyrKnNI8rShcT7glMDJa
 oy9lI+AbiEw6yPf+9HzDacihGllDhFo/3n1pFeLtoYM4zeoJPTeAPCI1VGpj1q5k6Qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791368726;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=A8SFMXls5ErntyjfRrNJ1EXdvhrL4XVMcOcKXDoTh5k=;
 b=nwzlJ2XAV7+VNZI1hRCSHpJXL6PgMHocL6LMOGds5P35tFJDiqNUgFlCq9jZtQ112LdE
 AOLiEuiVqR56SfmeL4KynYaOwDsmBdzgB1RwkUUqVA21i7pUHO1kXULWHM12Bb8XjOEzu
 VhmAnddbW4uIU4ve9Ml44+YptTUSpxKNMPHnR8QXbuyZu/xcYs4Z5hXmXFSH96L8TI4cC
 LvVt4KD7eJcCQlBWUlkyu0KPzFpgecKTOrTWFF/OZkrkrTbvvFqg/yQ4W2QYCCD+f59M/
 9Kh5IZ0iFf0ccG7zwDbv0ekrTYQ7T816lMqXEJyqKg0chgZUkniK6w49WOG11eF2KSQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XUUaPxjB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XUUaPxjB
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E5CF40057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 10:25:25 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3a7fecf8440so986771a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791368725; x=1791973525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A8SFMXls5ErntyjfRrNJ1EXdvhrL4XVMcOcKXDoTh5k=;
 b=XUUaPxjBtIPTIGaX5nxUFwjV20Bj34BP8UygyErgHxT/LfK3XkfSsECNpuIEo+T87j
 UjX/zH0QbfpSZC6Qdte69eRnpRFT52d8fcpCZ4Aq/i1olBWeTaQGSiZlYC4H8qmboRQc
 oGUjD5I3q0fuZnG2Bnqb9NtGkaiq/dgAGOeklBWodfvMkf3PzTLnK3jlkll5R0fhuSRA
 a/sP0kUyD0kAFnEIPG17yaaoao6bYLM3E9i0u4VTCpGNjO/ueVGkkME/dIpemlp3Qfui
 lkQQsCPlBSTLzIHuWY3SAcSpw+57F6trWwMUg0WiBOSw0WcQK4Rord4W0co6iWKPWfgu
 YpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368725; x=1791973525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A8SFMXls5ErntyjfRrNJ1EXdvhrL4XVMcOcKXDoTh5k=;
 b=pIt/tQdyBGb0xjeIQs5eHSxesWKy6RAjc0THwTTPp3j3Sq/KrUD4k5bpowECJG92dH
 kBt2ttQbvf+Nzcg2yhUbAhHGUON1rAaG8NJAFaZJOvc8y62hq3oz/PJLHg7cGcIFCpBe
 EicaxWp4AfPtXPSMsuKOZYvESRXJ48wsVU5LIOExVo/Ot193tV3UsqvnRCEO2JuNxZpV
 /tHF/NCbRaUcgaMfYefd+AbTpZU3csLRWgT63jqjszJHN04p3Gk1QeRXK1KZ6jqgBKpr
 ZDLAmHTbaoivp8IZfvfFVn6ov9hljD1s6xeEZj+8zBnDUFYB6C3zPMem9Uz7GAeTw5e+
 Hdyw==
X-Gm-Message-State: AFq9FYJvG6VXr/x+fTyfjOH/Nyv8iYomjEXzQJ6hKQ1V8kKwKlTpjfuG
 lKdrcymxmXL5+8sR4y0I3Il7pINgo7QNE3dLygQbsGA05j9wwDQTMlIt7DFNKGMv
X-Gm-Gg: AYBFou3cZclhVI6ZxGMebB/YPN8BmjJ9IiYJqEcm83jYdPVpaVx9UXTXKPDI+wEh3lk
 EA5rlMswHgqPYsUE9cg21OLQJXpZTeWFtaTxQ93Fd7ku93SCFVawqzzg7TI3tmagJSpLQTlqoAI
 l/kn47zBtn+CZmvXKXr61XaYHFACY4wp5Ieb8e373kpHcUbmxuih/XUMLDeTAvMCzYKSa4Qv8xn
 tRIuGLs8VVO9aQECSG34XTq+b2bAFAGX/mspgwC/j98sxtCPBD7BILZAtgpbkDn0OvUvluiwGPy
 TjmcPr3WAuZr69mMaFYVgrD9vImjLQ76EnvsFsw/wdt1Don76LraUns2O/wSrbK4pTk5wbycB+v
 CziKrr6BUw4KMwlLvjKZK2k5LOIX+Rsab2NDjMlrumylF7nCInftZEuCFiIjbPobWw6TB11ANHL
 h1FMovyKf8mj3bZ/0eb1Tt/WncrVzL1Ug0VA85plZrX60dR0EMVzwi5V74MiEOKNlALxplsODGm
 h1gbF1q5vt7sn42LGBQClRbVLnIQdDYaNLnoZm2pMbYhqnkisN8Zfx5r34QZdCDSuWi
X-Received: by 2002:a17:90b:1c0a:b0:3a0:42a9:9c75 with SMTP id
 98e67ed59e1d1-3a8a1b5d361mr1390677a91.43.1791368725217; 
 Wed, 07 Oct 2026 03:25:25 -0700 (PDT)
Received: from myosdev ([121.165.170.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89d416348sm1727746a91.0.2026.10.07.03.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:25:24 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Samuel Holland <samuel@sholland.org>,
	me@ziyao.cc,
	trini@konsulko.com
Subject: [PATCH v2] serial: ns16550: enable clocks for DesignWare UARTs
Date: Wed,  7 Oct 2026 19:25:21 +0900
Message-ID: <179136869120.3.14517302706306659442.uboot-uart-v2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
References: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
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

From: Samuel Holland <samuel@sholland.org>

D1 needs its DesignWare UART clocks enabled before register access.
Select this behavior through the existing snps,dw-apb-uart compatible.
Keep other UART variants unchanged.
Allow fixed-clock devices without a clocks property.
Propagate clock provider and enable errors.

Tested on MangoPi MQ Pro.

Link: https://github.com/smaeul/u-boot/commit/0617377a2555031f02a459b3451fa33ce53e9b74
Suggested-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Co-developed-by: khaliforce <kforce@gmail.com>
Signed-off-by: khaliforce <kforce@gmail.com>
---
Changes in v2:
- Select clock enabling through snps,dw-apb-uart match data.
- Remove the proposed NS16550_CLK_ENABLE Kconfig option.
- Preserve fixed-clock UARTs without a clocks property.
- Propagate clock provider and enable errors.

Validation:
- U-Boot CI Docker builds pass:
  MQ Pro, RISC-V QEMU, x96q, MQ R, and AM335x EVM.
- QEMU console tests pass:
  ns16550a and snps,dw-apb-uart without clocks.
- MQ Pro UART input/output, clock gate, SD, GRUB, Linux,
  SSH, and repeated boots pass.
- Other physical boards are not tested.

 drivers/serial/ns16550.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 10271f46aa6..c631d9628ea 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -492,6 +492,14 @@ static int ns16550_serial_assign_base(struct ns16550_plat *plat,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+enum {
+	PORT_NS16550 = 0,
+	PORT_JZ4780,
+	PORT_DW_APB,
+};
+#endif
+
 int ns16550_serial_probe(struct udevice *dev)
 {
 	struct ns16550_plat *plat = dev_get_plat(dev);
@@ -516,19 +524,28 @@ int ns16550_serial_probe(struct udevice *dev)
 	if (!ret)
 		reset_deassert_bulk(&reset_bulk);
 
+#if CONFIG_IS_ENABLED(OF_REAL)
+	if (CONFIG_IS_ENABLED(CLK) &&
+	    dev_get_driver_data(dev) == PORT_DW_APB) {
+		struct clk_bulk clk_bulk;
+
+		ret = clk_get_bulk(dev, &clk_bulk);
+		if (!ret) {
+			ret = clk_enable_bulk(&clk_bulk);
+			if (ret)
+				return ret;
+		} else if (ret != -ENOENT && ret != -ENOSYS) {
+			return ret;
+		}
+	}
+#endif
+
 	com_port->plat = dev_get_plat(dev);
 	ns16550_init(com_port, -1);
 
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-enum {
-	PORT_NS16550 = 0,
-	PORT_JZ4780,
-};
-#endif
-
 #if CONFIG_IS_ENABLED(OF_REAL)
 int ns16550_serial_of_to_plat(struct udevice *dev)
 {
@@ -598,7 +615,7 @@ static const struct udevice_id ns16550_serial_ids[] = {
 	{ .compatible = "ns16550a",		.data = PORT_NS16550 },
 	{ .compatible = "ingenic,jz4780-uart",	.data = PORT_JZ4780  },
 	{ .compatible = "nvidia,tegra20-uart",	.data = PORT_NS16550 },
-	{ .compatible = "snps,dw-apb-uart",	.data = PORT_NS16550 },
+	{ .compatible = "snps,dw-apb-uart",	.data = PORT_DW_APB },
 	{ .compatible = "intel,xscale-uart",	.data = PORT_NS16550 },
 	{}
 };
-- 
2.53.0

