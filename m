Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CCBC5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 12:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67DC660711;
	Mon, 10 Aug 2026 12:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RFaQ1-thoQ3; Mon, 10 Aug 2026 12:48:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40BC1606F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786366120;
	bh=xAqe2LCHZjmhcPPofPoY8Q1DNAZWJVPXAfjBeGpT0iE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VIwnz1ywwDoTHqEKir5XWPAUY1LdzusSWBR3Q6U+BEeiaOC5gTEMxTbx31iDNIPBP
	 VNkpH8KMM0vcihw7oADAbVmXA0Hrwp+RPKGaUiC6PTQCnuZyV7OHWzRJjg5TpbHIGc
	 M3s/ldRM1UdIMwlFcM/ADXhOX1ne1iash6Ikgis3YE8RoVhr7JtXWPrGtox7QycuTQ
	 LreMMj+TbZmBYh3gtgCyG7kQfFHVL11K5H5AVI2bzPM9PJuUfgTtut+LJ4ph4RvVPZ
	 /UobHsITRkPQu5B59UPOZFw76xYHroqu/6kPjuDszVQrLPAWuQWxYp7SZEwhn9Efq9
	 smjEYCq+HCiZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40BC1606F3;
	Mon, 10 Aug 2026 12:48:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28A1510E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E69780DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LBDZsKIuog5 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 12:48:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B4B5580DCA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4B5580DCA
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4B5580DCA
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:48:37 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so11991585e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 05:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786366115; x=1786970915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xAqe2LCHZjmhcPPofPoY8Q1DNAZWJVPXAfjBeGpT0iE=;
 b=TDWDk3CXH12upnYCAjT0yPSSGO3LXvqmohP5H9GAoSyGVf/gRkTa3UVShvGY+/uMvX
 rB87Cj1vmcUmb7CoNrGE82O52oThldVxab3XPwLWH55+0laWYQuYFvGXmG1rRO1gRqZ3
 C/MbA2n7V/iNGxNYi1SzzO48RNsuBCZOUd2y8m1kw2bbIJmQGsQgl3pc/Z1uCjKXLEFS
 37kdhQMoZCkWWNh6P5l6rAy/FqZ8dzIKKRCPH+N/eRv+9NKJLMfRqovCIhV+aWOy07Rm
 au9x05AY95RxoNVDvO+0gKnh4VagiVIYDlguRicK+GGT0DXvvQpEvykOk7u3MzFkiGqv
 vg5w==
X-Gm-Message-State: AOJu0YyqrPb5cTnodsyhsK8NzzhXgB3TidXyrL3P4F5zRY0o3D6Gzt9Y
 xNjtNg6Cu4Tj7CqBV676Np/PqJtIaYAXZHn3Tf0AVLv1n8fAkmgUZjQj3NIek4KPn/c=
X-Gm-Gg: AR+sD11ncv4t/mUZjpk2zI1inVuK2lVZb3AgOMXJKVvlVhkZRsRxFZzVh65uOZ80VcF
 6AJteA4DZn483CD2GCeHu1VlN0FM+9VuN/oJt//qCIw5MocdK+qGfUv5WbLRhyeqlT4W885EEax
 2jbd3SHY9xOZ7knfFeZM/M/WA6Kl5/sIEJ/nYNPsBxaL4eJNnyN+LRHfLxQGn2szJVi86ZGvXiy
 i+49WMC490BqNrb3ZKUSEs2jz5gcFQA5RLkWtCSjALy1lSiu+ijmYZCiXYdUuW8LOMBx56WsXin
 /bCF1QdGbNrBrF2hl+/ZjYz2hcvzsaH5wdz3dwQvEOe7HPtu451y4b6TNYaGHg8KMKPgaxBh+FP
 2OpZ3ekZ8+c1DGOODkdCPx9R9yTR6IPeoR6PM7l7U1ZyHCc6bMvnaJfPzwOQOXNuIvp2xo9vhrX
 mLRtnie/xRRpeoR6kPayWeXH5kQrrVQWXOoiev88uNyD9XfxDlYg1S2HzgVRPRMWwiB3lvXGhaa
 8NS7b/VPtaAx7x7cPfLrVP7uwgIVeh//i+SkMI=
