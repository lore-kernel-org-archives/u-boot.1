Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF7606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ypeRlzCS;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=jtJapLX9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BB18607B9;
	Mon,  9 Nov 2026 14:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zzZrmw6bsvF; Mon,  9 Nov 2026 14:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E61B607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794235411;
	b=BlbxFKVWx0MyuiRgLhrCWg+K5E1pvhxKF1T+s3jVCM/kpVE9Mxi9VzKvi3H3fXkPPJJC
	 ZJqQRxQfaTKgSx7Eye4gUHL6u/K7/5QkH3aGsnN0m572xv+VehwWZjC9VBP0nfHSUF7w8
	 0mPxrmWjURVrgjdmY4e32vAH8rR55uYJyqdpsAnNCie1lcsTNtNj+CLHVZO2pOCJPEn64
	 HvP9myqfwhejiAxHW2L3iLClbbzfesjT2XrAhHVToqJp18KemqgRpvOuJvMOTJXxNlr77
	 xpDZ/sZWparxOAUONbC6SAk7JaFQWXiRSRg7nnmrLA5VSZ+V8RIkPtIt4AHDGD+bvlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+Za2trCwcMzQNuUaTUFlORbUPV/d785x+QRMa5g8rbg=;
	b=UBRo0zRSsVyUkMRZ0jKY/AhmIzIN610qCD7K3I6XE/BMUy5tSqUE7eRSwqYP6sOxNQGv
	 CPuyZHj8L+HKqg4BoEHlFRRafBKins/o4911bXc3+onVqz++OCSvKeDsrGJLt+4veClIU
	 7vL2dPFX+wWylPHLiWO9u9w47WajhbncO9LkWnGuieYzP6My+2UxsoI+or5dHNsXAgnxF
	 aZoMIRUVRd1BELb+YLMGGszjP39nV0/6WU8GmBx4pdemq+xizK5svFTasZ7goJ+bVt+MK
	 PXTo+VbufflqaFxLrrzkwdJWFQ/NmZlgvZEHabinJBL3o0ZQmmSCNmLbXPwhjE0Mihg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794235411;
	bh=+Za2trCwcMzQNuUaTUFlORbUPV/d785x+QRMa5g8rbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ypeRlzCSy6Cr+oFv6wAJJB4aDPrNPb7H6JlASdpoCuUcAPMUtUGjWtZJPW18474r+
	 0xWaNzCoOP+EZ47B8d1QIAgWg4qGtnVKUXj9sXHxYj15lfyQj7gQ+2fYRuSuXpRfsv
	 n1422N0D+iwS2UbUDqCrgXjSbnfj8n6J9dzsEsf6bNbpiqJhsXOHQ6FC6FeXTW6mMg
	 wshCFN6azP9Wjgxa8JOUcHk0Is5BtqtfcmDQKSPo2ZUOu7V92oOhU2BosiFFk3sEVd
	 Iutu1bk2ckKs/PfJVMIp3UmC1vtUYkJCkq5pZEywherHH9DkIxZCwT4CME+wB3OJP5
	 d68KHJuOpGQPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E61B607D2;
	Mon,  9 Nov 2026 14:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46F63235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D4E280D3D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04dC_AqLeFiL for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 97DAB80F75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::42af"
X-Greylist: delayed 837 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 14:43:24 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=jtJapLX9
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::42af; helo=smtp-42af.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::42af])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97DAB80F75
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:23 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZx0KXkzy94;
 Mon,  9 Nov 2026 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794235400;
 bh=+Za2trCwcMzQNuUaTUFlORbUPV/d785x+QRMa5g8rbg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jtJapLX9cjf/ui6UB+eHAm/lbWaJVi3Dp0lrk6Rcc8UlX5FSG8ocZydTpmYxocHn5
 LrwXFix+qdLHdt+D4qcluFUiNSW0jcuD3OLjfQTphOihnWNtxgTij1wRUnryOxz6Br
 ndnxOJG+yFpIk9XLSoyhoJ/tYPvXeqA7ldhv9GKn490mIB/PMaMNGaEAG4GOHydOAO
 QrKPebeFbudCd8sZ5x2H82oh2sifJQq0lACjcgWI/qkTAiQf/nsNxPen8uUa1JW2b6
 is42nd5TAaB1yV0snuEUNqlfxuCKaDKnShIE5ebjolVv9OB2GfV70z9X37SG9Efhcv
 DVp2xZW6oWcbw==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZw08FHzsGl; 
 Mon,  9 Nov 2026 15:43:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:43:08 +0100
Subject: [PATCH 1/2] doc: arch/x86: update link to ACPI specs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-linkcheck-follow-up-v1-1-64ee7d115a6c@cherry.de>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
In-Reply-To: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The current link is only for outdated ACPI specs, so update to the link
that shows the latest versions of the specifications.

Fixes: 3b17ef9f7121 ("doc: arch/x86: update link to ACPI")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 9ba5c2893379..e8d753d1c7be 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -486,4 +486,4 @@ TODO List
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
 .. _SeaBIOS: https://www.seabios.org/
-.. _ACPI: https://uefi.org/acpi/specs
+.. _ACPI: https://uefi.org/specifications

-- 
2.56.0

