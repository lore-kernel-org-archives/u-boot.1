Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412C6CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 15:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E2880FB7;
	Sun, 18 Oct 2026 15:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kSuSokVE6re; Sun, 18 Oct 2026 15:59:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93DEF80C43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792339156;
	b=BHClHK8Pxg2OVS1dZGFQor0gReOSVyH6zMe2l3+7YCXGdg1Rgh/CQ1MoX52sAOvCa61R
	 +o002B3B7iOdZnNAAkXn/6op0fKmVBSg9aUspjENfOJqX3fIZtcPwcKOYiusNoQG34b3k
	 wsqdQ5QQ9xyF/tqwEHvvNCOWh++t8V1aMoSUAt/JebBlWx4VxuHCk75gdOi2Pem5ELXaw
	 aW0pHB7qGv4th0yw83zFjx/78wV7c/usVRGPq7nEoFDjnKjNMTQV6kkwHHS/cBFVA9b2i
	 XKuvbQegjSGEmgx2UqU2srCpaXZtpf8af/EQp/hSE0wNG34DIbdY5EEE+WGFjboJXng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792339156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qwwD/FGDyePhoHhQ6n3UJIPf3QQwBiaSPIuEb2zl4uQ=;
	b=nqGuRF3PB38KDUYnLneiclaqQUPG6FQBTbatpxrj3gke/cs1qEYKAqlVGTbzjGMar6iu
	 G4/cwA32lTfoO9mha8PGEGdvnPbChWWwnrpuj/stxdpkCuGaDsej69n7+zCo+hKkF4Ii3
	 Gr0K/4Sps9H8+Ia2MjYhGsANaXlhV4PI8gw2/Dmb44ZbvgJnfaIlJeKhYWODO43pGjvRr
	 jRmu2rgDjL678GZ1QvJRzRJuAltzlf5L1fv4WPw1fV0tVKrvrkxTc2lRp7rrg3x+yTyLY
	 c7rL0YGy+JI43sM/mNhcvBb2QRQJ9YI0YCeUPouBmBCqH05LxzJfDug04Y2qUsPGqqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrsHcf68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792339156;
	bh=qwwD/FGDyePhoHhQ6n3UJIPf3QQwBiaSPIuEb2zl4uQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y7s7r/ZFF7F6Vb4nzXev5cdjmM5uMAs4jP7t9qW4M7e4vWun1mcpo2bZFF98muHAD
	 BhZ+1IGeIZ++JlZPwhvEoZzgWRZZLueVhL1uDtzmJqQrZHkp1b58FyD50gMpUSpASv
	 3WgE9BGTpDNLpoI1LYlCXnVjqD3a8THaoOCkeJD9Eyz81x4E3Jvjbb2PMhW8wWxNfw
	 r/ghL4Tp/rvqi0QB802YUHYJgcBwGeSWvbe09J+t3lBrXDyTvscVmElLQ940jL84jw
	 sAcCrs0fN5g2OwfGd0psTH4XTC1QYF8M8yHxH53QLnBKyXvfA+9m/Bin1+mvSOiWOD
	 x6VoRdLygwwdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93DEF80C43;
	Sun, 18 Oct 2026 15:59:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABD70255
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DD4E80C43
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 714d51A8_xpd for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 15:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3698F80C16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792339152;
 b=LrMPKPP22Bm49Bc5A/sbJlXB1mZxrdp6v56bRQ+7bCxCIVXCvW8iZ83MrobcccfF4Lm/
 PAXhdrXKcSAoh0ew6sGihRlLLry4/Ta8vKutoGD+VBQ4rzuQC86f3gIQvttrLmblc/sdY
 UJLMJk8BQsP1diFuhCkOpz2ctlrvjRMWZUHeRWgNbMnq5g/wbAA8ASIKYYcMqT4d3DeyP
 awcvDO/RlE6903aiOLcxWU3fman3LAuEiKJxWnOd1BYIbcAXcJck/wgqpkCpuiNdGpO4M
 kpgpZpndqT3r+kAPlkrMI3ksBvA0xNMnKF521yDJ10JZISXWN3Qqofva3GejZsziXeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792339152;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=qwwD/FGDyePhoHhQ6n3UJIPf3QQwBiaSPIuEb2zl4uQ=;
 b=sbg9sx1LR8NBVvQ1LxUXxqCDs6kh5GMRcTa8xmYVND/2o0NPEggbCLH9gjIlJLhd6AEW
 7g1bey7N120ZgEoIUAH+ZrgXvP4YUV7faNko+nfkwHmesxOEOMTQB73TJyuuwXwd353yM
 DPEp5FIXUV68cA9SLF9EIHD5CLsG3SZJQYNzAkvLmDsAaZcuJJWrNhDv+qnQOmU2dCzNL
 e8zDsPXpOX8YHDxfM7H+BXFuqa8ZFTwwgj875ryqMJfiUSdJidyYRKoeJu1Lv3sqsGKYM
 nTscObJy2FdSe2UIMgQ2M/fDXjrvEgppgAsV1dOuoLW8xt3sZIuCrXqNX5mmekoYYeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NrsHcf68; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NrsHcf68
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3698F80C16
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:11 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so741241f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792339149; x=1792943949;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qwwD/FGDyePhoHhQ6n3UJIPf3QQwBiaSPIuEb2zl4uQ=;
 b=NrsHcf68wN8SXmz6+oi+dIGiy5UUSTUA0TqmfhooV+A/N8HWpfUwbEmd0jlquRQUBZ
 HUcGoBN7UFjSDBuN4IAglBID3ItxvWqTZgf+uJzLtsAMg2tKKddGITHghtyfpDQPQtgM
 58AL/TgXaxEpqtYduNlxX5zPrvXVzutW7+QUL/Ze24cCryGRKnLpNGSWjTegmMsFnguE
 l1RZmgv2rOXWMynBOQpJvW0NdavP+c2syQnLBDRObuyHusLsLUGGO2qJcpm7TQNZZOhm
 UVSlypRQBirHYOFBIclApwQME8tOyUKtkyAQsd0F7q3Mk4vybgGkFYNOMR1VzUCawdwQ
 ACsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339149; x=1792943949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qwwD/FGDyePhoHhQ6n3UJIPf3QQwBiaSPIuEb2zl4uQ=;
 b=mSnYAJqYnTb/xHiFWxm0LZTvlZyN2fhbog+XgBMq4c5oBKJ9VO3h12eqmhR+1H/sNa
 Dm3eMhIfqCcdRAYhbr8SWJNY1jVNp3DkUwSen080T+EcgnxyhKUUlTp6x9oQcSKg3AUU
 hqfU9FDe0xdZj/Zhx4DSQNvBjaFpaoqv2r/AwL3abCSKf68cS/1OuGknN5fUjbwzqUrK
 9b7YYgeljEywn50gJvbto6oI1eRnByOrbEevBWviPAMbF/KMo5APjj0pHFM9evf84Ljy
 7ak92tf8RUVgRnicTqQamYl99aPxABT9Aw+jR+e36GEzhN6oyW7UFJBlEAsU+xJneUdr
 DvOQ==