X-Received: by 2002:a05:600c:8b77:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-499726aa06cmr29934345e9.1.1786366115206; 
 Mon, 10 Aug 2026 05:48:35 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29ea13.dip0.t-ipconnect.de.
 [91.41.234.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea27b29sm375669215e9.11.2026.08.10.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:48:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	u-boot-qcom@groups.io
Subject: [RESEND PATCH V2] CI: add Qualcomm requirements.txt for world build
Date: Mon, 10 Aug 2026 14:47:51 +0200
Message-ID: <20260810124802.2037363-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786366115; x=1786970915;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xAqe2LCHZjmhcPPofPoY8Q1DNAZWJVPXAfjBeGpT0iE=;
 b=aSUeD6tPoeTLcG0cSiQZA7zW1urYKFFF6x7a+1BW7pnCWKmrTArhUUoHsCxCwSAT3A
 Bp3NTME9Iovzup+5QpP76KsyA19OT6CFRcabQ7cM5DQwuwJCzIIkRVr4gcDFd9oE+IS5
 XY15uik/Rh/c7DjAH2uoe5Q8F97Qxn6g3Wi5NNClwdHRF4LrZhiKmNBWr+JEPxXAPmOz
 S4KwJVy2DCorO6hZL6c8LYDREKx/xk4M22aRl3+IrPWmcq6e+WgqSa7ElCH0+J9+RJ+O
 V0hE1KlUrjLJmAtVZgDFHOjhp796ExJWgg0kUxbn4BMUWSsvYsZp1T29Rmdr5eLcgc5D
 qODg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=aSUeD6tP
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The mkmbn Python tool used for some Qualcomm platforms needs the
cryptography module, make sure it's installed so the world build can
succeed by adding a new requirements.txt.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
Resend to correct list

Changes since v1:
 - Use a new requirements.txt instead of adding the dependency directly
 - Document requirement in doc/board/qualcomm/signing.rst
 - v1: https://lore.kernel.org/u-boot/20260720131325.37436-1-casey.connolly@linaro.org/
---
 .azure-pipelines.yml            | 1 +
 .gitlab-ci.yml                  | 1 +
 board/qualcomm/requirements.txt | 1 +
 doc/board/qualcomm/signing.rst  | 3 +++
 4 files changed, 6 insertions(+)
 create mode 100644 board/qualcomm/requirements.txt

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 352269b08354..31962db1a40b 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -704,8 +704,9 @@ stages:
           python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
+            -r board/qualcomm/requirements.txt
             setuptools
           if [[ "${BUILDMAN}" != "" ]]; then
               ret=0;
               tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f53c9286c0c5..9831dd61bc18 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -153,8 +153,9 @@ build all platforms in a single job:
     - python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt
+        -r board/qualcomm/requirements.txt
         setuptools
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
diff --git a/board/qualcomm/requirements.txt b/board/qualcomm/requirements.txt
new file mode 100644
index 000000000000..2033083a01a7
--- /dev/null
+++ b/board/qualcomm/requirements.txt
@@ -0,0 +1 @@
+cryptography==50.0.0
diff --git a/doc/board/qualcomm/signing.rst b/doc/board/qualcomm/signing.rst
index 317cd57cefee..ad1d0faa58e9 100644
--- a/doc/board/qualcomm/signing.rst
+++ b/doc/board/qualcomm/signing.rst
@@ -26,4 +26,7 @@ For example:
 
 When you run make to build the ``u-boot.mbn`` target, ``mkmbn`` will inspect the DTB in your
 U-Boot image and try to match the compatible to the table, then it will build an ELF image and
 hash/sign it per the MBN spec.
+
+The mkmbn tool requires the python ``cryptography`` module, this can be installed in a virtualenv
+using pip, or from your distros package repositories.
-- 
2.55.0

