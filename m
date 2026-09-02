Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE115C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D1DE40806;
	Wed,  2 Sep 2026 06:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YflTqFzQsF_U; Wed,  2 Sep 2026 06:31:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330685;
	bh=obWmBThl8zHS9Ecq1cFFGhhASXFilgG+3j3kN1FZ+gE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpyG04AXBdrM+3ETXFvJaoqXmCA9D8gvCCsWO98YBP/eA4rhTKkzbC1zqg05mVzOg
	 B8IRMo12+XniwYzb4CqdyH6JmZ+EU3uJeW9nOLKlX6lENaDVzMFrXwLmbqUsRtYDy/
	 obo/2iQG96v43W0yXWyjYcKXW/ILXA0BgTq4ZFGL3kosjncMM1QX3WYL9yY2cXZvA4
	 T30AN8sizElhBA12z5R9sDkMzDVCWzDWSN+7iQsV1pwiCTe/Rq1B9UWjMLLhUFIYrD
	 1khoCXx1nip+g/ZIr0wCeTnPsSKjK7q/SFva+phKBfTOEPlutdE2dSxJUUro8anaTb
	 1lw9cW0c2N1jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27D67407ED;
	Wed,  2 Sep 2026 06:31:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE3C9230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0208607BB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lj3g3wVVP8_f for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.85;
 helo=forward102a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Hk+dvDkL
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [178.154.239.85])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7736760633
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:17 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward102a.mail.yandex.net (postfix) with ESMTPS id B8CF4C005D;
 Wed, 02 Sep 2026 09:31:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-Fx1M01FJ; 
 Wed, 02 Sep 2026 09:31:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330672; bh=obWmBThl8zHS9Ecq1cFFGhhASXFilgG+3j3kN1FZ+gE=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Hk+dvDkLarZ4pVOL+4b2ACxCB8XJgoan8pVSy3F87tszpeCFphRfZNTTj9Xp2J7R0
 YEmjBp8vZdqhwpesuyQGy9dRata8tJP4rG243Q0Q1uVLRrk8VPSl3SmpOvoQS6SzH7
 8gvlrn0uv9Ghd2X//AP3YFd6J44uDihapDihq+QY=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Wed, 02 Sep 2026 09:31:11 +0300
Subject: [PATCH v2 1/6] image: fit: allow IH_OS_OPENSBI in fit_image_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-riscv-full-fit-support-v2-1-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
In-Reply-To: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=991;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=/FrZQMGAsrKGtnFVpwqhnpk0eV3q39NYPHMOHOGguKI=;
 b=r8pgBh5J4dlW7iP585LMSHq41meNlsx7Lsqgq0Dw78vG9Q3D6IZ4TlJHY+CvOZklHCPdhjHwd
 nmugavz9fEyADKn2pL/tLMeQUvkjFaNnaeO5gM96aw6CRQC4ZlgvaPR
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
so that FIT images containing an OpenSBI firmware can be loaded without
error. Otherwise loading OpenSBI in full FIT Image is not possible.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 boot/image-fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..865edfeb1b5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2274,6 +2274,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
+		fit_image_check_os(fit, noffset, IH_OS_OPENSBI) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
 		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
 		fit_image_check_os(fit, noffset, IH_OS_ELF);

-- 
2.54.0

