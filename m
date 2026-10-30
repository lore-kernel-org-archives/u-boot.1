Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB8606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pnIUioIk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YnodJiVG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F08810D8;
	Fri, 30 Oct 2026 08:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wMJS-cmu2K1h; Fri, 30 Oct 2026 08:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4599810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793348085;
	b=LIw3zucY72wrDlRv6ZNsFvLDeOrGW82i3agjJbcvbREaFuoXWzGhulxk/KgFqLZgc66Y
	 RBsr85zSk4+itXhCwTpLI5E7+BZwfNN3KbENV4q7ze44DJD2TOIgxXO2NvW63grsmZRd3
	 bdasZRpaQvpheDRKJW2byiC/fJ5A868KQ/lNw1rd2SjrMNXk+Mx+29NAt+xKeK60QMSbR
	 /DGN+eTs9PA6tj8ZeQts+xyrJUMYMvFkZYpKCFa98p78cEenvBUEZ3jPj+b4B6TPYT85V
	 qUIEVbE+Xjx1kyjROofnZNrjW19hlfO2LI5rJXR/5nC/PZ/VNPBtFeAUpRiZeSS72aQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793348085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dFlIZh4AGzuJRcHOMjJ/OhpJxpOlvJCjcQ3qMcMmMPE=;
	b=Ullx4R6qttcL7ra+TjwlhhW6oZIdONiANQjaCqsMPAFmy1y5IYU7Ey7/l7aaUKXmp3sN
	 GzqB7pPqY5PZNb098rkYohQRv7EIarvrTicYtsXEPHuC3VXKbGbW9hPw9/6GRZ9uY7Wla
	 nIhmO8HjBvg+s6Op/iUdpAAiJL334EGV6yhoCcocscJSXEbec2er6fql3rnKb8Vh8DhVG
	 cfnwYWgRd8Eo7mVuT3nLn7Vu0H/Ev4s3uD3PqlJ+w+hkAZjLQXw4D2iPo/sYxYu9mcsBn
	 n59CqXpYzuDSSC+paZzUsAphY63pw7ecztquIdagsBMzXQ67WYD5fOuBvOosgcPErOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793348085;
	bh=dFlIZh4AGzuJRcHOMjJ/OhpJxpOlvJCjcQ3qMcMmMPE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pnIUioIkVGPlPBCVLdrb8P11nHSpfprHEY/pGKrCp1VcX8wIBTzX2KdqUUHPEti+I
	 F2BhGDBL5+zFwDfY+XskYgbr25ufwAXArjs4p7XGIRpnjDWDeT6w59WANVXRAhduvU
	 tdNgpfAlCPLa9+wscTBTi2K23MkGMrtG39YVOqLy20GbabcbU1FtxVEYpLVsEwx9XJ
	 qttX1ffuFAxeVxzPAOZIdfhlARZeEuwNgH+GApeZQOoMtDRxdhDgXi1BfXFHXn/lwo
	 nLBn+FgGrMKprFgEkn8WrGhRn1LZEmOpTa6j1Sj8PCpMfTO2gqK5Dwc0lobc+eXRYw
	 TsPmDN7bffvgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4599810C5;
	Fri, 30 Oct 2026 08:14:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72DEF2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5849960679
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10dGCoypnAPG for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B72B660650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793348082;
 b=jNGf6Fiy7noAJ4uFDnviGdxuv1BhMd+Qw6OgwfvFHR2HLxRT1/jGftv0DospPYfY1hHm
 gOnu8P1UrxnFqr5iHkrfpjpJKfIyvBJ/BsRUtafkLGGH1DDckqHB0aq4FnhlM+QgSoDm2
 9JjQH3jq74sZl9ECVSYbWvXBqfqwU8T2xub+nbCO/MLWRFt8Fk/w9rP+CGq3HPhImFjp7
 MBe3COjXTA25RB4VnUBasuSXCEhbOlyORZ16jIzT8VN5YxtkpYQjLKdVoyDgy6sgHZBA2
 F8x/ynlczqLXlElLRdrzW3dUyXpFSnjwaoVVr+hN23TtvfcvT4CpJXlAQ77H/65NHYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793348082;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=dFlIZh4AGzuJRcHOMjJ/OhpJxpOlvJCjcQ3qMcMmMPE=;
 b=OXVEIAHhjkaRotlmf0BiFNok2jfbqS/nA+Za/ZTuvkPz724MfNgJHNzYx08o/+0atttG
 gm6hEnJtASeZVphVio7GUW/V95laBUcLbI8OlBbQQlvhO7EL7UBq8Ob7/O2QhR85IyjrE
 UmuPeAIDtq2MiHpQseF3DNDONK3Lcz85Yn76XDKSF6EDrSvgYysnwxOrVaiRy7H8G19dN
 VtllM9eVDgJLQAaVA3ZmodMpRp88XmgL22d6+LnNniqZKuc9JkeVOfgHZE/VbgtQ0fBPf
 28hFauREfLZIZHX5Dr90gKwpJ9SZRcpg6Vi8UaV4+PTYHF6mPuhl5ccWkgHYRGm7WDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YnodJiVG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YnodJiVG
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B72B660650
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:14:41 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so904392f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348079; x=1793952879;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dFlIZh4AGzuJRcHOMjJ/OhpJxpOlvJCjcQ3qMcMmMPE=;
 b=YnodJiVG3p3cUZGdOIFfxNdJt5ChAhoIrhN/EH1jZZrZtugbuiqEJxLjFpLD7jvw81
 NI6AGGy6ULrrqCUu2lHvgN3+zL630Wyrdm+QOJZcmZHh6hNfwMoEtJ/YWTxWgLmBFqcf
 WlrGCtwRtJZbopJ2Se2+81jiyYPFso45Uy9giJ4GM+Kn5X0UPh2QI84i/GvCe1EMyYyD
 p6DQOP8hTf6H4sPGPx0wQaPkEuN8/pYaFf6sej4x37PBeTsCvatcDpCrf5O5MMBDI3zL
 Q3Ax2l0ON+vOldnga8syONyGxp3RLFM66ItVqyQdve71pWgYwd3+yntbGe/nzUxQmkId
 UrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348079; x=1793952879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dFlIZh4AGzuJRcHOMjJ/OhpJxpOlvJCjcQ3qMcMmMPE=;
 b=zP7hLsVU5E2LPh1JrkGA6CrZHV/95WierCsi39KCEY+AqDqfRAC4oUlU62VAQacwIa
 O2W4LMQqZzA2/2MxCtgk75cEQoTYvykFTA8SYO6JdhkIT4wYW3XUUvqkNeJCmdrvayp7
 YOAQ3DCojoCuyfATPF17o+snJ7BHRC6yhM/mQQrvw9SSNuyEPIhEtr6KGXc5uYUwz4UJ
 cDK14sXt2in0XF1xoxYff0WRHVCju8HpdQZ4pG/2iBUl0ivVO89208nW8j7y6SRoAHP+
 xu9K2C893j6gvOhLwFTYRabRGyf6hndIjs+cueSJ4zKNT5dXFCfHpE9mS6To44koOd6Z
 upsA==
