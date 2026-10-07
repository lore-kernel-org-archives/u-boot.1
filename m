Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EB5CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B3FA60812;
	Wed,  7 Oct 2026 16:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ManJa86IpxBs; Wed,  7 Oct 2026 16:07:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 25AE76080E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389243;
	b=JoQQP/Tk1tz51OMD4bw+D5p/b/WqU9kgGrI6K4M421LIz5Y13rCeeQq2ebYwmbZGvHYe
	 SJQzU3Pp1WkV9C4VMu453kTvTNk+irPKji0uxi/rpUn1i3hyGig6EzHkhLOriS7adxgKG
	 3W47/JSp4mZPUMMqU9kXdKyYTKESzA1SWbRlzDp7IxiGxTEjuJ6vd3yyBJXR/k+uddReC
	 D9QFtPb7/1bT2ZZQ5BFe9vKegs/Hn0CElSXqf/AFbcxZpp+lhVpponDjbgfjV4qrEvJAK
	 EXv5JUFlyje1uLirbtzVWDx5LujCu+Ap2Wexd5bh2y/s5enb8elPgvTQP6B/V09/dlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lmZKjB5BBB+vMjFnVqohWt60+sBB8ub2L04B3d9sTck=;
	b=IC9aCvZMIhw8wn3j9kH3lHNfXeajDMuZLHrWvHi4TySqp/tXss5gEXLiWwCk5PGFnr65
	 UzACgWJjKKYN9WIoNp64WX/9Yo5Rm5Jjjo2PvP6VKxCE3gQH+wbIFu1SKpG7EI16pXhx+
	 J3MOwPk2hOesr5eqiZRztYf9if7OHa2H137WR+jTs0s3YerefbZat4vR1jmIkrLXeTtPb
	 Ve+hiZT37KmsIEeWteB/0C31ZTc5tQaRvpRO2+x+uQwJYhIMgRMWVU+jihcrkoHYc+IeP
	 CpEdQQxf38KRwhgwe7coM1O3h7r4YUlS+ea4Kd2Bd1hH8XhGFW17auzXc2U7RtJ9cQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389243;
	bh=lmZKjB5BBB+vMjFnVqohWt60+sBB8ub2L04B3d9sTck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=brliVSFJ010TIVgxEfexhWRxxGmSFynYhHSsoJC+9BKhdDaTmU176aevRb9rkk3ty
	 AYyelq/w7Bo7vF78CiKzxoEdHJFXTw+CO3eQA57FiJEyLxgbhLTWrgGkkaY9HJwa2X
	 G08zQBOXmlzuCOX9vGR8rfkKwc8PMH0dp+JwEkWUqYyp4PyP8goDMYzwozZwK29kfV
	 QnqZHgs2kZpd1+8OuKjHPqjK9XKQUWGmTxIYgfKjA/P0lsmMvsG/h0DF83UbXdrA2k
	 +6ImJhcG7XdCNmSQLtPClmwERPSNBVR2DGLkHBZwLRtwAOlEyBbAO95ZCdJnSNnbE0
	 4LyhisWK0npRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25AE76080E;
	Wed,  7 Oct 2026 16:07:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFE93335
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95EB0400B8
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1BPN9V9FcB3 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 85C374021E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384354;
 b=dDqJU1bdr1hdT8EDGhvXiviriHIa5nd5IqgbRbwzzRBfDslbNCCpQqNDxfBd+qpjs6g4
 EIYZ8D9uPhhszM+I36mb2bLxC3c8+q8Gw/qAEXOBP6+H+lcD5cR+QdCNbU36cwjao2vWW
 LERPVc3c8dut36qqO46x1xzeZEny8r1t3dyuYIsYihi7G6rduXmQq7vJeJqKfHCLPCYiW
 g50dWQmDaUAchJfovzq90NxR76o1cBJZTJcU6uQCZvI9kNLIU8c5Te7UX4Ezfsr4BZ7vY
 Q9TBje3mlb4YpZRo9BqECvHGNrmPzg2Z6pReutbaApzWYByTikdCCm9Y3E9vCBNyjmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384354;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lmZKjB5BBB+vMjFnVqohWt60+sBB8ub2L04B3d9sTck=;
 b=TJ1Mxh0qlQxu7Snem+v+NAnvpQsByc2sesf7utsaslP9wFtEJ8+zbYMsR0LGTa4BqoZF
 e5nSJ6GvN5zoEwBrRs2Oemq2kx7oWVzY/XaWga+16KuX1ftk/o+sa3ydo2ZPqTOJ66twJ
 yJ/QQWzGjCg6wDuxYg4ceIk6TiZvVMSE3rcXBOxfmI/nT0ixO+ltek1SQ8hmlJYw6ENaS
 cjkG6Z6dsjfE95GbLQSYYMfvNEpruFSbM5u0qLgSDquk7eYMb2x+hQ6/smui4tIEDGeYF
 oEjxyRepe7V4twj1IQNVT8ceh0anaELuSdKJO0gJqBg8fvJuy7iV2/T7+/Z4yA60cTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ht7PS9ab; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ht7PS9ab
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85C374021E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso38616135e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384352; x=1791989152;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmZKjB5BBB+vMjFnVqohWt60+sBB8ub2L04B3d9sTck=;
 b=Ht7PS9abViu3V2fbin1/37vJPqOW9awZv2A8PPMGA20SRbAdK9TW2X/JDS+kx1nqIf
 NMOtwmK8164Jp7RM/PYGFIYSy4I+doYLtmpurg3xD1iHYYDkq/qlWKLCLS98A4DM6th1
 txKOA6zQPIexT4AVekpZ2ekAeL9nNL4d1fCimLuYNLMujG9N0H6qYJpiFPxYqbBgQ63e
 Ndqe0I/DCzVNCvbB+vzRxnlsG2jx63+e+y4f1lmTlgMTKqhF2oPGhTsXiitsGWAMyHHZ
 /LgMovdBz0ancCsAsqOv/kMwyDV5DisKJtaTFV87Halyj2iovKc/N7fGw42mz/7p8lwJ
 WVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384352; x=1791989152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lmZKjB5BBB+vMjFnVqohWt60+sBB8ub2L04B3d9sTck=;
 b=DyLMHgbKrlOWMOWN8rzxn/0krfmwugs1b+oFiK1cqprwTWTQUWSK5XSFRgT+kQc+d9
 gmvisMgcMVe4UdB9uSMC97WtrQpPeTMWaGwkHVIM/ke2RiCB9WL7fe5f8sS9FRQvMRGF
 Pk7lCVuev9ZO7J0y4WKdruLu52oV6ylrcMu+0hKNk0WiM1HNtViVGRSIoaKTufVot3zN
 Zxir+7dqtoucBAP7SPW+boSQqJJqXwEkUcQdRAgC9QFVQJXoMwIZc3YGihqmXenJmgm8
 O+2/TTFmuDKGCy6FhAG4AN0XQbMs6DQthL3ttnrBKy0Se0YXO1LHs1WgPzgOfpg5BUjE
 eMRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaktk68Zca9ZHBX1OWwkD8qUHyXVD9JGUKJ7BbzUSoPNNK9epCN8o1wx2zqoaNCUWv1gbVbh4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lDCfhC3LXH1useSrDXje29LTYrc2hq0pDJvn0Jd0TED4DSsIkF
 eENlKsGGQAo5SuIkOi2/y+0RIQN2lgQPi5vvFfQu72FImHDjevaClgy4
