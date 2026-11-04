Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B46070995
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t5olQeKa;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dbl8wDdy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F15B240797;
	Wed,  4 Nov 2026 21:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9SAQFK8B7xe; Wed,  4 Nov 2026 21:52:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B543840786
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793829163;
	b=KlxBA+Wec2rgH/vQgjjHNJAu+D196UsFJoH1Wo64IgUYKABj16zr8u/PgEG9kajmAK5R
	 XhL19T8ml+zTSd3R+79XMhnlshpvrV8pBUdq1suhOw+pKhp7LXbiLp0KIRhR+Ap3aAetK
	 3aXvO5ZAgh7vDLJ6+Tb37PFK4NWsg1mWCDCuDQLbfwttRMJdAMCH3S1n9vJJXydO1uyia
	 CVOgtT/mjGOWQCq8YEfCHfNj8i8eVLLdJm61eI2Q3j9q0BsQccIr9EuEfhmUpks/B0Epf
	 CgbZ2372y6+817PaEJ9hSZUGL/Q0/IgTRNeYaM4V38AvwyRCCuG42zzRjae0D/g8+rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793829163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
	b=fcsQU+ODAN0QR9NftiUpPCOSExqcNvQ6nH1Lc9dgXz7YoqfXCNq2gJUJPsbyW8uXrimI
	 j+9Avvgyve0qdk3WASZICVtJyoKjzXGnWUEuYCLtGvrFpUmg/gs4cGQSWAJJbvBccd0t9
	 IwxD731rB3MW6sAizSwIYQ5jpSTFHjtXQ7SyEbp97vrvMhjagyOt6ncE7urUktgWCLWlD
	 G2nj8wYUtfIuuxPGwFaNBnog1hxMSCu9Xn3OQuotFvv6NpiIOCzTvvkNsc2uXKXb1jptl
	 Uqy/p9ehFW6YRPxOo9eGChPUKwFxjXNMVbine72L99hsSPeJDwy/UfmTsIJDRifn8yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793829163;
	bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5olQeKaPCErdGAhqDA50Er8ZCnj7OlaK8ka8GYrSt+Wp+WaMksDwyyOj2tBYmKgn
	 dA4C/+NYnDxKt6aGkOkZM3ykYthy19P22vrOa5GcyUBjxGpUzBwi4++JrSLsD8FpFk
	 ow1bVk3PMv5qVXIW6gkQx5SrVGIIOlAVfC9yL0GPlnaHK2XSpSVs78ghCt5asK/3DE
	 IaGPPQ22hS+0MvNkqFG9/AjlvyZ6HRY+KLjkDkNjLzsYJSaXQ0/XJpc/ren/gHouTu
	 v0zwd2Vxaj6yWAZ58i+djlTKj7l7mjUqzUaGxrIlXpRUw6BgyuNv0MrB3C/aWe0cM8
	 GK++oOcDBs2vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B543840786;
	Wed,  4 Nov 2026 21:52:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 497BCB00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F356606F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8L43nCFJnr_d for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87ED9607B4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dbl8wDdy
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87ED9607B4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:40 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6f74f6b46abso679637eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793829159; x=1794433959;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
 b=dbl8wDdyXIRtMMsPuNDdQ28zJVs8Ffi5sWzHXyeR0RWJI7S32PRDmd7m7jRQG3y8NU
 5O+Tr8cda7febUCgnx8TJGHuMz6JPTfddR32d/emyMEo1vnhncO1pjuvkogEEimfukKR
 x63QUS2TANxJByLGYGPdsRMX//WYGxolrtTHqn5S2nrQR+r0a04O2wVxETuHQx2Og1Be
 +KVQwNRWkTHl0xuxiOdnDbzQNr548/d7vqBW4D3TcfK9gCKOKxLZPlwEkQVtqK2yCQHN
 FhGEGm46ebRp5lkGOjRB4WjPaQ62AhJf1LGCsglcugbBAX9RBv0kq/2dow6DaNhcB1HH
 N5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829159; x=1794433959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
 b=2FpjzlXATw1BcbebpS741fbK0+umOI/l/fOnKyVTkcnM9IZx6cM1R8kItAVWRc941Q
 /+4+hKOKYJ/yOqGqXQCjdTgMufpEz5PnoVCZ5GQkB0qOePNneX7vIJ4nbSNDchOfdFQS
 ebxCdSoJCMmeGtgU/r40G2pQBK5P14Rgj9VTUz7o2nPioX4AA1bSmghV9AIhEnFMSLHg
 Iyn3gYqv3c5XSQJ+tklXkPEQD6+4Ws/Gs0c/65U8TtYpnuqKcuWd/imco/9utE//Mq9a
 0bWrfAfBK25+ElU2Iysb8jZGT4YMWEEjkSud4LjdRnvtp/4xkJC9D1qBPXQxi7kCaq4R
 nAgQ==
X-Gm-Message-State: APuU4Z9VypStNygbFBB71d1CVv76ZJIKW3M1RORkOQ5Bp9r1iUP0JNQx
 5uYGNjaOVK6YCTknfRA5cZsMOlP4d/219eLKOqPkrLtgXxEzaFz8oOAwF471BfshgNg=