X-Gm-Message-State: AFq9FYKzirPF8ImAfue3z0z2GHAG+e32g9a26NXJxUBN1/7D3hz//TbW
 e5DowfSPFDAp3bWWC0ggSi/Ay1x6l4l1KuKV41IQE0o8gPqEPCmE+DHO
X-Gm-Gg: AYBFou1SRu8Uhdo+QZ88z3WqNLbpUGdv8hczEkbY93+eiPZxG+MLO1cfbPlXU6FpD4W
 mk1TQMYlDVQzhaU2SF2YcJxJfah6Oa5kz4TWi3JW2GsbOnL2LBJhXyBynshxD5RZMCy+mNC9Omn
 8168yMfiWEDQhzsUaKK/ltmhl8ITDivmwg4ShzHaOaBnNFtL8QeVEMtM9oTrKF3iarBZg3Y5wWA
 4nADyzCApsytQlGMbWKnX18MP+8tGJmEHA0xrjXtvqMzaPT23JaZdtzsUOQvwDJ2CDVehSHrtLN
 SQFsmtqF70dxko7xHX7geQhVOhiS51Erf9llpVTBxiFJuKZEIz+nd0OHhYfJt2xEU6lYprPfkbR
 1gkWJY94M9uevyV5roZYVL0c23cMYXw8FWdrgo2GjuS2puWhBxlEUAlkG4n7cH15FkBiDKAvu1R
 G1rlprLYJCoZCYVpLNGMwjwiUzXYUKZI+eT0bEFnLEnOacjBA9A9iqDZMWxRBT/WwuNNuELwdGL
 2D4tmCU
