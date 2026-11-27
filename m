Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05A606A31F
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XwYZ63Wo;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ox0/kCSq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46992812CF;
	Fri, 27 Nov 2026 16:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdJT6ctkQOmx; Fri, 27 Nov 2026 16:29:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C29D8129C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796982;
	b=qi2kXWYYyiSRE9oWyM/0bUMjZcyWZEMrykCYIlsXqr3nonD7f0jHPGH6j3zpRJR87Zwg
	 4BsttPK1Xe7tXKEYOm0jdxgmMaptG4oqqGALhSlWR4HcYPuc2iQAE8YrT8Y4x0aTrK52j
	 3tcJUCbKKZgQXCqSU7ZlbKzDEDYp4Zq2mKywL+VQ7rGZ8ODCX5f7bq05t5M5vqceoMDDz
	 oL8sqvsSYsOV+oMiY9epm4XrUoyUvuDXcOPB3FH4YEwKPtJb5OPDSsuFkSXIe1lSmt9xz
	 GykegxHmGZ6OSG84B4QokLASjcXmuw2F+HQ3UKdVD8HT0F/EVTKqB2YKJNQNzYWW2+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GeG651RArJaoMin4txEhDwzEfLgXbzfZVduqbAWreFY=;
	b=CgAqIMBPTbHsz3uzQvrqyhMPrTIBb2TR3PiZm5cXaLddIfxRNhCpiK+ISsT8UE2OsRps
	 HARGDlsQh1mDmaVvtWLFfGKC63+TMS2ccEhWzF2gXHtmbQN6kJIPQoWY52DR2s2kyuDxz
	 AlPoIB7sMXpuep0GOrdzj83cKzdlYbmi6UYZtOHn+P4OfS123uHzdMxRTf7T2uHY7hYBc
	 GB7P2wVtfDn3BRenGHweA442jhMLNRlqhImWvJjWecDaPBBFXW9CMBcBM5xvdjliZD8Xc
	 D70aDcrjPyGvJvobOeWZQJgg5cjcYEwB3AC8jKuVzkwiJQWKTpwIsqHW30rIUVb/kOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="ox0/kCSq";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796982;
	bh=GeG651RArJaoMin4txEhDwzEfLgXbzfZVduqbAWreFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwYZ63WonU5HPov2sOE20aZDgUZ1zBI9Ft+TEavJ502O5l3HCysALOFQqlala5wSb
	 qDLFbjUmVlBTljMmkCf5PLrxu5w8aALmQjFBrIpuKatSD20t0JsURG+qUxuhO27pqV
	 N6Zk7gGTtgghYEbjRaSmiks56nqYmbkZUDvNBuH35pUl3aNtWZZTyPk4dBUi6zfPD9
	 L6iTJ4WvL0SP+sSweTtJcZHA/+T4zalfvgWEr4p4XXpLtVlgveIY7gNkvhloKOiE+N
	 TDmkrBXKCrKrRgn+xlAAoaOzu1hA3pawRlNR5iRh1qzSN80vaQAARnrxT1lmY6qn5k
	 xRQDU5vQueQBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C29D8129C;
	Fri, 27 Nov 2026 16:29:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2F13311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A36E381215
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXDQ_W0O_9Vd for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:29:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A16C8129C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ox0/kCSq
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A16C8129C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:36 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6d290b10a35so3452435eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795796975; x=1796401775;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GeG651RArJaoMin4txEhDwzEfLgXbzfZVduqbAWreFY=;
 b=ox0/kCSq032RWAfc2rZlAijJ/pO+GmeoDRJO2FFzQxZV8ZIpq/VEHotaoHrSyoovBC
 6eIXgp/1TQJyolMSHMFMpjWM0/2hq38W+uuycykTKHft7Dx4bjx94NL7d3ENFVHaPXRl
 cPzrHxPyUNQmWtLdNErUcGmFHFH96Liga/KJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796975; x=1796401775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GeG651RArJaoMin4txEhDwzEfLgXbzfZVduqbAWreFY=;
 b=uxokki8GyKVoPiSuQNMDAgqbtH9gW19lU9bTbZ+ErUFuTx9QcF/fdQC6qPnVYpyXpY
 AOOWF+oEb2gPOEk0ONEppNbqb7/nll0FJeXFyl1rvnHs6x1a08UtS+sHZFcZGSI3NBiZ
 cO+O+gdhGAZincqnGLC+FukNsnVJVR97FY+/ARj4OXE+VMqsU86kvfioUxHy/9NiqDCr
 KBUsaRhKbvE1rhkKBTkXphH6khJb3JsYmMdJd2ImTIsrcYaBTvMC2h4p4qsBLkMwAPex
 LY48LxpNyf+E0zuwZ+svN0ZBsHfkOiFr8PH4+b09iGesI7h/2ROv/xLbKLflQGWAv7VY
 4FnA==
