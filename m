Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA7E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC6B895DD;
	Sun,  8 Dec 2024 20:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pIT/2SO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231D9893D6; Sun,  8 Dec 2024 20:08:04 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D8889541
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467631f3ae3so1755211cf.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684881; x=1734289681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDvNaabWhKkWhwpY1kPtX3noWnH2Byfq+SHtaSFhw0g=;
 b=pIT/2SO0Vy3/x+CGDO1xWVdt/D3hzwZjSbcupebtQ7hRUif7e5MKpvAb7eOMVCq36H
 zcDloGMwum0NfMTpTSUapwWLFbSJ4/NYxyOGWb7JO4ahg01WH0T+x2VSUMQPm+2hqsro
 G3PvwSFUf0wznExUS22SLV39iwTECdMS1QFIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684881; x=1734289681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDvNaabWhKkWhwpY1kPtX3noWnH2Byfq+SHtaSFhw0g=;
 b=lGDcx3QY2u8GbK6gYRD8k466fFDTvUi4na1qzeV6cKCHe0SxwoyPoFcK6Yd/qlVogr
 /899x21fnNuImbGH87MWgvYh757dU9Oww/XVZ9L2N0EjqgtJgDK1q4jdcETF8vMVZsG+
 feFoL39hQkeswXUJRAjc562FAuBJ6uNJRl3dV8zYvd9O5HtZWwOIuZNZLQnRvX9kfgAf
 tGTaH9hUIJILPs8WsNbGdyBuhbVIVU0fm2CyaxVVtAQ17DhezDJOuDmZp+YfNOdtEliA
 N6BJ5sHTkyySDqJAH8x/dYqjM2M3aP3DOFnCP6MPs6Pyl27GR+BNvliwCfsO9qB0x+wf
 j+yA==
X-Gm-Message-State: AOJu0Yz3eldoSzzA7XUMMDsAjmAN9Ht0sAh8K8qpGrgI4B0QRNaHyOn5
 M2X9LJVQzZ+ZFxao+VAY0JgDW2YBTbUtEDwHRfwhxXxybNBOeYE+ucX+7z1TVh0DaAmqk44ugVd
 i0Bc=
X-Gm-Gg: ASbGncsWoipQir2LJQ/3JM7uO+IFL+hNR1ghiJVezgombmAh8X1S5vfJ9hd7Kn+up/q
 EA8VSfbccaVAHbaGKc5L79azZqdxTtiNiteWaI0w9BjaDkKAmA4v5terck0sBWFc2771okUL/PC
 iMcIiLrIXUvCNqzZmAOUfBDcImMi2u9w3ZcS/Auke2L5JzuJ7K+dcJcKOg7jb7rqJ66yuGdodGj
 NwTZWX48rEbNYupCpG9U36JLuYruNdSUEaNF0DUtmhH2kuiftcB8ZReZzznLqehgVh+aooy9g==
X-Google-Smtp-Source: AGHT+IG0TA0qHjnIqVkAYocMoM1wHJHJoimpc3Hx1wfT6/KstVc9EZ/dAvfw065db4zbAUe5ySQ0HA==
X-Received: by 2002:a05:6214:c82:b0:6d8:96a6:ec27 with SMTP id
 6a1803df08f44-6d8e71a62camr161049496d6.35.1733684880870; 
 Sun, 08 Dec 2024 11:08:00 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:08:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] doc: Expand what we say about building the docker
 container a bit
Date: Sun,  8 Dec 2024 11:07:31 -0600
Message-ID: <20241208190741.4192601-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

First, try and be slightly clearer about what "buildx" is with respect
to the docker build process.

Second, now that we build the container for both amd64 and arm64, we
should document how to make a docker "builder" that has multiple nodes.
With this one node should be amd64 and one node arm64, and with
reasonably fast arm64 hardware this will be much quicker than using
QEMU.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 doc/build/docker.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 5896dd5ac4a6..01ed35050908 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -4,21 +4,29 @@ GitLab CI / U-Boot runner container
 In order to have a reproducible and portable build environment for CI we use a container for building in.  This means that developers can also reproduce the CI environment, to a large degree at least, locally.  This file is located in the tools/docker directory.
 
 The docker image supports both amd64 and arm64. Ensure that the
-'docker-buildx' Debian package is installed (or the equivalent on another
-distribution).
+`buildx` Docker CLI plugin is installed. This is often available in your
+distribution via the 'docker-buildx' or 'docker-buildx-plugin' package.
 
 You will need a multi-platform container, otherwise this error is shown::
 
     ERROR: Multi-platform build is not supported for the docker driver.
     Switch to a different driver, or turn on the containerd image store, and try again.
 
-You can add one with::
+You can add a simple one with::
 
     sudo docker buildx create --name multiarch --driver docker-container --use
 
-Building is supported on both amd64 (i.e. 64-bit x86) and arm64 machines. While
-both amd64 and arm64 happen in parallel, the non-native part will take
-considerably longer as it must use QEMU to emulate the foreign code.
+This will result in a builder that will use QEMU for the non-native
+architectures request in a build.  While both amd64 and arm64 happen in
+parallel, the non-native part will take considerably longer as it must use QEMU
+to emulate the foreign code.  An alternative, if you have accesss to reasonably
+fast amd64 (i.e. 64-bit x86) and arm64 machines is::
+
+    sudo docker buildx create --name multiarch-multinode --node localNode --bootstrap --use
+    sudo docker buildx create --name multiarch-multinode --append --node remoteNode --bootstrap ssh://user@host
+
+And this will result in a builder named multiarch-multinode that will build
+each platform natively on each node.
 
 To build the image yourself::
 
-- 
2.43.0

