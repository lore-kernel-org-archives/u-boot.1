Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CFDCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3E076122C;
	Fri, 16 Oct 2026 13:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QjR-y8C9Tfz1; Fri, 16 Oct 2026 13:24:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B6FC611DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157059;
	b=WacdrxOg1CaJpM9J5PV2BsI3VvYpa6/QlfgvgvjvJULVpnIboLsCfSc7n00gADhFHXL1
	 weJYUm5hUC9CKtmtAbBLi+POFoNlvylLB7f4U1In7gXWe6Rj//i4+kJhboPQokobyNWHp
	 cnZYWUQ/Wr7Lzn8FVIje06BgTJgkot6TZDkHjjMl0My7AXp0bbJhigF2pUzGcgN1yumay
	 3w+2wb7QxpXW6NdMU37IlWWNiELbIfiyatwFBRiwQC04wzqv7KRbkbkwKU5SbdymrNbQb
	 AAgm6vCg0qThiXIlvvOgv4rWim8A1+j37K9RctA2SDTHSJSQzZP4rO0M3HIIxz0H4QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/kk7HOnRLnBu9xh7gP1Xg9Ul+E0GB0GrdeLhfGQE8DU=;
	b=FnzInc2P5eEl00Nor5ln9kGmtC0L3aaLmBXUBkYMmdpn3MChWGlqucxuJHINqxQWrWvg
	 tU0OVYJskRag6hanvCgvWZY0LOyb72hO6TLpbzwZrAklPvnwemDrUQSiPZIbtSNOfQfz6
	 RYFhePR1sMVWf5wNtZYKU6y/xJiSlhx1zGLAqmY8Li77HqJx93GUJoRhv2ym++9weeFJw
	 rRQrI2evRkVd8Z1dszdhkLp16sfiFzqNRDqSB2IrFLjsEqHWfZ7aHXSXDVRrWkPMhBkiT
	 jLFIDL8uOW9FYvvKLKpwbkcf9/KQBqfSKSrtdawbekHUY+hvZ/NclAkECYyt3EA5ySg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157059;
	bh=/kk7HOnRLnBu9xh7gP1Xg9Ul+E0GB0GrdeLhfGQE8DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XP0UGUwxhF7LxCTP47mZYz6ssITQUOONDAL0FksEhIqodO/TufMCpAuKF0Os1KSPf
	 0HqaGC+12C1cuRi05ivoIr0Y8NlT/AH+ewa2XibXeK86Ls4gxUC/3qrFznAw5BLBKW
	 CgGKcKoETFqeiC9oWHgJPrzxtB2heiHMd7Y0715+lYUsRrwPDlPtXknlA86+QB9+1+
	 TslZESiHJNOaTPFQpX15G8iWkCdH+lF9R/yDZioAG3C993XqV0rcyMuupyYguzMP6K
	 8CqC5InevcaufS+1Y2vz6WISgalc3wB/lHJjRqgDo5PA+JO4SbjnXzKJcj5qJLydpU
	 xZK7fS47QHIWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B6FC611DE;
	Fri, 16 Oct 2026 13:24:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C83DE362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE75F81467
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEaoInyRAkNE for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EC8E81220
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142223;
 b=U2YRgdGuJsmcDw1U1sXatdYa2c3QtHst5oil+gg0hZrsiC5vs8xxY2kGRSgj/MK0EMrM
 UM9RV9JjbzRyx2yNxITvs7cMwYcOudEx3rTqcbKC1zWYdPTec9NEee/zXltarMhDkHZ42
 pWMT8+WTvk8GtH2506jbHZKzQAsaqVk05EyC1ikgz28Eh3sERHh02SNp+Kipvh1gQijD8
 PxPjvu/MYyL1z3MO/4bHP1WNiWp7HSL99xj+E3swtco6I+7wwsMPgkugUGlRDY19hK0Ys
 zru8QUbNlrVvcvqyXfdIwf6Wu8japHPfbFC7w67kGkLXkZWe4cfS6K3u+BCgj9jtPuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=/kk7HOnRLnBu9xh7gP1Xg9Ul+E0GB0GrdeLhfGQE8DU=;
 b=ktCVyQoQy2tlkE1kxb1Myg6BblG3IwSwozfz4D1nP5+AOfL4hDMM1LLlY0esqv4uYFob
 KxBGva+y+XKxOL/TK3YOV8/HQHlBq90uOG3phSTeNPpMotfcuOHjepr6ozXkYM42V3MlQ
 NBHQY6WGRKpJV8zXlMZ76huNO7ECDVqF/3OIHj21J8Ugh1PdKhcTNCrYgPYi1n28WJKB1
 tvekcF/XckGbLLYlG6ZwvwnG2UEf3Kku+WoX+UeSx/6PJZt5jOwfF7xk83fy0a5omPUHw
 Q5+AD7vE8i9x8OAtmr2g6cqLNMzv50LyCxvXEvWlxaxng1e9lMiFcRYUuqUGk/WCzEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bip7DfXT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bip7DfXT
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EC8E81220
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:02 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so56527365e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142220; x=1792747020;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/kk7HOnRLnBu9xh7gP1Xg9Ul+E0GB0GrdeLhfGQE8DU=;
 b=bip7DfXTSiokMyqJMRQKkPWm1AuEFwyKwQJkJAZJjjCehTAPdsOMwMo2wWocvmrp0k
 +0vQ3P6j1AK+yXokKSVq+0Xc/pi3NRJVJePOSuoeHmKiCuv3G+jR9gz9gTnYluR9Hvqu
 wd9ZjSD64+zoHdp2W5vjWSjk+GGMsSrm/X2V3j24vLfGxasUXLWtnqPCwcrlxED0YgVx
 onwPg708/QkDMeBN9uXrQf/Qz/u786fT1Hfj7r39jYfJa+a3+KECHuxQB1WmevuuNTqp
 xvnl/SoNE7o+PcLwc50R9ny6RZqedcLaHNsOM8IHmfRf4pp52WAiO2fcWFe/+3F+3FpB
 zIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142220; x=1792747020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/kk7HOnRLnBu9xh7gP1Xg9Ul+E0GB0GrdeLhfGQE8DU=;
 b=XIF5gdo/Jmiy2bXHtpi3s57Uheiv9VWqK7rHu55Q1AuqOZ1gFpovJ6Q/cbrxtgPhh0
 eNhksasFwSnuNOH22drNa6d6wlxIuJ41ogSgATHnJy66/gbnHwOqGnF4CMJpapD2KVGr
 QuyKtFFwdmoLe+mg9XyL+87jiI7CI+8QhMgt9Z5qfm5OPXrzz2fGI4LtfKfJgiBaJXDT
 jHP0xikOTEyO8fo6GQdd3oyobhssZGc+UUcGSEcGj/9xVPAa0V3Hx6A77qIrSzvL9x7I
 bBEu4LgNpgALndfzFale750Wt6NjR00HKHNOgIrRCIfkCRhBoTUzznez8I9qmg3lbAU3
 5+DA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkxKQP2B5jlq0m8jXwrwke/T1X0KUb2Xaqz+qi96uNo6xmkQFYNyaoF+Lv8rsFRDs2mvZVr/8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK6EviGo4Gun/hbOmIksvASQo/xF2wTXV7lYLvWago7IcESPdDX
 PfziNoJalDEslXoZbEXyzSDlBxkXdjEjdJ9qBAh0AO/DjF2EZNeD5BMl
