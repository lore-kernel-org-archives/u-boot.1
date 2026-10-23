Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDC606A320
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=veqtNqsz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LJ78iXhJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6ED481324;
	Fri, 23 Oct 2026 11:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1MqIDTIPjNV; Fri, 23 Oct 2026 11:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 954078135F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754186;
	b=pFygqjHzU1FYlu0jveLpMSWqf2NbFTPcyFHfF/XAf6toeWggrLJoeyRCua9D0kazIHOP
	 365oMgLJVbYFMGFvLzH3iQ5374i7wtS7js6F4j/CdER44Enj0dpOzUn2tum36cmBjlGcI
	 KcSjy6f4L2sUEp2Jv6aHTyvF4m/3XfwzH9iWctHjhrTi6kOLv3tKoXxleOPnZoRiNCoeR
	 XYjl4PPp57AQ8ec+0dlVLObAedjgwXMLLhUr0YDsVdcy7YDPK+VfHfzHMsXE+woMR1SRs
	 wYI7O24GjcrM0El57MaW3BZ9FKa6d2lSB8tMq09E1HrnLLF9VbjcsWhX9dzL3aODB3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SNUEM4ycZg2z6g7NQTuXpG9o7ehIWdSiactrLDB6mpY=;
	b=RC4I4uK9g2kQ5KKyGG35jXvwSn+/fLsrRV4Mjrzk6xs1zg98we9qQUgBeDlP34gFvRGL
	 j2VN1YB5yffW1siV/Uv8kXpveVNQgWgyd67QCO9T6MIG4JjSPUL7VPWnG9czdvb1Nzl2P
	 eJxA7b5J5g94nP4O1PjabZb9pXQzG0pHD8eAJLtPJX7v/DrvkAs1xEhDFCsyHTV6KBG7I
	 acogpWlKul+dE+IpqC4i/FE6ZRFtwXFlmQYXGlFYr3eWU7/IUsWNUrK4j1MNsegGeZlDY
	 yiMLsjYFgtMiMEv1BfbRIEz8LGFYUVV9zxIV+2CGVji3s6Y6XEeSKajfg/wl5dMmmJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754186;
	bh=SNUEM4ycZg2z6g7NQTuXpG9o7ehIWdSiactrLDB6mpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=veqtNqszxwwIj7o5FfmV6VLq/VzUlt1/iSCm8vbMK64Eaivm4xQu6JjeATMgAF8e3
	 vi8T979WOuPF5jwnH4RGxt8A5Gado5wBZ88JgUnmyMTs2CUpG2E7NWnxbnE2l2Lrjf
	 c9jM33cN6NtFbIxhVo7LaxlBl34zXJhOaa8oXCl//fUQ5mzc8G0CHs86eZFHaC4Fhs
	 z6lQ/UbZWzpCpYRrhg/oRzBZExnir0mpjtKKt9VIwlZeuCTxqgi1hto247gu0Z5kaT
	 A9mYpF1GGHQKmYPE0ZH3iy0Tm5iMxOuZ/evPDRetWu+nysyQQbgAt+H1d/wFcNOsMZ
	 MyfTrehHFeeKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 954078135F;
	Fri, 23 Oct 2026 11:16:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EB9C3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B6034083D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmYWD3nRzMKa for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B1E74082D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754173;
 b=Fiw/fDtWncl9C/QDvWgH8EoLSgW9Fzexo+NDD1c+bl8O0Q7tjvFIQJUFomENZ9BaNXWN
 219jupqpEOJ8cV/qx6qa3ijQXH/hi+Mv/vsc/zZp733c7OfT+5n5LCYLvh1zRNHVADKwJ
 t4HNJeQgFfvqrM15RmqY6bN2TCsh9Y1tGbGiwCPaiPL/lfJswjqTIcWmBKPn+AKIOoJ0a
 8363TuwuX4wHhpjYCEOhbqPPbLYyBHMs1Qs+G2XzDjEfVTkA7pUGEiUcqYj4xWwUdzowm
 24eXDmqofVPLAZiVwH/ZsJE+RyzYasrioNqHXVgdXllvkcpQqesMJcp0vnHZtdQgZlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754173;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=SNUEM4ycZg2z6g7NQTuXpG9o7ehIWdSiactrLDB6mpY=;
 b=cHHvAlRsZilL912dPSp7+svTlfPtWmo9W0i4Ej2qQ6Y/IUfV+Icz9Ik/5783R8CVLjRU
 Hi6wTkR9Yr9/5R9U8OgUzoVG2aJbErksE2Wlvnm5U+2KUOus2mC8MPSNgJa33z11KfxP0
 +EQC/SWMKKdoNceaYHYW1m8sVQj51U7Kbv5p/2DMHlS+Lb+1i+FvdPXWNWxXRiNGDRBdG
 eqiocPILVqEONJgvi+Mp5v4xk2eP2fVrqpRyrmW6AnQrd9AcFq/6QvsJBC6c5i6AYovqL
 bpLnOKil1AxVSj+ux6dZybBdIDWegDSN9mBAhh+fmTQS6QRr8Wb04p4AVDtvjpmu2FA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LJ78iXhJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=LJ78iXhJ
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B1E74082D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1301595f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754170; x=1793358970;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SNUEM4ycZg2z6g7NQTuXpG9o7ehIWdSiactrLDB6mpY=;
 b=LJ78iXhJuH+GuZWF1KFMNBEYBIagYKQAwZrA+cCeVda51a/Mt83GqJIU2jnjCdoKxs
 y3/kAte2dNztyRPE1J+w6JJmOTuO4EcZiRM4tKJij9SDqLWvhJptPbpcziHZ2vjYoq/y
 qopNyo3ekkEZ7gj2+vI3fhVjqVPEnh93W1UG8zTgu9DbHFS1nAEnicjD5+bd3l4SrIgc
 BlzIo6F3wAuiuOiv8MpKevFuO4mn5nUy+O1G6ir/J80l6WbbSckl+XN2Qs05s2I9mtLD
 NySwvEcqaT5VtVPGBaNIiVTGcs/6kKQBZ+Vhf4qTAXt80p0xvHlTWjlthqauJ2D/soQe
 iC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754170; x=1793358970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SNUEM4ycZg2z6g7NQTuXpG9o7ehIWdSiactrLDB6mpY=;
 b=C0VvRsKd45EBDdqYPZrTjRMnXm55qFn+EYsYsd7bp0ZvMggjWnSZ8kEFqyOTSu6Tr9
 IJK803qtUzzi3rOmqfKXLTbjOpfyImej677PNxoQeSP5u5EloVVe71yD8kgAoPGVhYmZ
 1RQonppbVgVqDnLCtzMNh4GKFn9UHIUiota0KWPFfpj8sVsk3nNXLV3QbOnSBY0dxzlR
 AkpCOg9d++UKrGmljknZsMB+pxPgx1YgO2RAK/oYcRS5U9T1V/xz4h/DsxwRe1Cpqx+u
 PQEjoXPPEjAC/FPl8Wf0TgXBgCX6TP8CUKb1BHz8pkz0M1woXnz9EK8/C0F4uQq/Dsm4
 Lbeg==
