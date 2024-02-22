Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EC3C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3BD9880A0;
	Thu, 22 Feb 2024 12:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IoyYxQ+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3ED8808D; Thu, 22 Feb 2024 10:36:39 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128AA88088
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so6727763a12.3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594594; x=1709199394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tcd+0dfRYZF3OWKud7BcUhBbJZ0BNgm86qOOaiJdKvo=;
 b=IoyYxQ+2NG3C9Ok2jJ7UA7KGmG/zuQw761AhE+YKP2DrTw8FqFVjtgDcj8mpEhxyBh
 FuJD0YonKgZ1HGwHK2DBHI9NI/iipFOuh3hH4Gfsb+1ZoShPZV5FN5C6COMkG8VDyXCc
 60cyN0+4LmOjmDVYW3ONPUSRNmuzv3lid/quEeDhak98Do3v37uAwAFG3Lot07zoiCxB
 gI+Q3qD1RdxCDW6XtBix4ZaujdoQUBNFH9DNgE7R7axiN8gWzImq+Ch8EtxQVy419cfU
 4C29mBv6FbRTGl13ol2c0S17FunpEgJV3pA5mliLvYeo87uTlzDi4ebVUB0OP6Gv3NpE
 GL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594594; x=1709199394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcd+0dfRYZF3OWKud7BcUhBbJZ0BNgm86qOOaiJdKvo=;
 b=axhICFm7/MdywKRygpY8IgzBy4lPc37bUIlT/s/i2JsV7eNi068noCzHQfIgpz0qud
 Cvc6WMgX4LVnL6Sh+F61h/2UW9JV3koK9O47P4DNEEjMeOqzMpQfmPr2bo6dbEu0HcrK
 SS3JpwdPbXkFtnU4bmCPf7HfnwtfZ0NB8preeFx+GM83OsqnltzcQIytE1ZzwP2HXCM5
 c01x/kwD2VkrtdqrhmsdYVRJMatx2EbBamcRKLYEGMb0k8WJYCTncHYPiIoGZTl7e6+M
 SiqYbOZy3NokNJ5jVX2DlRcO7EoTKKAAIOA3+yhBg3fi3KAV3WJMWczlGcM7RfCVQSaT
 piiQ==
X-Gm-Message-State: AOJu0YzglfdN1xI7lsuGMVqmuj9I/H0yWWNbGhbaq7LmY0nl23gOCOwW
 Yf26MkCRsgktPgERDludgkoTJGWA/x8gMOhzhUY72sJ1w+Q6kGtn3H5NMevsT9wqK2E5dOVBuUI
 B
X-Google-Smtp-Source: AGHT+IFIEFpzkt9C19vMi3K825MNxYGi2iVl0rjDkbXs1HVxJZ3K0mzr3rFYs6/iQZLCTFYv0ZKS9w==
X-Received: by 2002:a05:6a20:9e4a:b0:19e:3c4e:d0c6 with SMTP id
 mt10-20020a056a209e4a00b0019e3c4ed0c6mr25897148pzb.59.1708594594245; 
 Thu, 22 Feb 2024 01:36:34 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:36:33 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
Date: Thu, 22 Feb 2024 15:05:57 +0530
Message-Id: <20240222093607.3085545-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.

Changes in v3:
- Picked up review tags

Changes in v2:
- excluded gitab CI config check and added commit description.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e2646783ee62..1d73215afbae 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 278a2e2bbf31..8bfbadd6c89f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1

