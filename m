Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFECD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0052848DC;
	Thu,  4 Jun 2026 22:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="kTHR3Xx8";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="M16jsFYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B5A849D1; Thu,  4 Jun 2026 22:41:57 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525B184975
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605714; 
 b=MUCGSD+8J2HGsD/k1GzIHVkJu43R7x89ren6DRoB+QegQywwG90HqkHdVPqjTH1RS62IPTpyfS
 Fl8tIPHgOe3iRC1ExHXncvCr5kkdZN1HMkpSoRh5ZpSnnQutwFobebV8HpD32Yp+V9AYGA7VdE
 Qv/Hy26L/V/CfzrgZsU+exAgu5HcHCDDkfFIMS1TuspLLjLgQaiYZBQq2Am3rSAidRIysh/DlX
 /tcOOkpeyz5+m/Ej/HyWegQU05MthtIErhsXZlyAQ00+0MNXqGhmH4DC2MSdgakKnLCMtIzvjj
 7nE1VMB/ySu1g3QAhozsx2cQ4APK23SNUTpYDWhOBgIf4A==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780605714; 
 bh=j3H/w5t6lXVMxYjaEKGs1GSn4h8JP3QHzAJq7mvuFd4=;
 h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=fIrNXVIvnbie9Nbwkyq3e2asE0AoQfl/GywJdRFysGMv1vk1NXZImde5uxUiiKXgeCoSYBF4tp
 S892itmv0vGuaEilIA2DDqVX+0HGk+Fgb3D/tybSBKnvKMguZniqnmYjM9b8NbdnH8CIs67Wcf
 wZ8+0cBL0d8y1uvv9S/Ou1FOG/bqwWlerMNkEnLnwXyQ5awHGqm3592ldxG4UVWhdq24GCeGc/
 625+NkbeiI1XyWVocEt+A5fDeyvKzHcgQwbI0AMvdliFAntD/kMkXAqx9Sw3wXTSrnlV0jiaTk
 K2OtYEs2N+r6vr3xEG8/3JGkTzUQdkxzhSEySCj/gDXa8Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=mDefHH1UvDCmw3IazE2+p9SNeLHtzu1J/2QhF65818M=; b=kTHR3Xx8gO7qF/aPjvL5xl4ayL
 Q3kGU5cj5cwO2K9gBo3cfqdPpZmKqTGrD0NaLVulaw28XIJI0lQFzk6D7AF2tCZ1GLnDosNiUGIZW
 tfvmYISaDc5SBiTLv1uZ/7RqvYD0RlXoTGCZI341cJ4nJ+36fG4F9jSUrjOTREF/Mk8M=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <francesco@valla.it>) id 1wVEsy-00000007IsS-15Lo
 for u-boot@lists.denx.de; Thu, 04 Jun 2026 20:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=mDefHH1UvDCmw3IazE2+p9SNeLHtzu1J/2QhF65818M=; b=M16jsFYxhnmA/5oIAbgt8MG7Do
 hmw6RXMnyv69t8p3wb4v6EVOdge1dIJSoPzaPa6D+fAqTF6S+wZhJfJhkPuKX4G5vnICrPxCHRAM1
 xzJCgWA2o/RvsGcwU9vqaNhAKwOMza7Bzod8W77hi30yX+lTJo2GSU988reoPXUeN8xc=;
Received: from [95.248.69.182] (port=60898 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wVEsk-00000000GnV-22gq; Thu, 04 Jun 2026 20:41:38 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 04 Jun 2026 22:41:36 +0200
Subject: [PATCH 2/6] spl: fit: fix loadables load under sandbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-spl_fit_full_cleanup-v1-2-ec036b5872e2@valla.it>
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=francesco@valla.it;
 h=from:subject:message-id; bh=j3H/w5t6lXVMxYjaEKGs1GSn4h8JP3QHzAJq7mvuFd4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmKjxkUDr6paBcSedITuCbhvL6AtOuVhdNXnbs3d1d66
 I6e9GsZHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBE7ogy/FPyXer1+ZWMk8aO
 BUlVh90va/6ZemjHlWXaKRU+VnrT2o4wMmz65ey+VF/94LyZyisb//tu3Wau5MR17/ctwaearDW
 v1rEDAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: b1200159cbad14c56cf15939348af714
X-AntiAbuse: ID - b1200159cbad14c56cf15939348af714
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wVEsy-00000007IsS-15Lo-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dcpc.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Align the fit_image_load() call done for the loadables to the ones for
other artifatcs (firmware, kernel, fdt), calling virt_to_phys() on the
pointer that contains the FIT location.

This is needed to support the 'sandbox' environment.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe56a1..229eda0582f1 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -1024,7 +1024,7 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 		images.verify = 1;
 #endif
-		ret = fit_image_load(&images, (ulong)header,
+		ret = fit_image_load(&images, virt_to_phys((void *)header),
 				     &uname, &fit_uname_config,
 				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
 				     FIT_LOAD_OPTIONAL_NON_ZERO,

-- 
2.54.0

