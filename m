Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD5606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ovNSPYL3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABgwKAAW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 047AB40D0C;
	Sat, 21 Nov 2026 09:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhOcmcH7mQbA; Sat, 21 Nov 2026 09:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50F4240D11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795252906;
	b=FPVjrdBMcbxaDy8+m74MJJyJXBHh/sUnKZz8x+AykEy5FHX5v8otyMzyRPLwLttPR0FX
	 3WUpIapkSZPYIr1jbUvzhdgqxW38iduIXhhzFLC1jFrCBEZ5yqjmJ67aD0jwjpfS4swWV
	 uH93WJM0/jMfYJgIwy7x4J4FIyrcmSUcOXNiBu7DyFGxSvjrMQJStgngooOQ4jO/iTv2i
	 iykJHBbXflIMDUmEfpwHIdb5lEsa0WEURN0ZPwpPkJdkBtI/VfdxqYF1KHSi9amkXTnpp
	 t1otShch+4xOrpIpsSrygunybS1eTkpipW1JUEpQE90WxZ7TEqu0rcz9ojZMToJQNdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795252906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PMZEtiK47CFac6Dn6ICRbwgoBC7N7YyJakyrjfJjTik=;
	b=IV1iPIUJ8AC0ZoYhVgUqZ54/a8BpLt21cEr7F7fwTB0NEi9E186ODlU4wxdh30kVA4ir
	 dHmJ8pAhbLzJy3s6zFq1NpsIYSFHyvrKH96/yyEZebV3Xuz+AaKgED9R8T3XwWQzsGjH3
	 vvwbQUACmJvbiWaRPu26zBZZK4Ee5QlXwMzSiRihLT9FaJFQHg1eGbqd4bnDa51BboVPA
	 gXLMKsfKCYZ85H9Q72GrnhzwAHSQ3N+N+PWXfn6WxA9SFLxkXv9OQMTlaAFfymRIkUJw9
	 WoYDndvOraF5AILkd0FJU6EOrMwtvvfuZLBy1MfkScrJP1v2YiAXw6Aci+jAh5Lsy+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795252906;
	bh=PMZEtiK47CFac6Dn6ICRbwgoBC7N7YyJakyrjfJjTik=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ovNSPYL3SoQEuO/gJNsf1ufJxPcfu5zAxT5cYudIheNdWP4YRoSzpRgqtezMT7l8k
	 VFq2QPh8MRs0dazVoIviSZkbjzPfbOUbL92bsQEhxnqbQVovoelS/0aphQ3wabF2iL
	 oMk/AmJTaKcqyHKpHdn43v6Ek03TyOrcyOWsb4KZoa0SWGqiBuD/K8AfAGUgiCiN+P
	 UuirpX2/srmAKiMF7TuOgqn2YZlTz2bJzcboRulXX05BmP9z5BX3CwlHf1KK84m84z
	 H0m+JqCsb3+pMX4lOdwMmS76CoWrEa8CaUBt7SpX+uZeI+vkdXi/v0cvEp9/NrkGsN
	 /lQ1fwiLQFyPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50F4240D11;
	Sat, 21 Nov 2026 09:21:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EA4D260
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24EC76063E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:21:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67gBForPim6t for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 09:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3052160668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ABgwKAAW
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3052160668
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 09:21:43 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so1026331f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795252902; x=1795857702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PMZEtiK47CFac6Dn6ICRbwgoBC7N7YyJakyrjfJjTik=;
 b=ABgwKAAW08DqamPH5KJapdBYgRYFCcBQbexq/mNGjFiSpfL8sNOhGZi7P9BWIuYaF0
 fwaZ9suW6SDcHXy0rzXbhAr9zIT13siMyloH0JFXUI1Hez/uPRSIpe9l5dmbFY7ofAl5
 jbEkuYl0Wvkepevnpa3cnRd9aKyCM/lJVzYpGvK09H2utqxUNmnbVCsY7SJAco9cqJM/
 G5bXZ4AhNJsTlNT5STB1ByAYWmLrIzeUCtlqY0l9+iCYu+jVcbz5jFaITxuswLX1rnkh
 HbnJdU0hM/9sHFMvFRosZFqfKNJbk8aO5tKFGBcDU/s5kHulKsdwdhRGp0SjF7Wsc23I
 JuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795252902; x=1795857702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PMZEtiK47CFac6Dn6ICRbwgoBC7N7YyJakyrjfJjTik=;
 b=g0zoJKEF7wSFyWnb2U2PmqUeYr6SWCC+pBR54lrqWI3+UH0tJbDbPi50QEihn62Y1d
 r6dEIy46mt777fJDN2LfNCgNqi9REeprT9lVYIiNyhfk0SzCOz04MSl/RkCTJ2YWbobv
 dP64wqbRLvpmRNzh0HyP4CGwoEp/eltF1Y+gA3pw/OcnB6xeTqt6Wk0J1+2IyCog/ZGX
 F1fb0+JvTvu7Sw/CsRDGvX8+FF2+8wrytq45Plfxz/r2xPL1lmfMreetX4OTvbd6gNw1
 Fqw+OsplvzeV235r5ZfyOe97glgyr4nyUmxPkYPsyWkEvYEZ4GhNqaDTpDCxQJwTEFKf
 0HdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGVmbq7pB8hzFaAi9QlSC+FG0LnMOPlO5GhVazYmywM8mjvDwX5sbuR5DES5+cMTHTukwlJ7+k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9jKKZ7/tKBmskVaG69mNaYlof9IB5MRoUnrQOg8j2vGfkgS1KN
 D0fmv0Kw4kGDfTuTmuxy27tKy1K9cmIYEPDhHBceJ8QFqYyByGwKQVun
