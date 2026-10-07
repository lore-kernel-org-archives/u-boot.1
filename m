Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E7CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6582A81423;
	Wed,  7 Oct 2026 19:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsLyiLbnw78I; Wed,  7 Oct 2026 19:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EA7281420
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401702;
	b=N8W2Hh5EJOeYCFxIrI1EIVUSlwNngy2zTpI4w4FAs//bUx53ITqK0nNbqfCyalCcKv83
	 /sLbNXi/FtJ+yhEqXv0oIGMlv6rdiz1WJ/2zBAvN/8/aMFxG8TpO1LzrZEH3kEoe7LVaf
	 k9w1H6GMLKAXm3fe9Cznjci4NpsCQ2KTBhsNydQdHF8JWkp+Xld3zWTmVg/7tEcFqfSTh
	 10Y+VNMO1PEh4r63WwSlxlQ0WHRy2xxR8t6+X+KxTM7hvnSgwSTCfKzEdoUvXtz4lAEaH
	 7KF7RpjxhGg0l2gVTtUu0kH+BNO8t/Hz53s3+NdkceSF6+qzHJMhPLzErpozi6vDyVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FQha+FxnyUMHI88M0+vohA0tLc2WWoyU71DP0DH9iFM=;
	b=o2lmDoWanqpSsx5eeXZ6yPG4aiEZ/1UNnrOTBKtpfgL5xMe9cRRuJmKb2Jrl7bYVuZBR
	 a3maVFIger2XIiX0JxZDBdQPf4lSiI/O+rDXmcuvxnGx3sGrWa9o5WEaDhjYyUy8ZjkL8
	 2dl0DVnm1kz02YvNlwxZ/niWstiujUMwWTVU84p6ltXcumH5eJquwDm84wuoUs9ude9S5
	 zsv9S6ZbKMnhY2dT9/pcoYVCz0AyiGnFcXtwNWnBvv1H91KvleWDGdKw1aJOo09HRqy5w
	 EKduHgCBHQhj0Cj17Sy1oivgKValE4WdFw4Fx3AhtFEjAkKn7NwuungfQMBgDHlmymQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401702;
	bh=FQha+FxnyUMHI88M0+vohA0tLc2WWoyU71DP0DH9iFM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MdX8KhqPxH66K8Q9d7I4/8b9U3dzfbA9pODcKR/6riqnP1spqbnJ7+2P8rp9tyoAP
	 wgzVg4tZ1RUnZ23Xa+HFENbBPdZFZJGWLPkDH2B7tkKFKq6YVfvgiQsxv5ajx5Pw1j
	 QsRMZBQ0eFOt7Jy9854lj+Ey1Jnb9E6YttXNnVNNbfkq2Mo1Ub9B1+p8LBfElcfP5Z
	 4RLqE5OpLoi+NntTCdyxoaPVGpD1iBUxIIvU8wYCxcD3tbqkgmewWzX9j0UEyqM3kV
	 /+XezrTKgmgmvVwDPDjIBvbJJMH3pQbYLhIcRIlDbn6Q3v4FrVDQLyB3FHRGAMAkSJ
	 b6T+y7SZ9pbeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EA7281420;
	Wed,  7 Oct 2026 19:35:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27805338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C1E460840
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kWRqiU8vD7f for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 18:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 572A560828
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791399558;
 b=nTeeydpnBnFFC3p6/a+md2xgTt7BAkzFmcddhfusOOKm5BTnrrldlNxvI4/D6QT8EATX
 hjCy+aV890coTM9o+1Oi4XYZsBrN8rkMzeVv4G/8+qJww1TgJPRz3s14Aq+6n6bXqqRNc
 /LmIeGHfQxxJmrX3+83em2YqidMm4H1lb0e4d8shtcOj7sDvKLLLgjhtoNKLqO91DmYmj
 lKyOWjPGMfA7l3oyDUiZr45uFFGuwaK4MDRU8IjOe37UUQINwiVjYKls7BDhkvMYyvqOR
 hZkxup3NRpjzCVfe3wGGeqrU1Zg1IZe3lVrahJFvgX1eZWe0gW1GSYzqZ31abl7vlWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791399558;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=FQha+FxnyUMHI88M0+vohA0tLc2WWoyU71DP0DH9iFM=;
 b=fB1w5tvmILjpzOp8PzqMBb3rEHvh1U1FTHe0ySpumgg66ruTpVcuzFUJbC3fUpvFJDKu
 Q1DCHOHTWdog3H2Ahx80wJkzCPTnzTzHgshlsW9QV4yj8GtO1EpiSwJEyyySMJLFrKrCA
 40zRmp7SrPHr5zXPOW7z+v7yWRTyq7MGwRBdCjOoRuvIy5JEN2qELU66hO5vlZv9WXzIJ
 iehoa4GmnEyaySm3zxMFxdibmfPkJAQV5EjwO+axqs7loNAg8RkbrR1Q6lLYpwfwGbw5W
 tgZqEPwXawMEKwLiwEfnbw0Z376FaZ8zgIOHHVjQK8aVLikgRLZMwHiro8syOE32OSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VNfnn6L7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VNfnn6L7
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 572A560828
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:59:17 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4c382ece86fso1175592b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791399557; x=1792004357;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FQha+FxnyUMHI88M0+vohA0tLc2WWoyU71DP0DH9iFM=;
 b=VNfnn6L77F4mOyKzPHtOTDJ0rF6PPWFb1AN4TjNwMa1yEq4QCZd/iL/0AttFpOdKCI
 vR1phz3Nk5eUt25yA215Lq0wmf21g0pbZvz+m7DPBHZLiDRmu9fCGH5mbUz7hI35Omuu
 s05cTJeY2e2wUbIaBVT0F7wse7iyAnqSxCK7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791399557; x=1792004357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FQha+FxnyUMHI88M0+vohA0tLc2WWoyU71DP0DH9iFM=;
 b=kT8J4L0djQyiRjVFenxDGaF24P6vPhgl+U1pmXTDaUc0khnuyjjFezXqDR7K7FlbcM
 6+U+moAWHWoKF5uhPD9IbV65kFfzux8Y16oC4ZzxTCwvNj3ZvXlbRFi+VfWsUml2wYcM
 k0jxMraknKf7piKWA6lFdf3sTbsb1JmjsZJ1nW4SlPt8b88Tiv3omKGMdDfBiu739XcX
 D8cqLx/AAG+A6bfCvT/yjS1dpdBfrnuk+fvx3hxQbs9UEB7/GOWYr6dmqg1p+rabuwRL
 DrnRujrlXUQLPQW1vzDoUtM5lWtGBPYmVaXWa+F+V9JbMtwdrzmj+HxxgzK0CsLCiST0
 132A==
