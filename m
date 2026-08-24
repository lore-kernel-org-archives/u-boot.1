Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6645BC5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FC0A80BFB;
	Mon, 24 Aug 2026 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpRrUvHEO8Og; Mon, 24 Aug 2026 13:13:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577224;
	bh=ytL5MICLl1EGz2fojb/AAMTglVhBAE4KlmIFYdSovA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HB4blCtOUs7/mln/vuOEhURPQT1dUC+FomEsCNH0t3ZgQwILxiiFZJa5SjU1Xsclk
	 zektyqntKeuNrhr4FugN1qxhJc3YG7s7IrhETVfTf/wZ6Yk3mkBtG94FEwrwJpFTuM
	 ZHDlgOyRlquKpyIBiN+bWG1qPI6TdFu4t0pMp6++UmjnHKt+UDJKXPk5BM6AZ3XFyF
	 6bEhxs57Jb6eS65wCec9rHpGMCURiFGw7jT0KBGJxRJuAtGLsDP8SC6lxkQPbJRvaj
	 SpC4/49btyUuobHDuMOejeoylqoi1CzzOELO6azp4UXsyuNd62Q2LksN90ug9O3VFs
	 wfXcmz6buMaDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 168BD80CDB;
	Mon, 24 Aug 2026 13:13:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7DE2396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA201605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g26Hy54UKlvH for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=D8Ypgedc
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85545605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:40 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso35170995e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577219; x=1788182019;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ytL5MICLl1EGz2fojb/AAMTglVhBAE4KlmIFYdSovA8=;
 b=D8YpgedcWcu6RrCopBkaZiCuximZLnk6Zm5i6+T+QtMRpVlAX9XL3mD3PpOf7e/rzi
 TfZqMffQrtQjNGWvEcEDdRWnOhO41fMRPVIRir9N9EZDGLHUulGIc8PIQ24ar9cl++Ce
 T1knywGPtfeyVNeIOq39c3pMh+88LaLgjd3bQ0sxtHF0oNTKCUPnisFScaileg7H+Jao
 pBfkcJUY+jb3GeAUj53meIj0ejX7i3NCWIWij5m6P82Z+fJTrlPHg5UXj7NxVy0Tg2nm
 xs6qAX0YQaf689RSd/JL3E5mubVmKOCu6VdpEa4Y/8LP3Z/DWmnZDp1Z8AIosVRKbK/m
 kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577219; x=1788182019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ytL5MICLl1EGz2fojb/AAMTglVhBAE4KlmIFYdSovA8=;
 b=W/V03IqEM0Bc69UrsGOYvERnRwAIuc+FD188nDxzw9rvSdU2LZqz1L2GsNs4pDM2KG
 GRDDbHEmHobXLMskvPKAzitMC4Lvv5iK8ycP2X8XgcefYdgF3FUG3g6c5pOTulVaQTly
 nB1DKg5W1Gi1R0DaPHX7sxAeT/maojQOlzmwmtdCo5q6uFABlBzoZK0NFMKCgFf/bsEA
 hoY4pagM4t/FTVeyH89RAP2/U5FfVvJI1QuV743L1pL8EXh9gCcgItAuG65rXzOVi6bN
 BvsDKcZHfeNJaz8gP9B+8UQL8jW1XBd2+Chz0OZ1KAQL/l3Gyac6JpibVtNufkxoaIrD
 TZHg==
X-Gm-Message-State: AFuF++lEmgCGdTW2W2U1tI3cXgBR/KTt9W2blnaxRocAe6Z84D84vvgB
 yEBX8mMG6EwUYxuJQyAG91ku297bxgMYMY34Wa0JjM73Tvl86m/TbV5ESQNNJ/Mdwno=
