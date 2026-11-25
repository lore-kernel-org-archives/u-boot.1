Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D52606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yG8z54gX;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lL5MPPi3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CCBA40835;
	Wed, 25 Nov 2026 13:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hZJf725fPsH; Wed, 25 Nov 2026 13:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 514B740830
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614214;
	b=Bmr3kRz76/K2mpB3R8bHFYDYhhoc6r1vvWAEHitOWmEAEzQv4hlfei2cZOBJvagXf09W
	 5sL7eP+kprCLaaPQEsPPXAUOpZx8Z7oREfJfgVhtCS541Nxw3Trdp7NhVJre4MRi0Uus3
	 2eM1JLo6qgzrBGAR1QUzD6ZgN0zB+u3LcWrEWYobaC1IbIxiEzxul4d1T2Ezf67BK++ss
	 dBa+b4Y/QOtF0zQUWD8wVS7FT1WjMO+l5zVAQFXtUHFHRZNhbRW/4edBH/MKOPffroqsI
	 nhvSn4PU6a+ZPvcMHTDVMgwDAvBAUu+/1DoRZ9tgGbc1RrZl0CH5RsJNrShgCnq2OXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9T1OPkWhQD5d3YJclk6T/HR5g/uQDhb34SCsUQh109k=;
	b=YfXJ2WT1Xrf+NpZ813J5Ja9J/r23b0PVPEmqCZkAtP/h4Ifnwa8WfrUXfoWNawrHVHo7
	 sGlENBU0xZKQSdC6ts3cbnaMgZPrgIjfEfxfrJSTHClciZCgAcubL4DIb9xDqFDKPjWBa
	 fM4cliefMq0xm63ELw9cueCuYRch3TGi1vd6cLx8Ky1I9v3jAqB4RoHpp6Heil9F0yrnT
	 oVeGJybMSA6E09UqsxdddkqerLvznrT346hQ1SsTtPomvXYH0uzcNdtVrwKXjZNkLqfyT
	 LeyZ5ZNQaxhI/XU7NmUk8wUlDPCjKljK9zsTNrFMth3eg0sW0reB/uhD+KQqftzNNbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614214;
	bh=9T1OPkWhQD5d3YJclk6T/HR5g/uQDhb34SCsUQh109k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yG8z54gX56vQ8+Jk9jVaffr3lNHEk7E6nzQchzBVdtuDQhY6Yd8VjXRQ2N1f5WJbp
	 TGhbfaP9ubYVN7lmiCoSMwFWhKsVyN8h+rjh27o+HPKoSn+OlUeno/T1jRFY0DrFs9
	 SvoGZJBLuacLAPQ8IB8NZatr2yjpWfawW9fc/aNgSFB0HC5oGE31XQv0mwkgIb6Hed
	 iHO2R25jxPpBbUYDCWBp4zqeOcTkvXjnO0h+MUUcBTwDEKPky8Af4u+EJGoTiUDD1k
	 FomCYkupV3yAZ+HQ+jvIKJvAAhHE4zy44xKVfvNK+Q3fc6/5g+Mslzj/dUr9akmqoo
	 oOfVGYaUWLAAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 514B740830;
	Wed, 25 Nov 2026 13:43:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70B242F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62761401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOClLPU9NapT for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B541B4016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=lL5MPPi3
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B541B4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:43:26 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-499f20c7054so3057763fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795614205; x=1796219005;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9T1OPkWhQD5d3YJclk6T/HR5g/uQDhb34SCsUQh109k=;
 b=lL5MPPi3pOmXlZFTsaFzhRW67Tw8kmk1Vd7hQi0AA1qSBj9mcesLpel5OItkMyTD4g
 21SBQ6rH2NBFu1azmx+Xu4oKevza6bexzhr2L4fTjXAbAtyVjmdrab0305mWLbaxMZ0J
 lK3JOXfaVZn2W6X7i46QugYUUe3lqlixSpLrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795614205; x=1796219005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9T1OPkWhQD5d3YJclk6T/HR5g/uQDhb34SCsUQh109k=;
 b=rVKrpdJ723KuHDjRxqzOChMW4MVsqiagVJsgApB49tWEhhteER7khlvt4g5KC5Ybdi
 51xEUxh9kgXFwJfi4UTS/P6PnkmTiK45efpujm44qDKvb6PVkQcQzhONPJGhrLsLl8ET
 c4NmVuPqJNnzZZ0dlsU6u4DqUaCPgFFJdmqel9AdAaKaqE4+T21TxMoqZ+AhGRvNnk6r
 GV7dfgqO5o4kIKRe72Ske7iEUnIUO8pimk8IE45OLOahgHDmFtJ7oGhxW4v5gYIs93/F
 F0XJSPON3UYW09mMLwxpoRe7ewfsu7Hm2QLJvZ/9uk7VYZVWGA6tdo5drvNGO207BdUk
 1eTg==
