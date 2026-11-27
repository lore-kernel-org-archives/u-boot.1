Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C56606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bogNC+Ru;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjT32MDo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B728640A65;
	Fri, 27 Nov 2026 10:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UzB2FJL7q8Jb; Fri, 27 Nov 2026 10:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13C8340A73
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775546;
	b=UaVfGibFw9T85ce4IdoXeILO7oyW/LdP+RMp1tZOaBC8oYkHHALlxRJVGXQ/Z3xHfiFU
	 DiCy6i5VJxDUkHKWnFgC8f7zhaNmGOpcjJgQgtI40X9LcvVLA2HT0rEUy8xl6QxritqzG
	 ka4zBCpili2PN3wLVj09y33zbPE8Mus6d6BDiG1g3SIa5eXqj9A2Y+LMDyJNOcMGZlfyE
	 wRPoRUned2bVkQUAnfiX0Tvp07rt5ozHs0O2Wzpptr5mcZCwelfHjsnwptjnvtRXHje97
	 O9SaBFlmCBXEamJ6U1hyli1ZMjAzzUWttX/06BJ9zyfjMRpHwpC41LqXLq1NqImki7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sTfV9wqrq5ldAqRfp4c3vIK69BI7poiM+Xt/BvaPQNQ=;
	b=qI91PnmCnktb9NdaZbB2xWAze7vEwX4rkF8bXNX7gyTLFD7wp3oK+qIW9WtAe8c5hbvo
	 J/n+Nb/U6kNLElr9dcATDNLIHAadQD3j/GAs+SlNVb4Gv+nUiuFOZOHV6AU9CF1Lxa34t
	 YhuFlOz00ST2CFp4I9P2Ny5ABNvLUxCLdM7L8k85utuWOslhBIs7FT8AT/hIO4qp2CFeo
	 vrsca3yNaLLOApQKqrXagNg3YXZme9wleywdtO4sjgfAZ45fmmn5u8FSEAVkD0c7PZzLz
	 MpfgcU4B3xsIkO6LoVXCBNKHNIPPUpvFPs7L+oOdUVEdNMV+6LTdCkDzENLoeqZ9AVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjT32MDo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775546;
	bh=sTfV9wqrq5ldAqRfp4c3vIK69BI7poiM+Xt/BvaPQNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bogNC+RuzudmSNkCsdWCoTkiUZdAplbTLbmbROBeDBFAQ200m9uHzCg2mnnEupf1G
	 yo4bAxTNNZsoMlH91DuMVOpR623EP/kHvSFl09nKlT+v+1ZDIbpIlpjM16+8mdtL08
	 zlacspqgvvPuXoItONKHwyTWXv0q1HyDp6xj/yd/7iYHBSFxOkPzBqlGc/V94cCWRy
	 1ABWtdP90ExdxtJE9WJMEtyH4HTONJ5lLfACUaSiqz93i3rMIwWkPHz37aq52XQtBo
	 R3eB0S3VN4lWgJT40WPoJ2MDeyeiC8FZG+vPBBlG0vwx0puGD/QKQ6G4XFRgbUMaMl
	 uELlh3DeyLpww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13C8340A73;
	Fri, 27 Nov 2026 10:32:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03A6C373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9C5040A65
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wuXIgwyKfyjU for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45DA340A73
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=TjT32MDo
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45DA340A73
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:22 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-33fb4680717so4488171eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775542; x=1796380342;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sTfV9wqrq5ldAqRfp4c3vIK69BI7poiM+Xt/BvaPQNQ=;
 b=TjT32MDoT6Ndd4CR8gjortZnX6ACax+BPdXp+2WrbG+bVJ9FtMxJTAgr/CWF3LtSDr
 9leWzxJTMrBA+lXVVtUEZD4JLDoe7dFi1FJEcwCUOqsA03B8DP+m2lhtinajoa+pP0eY
 w1pUHOPBuvUQ2Ol3I2O6FX768XtjO/0pgVeEbhcef7LSc65CrI1nSwGegoO7e5U4clV5
 cdz/bQLO3Jjbl1sFUxdHQSXmN8VEf14YxUxBVRqIw9BMkteLwUyJy8gwt3GcHQyQxHDu
 Cd5FJ81kxjuuHqfIcYvnsM0Tu2cyS1JE+RzAH+/YE3UKt1N6MeBBhcBRmgah9czyWKnT
 i1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775542; x=1796380342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sTfV9wqrq5ldAqRfp4c3vIK69BI7poiM+Xt/BvaPQNQ=;
 b=c0NkTIxmk1eDHk+xusa6dc9bx4qmbLABhK2LVDdu1iIAT8e6zNqb3joJ0E2RhZZ0Id
 fdinBJIXFDSJHf3xPY+a+mYC7NLSyo5r8pogMMOe2qr944/leA2uGXdNO6kiC5XoOE51
 OvAvcHsmusdJj+8RCTvfjNXt5kYlggccaq04vlmpyHMPViDe6HthXNKvfXuC05SdMHfH
 TfX+pdmI+J0ldOMn2T1V2TE1i67iQS8K0g/zmEflCIGfvPQJzgsIOFTa7SHoeyc0REgk
 UT4BRPsW9Kg58NyNvV14TrZ4yBEKugh9G4u7tIPk8htjoVxmR675w1XKBH6CKoUKyAMv
 AzAQ==