X-Gm-Gg: AYBFou2+2ya+9+WRm8Qi38Ys0Din3Bo8bpAP2pj5Et21nXIQplSs3ntu1cnwuoJGP9T
 nsms2LXWZPUyXowb21yIWv6yw+ihXyufE3hpo4pTWLYOg5L62djp6HXi1kr2gle7wUMNx86C2L0
 cl74xdLaye1Z+BBdrvqBTrvOzTrQwlAwA7NM8ePtWA0uT4NTICywLA5RDTqbGbcOqQMASPQrX3f
 bJas9fUu7v6d9DX3tbWBzkf0pYPnP4KkWq2wjHtztwQ6f5GCEe1pXaOUbWZeuWLxLqERqqm4LYA
 ubOSAfAF0Ew/IQI6otohOWgoW9JhlrREQ99CyXQqMRGRZUm3qjqKlHRhRR1LSF9jcgmmoiKymWs
 5MZrsAsmx1wF89kJd87YQN0dqsWkComtiX2YTyDY+aBmT/yAByUqh4Lj4y5euSEPUbf4nr3C9GA
 37SCsmYPy7GWwJRZXZPxh6rivzKk41IAFA0GyoFPgECtOrvSQwxnzDnUNM2VeCwWDzT1l8ug==
X-Received: by 2002:a05:600c:820c:b0:49c:fa21:1c81 with SMTP id
 5b1f17b1804b1-4a18e4d5563mr430330745e9.22.1792142219904; 
 Fri, 16 Oct 2026 02:16:59 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:16:49 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/7] sunxi: add support for the Allwinner B288
