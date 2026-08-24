Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601D8C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22D094070C;
	Mon, 24 Aug 2026 13:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lu3Jy2ybozG9; Mon, 24 Aug 2026 13:13:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577227;
	bh=iMpY7OyqlUcf/ug+mg/MOdurlKXsqSJ2P+79PiP13NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUyXPTHBmyq1rbUD36hsgapE9SDl99lAAspZonke/wcnCzTvdI9721lAxLpypmGoW
	 bVrbgc5FcifiRWNcCVCv/zn7jIUceX4jrSoS0Qm+zafN0D4QUgAQUnlsTBXrBgyUcl
	 hJ51maG/0IUvtbcAOhnyLeqhttvH8CW6Q6sXYnTioRca19fWYnHW9qNS82Pv3TocWj
	 PEY/k49MW0FoV163vT86m3BshkeoFGax7PteD4joQme5Wz48ExqP5Bn5LGkAvM+/Kf
	 1dui+VFRBIE5OVo6PZ7b5f61YLdqd/H6cCnTjALiNPt6o+IbKtX0/Q6m8gbkSy1MLZ
	 svfE6Yh1VcASg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28873405A9;
	Mon, 24 Aug 2026 13:13:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9500396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB2ED80CC5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxT7dd1iRN6b for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=zehtBDCy
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3613380D60
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:43 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47de008b020so1879635f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577222; x=1788182022;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iMpY7OyqlUcf/ug+mg/MOdurlKXsqSJ2P+79PiP13NY=;
 b=zehtBDCyRxhDMbe+e6gXamhyM3iMmrJ26CnyLmb86Lznkz3XSWfm5ssftHXVkU07Jy
 llb7p0tOvobFZErjc4bQAWdTZyQUtTDLBj9uIhq75tVRJE7x/DZR5Bq3z6fY5KesGvKM
 TZ6aTI8S3bM/woP+JzkSTGehKGS5ktZZGwzhZN1Jydd7u3XqQD6Gc3ywfQeR/zCIriLT
 n5Hv82F7hfC6p+9IqnsyFTT21JR/HJdu1hg2lmaRdRIE/8oc3PskjuBHkYyRVS4B1Nmc
 kNlJk6NT1jha90nnwpRoX1y3fR6wfaJYFIrFdgz5oqMbcdUUTjdwPx78Kp5wvNN7VXSc
 rqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577222; x=1788182022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iMpY7OyqlUcf/ug+mg/MOdurlKXsqSJ2P+79PiP13NY=;
 b=mPDwttq6++pdOxU1rbp5dG3Zb2W6XbWtrDEuHf/0bg83qhKugX+760bVDR3EuMQ5a+
 5L6dCSZFAHL/FNbyCPCS4K9c/9BUG9J+lGLG436CExAlij7OgKnH1PFeZTY3Y4Z4aPq3
 wbc5kWpj78ulYtENH742/BOfxhdkqCncDhj/qmVjIW5yatmlHFOmw3K1YAv4gHKBTy6S
 6LQ1EiSlb5OSy+9OkeKA4BnzKIJkFagTc1j9Ph47b/1KYDUvhHI7M/yNrsq4DXBpRAk/
 M7K/e2NdD8ChWkdo9jYzlYrEeL86f0wyZ7Q1OV1BfaKixHm+lD6XusejYKlC/10QunvW
 3MgQ==
X-Gm-Message-State: AFuF++m0scCF/PYkKlejxFNdM2GyOl+TpgFAsDUFjdrAPx1jsG0ETBMD
 dPuzq9xDd2mVf+5N+XiGzaxsRSAPCXhapb4CTrFpq6mdOSvaY3L06xlOuaOlcPvTxqA=
X-Gm-Gg: AR+sD11chzd4GWaVpl9icf3nkVf4ZlxmEpscY0B2qFcoiR9nQ242hEbQA5TvXaB70UZ
 Zt4sPy5F7vcZxpLFirpsgOa+hamVZ9qHGGPrGTPkNfrYGqNMd5Uit8Q7sh09Sv4ERPZAJk5Scbw
 t5B8QVcEWpmgZIfeJ++TptXDMy4LcnRMXYJgImeh1eH9ZLJi0zSe8YscNJF16942g74/a7uK9/2
 xsqkUhNb7lW7eTXhCWkgWdEa8/9ThmtNyii4NMcp056JiBnAeTFhCSLLoKffmKmQX7oynsCF2Zn
 3SeZwr07WnrKluEoHpQpLcv4zXYmI9w/IUcEyU345D9HnoY3n48MpO8hefNwvL6k62wVevHNqy5
 LttesI0TlYE2WeXCxo5bL/NTgBzNMXiOVDmlX7RnxvIggSNmgTL1z727ZA6mY9fPiugOzIfQ5lj
 u8JM23XQ4MaMh5rc3OsRT2Ddzt9O9TlMduhzHeal3A7qxMS1ob4oDQDuRp+mlESKbpphJ3jNp71
 YoE/3Rxc64wm3OLSX8pTcLIyermQ2j0ZjnffIoYag==
