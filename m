Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A040606A338
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XcPHfJ8R;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FfUI7h3V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D7AE40648;
	Wed, 25 Nov 2026 20:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dc-ztHLJIKLi; Wed, 25 Nov 2026 20:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8819740623
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795639660;
	b=XRBgd10+nfAr3CQCPVyE4lZy/e3FVT08auBEpTRXfs7T9GUufJtgDASAKW6IWmOsxffQ
	 e15eM7km7QkRVD9pPIyLjGxqVFtgsaC7Au2q+wBgfvyT7clHuRs5EK6NjpN3IXI6ITLXy
	 x2AFmPX3udIj++dre54keGAKR9gj8yApVS8RbpjY0RQkadTEt20HSmeSKBGL1uNKiOWy6
	 Z7oJ/uvh2Np8i5X1hnyMCKsustK8zYhBKE/nvtPGRpU0dlURwWXr2AGn9GbjEblouXah+
	 w0uAtTYaUJN3kxBgPqft3MYE1BHka7NILybstXnBq29SJuo1JST6StMt0sEm3OgToeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795639660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+EaMxjF6s/dTBzMcjNUfSboDHvJhWbIyCLFLIZtYFRc=;
	b=IPmLyPMkud02z4LUwiaRiQI3n5ExgLJBbTE1S8Zf9ABkGsDkHAvRnO1z0afqUF1e53ZJ
	 /i/lVXXLbhx8Idsfa8KO42NqSJFpp4325FQpK416Z0heh0CwGAjwhBQVpjeAtI+5BOBay
	 iP8r+wqba9TCiwYttjRcDbAngsbw/S9059XsHS+1GHD2L93m1ZVI9SihnwwWE++6fJie+
	 qoqBeWf69OqNYi4R+oAZALkgnDHTqC5CpNK9eFoVySM/l9sTBEWmQPs1oNAEeBol9l7H6
	 3ExW670H2H+TLCbQvgLLC/el+iaeDVkcsHtQfStEe9BRp0xuXIAPE8Nq01GCTsjDExA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795639660;
	bh=+EaMxjF6s/dTBzMcjNUfSboDHvJhWbIyCLFLIZtYFRc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XcPHfJ8RfEjSZ8EqujTjlaYT3kri/K7qLB26uU1ENzoWvxzsWWlPz0hzTZqGPO/9i
	 XABfxZVsjrul2EvmVkQYkoEdbrDwDwF36qeyb+GDv0ozUjQv+nAKouWZlvFI9se7kV
	 oSGvkI5bVXTVJ60WgylAvezv0HAWsxLV+msJGwmeAM5I3gjImHOZkdawt5as8HgVwy
	 +qFCTZhlUWwPerAdkC6zPFBsS+2OQbDJfiZ0iG/lSlsXyjA9DFpaMRf3D2DqtZST1Q
	 su5TUJIXvJnBZIDCAcrjLEV3/AqHbG7T9UzQQ0xXTGYXAwi3bVZZfx0pNWtJJ2z7Sm
	 oaTho688rfiOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8819740623;
	Wed, 25 Nov 2026 20:47:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E91CA22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF265606DA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9siKrXTNvqr for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 20:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EA30606BE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FfUI7h3V
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EA30606BE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:47:36 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4adf4431ca0so1703292fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795639656; x=1796244456;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EaMxjF6s/dTBzMcjNUfSboDHvJhWbIyCLFLIZtYFRc=;
 b=FfUI7h3V/uC5kWC8Ts/DugaPdNfTogwO2Ps8rxiKIXHRwJwIpYkCpRgFFw4jlcqRPw
 hMKAZO2V6P+rxuggUIUDAzfFQednyooPteJ8jHdjdt96BvDXEyIBmyDfhUizwCKSeVKt
 jsTx43Dbl9LUPhN1P7RbPH9QafTxbYJXJ7LbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795639656; x=1796244456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EaMxjF6s/dTBzMcjNUfSboDHvJhWbIyCLFLIZtYFRc=;
 b=wnI+O4qCVd/cyiU/NQFqBuNsB2LmqnnjnDOnL90KxixjWE9PMkavMvQLClWu3ZOrFe
 uS9MrMBD+6R1LxhSISMAMgDUvMgdu+t+Hbnbvknlq6TpruRBKGaVOHiX+J7X5Lie3EIe
 ZTFMk+dMCIK3YAN2yvzvimwVJdGtpbIORwThzBywilcYPQSsgqVedPnKjSSbn61ix/ut
 P7GuXL0r8hXHj34dWt4nLSnox1ATVXwDBFP7vu9QzDYqXhIG2VO473VfRPmLfiwbpIPr
 3ms94YRMnOdyBSX1HyMpVv/7AgPBPn63YexrAtSqHlatzDoqvutp5flmvEssRN65QRCK
 V8xA==
X-Gm-Message-State: APuU4Z/+Pa+ZzK1qg8lknvsHh98cusWj6BHComzZM6SYX9NYPbgooJPv
 c3PzfVrRKeBin2+W7O+5dZlGA/RjTzbO9BmbUFzWdn0CMLGBwYcdu9cxzVrb7bGKxMyLJbx+ol6
 7j/MFcAXipjPa