Date: Fri, 16 Oct 2026 10:16:02 +0100
Message-ID: <20261016091608.121842-2-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

The B288 is a dual Cortex-A7 SoC of the sun8i family, used in e-readers.
Its memory map follows the H3, but the RTC, CPUCFG and SID sit where the
A20 has them, and there is no SRAM A2.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 arch/arm/cpu/armv7/sunxi/psci.c             |  9 +++++++--
 arch/arm/include/asm/arch-sunxi/cpu.h       |  1 +
 arch/arm/include/asm/arch-sunxi/cpu_sun4i.h | 16 +++++++++++++---
 arch/arm/mach-sunxi/Kconfig                 | 13 +++++++++++++
 arch/arm/mach-sunxi/board.c                 |  4 ++++
 arch/arm/mach-sunxi/clock_sun6i.c           |  1 +
 arch/arm/mach-sunxi/cpu_info.c              |  2 ++
 include/sunxi_gpio.h                        |  1 +
 8 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/arm/cpu/armv7/sunxi/psci.c b/arch/arm/cpu/armv7/sunxi/psci.c
index 4c30f3294b7..18a93546f16 100644
--- a/arch/arm/cpu/armv7/sunxi/psci.c
+++ b/arch/arm/cpu/armv7/sunxi/psci.c
@@ -53,6 +53,7 @@
  * CPU state, rather than the older CPUCFG system.
  */
 #define SUN8I_R528_SOFT_ENTRY			(0x1c8)
+#define SUN8I_B288_SOFT_ENTRY			(0x1e4)
 #define SUN8I_R528_C0_RST_CTRL			(0x0000)
 #define SUN8I_R528_C0_CTRL_REG0			(0x0010)
 #define SUN8I_R528_C0_CPU_STATUS		(0x0080)
@@ -126,6 +127,9 @@ static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
 	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
 		writel((u32)entry,
 		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_B288)) {
+		/* the B288 BROM takes the secondary entry from the RTC */
+		writel((u32)entry, SUNXI_RTC_BASE + SUN8I_B288_SOFT_ENTRY);
 	} else {
 		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
 	}
@@ -144,8 +148,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
 	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
 		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
 		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
