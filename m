Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962C606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CBUtxq45;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=eYRio8Es
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A8AE404C9;
	Thu, 29 Oct 2026 00:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id or-BiG2D4dB1; Thu, 29 Oct 2026 00:16:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D3E8D4084B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233015;
	b=j1u1qp/6T5vrm5CgoUVsin56AtwmfRXK6Wg8ve+OOy+NT/wqy3o46eK3NktdR1DddFY1
	 RW+TKg4LniONrMBzlh1pLmll8+sVW1mXTI4uLp/wcadhUetRDYb6sYiKaqN4JpZ3nud4K
	 r5eikcVfTLP5/w/6K2ieKJ3BUbw/OGlKJQ5tNQEpttBkNf1oDhptTYDSlI4vWbhGJtqC6
	 V4gvHh4s8COqMMAQ/gCg957nchLoI7vhr9Fy2jdX15LPJTYR31F7F7xuqTp563CwBWLOk
	 rhaHnGATnQwU0JqCYhpK///9nvP3kWcs4IfpklhQZIv9YvrKD01JH0liJ+mWvibFbQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V7IuuzNpR++abp9XVUjrpkRXFe3k10srRHAVOQtWcXs=;
	b=j+TcbjclX3OpqF+DEZ2s4vW9LL4+RC69a8EzOcwItKPlul2Vd13JDD1T3NRBaWyNJ0r8
	 Aw7yCV+6Esr48WkNar7OoNfAJnznRHXBfEOVLo2Gu7sYnEvvVFqkqbfhdmP/nsepeJj1z
	 PMFWJZ5rFc9xLcn8gY555dHkrhU8ugNVjgc2DYxifmfCy6gBsTgyvEima3xALhkPj99Vs
	 DES1Y+oU8Xz8XZUnXD5CFZaDQkiL03CkAbjB1gb0dxNeErmHd919BH4ECl0hHf3Xyn6Rh
	 gEz2/0nqmYjMF3/bdL58w7GbJ23NvVhpnHJXHU71LNx/elpHjyV/q3cdDHhrzK0kBMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233015;
	bh=V7IuuzNpR++abp9XVUjrpkRXFe3k10srRHAVOQtWcXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CBUtxq45pzxA7bZzmMRl8kNFkDbTIX5V2y4kN2Azg7B4ZGx4VdR84h8vhtIS4WyOY
	 Qp0reocF2o1J9KFbOWe/B9qMPisHKcKcHtmOQiXNzEbqkhd/wa54PXtuQpuLJS8+wW
	 Dr0Rd9HmHFVAavATkHPEKqNEDykQ4kJZpHajzB5Gik9y49VJXItpRKNbkrImwVU5l1
	 68XDhoHjgI7vhE8NLCHXxtLqPk7miYzvn/Xk2SQAEcgecEK/rt5RflCq+qpC1YMEso
	 8zgg3pKHLRT80hmMoAexCtfOyvfl8ztMANMtEXZ9AemhG0kAU/XyvD3Q9H+OPy+Mzc
	 R7UYXPt4OlX9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3E8D4084B;
	Thu, 29 Oct 2026 00:16:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 204CB2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0679980F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDkPkXJ-s17G for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B6A180F91
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233012;
 b=ntI4U7YR4D/RbNXFsQ75QawxfJyfYU3Yqgm81FOhPUvJQjUDLIlc/k1dQ6Uhg3ljt74R
 YvK2d233yCryLK8j/9x06OJkEz/Ik6wE0Gp7C8uiv3SRAomBGQI9MoT5KUvJkBWtiRaPs
 4AbY2wy4+z/rehf67PuMV+F2HRj5rN1MNwm/Rd/6EN6uMyoXyLqkcTrt4nPK3xxV+HF34
 JEfUo8/kotjNklQ0KDsS+tdF2xIbaukUCAD/H3sozqN9/FAtILWb761pGiYmaKbtDBKGR
 8ZuU7aGD/rAwcLHuu8w9tQ6q2a0usDw2B5stRWJ9ieZtrq6bonLQChZaByBcQXCAS4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233012;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=V7IuuzNpR++abp9XVUjrpkRXFe3k10srRHAVOQtWcXs=;
 b=c3is276CCNtBIJfpfHu61BAQRCz4SxAMFCpauQmBTpWhfEtasueH9EYuW0Epw9g8lHfI
 33HOrOvVS0SLBoihly87WKM+uK2FBTpuWQltianb1ULNwJElVM6gUErklOUVT8XR3EdGh
 592kQNRTEa3sKOb8bjngJlUqjJF1iPwtNCxzPu/bJGl4eLXNcgFSW/mc4rUXVtbtJOt/J
 csfUrIjmLAlxy3ShdIRx3DvvZ7eGmDLQibOeb8ua1XdS5/S8Gvo7wykDduRPJU9LWZdFD
 SNXZhCt/FVoG/Mtic6nPKBHQJu9Y9AQdJRQC8F4DASwrhKZP3ENuyu7Ud3I0AsCGRZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=eYRio8Es; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=eYRio8Es
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B6A180F91
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233007;
 bh=V7IuuzNpR++abp9XVUjrpkRXFe3k10srRHAVOQtWcXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eYRio8EsrcuW7KIQJNx1P0ioBopG+WHqfqMMbXXCqme0Uei8j092QzDWpOZ6PWGjl
 Nn4+QBNZdTLI6aQCEMLgVi6RrMfTNixZAtNZD0SOjm86RXFw+AuGmvHO5dOKFfFgi5
 8X57BQdoJyQfuYWmzc4klC01QijHsuGdlwsAEIk+6WeMmfIOFj/B5vZE0w+a8lpLGf
 ciRn4uW68PE7iHPQeCZ+i2BzpIcRW6GMilfCy02ASzgnVYlKnFWxnVSJBalt4/6B01
 9ylu9gMv6J8Hop48nR/cckzCgglck47/LLRC58SNnFTHaGcsNsiZ1lK5PrfEsHIC1T
 9wbJA0o9OgEdw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 14E5AB22087E;
 Thu, 29 Oct 2026 01:16:46 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 1/7] reduced SpacemiT K3 vendor BSP: use MKIMAGE build
 env
Date: Wed, 28 Oct 2026 17:15:49 -0700
Message-ID: <20261029001555.1890775-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.
---
 board/spacemit/k3/config.mk | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/board/spacemit/k3/config.mk b/board/spacemit/k3/config.mk
index bb8657ad0247..db871c53047b 100755
--- a/board/spacemit/k3/config.mk
+++ b/board/spacemit/k3/config.mk
@@ -74,13 +74,7 @@ endif
 u-boot.itb: u-boot-nodtb.bin u-boot-dtb.bin u-boot.dtb FORCE
 	$(call if_changed,build_itb,$@,$(its),$(key_para))
 
-ifneq ($(CONFIG_SPL_BUILD),)
-INPUTS-y += FSBL.bin
+MKIMAGE := tools/mkimage
+spl/u-boot-spl-mkimage.bin: spl/u-boot-spl.bin
+	${MKIMAGE} -T smtimage -n k3 -d $< $@
 
-FSBL.bin: spl/u-boot-spl.bin FORCE
-	$(call if_changed,build_spl_platform,$@,$<)
-else
-INPUTS-y += u-boot-env-default.bin
-u-boot-env-default.bin: u-boot-nodtb.bin FORCE
-	$(call if_changed,build_default_env,$@)
-endif
-- 
2.53.0

