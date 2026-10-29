Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KgBNmD3E;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxuXwlxb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27FCA40A6B;
	Thu, 29 Oct 2026 22:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrBFxVdBDDOf; Thu, 29 Oct 2026 22:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2CEC40A7D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312167;
	b=BR5DpENvNoYpej2wQnP1vUSgqpPILWLMhBaV9TEOhNHWzT98PABZGx5afUP6KhzscZSk
	 2TvO0nDYiGfzSok7Tnv4mA6tQ3FvkLeksTGVPE+3Hep8x91uascSehB2zqqcSiGqIOLR8
	 n7SGedgxPVVTSxuLDCWE3ZkL2Nseb7YnCqDghld7oMWKYaClITarjkqrkeFhK2BKuWww8
	 f/BKtiu7w3/Bd2OLgChPF3bpLbsy2Yz7LWIPzlwoMy0Z5Ts6baxHI3wp2n9xuwDF32x/T
	 lFqskyNMYNVikoNpNGHwZ2G0O8Z5YycXMN6AHUIddo3e8yG2RQErWDSfreDGLgWFOPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B/14Cp2JMdikrPy8NY5Oikl8t+lJvS63Y9Efl8LW5qE=;
	b=cG2IupchJuwLlpdoPXOYmWP9NtuZu48EU4T8hLCd+mmZdGcjIQDtZyZ+WVKvS0IcAKPf
	 B+/sVCgohaQJoQISW42zYsz8rh4I/BcWsy2zpw5HaiiRW1Yd2cs+QAbTgQxz6wdsDD1KY
	 Weepp5gXaQhzd7ZmRVGi2fqdQQpkidlGa+Lle6rYUUFb/0IK/2rGg/I/RUQo7sA0c0R0h
	 EcEYRwWKmMtMGYmXdbARsGjrGRAovxmu4uFUMebmm2IdJxo6ercJlJuKyzOpJfpN3+nDi
	 BrM142CK9nphQMQTe0Xg0USvERKZ/lhpNsCvVWQwd6CILc06gTtFKocdY7/ZbMRgAcQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312167;
	bh=B/14Cp2JMdikrPy8NY5Oikl8t+lJvS63Y9Efl8LW5qE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KgBNmD3ETKpkosRmFrUA+GXw7KSZIUYPiMg101q6Vbmvy08MKSdpLMb2otoqkZqRQ
	 A/bpyubvtjVUawTEX8jT5evzuB0ouSXh+b2ioXciDRNmFiz6iJBUsPHtVqg2/3+Ptg
	 CMa07RFMPUwk+GPSpcIKLIkU4jvPsMMI4G18ErI/GE0vfgAyUXqUfO4+XiZInnqcly
	 6cVRfIQJgvpAJDj0LVmWyBH98rUv2zahURUh/DsN65llVmCxQ//ldwKXiHqgKB9ydS
	 T5Bmwym537uwP6B3tQnxW5TJHo8kcHcU9RnrnR0GJU69LlxWhElNt4VY6nfc/4KN8l
	 x07qzWuF8urYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2CEC40A7D;
	Thu, 29 Oct 2026 22:16:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CC2B1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 831008105C
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJ4uyBK8Blqr for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35EDD808D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312162;
 b=MNiZb/Ycjxas8YcsTCZsd6Oj4H80et6xX2Wn+SfTUzGKhSVnUqMgYGv+lcKdB/7rn0Oe
 zqg5hdTd2jEzOWxwYSyQmNbOC5oJLhtbeXI844SLNZGBQ+QntiA8SPfYaGvi1zBDfn6Ga
 /89Oqzdcfn7dk/sDRLCxVUEKtzYcESjEI4bkSX3/rMGMr1FKfEcZDB6lisPt9raw7BF5/
 /OiV+VhwF9q1sdhlIuhUW1qZBnt7v53L1Otg7D2sn9li43RIKF2O5tUZQ97bJlGsBAiW/
 clX0qLThSBXLhGxS2GFaclVaK2ubMZ9w9L26uPcLIFTH/V7wpT93zuPdtVT2SSYgQBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312162;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=B/14Cp2JMdikrPy8NY5Oikl8t+lJvS63Y9Efl8LW5qE=;
 b=bS11RNjkTZ+iGYUbg8LErkH4LjIKVHtxe7eUBEOduNwaFECC/kSoi53EKePJ/Yr6c5O0
 GZOBS+LX9XCb7HT3KppXZfSwdcWbKZgNv8ARvpVm4PqaI2+yX1MoB2jRjromXabkBc6WY
 dbrTMM+EWcXc0NdQtHm4hQCYnfZbfbBbc7lSY6KKQpDDYY/7drw7SBi/6Ota8Y5PW6cAA
 Pi5H4rytxKxK8V2GSXAdRAzm44MXbohqmgDEoNULzMgWlZqw0YpEH0UV4ekILtg/VqK6A
 yN1NNazEp1eDiv588/nFXOrd9dL359fglqN/PFPwIrPsouYx3c4Ijxs5cfWmqeBz1Xg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dxuXwlxb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=dxuXwlxb
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35EDD808D9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:16:01 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so43303f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793312160; x=1793916960;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B/14Cp2JMdikrPy8NY5Oikl8t+lJvS63Y9Efl8LW5qE=;
 b=dxuXwlxbJQFhSiT61NL8UzA6/ei67zZpavUstIByMsGU2FqlFY9p+A2HwafRQp/TAN
 wULomhVVFfB7YtveGQh4NGIPDF3kXQdEieVwuYDSL5EpV+d5wrcpzJa0DNfpKpMmyZTM
 kBcUtUAkhurpYvIigMpIiXPA/MxOwDk4wOXDa5WTEEx1xYxKAAHzrgQ/iqW6dU2ehdAs
 PnrErKK7J5z7bEjKzcQvc7jxSMOADTuV5Rm+f0Yxj/FPhi0GDArbxZQPsL1GRUri3mAv
 Va7owLn42e59vseTWu5Amw8Fbm0WAS58ta9QGHJjFCGkRLPO01AmYUuY21ddw+0k4DFo
 WSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312160; x=1793916960;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B/14Cp2JMdikrPy8NY5Oikl8t+lJvS63Y9Efl8LW5qE=;
 b=cOLM9RLr7bcrkNL/Bbf/3h6afN2ki1VEgEnu1VnwNmuRisGtIqEyh7br4BPYld3r6K
 zB/OumKI/Rjs7/Sv9To7fQujuGAVazPJxmZQXluqE3JlRwqQI73hBfnxkxE8ryKxT9vZ
 xfXSTWRlMXRdlPzmZBW8XI/+bUun8eVFTRzXEZiDlgd0uPNgEm0NZWbG/ePXgwRLy2Uq
 8PvWBeNJdfTB2ORg6k5V6OvTGGrPtXnBpGefOyILwtQE5KCTqHg9ddXQjnvpPOksxljD
 KY5wFyONlwj4ezLBcFYYFgIHwyGPvZCFp1u2bf+PcOPLsp3YBXKkx4GOXMFPhm1B7SW5
 0/IA==
