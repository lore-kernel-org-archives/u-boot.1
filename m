Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673FC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2CE84067A;
	Mon, 24 Aug 2026 13:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8tbkLXIYibBs; Mon, 24 Aug 2026 13:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577238;
	bh=/yeIHJmbzmO8hk11cor41Grh8z4/pXMBbwZde+d4Nic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4uqXdzV7fetqydPoEJjCjCHfJUTgh6CWGnTW/ntSTvmNr+ArOe4zZd1Gm65/9Frr
	 WfHkKNWQnwSkPVFKVcpBd9c4jm+IIVMzIHDZM9Nbfuhl1n74gdtBDwIAY8xS1I3M5j
	 FacL+tIx6Ypss5WzIbmiQeGE6nPyA88T0y8eHHsI47IgjvkVf1odhbof7AT5yV/T5w
	 ucSCuHPjz9hC60yxNU/Xq8PPxfPTqvUMoc4AWcT7+EcAVqUnGSYw26RZDSlh0asaGO
	 Z7tRhu1k8amhyV5VUNAH+vGyUk5gm4R9NxWMcLXuxvMdyP1I5ABWsq2IsRm9cdPGrQ
	 emfEM3J88q7wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CFEF406AC;
	Mon, 24 Aug 2026 13:13:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9609141A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C539605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYnVBdmS-VU3 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=b66jt82o
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97BE0605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:55 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso35174515e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577233; x=1788182033;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/yeIHJmbzmO8hk11cor41Grh8z4/pXMBbwZde+d4Nic=;
 b=b66jt82op9EXyRm1ue94zFkJIZXUgll9/6XsR0VQWkl9gEH0G+q3vWg36EapcGBHHY
 vKx4BGkgbWqLm9A9T0eyUfq4ay4CavdogMJah1avZQlnmXF5w6EiW5mkAmGnmA0/kSdQ
 RwEkwWUJBahTTVvuwsXPLwhz3F+Nudy4+ZOjMSgodoswOs0xC31pjAQXZ2QNF4xlLJ7q
 tFKATKltDZ4O9DKD2DughSuC+9/Sw9w8cwLvnu8DDpU43i2Rein/T7WVzVvBM5XCw1h8
 3G6uGUShPa8/UVkp7l08dyvn+fcARyCR6FyKtxbzJoBxgLIQnG6/lZVIqsVu/O+w/Vxg
 OaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577233; x=1788182033;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/yeIHJmbzmO8hk11cor41Grh8z4/pXMBbwZde+d4Nic=;
 b=S9RBerD2izgim8k+n7+/1Lk+cwpZWXySMawWNRKtdlHqO1HpryGI1sisYayrIpdRn8
 H4QQ9iHeOIIrD6D3dp1aHy3grO1hfSoVLM/SmdfNt1s6ixD18eGujcwj85ugnM9wFyFQ
 Y6HH+IAHyz1ADvyJJ7JuRINbB1knigIIX4lAKOYJhFH9qMF5WUSvobKQ0mLkQz+hwfAO
 VVpJprwD1arJzhj/tQgMJjIB+mymu3BTVNCCLSf0hnFVFwlPm4qp6qbRb4Clw3MVywcu
 Btlx1jrLDBka/AtNAhKTKTyct1J4eoFuDJKSfE5H9GoC86ucqv0oMPyFWqVO5kakISgy
 5YdA==
X-Gm-Message-State: AFuF++ltW7yfOwRfkTPyUBw23HefLjKy4RrMFFYhqqKHGgxBpFA3gH4a
 j3q5Smykeijm1rD+cVqGrka70iSsqvG8XioDwLalOkBUwdXgvCHSSRzntwrBp7uSphw=
X-Gm-Gg: AR+sD12HFW49WfWnAEx+oNIk83ClS6lNtOgXKjnlnO48QmDTx/ogP/AZn1AuQyoT2bR
 jAHv3+rBqAF6zdhg5d77t4jnBcWUrf46LpaEz0hnSMK5ocLHoeecJVGUq3X/RledfNL8lnxMXmC
 9QbTlwQFP295xrFeiz+jpGiHJhQVbQxxNl/eGf12BXV/gv6JyIYc5FBNKYP1kPUsjzCPdr33Ow5
 zNKc1NXAyxgywGtifej6y0qXeDPbI1f+lxRkbVbYl5arp+SiCxSUyVdSJFfIdjZj2utGDgLYUoO
 O4sIfBJ7kdRGeS1pU3hGjIC5Rt0Sju3XDaw9zsxvUEA/xBViqN4V2Udj+2nZ+b7iTVP91l0hIpL
 7yGdx+j49U7nSlnonUzd556tfiq5l4WQV3wq+IrWf6GyyDMGMlSkLV+0c+d8V7F4+q2zXd/2+1r
 dHTCqiu+OmHWLgbIVX6AXd4JvRy96da0N250Nj8W/fMMMyxi6qIJp/10fbwDfTIudkEd0SEXHUS
 GsCIGgIfFE9yIpWO2Yx1sH4uOuknXp3HFMx9aIkDg==
X-Received: by 2002:a05:600c:1389:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-499c19a90femr191875245e9.7.1787577233364; 
 Mon, 24 Aug 2026 06:13:53 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:13 +0400
Subject: [PATCH 16/17] pylibfdt: Document that FdtSw.property() takes bytes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-16-a42be6fa4872@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=alchark@flipper.net;
 h=from:subject:message-id; bh=C4Qg9Yjs4C989+h231EgSZi7u2CDPpeAfoZIBi8OyUM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGffckz097Nj2nWwY9+ZhL6dr3XzRQWN5eZOTnn2i
 cP5jURwx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFO95QXDP8OXXhllLz78vtI49WGLzOMjMQq+qm5n3201P7as87pYxm1Ghm0slc8
 eJ0zYOyHi9vmA9TrH/d9YhKRebLbzFxRV2bryPzsA
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

From: Simon Glass <sjg@chromium.org>

Commit 97de532e59be ("pylibfdt: Correct the type for fdt_property_stub()")
took two of the three hunks of the upstream change and left the docstring
saying only "Value of property", which is what prompted the type fix in
the first place.

Take the remaining hunk of dtc commit fdf3f6d897ab ("pylibfdt: Correct
the type for fdt_property_stub()").

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[rewrite commit message for U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 127ec22de3fe..3d527dfe2120 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1112,7 +1112,7 @@ class FdtSw(FdtRo):
 
         Args:
             name: Name of property to add
-            val: Value of property
+            val: Value of property (bytes)
             quiet: Errors to ignore (empty to raise on all errors)
 
         Raises:

-- 
2.54.0