X-Gm-Message-State: APuU4Z+WdFy6bMvvKOkmZvMt7v3oM6wEi6eD/RnPKCZRErJ4RPTKdS9e
 WYv+M4TBi0g1aSXEGrPnijuIUFXbcpiLjcrs0XN9Qt/VMvv2CANOafocBCWv1BZRglwz3R5KQlD
 7QpEsCx0tR69l
X-Gm-Gg: AZFdTZcsKGMw4WGexSkOGjMrT/j2UtXEtleIMP87Ek1XEkEZaPSHrkvWranImgQa83N
 Hmc+D7oas2C2pQkHS6qCBZfmuuikk8u7jJwFz1d5ZAcc7LzUwDGHmuapH7h8guX0qkJ5eMVTj6Q
 QOSRSE6drDCDTnd/2HbhKybscgbfGsfdtQuKGY/4qMjYdeSYL7lnYwef+XqeRV8+cQ57dgzZdul
 0NFPvxvmb7cCtgQr8u/LzXlQR6ln+u6838QJ8vklOJupVKCaWuineORjtfRsxXHvsPNHqKx5dN1
 Czia6JzsYJISBgTYgMF+vNCHOsZVjWDVaPZgxLWI3fqdMcpAC/4zoYk9CvBANlbTQEG5wE9c2eT
 AD7zvva1Tms6XVozKQXUO9w3g7FLdS/p8y+L6Ps8B2Y+Ev4k6YFEc40sxW3GETA7fWOJkh4ZrOc
 9eXwO6jnBgploSiSDlDdRlx/iFq0vxvkVCaR6dJF5u1gRIGRvC+6RZl7Nv5HC1gUEByrpw6+FUR
 3u2bWhDpkdesn3vQMu6Rpaynh0WDKd2Ox76puPPo8aAEVF9tW0CtT7XuJ91gZNTeEZc1GTzp/Oi
 QRPIasaUDU9WLUIoIFQOcJB9vhRh1BvjqRrcvJOr+4PtAYAWjLXNfR2OzG5gg9sSFlkzy4avSZi
 0rKZ0OtGLEtn1wdSULWCARIsE8+AisgvkgLKGw6hOnzV3barPB2V+CfvoddV6lPPD3FmfbN6AWn
 HQgWWu+3by5oQg5mVqAMxk/keI5Gt9YApNghlTo/roeWdSwRcghIIbGuM=
X-Received: by 2002:a05:6870:c0d4:b0:4ad:949d:1993 with SMTP id
 586e51a60fabf-4bc7bea441emr15365136fac.8.1795614204962; 
 Wed, 25 Nov 2026 05:43:24 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d766sm16204806fac.2.2026.11.25.05.43.24
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:43:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 3/3] Dockerfile, CI: Update to the latest Ubuntu 'Noble' build
Date: Wed, 25 Nov 2026 07:39:19 -0600
Message-ID: <20261125134317.2479815-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125134317.2479815-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This bumps us to the ubuntu:noble-20261110.1 tag and also brings in
recent changes to our own Dockerfile.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 2 +-
 .gitlab-ci.yml          | 2 +-
 tools/docker/Dockerfile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6e..46509eeb7df6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -1,7 +1,7 @@
 variables:
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-26
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20261110.1-24Nov2026
   # Ensure we do a shallow clone
   Agent.Source.Git.ShallowFetchDepth: 1
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b78f7a9775ad..31c3d53806b9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,7 +18,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20261110.1-24Nov2026
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d5f1f6d697fc..187b55a8d1c2 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:noble-20251013
+FROM ubuntu:noble-20261110.1
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-- 
2.43.0