X-Gm-Gg: AYBFou0xP0iJ47DQfnbLJuX+0v+1NG0srhKj0G4Jdxuc0N0WRzKLB6Is4VR3+qnV0qg
 qJp+5FzcjWtEDsrVMZCDwgzTXDZ/AQdEQVVkS0WbwUrRhuwNYLf6izJRVShJt5+3nFFhPvzH48A
 75P+ElKCPbsPxaFXdLIOHZPg/izjNgKC/ZTQXIDTYV3szSERamVJNUV05yODX2CTqBGOxf7KU6V
 lhBs+CcwT7thRcqVnPKB1bwSQvZn/Y4f+nfORLO8vHYbiQePKwpcfPnFVl4/MMoNRv5xslCmT1z
 q5ZmSlWRJ3wdrdOj8BHqA/wfU1TpvNR+akfrXf4hGNLglqlqQtDRkCILp3vF5iHy6AAC5vmp8fH
 LZFucOqCwa1zC24yMwlTSFRrQ7hFeVzx7SqqGm4mTYQGPGU/IJrVxqycatumtJSlsnL4bYCQgy9
 IQy9Ny1ZpCd7jpze3z/oSrqGPtatbv+jRE2FvNIEYbDswbm6rUlBhbHsHv5T9iSuL4uZNappCPC
 oW8
X-Received: by 2002:a05:600c:4687:b0:4a1:688d:a41c with SMTP id
 5b1f17b1804b1-4a18065e235mr41907335e9.25.1791384351949; 
 Wed, 07 Oct 2026 07:45:51 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:51 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 4/6] dm: core: add ofnode_get_alias_seq()
Date: Wed,  7 Oct 2026 16:45:42 +0200
Message-ID: <0dcd337468ebf2c5baebc91c32bbf990422c2d32.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
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

The sequence number an aliases entry gives a node can only be looked up
for a device, through dev_read_alias_seq(). A driver that has to know
the number of a node it does not own, one it reached through a phandle
for instance, has no livetree call for it and is left with fdtdec.

