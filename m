Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF7C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12BF8197D;
	Tue, 28 Jan 2025 00:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="KYFNuR6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3489C812BB; Tue, 28 Jan 2025 00:03:10 +0100 (CET)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5778192E
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738018987; x=1738278187;
 bh=oL9q3o38kmr+8O80uLMhlGZU7Sv/x8FzruaBKtnpS+g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=KYFNuR6zjXfm/i4ZEkQvDdjzW72NKkD8NC9ag6CwoESkiizMLIOS2MnozV1B5pavR
 uMHkXahhe8i7GzFc9VUL966TQ6E0cv6iDUbN1KkIDE/sGpUv06iCVXl3YvOM+qx2KA
 UgIQVkunO3lQKG2DKS5O5yhKOU9lqJWfeUIBFdqAlYbKKvtjpsE7Bxm5rAmnbprnbU
 H7no1/Iq+BJfq5YoOlkHQFIu7zj5x7mUMwG+4h1UrJsyx+zQwyyLCkp7SpkngL5iY9
 XNAWw3M9PqWRtcoVWhwEQrDEeGyczSJSiACQQld3VdlfEYambUpuMKe8InHETR0ajc
 2KA8Sjqy+CRww==
Date: Mon, 27 Jan 2025 23:03:01 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 2/6] armv8: spin_table: add hook for booting cores
Message-ID: <20250128-msm8916-smp-support-v1-2-39587f18cf0c@samcday.com>
In-Reply-To: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 1e949d0445cc01ff61c40a6b904e0412e5bf5f2a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Introduce the weak symbol spin_table_boot_cpu, which is called by
spin_table_update_dt during pre-boot FDT fixup phase for each CPU that
has enable-method=3D"spin-table".

This saves the board/arch code from needing to scan the DT looking for
CPUs to boot, and also makes it easier to bring the secondary CPUs online
as late as possible.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/cpu/armv8/spin_table.c   | 9 +++++++++
 arch/arm/include/asm/spin_table.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_tabl=
e.c
index 13b300f5c67a6dd257b2cb53350a7b5bafa3db96..f83ff456f26d41402b83f0e30a6=
5f8fc48e42fbe 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -8,6 +8,11 @@
 #include <asm/spin_table.h>
 #include <errno.h>
=20
+int __weak spin_table_boot_cpu(void *fdt, int cpu_offset)
+{
+=09return 0;
+}
+
 int spin_table_update_dt(void *fdt)
 {
 =09int cpus_offset, offset;
@@ -45,6 +50,10 @@ int spin_table_update_dt(void *fdt)
 =09=09if (!prop || strcmp(prop, "cpu"))
 =09=09=09continue;
=20
+=09=09ret =3D spin_table_boot_cpu(fdt, offset);
+=09=09if (ret)
+=09=09=09return ret;
+
 =09=09ret =3D fdt_setprop_u64(fdt, offset, "cpu-release-addr",
 =09=09=09=09(unsigned long)&spin_table_cpu_release_addr);
 =09=09if (ret)
diff --git a/arch/arm/include/asm/spin_table.h b/arch/arm/include/asm/spin_=
table.h
index 8fc61237e07559f267e1da1fbc8ee646ef08721f..3c422046b830a7a81d7de806ff0=
db92d346446d2 100644
--- a/arch/arm/include/asm/spin_table.h
+++ b/arch/arm/include/asm/spin_table.h
@@ -10,5 +10,6 @@ extern char spin_table_reserve_begin;
 extern char spin_table_reserve_end;
=20
 int spin_table_update_dt(void *fdt);
+int spin_table_boot_cpu(void *fdt, int cpu_offset);
=20
 #endif /* __ASM_SPIN_TABLE_H__ */

--=20
2.47.1


