Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406C606C47F
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t9lMMlLw;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=S1HYGFpI;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=+KotXKkf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2AD240847;
	Wed,  4 Nov 2026 20:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-GXsmUmIycx; Wed,  4 Nov 2026 20:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 263994084A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793825072;
	b=bS5lysHq9tjA50blhU4q6eC2CChE1hQVSc+Ca94BW7QRQ0U7P7/42A99x5KE4dePKFWL
	 z+6vxLqA7/vWcKHdWQVadPCvr0+flxoZ6auO0n7mwqC28M42Ltf0qdkTjvF1J7E00aLTw
	 Go0aeV2Qvi26hyjA9DfJTSlun6hE46GTVDYXP3bo8g8CQAI5WEPOMjptWycP6K3+J3VeZ
	 w+Nbl2y4EAS+0z/cTVFBZaems0/xbsEOzIz8QxLFHE3Jx9CwtWjWJVFetVxWPZFY8q16K
	 0czeSba380aRk/TTSjZSC3B9usnxccqCDxhq0/KzyVqZjGzpNm8dko6CUNfqU31+LMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793825072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iQUykblSj+e0BiBf80I4Sjho0Haz5OfWBVrCfF82GZE=;
	b=TrkX93qAqy2VrVYEQC1AjHVS5WYML5/bhCujjNRnLJvxQK+eeHtJn+hCEcebEpD/yv0e
	 v20/v29vzKpV+yz/wYmPPEmNZxDfECKrTrMh5UnzQUn76NFCkxF/0lRcGwzWhgCHA5OYp
	 lvcvYjquRJXUh6Yyg7YgUNjSJo0VjazSrBDvuOa8EWy8oSNXi/yF6+RGT4upT+bxCZmhy
	 9Pccq03DNg4D+tiZkGll3MJULuZ5nxX+DSnX/x5YtGppwrUNb5hAK389zOljL3uXDY6wj
	 t5YeqBWk1t7IJFKqeoM/W6hImc9ZT4Hraj2hQkUj5FUzPXVVpCh3Ks24Hwek+ryb34A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793825072;
	bh=iQUykblSj+e0BiBf80I4Sjho0Haz5OfWBVrCfF82GZE=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=t9lMMlLwU/y0CiCraDVd24b6P1gQFy0yx4Bc1M6ehZfPF4U4p9sk2ajqhXcdBMbc2
	 TUW6b0hlDeuV+nB7kYMcsD/Y2Ub2Rf74GSTk2yxrV252M4RtMbxWcAAt65DyCPJ8GR
	 /afoScGgxtnMtobDCPvnRCPPpTtGWmQz+jvb/40gu73hliQ8mRBKstce6NvaaM3MhI
	 vfrOuMKTJQx7QNENLiC2lr5ChAbEgNVC5CxfWSIaUxy9e6hMNBP817Mrgah/oK3C2l
	 2RNijLe9bmXEzBH8YPf3d05n042nuS7l2v1jG+nTrKwgSJ1a+3prb1KcDH5hD1Na3P
	 SRyYXLB7XRvGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 263994084A;
	Wed,  4 Nov 2026 20:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BD07B00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 322FB6078E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZOd3eSD8wD2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 20:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 16CCA606E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=brads@mainlining.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=S1HYGFpI; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=+KotXKkf
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16CCA606E1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 20:44:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF1A84828; Wed,  4 Nov 2026 21:44:26 +0100 (CET)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8400383E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 21:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brads@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793825059; bh=iQUykblSj+e0BiBf80I4Sjh
 o0Haz5OfWBVrCfF82GZE=; b=S1HYGFpIRs4XxDggW0iE9u1R3w2Yj4EgxTt+xTYpout8ksJbuX
 smR8F4bJGll6bN2WTFwOpGWvo7LofjM9PrzWEKggwQBQP96uhLiITuVGTr0ssBSIInsmMVETh9x
 CAxlJGpJd50s43FWEECv1DCmGYPzcl4hbUgHB1MdDv1oVVFL/yrGkbGJXDuFB2S2YBVYoQBDQMj
 6sN2959+C0tZ0cFYUZ6x6k64zOmB7y+L2vyEBzBd4zz+qDoCsTX89cqiz9x25sy8zjRa/oohVrk
 oLtfnI981wronOd8GLaMEhr2++ERgkJvGw9fGWT4FfQ9wKnwCe9d2O3r0E1Ec51vzZQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793825059; bh=iQUykblSj+e0BiBf80I4Sjh
 o0Haz5OfWBVrCfF82GZE=; b=+KotXKkfvntBag8+H953cPc61gLA7KrFNTLsa9412s70OOhSq7
 phvC/CoyCBbzE7ZrYZ6DJxH+8XW8qFfbb+CQ==;