-	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
-		/* R528 leaves both cores powered up, manages them via reset */
+	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528) ||
+		   IS_ENABLED(CONFIG_MACH_SUN8I_B288)) {
+		/* Both leave the cores powered and manage them via reset */
 		return;
 	} else {
 		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
diff --git a/arch/arm/include/asm/arch-sunxi/cpu.h b/arch/arm/include/asm/arch-sunxi/cpu.h
index 768c6572d6b..7515d98959d 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu.h
@@ -21,5 +21,6 @@
 #define SOCID_V3S	0x1681
 #define SOCID_H5	0x1718
 #define SOCID_R40	0x1701
+#define SOCID_B288	0x1699
 
 #endif /* _SUNXI_CPU_H */
diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
index f023a4cfd93..559544daf58 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
@@ -13,7 +13,8 @@
 
 #if defined(CONFIG_SUNXI_GEN_SUN6I) && \
     !defined(CONFIG_MACH_SUN8I_R40) && \
-    !defined(CONFIG_MACH_SUN8I_V3S)
+    !defined(CONFIG_MACH_SUN8I_V3S) && \
+    !defined(CONFIG_MACH_SUN8I_B288)
 #define SUNXI_SRAM_A2_BASE		0x00040000
 #ifdef CONFIG_MACH_SUN8I_H3
 #define SUNXI_SRAM_A2_SIZE		(48 * 1024)	/* 16+32 kiB */
@@ -77,6 +78,9 @@ defined(CONFIG_MACH_SUN50I)
 /* SID address space starts at 0x01c1400, but e-fuse is at offset 0x200 */
 #define SUNXI_SIDC_BASE			0x01c14000
 #define SUNXI_SID_BASE			0x01c14200
+#elif defined(CONFIG_MACH_SUN8I_B288)
+/* The H3's SID address, but with the e-fuse at offset 0, as on the A10 */
+#define SUNXI_SID_BASE			0x01c14000
 #else
 #define SUNXI_SID_BASE			0x01c23800
 #endif
@@ -86,7 +90,8 @@ defined(CONFIG_MACH_SUN50I)
 #define SUNXI_TP_BASE			0x01c25000
 #define SUNXI_PMU_BASE			0x01c25400
 
-#if defined CONFIG_MACH_SUN7I || defined CONFIG_MACH_SUN8I_R40
+#if defined CONFIG_MACH_SUN7I || defined CONFIG_MACH_SUN8I_R40 || \
+    defined CONFIG_MACH_SUN8I_B288
 #define SUNXI_CPUCFG_BASE		0x01c25c00
 #endif
 
@@ -144,12 +149,17 @@ defined(CONFIG_MACH_SUN50I)
 #define SUNXI_HDMI_BASE			0x01ee0000
 #endif
 
+#ifdef CONFIG_MACH_SUN8I_B288
+#define SUNXI_RTC_BASE			0x01c20400
+#else
 #define SUNXI_RTC_BASE			0x01f00000
+#endif
 #define SUNXI_PRCM_BASE			0x01f01400
 
 #if defined CONFIG_SUNXI_GEN_SUN6I && \
     !defined CONFIG_MACH_SUN8I_A83T && \
-    !defined CONFIG_MACH_SUN8I_R40
+    !defined CONFIG_MACH_SUN8I_R40 && \
+    !defined CONFIG_MACH_SUN8I_B288
 #define SUNXI_CPUCFG_BASE		0x01f01c00
 #endif
 
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b0c5d3cd903..ed2402f71f2 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -490,6 +490,18 @@ config MACH_SUN8I_R528
 	select DRAM_SUN20I_D1
 	imply OF_UPSTREAM
 
+config MACH_SUN8I_B288
+	bool "sun8i (Allwinner B288)"
+	select CPU_V7A
+	select CPU_V7_HAS_NONSEC
+	select CPU_V7_HAS_VIRT
+	select ARCH_SUPPORT_PSCI
+	select SUNXI_GEN_SUN6I
+	select SUNXI_DRAM_DW
+	select SUNXI_DRAM_DW_32BIT
+	select SUPPORT_SPL
+	imply OF_UPSTREAM
+
 config MACH_SUN8I_V3S
 	bool "sun8i (Allwinner V3/V3s/S3/S3L)"
 	select CPU_V7A
@@ -579,6 +591,7 @@ config MACH_SUN8I
 	default y if MACH_SUNXI_H3_H5
 	default y if MACH_SUN8I_R40
 	default y if MACH_SUN8I_V3S
+	default y if MACH_SUN8I_B288
 
 config RESERVE_ALLWINNER_BOOT0_HEADER
 	bool "reserve space for Allwinner boot0 header"
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..c2b01896da9 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -153,6 +153,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN8I_B288)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(4), SUN8I_B288_GPB_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(5), SUN8I_B288_GPB_UART0);
+	sunxi_gpio_set_pull(SUNXI_GPB(5), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN9I)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(12), SUN9I_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(13), SUN9I_GPH_UART0);
diff --git a/arch/arm/mach-sunxi/clock_sun6i.c b/arch/arm/mach-sunxi/clock_sun6i.c
index 657736c7ac2..d8e549a0adb 100644
--- a/arch/arm/mach-sunxi/clock_sun6i.c
+++ b/arch/arm/mach-sunxi/clock_sun6i.c
@@ -305,6 +305,7 @@ void clock_set_pll10(unsigned int clk)
 
 #if defined(CONFIG_MACH_SUN8I_A33) || \
     defined(CONFIG_MACH_SUN8I_R40) || \
+    defined(CONFIG_MACH_SUN8I_B288) || \
     defined(CONFIG_MACH_SUN50I)
 void clock_set_pll11(unsigned int clk, bool sigma_delta_enable)
 {
diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_info.c
index c3a51d9956e..7c04105ad6d 100644
--- a/arch/arm/mach-sunxi/cpu_info.c
+++ b/arch/arm/mach-sunxi/cpu_info.c
@@ -86,6 +86,8 @@ int print_cpuinfo(void)
 	printf("CPU:   Allwinner A33 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_A83T
 	printf("CPU:   Allwinner A83T (SUN8I %04x)\n", sunxi_get_sram_id());
+#elif defined CONFIG_MACH_SUN8I_B288
+	printf("CPU:   Allwinner B288 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_H3
 	printf("CPU:   Allwinner H3 (SUN8I %04x)\n", sunxi_get_sram_id());
 #elif defined CONFIG_MACH_SUN8I_R40
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda4..ad2bd0470f8 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -116,6 +116,7 @@ enum sunxi_gpio_number {
 #define SUN8I_A33_GPB_UART0	3
 #define SUN8I_A83T_GPB_UART0	2
 #define SUN8I_V3S_GPB_UART0	3
+#define SUN8I_B288_GPB_UART0	2
 #define SUN50I_GPB_UART0	4
 
 #define SUNXI_GPC_NAND		2
-- 
2.52.0

