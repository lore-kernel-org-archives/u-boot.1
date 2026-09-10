Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93057C88E42
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BA0560BF2;
	Thu, 10 Sep 2026 20:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uzht6Ou_OuV4; Thu, 10 Sep 2026 20:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 876F660BF0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070608;
	b=AJm0w+8mFvPbHv2K9K6mwcaM8o+HQ+YBroHa52ajSAVpMEZR0Lpbf+PH0SRJpX8NQ+xA
	 +ZWYQBxDXbxryyk7nO4VIP7mtioU9aDALzMD/3U2P3DsT1n1ewni/7oZe/eCJW/AksMwj
	 oU3S/K7UzvcL0qmLhLgqotUFLsRKxp40SbK601OJ+0bOG6SRXoD7js4dGaA7KarZjfuI1
	 bRP/xwmioFnTb0vt7uay6dYs46ptxmFxb4+q07PPL2bv7AuRr9sk8TDGnNW4NfE7Mdc2C
	 MMNzUP+DfYJmiqvkSn+DVtTDaj+bROnnjLzL4vvldSCxiQspFmJq7FHQDnWc9N75E4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
	b=jY2WkweGcPNqMhVd5NqCrVdYJcd2yLH+Xg/pod/huY+0jNVmNSSGge1S9V3bB2iVaEus
	 AzC3NWnYsnoI/6sBkVAhDTQfo2DrwfyiMD081t4eKCdWPlfA24aTQheE7Hti8s8AHyJTH
	 ccy8cvbzKZweXGqNrT531vx4PCaLuXhRVjiwfHD+56H2he0u/xgLsSoHnCdE3rOMNGwqa
	 gzLxjYWfvnzCsHCTmig98nS9YKQ+wp+yCTes6HxR7/wv+Wz4Xd1od1HXa44dDBw8NjuoH
	 4BDdbuj4wmSCEeK2BFRsxEGG+2TZcwtipzXA70dc8QE3SbMNCrjNFaeX/IVNInIYUrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070608;
	bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9LH8QtPZqUI3Ug0GgDpFqrScpgtCjceeA/CpAv5v24CX9XOHFqizcSmpHDJg3Zg1
	 suFdjOTfpY1D3oCm+ZyPTKPO2YFaCA4/VcnYkt0oWIf6BzQOvQ0nvj3ZLSEmL8gg8D
	 Jz2akPt9XQAY+P/roC9KcDlpTGIUNLbHQFR0K//2+ATWf0YEW0W0UCLEzLr5tO7gSQ
	 uSOgAqqCQvNkD3Su3V91io+naYDS7QsRulhRcBdSHzqHDD9J08iRwNWBObdfF7dXU/
	 2bLrCxV2IIY5Gt9iaK1DZgjvyI02l3wU7KqgwkbIBDnLzuFptT4sg6I6Xtx4o+xZWt
	 kwOOvMIJDAKLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 876F660BF0;
	Thu, 10 Sep 2026 20:03:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A94E614D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FC9140B96
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poaMtjh2nbkq for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C8CA340B55
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070602;
 b=RhnqIDSOnXMkBq5xsJfkF5SwNSppwcMND/RCHvP9w3VJjchtUYwbaf4X0gmz25QDTi/E
 FdoBKs/jfsx14pat7kc1LMj21eW7v0beenUyt3+hrp5aZNwLUAdiaMf25kB16jOQlax3Q
 o/+s3sAnVJYdzk4DhRB/jzmTRTRYxJ2zwMlh21LVbqKtp+HRAcvqJzB0EYWQV/dkbGlSU
 xPwgRaN7JBNKAC86HauQFmKwgqktZukbV2qSK6VAt9jgE/0C/L4L5En9QFa/P5R6cXX8p
 GoUVWvKFFox5cE6g5HnqUdyyKqz++Cg0fV3w1OW1LJY7G2dka5ce3HYHIuFnXHyxyGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070602;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
 b=EqDlWtkXyINpCLAV6/opUuKj2uKzsPi0Osuchlhkh5kkB2EJGWHVICFUOl/RXRN064/O
 YcEcuI1V5URpw3x2dcTGX/W8YOY7H0k/MCKov0wljk1wInkvA817Ln+A05+S90r/uu4PV
 lmnxJ88nh4yE8tuTulgR1uv4Oqm6iQMC9GjQMAZ81Rsnw87TmOMmfVH1fEqLFW8g9pYJ0
 UM5ywTbYeORaNq7uaMsgjyaUa9RoKSn/2g6Erv76dGfvlbSvADvxtWpFOamFpejReRe7B
 4npiM5BF07yC3p9/hrquji635CMzJn1mhc+glr5DtxSX3n/crid62pmKAbQ6ovBwKmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nQ8MYIBZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=nQ8MYIBZ
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8CA340B55
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c2c368cb3bso151212b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070600; x=1789675400;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
 b=nQ8MYIBZbCsPJmdMdO2t0n7rvR+lUM3+16Yy7GKvqSjc/S2v0z6Xqybw8W7XNqC8RR
 jRWv4WAkA8+FCCgj0mru5rXPNHZ4SPFXIh1tcrsCRqvO0e8utVWxq+ILpHxpAjFwHa8w
 tmaRbh79QHiT69q9qtFb0aIyRWVHd9ihzl7jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070600; x=1789675400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VAW+O1J+pNK0ywvy946gJkHqCM/dwkXjpUDf8ODpQo4=;
 b=Ob8hLynBkMeBjG6gpjfcKEHYjwZ+IyqdSxTCXXsDHe9hR238xW5RdvsaUxlNItuacH
 dr3rLt15WVJqGsbJjklJ6fL+r3u9l5yeev8SH6AIvz+jR/gs2hHuyvx0fA5cJQBnKm60
 FMfh4CDJdaJ5ey+euQsFHSpZS4iDGu7fsmtytW4HURE1gKxfR1xX2gLbxVA8BntLvBqx
 mUfI2evogjN/hMxNL/E5BT8Fdux2/DpPPJ0jSB56PPdq4DRQEtoCfI8u828dPmV+Ufyi
 QxkDSQ5yRdrwYg2Zvp/E83i/9T+8Zfl5ji2CJi3+KSQeP2pc89JEP62tZRiVAdJhsnGZ
 +fsw==
