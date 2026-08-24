Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6457FC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE80C80C5C;
	Mon, 24 Aug 2026 19:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6fqn6o_w2vM; Mon, 24 Aug 2026 19:03:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598236;
	bh=BYLXqULgNkbqYYOmRkQ/K+pcl9pumX9v6taNnGhHMGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQngQiHQtOWlkwE5RDTDq2E4yTCGtXPh0qeKssRgiwlOgbQbg5SiMcLwMHPMriRYS
	 ACIYKlY4XFU+hxDnDbojMJ1k87mjq4m791WH2+pOK99GCfL9AUQ6i7Tr2RW4rWdpDZ
	 0vJKum+3vcQUDWJyI9MPc9Nm39o7Z3N4MWccVeMe1yFUjvVbhSY5VS3xjnW/Eiw+NL
	 rgm3NQQs3eD/tI0WlW+GEORnTKY1PCNuNHE+V5QrsQPEWXHjuRWbKvmzb3sPsfrVKl
	 wPmBa+j4nv6Rffyy8VjIZt/LeXKfBHT/dlC8bji13/r2nzZYnkZ5O8j3tAAAPXF03E
	 VCYZatAlgBTlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA881806C0;
	Mon, 24 Aug 2026 19:03:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10328279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01F5460627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAnLqAv65YKy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=klXZkPOO
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EE8860618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:30:58 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso1192066b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596257; x=1788201057;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BYLXqULgNkbqYYOmRkQ/K+pcl9pumX9v6taNnGhHMGo=;
 b=klXZkPOOyuU+mLkM1J+xxqn0Zb3+o563TZ1l/Q01HdwQfpNraF6GLoFi9LO1wU2vNP
 AaOJEdK+UUiZMcoKscTgQ8BUxKEZ7BHnuJ5V6CvQbLD7vFOsl3CK8FyoEGT7pJqDlPR3
 LgcoGk1VbVecGMuEvlrv/5/sTaVy8jdMHzv5GFwP5ZyVRG02+XFhvnyzs0ckEiupnp3T
 pYAfawV/jVeGMiixaQ8kT88988PPQvNUWffMt349fe0pMlX33h/D35SLAhKBsMhdOZRc
 sWVXtK4QO1VPp4w6UOy3i4dKhAYCGpKfIGDO9ZWquCwe5dgRecILZpT1uhUjnTgCAHVT
 1WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596257; x=1788201057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BYLXqULgNkbqYYOmRkQ/K+pcl9pumX9v6taNnGhHMGo=;
 b=AgHeELTwsVBzAd/5TUzSVnhTODBMzir2GFkLZ7BhUngAJt1PYK4yGGUphO/M8HnoSV
 09lPRANvBxEBeOytX/S8hapJR8SqM4FnzTZuItVrAdXrfTXyjhPCi/6eQWWmsr1poEfj
 d5xU1YrpXdbHdVYvuNQV0FO13C30+jtCfJtBmNWMD6ymY20OqZlNDCRzRhKySyRy9OVr
 P7apfaRlf3gRXmSh/37vaiIL7e8JGM43S6nQ2mb2ns4AERhPDhIBvHhzYTe35NfPhcnX
 VA0l0/oF5SVYT7jkHd0Onjb17wAr5y1NMf85UlBcHtVrJC3D5nq+IPRQqfFoehqetjf9
 8G/Q==
X-Gm-Message-State: AFuF++lY+qswUAMmBTM5cqXsIBEtV+i8z09fCkiLDQbEFw/g7CUx9yAK
 8jvTLZQDUlcK9M61hijLU3XSbQEo3kJtU41Rk34jWEOzf+bqbbAyp9OX
X-Gm-Gg: AR+sD11EqAMc4meAzgqsGT2JzpbfH5h59AljNMJWksl6hGF/ODIvlXQUt2GN2bMoS9T
 5qPmwvnQdud8EScXeCROUajlPEZeqHk9gatxtD5bYi5vBsSXD9sIO47QULZkuJCvCz166ZsQobW
 3GAUWVTwo8J815Lh/THpbMyXxlZgoWkVOHNw3CnWp7yWIgrg5nmJm8f1D1WzjEPVJwfP9kdVlmK
 +Euwmv55Ee9ABdtHZE0qe6bj/y8Doj+CBUVcCFw0tRWcdAafBrFHVdpeqsWlAlvFZ9lMWSA4g3N
 85lXjwXK1FO3iTngZtJ5kJHCo2Z0d7KwC+iPzwIOkEzOZuQJHScQ0SzTk36ieiN7o0ek8QsMSNr
 IbEGbufaa40MX7Eg2fiNJ9C+BeMMtixuA041dMqrV5PaX4TOuL1SnrmJTlBuii+mQblAmWVUOT4
 /sqFfsUt+yyaJT/Ccld1AeEtSFoURSNVABEwf9S/kklxQ=
X-Received: by 2002:a17:907:c8c5:b0:c12:3cbf:9f6d with SMTP id
 a640c23a62f3a-c24e2b10f38mr92211166b.1.1787596256758; 
 Mon, 24 Aug 2026 11:30:56 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:30:56 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/6] usb: dwc3: core: only provide legacy gadget IRQ
 handler when USB_DWC3_GADGET
Date: Mon, 24 Aug 2026 20:29:09 +0200
Message-ID: <20260824183048.419198-2-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Building a board with USB_DWC3=y (DWC3 used purely as an XHCI host
controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
fails to link:

drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interrupts':
drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadget_handle_interrupts';
drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined here
drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts':
drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_uboot_handle_interrupt'

Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
is only compiled when the DWC3 gadget driver it depends on is actually
present, matching the Makefile dependency. Boards that combine DWC3
(host) with a separate legacy gadget driver like CI_UDC, with
DM_USB_GADGET disabled, now link correctly. Boards that already use
DWC3 in gadget mode without DM_USB_GADGET are unaffected since
USB_DWC3_GADGET is set for them.

Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index be198041f08..9bff5149c5f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
 
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_GADGET)
 __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
 {
 	return 1;
-- 
2.55.0

