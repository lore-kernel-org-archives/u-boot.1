Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A4C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 806474055B;
	Mon, 24 Aug 2026 13:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTzpXzbhbgmZ; Mon, 24 Aug 2026 13:13:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577200;
	bh=T7qlY5js0/IVKZvtgTsPRn5PBoTi6nJ/5VKh9k9449Y=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rhGE9HLII+1U/5DSKBDu8sm7LqHNWjPSVMup+siPZZwrbAistx54bLhs53uOMEtDb
	 2UzSJBDivJ/klpCXZU2pmuYb4gyvCtGhMbEKheTLo10/1h66pI/Y9hJp39I3jNpFG4
	 TpYzpHdJCxt4oaKsg22TPr/7TEDoXxDfrRvzmiJJohB6sUAtjqlk0v4Z5gPQCO+Gcg
	 OLRNCPOAOSb+nfa5oQjDvZuYPVM11oAG1PEjUUdf0pRgldRXAYvFuy3iy7ArwI470j
	 htg88YHz0QaxKKpSm1MEKaA3SUKsWwPZqtrSAywDeugQ0hURAvqICBp0t2lcUc9RYw
	 prEmykVyxm9yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FDC440571;
	Mon, 24 Aug 2026 13:13:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51EE941A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3804B605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5E7Kl4LAvkDG for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=tN3b+HFU
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1739E605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:17 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so18471915e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577195; x=1788181995;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T7qlY5js0/IVKZvtgTsPRn5PBoTi6nJ/5VKh9k9449Y=;
 b=tN3b+HFULu7lzTksiGH2Kb2OPE7Jipra1o0QkT6IppN90fr3PAesTDydt7XI9AYpR4
 DgAeFmZDjb/28JpWXRhAQDKO/4eeGmJF+53/EVVue4V4+41CA4R7aYEu1lVi8kuj2Lxr
 N5TflG+lkOUDvcjQWg/57KLR/MwiOdYJvYgixfRiaLMq0ypvd5afHgasJiKFINZb7cKx
 GOUELvIZE2b3oawItWof5mxpw6DvL9R1khR5x33PDljiMzapYWgxF4z9msA6ZztTRaOh
 UAXnxbZvVTSRk4fmXjlIrA4doipfZYNUEQOMCI1HvNoemIr8D4fopU1c03tAJd17YMPt
 5AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577195; x=1788181995;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T7qlY5js0/IVKZvtgTsPRn5PBoTi6nJ/5VKh9k9449Y=;
 b=OHxIOM8sxuR8+48uzWLycxtIm1INqOzWI4UE6IFEfX3ZSaG86PZvM2ekldBPAPORbQ
 vwGUPobfxb3HZ7XMnWDnJfks/Zi5bqSM7eRPgtyo8NmkD2aNiuf/YWoQu/1aSVsSO7Zv
 t/CAcNLg4l208ldjK3gtC47jGeOshvK0Zfx/KkPEKyWG8RaYxgtcE+RLjY1596psP8Qt
 B2ryE4kI3fi2KhZS1+CDH4Jeb7WgD0fGwN/7qn9JzaKxVNqIpv/lWM2SPibXMnx/lcmL
 N0t2c1t86mzAjsgzN+EzSqnfcDnFXtoxPn71VFl6ACPLCE+glHWm9HPnodVHtBk7IsvP
 PmSg==
X-Gm-Message-State: AFuF++mYwIldQ8n2xe+SQDMtAUbAm91D0hVqGC4xa0KuNZTcvhgqMvsQ
 JGJY78KkyDlb2hMZVP3IRNy87WH89Tdwkzze8gj7ZLfQu9rC2XDozeAiiahZDps+/p0=
X-Gm-Gg: AR+sD12wxhLShOcOH89TD45l0uGxjmhuDUEB4V1ke7ohVSfEpYcS7v/E0uowUOAG9Xk
 TOXR80Mg88zse9lz5MNzX9du5UzbaESJggQZEund8qeRvqf/mPFCgpmvlYSvFHPI6WcGebPECom
 TRK9hTIazf5FhO/HdQwpSA0/5wARzwoc2hJcE+mxPji1K93v/5u5yHAsO2uCemMD5VREAipc2YZ
 iOpP2Zuxdye7zzkI/9vfIzfje2HUaWYI6GRUSc/9NsbOaVniKXkRPhbaglfesZbUMK/6zbaBtC8
 vwr8Wr2afWqpH1FDxUqVpacmWGJq/rLvQMQxgGHS3lXPODqyZIYNHvebm8VMRgK/uwFlYm8mrK3
 GS+7dX5a2scIa9/m46WOh9GAyn6O0YumONYyAXgPA/DtWp/oJLL0Bj2S6pN822anWGjNauXoPbx
 D9AHlXZztJxbCzM5tYZgp02oIV0gk4PRZ+PFPOnWmZ9W+ygkuc6VadRdEblpz6+EjuFi/hDhwdh
 9RMwVlbrE+6gXQOTnFeWgvlr/rPVowGFyJbZ25LPQ==
