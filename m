Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6F606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ayj3KKEP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3wnm93B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B9D2607E4;
	Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apyzDrpKBN67; Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D3016086F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652952;
	b=DrDxR/NAFff1z4haGDUAbUmFnjp6XgGgl50Co/oTOPc8payE0IWU4l0ky7h5h2sd9Iry
	 Jprv52ydQreeS6+/uuYRqIAtqy1OwluSgruQ1OAiXKOuvKZy+owcCds8kIsX6KhfVmFjs
	 /k3d5pqUPtTS/LoC7LGQLCrh5bhIv4JVdrZuxapldqUHUnJEZR35YYFZbiOKa9ZNA68mf
	 uQJUTD+5iB9P4G0sVRb6NZr9l5oYV8BbvLsWJfQRWVk8oYVVKAZd80JJOanY9tpus+LVy
	 bLdOaSXYVy0RQIpznSXLeOmkkhlBOKzNVuA+K0NAxbLRIR1ja9dbf2zkxdHeHpBafNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Le/ve9NAFdoCaMFg/h7tunzucbgB2d1k68zXlLsIaxM=;
	b=RM5rg4XljJ9qes+tB0vWiSHDGLZB0oVkQXgXWR1abpPLrAoNLYwECEXENZzfa6ezc6i+
	 lVB53fx63Mv5RyqOa5oCiDS6zUbM72HGRxy1P03YaR+iuL8UZXpIFPeJeGfYFq5RarRL8
	 UQGqWKDN+EFqwZEQ/24Skznwf5gQnmjoukxzaY8/YyYl9eoeH8EGNwH1zU3IZ9wLiRjEP
	 qlWo41s7TXekHRJfzkt2/Fflv+Btu3Aqc7OYirHVa3TK9sBxvugo477sj1OhSBVDkQM3d
	 STbIQlfQulqlUKoqMrbguer13Hpzv+DZ49m5XQpQiJczb/z+NO1gEzLvaWlgKbmE33Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652952;
	bh=Le/ve9NAFdoCaMFg/h7tunzucbgB2d1k68zXlLsIaxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ayj3KKEPIBZJH6N+xndolPSAcoshitduz3ptXYusNi10VqSVt+rescv1cxcjY79Ga
	 OxPKpZwClwqKeqDi8T4gkl70Y5Hx0JfINVOUQF3Jxx6adJEEqpEmanVwBbRlaFgrDZ
	 mFJazCdSgvUC4crIkOOklgBKCvT1+gpZIWnXPjq1U45oWpKXq3oeyGcQfHQliKsDMy
	 SHnV7j8UfjgcPUuzL8B1JESWgcGuMuuOZi1gElhojYEnikHAu2dsBa5bGcxBtLDZTO
	 iZ1zSSryn5urZKYB1FSz/RXSug1N8iJtog0hl8WNEgyb5CCt3KzejriKWYxVOwlAM4
	 mIR1D4Def1JpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D3016086F;
	Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E266D3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4B7F40075
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHn-IhZOCOqO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E0AB540042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652947;
 b=fSW9+iRRkZM4coumgAirsUDVte9zLUpymt5F4qifvwPccDlsAmDMrL8ZyIfqQdfS+qfc
 Nvuc/n9GsUTsUF1AMA9aEkBqIu3HuzFBPn/XPwgQk+arcJ+8ihstSWI0obJGVR1FjQm1K
 JJUc4doD50ADtOX0uaOipzzq+YR+48ti5WziviX4dOFQZg4OrBfsVNv4s2iLtm6fuZg9P
 hQkaIa5bS5CsoMXeWgi/2C/DEXfd6Qn5NZXCIz8DG3w+BldUP5FRBLNevA45IkCmgM8gr
 dMN1ZLA/Ynlwg1J+4pKwlCXx/MgUtwivsGQHLkVz48CsKyEm3BuJHfW/mVTIxgnDoAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Le/ve9NAFdoCaMFg/h7tunzucbgB2d1k68zXlLsIaxM=;
 b=AoC24+OnBqBVE0CijAmI/eiToDdskLiBnUK/C6kiERGcnnPltJdWQWmISbSLu4RM0u9O
 vuG3oL1E+WRRGCKa2WFwgnHknRKZAugvbVvoj3WmoNFFofVWXxWx2pgMRRtXEa2hwQlor
 +WD0cGSrxlA+ywWQIMh5/Yqcu+VwcW4MF7FuNO+GGu/rRLjfcbiaIrE0h7m0Z3n34N10r
 QUXvzCdxQqhAv2iWH+oRQhl/zhCuuItxp0KQsrpXHBqZ1dNjUc2U0gaa+pBIrOc9HI+GO
 QKSXTHR1aU7giAqf1/3WlawVWqEry9g+psKIhESs//2eT4RFSLgKwJpeqKYQQ99I77g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=e3wnm93B; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=e3wnm93B
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0AB540042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:06 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso213975e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652944; x=1793257744;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Le/ve9NAFdoCaMFg/h7tunzucbgB2d1k68zXlLsIaxM=;
 b=e3wnm93B4TEg7hDhOVnxlXDvhkWRTOGDq8iX0oI/8by3NVK/WhUfoErka/hURKZtdT
 1CfmLC/4RrH/9NvsRa9mOiIA0ms+YNgMZVJRWP2g80SQSosopMFow2EnxnbaUTdf7cv6
 r9vbwLZcFs1AwxMTcqwxodOS/7/x9uuqSpLqOHTkvMDSlB6sMaLwRQExJAD2W5jBLTK/
 NikS2XY1quHK1fzYmGtNISXnNTqKH3MUXbHvZCM4TcSXoED57W9Wv6meDZK5HibWykXZ
 LNHKtKFBWd1wspM/YaT2PvkLJPXwX0khFfcX/hRKGS6JuEHth2ovBLVTNMo5Isxss0M5
 qRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652944; x=1793257744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Le/ve9NAFdoCaMFg/h7tunzucbgB2d1k68zXlLsIaxM=;
 b=P42aF2bl/k3V0UCLr5uDGRG0ZbjL5EgIgIAyxuayyovcBrL7KHiT3WsRel1r5H3OZT
 uqv1AnXT2IjfYoQbJY/0eNBKfYW2MqxgyMv6iCUBFV2w6a2v4DbYkZjDDZ/aPefPHWX3
 Fq8dU+9z1jNK/pIhEEaCVi7X3JOfZ+O4QOc/acFmhgMjQHP4y5XzCvRh7QbMTDnc8p65
 u2BGkFDZ0p4zw0GyGXPco1KzhJGvJPNk4PtxCxaMBNEQIG2uDDHTi8m4cUU7uNvsvMaQ
 ghdJEtZk7VY1CbKBFxqTAwVBCg5+P1o5bi/SU9eM+bg+yAv/epl6LVCMmpCpM4bZpzoU
 xtYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu/5/ACFiTg8d1Gf/Yvg3oLMJgz9KfJichantK5Hoseska97KSHZtgx5khyD+Qh7JLzt8APx4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK16XZ2gs0tEHFKDsE1VD0D0MDQqWSUE3atfedBgxNHHSeztOJa
 4+9tVK0aTc5j65a5qSYfI4ZAiRaxKDpQm/7u1Pb0VpWKqMNWIK2s+puL
