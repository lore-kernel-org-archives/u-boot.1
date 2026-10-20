Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB16606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QWFaE0eq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DSm7FQtP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B044880D80;
	Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lddnvmE7rpCu; Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D69981028
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491377;
	b=SU5xISqK9AeakCdrLwuPv4ETG4/KbvmeSnAwIHLIHyBpXYOp82KNaD3sP00ktX7ISKBw
	 oa1HhzNPwBqc6PD258FhY0K8tPQgKhnSFqMzE9ifv87+WqWVByoNhMaMxfUUsxIP+ptrY
	 TH13BVfB/v0AV3aTPB5CYe5+8fntA6xR7SF5a3U14xKa/Zs6NWh8Gd4M/dkxXa6OjqxlN
	 OqxHU4rgQAtdZvhdDkjc8slFiCV4LHe1jN7Mc945mqn5LcPJW0dVHIiKpj9hpII3Eksji
	 aIww5pYm3e+lVZFJIb5wY+tHRMC5rh+hTn+qb618gcP5vacmG2PI3M1jovI78iTkFFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zttFkRfPbGigwDH4H4+6atLfzB37p9XnTsqZZ199Lg0=;
	b=BhPe6IB5Mfrd26c1+dBospzdxk6STUmRoC5AqpjzrqwZTE8utKtGMsJVBPL9wXhLy3RP
	 X9SBYqoyOA8ax8V4xBDQQIKTHtyzSvhRm+jO0yZbbeKGaBl/BHcwCtU3IRMB6myo7QL5m
	 OPD2YpP5IWUdER2T6IFzaMr5NHIydimESXl9PfRxEWf8LZ7PP6kEbyhCZ/VcndjnS0Thw
	 RnTenbN/hUsxIW1d/LFjVniD8OZZmQHegxEw0XuVSOvmADx++P7ySYRBc8IVl5rtJg+s0
	 jxVZdEz4rN2eH1/KBOPlJQADV8a43tEwKUAFawLa1XYwF43Dx53UzXMrB884KrIzpSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DSm7FQtP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491377;
	bh=zttFkRfPbGigwDH4H4+6atLfzB37p9XnTsqZZ199Lg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWFaE0eqZoPweNhmIpD4O1X0Qecq92dOUWSmjoiCQcnXHF8tO1Q+jO1Kbxphg2gpY
	 6YtnBOCPMy86Jlt0n5HCpfK7nYJXZOn3NLl9UcYmPrUHGzZZHL6Ii1+We45xIyc6vN
	 IfxXIpeD4w4l2O7dcraHIVO9CJ+bWC3UcaiZa3u7i51vo2ywPfYY2tGE4URIEHltnw
	 VYRJtXwHc/o1s8XSPnpxQsBJZHgIcttWc7dBIe+TQ90T9Q2pnOXF3+fbhfufs7cL94
	 y5uWg7hhk7ikG2Yrjr/50g8F1h9R5YMpqH1QtW/zUNZlVg6SGJIvqKCSMLim89EkQF
	 kAWXDxlWXeLfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D69981028;
	Tue, 20 Oct 2026 10:16:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C9EA1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A7F181068
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmOYO9HqhGKU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B95180D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491375;
 b=mYz8wOLoERymerSdAfdX061hfWsSmiw57tEThrgRMLQYT1pImh/wt7iBIJ9jhDoTLGXK
 Hf4hzAV6NfzZLjfDhbDLr+PN6SS0ohOSBAKLHiTxMBaIWny1JRuAvCj422UHpdkxOhVyA
 osaWFk89GYr81OvxqXZVnSBVMPixV4Kn/YNdJSt+3PT4lizd4XbcBgN6kIXO7DlZtLNsQ
 m4q+2czxO9ko20LsCe/oolXLfWRdnq2n9tv5dZubRFBN/Nu+2UpAc6OIqKFGinmHO9QSR
 oJVSB7cpwYOqp9CrsBMMv7trr56swe29Gh6niHoShAnRkp1EGZNkb0FszcB8pg/OmFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491375;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zttFkRfPbGigwDH4H4+6atLfzB37p9XnTsqZZ199Lg0=;
 b=pFimyx1IorYHMkwGmVlJxPkZ2emveNQniuyR3qM83L48IXexm8XuD1VXweO5q2sZqmYA
 vY+GZGjwI3MSwp2VdM0zHPKsEoGddAUKIJjG/qeKEYHNdOT89TNJX3F8XaOfI0XeRDQPE
 OdBIjlw8VJtfwYAPpH2yJdKCk+4BwAzaZ93MJ7TDHyk6kK3wUwVDU2HLRYIwhUUdmOHFS
 oW2JNPTxk+FnR3W2sj8vOg+AaKfmm/9Q2591stDkEC1tvtk30CRt+3iFIGPjrtWXhCZoR
 tRPaeLJxmSOwybObZP66teh7G2xtJlYt9ESbeqO5cM9oUzm+NyvYDNYDOmg9MjyZtXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DSm7FQtP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DSm7FQtP
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B95180D80
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:14 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso21010435e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491372; x=1793096172;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zttFkRfPbGigwDH4H4+6atLfzB37p9XnTsqZZ199Lg0=;
 b=DSm7FQtPHUOcNZvV/9IzVu+7kiyquck5FbQVlwUGgiwU8CDXRXa3VxA3+x9gcwYSZn
 QmCoTgfoTZ91mWL2CelN1PHfdhhGv3slfPyduZmxfxyadRmaqwj+SNBpAxfO37+r08CW
 S1pQNfXLY1jVCEOxhX3mvlzylyTpVc+LvOwY3f7UcTXQMB2NzX9A2Zau9ue58sYx1gDz
 P0wkLwnquNU3TPi03QgpAJyKJbBODk+sBy3+al1q4xeJkpon1N9LGpncIUIl8p06Zwp8
 ARlVLC8FjCsN/sDEMvdfI7rAi4XiOnkbLy8ZPcSwQa3kTmQ6Qec+65/QoRS3k4hIoLx9
 aZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491372; x=1793096172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zttFkRfPbGigwDH4H4+6atLfzB37p9XnTsqZZ199Lg0=;
 b=xz81NMxqNOXF7n+Shg7qMvJinQps8l7YDAFNf6L2Pc1NL3ahAYuNDDRI7YP/aL8n8Y
 NrQUYTFBCRaxWqw1HiUDnLpSLW6Apc58MzaDgg8sbodKCKcDHgKEgiHxr/dpPv/DwNqu
 Smo+oa1E5DL3b+ad2LlDZbZ3f/CcybENuo5TR1ZQr4WWVxwbyZeU8sEbBc5NO8BvIewP
 dVj+SmL4ocazIrbeLPGPCsN6UZxHa3eFEJwi54E4AwH0jwuDpsacyO2WxT/ps9UMVkT/
 m7DCsB/7ulnloqw2ji3sR30I2cN+V9L9pjdggpo0WzFqcdQKEL0C32oDH4Tz8g8G6L4/
 X9UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2XiIwXzwRrlTlsgxnI7CpUPIRmaPg20JrY3ZvdehLuTXU5za/nI4xnRABBVdrqWMNzquWLE8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYISBCcOm8ZGLu29CR+TaJyl0ri0CW9G7MYW4py+p8sddimEiGv7
 /S96E6s9jGpykJ9e025aowejRsH6vt6alPJNszNncYp1KOWTFI/cpin5
