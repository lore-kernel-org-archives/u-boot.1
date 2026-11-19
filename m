Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5212606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0fUPxQra;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=kfhFBCca
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 787F240A4B;
	Thu, 19 Nov 2026 10:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qe7uNmdFFgqS; Thu, 19 Nov 2026 10:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9C8C40A4F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795084361;
	b=VtS4K17/1n5oWJ9+cxhVQzj1fdaEb9kqoi6qR2wAboVsJZON6dHjzOwr+g3Lbm3FbMqF
	 4EPzTTPuPElPbGhMqOG+gwgolBGLDYIyQ3fotahyBsUh3HBqXhAZsl/NqrFUjnxaeZBPF
	 ihss8fPL6tF4CZzDg2WWrXgyC0v7qskrK4zSvRrupjJpmKpQPAbhuBITNqMn4F6iTwVHW
	 IKgP/P87omkTD4HcQ7evUfjZNKxgQdnX8l1U2ageaZzxVQO5oQBdyO8ca/h8IQx9qhH5s
	 Rlx27f9W+OhaCXNc763Py0z7v0hbALbp/wo7VKfVWqqbgNemOR3R03Wf5daR0DH2d1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795084361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KP6HB42eOzgUpwCKBl1APmWJgF3gHuGeL6BJj7eCyMw=;
	b=icsVx2mWJ+qzeo5tC1KBuyUW+tFeydr28UfwPTh59z/1xRS1d3lQQpCO3+53rCU4U0Qt
	 gOUcOecijWrIgMhy1FN+0MbRknnWm6zH4Di1GgdFauSodlLDVjz56NvSyegTxZvtPPtRx
	 3Y1c1/8tuvhDummc2zJQYDD/PlGjHDfxYykrOZbcYJP2dJdPkxu3nMwHhcD8mqO8m8u1p
	 Qgcb0rsDGfWbbXuBg51g3IN0iGdfp4P/zdT17AtdoIwkD3dzmJhOW2QYEdR6OxiTLYNzi
	 O2RFW+/aZxV/jsi9s08+o08eQDoqBlzgDF0aI2dRm64dhwKLu41JC92XebOf06ytf5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795084360;
	bh=KP6HB42eOzgUpwCKBl1APmWJgF3gHuGeL6BJj7eCyMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fUPxQraWMwImzmDk3OWreSkjslnJWF8U1Y+3G+y5L+vi/UmDRv0NVtwl3nsbtr69
	 qI8jqxlhRyZYe3FQIxinYJuPXh8/UIlgmTv/8g+Z1paQLMr9t73WKpL5yYT31iYRa4
	 Bsm4aSxohmxwomHptXFPBLMlbc5qC1CF7XgLRaObVyFnvKf/ZcOzMSQOjbG46RqBjH
	 3nmyfAlsycVKtSNb+dsvIX1nW1IZMrJdRt3IitY8z16oB2togkbieHHPBoCuscu7LF
	 VqMIr/PYhtWfVvMjLftS5QijFMhLM0xILSDH8f+zZpL4IcYQ0GX6TifsGHShHetqTp
	 DbxXWyfRIFo7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9C8C40A4F;
	Thu, 19 Nov 2026 10:32:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 740BF70B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65B9360B67
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:32:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yjb9-e6yfBMU for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:32:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8225160898
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=kfhFBCca
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8225160898
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795084322;
 bh=KP6HB42eOzgUpwCKBl1APmWJgF3gHuGeL6BJj7eCyMw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kfhFBCcatoolHNT1+x8ynxnHh4gjoDCa82cohoWDB03GrOYk59/tLqeDAumkiPdKI
 IAI7G5M0EJuC3RbtNpvxXSSyfjDgA2EAW23eUyROAiaurSaPylcVfLfFffUQ6fh4gg
 xNF5/oTncfmFeT7lx2OGLjvN/BqiTn1H1PYow5c5kLlrkkXVz1CSwvv7RZj9V2uhsD
 v7DwPMF7avOl0h6G3+c/FYohyubJrrJaifGrLHhyoMDdc54kOI6eSFWZ/E5VFMgrdU
 boCyVWWTjS+FpvnyAeJcqkuDuaFxH2dX7s3XlMZDHoIPC0/AVo0j/7Fgifa95qlnpm
 Xd+adZ717Pmlg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 84485B221B41;
 Thu, 19 Nov 2026 11:31:59 +0100 (CET)