X-Gm-Message-State: AFuF++nELIaP28hvly8r9QDkKKnC7+1lhbwEvyrxgzyrcizPs/B9dyLu
 fvDQmlWCv2Nvuch4wUufQcNqGBrs+C7NI21P87MA67vSYM4DRhDya2TwG66KbaLKch0oN/2NOfU
 7Q89V2rlMOt8H
X-Gm-Gg: AYBFou0ErOeTr78ezA4ePOlV8NeZZXrrLF8yDeKF94jz4t8MuSW+5gQI5waOAOy0aJN
 Cor/pKmuRNgnET6gxNgUUMyuQXjGE//R8cLRe2SJ/MFjBNUQkn12psxZTA4HPAmnlD6wUfa/68V
 ba1eqr5GywI7hnjDbgLt9RhzSo2ZF+M7AbqT3NRW79ZTfYWxKgALN2OMEZFGZbkfFZU8ZatfhZd
 YhBGdIpf4rnirT6ISZEqO+Z5+EFoY8KZkvhTj085XcpuTV2rEfCHs8eSffQqkA0zEPswGp6LoHi
 TuHQh+VbC0xChjPu/RxPMeMCyEBxn4iPNjXGelgvlju76ROCuddFerDTL01mVix/z3F6CEN+zsj
 GjtlaS+zyuk4u6dn9pqVv//iFMasx4kgBbNjP/oXHx29VY6t+1E/CBAASLuXfRE2DHhRzsYR7hl
 DyludhngzNkHrnSmrZaBP2/7O6Neu+CrtCYupid6tI8Bu5djazF5slwEqIsmX1SUkAXwZgDQK23
 4lb4lJUOflNJHb2cmn1McBjOR/IdgdnBYBS+r7UdZCu5zTtrjVSVMAOjR7AZCoVaWHjsxTCCl6z
 ud5SkOU0F+GsWWfEY3QCLWs14dSyLP9Pk/+foYuNae0=
X-Received: by 2002:a05:6808:ec2:b0:4c3:6c2:4f29 with SMTP id
 5614622812f47-4fc45d57bebmr2906327b6e.16.1791399556518; 
 Wed, 07 Oct 2026 11:59:16 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4fc48b0cb3csm3398367b6e.7.2026.10.07.11.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:59:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Update urllib3 version for building
Date: Wed,  7 Oct 2026 12:59:14 -0600
Message-ID: <20261007185914.3419261-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The GitHub dependabot tool has reported two "high" priorities bugs and
one "moderate" priority bugs (CVE-2026-97689, CVE-2026-97687 and
CVE-2026-97688 respectively) with this package. Update to the patched
version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 20a99005d71a..71adb117e339 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -23,4 +23,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.7.0
+urllib3==2.8.0
-- 
2.43.0