X-Gm-Gg: AYBFou2B41WaKEq9/e7Xdc46tV33cZboOBucrOLCpbzlA8AcubW5OBLBTNNW1T6LGVv
 QsaatCNz0LwqNW7T/hNN/4TiLFWQ/ti92HZ1V1G3rkoduiaM6fQ02szLLY0ZAzvTAzZrJxEhKpq
 0Rfu4HWxKRZ88mHsA5lyv9hM1+bbO/2y+EPS1BoYo6+K9ieDzZh+lovcPjB4/DvBy4FGsc9eFzg
 f+0W7ZGXGBeVTn2ccWN+1tsTD74epBv0vc83Fa15MHRZkxepXY70e1ro4DC7IDdLqlkfE0QbCs+
 Xwdfp2nBXGB2HR2B3QVCHlEg16/PvwJau3SC6Y1nzxLW5kY5qwc2/YKuXC+NyesRZL3McE364wZ
 KwnonaPukTHySN9NmVcyorCiw83MtAIWcvISWvrlAWYGKoVtjHApzMW1A4gGlRYvAEyl6OfVr7A
 IGBhdyUdViSzoeFLqvVIu0elsk1Ama/qb6vN27m9wEJ2GXObVpiiAoG6SJ4lVE0YJNEUrT7eUE0
 AX6MIFSdA68Y6M=
X-Received: by 2002:a05:600c:3513:b0:4a1:d05d:2af7 with SMTP id
 5b1f17b1804b1-4a1d7607497mr216378125e9.10.1792491372050; 
 Tue, 20 Oct 2026 03:16:12 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:11 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 2/9] usb: ehci-vf: take the controller index from the
 device tree
Date: Tue, 20 Oct 2026 12:16:01 +0200
Message-ID: <20261020101608.2818265-3-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" on a Colibri VF50 or VF61 ends in a data abort and a
watchdog reset.

vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
usbphy0 and usbphy1 aliases count as "usb" aliases when the uclass
numbers its devices, so the two controllers get 2 and 3 and index past
the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
writes through an address read from beyond the table.

Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node to
the index of the table instead of trusting the sequence number.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v7:
    - the Reviewed-by moved above the Signed-off-by
    
    Changes in v6:
    - Reviewed-by from Marek and Simon
    
    Changes in v5:
    - none
    
    Changes in v4:
    - sent alone before, now patch 1 of the series
    - reworded the commit message, no code change
    - the test note moved here: on a Colibri VF50 V1.2A on an Iris carrier,
      "usb start" brings up the controller instead of resetting the board

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
2.55.0