X-Gm-Gg: AR+sD11lUtQROqIZG3CHdZ6600E7+7VU9QD884oeToJzexAC+Tal36HX4eWVY8LoRun
 Tu3xIKG3D9nT3oL0QwSA08dG9PrKRNxfoEKYPHGLSjkHovrnpY1Kkqqbzi4jMDlt76Aqu1yDZaV
 un0Rteoc2k5Ti/DfOGx7dgh+qHF34ovA4uO86rwJ3A+ne+fHMpxXDnD6LCuDCYi6eynJ6MU463X
 qShcicZgOTYTt47Vg9QqB18F/MmczFcckI2HU9zUfJtRmq7jsDvY6QkntbmMGquSYr0S4+c5xca
 24m1CUNoKD8hKEqRLPehYol8nD+di/moIzSzML/zrV8go/jLQsuw9PRKXwgITgUUwDpvM0GmMUC
 JIGP1xCggFqLjtQpqTNXKUPAziyOs51H2Y0RGMLtexH6A8s2WF4/meJHG1hB2UPH3dLQ8iMbDxn
 mlxMb/UweWiRx5JFMhVC9hmIVpry6Ka9JbsOguTZxChVWR8K1nXMyDFztD3ZcHet8TJQWWCeCHH
 +lSSkXX8850OvKPTofG0ViNq1Io+gIzAlYTBkgI4A==
X-Received: by 2002:a05:600c:3ba8:b0:499:b682:12bb with SMTP id
 5b1f17b1804b1-499c1997e55mr255671815e9.1.1787577219079; 
 Mon, 24 Aug 2026 06:13:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:07 +0400
Subject: [PATCH 10/17] pylibfdt: Fix get_mem_rsv for newer Python versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-10-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>, 
 Brandon Maier <brandon.maier@collins.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=alchark@flipper.net;
 h=from:subject:message-id; bh=NqmB6RK7rVimEN2gbiJB5afUoenqo/3KiGdFtw7Ru3M=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGfdND7s+u1EqrTuiR08l9wtc440GC1cpLXCRbCZV
 fDqa6mnHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx14n6Gv9Kv9PKrlR3l2zm+HHePsSo0mTNzxvaIyA+NoZ2MPqanXzD8FTZ+GP5
 o/p9r9bO8jk2u6r3lzMliK7PlyMQvWc+TLWx/MgAA
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

From: Brandon Maier <brandon.maier@collins.com>

The test for get_mem_rsv fails on newer versions of Python with the
following error.

> AssertionError: Lists differ:
> [16045690981097406464, 1048576] != [0, 16045690981097406464, 1048576]

It appears this is because the PyTuple_GET_SIZE() function that was used
to build the fdt_get_mem_rsv() return value has changed. It now is
returning a non-zero value when it's passed an integer, which causes the
SWIG wrapper to append the returned arguments to the return error rather
then ignore them.

This is valid behaviour per Python's documentation, which says it will
"Return the size of the tuple p, which must be non-NULL and point to a
tuple; no error checking is performed"[1]. As passing an integer is not
a tuple, its return value is undefined.

Fix this issue on older and newer versions by avoiding
PyTuple_GET_SIZE() entirely. Always append the arguments to the list,
and instead use the wrapper python function to check the first argument
and then splice the last two arguments as the return value.

[1] https://docs.python.org/3/c-api/tuple.html#c.PyTuple_GET_SIZE

This is a backport of dtc commit 822123856980 ("pylibfdt: fix get_mem_rsv
for newer Python versions"), keeping the SWIG_AppendOutput() spelling
introduced by commit a63456b9191f ("scripts/dtc/pylibfdt/libfdt.i_shipped:
Use SWIG_AppendOutput").

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapt to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index dd568fc74935..0204708aa6f4 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -299,7 +299,9 @@ class FdtRo(object):
         Returns:
             Number of memory reserve-map records
         """
-        return check_err(fdt_get_mem_rsv(self._fdt, index), quiet)
+        val = fdt_get_mem_rsv(self._fdt, index)
+        check_err(val[0], quiet)
+        return val[1:]
 
     def subnode_offset(self, parentoffset, name, quiet=()):
         """Get the offset of a named subnode
@@ -1193,12 +1195,7 @@ typedef uint32_t fdt32_t;
 
 %typemap(argout) uint64_t * {
         PyObject *val = PyLong_FromUnsignedLongLong(*arg$argnum);
-        if (!result) {
-           if (PyTuple_GET_SIZE(resultobj) == 0)
-              resultobj = val;
-           else
-              resultobj = SWIG_AppendOutput(resultobj, val);
-        }
+        resultobj = SWIG_AppendOutput(resultobj, val);
 }
 
 %include "cstring.i"

-- 
2.54.0