X-Gm-Message-State: APuU4Z8ZZHlbWqV1zLO7FBG5wBdtd+QXbzdkl+9bb0HGJAzKFbNjChch
 E+cj5Lf0ZK5uPyeiMCpSwE76aVTVacEdLP6L52nev9zEwo61yhaF2nCwWa2Iaw==
X-Gm-Gg: AZFdTZdOuHhTgUx0+8vYLJZ9KytnD+WvgvqeCxnMRBI0hWSbc1rTAmH+El2pvoGkTr/
 RFRDv5UEg0auBIOaMp/02UKV1bj2nDxS8z3jKDxpg8mA8EwgGsh3TmICPRKDbpCdEzvinb4baFY
 FtU4AOWTr0aUxepE9xYqvL2G8OS/RRDQ1zxDTOk0zMR+un+PNcG9BdXk/LKZnFtURYFwohgLGOd
 mm3WHEdFbtkSQOEq+qZP/LMvocfu9soISay8/H3TY3orR45MU84sVZsla4vNTLCJxtZ3yqd86VM
 Mg2VNaHzb7UYwjY2wx/ffvQzFX5BpwFpf0iplTEHQtrSNHwztRmWwW05rxqgvVGgjEHfWS6XEb2
 ZFAxGRdivIPuubT942WpyXtk9GggpbXeqxSeZ+GpOdDYpQQolI1yby0WOmOz5ulOcxeaA/po9Oq
 j5md9uGL3KeF01FYuqpApSj7EkYqu0W93O6G7K0k/B8agLITsdob+qNyX4msJWyKFy8uo0TpgM1
 skZRfivI1zKHmgx8aOt0exV8AcEvDLXew5pEH6pWdvjOTXS2rZHwt1Ky2sKOT/6uIS+Kt2X8jFp
 nD8zU8m9ep7SXsZWyCDtWamvlVNs
X-Received: by 2002:a05:7301:240a:b0:386:cd71:b714 with SMTP id
 5a478bee46e88-386cd71ce89mr8919682eec.35.1795775542083; 
 Fri, 27 Nov 2026 02:32:22 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:32:21 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH v3 12/13] riscv: spacemit: k1: Enable uncompressed multi-DTB
 FIT support in SPL
Date: Fri, 27 Nov 2026 10:30:11 +0000
Message-ID: <20261127103030.4647-13-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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

Enable multi-DTB FIT support in SPL for the Banana Pi BPI-F3 and
MusePi Pro boards.

Use an uncompressed FIT to avoid allocating a decompression buffer
from the limited early SPL malloc pool.

Increasing the early malloc pool to accommodate the compressed FIT
causes the relocated DDR firmware to overlap SPL global data and
malloc memory, resulting in memory corruption before DDR
initialization.

Using an uncompressed FIT allows the original early malloc pool
size to be retained and avoids the observed SRAM overlap.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/spacemit_k1_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 8e41384a3e1..5b1153fa63f 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -69,7 +69,10 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k1-u-boot.dtsi"
 CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
+CONFIG_SPL_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SYSCON=y
-- 
2.56.1

