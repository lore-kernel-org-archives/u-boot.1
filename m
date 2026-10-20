Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66160A261D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YaCn35jN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EnNkHWQ9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A15181109;
	Tue, 20 Oct 2026 10:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtYfASoUVcI7; Tue, 20 Oct 2026 10:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1216D811CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491399;
	b=P2B8n5F/5UNK0VVE8XMCIQISOgDGrOOGJ+KuNdEXBGFbAucWZyC+nTGOjE4RnKDjPgQF
	 T1xhHjA+UucwrbFoQW76Cu4xRY8h3mgD+8IluNuvxkeRMJ0cdLuQqEf+K4y4MpE8mhYL1
	 CmpG5on9QXOTW9HJYvmjW4XS8zs6NScxXzspqeshzCZsxSbBptFX53N2uaN1Zwzf7xFXQ
	 zIp3h2e4UzNuOMM9W2NreUsG4XEhQJyVH44mUZGfzN4h+olfUD97WCP0tddD9ZqxcHovW
	 ijW6toJT6UAUb3me2I/yVV0duxMursr3Ta3JB+33s4Hjz5t+NlCgCZz6ZOeTAzD7FsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HIu1+PfKwPcs9ZyUxuDkyb5FQbO2MoDQK9XMFmyXvJk=;
	b=UL9jUh04vbGCvbttvo2SRQDn3q9yahzRnIxoOhf/gRXYZziXsaOc9m0JnmkZEeYPJ8QP
	 m/yVnD8dVR+ayMniBq0y0SCnsm1bYPLGtnxs56rwUZ899YFN8XmftnYXU63OUVWiM3lUb
	 Y/95KE6cBqbVGsrjlAd0QwhGoko8HFdIEFFc15eqEeAt6NrKhqbHcP5nASKOb0FH7YU2N
	 8JQkcvWay1dQpA/Wgyu3yd78zCexF/zdLZSPBR0wk5LPtzuzzbS0vhWLoVTvqKmgA3KgA
	 1Dw9UoZRbGrG6dLUqAWn4SuL9I14W5cXKjgO772U2R6+3CTQ9o0Sqrm4x8dV9kEdsNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491399;
	bh=HIu1+PfKwPcs9ZyUxuDkyb5FQbO2MoDQK9XMFmyXvJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaCn35jN+Vl20J9VgKnmv2imMtona3RgTqA8YDPJlGKRsJB7iVbfgtjL+F4qXpkFz
	 zgVem5jILqlIvKpu3+FNaq+U5l3zUPCTtTl9FmkYgZJQ/xmAaLUo01+iLy982VS5tZ
	 T6cjPT4LdFhj1BwexsaBdfrk6dqIYYFckIIX6lwpzA9TxQcS4yd65v+lpcMqeWkn/L
	 eQmRqxAlNLqL5px+3w81hmA91wPHL5bX1vedHx9g5KTWba2n+8qmXHoflr8vuvFvZF
	 p2iMdpK4L/f4JDTsHHqxUA8ipfpZV0Nsh0nouU3mT1eH0K8zdC3VpVPP5eIH4yEwra
	 Qjh6jkdXNAlCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1216D811CE;
	Tue, 20 Oct 2026 10:16:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E91E3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1469160825
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rk1HE2AeHn56 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0F0960822
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491380;
 b=XvyX9T4WV8c1sWdq1aXqAEahAn9ILlH7/zyCdSW3Ru7vtXmMwJj0NEZCX95e9eOARlJK
 Og//m1ymBRCYgkdQyVkY6VgGwBAP2AIOxwbjuKS/BqeKsMNqyP1Jafy1LpMW22nj61Nyt
 zdVg63cDDCZB7G16qkBizbo5YzU03spgzaSwQbjPLzFIAZA4PlRRwiuwCGGBkp3UpvVLN
 H9IIyRr4yXjbv4dmxIy5RgrLSMttIOCtHdYphFjPJ+t5R/ejUHoqnthOCWfZ4/ZwqgcXe
 5tDSXrB6ppMIwPvnn9NWABQRiBXjp/e26elB8VbGlt4AB1fdPIEE1KDsLlKLT/5rKGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491380;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=HIu1+PfKwPcs9ZyUxuDkyb5FQbO2MoDQK9XMFmyXvJk=;
 b=TmiHybadN8seIEHuW1CbjCueYqcqH3ub0a84uMoupVCzhRLnyNtQpS5V7+CjC+TmbygK
 K0+n/K3ugvfYFmmWIacwfjVA9KxBApHcgxicbr697Ctu8Pl0VJQBwAFiZ2XWQKcj2D3pe
 Evt3bT9QA1v2AeDyCaeeKjOyLjf3QiaHgPX4FFJJ/fIKIQLdEd4OFTGe4/SQKZBg30BaM
 UHgc5l3n+fbx8Tr+PV4CUgUorsWL7ubwScgeaCusriW+m2w/CGqmCWzjo6VWiVgrFX/NN
 DPqObFT9tF7raCm2Z1DhqfY7d7kiRomVoryPJyMUjQU9uXP25q1azCMmv0k9qKMWX2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EnNkHWQ9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EnNkHWQ9
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0F0960822
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:19 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so15729755e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491377; x=1793096177;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HIu1+PfKwPcs9ZyUxuDkyb5FQbO2MoDQK9XMFmyXvJk=;
 b=EnNkHWQ9aAFFatbORguPxioUeVjUX3BQWT8/HVzKgmbk3I9glOlSuPlbtT/LWj/bKu
 rSd8CCyxnU+Nwrc32p/NoO0CDeRPIwtNfUdJBknX27TvvCa2taf1KIZV+Z7soQudhczd
 K6MWppI4M+2JqPpAz8TubLKFKU0hrtsE79F41LQvDoDOtZd9M8GqsU87DcaPabKbJopK
 bM6nRiuliQhLh5n39Sz9ehfpzyKscwiinDQaxzw2UQHlpw5taD7Dv0RDK4Bmrs1JCiag
 Xt9qRRukNTq7EV4A48Ldaxc8dRJX2JbG4nWWmyHCJYZnHDy1RvX/XFqPvulIrHsWfN6o
 bhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491377; x=1793096177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HIu1+PfKwPcs9ZyUxuDkyb5FQbO2MoDQK9XMFmyXvJk=;
 b=x1YqMV/o3uU9TjT4ZVP0IxSM1WK3wWZmJJIUfzpi+3v3cGcTjrIOXdQIaQUqZffWFx
 S4+dZ398raNCHkIJR/yvuNpsAVq6IBqFMe5NTnOTcKyz9YHpYAy+/nlpN+DKRPtBvdFf
 TjcStXbm/+UvxjDwyBS8L07ckC5C3UjXXZP9Tp2qypiqXwNpRc6q1JEGDdJnZBrHNUQm
 FOBnSugkZi58Zi9F01/2+Rr8C9Jj9h9YDiYcdPBbR9NRmMunQZwUqDTzDrmFkLEbO/ib
 7eG6xsqiXDcyZq8f6xQR8VXPWWtswVWkcg9OoPv9cJDZuQubSGQsPrzSyhL24v1VRnVf
 qcSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByP89j5xdojkVMvZj4/rJM0VHFp5O+/Cke+VaNVViOjFc2YaEYu79lBa/RQV7lRECGyVoPo4fY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+rP75XpKlmRtkmUKIyM0BO1pBNoUQdmr987KaoTp+KB2KhCu8
 djMwRt/QNs5HLVnKuTJKYhB38aqEbfK4GJeF4TxI7M4HnDvqbRK1Zjy2