X-Forwarded-Encrypted: i=1;
 AKwUvByur+k4K5S0sfa1aMGF8tXsA9ogDpLQsS7/U06ThFmEVWfdRdPPR/9L7pW1/c6OjD3mkpkOzDg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKsY2amuuV6ThjULqWOBToun+sRNSvR83QmW8NF2vkhzrw3p6Qo
 5YyQO7D01TbE9KCpvNlp3af13lWrOZY1nPWTBaadvev7IcjHm/lU3aEf
X-Gm-Gg: AYBFou1631Ql2lnds1LO5zwDyn3JNuqj6WpSnP4e7KXdHJLshVX8T1xIffW6Z9zkt8h
 v0uBsGiT1FTXIKEEV7/J4xA2lm6h4BQK/7Lf7se98/Aj8cF43IzVKrh5xR/AbiEk9nZ0GiyYQpT
 pey0Ne7bgcxGOlDRQTxVH5Xw8lF1sHQ4cSK0zVAnvfQww8mUIjznZXxEarMVginR4zqQjorO2cB
 4V+srlFqlc5rSlz/MvQOC2mx+UUE7rwlpYY/+GO1d/d0ttHb2duuL1HoI3gffbUCsgsjNSYr8BS
 33m8eICd3rIyhNgSviznmhnekkqrsn2Z/QgbMNbclgEYUrylMELVaU45rNvSor6wg3Yb2DHWDGz
 3nOhp5SwaKO75PmysOfJKzv0VjbtEe9c7+b+5PPiIrM8Bpt3ZFKOuCLYUswaxfkKDdybqdG/Kk6
 tANe0IZxtUXUggkrfQJtTTbK0smG5NJL2WFn0Mdu/PNqDzT2cg/+AntaBN6WrCUG41jTZa2Q0GM
 jwSkCHrzKGIYkAY6lUDFxWITuifOz35ELVL49VuhJ9QorkS74vX8tyTmJdHgQ==