X-Gm-Gg: AYBFou0Ri+245YiIgLWbdZQdFq1YEUU+ki0EbWsNTrknR5q8SNmxxOW/Uf/ccqDYJwb
 ho1VMpRzR06KKApwqfFFBIZ82MzynI9MoFolpgzIlTclpsKeo9OcBjC6LbY28aR45T3IE1d4z4u
 YfpTBQHFSLdKsfEOBN1jbcj+BK2zUURVLr7IXcGzSbO4yVKOxgDXi1ftKuEiUBwSXQNkO/AZ0T9
 08dpzVFm3OfMAxtUwOq0DQmOMj0e1d32Bbp2zKDMnUn338b+OofeaZtXQA2TmR8K2GZzi0Z6kkl
 KDb8RPzPBsV2LP0g3QTpzD0DpY6xziiaBTtuUlSupbaGLxEQTRmRJfP4nsP5mBMURAVkN8hM9TL
 NCAPPIKGFjEV2XhOD2JvXkMt1BE5XM0hZ70LgYL0vmQVyUwja6l7V87hySKgIhoQPsq8kB01YO1
 /blqCXlafbvowk27PgeAqn8eG1WdITIJ76m9nFaigQCf86rPUIoxYcOc4E38FmKLDhmTv47IfZF
 5qcYekSmcA/y6wRqXApoVolbY4wLYMnucqo4b3TQxxKwRE6Uj+JJO7ltt/79xVaeKHvXqc0u0oX
 FgX/sHKFiwc/OiKKPCzcpz9UPO2mD12U
X-Received: by 2002:a05:6820:1626:b0:6f7:e193:831b with SMTP id
 006d021491bc7-714f2928182mr10468345eaf.39.1793829159050; 
 Wed, 04 Nov 2026 13:52:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2479415eaf.8.2026.11.04.13.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:52:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:51:55 -0600
Subject: [PATCH v2 2/4] arm: add xferlist_to_boot_arg()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-spl-bloblist-pass-regs-v2-2-3126de1b77e9@baylibre.com>
References: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
In-Reply-To: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=icF+Wc/p+Kf2Z2Bn8mW4RGAgkBrKyogzSsHa5yGFJEc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66kLPc3wOIcTFNiEyjTHIA61d5JxTdT6APLsm
 2wvR+z0wlGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauupCxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADFQH/1xh/eBB0BL1DdCgzvFAx8LDBSDwi4iZ6zdpM32
 opb0L/61ZwPIrQvS0bnwcL1Ka9B4w+9xGaAimX/prGVv3W+z40wCf31Hk6Zx9OT58COwAu9DfaK
 ni7DNUjspViLWilUUwvYzWmWZVHo/DrsTS10CAIFp9M8cRqXnCjq8DyWhDs6bmljb+7eziwROk+
 6hsOJgHHXK3OsA3+FmhnaKMooDJmvP8y50ujmAy2OcVsRIsQhENl9Rowew3A77sl6tLTljv0Kbl
 BXqd86iJG0dM+IJtv+h1QFjHmu87ZTKZ64OMmbUVlKrPT1+dmfAhro7fdp3lKHASLXiNdKpDVdL
 ghV8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add xferlist_to_boot_arg() to fill in the arguments for the first four
registers of the next stage, so that the bloblist can be passed on with
the register conventions of the Firmware Handoff spec. It is the
counterpart of xferlist_from_boot_arg().

Add a weak default in common/bloblist.c, which returns -ENOSYS, and the
ARM version in arch/arm/lib/xferlist.c, so that other architectures can
add their own later. The ARM version uses the AArch64 or AArch32 register
layout from the spec.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/lib/xferlist.c | 23 +++++++++++++++++++++++
 common/bloblist.c       |  8 ++++++++
 include/bloblist.h      | 11 +++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index 6425936d354..260e7f14dda 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -21,3 +21,26 @@ int xferlist_from_boot_arg(ulong *addr)
 
 	return 0;
 }
+
+int xferlist_to_boot_arg(ulong *args)
+{
+	ulong fdt, sig, xlist;
+	int ret;
+
+	ret = bloblist_get_reg_conv(&fdt, &sig, &xlist);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		args[0] = fdt;
+		args[1] = sig;
+		args[2] = 0;
+	} else {
+		args[0] = 0;
+		args[1] = sig;
+		args[2] = fdt;
+	}
+	args[3] = xlist;
+
+	return 0;
+}
diff --git a/common/bloblist.c b/common/bloblist.c
index 4269a49ef99..d649311ed74 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -578,6 +578,14 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 	return -ENOENT;
 }
 
+/*
+ * Weak default function for passing the bloblist in the boot args.
+ */
+int __weak xferlist_to_boot_arg(ulong __always_unused *args)
+{
+	return -ENOSYS;
+}
+
 bool bloblist_exists(void)
 {
 	int ret;
diff --git a/include/bloblist.h b/include/bloblist.h
index cdb5764cf55..f143c7cf03c 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -560,4 +560,15 @@ int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
  */
 int xferlist_from_boot_arg(ulong *addr);
 
+/**
+ * xferlist_to_boot_arg() - Get the boot args for passing on the bloblist
+ *
+ * Fills in the arguments for the first four registers of the next stage
+ * according to the register conventions of the Firmware Handoff spec.
+ *
+ * @args: Returns the four register values, in register order
+ * Return: 0 if OK, -ENOSYS if not supported, else on error
+ */
+int xferlist_to_boot_arg(ulong *args);
+
 #endif /* __BLOBLIST_H */

-- 
2.53.0

