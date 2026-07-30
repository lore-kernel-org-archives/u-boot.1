Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804CBC5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BAC880FA7;
	Thu, 30 Jul 2026 18:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id laM9l7W2Rr4q; Thu, 30 Jul 2026 18:41:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C5D4811E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436883;
	bh=JCRnIs69CABpUsB94SHOgNaXVpUxYNWy8RGkhbQ/b/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DcbyjKCLQ9akjZOOArMWF7CCUZBRKSkBIPYj6hihHJnD0ugyPCRT2VkLl/YP/YZ6r
	 WcqJUADcgt2HGAG90we/egI5OOA62BGqIRV0etMVK775ouNDP51hyFv1m1VyHK/ZDU
	 DC9PZwdpv7NHOghC310t41Tznav03CjijsaGaOahGMnMeYMCcFkOR9AujjAS5bVhsL
	 2GDRKMOFb5Vt9tg3a09Rh25VPFK7yNwlQc0mV0Rtzw+EAPVbpBmP7BExOz3TIuHArJ
	 a1O5CWdg8VVYfjBsxdHpmh9Xp5FPUoqxdsMP+n3f5O6d6Syxau3dSQcLUoVpNgOx++
	 V9NzYWJWy1XWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C5D4811E6;
	Thu, 30 Jul 2026 18:41:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F53227C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8503940420
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id egZVLINq8lrx for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 39D3240094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39D3240094
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39D3240094
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:19 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso38370f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436877; x=1786041677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCRnIs69CABpUsB94SHOgNaXVpUxYNWy8RGkhbQ/b/k=;
 b=Gj3icrMlmBI9hA3pCuyZROvKEQZraKxBURpnuFC1n44W/Q87IPU+DbvFHa+uU4dsKt
 S5hQKZnXNiE6ch75UBrTbxu9ncAFZHW/CIEvJ/B3X+cJsWvYsS1eVmNSJkU69e+Sju5F
 p+XR6RPNmSugFipnx62MdBAWlK15V0lnpzJ2SZGQlwt6Cu3H2SXJTc5iO92Rnjh30Wr+
 bIw1HYYgPIh156YL2zlI5y+Aemb2n2rzvc9nNM6+Y5IHnBOy/QGXcRVDtDJ7qkc4l69h
 TfRi14c1RlxNqma93zMwKO35uStWVNYEaLEdAd/BCUP1Ygk0TSkSUElooCyrwSwDORLB
 1VIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhddnvmBRpRgtVJ6EMF2xI+hfP7LbumcEiGljNLdmuC7rXg13PenruelHUV+K2pQ+4qeXuLYw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwcT5Sx9S0kxrRLoumeN6fDHuicn5jLVOBVXrB5tENCLvDYLOJR
 gteUGl2XA7Oosoq2r+YFTKQXw5f9XjgpoJuitMsYzcSS4vAZWUrp1K3T4YwC3rLKlutFX0OCW5Y
 XAPmgzbaTIA==
X-Gm-Gg: AR+sD127MGRyikqizNNYbjj5P226pMtR67paiB/CRtLriMJpN/ucoerPu0fHsap8MGc
 rVQPUo6vFy4NPqjnWb1QuY4AkamJiIDtOugLKGdINfS+FZiZ4qAozQzVW9qy6Ha9UnIA6KhXmKl
 lN2sY4ebPcgubzKT/IM5C5q1DPXCS+W5NA6W3QinXkJlXtg/cYXkt7coxiCDTkH28i1dbWrT6Cd
 U7e2Za3f4z9sh93QMqJhOA981E2BOUJcNypcS7FkqP6Pvb4Pwo8dZ5rZJsZHFOt323W6/Knb0Q4
 Ykw15C5XMQ1JtNNFx0jChF6UmKG7Txkz8itL+ZNqQxPAjGrtWjn5lPIzFIiZrNTozBjOExpglsd
 im4RQ9V29zZG/DqYoZb9nSxuRai5FvxUJUg3p8BcfHPNy03bcDzTeIxh1EfLN4AceadFY5B7wfR
 7lm2ZozqghllserwX2eMIAgkemd+H5oywuOwDQVp+SUeqGIYjd/LuV7b0o6JdIBPfelyFMFRyj3
 nR6J++4eejDdwM07STcJqueQO/auddsAGYOYJhD0g==
