Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFC2C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCBF740702;
	Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hVpP8qfZfyzF; Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577234;
	bh=5ahCKEWM4He6M2/MvW12bPz6Vz2fl/hLC2r9JG1MZDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PoseXsfueOihJ6kTDvPpVn4w2Wb58yf90fCXNFhocQIx5NQ5i7qHtPPlAxX9jj8LI
	 ORI3sbqW6WlZBUvzii5zeZ7DV96NCbVEYSpJCjGQX774aRGba0BNOUMpM3X+LlZmBv
	 /HHBq0VFDH3JVSziFLvnKfZBHnUxdEBLoKMKMev38e+HX6jpDunchzwEtvDHYkk5iR
	 qcDOzPej/4fqqzOjvTkpnckCFuQ60Muj9ZY7hQ/pYAYe4Iq5J7PLDxoa30c+YUQ1qA
	 LvUqWOHSbbvMAEtoCjr9CQf9saIwFfL5jNr6mtobKyL7d0WKqpt5etdLODW3QNHXRZ
	 QPSqJXVrLDKxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11519406E5;
	Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAA1B41A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CADD60600
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrX8dJVBmhe2 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=M1jpHrSj
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89A80605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-481412f1828so901509f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577229; x=1788182029;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ahCKEWM4He6M2/MvW12bPz6Vz2fl/hLC2r9JG1MZDg=;
 b=M1jpHrSju5waau1nNT6B/OuzNh+izZSfQ5jlUdeHulx2rUtWOjTiEiAogziqEMqJM0
 RZN3Z9xkQJVy0UmO2kdB5dzX1N92T4XtT/KpLa4ug+8l5XsivPf38uMQX8NRhBGGebq/
 70MR+nBH40xtP0tpz1DDRnQ5PK96xEYCZMAPGGEWUkvUZ2Fyuhk6laep5WcyEqI3oBlc
 LIo5lveSYcpz206WCYP+Q9E7VCib5MPdVvXfOn0TYytkiv8oUxQKLM+ezA0cWBk8n1A7
 vhvUAIjNOPAh64OPTfa9bknvZRwglG4mDfriGraTmTKow/9OvHwdDk6s9YyzTfu6s/z7
 I3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577229; x=1788182029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ahCKEWM4He6M2/MvW12bPz6Vz2fl/hLC2r9JG1MZDg=;
 b=ZhvqWOzLydPk/lgeVT162ZpR1oHaHFIVFIIpgBZVpBt6pi36Ugb0Vokm+uxuxS3y8J
 ukeW9a3f+t3khg9sRIr7JjlC90ZM2Ecbu2qk+sM/b1Jisz4vCy5glQbC7+0BoiL7c6HM
 Cwaz4dmyUv26l60rYxEIT1yiT0Xh6pSseLWNLnHJz/kiTy/ARPDOpgcx4PBmflaKUGMS
 9D6h31Ita9iRF0cIaM7P2cVR7Hp+TYanXf1BV+oameK/+I35EajezBx7PVSUBwV9zlc0
 oKkfjWc3SS+0rtEspmyv7D2Wsw0IvtO5RGtqZjrbjY6d8O+7fX4CUpNeKWmm7YBKbBui
 Mbiw==
X-Gm-Message-State: AFuF++nzJj7aGkLyFbmR/s91csxk5GgU1DhMTL4Dwvg6m7a2BPeBAk0Z
 XOdW4zLr9n7f2wckCSeYQ4yDsdoHo3gLF5i8k5wQ1BGPABeLrh4jGjh5b8Kq4BTQdf8=
X-Gm-Gg: AR+sD107vZW9IJ2q3gVfUQEop/e+E26oaR5jMc/g8sMmkIm0+n5qDNiNwIhV3Ckrpf+
 wGGQFLdFqsNmZwbDaDGWsgSNrb2C1GSzoPKgspsn0q7SYHaJuc/1T5ur6t4c0VQsE7pqxME1hMH
 o00YnJ35KBEOSJduT7tfYgvL2WheeTZZTnw7M+iRCdjX1EgiqeLVosh5jCo5PIFTTH5uitcrMxH
 fs1BIzVnTpQnBTdtOGV2lYs4BvI1dJmRZeoyR5blIP/bplA7I72cFh7EjlsRprxhp42HVUttZEK
 WP+c2xbtKlv644BbnnvI8mrYjKPOj58VBzGiVPt3HpgiFaVRctb3niFh1dIBxASq1O0DSVciSS+
 6vrJmjUxZjAFLwT/V1DPSNRZR9N5BS61wudJTVr3T5H1/FKXkmQ0FEvjUKlyhFIujN8ZK/oam+/
 ODw5hW34gQ5u2hlT21il2AiEQiipyttGCRUzM+5Xgm9/oSQFLKymeOcOo72gG6+T4dLTVaTaJPB
 Ah4KO6GM9+rIT/Rml3HZTWU8RqCJmgsL0RiBU1//w==
X-Received: by 2002:a05:6000:2307:b0:47f:80d1:be0a with SMTP id
 ffacd0b85a97d-482c81bd3e5mr19937045f8f.14.1787577228565; 
 Mon, 24 Aug 2026 06:13:48 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:48 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:11 +0400
Subject: [PATCH 14/17] pylibfdt: Add address_cells() and size_cells()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-14-a42be6fa4872@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=alchark@flipper.net;
 h=from:subject:message-id; bh=trK7R2T6OYjeXmMYn7AyAboMw/HuQ+AGG7Mbk83TIW8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGcL9iQfn/nK91ZI9WrNWIb5EZlTHvXc0p90qaLR6
 Tu7luvbjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZ6sScjw2WHKeke2ya1m39V2ea+1euXwI5Qs69HjrMozrp28OTTeH6Gf/Yz+/Z
 IL+UPE1+gUqD24J5Wm+j20026nFeUZaI6gzbO5AUA
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

Finding out how many cells a node's children use for addresses and sizes
currently requires calling the raw fdt_address_cells()/fdt_size_cells()
wrappers with the private FdtRo._fdt buffer, as the class exposes no
methods for them.

Add them to FdtRo alongside the other node accessors.

This is a backport of dtc commit 3750493c8b0f ("pylibfdt: Add
address_cells() and size_cells()").

Link: https://github.com/dgibson/dtc/pull/190
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index c00e74a46b76..1983ebaee335 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -306,6 +306,38 @@ class FdtRo(object):
         check_err(val[0], quiet)
         return val[1:]
 
+    def address_cells(self, nodeoffset, quiet=()):
+        """Return the number of address cells used by a node's children
+
+        Args:
+            nodeoffset: Offset of the node to check
+            quiet: Errors to ignore (empty to raise on all errors)
+
+        Returns:
+            Number of address cells used by the children of @nodeoffset
+
+        Raises:
+            FdtException if the node has an invalid #address-cells property,
+            or another error occurs
+        """
+        return check_err(fdt_address_cells(self._fdt, nodeoffset), quiet)
+
+    def size_cells(self, nodeoffset, quiet=()):
+        """Return the number of size cells used by a node's children
+
+        Args:
+            nodeoffset: Offset of the node to check
+            quiet: Errors to ignore (empty to raise on all errors)
+
+        Returns:
+            Number of size cells used by the children of @nodeoffset
+
+        Raises:
+            FdtException if the node has an invalid #size-cells property, or
+            another error occurs
+        """
+        return check_err(fdt_size_cells(self._fdt, nodeoffset), quiet)
+
     def subnode_offset(self, parentoffset, name, quiet=()):
         """Get the offset of a named subnode
 

-- 
2.54.0

