Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F037606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bVbrFUT+;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=oQRaH6Yq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BBE8403B5;
	Wed, 28 Oct 2026 18:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4YPKf2nUs0C; Wed, 28 Oct 2026 18:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1B9A40217
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793213214;
	b=rbjO6wQ6aTzhvA7oEUDEeynL5HAdKsBaI0slAftuor74Q1G3jNq2AfS32eUcdejj890p
	 ytEVcP0hMytLOtSsK7ccU1jGB5g6lk7fj0K4Iyn5I46MxXfMOntqMbJ95WJ25cJSdjkDX
	 KjFrdlKvrSPPoEpEumtW7NQa6j1hTsRiwRjaba138KIeUqMcwPeaCV/Urgzxpw/P5bH8X
	 5xIGREL8gquZz8DvGfUCJY57h54iTo/1NEOreD6gBhPB8sU6QSIywI3Ouuljy4SVIgnI/
	 RBnBbeXSb4UTSlZ63do9xVWcS/tqCP7w6N0C4oHuaP9k8KvDLibioLADQSackThvMmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793213214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3b1Yc8NAM2aBtvL+k983e1DfG+deB0YM47VSlBI8FZE=;
	b=H5i3319XGOmz/NU1q5DsFs0Ruav61lD6M1/S7O3E0GX/TKXVKLjMybrJxIj6GS09LjYn
	 kD3dowbtMGVAG8tCn+CX8qtY0XpM8rtmbpKLzeGpHWO/8lkHP5m7d51Be3R0+26khJFT+
	 t2rrdphEQPhICO6KY9hObAIVHj1eB7tm4g45cO2ufT7PlC7socpaumVf+F6vLLi01FfJw
	 cfn3/CGBjXmniurWUtiMGDIJuB/NHqwCrGCn2YmxIlkPBRfWMdZt6h92r1Iu7I9S2ZCqo
	 5xBId8Q6HcweFD6Uk3ya5oEm0IAYQD8GMK2V247MA3QdKzIoH/I3Qz5PNJAPXb3JAbg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793213214;
	bh=3b1Yc8NAM2aBtvL+k983e1DfG+deB0YM47VSlBI8FZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bVbrFUT+fCHvu7pfQoxCCUdLyQxH4q2kYls8SfjxSGsfCOtOBJJNtEZi0bsCMfmVH
	 lJUIoJy1lLssReLeAR3FhUZyW+l32IE8+v1zgbPx6S76pco3q+HYfg98Ej1l6YqiNg
	 vZl8K2QZvEr/AHtVL1KsZxfrHji8vDsnG838HIE94HSZUzg9xdrJ7y/E9h6+Td+Ik0
	 9TZtnCe7wV/L/fu5NGUNjTwD9tFJJB7qEGzuOrM9EaXevfxVBxUMjzh9u88bE0Laqt
	 YeN5xamAWKIQvQZlad7vDtR1hbmmONHbFerbiDoAYFPtAbhrO3CgrF1ptzqzonmkx/
	 hG652NIAguugw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1B9A40217;
	Wed, 28 Oct 2026 18:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2318B356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 155C5608A4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4kizofHNqlV for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18090607A6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213212;
 b=ltqi316WzpUuAee3i/z2fqOJ4vwWyTqMwVg8+gNJ3WACh1ihLT/Qw9K0S9cPqG982QJe
 QG6XtwJTe8Scp1JKR8Sh+noGIK6iYnO3B+cO4CkguikLFnAOHuyDnzKRvZuhZRrmY+QKV
 R9uL42NFlMryU4Mf+04iE20X3PjrSXuSI6rsCMIwsje7DruGqAQH/HaWmJHoFMZQ7ZX0n
 w1N84Zftj8Pkz1wP8DlUr/6FO5ENGcAr5ZGtDmc+9WNBpv3DoPhGmyor8zr84wt+QC1tU
 cwzP2bIVDXcI0w0O/CsPxhYz3kert2trmtsZiIgYdbjCH6ZwW2PEXpQ/UdOB6cMk6SQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213212;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3b1Yc8NAM2aBtvL+k983e1DfG+deB0YM47VSlBI8FZE=;
 b=TVgqOt8hKftyDQVq7H0MlMH6IlRzKDnTvFyma7B5ZwSsLiL/C1II6wwl0t0+lwaiR16G
 XVOnE06h0xvQu0nASBjMj/U7W/k2pJpsqBljZhfUlbtK//p+h9rpYC9iyJLLYvGBWIx/i
 ZM/H/lY/bFGbsp79PQWaFtmjK01FMKCd5VCzC9WOWbFwlq/0M0KAMtZeIBP66uVPJvPc4
 gVQxG6yRUaCJ/914cD1v9iJGxvI6De5HOnhGEIoPyEAVmEO1x0np1zLz81fJOAgLzf5Se
 XDhU5h6ufvx3pk/+1B7Hkp6fbrKLV+28F41D5qvyMMgKsNDXljskTs3l+vAiE/uaJ6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=oQRaH6Yq; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=oQRaH6Yq
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18090607A6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793213164;
 bh=3b1Yc8NAM2aBtvL+k983e1DfG+deB0YM47VSlBI8FZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oQRaH6Yq8hkI/F9mSY3bvCqlXkje79ietOSO2GHPFs2C4eEDRv9tEZeroUKBHJBCX
 KOwJfWQQxJ2ez8P6Eqif44Jb7ZW1HbSwsfSHJy9g0nnGvRJqYSV2pYCKwKEi1QTFhN
 BTsNli8sdrMbV/opDBQpU2iWllUvuDrU2uQAEc65a6d8gIRVWa8A901lCUpRkgNqDg
 f2Ayr+nAfTj+yek+WEomUudcT6zylNuAwhFMgPqAy0OhMFVMrfIE4gG5nmd7G8X1Eh
 OnxGK/OZqEP4TI+zab/h8l+5dRV3ddoW/AaRMu8mY/dpvqVMVREAibD6axnX4mlRJx
 7vN+t8s0Aim0w==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D1B1AB22057D;
 Wed, 28 Oct 2026 19:46:02 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v1 2/3] riscv: dts: spacemit: k3: adopt override to drop
 M-level IMSIC guest props
Date: Wed, 28 Oct 2026 11:45:06 -0700
Message-ID: <20261028184526.1887640-3-e@freeshell.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt Linux next-for-v7.4 01e2f07c44fc ("riscv: dts: spacemit: k3: Drop
guest properties from M-level IMSIC"). Resolves OpenSBI failure:

  fdt_driver_init_by_offset: interrupt-controller@f1000000 (riscv,imsics)
   init failed: -3
  init_coldboot: irqchip init failed (error -3)

Reported-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 278b36acc79f..721e2d3cbb61 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -7,4 +7,12 @@
 &mimsic { status = "okay"; };
 &maplic { status = "okay"; };
 
+/* Linux next-for-v7.4 01e2f07c44fc
+ * ("riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC")
+ */
+&mimsic {
+	/delete-property/ riscv,guest-index-bits;
+	/delete-property/ riscv,num-guest-ids;
+};
+
 #include "spacemit-k3-binman.dtsi"
-- 
2.53.0