X-Received: by 2002:a05:6000:381:b0:47f:9567:e63b with SMTP id
 ffacd0b85a97d-47fc821713fmr5542458f8f.55.1785436877104; 
 Thu, 30 Jul 2026 11:41:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 22:40:38 +0400
Subject: [PATCH 1/5] lib: div64: fix off-by-one shift in div64_u64() and
 div64_u64_rem()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-math64-resync-v1-1-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=alchark@flipper.net;
 h=from:subject:message-id; bh=oLa0qyzvyzp6UGBIt25Bzc8E0ECieWnuRBCDljZs1Nw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlzzri5DtP7UsEm80RqVCTjsLNZl2bLuTcv7fXutS0z
 +sN25ZzHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1bBPD/2K97oqpX9btuLI3ZDJf7jKdp3Y933Unfgn80TPzo0m85SVGhq1M7FY
 n7/kd9dFjuhywi+2ZVXfF4VrDbPPYI0uZb87z4QIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436877; x=1786041677;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCRnIs69CABpUsB94SHOgNaXVpUxYNWy8RGkhbQ/b/k=;
 b=N5J5ur6mEnL/OqK/C8fJACa4Meep39zWv7duaVBSmXwCX1en1HOCskEzibSp7Hkg6j
 Y00IvYc5Fo7orjmtsjWQiXsrZZAXLqBu9IJkQ9uFh+CbNGWSEJGGt8eoEj5tuElIKh42
 1c0z90kzo4ZlmN5AZ3i61OgnnnU2RsHKslRK8FljUq6GK9echziu3+Di/oOmhV1h4dDc
 LobsXsoYLXFbxs3k14uZyNwNbAH7GCixE/XzHvqofPqb47t1s9AqKWLXC41sXeptZD9u
 W54/IJXuEm7fz7tHjNwOPRUJMNXxZ2sK4SMZ+ALGJ64w9bjCk8zoSU+C7yRk/WvqWUxo
 y6yQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=N5J5ur6m
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

fls() counts bits starting from 1, so shifting the operands right by
1 + fls(high) discards one more bit of the divisor than intended. Both
functions estimate the quotient from the shifted operands and then fix
it up with a single decrement/increment, so an estimate that is off by
more than one cannot be repaired and the result comes out wrong.

This only affects BITS_PER_LONG == 32, where these are the out-of-line
implementations; on 64-bit the header provides plain C division.

The error is only reachable when the quotient is large, which needs a
divisor just above 2^32. For example:

  dividend = 15559272575191414037
  divisor  = 4333540799
  expected = 3590429465
  actual   = 3590429468            (off by 3)

A sweep over 6.4M random operand pairs, stratified by the width of the
divisor's high word, mismatches a __int128 reference 8260 times before
this change and never after it. All failures have a divisor with one or
two significant bits above bit 32; uniformly random 64-bit divisors are
closer to 2^63 and yield quotients of ~1, which hides the problem.

Port of Linux commit cdc94a374931 ("lib/div64.c: off by one in shift"),
which fixed the same code and cites [1].

In-tree users of div64_u64() that are built for 32-bit targets include
the Aspeed, Meson and Cadence TTC PWM drivers, the Versaclock and
wrpll-cln28hpc clock drivers, and the DWC3 USB core.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202391 [1]
Fixes: 0342e335ba88 ("lib: div64: sync with Linux")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/div64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/div64.c b/lib/div64.c
index 779d7521f69f..14d402ce4c7e 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -109,7 +109,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 		quot = div_u64_rem(dividend, divisor, &rem32);
 		*remainder = rem32;
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
@@ -147,7 +147,7 @@ u64 div64_u64(u64 dividend, u64 divisor)
 	if (high == 0) {
 		quot = div_u64(dividend, divisor);
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)

-- 
2.54.0

