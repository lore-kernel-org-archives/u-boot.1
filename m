Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76B6070989
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qvD/NIEL;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KZt++Fo1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373A5407D4;
	Wed,  4 Nov 2026 21:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 070padnYtKRz; Wed,  4 Nov 2026 21:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FF6B407E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793829172;
	b=DEZ3Mfaony9d5yTSThZERolBbDLGxMYmQ21Wju0X6oBVGkHDM00UWRVN+0Y1L8mVdw4h
	 RmNQkkJLwLALBRemjoz6WzScELNk583SVdnjvVL6/lTiUc9xv9EvL04863stpXNbUZ6M4
	 V0CjwGf8YTfTfugRhD/W+tYiU1eGZmFSTe0wdNJaeMiPhtJ3fGYrmP1ubZQP6NzC/R/v4
	 0xgunO3Ft6jKj1S2LJxMFkhNWW/+HOHFk7nhIUJoun2MyDOewZmJDK9V05YEe38oic4dT
	 cUqtgjXl7E+9TLH2wFVVJZxXuZz3TnBNsuI4ORcb0jmHxJBMKQZgTX3bp+9HjNgz1sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793829172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dApbbMgu0Wnh1ljk0DwB1IMGayU4YyRue/lrPRCFh7U=;
	b=stVPksievHKyPzNGp+QwK7JCuGRPaP6R0pyGITe9xU9C/Aaib1HkzsgcOnbh6J5TRrth
	 fYMm4z6b4cglaLqBIQSGax0xKiuH3A9PLtwFhuwGtG+rAv1yNFL5Z5ZLAdm3m0kzEdxBK
	 L9o5IayKJHx0WJqrSXLxmzX/J0cLWu/PY8DVU8+ppBlEJa7P3YD747YCF79h8Q+MhFhDi
	 dLQmVE84OleTmU1VvQPjfh4CA4z69LifEBRBgnkpYXUqBiSErwh78IHJU8v7924lMz8pu
	 l38/3CFsfN5hVW0Q6gkMDlxcVasBfhtFRV+MbOcBrgWABvun2WgCwujQ2c+7CWnE1mQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KZt++Fo1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793829172;
	bh=dApbbMgu0Wnh1ljk0DwB1IMGayU4YyRue/lrPRCFh7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvD/NIELQGTplRy4p1Pm4Fm0Ht1Bls2NBezm9UdBAZ3ncf+bA0+aUJ8j5BRGxjlCr
	 pDhB4JmkQIT9KTUZ3QOH+pEyy8kO0BQtHCHtQo1U3lsEoIo36tujP9bDAzghRtH+Oc
	 PcZ4S1pnCK5F5EvCoxdHr01n2MxW4dZS+Tgi6z+MBjyvl5sjv5uiII5T7RN6elwL5F
	 kW1mjHz5t7q9jb9bbfnL3wKWl43eOTw0HDE7lCi2YEXMKaP8apm3EQxMchgHlreGdi
	 dixC2buUU03K1NQApN+mVSaI+2nuhd+jAsr3gYLxKTohxuT/kHFDaYwlYrjCHD+Y40
	 rU3AvvTpFwhIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FF6B407E4;
	Wed,  4 Nov 2026 21:52:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5ED1362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93DE6407E4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQmziYdRPlrm for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8039407D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KZt++Fo1
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8039407D4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:49 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6de1fd5f572so557912eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793829168; x=1794433968;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dApbbMgu0Wnh1ljk0DwB1IMGayU4YyRue/lrPRCFh7U=;
 b=KZt++Fo1l4gqxA+8PhzAoF2IMbpdQIW0rHqAHfL398kr5b+MyfTitmVAObYWEFpndN
 exJiSzZrtEq/h/R+wsE5c9j5wt4gealtBy8AmAY4lh5GrUAHi2G89R8VyVOr98sd7ibv
 q8wKra+FQQvp6eUsK6yRGdnVKrNzWesDhjQanKfwAiRJ2rhKdnO5OjCQbzbOTG4+5+Tx
 +EFfNxLuI7q/GLhDNVhfn0Rk3NSTUzaF57OGhlDDql5gtMEet2tPaNwsOjFi58UPfv4P
 4VqjI56IJ6J2bV8FeaAhjVRCJc8VTyGzApStZNiEi1iH/tp03nZLlfhEsnpqy0RnKzc3
 XUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829168; x=1794433968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dApbbMgu0Wnh1ljk0DwB1IMGayU4YyRue/lrPRCFh7U=;
 b=DKia5ifI2nProKKqE5bzEpJ4JpuFmWwUvHcbmuu4qUGMvce3OOVWqYPhoJuEOcKWlr
 /+SBkczNGXtgN07IbsRrZEm6FLo2fI+6zDC4MGoJEis3aYHlQC/1+GWhxiCtwzWYfGjN
 t+1QnM6DCs1+tm8Iy/nSsbYQwuZhfWa5nIYwKbmMy2QB6P6hBiVX9ZCtATLvpd5M7Iwu
 f8sUOJc+FtoAz/DQDCR5jJq71Z+wgVOU76kind9OAupjC59R8KXYwNeHgh1bVtZSy6/I
 XWPuCnY84l/1EuroxnFktvp+tvUjKt+SWER0gbvSXYgGWPTlLgGeJWhwIVzp52tQ88eu
 kSrA==
