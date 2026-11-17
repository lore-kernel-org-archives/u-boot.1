Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EF606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nUzxC1nx;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsU+r61R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 084816082A;
	Tue, 17 Nov 2026 00:32:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QU5RE3XcPvA; Tue, 17 Nov 2026 00:32:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51E8A6081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794875564;
	b=n7+PaLu+XF1zB2SpIwZcZS0QyRLQ2CeOZkP7YuQzeCL1cguNZEWlapIw5rLDexMdmSMw
	 nyvll+mfV1/SmheKNRuI0iJebUufPP310T7wMPm8Lgm0p5YY1VGSx+dlQ+YahSPp8iI5a
	 Pk//E6YM5pj6/SmVqifOmNzhLuxC+PtjM1khs3H8bkpAfieMFC0/7w3gbDDM3ewSxZAKd
	 qE23OoJlCQUEzTjv/e7nw3VDNB5C2Uh1pJscwdYYQy/C4z2sCgAK6pTuR1cq/zfz6H3ZK
	 NaIF7xfrGdKx5LBC4IGfC9Uv+Qrnc3JyGaExSYxIjuRXFF9eTeHn4z9Phjax/KcQj4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794875564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fR1h6wq0nLMHnetrMpuY50865E41FWLghdDCl3FXh2s=;
	b=mJj6ISFyAZw48BQOcfvX9PE8hR2HITIWqiZxitK+EX+vsKEjPft3SmOKiy8QD3Ds4Nwz
	 aTK6xZp9ulwB4oC9VH2AhfZceZ08K0wWZJ1d41w2lXmry/DuOen3aMubueoi5CC5bFW3r
	 WZVUo5HBwHRFXe1fx6hVhL0JZW2P31V6wh+qWU9YflKC/Zxsr1rKwooDDdlw1Sws+Gp4n
	 lsU4bOyR3P4DBZdFJvYxH285KpLY+dqDOKtb6LH6GQsaZ/vdoCneqhZJw1FeRFw2xXoIz
	 c40T5qM42ahrryof5EZvyLQzmLnc/+l2A5qvW2LI/2AHSmb3Kxq5iD3VJKzgI23Z9eg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794875564;
	bh=fR1h6wq0nLMHnetrMpuY50865E41FWLghdDCl3FXh2s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nUzxC1nx1DYtR0sfp0DzSxvw8Q10R6qHnFH9SuiEtgCK5aiIE9/2PpN4y86ESEsX1
	 zmZ2AbhpfxFyWGKODaSfrml10qFrNeBJQ0UNNf4g2Jr4uolA2GO9RIJtgs8foeGU41
	 KOEssA+52D0ViBOSTzvmTe0b9bftpx7eMx/dAsDWtNLYvBSl/i6YJ/ldykIoWc7nAS
	 rZ67g/dZORjKCVEipqYTSdspf3O8HRn2TnmrVUxLm8y4Ly8TVDnq+Bbizu4r6P3Oyo
	 YAUmzSBPQwqY7MFPxN6N2WU6qjZPGWlo9s9fPvBDDVW1EhtCkSb8hCRS890fCn2GK4
	 Hf+Lxq5La4VUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51E8A6081F;
	Tue, 17 Nov 2026 00:32:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 068C370B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC5E34071F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w_2MGZzVZD43 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 00:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E4034071D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vsU+r61R
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E4034071D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:32:41 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso238428a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794875561; x=1795480361;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fR1h6wq0nLMHnetrMpuY50865E41FWLghdDCl3FXh2s=;
 b=vsU+r61RRItTeABpwUD1abu1gIMg8WQqcNikU0tPxLEHZI8tpzP6zL6bhVd8AiuD32
 MD1Vq5Z9EFfvjTCCmirH/p6i5i76Muk+ksOHmj8jCJ6jwA7EU3U/9Au9DdN/X5uE55YP
 Kn6KOkmXSmd0mnuIDAPn2ixv2G07M/WJR1QIHmEAS8caAH6Ul156E2Z2Ap8PsbIKg6uj
 IwenSA/OmzDOxibz8zQDutwtLaeMGmgVTDupZTEntuSh6DEGs9IGxoC8LoyVVimCAdl8
 Oefemi0clTXzscGCLkAr6LOFUBxwPejSFPrFwpQvCeWRUti32LUF6i2IWZnQPrXNv3AP
 P4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794875561; x=1795480361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fR1h6wq0nLMHnetrMpuY50865E41FWLghdDCl3FXh2s=;
 b=gMFcrIE37hNBEsQLZrQ3qJXUEuNBbQbP6PVTbHUE9HKdnfC1HtvR6TxjeEgb3p4uUr
 8Xuxw1302jBfuBA5XW3kgzbecf7hDU0tbZpmKosLThsfwVCp1u0+qXkkZ5KD5vOlJAVn
 GpsYQGHW0fQ27fzeQ5oZ6zkQoyT/QeGAm9XJWIDqSluOnEnCXaeME8nuHGYvGbC5GQeW
 cbWqCL3ASWj+Yl3ob0V9zbV68b8LFCo4EknGqNgRonDwnYem/U3MJE2LmWlYNwTgUQ4h
 1O80GoU0R+5NmIGKRTqhGqFMHwDIalxxbT3dfT6Czab/sgyL+h7coUbtzwWAxcqCzdxY
 Vr+w==
