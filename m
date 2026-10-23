Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA8606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x4l5Pze2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NJ6tS85u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8D6B812DA;
	Fri, 23 Oct 2026 11:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WUqAHH1rh03; Fri, 23 Oct 2026 11:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25DDC812B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754179;
	b=qYPJBmMZ5Ml0uYaJUpDOTmDr6g1cm7iimo6a92i5bpzY3v7zK4tenlgOksazojnfOe9q
	 iQIBycVRwOS0YFpyzOYS78JKcDptuqUjx5adbYmZH5xKkCENvFcdL1I0ydmmAs3sc+Nro
	 HAWsW0T8UlGlbLE21ypqR1OH39u/1s3Y1kKXUa5k37WJLlv+fXOlAv7+JjAWECE8dzNgl
	 XiGU20wcttUeOVuPbGHlTPb+PNZU4ws7K1CKa44gc8i0EIzDurrCW6g0IQYoNkD+9OtfW
	 8k7VzwmQucWUaz6kmzJWjqRvEz+JXmCaO+97WdSuBapFfJNtg+WKerlOkUekKutcBnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y4A5Xge2hYCF9RgmMvRKh5IAHCyXyOKeON+F61O/n5g=;
	b=Nd5R2hHkk4sE17VE4mdRPFCXKQy+pfa/UCe5EmoPUyX+Zfb5MG0/GQbqFoK06qHWq/jD
	 2JN3pyZxBkOUm4CfyuL3FfydIFGhy9wpPfC3kyi+O43THFiAyUHpjXkJx/Ng4veIQB+RF
	 fpeG/3c6d9u004j1caQDNChqthJ4JZi7feAVzHI1V+1I5VhqNtAZqrCFbF/ux9PLCOxNW
	 tdQoeZ0C5iDfyH0y16FvoEOXbz7WiZu1IXSE36dneVemTRJSWQDFAgRMYA1cGrjDbRnhm
	 Y+C3I7AuSMf+tWc1N6upTNOpD+uq19je7cHypf4TndPBEARuy6eteE0OtUqqYfu2mZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754179;
	bh=y4A5Xge2hYCF9RgmMvRKh5IAHCyXyOKeON+F61O/n5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4l5Pze27kQtOO10hL7Dr9fdE6WMTj+7ZA+AcC+Oafxup5kwY3QvV8vQa5Vx2FYtL
	 JHwjXwV5zCgFnslOfUNtCDuFtTfRTE+r9po3HbwSCpe5HtRssnCVkzSZCH1Duf2+9D
	 GcaN1UX9Ouenpp/EKv/9Eew+EOKx7kihb4SKl5U74dNrgtUeFd1A0Y7GnyIVJHHzHt
	 IZvYocJg7y4mtXK2thCOPM1UMq4fn+2smwz4a3waAoqyExHC4gu3MNTqfKTJZbPCPe
	 KCGcukSkCXoNF0B1fiS5uN8LnBoGFD5TQ4SDYnQF6jOIlg2jatAZpVi5GsbrvtSLAA
	 W5iy6TsCgEoZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25DDC812B9;
	Fri, 23 Oct 2026 11:16:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A88E43AF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E6F64083D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JfrI6PaCE4k for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 845F64083B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754171;
 b=H/Lg/t4XFcA7Z651iR/tuPgR6S1zSOE8w/bpAw6wE0GjhVOzUUC8Dgm8R5SyBKOaVHZF
 h9pgEJCpGfsz/76SWbYTgu9mVppxPFU+z+LrDG33zngya1bK/OhV18hn5fbM/XF1Gadke
 SSSr8QdlgAEWMpbKYTO4vx0tbNvUxK/X+IkufziP2ZSxTsnW1R/tp0PfB0F/padMttfs2
 WpCeXNkiAtNCn7lV09Z2BUbTtYWJuNv9zog6zhVXUald+hZ13aTSfOC+bplXikSn4LhzG
 CiOe8LY8B/GjzFqRuwY4bpSQzghm2+IxVFW1e7QrVpMrkce1iW/lGYdsF9muev0H0Ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754171;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=y4A5Xge2hYCF9RgmMvRKh5IAHCyXyOKeON+F61O/n5g=;
 b=UeLxoqhdpHLWAd9g+KdmiGOH0G0GHxyeNUHHXOMpfEshrXsVgaiR76cg/eYOsOLRjFGF
 gvvZodKHwLSHfOHmJNXNQYIYrPjTU84+JjLBxj4hIZdy+MrGTPx5eRu7iCNTv0rSkXcBy
 a3/tK7GlPOf3hZ6XR1kjXcmHnGMBzm3837XtWQKCizRu1FuEVQoip6DEC7hxkixnTOvbP
 AeklYxPmxhcIaDpvXchcV7Ie9ccw/BYwxw0ea6VV/wgtg0EYtydVL17jJARymXIwHPXqw
 yIRSkd+R1DEtS/HrEgLsC/G/X521WMXNdB32fhTwARR1oQ4e+B8ujNfPLadVN1ojasw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NJ6tS85u; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NJ6tS85u
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 845F64083B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso7837215e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754168; x=1793358968;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y4A5Xge2hYCF9RgmMvRKh5IAHCyXyOKeON+F61O/n5g=;
 b=NJ6tS85uPIgEPgnWdJNO+mYNhvwIkBXtHJWDlQnhljUzZMfq09IZ8pU5gdMsbpcPvk
 d+7RDlbQ8TNAb++m/W8X0mYVzzEZ1pgsDx2I3nmmkL+yzWCQNabrd7ioyYE017rm4ioW
 s7ORdbcak6u5bV5W9nosVBjc3wtFBgWb+fn9GT0pY4z7BgwS1/YiN4w0XfRT9nri34Lw
 8pq0Qcd0PvN2fpsDq3SRQT5mOeLCZHLCbxgEDkrLhZ4GN7zYoMfyFFwaQeYTP9TlOqd6
 I3Zdk/xoM08kfcXBmBl/pMsyMYsL6WzygZajg/GME836B5FXKYw66/3k3SWpYCX9F4zi
 RdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754168; x=1793358968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y4A5Xge2hYCF9RgmMvRKh5IAHCyXyOKeON+F61O/n5g=;
 b=gQD9Oh4RY2dOR/i/67fa4jpKq46mbjExnOLFebMGif4jf3r++0c7M81UB3TIjdqn9b
 SWZiDBlxhJ1OYBdGGB0lRLkUhsIPzRbWVevM9/XI97r5W5yju/FvYwyjefzp4KMtCS2r
 ZbM92FeQ8F8CkEW1PBVeUMxUP9TCxM8VQMu4S5r+LtqgsKBR1e8BU2CxEs5i0H20rkVe
 F+F4UdWhNNdq4PYb47w/HnuW8L4B/8mEOpnwAOZ/FdSbMZHAjNEgOal390nKznqqss+Z
 QLaXpF863r2+ZYqbTMHfg6kQcJ9xpddoSkb8jrj3tVyh4F10l8ktHR9lTZYGJ8O4That
 5Rnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+ixNgcbIG/vl7lQyvYSNtwVYLN5itsJLvhxDWvVCjpHGmOICM0XxUDgb1atox/xPofVeiU/U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL15EXha2NuqjouHXWXlXzjqWEYeeUYpJmWYGPlYtiAMY6IwRnv
 HdCaww+Q9p+mnmyvL7L2rDKSZCxqBAcjvYWTA/2lo+HY2WiEWip2WeQY
