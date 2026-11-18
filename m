Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C406606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h9mLIg7h;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PfqcbrI9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 132068123C;
	Wed, 18 Nov 2026 17:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5si7NNVNG8Ly; Wed, 18 Nov 2026 17:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D57781253
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795024041;
	b=p3fROFhl/99khd8K3+jCgaT6k4sqo8Txu6C+Yx5t9wyeeNmvgzCU6Rb39/3iuokChk7P
	 N/kXQimVR6pYDPKHqNeA/9IEI7wrs09K9rUV02lVpjGLcciMeeQND78amySdrIzr5PRi3
	 zHx4JUrIHy2jVnxZsoPdd2JGoN8FiPpZ6My5G86sKzzhBmykaZ5ay4KeknDoRTyl3tvHt
	 E/iwlpQP9UkvIs7p0SNDknaj3B8A7CVUoZJbviRt+kshTv1pLQ86pXtXGiSskgS6z2OPE
	 8D8uTKYGtlDFNuVoC/BetKIB9x0t4/x5UXrKb1WHlMsgHbMeChjOE60gfxBRZzNqw6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795024041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NdlQWJnIeD8JH/5VpbNk8sMm166uSUIeP1gC5h2bmx4=;
	b=hWfucRdvp9peTdZt+YyK76FRCzgIburtemXCcUQb5zHnnvioR7zAaUojgRvMXqltWWA6
	 ElHnhdDGjrjoUx14FmZX65/kY3J+XboDqlxLbzzQKQFtC/zFFw2IRADy5LJlxJgV7Gla8
	 jZvkc74wzrBSWIwI6JdKimEtsqy5eda7h87Ra/Bz9jBwMaewMCGVV9ewy2s19QwrW6Mtd
	 WT/SyA9/Kq/NZZFG9Vs+V3SwMO+8LLxhNPRRw8LXCuN+SE5rfZB8o0gyfvlTXaQaUcWh4
	 MVoZiSC8Y5GWYIdhfQwvMZcQ1z7A93rgBMMn85NmhWDLOVHFgo8p25LgUind2x5xNMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795024041;
	bh=NdlQWJnIeD8JH/5VpbNk8sMm166uSUIeP1gC5h2bmx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9mLIg7hNNW3+X7Dm28sTvPZnpTRKstJfLz+kD8urSy4EnRkAOquKSSo+JkaCn5vj
	 KCmgGENxsMAVcNZU77KEyxMCTMeY5O2veTpoUt8YMBAa2Ni7+o4UXCPKXXo5D87y7s
	 E8lXTkub7IgTh7gThcF2OAVIsR0j1NA5XbmKGGm/4alXqTG2igkRfQxcwtEs+aQ02t
	 KTAnq7Bd8aw5c2mJVo77K4smhrbRCBV4W1dX7kBgBEtVWzYE5UGGd9vxN4LHUS6jyp
	 QAwtjb91aOiHDZggWQHV9vZySl8rH5EvATyx4TQFXRMtJJbKXnPpj9g9TIwPS/CYN7
	 +BR092pbKZlGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D57781253;
	Wed, 18 Nov 2026 17:47:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FA2949B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91AD24009B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ghe6uJ6UqA7Y for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9BF1340095
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PfqcbrI9
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BF1340095
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:47:16 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so13929855e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795024034; x=1795628834;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NdlQWJnIeD8JH/5VpbNk8sMm166uSUIeP1gC5h2bmx4=;
 b=PfqcbrI9cjHWWHRKt6QekufIcw9qok3+/kurAeBRMCkWTtSIfrCbXgKZbxEzkTf2AO
 paOnFXm+3Hx+Ktv3SUk+8h2RicPvQ2juYAt1jg53Tz6wCxOTeOALglkuTplnZkNRYinY
 cdnnIYyOPqhECImMati2lUeNib0pGt+9A6Vs5/ZKA/Kpu+2syjosAKsSl8pBPi6cnyxK
 tX+Dsbr7kuD0ibn/1h4LokMoD8uKvq/pU2nm8L+qrCqtwKii6eN1tzmIlF0XeEa8Ba7X
 PasdRUR1PK07ENKxxGhM4lJ2pqecnECpMR1pH89NPojYXdjFx+D82RLL1lH9NQuzHeOW
 0efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024034; x=1795628834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NdlQWJnIeD8JH/5VpbNk8sMm166uSUIeP1gC5h2bmx4=;
 b=Ykck28nu88nx+eAlh1FE+Tc4ylaKfpBj/iVXnOaf8lidRQ2pNUEOVK6wA+gY8wTY0M
 RRom59U+j5JBkDKxuqSPKYX4zt+hlGwz5j6UtJXVc2sGPMc5Llb3ZDEDXm9f2KQ2yMBA
 TQau8Glddy+d5zdckq2HV+QWvnktjfVrXdb6877pVZB6vQ8JiQz0kM0DZPyUTumLtM99
 XwQLiqZqO8aZxKmxBFJNzeiMcQzSF9edmgoZSPv/BsqB0bKir4/OJyvH/j5rbKIp/s+A
 mUzctp/m1YZc8WO4o2qkNU3HvIn8J9sNIq6pSV08z0rkS9YLBXln2IvQuj3alGuczXwi
 IAag==
