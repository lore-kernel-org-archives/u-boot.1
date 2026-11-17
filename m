Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097A606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ign7bhjn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hii2JtUb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC8FD606EB;
	Tue, 17 Nov 2026 23:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cs1dCn4atNQq; Tue, 17 Nov 2026 23:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 516A460730
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794957127;
	b=aockZZmayiFgz+EEH170HmO+6C3v7Moi3izkdq+VfCU20FbmMEqythGY0pNyQA7bAUzz
	 XATE1gvnqar2ICm8pfx3nCK+Nqndxmeu/nL6gLJioFIZ1g0fX95fVayHbBR8IvZM9lPDG
	 uAtl3pD0K1xxkNxtnO5I86LguCrxVMe8Vbi4WzzZCXb9o/Doe6RSw4404j6ylA0a6EufO
	 EEDFU8LBkhzSpwOuNoqSxqVVOJ3b8izkgjN1ubtGDjJUtZycKPsP5itWDCfHgxcrtAuuI
	 bpZBeZaVehZMLLZwPePhMnZfCyUhBrjTTRdlW+V4C/lgp67aBbpKx6Ipc5MOAugt2bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZS+7imKvRhI/mgy72HqjF4vhbRsxNAqmN2HpoXXwTn8=;
	b=jzb8WDcGDGIZ1/rQo5E00LkJA9FBcfC1aNHdMCrAU5E1KAp8qJ2KEnzVF1ElPh2YPLqn
	 KuWcGVOsL+qpMrm5UlE4eemxk5E7rE625CwdS7rxg3LlPZofPqFoX7s1zilnxqTZ9YAE1
	 qtn97+aAIWiXchObYOnsC2q8midqchFBoHisHMdTEXn6kvJFCgJNB7coy10+3CJWsz12Y
	 ErIqaAHszaZy4oBaObZduo1OiqU+yfu0LWXsADT6tlS6HSMYHKA8uw/8jBBoAb0Xu6/iw
	 pcAwaQ6NvEc76RNaus7gHUmK6YzSgocfloxgAprOKdz7i8d0xvPxSSnNRv9V5vf9sDg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794957127;
	bh=ZS+7imKvRhI/mgy72HqjF4vhbRsxNAqmN2HpoXXwTn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ign7bhjnJRNztTtkp64700hhdtOIj8kjm1ckdA6OEesbqby+bEwCB2SOfuD7qentG
	 hkKT0P2/BY6CdzZMQ3CCcC5YWOT5pdzs2u3T7UNCBJv75sq/Yk9zg/NcNKYZJVVHTJ
	 xBfbr2uleD/GVAi4p1Lh0FhK4qAaIpBnREvvmfczd2AO8DXR3uBI7gqa813WduQujE
	 KD+qqb3dKhJEP++JECrhHRdIbeA/F2Oj78W7Bmdp8kFdelzlD2LFiXvduIqJbAEqMt
	 eOV0PONEm7jJRVWFY0cICmFAAOrh1DjWgfO1FQ8NzziyeXZOTguJZ4ptmgOndDzVbZ
	 sclJs7CjawcBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 516A460730;
	Tue, 17 Nov 2026 23:12:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35EEE1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27D8A407FA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YpKOX31b-fTQ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FCDF40555
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Hii2JtUb
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FCDF40555
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:12:04 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2efde3200c7so1328925ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794957124; x=1795561924;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZS+7imKvRhI/mgy72HqjF4vhbRsxNAqmN2HpoXXwTn8=;
 b=Hii2JtUbL6bhU8RrUM3FnxFYlDwSJ6gIYSP89m9mjFkxwbW5sQcMyinP4B2woZFVDR
 Vx3EiVSpbYl45qFnAf4kfZPfp/K19jh33fgmIlZ+VVtscwhLbAyvuT8N5rnuK6Y9Jzz4
 K3tDzY/8//jLvOg1hkee2azDMaXY6yHNhUTlDY3levhFbubGRra8uXShBjY6IjfijqED
 jrhyRSt34QYmPRllRbKmCiIcArbzlRIxsfAfOT3e21fT1iBrcklubNZtndLx0s+KRsm1
 iaFN78osM1o8KClN2d5oprcf/lFiliuyoLPDqKJYe9YQAa6d4ASK3fg2mnxSzjJvE/ie
 jZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794957124; x=1795561924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZS+7imKvRhI/mgy72HqjF4vhbRsxNAqmN2HpoXXwTn8=;
 b=fU7B02djTCCYpbm+uCROf8fRl06NytH74fn/KsTsn+ALnuJHwOMa93h6nkq/BrZPH7
 rBnGq6hujbJz7XqIcZAj6Q2muqOpYl8QuEaCEwlLXRWDMg9HoIOqEGaW5iERpAlkPb0o
 S2KVqq/tWvQSAEBxJRsNG5eN52JQw7vliyZnAt3g1zau2QdF2FxvkNNVmkL5JfQdEadg
 C7sQxy6HwuDi8KAqHVGy1bj10YTwEl7+T+JV0XNVNhf64LyyU/tl7Oeelp2H8PoV6Kzq
 k0uXXpmxnwhBq98Vgf0mraKxeGG3j/OC5HTZXHuf4Z7aHh52uQXGgLYpvJm03PPH5bou
 ETgQ==