X-Gm-Gg: AYBFou12QrXafSGfmPjKTZK7Ebenm3nkJF8Y3FZXq1bnpBMwe/UUktGQ1Vf4HhfBQgi
 MYvJ7IdDsdpAR9PDbh+fUvTcZSNufyhXqo3MHKMG+fZcU4cIS66Q+ybQLcrUpzz/LBCiz8bOpCq
 V2RVRxqQkV2z3LjHPO+ZhLUw5dApY+ODhddOR7booBSMhTnhfgH+Z01nDzVcgsZ+dx7K4hflgmf
 mtbP+a+8++e2NRQkVujgaQYy8bHTnR9BqkrkQ62tiBTX9GCk4rnC9OD0oUVEkSCeyEKQ5gdhcsX
 pvST3bOHScT551Z1grgozgrsSodxpvDqlbQXcISYOu3c63WKidaydkZBc9K/pXJl5b74A/1A95j
 ZKYRWKq3O98A5DwPyDTdwCtWvYKA5gHhU3GKCEk9y3rgJ5j7lKi5ab17B/b9YABhlJCQaUDswxX
 iiHnRHkrnsWoVu999HEWDWE3LeuoHk716IhepybAN+3J7wmP1Lfog5Tgv8xmK/ocwjCCmc5TWOj
 t4PoypaTkUsVuxCVZIM8AuVHm/aoemJHK8xz/j6c3wlsb6/LDEZxSIom21ueQ==
