Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7E606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BrXPhUbg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDE6681192;
	Wed, 21 Oct 2026 14:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gk247Png98sS; Wed, 21 Oct 2026 14:09:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15FE4811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591770;
	b=gcse7Ei7a4jampYK2epycmbO8ucdwLBMBU8mJD09FS+dUslezqvNlN/XQPqb61oD3fK7
	 ti+75ErwChU8svkUPH/Oq/HRQdD9USzstCBtoIOZI8cSY5vG3uBoKQFl5x/P6P0ejurZe
	 eaqZPb6X78MRGFSQTL2cvjrvOnWAP4RSogbQSk6cU+R8QDAezkFwKSpydlxVudnazmKDg
	 qtWOnPKUwxZmLl7D3wmUXcjmydwGLLxiOCHJg2ES8GsL8uIqp+4K582ay3oxM4WuwuhP+
	 VMazC3CQP6hhdeHT/AEVKfm2HQl83MMQsZmYCBR1uECAQiA4pr2wgCjkexPmxN8GvLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ptR8YNq0t3qSjLJsQtv2Drkc4wN216ICw9d6zYksgEk=;
	b=jFub1OlcZbLBpsjrV4SX+r9cn2daWq0Nd4v5eF1ogIQQTyTv2/gwITsDYXux+WFDkqLy
	 R4o7834Jv7YtsGsDBzPq8aVSKIXCDAFeZm1xfTw+13erFzRzEfPUJeCJDBtmtItWhyWYN
	 hzLTLQTYdKFL2CenXINTfAXrhw/Swc9szO31AxfRQVyTML2INhlcbIdC5Yw3f37LNaRn4
	 dfVW77GydVhm3iwqhIPJtUkv2DgWWDP/Cd1v3SYlOKqSsgJjC/EkCUePbr/TC1ZHJ7yf0
	 yrb5U1CYZq+dCfRVZi32gk+jFGu6cvQai33oIRmoS2kC13cAg59QUs2fp9/8q+ghN5A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591770;
	bh=ptR8YNq0t3qSjLJsQtv2Drkc4wN216ICw9d6zYksgEk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BrXPhUbgqzBTMoE/dEC+Ovv5De9Yqgca1opG0/nIwwGdZQcFp1BJkHbF15HxKGaYR
	 mdQSGgGLlEjf0kmxEIW4uRjg2oxy92pGRCG61aBcujncljrxeDmZ4rQy7vYAUNStF7
	 0ALzd51cCeWZHWaZ0o4Nu7QReFRy1kGpPliwMgti/WgGUEXk4pK+11MBKQFT5xv+hC
	 K+Y6pGNzLIpwlhXiyT27QnBFztYkjQ0aZA/BHfeQVBoLENMktZMGzrxSnjqNEeF0fM
	 p2HvhVPcWeftSBDxU1xsnCByoatIaJzJWR91QVtYnNJglHwdOdgRkcWAIKx2uGMYWZ
	 EQaEz+wJ4vZVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15FE4811BF;
	Wed, 21 Oct 2026 14:09:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A6F11E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7086960823
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjZhwSJxl17M for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 185816069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591767;
 b=FXrX2zSnKDLmm6Aqg6z79odDCbjG/bTYbEiYG12uaXKvNKUSamdiy9smq5A0X/Hgvfh5
 jkzQa2N9RRYoVxFSmJKc1slSjudP7wRR2o2JDDSoUqQPlcGTlYc2WY810CeGg1JFRysYP
 9sFjZhdKroE0cNRQj8ZnR+HCtAYRjBCpBUKM2c8FcB4s7/vzj0pLEpry0sUSovqv1dOXx
 Dj7dA7vbpZ3rA/IgiugYbPkzftm31gLuOtkkAF6SuK9Hw0l0nEboMM58q1/6ncie8D/pk
 stM2bMow5hiaZ73PLs9X0V70SL1zfVd5INV2lqwbAm9C141d4VSuKYQXldvJnsVQ3GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591767;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=ptR8YNq0t3qSjLJsQtv2Drkc4wN216ICw9d6zYksgEk=;
 b=YRzYGz8WTla0Mus3xfqauDHPcHdUpAFQf3A4AidBg//ueF35RrAAgG8U2YZ9W677aFrR
 EyIqgNu1GT4riEKY5g3e+kNo4pUGb6MBNCs/rAQSxR71084qsAg4dpf7I+Z4coA82a/z7
 PwoOTtfDqN1q7gAEknGCH3SifaeMkh5NeuC0z/XAW+ZAnHhP2RlQggoHhPtmEryOyNA4x
 Ni7PMUduv2jk+IBsSdgv3gi/EKbMC+/GWoIYjcX+eCv0V1pNkc/ICCaye7FHLhy/KuVCd
 ESc/jpsWcpYkzvcnPgT4dxtIT1W5N011dUZZoxV7lpwnGMnvu7G5ddiOz8X7vPGj+TQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 185816069C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:26 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxF-00000000243-3mqW;
 Wed, 21 Oct 2026 14:09:23 +0000
Date: Wed, 21 Oct 2026 15:09:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 03/11] boot: imagemap: correct the lookup guard rationale
Message-ID: <29d1a8de9b9e6e202372d4397480661782b1e238.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The comment on imagemap_lookup() attributes the need for its second
guard to ulong and loff_t sharing a rank on LP64. The rank wording is
wrong: loff_t is a signed long long, which outranks ulong on ILP32, so
the subtraction in (3) stays signed there and an underflowing offset
simply fails the size comparison. It is on LP64, where the two have
the same width but different signedness, that the usual arithmetic
conversions turn the subtraction unsigned and make it wrap, letting
every range appear to fit.

State the actual reason.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: The "same rank" wording is corrected to "same width": on ILP32
    loff_t outranks ulong and the subtraction stays signed, on LP64 the
    usual arithmetic conversions turn it unsigned and it wraps.

 boot/imagemap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index b004aa1644b..0a156e010ec 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -72,10 +72,11 @@ void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
 		 *
 		 *  2) img_offset - r->img_offset <= r->size
 		 *     The offset into the region does not exceed the
-		 *     region size.  This guard is essential: without it,
-		 *     the subtraction in (3) wraps to a huge value on
-		 *     LP64 where ulong and loff_t have the same rank
-		 *     and the arithmetic is performed as unsigned.
+		 *     region size.  This guard is essential: on LP64,
+		 *     ulong and loff_t have the same width, so the usual
+		 *     arithmetic conversions turn the subtraction in (3)
+		 *     unsigned and it wraps, making every range appear to
+		 *     fit.
 		 *
 		 *  3) size <= r->size - (img_offset - r->img_offset)
 		 *     The requested range fits in the remaining space.
-- 
2.56.0