X-Gm-Message-State: APuU4Z+5vSHE/Pr0cq3kFOcioiVdnzmWbDn5Xxp27j+6J7h07yvqDCyW
 Vo/69mcE0zz8bTnDD5itHSIdxGogdGGl9m7Ig9HmEUWEbyxwrHEE0CIs4kad6g==
X-Gm-Gg: AZFdTZfZLNmhAViU9Tfigh9FaJY5l9QR13kdtdIM48IHJPpXiN+2XTlC39MSWGkOo2U
 Uspm1x3QN0UqX7uuE9H/GgCTEPyILzwmOwiD72S6F84HcG2uR2eOo434fF5AIDyKHYU2C13zruK
 pVSWhtgwTPyRNo+/QqwJnUfdUVn4HrbXeFWrHGsMNAfqbyq+tNmiEreXBp90E67b2abU+vhSzNK
 MBsPB/6VDsh0Cg6GjfcOAZf9YZxzA+YvrDOG+KShVy/uX824L1kRjRjSaz3tTNc2m/GIa3DK16D
 +RmXPTgRE93RF2/10VkbEJ76PfREiKk91Apm/IYxmO3+2lNLtGqySx08BUPGtfiYD008V7hThZg
 aC4ZG171AkMF1JqXaKMQNc+5p9p3UPPugx3dBgmxneRkrlQJL4Y0SUnAZRhfzwYZJsmCwugu1xR
 WoeM//pHZtJaNY6ENKLp5rfSZOR3dbtpu7uy2AeeAGEsJw/db+3vi408OJH2VWGoIEn+DhCX7Pq
 1oNoVI5RAvqLUQIxjS2UWx5g46GjikG+DLpbui6pUM5W6VOeXcgZo3Vxda/t1t4rmgdziErKzK7
 o8NtaWAo9PfHvTZcAmXtQrnhtmZfyAJtgnYDb1qaFjsqvVei8mZIK/Fo9PPQcJGgNu9ThmeBA/X
 YpMa9RuRi4RbL0rgaN2YxsR+5wCmdfoZQL/lW+GejCjdYbwF1RzUnBcxpz5fH99pkPteDb2xzsk
 OYaM3WOYiKpA==
X-Received: by 2002:a17:902:f683:b0:2e9:5b20:1c2b with SMTP id
 d9443c01a7336-2eff70fdf8dmr6990745ad.5.1794957124157; 
 Tue, 17 Nov 2026 15:12:04 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff618233fsm3365575ad.37.2026.11.17.15.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:12:03 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v2] MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as reviewer
Date: Wed, 18 Nov 2026 07:12:00 +0800
Message-ID: <20261117231200.3699482-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
References: <20261117003237.3090023-1-alan.tseng.cs@gmail.com>
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

Add Hung-Chun Tseng as reviewer for the SpacemiT K1 board support, to
help review K1 patches and test them on a Milk-V Jupiter.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Applies on top of "MAINTAINERS: spacemit: k1: drop Huan Zhou".

Changes in v2:
- reword the commit message in imperative mood (Yixun)

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
-- 
2.56.1