X-Received: by 2002:a05:600c:5486:b0:499:a277:e8c8 with SMTP id
 5b1f17b1804b1-499b8464cb8mr295024745e9.13.1787577195247; 
 Mon, 24 Aug 2026 06:13:15 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 00/17] pylibfdt: Update the U-Boot version with changes
 from upstream dtc
Date: Mon, 24 Aug 2026 17:12:57 +0400
Message-Id: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMT3YLKnMyktJQS3eLKvGTdZMNkQ8M0CyNDU3NLJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAC5ARepxAAAA
X-Change-ID: 20260824-pylibfdt-sync-c1c11f821579
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>, 
 Brandon Maier <brandon.maier@collins.com>, Thomas Huth <thuth@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3633; i=alchark@flipper.net;
 h=from:subject:message-id; bh=3FqbzqRMQAa0bfzTn6ElsLfU9gSIw5vv2nar1WR97gE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OCcKlHpsnbfivtSkzgV3VmiG9Ds/CX7gvU9jRq3Dp
 8/CO+ff6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqtb4y/FP2zVZ+O3ObVZ9t3ZzcOew39pqG+0xdZDCf+cyif/y3njQwMuyd8pI
 rWPKa7+bZ70/O5OhsY3CwCr8eFea8jPd/UJLIb24A
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

U-Boot's copy of the libfdt Python bindings in
scripts/dtc/pylibfdt/libfdt.i_shipped was last synced wholesale in 2019,
by commit 903fe17aa8c8 ("pylibfdt: Sync up with upstream"), against dtc
commit 430419c28100. Since then it has only picked up individual fixes,
so it has drifted a long way behind dtc, which is now at v1.8.1-19.

Tom asked for an audit of the divergence when reviewing the FdtSw growth
patch [1]; this is the result. Bring in every missing change from upstream
as an individual commit, referencing its upstream sibling. 

This adds: hasprop() and setprop_bool(), get_path(),
Property.as_stringlist() and the as_*int*_list() accessors,
address_cells()/size_cells(), add_mem_rsv()/del_mem_rsv(), geometric FdtSw
buffer growth, a missing Py_INCREF on the Py_None returned by the
fdt_getprop() typemap, correct get_mem_rsv() results on current Python,
and the SWIG 4.3+ return-value compatibility shim.

Not included is dtc commit 5008d1d6a356 ("pylibfdt: Replace removed SWIG
Python 2 compatibility macros"), which already landed independently as
commit 527115ef6783 ("pylibfdt: Replace removed SWIG Python 2
compatibility macros").

The first two patches are preparatory: they take the parts of two upstream
commits that earlier partial imports left behind, so the rest apply
verbatim. The last patch adds test coverage, since none of these bindings
have an in-tree caller yet and dtc's own tests for them live in
tests/pylibfdt_tests.py, which U-Boot does not carry.

Residual differences from upstream left untouched:
 - the SPDX comment style;
 - the %begin block defining PY_SSIZE_T_CLEAN, which is U-Boot's variant
   of a fix dtc applies from its build system;
 - the two %include paths, which follow U-Boot's directory layout;
 - the retry loop in FdtSw.as_fdt(), from commit 211cfa503f6c ("libfdt:
   Detected out-of-space with fdt_finish()") - U-Boot only change

CI passes all green [2]

[1] https://lore.kernel.org/u-boot/20260805-pylibfdt-geo-growth-v1-1-dabe082367e5@flipper.net/
[2] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1047

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (6):
      pylibfdt: Cast property length to Py_ssize_t
      pylibfdt: Restore the upstream bytearray() in getprop()
      pylibfdt: Grow the FdtSw buffer geometrically
      pylibfdt: Add address_cells() and size_cells()
      pylibfdt: Add add_mem_rsv() and del_mem_rsv()
      dtoc: Add tests for the pylibfdt bindings dtoc does not use

Brandon Maier (2):
      pylibfdt: Fix get_mem_rsv for newer Python versions
      pylibfdt: Fix backwards compatibility of return values

Luca Weiss (5):
      pylibfdt: Fix Python crash on getprop deallocation
      pylibfdt: Add Property.as_stringlist()
      pylibfdt: Add Property.as_*int*_array()
      pylibfdt: Add FdtRo.get_path()
      pylibfdt: Add size_hint parameter for get_path

Rob Herring (1):
      pylibfdt: Work-around SWIG limitations with flexible arrays

Simon Glass (2):
      pylibfdt: Support boolean properties
      pylibfdt: Document that FdtSw.property() takes bytes

Thomas Huth (1):
      pylibfdt: Fix a typo in the next_node() docstring

 scripts/dtc/pylibfdt/libfdt.i_shipped | 230 ++++++++++++++++++++++++++++++----
 tools/dtoc/test_fdt.py                | 175 +++++++++++++++++++++++++-
 2 files changed, 380 insertions(+), 25 deletions(-)
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
change-id: 20260824-pylibfdt-sync-c1c11f821579

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