X-Gm-Gg: AYBFou32v1uKbcNGstTQG+EXfXuTyP8RCLfD2V5cXAFh8crFZALmygNRXiHxsPG3tvi
 ck2h8B0t5VGFo0VBKGPvb+P7GCtjgb5t4cH5kmbwkrVSx2abwSiznUembhrYniOpo5z67bFDC5L
 SaUFyXM3kBfM4WQlsBc+bllNOX0WdrkHvs1ddtAWdBjb/ReMO4WY5dGKQSsFtnEJI5Sx3HdfYiL
 amhxncKS8vdG11VTH1waul9EI7gQilWtO8FDnrob86ZIB0fM3H27FSD+0CfTCGU1URcJ4sooAMO
 eiy42DuEUDb1ecAkuJJI65HR0iZEszcONCGi7mrkmXdgd4T5X9HU9wK5Q12mtrg7K5hMnIXNt/v
 cCrbnThwar1BdyusFRpYq1mZLmAptydtYlkg+jrfojflAK+ptwNeitKWaBAjYJ2YKPIo6I2H66v
 b8AJFhCQAyDPqNnkXVoq2/AXgeiRhnxx+bgAJulyHUrdv36KprGj+SqDes5KUb7iX4y5BMhxCZI
 SI3TQ==
X-Received: by 2002:a05:600d:848c:20b0:4a1:e9fb:7677 with SMTP id
 5b1f17b1804b1-4a1e9fb7776mr79001685e9.8.1792491377379; 
 Tue, 20 Oct 2026 03:16:17 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:16 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 8/9] usb: ehci-vf: take the register bases from the device
 tree
Date: Tue, 20 Oct 2026 12:16:07 +0200
Message-ID: <20261020101608.2818265-9-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020101608.2818265-1-mehmet.fide@gmail.com>
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
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
index edf100fc3b8..e67eae834b0 100644
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
-	}
-	if (i == ARRAY_SIZE(phy_bases))
+	ret = ofnode_get_alias_seq(phy.node, "usbphy", &seq);
+	if (ret)
+		return ret;
+	priv->portnr = seq;
+
+	addr = ofnode_get_addr(phy.node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(misc.node);
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
 
-	priv->portnr = i;
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
 	if (ofnode_read_string(dev_ofnode(dev), "dr_mode")) {
@@ -215,7 +228,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -257,7 +270,7 @@ static int ehci_usb_probe(struct udevice *dev)
 		}
 	}
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		goto err_gpio;
 
-- 
2.55.0