Date: Wed, 04 Nov 2026 20:44:20 +0000
From: Bradley Morgan <brads@mainlining.org>
To: xjmps7114@qq.com
CC: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] doc: spl: describe SPL FIT anti-rollback usage
In-Reply-To: <tencent_2570A614E7B8955F61CA5DE0070B17874006@qq.com>
Message-ID: <066F752F-59CB-4072-B66F-6875306BA00F@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 14:11:17 GMT, eli <xjmps7114@qq.com> wrote:
>Document CONFIG_SPL_MINIMUM_FIT_VERSION, the FIT configuration 'version'
>property it checks, and the trust-root boundary of the mechanism (the
>minimum lives in the SPL binary itself).
>
>Signed-off-by: eli <xjmps7114@qq.com>
>---
> doc/develop/spl.rst | 43 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 43 insertions(+)
>
>diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
>index 08b51172..762edeea 100644
>--- a/doc/develop/spl.rst
>+++ b/doc/develop/spl.rst
>@@ -125,6 +125,49 @@ Use `xpl_phase()` to find the current U-Boot phase, e.g. `PHASE_SPL`. You can
> also find the previous and next phase and get the phase name.
> 
> 
>+SPL FIT anti-rollback
>+---------------------
>+
>+When SPL verifies a signed FIT (CONFIG_SPL_FIT_SIGNATURE), the signature
>+guarantees that the image is authentic, but not that it is current: an
>+attacker who can write the next-stage image location could replace it with an
>+older image that is still correctly signed, reintroducing vulnerabilities
>+fixed in newer firmware.
>+
>+CONFIG_SPL_MINIMUM_FIT_VERSION adds a software rollback check: after
>+signature verification succeeds, SPL reads the "version" property of the
>+selected configuration node and refuses to boot if it is lower than this
>+value. A missing property counts as version 0, so the minimum must be raised
>+together with images that actually carry the property. The default of 0
>+disables the check.
>+
>+Example configuration node::
>+
>+    configurations {
>+        default = "conf-1";
>+        conf-1 {
>+            version = <0x2>;
>+            description = "U-Boot 2026.07";
>+            firmware = "uboot";
>+            signature-1 {
>+                algo = "sha256,rsa4096";
>+                key-name-hint = "dev";
>+                sign-images = "firmware";
>+            };
>+        };
>+    };
>+
>+The configuration node, including its "version" property, is covered by its
>+signature, so the property cannot be forged without the signing key; the
>+minimum version itself is fixed at SPL build time.
>+
>+Note that this is a software trust root: the minimum version lives in the SPL
>+binary, so an attacker able to rewrite the SPL itself (for example via a
>+writable boot flash) can also lower the minimum. For a stronger guarantee,
>+protect the SPL boot medium against writes or anchor the trust root in
>+one-time programmable storage.

The BROM should be incredulously protected from issues, if not, well done,
^Wunsigned exploit incoming^W

>+
>+
> .. _fdtgrep_filter:
> 
> Device tree
>

--- Thanks!