X-Gm-Message-State: APuU4Z83blhnMrDYOZtsMozfk4EGtJCYP8SeNz9xQanxtoj4XrdFp5dH
 PeLW8O8DY/72lyDNr7vDkdXb87OQCgk88zuyiIEHKSKIiu2feQMReSQo
X-Gm-Gg: AYBFou0SvqTjGsVe3FFWf3dedM2EzsPVkheejuR7PbXMG+RwZOLUJBmjdlhOjXBsRYl
 O/eQv/huekFf/EVWni3r9sdpwhm1srJ7pfpDWcmDFzfm2eyBcrGVI78m2UOOpCzGUmbOVs9j2oz
 RKTkSfkNQxuVCoc1a6Fq3nmlj6BHPo4gDppSPtUmOtfloY2+odZBPQnuYEpp/cVWmiC3mnZDfwL
 L13OJS+uJbRGdYb0dhW7wVAWcEQNwNZv8cV8N1HWgYH/G5Z5zMrNbTrVxgWaCzAM4rr/7Jo5N1I
 RidY62PRhN+QupsZnETZ3dQFjXpf1eanqArPInQZYMDOrjmSqmefRydIlcuhHx0xajHvD5MhWog
 9jR9kgdEYW3c/v8PONU/XwFFbTZ4C5aTwos9WTxeaDSfvNuMBm/WEgsijSvoCmp0B3PGw9x2jNv
 lpX6zPfsflr1z69+eMEaO6S2xOvZ1kllkhBpalGRKZcNBbnQLGRfXL3XAUR2mj3NSXxANoHfrbX
 oAAY4xicoPrZ43QXnzPHXqp6M4AzUZIEhJN0iuLh8J32nJJ1DsIXTivH+doz1BDSn4PWvfDc+Jf
 ZI1WUUFC9RNNxDbhdSZOhZumjRZQ28bminzn5OwBtU9vP0DZ5Y7abHnVcGxSWA==
X-Received: by 2002:a05:600c:5012:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4bb7d6d1e08mr69290515e9.4.1795024034258; 
 Wed, 18 Nov 2026 09:47:14 -0800 (PST)
Received: from [127.0.1.1] ([151.51.238.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm6302789f8f.43.2026.11.18.09.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:47:14 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 18 Nov 2026 18:46:57 +0100
Subject: [PATCH 1/4] Makefile: Drop $(CROSS_COMPILE) prefix from LDR
 variable definition
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ldr3-v1-1-6ffe43aa8c6c@gmail.com>
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
To: u-boot@lists.u-boot-project.org, linux@analog.com
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ldr tool is neither a utility part of cross-compiling toolchains,
nor is it a cross-tool in the sense that different versions of the tool
exist to generate different LDR format artifacts specific to different
targets.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a9cc6ec2bd3..e7cea1be9c3 100644
--- a/Makefile
+++ b/Makefile
@@ -459,7 +459,7 @@ CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
-LDR		= $(CROSS_COMPILE)ldr
+LDR		= ldr
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump

-- 
2.34.1