X-Received: by 2002:a05:6000:40cc:b0:47f:7fe0:a287 with SMTP id
 ffacd0b85a97d-482c102d884mr27540065f8f.2.1787577221668; 
 Mon, 24 Aug 2026 06:13:41 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:08 +0400
Subject: [PATCH 11/17] pylibfdt: Fix backwards compatibility of return values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-11-a42be6fa4872@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MBGtq2gB3rA5Eff4ZIR0qeJ3vM8Uxq7qEyelXVRpeo4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGd5F+YZXwzlaayxke4K27el5Zghf+zBifOCBT+fL
 D3ZJrGrYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKk+M5eRYXb7O5uWNssXy5vvCNTeXl5xIMpwgi2X/XnV7415N1zivBj++xypDlB
 pTOjhjbhuUOx65e2hrp0dTxdc6pRqDDxTdqmSCQA=
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

From: Brandon Maier <brandon.maier@gmail.com>

When our Python functions wrap `fdt_getprop()` they return a list
containing `[*data, length]`.

In SWIG v4.2 and earlier SWIG would discard `*data` if it is NULL/None.
Causing the return value to just be `length`.

But starting in SWIG v4.3 it no longer discards `*data`. So the return
value is now `[None, length]`.

Handle this compatibility issue in libfdt.i by checking if the return
value looks like the older 4.2 return value, and casting it to the newer
style.

See https://github.com/swig/swig/pull/2907

This is a backport of dtc commit 9a969f3b70b0 ("pylibfdt/libfdt.i: fix
backwards compatibility of return values"). Its prerequisite is already
in tree as commit a63456b9191f ("scripts/dtc/pylibfdt/libfdt.i_shipped:
Use SWIG_AppendOutput").

Signed-off-by: Brandon Maier <brandon.maier@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapt to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 0204708aa6f4..2c8efd57a607 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -118,11 +118,14 @@ def check_err_null(val, quiet=()):
         FdtException if val indicates an error was reported and the error
         is not in @quiet.
     """
-    # Normally a list is returned which contains the data and its length.
-    # If we get just an integer error code, it means the function failed.
+    # Compatibility for SWIG v4.2 and earlier. SWIG 4.2 would drop the first
+    # item from the list if it was None, returning only the second item.
     if not isinstance(val, list):
-        if -val not in quiet:
-            raise FdtException(val)
+        val = [None, val]
+
+    if val[0] is None:
+        if -val[1] not in quiet:
+            raise FdtException(val[1])
     return val
 
 class FdtRo(object):
@@ -399,8 +402,8 @@ class FdtRo(object):
         """
         pdata = check_err_null(
                 fdt_get_property_by_offset(self._fdt, prop_offset), quiet)
-        if isinstance(pdata, (int)):
-            return pdata
+        if pdata[0] is None:
+            return pdata[1]
         return Property(pdata[0], pdata[1])
 
     def getprop(self, nodeoffset, prop_name, quiet=()):
@@ -421,8 +424,8 @@ class FdtRo(object):
         """
         pdata = check_err_null(fdt_getprop(self._fdt, nodeoffset, prop_name),
                                quiet)
-        if isinstance(pdata, (int)):
-            return pdata
+        if pdata[0] is None:
+            return pdata[1]
         return Property(prop_name, bytearray(pdata[0]))
 
     def hasprop(self, nodeoffset, prop_name, quiet=()):
@@ -448,10 +451,10 @@ class FdtRo(object):
         """
         pdata = check_err_null(fdt_getprop(self._fdt, nodeoffset, prop_name),
                                quiet + (NOTFOUND,))
-        if isinstance(pdata, (int)):
-            if pdata == -NOTFOUND:
+        if pdata[0] is None:
+            if pdata[1] == -NOTFOUND:
                 return False
-            return pdata
+            return pdata[1]
         return True
 
     def get_phandle(self, nodeoffset):

-- 
2.54.0