X-Received: by 2002:a5d:5d0b:0:b0:48d:f876:f370 with SMTP id
 ffacd0b85a97d-48e0d78a05cmr7494523f8f.48.1792339149316; 
 Sun, 18 Oct 2026 08:59:09 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.143.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm17053434f8f.50.2026.10.18.08.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:59:09 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 18 Oct 2026 17:59:04 +0200
Subject: [PATCH 1/2] doc: Replace master with main as primary branch name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-master-main-v1-1-e07455d232bd@gmail.com>
References: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
In-Reply-To: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

The primary branch name is main, not master anymore. Update references
still naming it master in the documentation, replacing master with main.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/CONTRIBUTE.rst              |  6 +++---
 doc/develop/sending_patches.rst | 12 ++++++------
 tools/buildman/buildman.rst     |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index e0394515702..b012648e3f2 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -73,11 +73,11 @@ considered as reasonable amount of time.
 Development Branches
 --------------------
 
-The U-Boot developers use two main branches for developing the code. The master
+The U-Boot developers use two primary branches for developing the code. The main
 branch is used for the current development cycle, while there is also a next
 branch intended to land changes for the next release early to enable wider
-testing of larger code changes. The next branch is merged to master shortly
-after the tagging of a new major release.
+testing of larger code changes. The next branch is merged to main shortly after
+the tagging of a new major release.
 
 Similar to Linux there is a three week merge window post release after which a
 release candidate is tagged. There's typically a new release candidate every
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index b4f82eb18e1..8b8a70da4bb 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -36,7 +36,7 @@ configuration file and ``scripts/get_maintainer.pl``.
 .. code-block:: bash
 
    b4 prep -n mmc-fixes
-   git rebase -i origin/master
+   git rebase -i origin/main
    b4 prep --edit-cover
    b4 prep --auto-to-cc
 
@@ -65,7 +65,7 @@ fold them into your commits before resending the updated series.
 .. code-block:: bash
 
    b4 trailers -u
-   git rebase -i origin/master
+   git rebase -i origin/main
    b4 send
 
 Using patman
@@ -132,11 +132,11 @@ General Patch Submission Rules
 * Send your patches as plain text messages: no HTML, no MIME, no links, no
   compression, no attachments. Just plain text. The best way to generate
   patches is by using the ``git format-patch`` command. For a patch that is
-  fixing a bug or regression of some sort, please use the ``master`` branch of
+  fixing a bug or regression of some sort, please use the ``main`` branch of
   the mainline U-Boot git repository located at
   https://git.u-boot-project.org/u-boot/u-boot.git as reference. For new features, if
   the ``next`` branch has been opened (which happens with the release of
-  ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
+  ``-rc2``) that branch should be used, otherwise ``main`` is acceptable.
 
 * Make sure that your mailer does not mangle the patch by automatic changes
   like wrapping of longer lines etc.
@@ -452,8 +452,8 @@ today. Not all states are used by all custodians.
   it will be accepted for mainline.
 
 * Awaiting Upstream: A custodian may have applied this to the ``next`` branch
-  and has not merged yet to master, or has queued the patch up to be submitted
-  to be merged, but has not yet.
+  and has not merged yet to ``main`` one, or has queued the patch up to be
+  submitted to be merged, but has not yet.
 
 * Superseded: Patches are marked as 'superseded' when the poster submits a
   new version of these patches.
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index a2061715788..151123ccdca 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -180,7 +180,7 @@ Setting up
 
       cd /path/to/u-boot
       git clone git://git.denx.de/u-boot.git .
-      git checkout -b my-branch origin/master
+      git checkout -b my-branch origin/main
       # Add some commits to the branch, reading for testing
 
 #. Create ~/.buildman to tell Buildman where to find tool chains (see
@@ -505,7 +505,7 @@ branch with a valid upstream):
    ./tools/buildman/buildman -b <branch> -n
 
 If it can't detect the upstream branch, try checking out the branch, and
-doing something like ``git branch --set-upstream-to upstream/master``
+doing something like ``git branch --set-upstream-to upstream/main``
 or something similar. Buildman will try to guess a suitable upstream branch
 if it can't find one (you will see a message like "Guessing upstream as ...").
 You can also use the -c option to manually specify the number of commits to
@@ -1008,9 +1008,9 @@ Building Ranges
 You can build a range of commits by specifying a range instead of a branch
 when using the -b flag. For example::
 
-    buildman -b upstream/master..us-buildman
+    buildman -b upstream/main..us-buildman
 
-will build commits in us-buildman that are not in upstream/master.
+will build commits in us-buildman that are not in upstream/main.
 
 
 Building Faster

-- 
2.34.1

