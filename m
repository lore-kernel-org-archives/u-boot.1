Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03260A2602
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uWXpCWA7;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tgrlAgYm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62FB8607ED;
	Mon,  2 Nov 2026 09:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqPj5cH8jN52; Mon,  2 Nov 2026 09:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80CC1607E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613526;
	b=QOCSUDuGvZxt2IcUflDlKAKM+aEwuZyLn+LykBPPnsyEQ3kddp+9Q4tZzkSyPe03Cd3c
	 2P5F1InagvqGvXx1mzcSKNP0s5Vn9Q/jU9x9K/blcF6zpY761acXR3uVxvMXr6J4eid3m
	 rkUXQE4ZFkwkik32Dg1xmKxnlqx+6AN6l1b+uR6X2aDJwLMLrl4Oqfze/Ev3+zu2SFYTp
	 RhWyfaMupBLsoC4Qz7AY+EgWIn3nisQLaMRMx7YEi5bdyh4mQ9OVS+3GALfUm8geU09qt
	 T7czApUUrPMOm51w7MGAC5GCyMAznL+zVo5xEVxyCcmPPEAxQkvSuntwwAQk5mKvcnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZKWrxRIJKXejAczn+S4YFv7yCdQYvnt8bHAVU678re0=;
	b=YBpGxZa8nNtRko4aaB/ElkTfZwAM9gxsdc0nTLotQ23NICfu0weS9UBEkr2m8mfCvOAC
	 o2jfssjNqPlhWkPsp39VOLdr4/KCLJglw67+wIoL/ojM+RLRUpOsJ/bbtq3pD7fmL4P5X
	 cweX4qf/vg7JIcGvvAexumnKpJUP8DT7WTKx9s4PhSTMmcdSOygbSzSKGVAwWZkfIzFAs
	 hkTFEqBtTIZpxqh3H1DzCNlm5muujrNCQCoIhahspX53asutgHSW3NUdQ7dvQaApqA4jH
	 hgPqVWYX5r11vHtaY7TxYu55k/vd8Cd/YyEoUbTULDu8oZu7tNdTsF7j0jOMI2qsMqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613526;
	bh=ZKWrxRIJKXejAczn+S4YFv7yCdQYvnt8bHAVU678re0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWXpCWA7hz8bH7Gf60c0ksPdAxvwZk30EnHRn3Rr2HcR1myGiVyJ23x5KDGqZa/E5
	 B093VGJqdGF2tewpf194kh3hfsndjpzQUUmj3XKRI9B6Hyd4GXLXG/d+1pVcG3yI6+
	 jXAxKS5QkewM1uVhM5EXraDzm62+7P1NPD1S506c4uXrB+I7pROs1rndjKNKTlcCo0
	 RgjUdOwkPO5jMiyz0bN8+zV4l1hftXlb9xyHjO/l2/x4GUDJbK8hLtIuoRNwz57khb
	 +b3XMmQEmZoQ2yi0AlaKYcxb0VqeV18FxGh9kFxlGaXneCaIKi9nLd94v4uH6am/1Q
	 9HAH0tDrUdbMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80CC1607E2;
	Mon,  2 Nov 2026 09:58:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BC80D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D3124066C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrZAIigq6X_Q for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 360A7405CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613521;
 b=O1DPwkhDmahXIpA/quNeef+Krs/M2fJeLWPbzM4wQsFv6EA+xn4/z3MN0aPYfEYz/oiQ
 z27gT7sR5n5nhw6opTXGktZ6W/WqSP0+yqldHz+j8zd9noGOU+ein6j7eIreMMO5XD/Va
 cNZ0BYpEMyh1YNynkF4v816s7fXxwFxf9+njzwBvKh0RvbAOeSpyHIdprytrKOACpxUwj
 ErzpDVAZO/atYKs0NZbGNFcerP/DD3OsCSTRSTh+hS45iPBjq+tLDHnp1G8bhEweX24to
 RqeKrJDlWQ+Zl6mjxc6KXMw5y4xmvl7SjqWZIk4S5weEm45rKthl1YNRZmoeDM0XXEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613521;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ZKWrxRIJKXejAczn+S4YFv7yCdQYvnt8bHAVU678re0=;
 b=NdsMm4ztRn+jB+I6DUsrL5rRR7Q+Dq+ipusmwNr5/GeQvgl8xf4CzVJBZrNQth1bI3CA
 5bdmjKBlrNKS44z86MPk+v4AwpZ1orCS532l1V/of8pY33nINas4jV0ALeiOjTylcTHXD
 vldInWCA358EwfoeyVzZzEQKT1+GS0+ut36Mm39Pwkfw8np5qhWMjYBmDdAQY0/GeKJGy
 pTRG2W+nPJ9eg68q87b1iPRht6aeuRMWCd+MJzXmRXt8Gm4tgM4cXdrLtwaQmyxSertPo
 YB1NRslUikYWLyoM2K1Z38H258Ln5Fn0cHCYEANyHlpHV0wunRd16BazSF+GfsHvC3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tgrlAgYm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tgrlAgYm
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 360A7405CC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:40 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so17251135e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613519; x=1794218319;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKWrxRIJKXejAczn+S4YFv7yCdQYvnt8bHAVU678re0=;
 b=tgrlAgYmMHFZnO9EYfiqwlJdL/3HEvdaP3x3IG/EweckqewAGCkPoEZKUUIONHV4FY
 euP2Gy+UDjk6F+Bq0GqT6/XVzw9qwWHKKrylRrLcsmQsU/Xm/BFvJCS/f9x2y5G0oekI
 CuWLCWTE+OCWWbR0V1JYqxNrz/nnbuluH33g5FOwyhwlXPEPp1ujSGKbyhOozcMUH7Kj
 8n4F0rchDSzlcK+0WmuBP/uhEfcgdyJCc6+cJKMtC9vAsYGMG8E8fltfb7WxQ/EAZrSq
 H2Kiy8TYRbsQfjyshoNZzvnhluKGW8GqCGPkawT5YJbeo/AIqlbqmDqcvycfntpi94cE
 kCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613519; x=1794218319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKWrxRIJKXejAczn+S4YFv7yCdQYvnt8bHAVU678re0=;
 b=SUN3QE1Q71d0LmxJXrGIQwMh+dtdy1eAp01yyRYFkPLMMNMKRGVT0NMV05FOKEYZ6S
 aZL7fLbVqTNSpRINJW5+9sR6ogqhGb6plW/ibtksxLD0OqV3MGVCOejOMSvq2Z/8oiDU
 OvVrJMPEBhHZX260Sq9VNoay2WjqO2wgcnuxzTm7FJuEoYUtNqpgo6AlTyGd9I0ETLAc
 Bqk2dvK+tq14igIfaS+vr49le/2gjGa3JvMP+2KYnnStOIQ55dapPcTH8+LATZUN9z6n
 hV1IDnA3RBKUxrQS2/14z5orBlTs9l5I9qWIe73cNAD/ylBS7cRjtA7CnkPP25xrYcDQ
 IcDA==
