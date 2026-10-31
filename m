Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FzTyAC7T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16FB08115E;
	Sat, 31 Oct 2026 11:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFByLjTHsWmE; Sat, 31 Oct 2026 11:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 674B9810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445040;
	b=J5EmMjnJMQec9qWO4x89CEG06rMP/DRkw7UZofDN6mrSKpGZCi0xnErEMsFNg8Coyn3C
	 QSFC3geOLgC9IT9y3M0dboDZ11drF9Ioxi+C7lIIrclyYm/V79Scq08ykhwJLw+p+SFyA
	 wzU0WdfU82O59jcGTj57DtyLHsbeGjzKHw09jnpbsp/8xKnISDzy3jgNMF8b6jwCmvAzm
	 t0NfNDAajFnqGurOvK2LDOIOR60isyNRDKyAULJxxg53OvLPoDE5X+aaztfba/ngoUXBw
	 RCYrt1eh4ckoMLFfCr3slHI1ojitQTe+8LRtrEEiApfeD8dnrTuIF9dp6oGnpw/2rQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gden8yBx8SPTk+uqz6NbUC3TNGBZ5ftMaxB43QSDXtA=;
	b=bHvKFJXJEHOnRLZxohGZsi4knp6ATRfJEqygHOqnMf3IR6LAguXmv1CJ18LDOckmoGMO
	 kWVCIw8rQ258KlEF1EQJUSeONe3RrhI6OSN+XnDCJdQOzYNVPYOY7u9aAqjR2iK0lUlhV
	 8hDAq/60kXxrql3mU2UBQYznvbsRuWnI3ddP4rMJ6foKoawLgN5Vo+OBugtq53LmXJFON
	 L//SZXyvlTKh3QDWxrdrtFq/xNsRcw9Sxq+qu6mAPTFM4sFEK7+Z1zYhPe3ezg9/f89Ev
	 gygkr6jNrR0kst3ny24UaeBONaHYgdfhh7OvHdYiudkArg2dCQjCcrPCBMaAq4ukD2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445040;
	bh=gden8yBx8SPTk+uqz6NbUC3TNGBZ5ftMaxB43QSDXtA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FzTyAC7T99sPVBH61PkC4MwSvfUZa8x/PQXbL440eBgH3URc4KgHXOm+wwRWjKJp/
	 m5KzF03hEnl09H4W7FKDnF80F29HHOIoTiEk9u244yqwoWJ/AHWOjMVHjYkBLWGLUT
	 kl9JrifUAYlPIdZiRJNJJxeRj5Klki47+ifY6kbU6YK0nLTVP1nRm9JjlSnmS+J+tl
	 hLYngZQLjhdAztRGP3PELQ4Q1EpBMUSN6UIVwxmASLIbfsiybGKHfx0m20UM7mKTIP
	 EMdqK3gL5vnaSZp4Ty6RbwbiqgE3dTAmyExBmz0cq/ekyiwmqZT14ey8Z3cuezzMps
	 bTp6yn+e6SL1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 674B9810E6;
	Sat, 31 Oct 2026 11:10:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2BD12C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8F1B81127
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dysygPMZ3hQ for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2703C80E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445038;
 b=S1ssq2LPrdVZLqq5eYJ8MNo6cU393TfAF/QhgQ1Bd5P0574ElC98OEcFuoiydm2iZDMM
 oFlbPGY+L41bxUcnxndmkJNWo9d9mVhRRABiydiyT0/woGGq11BiVO35DB2r+sIK8t578
 tmLMAW22CeJ9o3YPk5516vQt42idpg8M6YVwBft+2PVl7IWI672jO1cGsytgkzsBn1+u+
 LBtLxW6z7KZZiDgDX+pinP0jVHa93iM2Bkx59mjQjEIe/aUzk2ptcAoHCWHm5i6jlWzjv
 JF06WczL2n7Z0QYRlWffPToy7eLmIowG16eXmHPumOPrKS2ENOn7Pfu62hgL5QdZdQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445038;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=gden8yBx8SPTk+uqz6NbUC3TNGBZ5ftMaxB43QSDXtA=;
 b=fR7iPwvNvEOBXGZ86QwPNxdSPnUpUtKKSxwuncBvePSetIv/qt3BpUN7tySKLvFO3rdn
 aXVBq+A8qaOpje9fKe1hHvqll3B9zKp29xU4DsaXitNh0sh4nXcg05jLwd16eJof1HAI3
 VP4YFJlQedNYUR70JHuxANztD2JQ8lgab5D4H6Tdb/HYGRwO/5MikDuNMURrvfAChfxNO
 84rRxpgix9N5FiJIRxKJR1T/z+AzkkYXbLMQoywW9QizHKNocEBQyBGUtRCtoZUv2GeUu
 5r69gKF9Ixhs2KNJyJfi+y472WdeYmW7abnbPgZtOGazX9Q5VWBgJ12krOrn5gtbDag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2703C80E3F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:10:37 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6vg-000000003N6-0hrX;
 Sat, 31 Oct 2026 11:10:33 +0000
Date: Sat, 31 Oct 2026 11:10:31 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 03/11] boot: imagemap: correct the lookup guard rationale
Message-ID: <1d6a7929b1e37e8d9e8140e17218e84c62b7a45a.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v2.
v2: - The "same rank" wording is corrected to "same width": on ILP32
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