X-Gm-Message-State: AFuF++kZ64tOfySyaecGrGd4McvqoRm4h5l4Q7zBIlOxYUyZqZ8xSwdS
 7is0S/XbmdjvyrEJFJQItw30d0z1tpHqcPfFrjUjK6S+ik20I294TFawm3d1epNyIZ8pclsFzQx
 jNsdvnKxuN4fe
X-Gm-Gg: AYBFou3HcyvxbkNYpqhHwNEay6VcD+QxA/KOnZlaspcxm9+Dfty4eLuq+HEL1LWa3Sb
 L8dnURGjaVSJfFdlHn8VpVDCb0K2UBMtEc/uy74/VwDPgQQI0M3K6MmIgmSubcwFchMK0BF8Bou
 QxCV/LuGfYpq9KQi2osi2NzXxGT5hd7zUG+VNdRrZv7w8GeED+dWou8gGEpFbA2h1eOiFPgnGF2
 nGXFSzC62Bfemt7oLGpk5W+Wf3mj0xTeRp+ERxVOTK9ckjIrY/9Z/LDi99Uf8LvYGKzLRNZ5TqS
 aX8EcFsB6AwxpO4f2hyw8O1lo7j4w4mb9GXlfwXgJnLMZxpBv5IAfXQhHHoBnMpAoNu3n6wYZYw
 dBDGlba881xzy8iQk9ygei60YMo1+j5+wQO3Oo8WU7INH3bUMTwDB4Cs3BCOZ2buUff5/ImWOsM
 fTp/S7z37kKUB3T+yKY3wMoOYt3IJslDAhI1MeTL9AzRtig3I+0LwADkk21V9gr22NlMK8N9OtO
 MHWIU/ObOEtWUWLDrCForlDO65IfEeBhLZm5YlhA0Pubrbisu0Cb9LYzXaqpsgU2Du5eB+nK7ka
 z1429KgzmpnrBi/K5H9j7AjgOsvg7XO0/oxPb7XrGZ13
X-Received: by 2002:a05:6808:1301:b0:4c1:2b62:35a4 with SMTP id
 5614622812f47-4c31a28134emr996295b6e.5.1789070600562; 
 Thu, 10 Sep 2026 13:03:20 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 7/7] CI: Run scripts/check_maintainers_files.sh in the
 existing MAINTAINERS job
Date: Thu, 10 Sep 2026 14:03:09 -0600
Message-ID: <20260910200310.3503830-8-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rename the existing job that does some checking of MAINTAINERS file
contents already to be a little clearer that it's doing two things now,
and then also run scripts/check_maintainers_files.sh in this job.

Suggested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 015fc15d5c29..5130058925d5 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -90,7 +90,7 @@ stages:
           make infodocs
 
   - job: maintainers
-    displayName: 'Ensure all configs have MAINTAINERS entries'
+    displayName: 'Check all configs are in MAINTAINERS and validate MAINTAINERS'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -99,6 +99,7 @@ stages:
     steps:
       - script: |
           ./tools/buildman/buildman --maintainer-check
+          ./scripts/check_maintainers_files.sh
 
   - job: allyesconfig_and_tools
     displayName: 'Ensure allyesconfig, tools-only and envtools build'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9831dd61bc18..e08068f1cbf5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -189,11 +189,11 @@ docs:
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
-# ensure all configs have MAINTAINERS entries
-Check for configs without MAINTAINERS entry:
+Check all configs are in MAINTAINERS and validate MAINTAINERS:
   extends: .testsuites
   script:
     - ./tools/buildman/buildman --maintainer-check
+    - ./scripts/check_maintainers_files.sh
 
 # Ensure host tools build
 Build allyesconfig, tools-only and envtools:
-- 
2.43.0