Move the body of dev_read_alias_seq() to the ofnode level and let both
of its variants call it. No functional change, so the moved lines keep
the ENOTSUPP return, the #if and the fdtdec call they had, which is what
checkpatch complains about here.

A test checks the lookup on the live and on the flat tree.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Changes in v4:
- added a test, run on the live and on the flat tree
- the kernel-doc no longer promises -ENOENT for a missing alias, the
  live tree returns -ENODEV

 drivers/core/ofnode.c | 20 ++++++++++++++++++++
 drivers/core/read.c   | 20 ++------------------
 include/dm/ofnode.h   | 13 +++++++++++++
 include/dm/read.h     |  8 ++------
 test/dm/ofnode.c      | 20 ++++++++++++++++++++
 5 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index b5d13c43db1..81d91ce5476 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1233,6 +1233,26 @@ ofnode ofnode_get_aliases_node(const char *name)
 	return ofnode_path(prop);
 }
 
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp)
+{
+	int ret = -ENOTSUPP;
+
+	if (ofnode_is_np(node)) {
+		ret = of_alias_get_id(ofnode_to_np(node), stem);
+		if (ret >= 0) {
+			*seqp = ret;
+			ret = 0;
+		}
+	} else {
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+		ret = fdtdec_get_alias_seq(ofnode_to_fdt(node), stem,
+					   ofnode_to_offset(node), seqp);
+#endif
+	}
+
+	return ret;
+}
+
 int ofnode_get_child_count(ofnode parent)
 {
 	ofnode child;
diff --git a/drivers/core/read.c b/drivers/core/read.c
index ba48862f44b..985f6128d97 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -356,24 +356,8 @@ const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-	ofnode node = dev_ofnode(dev);
-	const char *uc_name = dev->uclass->uc_drv->name;
-	int ret = -ENOTSUPP;
-
-	if (ofnode_is_np(node)) {
-		ret = of_alias_get_id(ofnode_to_np(node), uc_name);
-		if (ret >= 0) {
-			*devnump = ret;
-			ret = 0;
-		}
-	} else {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-		ret = fdtdec_get_alias_seq(gd->fdt_blob, uc_name,
-					   ofnode_to_offset(node), devnump);
-#endif
-	}
-
-	return ret;
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 int dev_read_u32_array(const struct udevice *dev, const char *propname,
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index c905e86b283..e13271a824f 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1180,6 +1180,19 @@ const void *ofnode_read_aliases_prop(const char *propname, int *sizep);
  */
 ofnode ofnode_get_aliases_node(const char *propname);
 
+/**
+ * ofnode_get_alias_seq() - get the sequence number of a node from its alias
+ *
+ * The aliases node can name a node with a stem and a number, such as
+ * "serial2". This looks the node up and returns the number.
+ *
+ * @node: Node to look for
+ * @stem: Alias stem, e.g. "serial"
+ * @seqp: Returns the sequence number of the alias, if found
+ * Return: 0 if a sequence number was found, -ve if not
+ */
+int ofnode_get_alias_seq(ofnode node, const char *stem, int *seqp);
+
 struct display_timing;
 /**
  * ofnode_decode_display_timing() - decode display timings
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c..d0c17c3d343 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1168,12 +1168,8 @@ static inline const void *dev_read_prop_by_prop(struct ofprop *prop,
 
 static inline int dev_read_alias_seq(const struct udevice *dev, int *devnump)
 {
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-	return fdtdec_get_alias_seq(gd->fdt_blob, dev->uclass->uc_drv->name,
-				    dev_of_offset(dev), devnump);
-#else
-	return -ENOTSUPP;
-#endif
+	return ofnode_get_alias_seq(dev_ofnode(dev),
+				    dev->uclass->uc_drv->name, devnump);
 }
 
 static inline int dev_read_u32_array(const struct udevice *dev,
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 0f60c2a6281..07c1965dd34 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -523,6 +523,26 @@ static int dm_test_ofnode_read_aliases(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read_aliases, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* test ofnode_get_alias_seq() */
+static int dm_test_ofnode_get_alias_seq(struct unit_test_state *uts)
+{
+	int seq;
+
+	ut_assertok(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "i2c", &seq));
+	ut_asserteq(0, seq);
+
+	ut_assertok(ofnode_get_alias_seq(ofnode_path("/some-bus/c-test@1"),
+					 "testfdt", &seq));
+	ut_asserteq(12, seq);
+
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/i2c@0"), "spi", &seq) < 0);
+	ut_assert(ofnode_get_alias_seq(ofnode_path("/some-bus"), "testfdt",
+				       &seq) < 0);
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_get_alias_seq, UTF_SCAN_FDT);
+
 static int dm_test_ofnode_get_child_count(struct unit_test_state *uts)
 {
 	ofnode node, child_node;
-- 
2.55.0