X-Gm-Message-State: AFq9FYK0EtCMJ6IodoZ/vYCdAGwcMMCeeegUZNfjilKfNytaw7lAjnz6
 GA3e2UFhLHrGZviTOiau68C/6rKzyJK6f47Wr3jMa7z6ek7tZ/60zxN2
X-Gm-Gg: AYBFou16i6zWvZlhxZuV6w9c+8eOYoyXKpgS48VBMnSWlZHNXkCGFJT4uIvl4Y8vl10
 936KDIrTjKruG7yWQV9VdHjqCcgffRUya1e5P4SkJVpnOaJv2zyeRX7BrkhWildrdLLhXsnKqn0
 e3XGg3sDOttsnX9Vgk/JOxOVLFRvgeHBHQYz8d5WuLjT16sJVE58LdI0yH0Uy4noS3jKbBqNm14
 ojtX6tkvicFEP9hzBtG9BQergehmNRvyv32fDR2GeYpLv2FP2Zg1GoLcxojpOZS7LcLtyh3LAKD
 zHggj7AVdR5JkDcSNcN7CBd/kHWvdPZvHmwmsoW/rMWYtR1xW2FR4e2YWp0BNU4Vl5rH2KNXZDd
 bdVPf7rpQtlXM58a6wxRnA6NoBul61ka5EQ4Kioz3Dl07e3NJ6pgxsjB/LWappX6yyeH3pesAPS
 WDyzUjh/M8U2jAUwmoPvSqArPwOb0P0IUuCagkwIRdHXbDlRn3ohuTHwA1+VcMu3s6cVnLAFstP
 M/QaZHhsp+q/aJZDAIcaY5TzDswsASdz/H+TCH2iAnBtUqVOc1N22eTWawdPz2/mbtm0lo0rm/p
 KQ1yqPySl7NHgaVWrwspszZ53LQRSp0ZgKximhtD
X-Received: by 2002:a05:6000:310f:b0:48d:f95e:6e8 with SMTP id
 ffacd0b85a97d-48e6e2c3586mr1643080f8f.1.1793312159528; 
 Thu, 29 Oct 2026 15:15:59 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.167.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e712b90a3sm53145f8f.19.2026.10.29.15.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:15:59 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 29 Oct 2026 23:15:56 +0100
Subject: [PATCH v2 1/2] doc: Replace master with main as primary branch
 name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-master-main-v2-1-5c2c579e9eb1@gmail.com>
References: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
In-Reply-To: <20261029-master-main-v2-0-5c2c579e9eb1@gmail.com>
To: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The primary branch name is main, not master anymore. Update references
still naming it master in the documentation, replacing master with main.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/CONTRIBUTE.rst              | 10 +++++-----
 doc/develop/sending_patches.rst | 10 +++++-----
 tools/buildman/buildman.rst     |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index e0394515702..e38b1875a70 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -73,11 +73,11 @@ considered as reasonable amount of time.
 Development Branches
 --------------------
 
-The U-Boot developers use two main branches for developing the code. The master
-branch is used for the current development cycle, while there is also a next
-branch intended to land changes for the next release early to enable wider
-testing of larger code changes. The next branch is merged to master shortly
-after the tagging of a new major release.
+The U-Boot developers use two primary branches for developing the code. The
+``main`` branch is used for the current development cycle, while there is also a
+``next`` branch intended to land changes for the next release early to enable
+wider testing of larger code changes. The ``next`` branch is merged to ``main``
+shortly after the tagging of a new major release.
 
 Similar to Linux there is a three week merge window post release after which a
 release candidate is tagged. There's typically a new release candidate every
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index b4f82eb18e1..99581dc0ba0 100644
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
@@ -452,7 +452,7 @@ today. Not all states are used by all custodians.
   it will be accepted for mainline.
 
 * Awaiting Upstream: A custodian may have applied this to the ``next`` branch
-  and has not merged yet to master, or has queued the patch up to be submitted
+  and has not merged yet to ``main``, or has queued the patch up to be submitted
   to be merged, but has not yet.
 
 * Superseded: Patches are marked as 'superseded' when the poster submits a
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