X-Forwarded-Encrypted: i=1;
 AL+hErEp6UUjTuqNAElTBq8Br9Xqr3se+QKrmR9zmk/x/yvyrX1NrvM5OqOSPcWv3Iz3Ezy1KTUqMaU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+AmyU8vdNrmCZgHztfm9NlbwuWy34k/bsIIbgqJ8sSEfJlm5AN
 neK0UJ6kYC+eM1WOHc5zNNlYlpu+MnbBSP7iM+x6x7NVBJyLgE2SrTVI4dRAMw==
X-Gm-Gg: AZFdTZfZoHg5wmYRX53iwzoSDT4ZEIUv6TYPQ7WG6AaHwofKq4tzQYhzV8S0N+DoSRG
 pLDZe2WD3gf1G5fCKZtzB2JZkErzCyi3HpHLXSSYcFhODl6Izz7J9ZqrTfnPMnEVRovypXIay9M
 ga5Wb2B+bvGWklKiip9Pch4O2qtPbe0rjfPbykAsHMmyGN7YpFMoI7m4mrxxsh6Fj8EJuNSn4wK
 WuVdc8l/jEUt51mEuu36KeBvpwgkiA3cEE2jYZizMmFDQ1qxprZPEeMsUw4cn3zgt+JD03OuTwT
 pZtIxik3Q/3rJe/dfxzG5D0XRjLnN5xLG+0BdkNzpY83byxXqg58Io6+5eOpuFL/FP9mRgTZ9Gy
 tSfXOeT7/nOnM7pL/Pg3AqhrDpnqTPdQQa3awgYDoq6jkAtpIRe+X2aq2fDbPS4C8+nSm8aMMta
 ex2bRF1yigvwAWOdgBUpeYezsGybGsDfinb3/PfeBjMRorrlIjjGFc1Nj3RIZUyGzYfdicIVi68
 Mp//HTUqIySxa6wvv0iF9o9bu/8HRJhSxVq91+KiUlOjxtn7bft553L81IA5y4aeC4Y9SAjejTp
 qqq0qWmrAg73Z5IF7OrCuxDZ7LkqV8VdOVzEzVLHu5NNCP85TnzmwJrALlz566LipfM1gTEcuig
 k5FNbr+E8ru5lglTftkwQbomkhfPhN3kzz0uO56AfN1HGlwaPHrzsEXoh77h3Y8WbLWHSGMhEh1
 iSgXLLgc9zEg==
X-Received: by 2002:a17:90b:1fc5:b0:3ad:6090:a17f with SMTP id
 98e67ed59e1d1-3b3abeebab3mr762930a91.10.1794875561097; 
 Mon, 16 Nov 2026 16:32:41 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abd063e8sm1229702a91.8.2026.11.16.16.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:32:40 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>,
	Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as reviewer
Date: Tue, 17 Nov 2026 08:32:37 +0800
Message-ID: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I test K1 patches on a Milk-V Jupiter and would like to help review
them.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Applies on top of "MAINTAINERS: spacemit: k1: drop Huan Zhou".

 board/spacemit/k1/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 93a5aa6677a..3fd97fb6ffd 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,5 +1,6 @@
 BananaPi F3
 M:	Eric Chung <eric.chung@riscstar.com>
+R:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi

base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
prerequisite-patch-id: 974bda77e7d5815be9f750da8c47c9d5cd1eb15a
-- 
2.56.1

