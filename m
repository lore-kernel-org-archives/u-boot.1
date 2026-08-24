Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169FDC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB8F406C6;
	Mon, 24 Aug 2026 13:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGiPpXZPYyON; Mon, 24 Aug 2026 13:13:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577211;
	bh=dPdW1+a5dSqNRqaA+2rVRkPwrL3XItxIC4Sudn5RS30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=quv1W6hqHpZEnWzsErbWSUCebo6Afrmugf2ug2UfdD/lx4jQGgYJrBHexdIDb3aQT
	 gmCzT/sfA9/gSLqoIO3+khdnrGLTPSX0UYuIkjy6eWOItynlDJ2tm3jKPIM1qo57A5
	 iaZyN5lCJewTLAcDkgDc8y782zORKgjqGicK/A04/pY1QAgeJRkokoAnKooJbGPje4
	 volUcIovdvlw35yHZEsioU1hXgTpB7dwNY3DxvMO/29IwsqFwJ/yFbmUZWiVsWlfU8
	 jyVazsPebuELshNbr94lNv7H+mUfiISYh6IpIanKDNEb8glG89X6nNXSzMZQvxWoov
	 QNQ6GaOdiSwGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C83040699;
	Mon, 24 Aug 2026 13:13:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D810386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FE64605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JrVGIr10B01V for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=CfP3egHD
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CC2D605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:26 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso3005205f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577204; x=1788182004;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dPdW1+a5dSqNRqaA+2rVRkPwrL3XItxIC4Sudn5RS30=;
 b=CfP3egHD2Faf6C2JLucf86Z+n8Icgl5F2qPbXHtl1Ec21IexyEEpXyiJkZoCZrnP0l
 UVYKD9SUlqlAF5SSblFz5F9L9A5T13nOrIUhuRbq7OjswUVSysHc1pweo8+wri79WWpn
 vE0A54dfpdNU35ZJiDWepHHc/ZoqsKZix7mEnxHB+yAkqHVoKNv5vueuSNZAWK2N7e03
 oRYFYGCYNfrXl9MfEN35zfFVJeoH3e/+dVfwIx9qFuEHUPo4DKB4zCCQAU0sprmI5xt8
 LxJyU8VQw/ZI1YJW1QyFGgs3YDxeKQS6/06DIFXdTMCimyLVbL6ARGgqtVrRGSxu+wF9
 J9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577204; x=1788182004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPdW1+a5dSqNRqaA+2rVRkPwrL3XItxIC4Sudn5RS30=;
 b=HE3BCKGJ9f+uqGsntMDCynkq2w4AG4XhPF54/EC6KvEsoGHFD0ngmZWuA+CKIqQsBJ
 cv07tERsLmGYu6K3NcmpgxTdCC5dhU5irEJo5UYQ5xnSmaKjA3XyBxi+Ep2brc62CnQI
 9zD+BBfQzU4BftqPR5bAmsaPpS8yWMfEbAWNnAmSg5RJ88hYtqFi/NpFi4/Gc3HlXwz1
 k4BsWgVETqf2VzEPvwPE3BgQLH5+dsd7MmjB2edt4Xp+HAPN1z178OpQ44PPbLgoCzOq
 I0YOScJ8ljpaDgeAuNbWz17HtiuqeU0WsurqN9yQT2sEKcLhcE/2Juhl1RZvicX8sBaw
 gT+w==
X-Gm-Message-State: AFuF++n4ZlXHNnbbduS5vXr42hvBrpvAJX30X0Hb4+WdNcvvGOlv85Ll
 ++Reu2LpFfJ/FXGP5yMo/EqTJ804UD6g1QOMg6Hju8r4SXm1ztb9PA/z07/whBug9hQ=
X-Gm-Gg: AR+sD10W63WKPoP+KWWwmor5P5MfWxkjlMEf7gtCJL2+w7LYK3UMemzcNKT9u0FJ/ZC
 0QrsOatjsugyomkAr5lBEDdHeqL0vFQBTU9snsBzooOcncIFDDMkZrT5vjMdIGrkd/0B/4doN/5
 ME7G72wxY9cEcBa0LRpAffBtV8qehncdFR92hbvWaSf4v9DE5DKbi1gvh4LWLPwJFwgv2r18FbB
 qvoTcEn0v6fF9DWTNxRHzJ+4PgeSI/RJLhlGz6CfS5K/6NOuO7AqqVCnUXyeLN9GZYd4+xE0Zic
 A6Axe7KDs3HTQmrwsXuKrgiI4M6L5uB7s1XlbxhMm/MDQy98Lsw9jrZ3kJomUmeRUM6/QT6v8zO
 EMcfWHKjM6ejV9WsD3XL8bnXY+MNfSNVjChF3aFtI8k08cyumpLmkyxcYY4FINKK5ilFafJyP5n
 Q+H5C0B9tAoeb5hcdDMB51tXeRXFMPEAPGSWbZ61UYb6g57Kg5icnTPrnf5lsRHzfPK4v0tqU4N
 iRnw79Hg2Tpksp0zebnCQ56ai0liKglmmGReESqJ6e87biv2mFQ
X-Received: by 2002:a05:6000:250f:b0:47f:8cd3:4bed with SMTP id
 ffacd0b85a97d-482c104d89amr27851972f8f.5.1787577204609; 
 Mon, 24 Aug 2026 06:13:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:01 +0400
Subject: [PATCH 04/17] pylibfdt: Add Property.as_stringlist()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-4-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=alchark@flipper.net;
 h=from:subject:message-id; bh=arOhPpDooWHVcDgqNvVRUgf5YCAhnAoGmlJ4N7XjJys=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGd6L+Y8fmnuyhXPRF6YbUpoOLbi2wkpk0Ur1u9jV
 7pudPaMecdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTfSCS4X/WcSczu4dxl8V9Zq+IzD3U8iH2c8VelyBli7kMbW9f7m5nZHjXlJ3
 J3OP5tK7g6meNzn2ThX+11MlnnO7f6CyZXXGMjRMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Luca Weiss <luca@z3ntu.xyz>

Add a new method for decoding a string list property, useful for e.g.
the "reg-names" property.

This is a backport of dtc commit 83102717d7c4 ("pylibfdt: add
Property.as_stringlist()"), without the dtc-side test, which has no
counterpart in U-Boot's test suite.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapted to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 5025893b1e95..c8ac578b367b 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -728,6 +728,13 @@ class Property(bytearray):
             raise ValueError('Property contains embedded nul characters')
         return self[:-1].decode('utf-8')
 
+    def as_stringlist(self):
+        """Unicode is supported by decoding from UTF-8"""
+        if self[-1] != 0:
+            raise ValueError('Property lacks nul termination')
+        parts = self[:-1].split(b'\x00')
+        return list(map(lambda x: x.decode('utf-8'), parts))
+
 
 class FdtSw(FdtRo):
     """Software interface to create a device tree from scratch

-- 
2.54.0