X-Gm-Message-State: APuU4Z9XhBby3Inebpm0rlav9rXnFcumL6aE5wcDh4ZU//mBt1kbmeYQ
 pTeua3acYCG87M/w/qge8cfPZ0DHN9q/iIwW3org8oMT5zIzRbYMEm1qtyrVO6XJ/To=
X-Gm-Gg: AYBFou3zngkTPK5+HuqgNr81wfSZxCSTYMGLoEr1pZBoHh14aIqKTXjPoi16fPf+Chg
 mMb7/lQZeyHRM0XRspJyClLlAqiNMpAql2/QaxdHuk5qD60UhBgG6rGwS860w+brtQ9l3aV+i+8
 Bg5L4vEs9ACvGJ9dkf/SlyDluwf8dKGxzrBRCB8vaSuyHbBwO7wzd0frcHEVwrpkuA8NeiV3MaO
 7IfNvImfF3o7+PJspMAzPlxgFLmc7P8WGHK7W3UTMR8+N0VnKApTBwFDMHbYF8FEcgDkiPOm2/N
 ljnHn/lcoemrpht9E75TxGi4f9jeo7h5bj0FQWCporQno8ewl/xoq5VWItZ+13ihPxpJ2VHARsX
 2P2GjKgithcAJ/Lk8ekOZ+AUG7xXC7Wm7uiTRWCes0Gi/F0XDPr+DLAcPZfw5jHdr/LFd/BXamo
 efTxc0u8tgP+k44K+6VtMy0pqflOWBsKKrxrqcFx7IUCSyVhnkJQFvbCfRijxhnBxv+7PDS9wQ4
 6BXW44UE/0sKpWofOEMiuuCt/ZkymUM/lPKUQ1y/rDdIB9WKUHX8s40w3kto+vH4aa/5PXSoklQ
 V2VdCIb82OLVGTeTTWifk+b4wawlSOhd
X-Received: by 2002:a05:6820:1612:b0:6fa:ddda:4234 with SMTP id
 006d021491bc7-714f24b9ba5mr9772960eaf.1.1793829163524; 
 Wed, 04 Nov 2026 13:52:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2479415eaf.8.2026.11.04.13.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:52:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:51:57 -0600
Subject: [PATCH v2 4/4] spl: atf: pass the bloblist to BL33 in registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-spl-bloblist-pass-regs-v2-4-3126de1b77e9@baylibre.com>
References: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
In-Reply-To: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4152; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=szwoE/8rWRQyyY6zyu8iSW+P5h+9mZW/2jgaMU8UHiQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66kZjjNap+9JEEVgyxS16MhK+dfyc/79D5u7d
 xTBianaDIWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauupGRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMWgH/1TspFi7OfWH+rvTQ2QyONMMDjwH7kJ6RkV0uRO
 cpSfVJOoWRFmHbVmEWDEd6e/NMjuKr/1LsRGYlA+XKGRo4j9WJWEBMeQ4DQZRy9Uv6mSE9tZi5Z
 fEwHJlXI3qOzdbn+aBl5pVtwZokDCU/rh9LMzbzs5td/G4BWTVGJkAtvKT9jnpTxqxg701Cv0iU
 ZR9CaDRd+DBYQ64FAMPrFkU1I8T+DN1ydn4zhgvS9zzxOlv41GGjWeDN99+saqj1x1iwwstH8DN
 FlErpm7meJDZqYN3v6fFKoqvEhxTbG/3cRblNx8aD9/N9EdLz2RpwepO2CzyNH9LUfKoNzmXbH1
 hzOw=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make SPL_BLOBLIST_PASS_REGS also pass the bloblist to BL33, which is