X-Gm-Gg: AZFdTZf+tH4BuFfEh3a7bog3c001PIJixZ5NX3uTqvmwJTQpD54CMtRE557LAw+bjy+
 EIgH4HO2m699RMzDBqJsLfavKx6WAe8IhDvTwKWG+sKrbQAQpfohz66FuAdqrADuuA6Hb22K1Zx
 L20xiua9sLcz2HyaQwx0FsuZRatREQqjIQxpafn4g+1pU/QxH/E/Ya2B5h5NB2vnfMgOBlVr8BM
 vWLozuHMb7eQggYdMO9o+EOyDGhptOzdhdzctj26OHUJDb0LO2YpsEz+ciry2gDl5wGcWVdEFrE
 M6/Gm/E2C2Yui9C06q7pZxMUFrCK6fptlXMPzSq9nR881iNSMqQpZNRseg4RqiKbMxkhLytJUVn
 CyC5uO7g5lNFmlN4SutB9zKZov0/G2vXz+wCeNTAzIJOD5r2DFIm6ryPzDAXZx4Jt3Nt+zgz8HD
 DymUjgAQn/c/rqgbqWuKvgIU2kO3sunlBp1YbHxHYqKVDD1ppJ3OYAnSwxPjXQbAG1uddoUuZmK
 DWueBjYUf2Dx45/7L/6UfkcWI9JLcAqNKYSlzAOK/Y0DQd6G1pfNCuT0ju+yu7luPy/+GKUgYwN
 mpxNGSR0I8Vu/erLo2PryvmlmvbGdFX4ri+x4wILPcBPjSH8y2oEqCNEXOEXiTgLxjGA1173ZIy
 szSd+CtIRSWixVv7or3mNbhKZO9Y88yKyjkRKrbulRCTdgssTf/hAufbZUHTLUxXgQCkaN/6sIR
 Bbmy6gHWASpN2eIKB/ISt0tT8rOoqH4kUHZVpj1Fic+HeX3Fe1jTDIhV8Dl+lOVFy/r6yNH6wZg
 /XF
X-Received: by 2002:a05:6808:17a3:b0:573:bf91:b218 with SMTP id
 5614622812f47-57a06a10fafmr18659377b6e.2.1795639655722; 
 Wed, 25 Nov 2026 12:47:35 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35e5ab03sm14636735b6e.16.2026.11.25.12.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:47:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] Azure: Move Qualcomm boards out of aarch64 catch all builds
Date: Wed, 25 Nov 2026 14:47:33 -0600
Message-ID: <20261125204733.2995467-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The aarch64 catch all build is currently failing, due to running out of
disk space. Also currently we build kirkwood platforms in two jobs. Take
kirkwood out of one of them and replace it with qcom, and exclude qcom
from the aarch64 catch all build.

Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6e..ff6392439da2 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -10,7 +10,7 @@ variables:
   container_option: -u 0
   work_dir: /u
   # We define all of these as variables so we can easily reference them twice
-  am33xx_kirkwood: "am33xx kirkwood"
+  am33xx_qcom: "am33xx qcom"
   amd: "amd xilinx zynq"
   amlogic_bcm: "amlogic bcm -x mips"
   atmel: "atmel"
@@ -38,7 +38,7 @@ variables:
   sun8i: "sun8i"
   sunxi_rest: "sunxi -x sun4i,sun5i,sun6i,sun7i,sun8i"
   arm_catch_all: "arm -x aarch64,am33xx,atmel,bcm,ls,lx,imx,k3,kirkwood,mvebu,mx,omap,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,vf610,xilinx,zynq"
-  aarch64_catch_all: "aarch64 -x amd,amlogic,bcm,engicam,imx,k3,ls,lx,mediatek,mvebu,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,xilinx,zynq"
+  aarch64_catch_all: "aarch64 -x amd,amlogic,bcm,engicam,imx,k3,ls,lx,mediatek,mvebu,renesas,qcom,rk,samsung,socfpga,stm32,sunxi,tegra,xilinx,zynq"
 
 stages:
 - stage: testsuites
@@ -204,7 +204,7 @@ stages:
           # First get the total number of boards
           total=$(tools/buildman/buildman ${BMANARGS} | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
           # Now build up the list of what each job built.
-          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_kirkwood) | grep '^   ')"
+          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_qcom) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(amd) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(amlogic_bcm) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(atmel) | grep '^   ')"
@@ -640,8 +640,8 @@ stages:
       # We split the world up in to 10 jobs as we can have at most 10
       # parallel jobs going on the free tier of Azure.
       matrix:
-        am33xx_kirkwood:
-          BUILDMAN: $(am33xx_kirkwood)
+        am33xx_qcom:
+          BUILDMAN: $(am33xx_qcom)
         amd:
           BUILDMAN: $(amd)
         amlogic_bcm:
-- 
2.43.0