X-Gm-Message-State: AFq9FYJagloxqk/sHsqMs3YdNTGlh2z/7/r2zGkRJL1ojrC9WJ+k0y4S
 ng3j0q2FT+pwMHDiCVnBkCSWeF9E/BkFmpFB2o2rSWa3TDk9FwIpEBJ1lgbxb5M2
X-Gm-Gg: AYBFou1ULO9MhzqVYx7wscFOkkVhhEIlkq/4fUpaMBsV69wbJdLBVsX6wTaNpKjD+lF
 HuosV1tkeqWQTtCVGVrY+sw4LOMfcGQvu+tQUtlD5yTNhspM4dOrR+GVVAoM6YosHu5cBFb0HEg
 T2GFFYdEXenpD8SEX24+BOPOtczW16MZoA9vdMFf/5iC7Pr4rQdNFl+KcLjmaaU+ENZPQDvkme9
 GeVy04eRWVadbwiWNWmDr9zT1EJ9knvXPK1hsK81gRKKLjVJnPkjckulFaQRZAK/teoc5ltn409
 gbA3ZiVLsyvtlOPnPaWweSmg+Bg9HBrt17fgEjLgaOvhFbeBLC17Cy/gY/VAKksZx2npmkYLwwz
 jwZHAAfZJwOW8TnPx56T20uVFffcjsD3jxa9f0oB3fEgxxgIrSva0JZSoDcMH9Z5F7Kg1DffbMP
 75c/UjxFsZzgltTIEd8QM/fbRMq51xMoCfyKIHP/HY7FtE6cIR5oNAIP3DuhsZww4h9EtW6BSXi
 4yUF3c7P/LTHb9zkvrgoyccp0QdNIbW3Uv7An9+MX1QMhyJbXM7haM4xgal4dbxUXL3CSNyiP8S
 jbtu17cLdbBqWWOldvF4qD2p72XyAxL4t1tu6IdpFf/JWT7/gQDq9HzrHxFS118N+VENYpb5F2o
 BF6CKW9ql1Yj7Ymg4pPOqus3aiZMJm+KLv9hNCiimbr7/dOag/ekuVWDszMHTrLhIV/32KrQHVv
 hsKCaMTyj6SK9qbtnW5nRLMx9BiPa3eBBb16sn7kDX5ghyDHHht8NQqVo=
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4ac17567cc8mr29534755e9.11.1793348079165; 
 Fri, 30 Oct 2026 01:14:39 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-f0b4-1ae5-deec-a097.ipv6.o2.cz.
 [2a00:1028:8388:a84e:f0b4:1ae5:deec:a097])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf723b5dcsm43031585e9.14.2026.10.30.01.14.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 01:14:38 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] Azure CI: Build all host tools on macOS
Date: Fri, 30 Oct 2026 09:14:36 +0100
Message-ID: <20261030081436.86780-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The macOS tools-only build does not include kwboot or
gen_ethaddr_crc. Set HOST_TOOLS_ALL=y to include them in the build.

Tested on macOS 27.0.1 with HOST_TOOLS_ALL=y: fails on main at
crc8.o and while linking kwboot, but passes with the macOS
improvements series applied.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
This goes on top of the macOS improvements series, without which the
macOS job now fails:
https://lore.kernel.org/u-boot/20261028121258.572-1-pepe.schlehofer@gmail.com/

 .azure-pipelines.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6..48956f81c1b 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -52,6 +52,7 @@ stages:
         displayName: Brew install dependencies
       - script: |
           gmake tools-only_config tools-only \
+            HOST_TOOLS_ALL=y \
             HOSTCFLAGS="-I/usr/local/opt/openssl@1.1/include" \
             HOSTLDFLAGS="-L/usr/local/opt/openssl@1.1/lib" \
             -j$(sysctl -n hw.logicalcpu)
-- 
2.54.0 (Apple Git-157)

