Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDB606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hKAJ1w1p;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lGkP6adV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3738A4083D;
	Wed, 18 Nov 2026 07:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HK4oC_DRcIg2; Wed, 18 Nov 2026 07:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CB7040844
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794986621;
	b=tRRdC691Dh1xwnnDcJ/JBK8ZO+sC9qbJjlEidmLcunCcYouAheGosimnm8801hNmneC5
	 B/w0PLZ1zlz/8ySR/HvcAMMVknROXVYCPz1bUVuusoqD/lmOpuAGXmh9j3T7wTSbj3lfV
	 henjZbG2m2bFJCWc2HLSKITLGdDxmb/nWHFQHnpYKDC3qnZuot2IjhrMTZ8QV5virQC52
	 MT1rWqRCNwGCBvJoNzS+lmJVahgTj88jjVX59taOrBvmN0hTtVqY9pj48LIdOkKO+TTNp
	 ujrd0Dg2mb6J1GyITlRGKTVs7wL/D9p3gasRoQKhPmPtM3iN9pnP1w5jFDbrqfMCfKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zppwL0CL1EI4qOfDo/HmPoxrELTFdgH8Jh1xwl+sgPE=;
	b=VRdoD/iOm9dwRvxcJ/Q6eDsS8IAi9ridIGd813UOrJGiEnxguRezX4bSOLnKomj0Tqlp
	 2dVw8coaR3Z+tKsbBPQj5sZ7453mZs9wcoPt1tloLf3jZbPDMduLxywUpwTdxI7c55NDT
	 VowEZ6qk4U5+uSUx1lLeaVIIZ+m+lD0dgF5B+7YTERW0LNKc3rZQI3GQQ3GsBIewPgI6F
	 w2CQbKWM0NL8URW12CMScZXRkIo7j9hdYxbrnMkd0xvfNwcoedfQtggebydALEA0ASzrY
	 RvcXNSyeR3HahObbKleVnNjnyJXZ1ATaWPzBy6kghJYTzq4doyy21qJ/NkFC3J3UDvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794986621;
	bh=zppwL0CL1EI4qOfDo/HmPoxrELTFdgH8Jh1xwl+sgPE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hKAJ1w1pD7FLn1dQlar8jXFzVb9RPa/3jgTykySpoPHbsnqvc7uADoY8KGuuyEdLc
	 kODpfqa734adZ0Ko6CrE2b0c7+mzizV39WzpFWNLr+f5r/r5uhxHih9Wm4xdl4fcgs
	 uEnrMudqn7CYvlHanWnugMgCjauo1yqj++bsDWWRQaJNdRaNhs7MuD3lS/J5ELcPSt
	 8Rxf55nk68EAMCN0fucxICN4f5M90tdAOSH6ocsCe0DgtwPIt2WtPppUzJj2df5pP6
	 vDhzDteueR+8cuEV03v1rT3o3cDFeKahLHG8Fc4ts+Z5Uoxrw9+6MrBb7jDeGyZQt0
	 zkY9pTUDgb/HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CB7040844;
	Wed, 18 Nov 2026 07:23:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8CC59F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF3A4400A7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2mYgHijb8gz for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:23:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A90FB4005D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lGkP6adV
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A90FB4005D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:38 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jTtPM37xYzMlxC;
 Wed, 18 Nov 2026 08:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794986615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zppwL0CL1EI4qOfDo/HmPoxrELTFdgH8Jh1xwl+sgPE=;
 b=lGkP6adV9gP9zPqf5/gSRQh6bMIVM4ytDii4bMFMRhJ8ZAXzcHexIqIoPD5dwmuqWyUBmT
 Vz1DIGyCRXCLaxoCyR3tZi9bYA/R66XfX0vtv9BlVJdJXIL06tWkFbs1H5g4+XYSi5pQBT
 iaGNnCz2ElzJf1rYl9BOS+SRNG8w4kPJgKSnm/kdT5ZNOYGrq+QcKAvJ6MGShuRzVeeiP1
 aM4vQYpJET8mycXXEi31PhpYJz//K+eAyT+YkP8JOkq2/397x5ZIG3LnPQYNax3pu7QyX1
 4UmoV5LkDq7ex0LsXqI9FrVFOOZGPb00fTt7to6VUUj5oUizWvM/L2A6LDQIIg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] usb: onboard-hub: Move usb-onboard-hub into drivers
Date: Wed, 18 Nov 2026 08:23:08 +0100
Message-ID: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4cda71a80942d91696f
X-MBO-RS-META: cc3cy7mnip93446d19nrf6j1qmccczhm
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the onboard hub driver into drivers, this is a driver and should
not be in common/ . No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---

Cc: Alexey Charkov <alchark@flipper.net>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.u-boot-project.org
---
 common/Makefile                                  | 1 -
 drivers/usb/common/Makefile                      | 1 +
 {common => drivers/usb/common}/usb_onboard_hub.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {common => drivers/usb/common}/usb_onboard_hub.c (100%)

diff --git a/common/Makefile b/common/Makefile
index d62ea34599e..ac6a2d1ae6a 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_PHYLIB) += miiphyutil.o
 obj-$(CONFIG_USB_HOST) += usb.o usb_hub.o
 obj-$(CONFIG_USB_GADGET) += usb.o
 obj-$(CONFIG_USB_STORAGE) += usb_storage.o
-obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
 
 # others
 obj-$(CONFIG_CONSOLE_MUX) += iomux.o
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index db8f35c10c4..e7d5356e521 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
 obj-$(CONFIG_USB_ISP1760) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
 obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
+obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
 obj-$(CONFIG_USB_R8A66597_HCD) += usb_urb.o
 obj-$(CONFIG_USB_EHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
 obj-$(CONFIG_USB_XHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
diff --git a/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
similarity index 100%
rename from common/usb_onboard_hub.c
rename to drivers/usb/common/usb_onboard_hub.c
-- 
2.53.0

