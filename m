Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA86606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NJD2Nn6O;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RcCf05Ug
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C15E608C3;
	Thu, 22 Oct 2026 07:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0A4-NJ0fSSkL; Thu, 22 Oct 2026 07:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 28B2960877
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652965;
	b=WduRDg38BVIFARwk1PeHm8MZGvNjeX9PGgOkxnmpioXqIYwC59FFakMTuRh5Xe3GBobz
	 aCpwPyVb2HJBVMyaTjDZhzTMz7/tIy+Xl+X0KEX/MrQCa3L/fPWBaK4YocB1w+I4nQipV
	 Rxoo2xgYaIVa9VUMU+9ykJR7tboupBbg254xfAoO7LgUlghLba8E6g9Vt6n1tT5S8iLd5
	 ngujV4oGcwMK0YbMBAHxqZhx3NzTNWP6E1BbrmPwe+DE/IjbLumDEtgR1GJERoKvuqAbj
	 irS/sxRJW5SJBb9jxFxa65gevEIpMUG6m9ow59O/xSb8mSoxNVi/N+kVO7dNegKaKSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ELXlzyYXyt4pqkW0tZfdrtLddaVrU7/bcqsoNgX1+1M=;
	b=SkErcHwpgUuw3i45kPJq/QFH0IZcx2qitpjIbsQMNiraD2OAjDQVSlOm3QNlnqFEf0aQ
	 8jKLUPV/SRY8GkpKiEFxOZwJJhQckPxW++PSs9rIJdyjl8cuQRBBaVeRXaVA1qJnkcX6a
	 SuR7le4JMZaAw+Tqg3cgtz4M64bUFCmiYUNRwIPbSGuhQOS5t2lkq0nWVbUODL1Jcwan+
	 f6C5OKOCJ3dOM5cGZjMrBgPTudFts27Mup6QoZqnuIF9FNhkneHNqKl2gB5/pSJRiBJ/v
	 faQceHChwT1J/qMar3lYu6Gp+++hA1kC9u3Roe0MvrzbIL+AYBtFt3jP/6tPB0y6QEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652965;
	bh=ELXlzyYXyt4pqkW0tZfdrtLddaVrU7/bcqsoNgX1+1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJD2Nn6OmqLRfaVMEmP3ExtLML50dA00Kg3G8uqBLeQZU8aVqdKs9sCKjRNYy1jhD
	 Pik7Y8T4QrSJHXHhY6iqCoQ0m2hRYxuN2sp8+5w+RwCiZC2xXAb/twYBypTlkP9ADk
	 K5m22MGbPkavm+RAVT8Del3mI1OaaESLywcP6uYQ+GKn3C8W692Akb19W6/A3LfLg5
	 itl76gxenh0jzu1XMnEkURNxd13LBxaI/KVHczlBnrioTvC3b6U340iKSJfjnjdkf+
	 brhV4wvhObBlgh0YwH4G8Pq3bhCTcin49FEKbi0k7d0WwVI5ORVlh7krETUP3zFGQI
	 Ah4zYIVxZxptg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28B2960877;
	Thu, 22 Oct 2026 07:09:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 611731AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4730A40042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUWojGj1GGIz for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1FC3F40075
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652952;
 b=UAGSL1br4W09fiAywUNRV8VD+qZvoZfj7KP7DgSYrKR7wO4fDFKQRu4O2cNQ+2F2DTRq
 8AZtyBa0X/vtqGl2bZg30kst9TgqnEjiiQ5lml3KQv05ePZghx6cdQFYBJOdQfChnStgD
 N9gMrIofqlDRTAXTFv6L4DXH/rFO3IKrgo6cTc2UNFo03nVkIOd6sHcuxbEsMA0baUn/+
 7WiNwcVs70jFCYjUTITt3RyyWwctQRfjk/tipTqu+h/gB79yKJpOe2shC4Qhpa6kdv7HT
 rCxlQawlJaB1jeL608eBuiQnwHYwGk1CG45mZTfmDk9iGyn9sV8yjfmSy7KKW1Uj0xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652952;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=ELXlzyYXyt4pqkW0tZfdrtLddaVrU7/bcqsoNgX1+1M=;
 b=JdTxr1LLDiokRqnqks0k2mpq9L4etDyFI98w+gXBlbRqobAEJ8k3gGjMsqiu8IisfBjY
 aYmi8eZkyOUJ5CdDPuhxaV8h/G2XsQq4oOXvtLAUO5aGcfXkdWASDcKJbkQo1Ca674jw8
 E2TTkuN3pmz9HJWxqL1DjVch1oHroRBPmFCZ8bwawtRqOPrcHFFoD+B1dsWAhzOv3J5PK
 ssZArlkW7ifIjfyqAgjjA6C1Rwkd7DTHsQq038qi4kXYHcVFbpj4DxQMV+FYu2Hs3dsE+
 J4Y+z+HKt04Zu9zbTOLt2CfzJECIUVJFsuQNKjiCBKvqrHp55uc0yxN8VTmHZLOp6YA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RcCf05Ug; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RcCf05Ug
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FC3F40075
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:11 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so436199f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652950; x=1793257750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELXlzyYXyt4pqkW0tZfdrtLddaVrU7/bcqsoNgX1+1M=;
 b=RcCf05UgHsTTL/xJNEdjT7kDsj/OdjshssdqQVNqWwvN/vByih30WdTMHrqcXKC5he
 OYb8HMmPqE4vY6Jc1go8YhMaXISfQiQOTpEvW3dJYpiDH/Ev0ea+iLiyp/fLf8vgKlKC
 XaC0EiBRYb0q3c050oYo/GJM9MHOCy7PXIdZq030phLnqYe6YiISCiN4545/NM5IBRUP
 Pr0V+6VmhaLBN0QF27io3IMPx4eukR2WUYQzt2a1aNsCKHv1T3fUqylHjtmJpfR6vfY/
 DEaCS/Xco7sXGm7XvwLgY3uRFIlMo88ZdNDw9LuKpvFVPMPoZkLEREkZhVQRPEcZvWuw
 czQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652950; x=1793257750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ELXlzyYXyt4pqkW0tZfdrtLddaVrU7/bcqsoNgX1+1M=;
 b=zsAJor8NZN/gZz7mlDrjJc686m1aaTSHraPHIdMaY4bzM6hsL2Owf0r/K2sGWG7gpL
 CcCSt/0OyCMa9gJiH3ddwjp0aZkiSo6wPlFWlRfV3kIDfBwLjlFH4eiBdNGi/app7qEj
 kxCpXhnYWb5ELc3740c76bLzD5s7hmDDmTRSuGvKdxZe4qAkJPlgpTuANhguZglr+7B6
 t/JGTAu+dRzbfuh86KvVJD7Nlnt9nY2cOhLYTS/fNJvGquDjFiiQPEpQoGj+HMxHuF/q
 T7fc4p4i+FEdlhH/ySR8bWPozdLL3CTmBqUmcRND/XqoNZvFTvPzi4yOe2BQpUH1uHCA
 efmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+yCJPC5GJYYBzIPIYivIWcuvpL6czqWnHa92Je4f5O0Dojct5FRBZ/kyYzPTIR3C+e+7z+9c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhz9vuRJdsGAVaham/YioUIYaT/mllLHdcOJkU3bGBksgEcpvd
 HORAadCbZnscuKrDHuOfHEE4sUFZglkCpFekgQa20FULKfpg25W8i/VL
