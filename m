Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB07606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R+CH0B2x;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=W2ARVyzp;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Y5vniZgr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4D1D80E07;
	Sun,  8 Nov 2026 19:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25kO4I6xcxJ8; Sun,  8 Nov 2026 19:56:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DCAF80E29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794167809;
	b=fABReOP07zycZV1c0e1eaDz3/uScZTBvBalDz5lqrlFkbaBYQvjlW1zRc1PS5U9LIfcN
	 Izgb3+W7crpcMLcfSMmaIJAEfOFVulSa/kXqugAMzzzJXLraZ9muGXEmN7DngsLxLKJPT
	 YwiCnHw+6E/pAaXjrMCaF/oXyVIXfPqSUnisKBhe4MPyQsc1vMqZciHX67YuyxxN7kq2u
	 c/xjwGoibJIK6zyoLSiiJu2NsAnIPnVb38H6tVl/Jb8SA0w0KEqb/VuyC2xStD9gnzMfI
	 Spq2Acjz8ZKGm6Xu68p3XFHc3C0h6VsBPykKKZkLfRV5blQi7BWrZ4jU07sGJCKDu7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794167809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gF6VB7nyI556LfthM9AgH7i+1zgwPgx3j2lV8DwP0ro=;
	b=MhBpI9OBCx9I17zgNVIKPhkRMEPHJFbqzcQoERsVHpv12wBlPnWCZ/CGy9kSEj/p3V7M
	 /rpsNFwbAUofOrjYCiOg24AEVp+T/DLjEZ2QKWcK4+Ph/8jNnb+NWXRTRbKKuAH0nTRT+
	 M0iBRTBVkgCsSgAlTUvoO1a9yxTeJhMQYeAFm5KZh+xUN2EoNMIPtMebbxVlMUXzBqBSI
	 FtAtRunGwQbVU+5dfgwcgArs5dq+ZguBpj+0MNcxkewFcQ9+JfLLriCXgPOCTn3m9IQrs
	 gfR3EItF19cdYbeDZoHc4V/BpXavr7WCkePxGelMipv/s2SPfmUuP0njCJPCvtqKkLg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794167809;
	bh=gF6VB7nyI556LfthM9AgH7i+1zgwPgx3j2lV8DwP0ro=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R+CH0B2xUQ8eq8mherpwBdtdHMwhIP+6UfeOfurrFcFE3iMMwOsp7a4qIOuF/UF+9
	 UylN/ee/sPG0Mg0UpDS5eWCmkkCbFAZwsxv2jTu2z7Uyzf5lCE5gdBVqG5/y5OTibz
	 qoPEKtdFnfG2ejrzEGyfvBuxyrSdN9kvVCREovUmlmBgXpCT/2NNYCIscyG65zagXg
	 UUAFQ26psCpO9F91m8/ZCNnrA+Il6BKdyTX9QTQ7B7e7hVdHFAKKV/Omw26tcsKtCR
	 km1sf5yqEbAEGzhXzL9jUv7x8yGU5MvE8AooRIK0+dJhiK7ZCJs/2QTe9RbBGeBqlt
	 ejSgezoR/O/vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DCAF80E29;
	Sun,  8 Nov 2026 19:56:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35C85932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 19:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B6164061A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 19:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1F2ZIxFPCqsv for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 19:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB489405D2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=W2ARVyzp; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=Y5vniZgr
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB489405D2
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1794167803; bh=gF6VB7nyI556LfthM9AgH7i
 +1zgwPgx3j2lV8DwP0ro=; b=W2ARVyzp/rZmUHg7Ykob+TPibECRvOWI4ApwaP7HwZBn5YjC0e
 xp5KcNIWG3NhaxBWm3DultQwi+jwfyhKoDmvH+6w1uze0Xgh+jQxuS2LqN/68ieAIT3SGjAtBQ7
 FDXdP8FpyvEjFSFEGkNUIlmsr7pWewNbcBfgQE5upNXPHPgi9d54q+1F82xNXqENqk50GwBAeCb
 BPmAhWVZtJVbUZ4hK3Gu6azk1d8W74kfqOgm88lE5PaIMEP0yzBdeAL1y2RkHm1ZoQfR5yePXFC
 /8Gqi7eGgl0rdhcp1h9OV+T+3M0gKqJGkCGBjALYjw6cDM5V0ZjgLiwhIVmE9hDH3pg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1794167803; bh=gF6VB7nyI556LfthM9AgH7i
 +1zgwPgx3j2lV8DwP0ro=; b=Y5vniZgrXTtYHMEwX9a7t4PP7dxVRPpw75cJ3pJh+8yU+RxJRJ
 flMNM6Z/gmM1fWGVLiYHCBWC9AZu1Au+k9Ag==;
Date: Sun, 08 Nov 2026 19:56:44 +0000
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
CC: trini@konsulko.com, tomas.alvarez-vanoli@hitachienergy.com
Subject: Re: [PATCH] powerpc: time: Prevent overflow in usec2ticks()
In-Reply-To: <20261107214850.3208042-1-brads@mainlining.org>
References: <20261107214850.3208042-1-brads@mainlining.org>
Message-ID: <2E9AE14E-2DE9-4CD4-AC7F-FA0808A4DC12@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 7 November 2026 21:48:50 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>In usec2ticks(), the author of this file indicated
>that this was only intended for "short delays"
>for example, it would have overflowed at 10 seconds
>at 400 MHz, which is quite a hack.
>
>To fix this, use lldiv() and 64 bit math in order to
>compute the tick count without the overflow, then
>clamp the output to ULONG_MAX so it does not break
>32 bit PowerPC boards
>
>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>---
> arch/powerpc/lib/time.c | 16 +++++-----------
> 1 file changed, 5 insertions(+), 11 deletions(-)
>
>diff --git a/arch/powerpc/lib/time.c b/arch/powerpc/lib/time.c
>index 0a0e75e726b..120f1fcd0d7 100644
>--- a/arch/powerpc/lib/time.c
>+++ b/arch/powerpc/lib/time.c
>@@ -6,27 +6,21 @@
> 
> #include <init.h>
> #include <time.h>
>+#include <div64.h>
>+#include <linux/kernel.h>
> #include <asm/io.h>
> #include <linux/delay.h>
> 
> /*
> -------------------------------------------------------------------------
> */
> 
> /*
>- * This function is intended for SHORT delays only.
>- * It will overflow at around 10 seconds @ 400MHz,
>- * or 20 seconds @ 200MHz.
>+ * Convert microseconds to timebase ticks without overflow.
>  */
> unsigned long usec2ticks(unsigned long usec)
> {
>-	ulong ticks;
>+	u64 ticks = lldiv((u64)usec * get_tbclk() + 500000, 1000000);
> 
>-	if (usec < 1000) {
>-		ticks = ((usec * (get_tbclk()/1000)) + 500) / 1000;
>-	} else {
>-		ticks = ((usec / 10) * (get_tbclk() / 100000));
>-	}
>-
>-	return (ticks);
>+	return ticks > ULONG_MAX ? ULONG_MAX : ticks;

NAK, marex suggested that this would cause additional overhead, so id
reckon this wouldn't need to be fixed, but I'll keep a eye on this and see
if anything blows up

> }
> 
> /*
> -------------------------------------------------------------------------
> */
>

--- Thanks!