X-Received: by 2002:a05:600c:e547:20b0:4a2:1196:db0e with SMTP id
 5b1f17b1804b1-4a211edd498mr20389405e9.30.1792754167848; 
 Fri, 23 Oct 2026 04:16:07 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:07 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 5/9] usb: ehci-vf: use usb_get_dr_mode()
Date: Fri, 23 Oct 2026 13:15:55 +0200
Message-ID: <20261023111559.4081795-6-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver parses the dr_mode property itself, through the flat tree,
into an enum of its own that mirrors enum usb_dr_mode. Use
usb_get_dr_mode() and USB_DR_MODE_* instead, as ehci-mx6 does. A
missing property still means host, for legacy device trees.
usb_get_dr_mode() does not tell it from a value it does not know, so
such a value now means host as well instead of failing the probe.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - Reviewed-by from Marek
    
    Changes in v8:
    - usb_get_dr_mode() is read once and USB_DR_MODE_UNKNOWN falls back to
      host, as Marek proposed; an unknown value now means host too, as in
      v6, instead of failing with -EINVAL as in v7
    
    Changes in v7:
    - Marek's review: this patch only replaces the private enum and the
      strcmp() chain; the ID detect gpio moves to the next patch
    - a missing dr_mode property means host and an unknown value fails with
      -EINVAL again, as before the series; v6 made an unknown value host
    
    Changes in v6:
    - new patch, from the review of the register base patch in v5: the
      private enum duplicated USB_DR_MODE_*

 drivers/usb/host/ehci-vf.c | 62 +++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..90840cea92d 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,8 +21,8 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
-#include <linux/libfdt.h>
 #include <fdtdec.h>
+#include <linux/usb/otg.h>
 
 #include "ehci.h"
 
@@ -150,29 +150,19 @@ int ehci_vf_common_init(struct usb_ehci *ehci, int index)
 	return 0;
 }
 
-/* Possible port types (dual role mode) */
-enum dr_mode {
-	DR_MODE_NONE = 0,
-	DR_MODE_HOST,		/* supports host operation */
-	DR_MODE_DEVICE,		/* supports device operation */
-	DR_MODE_OTG,		/* supports both */
-};
-
 struct ehci_vf_priv_data {
 	struct ehci_ctrl ctrl;
 	struct usb_ehci *ehci;
 	struct gpio_desc cdet_gpio;
 	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
+	enum usb_dr_mode dr_mode;
 	u32 portnr;
 };
 
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
-	const char *mode;
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -192,34 +182,32 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
-	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-	if (mode) {
-		if (0 == strcmp(mode, "host")) {
-			priv->dr_mode = DR_MODE_HOST;
-			priv->init_type = USB_INIT_HOST;
-		} else if (0 == strcmp(mode, "peripheral")) {
-			priv->dr_mode = DR_MODE_DEVICE;
-			priv->init_type = USB_INIT_DEVICE;
-		} else if (0 == strcmp(mode, "otg")) {
-			priv->dr_mode = DR_MODE_OTG;
-			/*
-			 * We set init_type to device by default when OTG
-			 * mode is requested. If a valid gpio is provided
-			 * we will switch the init_type based on the state
-			 * of the gpio pin.
-			 */
-			priv->init_type = USB_INIT_DEVICE;
-		} else {
-			debug("%s: Cannot decode dr_mode '%s'\n",
-			      __func__, mode);
-			return -EINVAL;
-		}
-	} else {
-		priv->dr_mode = DR_MODE_HOST;
+	priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+	/* Handle legacy DTs without dr_mode property, fall back to host */
+	if (priv->dr_mode == USB_DR_MODE_UNKNOWN)
+		priv->dr_mode = USB_DR_MODE_HOST;
+
+	switch (priv->dr_mode) {
+	case USB_DR_MODE_HOST:
 		priv->init_type = USB_INIT_HOST;
+		break;
+	case USB_DR_MODE_PERIPHERAL:
+		priv->init_type = USB_INIT_DEVICE;
+		break;
+	case USB_DR_MODE_OTG:
+		/*
+		 * We set init_type to device by default when OTG
+		 * mode is requested. If a valid gpio is provided
+		 * we will switch the init_type based on the state
+		 * of the gpio pin.
+		 */
+		priv->init_type = USB_INIT_DEVICE;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	if (priv->dr_mode == DR_MODE_OTG) {
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
 		gpio_request_by_name_nodev(offset_to_ofnode(node),
 					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
 					   GPIOD_IS_IN);
-- 
2.55.0