X-Gm-Gg: AYBFou0EtPjYgML+hy7A1pwOUno+RDYIBwYYx3MFnGdqTvkt0xIc0MY5V4w/HGg6WL7
 zpnm68yUzNjxt3JwBDzs8O7LVrjT+CAGtB9Kxab90C93bJLn6tLJ36mMiNnyzX1XAxRIXz9q71O
 dYXZe0sV/bEd+UX/Lo0H3bh3jzAf3Lt+G7RoajCIPVtW1w1fO09K+PPwdUuvaBE2WJve+9E2U/O
 ag+bxZXIXp1QEh6bD4bzNusIeIyWj+uDDBlRV5C7gm/O3CP7ZqwV0sWD6DZP4vIL9id+2gQ3emC
 jjqA1elMbOeOgFen6Z8fvSy775QDGhtbJJ6Ob9BxeFroCTT93yj1r3GjQou1MIHOdyrgVxuO7pM
 S4mp4Ixz7xdihPQqWheLrWuH12Fn0IeoJpT3XN9hcuNC/2OK0mjlm7QhCQVGgwU76oglwFuGd/H
 NDGABesa374ItPWxYrCptBpjTsTjBhr+bTsK2drpCfKty+11C7/iIn0OuC0+csSRj82J19yPUnm
 sb7i1DyuvBF7MO6K1gFAG/VGl2MXrf8o5tNTgoEnJ7v/CMCYhgXgU5I/bA3ug==