X-Gm-Message-State: AFq9FYJM2Syfmlrg0pFRpsDcLpginkCnXcJBIjYMhD6qLJc4Uew6HQhg
 ELF5z/2YslR5ky2maaxGJrc4+oIKu6oReRJUQaS86XnCpgG5B8vEbbNgzxXgG7CPN+PYN2gY+XR
 OXfLsyQV47g==
X-Gm-Gg: AYBFou1fDFLz/AGDNrBldovFM8/G7YfgqkKsBqk1uN023CfGCFQKpuWFLz+PL8xlqeA
 +IIz0AqJW3UwDxRDN0Zr0HLdvwx/80qafNix0waKyQ5DL/KreeBdmvZu4BUg9EZeeZwqrWCEq9I
 RumqmVv9UebsOrhgGR64i6O6zkjNsQB9rVpttJiyi7+0qU478elN7nst2mshODOTb3b7VeTQBG7
 x7nwueY2jHmX1k29yvCJmFFIEcTwDKfHKVaTQp04UJcp/o2LD2MuYLnTGtCryVTSPCkgQt/zLE4
 6wu98sk1XnEwmT1YBixD88Bn9G0hPYagtPT1zocCsUBzepW5GI0rN9Qd73CTeLQkpWTi42wHots
 OzHFJPUed/HHdR/pCkHTOB8yupOYa936N6JR7nWTHINs0E84i4b7Mcya2H7RAkTscSdVdrxs4fN
 IsmmUcs99qDG3x4rEX2hqFrBxRwYauwaT7lmc+0Z9lG4HDr8YzMiktVcKHzR+L1cQMBBRvZrpfW
 GBSSXQ6HTjgiTpNZB+0Zq33VS196yGmWL4hq7wC2V7ZatahaLt4T4rj6Xr+hXcgcCbCMPqAxYeH
 qAHJXmVvW1WyKIwEXIU2/1m8wSGBw45+jFgIZvyJSWW8opcUCQyXOtWZFylhBmTToNCG5Q==
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4ac187a6ffcmr228800755e9.29.1793613518830; 
 Mon, 02 Nov 2026 01:58:38 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:38 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:47 +0000
Subject: [PATCH 2/6] binman: btool: lzma_alone: Update version function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-2-f1f547c4a731@linaro.org>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lzma_alone 24.08 now prints its version string to stdout instead of
stderr which means the current version function will not find it as it
only looks in stderr. Instead look in 'combined' which contains both
stdout and stderr and so will work with older and newer versions of
lzma_alone.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lzma_alone.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b..aa44c897223 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -116,7 +116,7 @@ class Bintoollzma_alone(bintool.Bintool):
         Returns:
             str: Version number of lzma_alone
         """
-        out = self.run_cmd_result('', raise_on_error=False).stderr.strip()
+        out = self.run_cmd_result('', raise_on_error=False).combined.strip()
         lines = out.splitlines()
         if not lines:
             return super().version()

-- 
2.47.3