Message-ID: <319d91fc-79ba-491f-b5e6-234520c7ae60@freeshell.de>
Date: Thu, 19 Nov 2026 02:31:52 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] riscv: Support RustSBI through the FW_DYNAMIC
 handoff
To: Zhouqi Jiang <luojia@rustsbi.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>, Daniel Maslowski <info@orangecms.org>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <B92B10779C0D9EDB+20261119091842.3062208-1-luojia@rustsbi.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <B92B10779C0D9EDB+20261119091842.3062208-1-luojia@rustsbi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhougi,

On 11/19/26 01:18, Zhouqi Jiang wrote:
> RustSBI Prototyper dynamic firmware accepts the FW_DYNAMIC handoff
> already used by U-Boot SPL. This series documents that compatibility
> and lets users provide the firmware with RUSTSBI= through the
> existing opensbi binman entry.
> 
> The first patch makes the SBI_V02 help text firmware-independent.
> The second adds the build input alias, a binman test and help for a
> missing firmware blob. The third describes supported firmware and
> the effects of the scratch options in the architecture guide and
> SPL Kconfig help.
> 
> I'd appreciate Tom's and Yao's feedback on two points from the v1
> discussion.
> 
> 1. Patch 2 keeps RUSTSBI= as an alias for OPENSBI=. Both use the same
>    FIT entry and SPL handoff. Would you prefer to keep the alias or
>    use OPENSBI= for both firmware implementations?

Correct, keep OPENSBI= and no additional aliases please.

Arguably this should be a few bytes shorter as 'SBI=' however the effort
to change this and all the documentation and all references to U-Boot
from external write-ups and documentation is without any particular
purpose. "OpenSBI" was the first mover, and as that goes in technology
the first mover tends to be the "Google it" or "Open up your Excel"...

OPENSBI= has the meaning here of "an SBI implementation" and we must use
that for consistency. Adding an alias adds to technical debt without any
particular purpose.

> 
> 2. The FIT description and SPL debug message currently say OpenSBI
>    for both firmware binaries. The U-Boot "sbi" command identifies
>    the implementation at runtime. Would it be useful to pass the
>    firmware name through for display, or should we keep the current
>    labels?

If you have "sbi" command enabled then you probably already know the SBI
implementation linked or packaged with a build of U-Boot, and if you do
not then (depending on scratch options at OpenSBI build time e.g.) a
huge banner gets printed with this information before U-Boot main app
invocation. Is there a common use for this that "sbi" command should be
enabled for most users?

> 
> Changes in v2:
> - Split the series into three focused patches.
> - Reuse the existing SPL handoff and opensbi FIT entry.
> - Put the firmware documentation in the RISC-V architecture guide.
> 
> v1: https://lore.kernel.org/u-boot/2744044E69DD25E5%2B20261115143808.1812787-1-luojia@rustsbi.com/
> 
> Zhouqi Jiang (3):
>   riscv: Describe SBI_V02 in terms of the SBI version
>   binman: Accept RUSTSBI as an alias for OPENSBI
>   riscv: Document SBI firmware support in SPL
> 
>  Makefile                       |  6 ++++--
>  arch/riscv/Kconfig             |  3 +--
>  common/spl/Kconfig             |  8 +++++++-
>  doc/arch/riscv.rst             | 17 +++++++++++++++++
>  tools/binman/ftest.py          |  9 +++++++++
>  tools/binman/missing-blob-help |  2 ++
>  6 files changed, 40 insertions(+), 5 deletions(-)
> 
> base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d

-E