normally U-Boot proper, when SPL starts it through BL31. Set the BL33
entry point arguments that SPL gives to BL31 to the register values in
struct spl_image_info instead of the primary CPU MPID. BL31 passes these
on to BL33 unchanged.

This is done after bl2_plat_get_bl31_params() or
bl2_plat_get_bl31_params_v2() returns, so it also works with boards that
provide their own.

Without this, the only way for BL33 to find the SPL bloblist is a fixed
address in memory.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/Kconfig       |  4 ++++
 common/spl/spl_atf.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 4180755525d..5b728cfe324 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1243,6 +1243,10 @@ config SPL_BLOBLIST_PASS_REGS
 	  specification. The next phase then finds the bloblist without relying
 	  on a fixed address in memory.
 
+	  When SPL starts BL31 (SPL_ATF), the registers are passed to BL33
+	  through its entry point arguments instead of the primary CPU MPID,
+	  and BL31 must pass them on unchanged.
+
 	  SPL works out the register values in struct spl_image_info. The
 	  default jump_to_image() uses them, other implementations need to do
 	  the same.
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index c1233b54cf5..00346779713 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -181,6 +181,39 @@ __weak struct bl_params *bl2_plat_get_bl31_params_v2(ulong bl32_entry,
 						   fdt_addr);
 }
 
+/*
+ * Pass the bloblist to BL33 in its entry point arguments, which BL31 passes on
+ * to BL33 unchanged, instead of the primary CPU MPID.
+ */
+static void bl31_params_set_bl33_args(void *bl31_params, const ulong *args)
+{
+	struct entry_point_info *ep_info = NULL;
+
+	if (CONFIG_IS_ENABLED(ATF_LOAD_IMAGE_V2)) {
+		struct bl_params_node *node;
+
+		for (node = ((struct bl_params *)bl31_params)->head; node;
+		     node = node->next_params_info) {
+			if (node->image_id == ATF_BL33_IMAGE_ID) {
+				ep_info = node->ep_info;
+				break;
+			}
+		}
+	} else {
+		ep_info = ((struct bl31_params *)bl31_params)->bl33_ep_info;
+	}
+
+	if (!ep_info) {
+		printf("Warning: Failed to pass bloblist to BL33\n");
+		return;
+	}
+
+	ep_info->args.arg0 = args[0];
+	ep_info->args.arg1 = args[1];
+	ep_info->args.arg2 = args[2];
+	ep_info->args.arg3 = args[3];
+}
+
 static inline void raw_write_daif(unsigned int daif)
 {
 	__asm__ __volatile__("msr DAIF, %x0\n\t" : : "r" (daif) : "memory");
@@ -188,10 +221,11 @@ static inline void raw_write_daif(unsigned int daif)
 
 typedef void __noreturn (*atf_entry_t)(struct bl31_params *params, void *plat_params);
 
-static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
-				  ulong bl33_entry, ulong fdt_addr)
+static void __noreturn bl31_entry(struct spl_image_info *spl_image,
+				  ulong bl32_entry, ulong bl33_entry,
+				  ulong fdt_addr)
 {
-	atf_entry_t  atf_entry = (atf_entry_t)bl31_entry;
+	atf_entry_t  atf_entry = (atf_entry_t)spl_image->entry_point;
 	void *bl31_params;
 
 	if (CONFIG_IS_ENABLED(ATF_LOAD_IMAGE_V2))
@@ -202,6 +236,11 @@ static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
 		bl31_params = bl2_plat_get_bl31_params(bl32_entry, bl33_entry,
 						       fdt_addr);
 
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASS_REGS) &&
+	    spl_image->bloblist_args_valid)
+		bl31_params_set_bl33_args(bl31_params,
+					  spl_image->bloblist_args);
+
 	raw_write_daif(SPSR_EXCEPTION_MASK);
 	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		dcache_disable();
@@ -309,6 +348,5 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 	 * We don't provide a BL3-2 entry yet, but this will be possible
 	 * using similar logic.
 	 */
-	bl31_entry(spl_image->entry_point, bl32_entry,
-		   bl33_entry, platform_param);
+	bl31_entry(spl_image, bl32_entry, bl33_entry, platform_param);
 }

-- 
2.53.0

