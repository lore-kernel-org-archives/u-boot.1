Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6249606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p5M2cJEa;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=NZMIg1tP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80CD060AE8;
	Wed, 28 Oct 2026 18:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DEMXKYL6Rjk; Wed, 28 Oct 2026 18:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27F1A60793
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793213195;
	b=Wjcg/w+4UYVlrrMEomkNPwE9LvKLXq9cavxCXKkX11c1JNd9XDFwg9AmIpqvLKBQYSMF
	 r6Bd8SnnZi4Knc7ezan4lxaN8RbA+DcSYr3b2BWIo4qrXmQQk0w5NP7eknfjzma/bhK+A
	 wUzD6BQyMSW+/OZLrZO9SB/aAsgf4xtuL3NOU0uLdNfJCGi8jQUJhDjPu44Gy9oQ6fN8w
	 8YGY02qyjwo3hj/C0VSzbABMDop6bC53CNU4sIj6cAsAnj7YeChmkl3WFWiwZ7DkKpaCR
	 1VPNeg2lhQvYdoigU80JN6h90+Iw/tIbuftWoVjBKSzAK1NkBgyMpn/IfK34FgYQzdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793213195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=83bdxkhBti15mRZzfLvPuVwuiw+1yrx2AUV5QQM5/VM=;
	b=lZxgahpy84ZBa5Knj7yj8YwR45mCUyKkxJBQVwkTVpk/nBff31empnjG7xKBdtzM63yI
	 EFh2/lUay6zfan/A79pcvVY3mglOhoNpRLOvR/QTQiY+RBFu1sC3hHStwxUoKjrVrrIPn
	 vPhTOcoDHN6TXvSV2LzWMpfnoKiIxFsOXq+2pZbtHRspudY5PbVOytiEFLnwnPeCzduUD
	 I60RjzNU/OpPG3vS72H/5zrAQf/6HWxIchws8/IxydFm3OYlFBgCdBeMC79ub9+F4tZgz
	 vZS8NOkmgqBHDqKCpoTP4s2pvnDdpF8AKiJtMY0d6Kj25V4P3667LJUlkMyuUCeiiRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793213195;
	bh=83bdxkhBti15mRZzfLvPuVwuiw+1yrx2AUV5QQM5/VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5M2cJEa4hbWEWsR8ihhFruHSypIDt4qphR8cwjso9r+gTqX5V1GzWiQJ8MxIQIDs
	 4iOJ5eYsMM0YXZ15569dfyBkqnAdAf52OJ+XGVfL/iERSYbCSwTp11Sev6GKRhtuhj
	 /KxhW97JTPryEeUw/ghlH2Jc3gXxciAH4Mww/LHCrmwopwm++sPqa11gIa0cXyQFkx
	 3mscdg0NnNKm31o4HbpMgRzoAu98W4hILY1cN16utEgEkIp6OX3oUj5ZCQamBz2Bw5
	 R3rHf6QytwlO+jIlC8RIkY0MPR1Nt/hXWN7kyL6kzVH2ewZBNbxMUguH+AA+jQ63yX
	 OW/xC1vQaw+cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27F1A60793;
	Wed, 28 Oct 2026 18:46:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AD55356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CC944031F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0I5Q6H4gPAg for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:46:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DBDF4020B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213192;
 b=A9AKzx56SSNXzaKogZj9DMCHkJA1dQUd3Vc8Dv+FaSH1R7d267zoW3/b+tcsPWRnKXPA
 CWLVDu73mOWKC2A5CKT4qJZNWV5jJBPQ7b66FJRVAepRno0FWF34PFK9jVbBCDjIo4Pr3
 GCU/Xkw+jj3+TnmBLAhRMCkFG8wejFqCpNEzmunrgdah33Gm2BGOnlMONuhSi0jn6H03E
 WHfrb2XpM1mcVRel/4QJqFYp1WBkO1eKMYPKeSiCk9/eLBbbWdm4GD6exWh65pB1tZHlg
 ydCLcrpcqNzjIK4v54ByuxSZjIE/WWmPfAKJB3cPjpfFILYqjrSzttMcPIGK1d1TfVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213192;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=83bdxkhBti15mRZzfLvPuVwuiw+1yrx2AUV5QQM5/VM=;
 b=A1KFm8thIm0ZBBLRnuvPbCid3XjALaOteWwi7qaYs1GTS4xl4HYdzaBIFen0oNmBeR4B
 VEiAETFSvEKk/K72/mGaOYgVkHQ5MnSGtoItpKRAv/2jZkdtoZa7B8CTsJ1gN7dVDchJ/
 B6/Hg61/Lh827d70bD6bFwoZ+ICmnuuALaI/og7/LWNo8uITVEHS9kyxxsZ0N/gGZcn4T
 pzbZx3KxPXxgC+IXOQrGn9CHZBT3Y6MUGjICVumMRW38KZN1SbKV7wS4eLBJ3pu0PB16A
 sJhqDOVwE10+b1iEf3+nFoecrjDTS8FECNe1otok6AvCSPFenJ3ePevPd0iqofATO0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NZMIg1tP; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NZMIg1tP
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DBDF4020B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793213158;
 bh=83bdxkhBti15mRZzfLvPuVwuiw+1yrx2AUV5QQM5/VM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NZMIg1tP2glp+TUINQCEonDxivimpS9OK7jqvp8Zpo7/70SMIH6m9PUhtyFx8Rier
 EUW9itugEF9ki97GAoJjt5PLqMY5Z94Nm+UDDxCZMFtHAeyWxS+FbZkmqM+RkCDAog
 a6fapMtK2oEXhM3DRNxL7t4s6XtaIwHxlgOHlieQ7EsRRU2XUPYpaC2WM5KFXXcVi7
 s0OR0wIkwh/QfaTsrnvba+ObmWRWL/I51aII6uQeiumlN5w3CBu7Lq5buSHbSunOGp
 PhjP6hbkPCbUOpSdb1owf6VSusWyrnHa6LjcYsoZ+PGQ6vQx81LELQY7dGB8lAMIu+
 WJewPKI4SVppA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 004A9B2202E7;
 Wed, 28 Oct 2026 19:45:56 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 1/3] riscv: dts: spacemit: k3: override reserved status of
 mimsic and maplic
Date: Wed, 28 Oct 2026 11:45:05 -0700
Message-ID: <20261028184526.1887640-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028184526.1887640-1-e@freeshell.de>
References: <20261028184526.1887640-1-e@freeshell.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux boot stalls when probing peripherals unless OpenSBI has the
enabled mimsic and maplic nodes. Override these nodes so Linux can boot.

Reported-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 352e85e7de87..278b36acc79f 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -3,4 +3,8 @@
  * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
  */
 
+/* Override reserved status of mimsic and maplic for OpenSBI */
+&mimsic { status = "okay"; };
+&maplic { status = "okay"; };
+
 #include "spacemit-k3-binman.dtsi"
-- 
2.53.0