X-Received: by 2002:adf:e00e:0:10b0:48e:1ceb:e8a4 with SMTP id
 ffacd0b85a97d-48e385a11c4mr2133522f8f.17.1792754169745; 
 Fri, 23 Oct 2026 04:16:09 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:09 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 7/9] usb: ehci-vf: take the register bases from the device
 tree
Date: Fri, 23 Oct 2026 13:15:57 +0200
Message-ID: <20261023111559.4081795-8-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver keeps its own tables of PHY and controller base addresses
and reaches the anatop block through a hardcoded address, although the
device tree describes all three: the controller points at its PHY and
usbmisc nodes, and the PHY at its anatop.

Read them from there and drop the tables: the two phandles of the
controller node through dev_read_phandle_with_args(), the anatop one
from the PHY node. The helpers take the private data instead of single
addresses. The port number stays only for the choice between PLL3 and
PLL7 and now comes from the clock of the PHY: VF610_CLK_USBPHY0 and
VF610_CLK_USBPHY1 are the USB clock gates of the two PLLs.

The usbmisc node already starts at the non-core registers, so the
driver no longer adds an offset to reach them.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - the port number comes from the clock of the PHY, VF610_CLK_USBPHY0
      or VF610_CLK_USBPHY1, instead of its usbphy alias, which is not
      documented ABI (Krzysztof); the ofnode_get_alias_seq() patch is gone
    - the Reviewed-by of Marek on v8 is dropped, the code changed
    
    Changes in v8:
    - Reviewed-by from Marek
    
    Changes in v7:
    - portnr keeps its u32 type, Marek's review; the alias lookup writes a
      local int
    - adapted to the split of the previous patch, no other code change
    
    Changes in v6:
    - the phandles of the controller node are read with
      dev_read_phandle_with_args()
    - the helpers take the private data, not single addresses
    - the dr_mode enum this patch used to move is gone, see the new patch
      before this one
    
    Changes in v5:
    - the PHY node is looked up with the "usbphy" stem: the uclass name
      "usb" found usbphy0 only through the prefix match of the flat lookup
    
    Changes in v4:
    - rebased on next
    - dropped two comments that repeated the commit message
    - reworded the commit message and took the note on the previous version
      out of it

 drivers/usb/host/ehci-vf.c | 145 ++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 52ec83fc485..46d8f6b4461 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -20,13 +20,11 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
-#include <fdtdec.h>
 #include <linux/usb/otg.h>
+#include <dt-bindings/clock/vf610-clock.h>
 
 #include "ehci.h"
 
-#define USB_NC_REG_OFFSET				0x00000800
-
 #define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
 
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
@@ -36,31 +34,29 @@
 #define UCMD_RUN_STOP		(1 << 0) /* controller run/stop */
 #define UCMD_RESET			(1 << 1) /* controller reset */
 
-static const unsigned phy_bases[] = {
-	USB_PHY0_BASE_ADDR,
-	USB_PHY1_BASE_ADDR,
-};
-
-static const unsigned nc_reg_bases[] = {
-	USBC0_BASE_ADDR,
-	USBC1_BASE_ADDR,
+struct ehci_vf_priv_data {
+	struct ehci_ctrl ctrl;
+	struct usb_ehci *ehci;
+	struct gpio_desc cdet_gpio;
+	enum usb_init_type init_type;
+	enum usb_dr_mode dr_mode;
+	struct anadig_reg __iomem *anatop_addr;
+	void __iomem *phy_addr;
+	void __iomem *misc_addr;
+	u32 portnr;
 };
 
-static void usb_internal_phy_clock_gate(int index)
+static void usb_internal_phy_clock_gate(struct ehci_vf_priv_data *priv)
 {
-	void __iomem *phy_reg;
-
-	phy_reg = (void __iomem *)phy_bases[index];
-	clrbits_le32(phy_reg + USBPHY_CTRL, USBPHY_CTRL_CLKGATE);
+	clrbits_le32(priv->phy_addr + USBPHY_CTRL, USBPHY_CTRL_CLKGATE);
 }
 
-static void usb_power_config(int index)
+static void usb_power_config(struct ehci_vf_priv_data *priv)
 {
-	struct anadig_reg __iomem *anadig =
-		(struct anadig_reg __iomem *)ANADIG_BASE_ADDR;
+	struct anadig_reg __iomem *anadig = priv->anatop_addr;
 	void __iomem *pll_ctrl;
 
-	switch (index) {
+	switch (priv->portnr) {
 	case 0:
 		pll_ctrl = &anadig->pll3_ctrl;
 		clrbits_le32(pll_ctrl, ANADIG_PLL3_CTRL_BYPASS);
@@ -80,15 +76,14 @@ static void usb_power_config(int index)
 	}
 }
 
-static void usb_phy_enable(int index, struct usb_ehci *ehci)
+static void usb_phy_enable(struct ehci_vf_priv_data *priv)
 {
-	void __iomem *phy_reg;
+	void __iomem *phy_reg = priv->phy_addr;
 	void __iomem *phy_ctrl;
 	void __iomem *usb_cmd;
 
-	phy_reg = (void __iomem *)phy_bases[index];
 	phy_ctrl = (void __iomem *)(phy_reg + USBPHY_CTRL);
-	usb_cmd = (void __iomem *)&ehci->usbcmd;
+	usb_cmd = (void __iomem *)&priv->ehci->usbcmd;
 
 	/* Stop then Reset */
 	clrbits_le32(usb_cmd, UCMD_RUN_STOP);
@@ -115,14 +110,10 @@ static void usb_phy_enable(int index, struct usb_ehci *ehci)
 		 USBPHY_CTRL_ENUTMILEVEL3);
 }
 
-static void usb_oc_config(int index)
+static void usb_oc_config(struct ehci_vf_priv_data *priv)
 {
-	void __iomem *ctrl;
-
-	ctrl = (void __iomem *)(nc_reg_bases[index] + USB_NC_REG_OFFSET);
-
-	setbits_le32(ctrl, UCTRL_OVER_CUR_POL);
-	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
+	setbits_le32(priv->misc_addr, UCTRL_OVER_CUR_POL);
+	setbits_le32(priv->misc_addr, UCTRL_OVER_CUR_DIS);
 }
 
 int __weak board_ehci_hcd_init(int port)
@@ -130,52 +121,86 @@ int __weak board_ehci_hcd_init(int port)
 	return 0;
 }
 