X-Gm-Gg: AZFdTZfcgio0IfBopWBzFnjmxnvUEauL1UsM4No0VHXu6C6PFHnIAwXb2xSd6A+DMYd
 17IUMwBtlPmqWvn1e+E2vltUZIvtcosdcfD0KYB3hsvZoT8/C7iQ2U4N5nxFMrG6p0IIRN81yL6
 kLESJJldOi7inits4xLtaQtVAMIPHCX8+BpdTNTkCwlSswcEquCKUcYIFPb3H5/E7HSAWwA6inK
 v/pWTqmvj8kkM7qpfz5Bsc8Be4Dc+mLuKg6S2zFA1DuuTKpsEi0iErFZ/6eU9UUrdDJ+MmgoXIs
 +sCLKcG6P09HPplipbx2HG6/uCbbr4kJWomjcL5vjv8P3TSvioRG6iS/CUlRvonfkhWW3C5e89y
 uncaskWTOTJVlEqUZ+LOq1KIDKqL6woHXRnnzIMYagWAQ5gTiAMeF8FqnCmW2bOKrSxPHoYXyfL
 QNpY/fHX8X7VV+e+ubXyu/j4okA6nBjLjTqOI1lZdUN7nzIrev6/R6/WMSHS58hqxEE0ds6kEMF
 p+Wt1NkDXbyrRBD3qgd2BqGAlANZZpnr6vwwAHsSnyGJVDr8S2xvNLDl85OdA0hb46+E1mpf5Wc
 a4yRy0YdKkbA5eSVxtM7nTa40C3/FSJrjvXy0E4cQiv+PxRwl5swwFfxc5CXJtuxMOQliVmcifP
 rvk3l43SGL/KNn06+l0NEFTm+Ray+/jfQvBcGvw/eXT54kUTAl3dlhdvmXV9tTY/3j28b8t8iKq
 EONimqk5mAJ+j+X1pGc5JTpLOeBlmCIlhZJHF4oABNgb7++Iv47Sm+SX9diHYeUvCNUlL/CK4Cq
 huWCdw=
X-Received: by 2002:a05:6000:1788:b0:4a9:1649:9eaf with SMTP id
 ffacd0b85a97d-4abb86e5099mr11696081f8f.57.1795252901558; 
 Sat, 21 Nov 2026 01:21:41 -0800 (PST)
Received: from cypher.home.roving-it.com
 (95.red-79-153-226.dynamicip.rima-tde.net. [79.153.226.95])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm10254938f8f.38.2026.11.21.01.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 01:21:40 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Makefile: Move PLATFORM_LIBS outside the the whole-archive
 region
Date: Sat, 21 Nov 2026 09:21:33 +0000
Message-ID: <20261121092137.2797011-1-pbrobinson@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archive
region, forcing every libgcc.a member to be linked. On AArch64 this pulls
in members needing libc symbols U-Boot lacks (__getauxval, abort, stderr),
so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after
--no-whole-archive, as the non-LTO link already does.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 840d02aa6ca..4323d5ec701 100644
--- a/Makefile
+++ b/Makefile
@@ -2103,8 +2103,8 @@ quiet_cmd_u-boot__ ?= LTO     $@
 		-Wl,--whole-archive						\
 			$(u-boot-main)						\
 			$(u-boot-keep-syms-lto)					\
-			$(PLATFORM_LIBS)					\
 		-Wl,--no-whole-archive						\
+		$(PLATFORM_LIBS)						\
 		-Wl,-Map,u-boot.map;						\
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 else
-- 
2.56.1

