Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9362EC5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 15:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D4964089A;
	Tue, 18 Aug 2026 15:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lH_SSLNjaTHz; Tue, 18 Aug 2026 15:12:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E3AC4089B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787065962;
	bh=joYyyzRJcmmpioWmcbmKTB38ZaWcDF0fa66QTYb7efE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h/KdJbqHjTvZlW3tD6OOZNg4YoN6w7/l8IgTEadt9LePmSeEZZ8esRqr7jeziG062
	 A4bT6pkghPHssjOVmmjc622zQO8NtbC11jqOwteN5hrDVZAD5rxBN+X1ytWda+WHKU
	 cxpikyJFuLUeDF/1RvWIhtcMlxbb9Zd6K+MNbTLWHWbWJ+bccpobMgngj8LXBEQnFj
	 Oae+uBZ8AJ9cQsSfhtR6lckK4Q/K6X+9LXiDwig/+uuUtljfjHoz7QX0rWg5v2fIoo
	 mMHBWsqZB6YYXidY0uYefevo0ZKFj0xuGTlcCjcupL5eWR4GL3V5SWBml65vjRi+dV
	 LyxHCp+FyXY5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E3AC4089B;
	Tue, 18 Aug 2026 15:12:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31443282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E6D64085E
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAhmKziSLFa5 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 15:12:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3E5D94080A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E5D94080A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jxA+HUig
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E5D94080A
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:12:40 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49557167508so48464315e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787065958; x=1787670758;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=joYyyzRJcmmpioWmcbmKTB38ZaWcDF0fa66QTYb7efE=;
 b=jxA+HUigoy1OvOLWy/PTJkVTPu5l0PfmQjbc0xv5wTXBNk6+pBTU6ESg7VSMmW1UJz
 +2XBCUe0pIy9eRvo4dUKJDLflS6xsYcCIFrPPLiEOUexsZ7zuor++qlOq4EA7gz94O1H
 0hjNnQ8/fZKgTsM13KHTf7vzcVAC/tN+IayKWfznE58rfCWWi4x4FT18FHAc1xnyDDKh
 IHTkHt6+fayTNPLATeHYCBeoGAf/FNrIiWMbvFwa4s6RNe2ulM2A9UWS12PhimXDh5PK
 PD1eQAV/nG+ZSKuMNkcj6vNm3wD0JaWvUZ/g7qC92VHEKoWxm8whOSgTrqiapVV30Wxd
 b5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787065958; x=1787670758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joYyyzRJcmmpioWmcbmKTB38ZaWcDF0fa66QTYb7efE=;
 b=SGldzw27FkIiJHGmL/+C0tkkX6aFoMjjiwMDLfvp7IukvKWJGtJDJsvkwQg08+/F4q
 EZEUFqqdPzjMB7837PeBKw0hGDDXPM5Yzh1f1+sWXmf/j54jj9g/OFobOJuqcYKglvOS
 jyZCduSgbDcruQ9dNHQihzdUzoYi45JzhYzS18sohhDtkreIzJqgHlDCM/aA7w+g5D9o
 1/e6H9JLzR47kQmAsisiFSUQr5QATmRQ0Ci+pPUCjwK/M1a5E1Q/8CMZmvhGGsPMTZYg
 q30r/6wF1aOZYP+LEWkUBvaELaigcJE920ac25+84x+QaJtluPFSMbSwxAQChKGwNz6B
 OtOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqC8TgyaH0hwg3FShu1zDpNEL8RZAH8xog3vvskWonlfQAcjPJY4lCdVViwu3cryJVBgrUu8Zw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwFYtc2UgqXfKrumxngFm67JGOfJK28oK/FF33EzbcpCRn4tTIz
 IFpf6oDjOWi+TUJZrQUemPy3KGA0qU1gabnY5ibb+IjWDBRYdbHlYDpk
X-Gm-Gg: AR+sD105SMqR+CtQLNkYvYHkOGrnrgsHlzl1fwSyKp/3bPCP/Z9/IysYGSKEIV1z2Ea
 Xo/9nyz+LaDkJ07j0ieGKPo1vg/tQ7ckz6gOC/dSWmdfKQ9AWZXQscSpO9CKCDMWyf+/+EuhXpB
 BhpQoMAhUeRDmoUIU5ler7COU1cP3T28plFmWuyltpBbLBQkonGBY0bdDnJRw8Cnd8Jo2k4ZscQ
 EoOrXUBB+pMSRIppGhJSK9SJg+a9FGa2hcOjQkEf+JSCJztevIA7p/hLLqpDKXwUFu31Aq1hDL9
 WXuc0R3PIs1HEusXIbma9VPzz4uiO9A97EpOiFPsDgoxu82e/fd/9HIG4gS4z8CTXH75mNZ9ohH
 w+eLZowyRrzXw6tUY6Eh2+bqFbDt4Feu32l/xsLnMxWMXbqrito0f5tVsYu1KmEZXEB08EI4R2b
 PEfHovmbe0W9RPOzhyDlRLgSB4+xLnyjElD6NQx/z7LisF/VCKiHlq4DArASUy9acZqO0=
X-Received: by 2002:a05:600c:468c:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-4999fb6d4d8mr133481705e9.11.1787065957917; 
 Tue, 18 Aug 2026 08:12:37 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b7840esm11543237f8f.29.2026.08.18.08.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:12:37 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] usb: ehci-vf: take the controller index from the device tree
Date: Tue, 18 Aug 2026 17:12:36 +0200
Message-ID: <20260818151236.2891878-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" dies with a data abort on a Colibri VF50 and on a Colibri
VF61, and the watchdog resets the board:

  Colibri VFxx # usb start
  starting USB...
  Bus usb@40034000: Port not available.
  data abort
  ...
  r4 : 00000003
  Resetting CPU ...

vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
sequence numbers of the two controllers are 2 and 3:

  Class     Seq  Probed  Driver    Name
  usb         2  [   ]   ehci_vf   usb@40034000
  usb         3  [   ]   ehci_vf   usb@400b4000

uclass_find_next_free_seq() starts numbering above the highest alias of
the uclass, and fdtdec_get_alias_highest_id() matches an alias by its
name prefix plus trailing digits, so the usbphy0 and usbphy1 aliases of
the vf device tree count as "usb" aliases and reserve 0 and 1. The two
controllers have no aliases of their own and end up with 2 and 3, past
the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
loads a base address from beyond the table and writes to it, which is
the abort above. The bounds check that would have caught this only
exists in the non-DM ehci_hcd_init().

Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node
to the index of the driver's own table instead of trusting the sequence
number, since the alias numbering is what goes wrong here.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND: "usb start" now brings up the host controller and enumerates the
root hub instead of resetting the board.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 96d1363a76e..32fe05920d0 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -221,8 +221,23 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
 	const char *mode;
+	fdt_addr_t phy_addr;
+	ofnode phy_node;
+	int i;
 
-	priv->portnr = dev_seq(dev);
+	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
+	if (!ofnode_valid(phy_node))
+		return -EINVAL;
+
+	phy_addr = ofnode_get_addr(phy_node);
+	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
+		if (phy_addr == phy_bases[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(phy_bases))
+		return -EINVAL;
+
+	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-- 
2.54.0