-int ehci_vf_common_init(struct usb_ehci *ehci, int index)
+static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 {
 	int ret;
 
 	/* Do board specific initialisation */
-	ret = board_ehci_hcd_init(index);
+	ret = board_ehci_hcd_init(priv->portnr);
 	if (ret)
 		return ret;
 
-	usb_power_config(index);
-	usb_oc_config(index);
-	usb_internal_phy_clock_gate(index);
-	usb_phy_enable(index, ehci);
+	usb_power_config(priv);
+	usb_oc_config(priv);
+	usb_internal_phy_clock_gate(priv);
+	usb_phy_enable(priv);
 
 	return 0;
 }
 
-struct ehci_vf_priv_data {
-	struct ehci_ctrl ctrl;
-	struct usb_ehci *ehci;
-	struct gpio_desc cdet_gpio;
-	enum usb_init_type init_type;
-	enum usb_dr_mode dr_mode;
-	u32 portnr;
-};
-
-static int vf_usb_of_to_plat(struct udevice *dev)
+static int vf_parse_dt_addrs(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	fdt_addr_t phy_addr;
-	ofnode phy_node;
-	int i;
+	struct ofnode_phandle_args phy, misc, clk;
+	ofnode anatop_node;
+	fdt_addr_t addr;
+	int ret;
+
+	ret = dev_read_phandle_with_args(dev, "fsl,usbphy", NULL, 0, 0, &phy);
+	if (ret)
+		return ret;
+
+	ret = dev_read_phandle_with_args(dev, "fsl,usbmisc", NULL, 0, 0,
+					 &misc);
+	if (ret)
+		return ret;
 
-	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
-	if (!ofnode_valid(phy_node))
+	anatop_node = ofnode_parse_phandle(phy.node, "fsl,anatop", 0);
+	if (!ofnode_valid(anatop_node))
 		return -EINVAL;
 
-	phy_addr = ofnode_get_addr(phy_node);
-	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
-		if (phy_addr == phy_bases[i])
-			break;
+	ret = ofnode_parse_phandle_with_args(phy.node, "clocks", "#clock-cells",
+					     0, 0, &clk);
+	if (ret)
+		return ret;
+
+	switch (clk.args[0]) {
+	case VF610_CLK_USBPHY0:
+		priv->portnr = 0;
+		break;
+	case VF610_CLK_USBPHY1:
+		priv->portnr = 1;
+		break;
+	default:
+		return -EINVAL;
 	}
-	if (i == ARRAY_SIZE(phy_bases))
+
+	addr = ofnode_get_addr(phy.node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(misc.node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(anatop_node);
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
+	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
 
-	priv->portnr = i;
+	return 0;
+}
+
+static int vf_usb_of_to_plat(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = vf_parse_dt_addrs(dev);
+	if (ret)
+		return ret;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
@@ -213,7 +238,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -255,7 +280,7 @@ static int ehci_usb_probe(struct udevice *dev)
 		}
 	}
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		goto err_gpio;
 
-- 
2.55.0