X-Received: by 2002:a05:6000:4211:b0:48e:d7c:4bc3 with SMTP id
 ffacd0b85a97d-48e2d269fe6mr3194430f8f.21.1792652949832; 
 Thu, 22 Oct 2026 00:09:09 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:09 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
Date: Thu, 22 Oct 2026 09:08:58 +0200
Message-ID: <20261022070900.616265-9-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
PLL7, which the device tree does not express, and now comes from the
usbphy alias of the PHY node.

The usbmisc node already starts at the non-core registers, so the
driver no longer adds an offset to reach them.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
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

 drivers/usb/host/ehci-vf.c | 135 ++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 61 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 52ec83fc485..d2263a1224f 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -20,13 +20,10 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
-#include <fdtdec.h>
 #include <linux/usb/otg.h>
 
 #include "ehci.h"
 
-#define USB_NC_REG_OFFSET				0x00000800
-
 #define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
 
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
@@ -36,31 +33,29 @@
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
@@ -80,15 +75,14 @@ static void usb_power_config(int index)
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
@@ -115,14 +109,10 @@ static void usb_phy_enable(int index, struct usb_ehci *ehci)
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
@@ -130,52 +120,75 @@ int __weak board_ehci_hcd_init(int port)
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
+	struct ofnode_phandle_args phy, misc;
+	ofnode anatop_node;
+	fdt_addr_t addr;
+	int seq, ret;
 
-	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
-	if (!ofnode_valid(phy_node))
+	ret = dev_read_phandle_with_args(dev, "fsl,usbphy", NULL, 0, 0, &phy);
+	if (ret)
+		return ret;
+
+	ret = dev_read_phandle_with_args(dev, "fsl,usbmisc", NULL, 0, 0,
+					 &misc);
+	if (ret)
+		return ret;
+
+	anatop_node = ofnode_parse_phandle(phy.node, "fsl,anatop", 0);
+	if (!ofnode_valid(anatop_node))
 		return -EINVAL;
 
-	phy_addr = ofnode_get_addr(phy_node);
-	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
-		if (phy_addr == phy_bases[i])
-			break;
-	}
-	if (i == ARRAY_SIZE(phy_bases))
+	ret = ofnode_get_alias_seq(phy.node, "usbphy", &seq);
+	if (ret)
+		return ret;
+	priv->portnr = seq;
+
+	addr = ofnode_get_addr(phy.node);
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
 
-	priv->portnr = i;
+	addr = ofnode_get_addr(misc.node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(anatop_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
+
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
@@ -213,7 +226,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -255,7 +268,7 @@ static int ehci_usb_probe(struct udevice *dev)
 		}
 	}
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		goto err_gpio;
 
-- 
2.55.0