X-Gm-Gg: AYBFou2cH4+0QC+pFF+PJG4FwsPeHiMkXoTPi+2i+/X6oWu0ZBBwG8rkhXvzp25WKom
 555s5RUj7S2JJKxld21LieOD7o9ebU4Egeizju5M83zL0OHEjaK7l12nii97tWY1Jmr9WvbfIaD
 vsoXYJ/0O8v1dexqwjdy+NSlW06AkkzAA+iXxe8cmSPSCGloubTthY3cmSRkZ8PjdhqRdXDNgco
 ZOGgU6wg9Snd4cmP8bTxYkSBFDUGKvd7tvv3EsfuuboWVZLe/sOSJ0YNnMSzKjfNXWTpBPvKww9
 1CNmlD7QaCvwoex6ZwpMODguBS5myiT3M/yezy3R8SUr7ykwhT8u5qQ874KKfeZ9ysMdq5Nxdsv
 u/1JX9wbMC1GNpyBAMhomcKMFhofFR2fE7sFVKV2oQgr8KVx4F06rgJNVT0sToFR+Qque9THJ9W
 QfebG7Ekn79zyLq6HU+RCJFGjSExxYQ1b9UWsToYiYKNDpo0uhg3QRycQCrqb2Nx1mpq7QV7ipP
 2w2MlcqKOz/V/m2B81Jtkt8pffZlJM5xXy40/G6uYKkkmHYulWVQCI8HlWMsw==
X-Received: by 2002:a05:600c:4713:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4a1fdaf738dmr90821835e9.11.1792652944030; 
 Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:03 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 02/10] usb: ehci-vf: take the controller index from the
 device tree
Date: Thu, 22 Oct 2026 09:08:52 +0200
Message-ID: <20261022070900.616265-3-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
    Changes in v8:
    - none, rebased on main
    
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