X-Gm-Message-State: APuU4Z8JP147ZVFfhfeNKCCbsR249cKi5zz3FmrgPMrTlvUPBe7Uqw+5
 J45G4dJxRuLvWURWYaNMz4YClDj1v0qb6zZ+cAhGbRKChxjdNSTCzoWKD8sdPauT3vzXWXx5/SI
 vJrAwEjxD2BOF
X-Gm-Gg: AZFdTZc1nB7ZA0yOOn4a8w05KYfCulc2p5clVPRZbq7d+4pgwAxOohiILgCf4t4KGxj
 VlPnnFFPqyjKRj9hi0Ts6R9l4IrmSd65OGoeeC4c86xU6ztK6ivGlNKrrzernIVY3bI84NumgBj
 44kNpqB5ITv0oSSxnzCAFoYxLDpO5iy6Wxk3VD+R+u7Ca0eYNyjM0dhFGyIvMm3OMclszSCNhrs
 D7CyBhhDJE8p3ffJD5l74o3b96l6eBxkOK2ikL++RpiaLHpo1Xk58T0M5Uw9s7kUKqDXhafSpIk
 lnuyR5loycPPLb/zUcnn/EajyXALtFut2DRNh1cBPW39PIu8MDZ+BO5d7+Yh2Ms5C9O0rmOCcZ6
 BEBKRgh7RYeYRM7wy8JxkZWkhdgJw4RkiXptHA3llyjK0rlusfaxYx1KWrZsa7AD/SKuR658lq1
 ShPPTqfHJiVwFlQHrrWqpKBkco9Vv6aQI4hn4FSETtFuSuMeM/fhL51mWWYb+s6QOe9qAG9Q92j
 +cE2yBOJYTdn5vehFs3n7/JSe6IxdkFU68hmqVaXkC+wF1rnRn96SVdkhdfUOiA5uogzHOwxnju
 bkJ142SR9enWzBei4n3L21bQTNpsjQeGMCSdxdsYvvlFepR6d9uEb98QGSxkgnx4qLTkzyk1Yui
 Ij5OVQAk1P+8Oa2cSYAajAZIAiONeoLB99TtE60xsLukkgxhJXIY3boKSqssojHjQdCd8EvWUrS
 nhsMwG4VvDKz/xkHvnTHQizJgwwzUPNlH19p1c/KZ3woh8M3wtL3XnHB4=
X-Received: by 2002:a05:6820:1611:b0:71b:1c49:5f22 with SMTP id
 006d021491bc7-71b394ac401mr19419921eaf.42.1795796975084; 
 Fri, 27 Nov 2026 08:29:35 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b865900ccsm4746056eaf.6.2026.11.27.08.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:29:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 3/4] Dockerfile: Be more polite in two git clones
Date: Fri, 27 Nov 2026 10:26:28 -0600
Message-ID: <20261127162927.3545062-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127162927.3545062-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When cloning grub and qemu, stick to grabbing only the tag that we
intend to build. This both saves time and their bandwidth, which in turn
makes our build more robust.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Don't touch mkbootimg as we don't use it, noticed by Quentin Schulz
  and add his R-B.
---
 tools/docker/Dockerfile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 4ec68eba785a..9c1fd21884b9 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -158,9 +158,9 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit, and LoongArch
 # 64-bit
-RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
+RUN git clone --depth 1 -b grub-2.14 \
+	https://gitlab.freedesktop.org/gnu-grub/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-	git checkout grub-2.14 && \
 	git config --global user.name "GitLab CI Runner" && \
 	git config --global user.email trini@konsulko.com && \
 	GNULIB_URL=https://https.git.savannah.gnu.org/git/gnulib.git ./bootstrap && \
@@ -244,9 +244,9 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
 	rm -rf /tmp/grub
 
-RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
+RUN git clone --depth 1 -b v10.1.2 \
+	https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v10.1.2 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-- 
2.43.0

