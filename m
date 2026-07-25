Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66115C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 09:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A2756065F;
	Sat, 25 Jul 2026 09:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nvupuZ5MN5bR; Sat, 25 Jul 2026 09:42:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 865776066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784972578;
	bh=Sc0sdGj/8nbedST/0nDq/k9X5wCAXZwU0IZZvAoKY7w=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ltIjdgxHVQo1eXbsqwnqalL1QNpHWhz9ju5XuRNaqDOLroTJ2lMGVzwaMzZih7dyz
	 Zx3ECGikKOSdFTQI47cScZn/09wUK5xwUQ8KjsWVcsKZQtC56hH3JfQkK/pd6AC1QA
	 sB4YG5pTTYznmJeJrDkFtsaKjWXy1wDnL8HCPWal7e6YlN8YeA30/zf7MsnRRXHwPL
	 knugQrPbLzyG/YCCq+Hbqs6f1IDPqEYpn4E2Ig4ZslJPKANRJ5lkLXRCDKDZRhtriF
	 QTKvBqYzk3fZHWLyQHyIn2ePJolb6/oYTFYZyXSgMfEueI0yEiU6OuOw1MTB0IKzL7
	 IkVEZprVWVHvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 865776066F;
	Sat, 25 Jul 2026 09:42:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1FCD26C
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D391181114
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0Ek01o54jHF for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 09:42:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1E6E681106
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E6E681106
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E6E681106
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 09:42:55 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-381216921aaso1180797a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 02:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784972575; x=1785577375;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sc0sdGj/8nbedST/0nDq/k9X5wCAXZwU0IZZvAoKY7w=;
 b=poPHOHY5t2uaBgRGO6kAAJhwEJ5BYRvPyecez9ptQckWP0DaEt4jD7ju5e/fntIE2I
 IsxU3rOym4mEJB4aPhhr8nlzUURsAsmEdmmxZ7F7ZwdSxqjsMaw8lbcRLLOMJEBXAjSU
 i9wt2n2P+aJf7HcHEFbEu5KNFIi5fpZhuVhpDUbcvGHQ4aPaV8Cl/Ie6hkf7hsRvTfYJ
 PE7uSnrrCVm5hKVQ41tbBPZmvCqwL2tyWbb208D/mZw3svPNighhC5Ecb/cZ46gO2U+k
 ZgcoKJnngukcA8XjK0+8ztwbyjszecr7hTDeMsKjPJbdiw4OZ1bIu2qWoo+aIL2Nl8k8
 J/mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQYrA/uuf3CLQMxnptOO4jWuoMmsBo71Igzy9hUxxqxiAs01+OLTRppIS3gSoTPssroVKF69s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YznmtLKrLz1PAmeGyVTOtzlqWPLK12sNc3bMC/ezKn6Csb3647t
 wuq6ZGd2ImMvcBwEVQ86QC9XnTlS6aQNsOzqeXpO6Bo16k2hV1VZtBVhpRH19kVNemU=
X-Gm-Gg: AR+sD12/A9tnkUd1uKDqVlRdErhMTFF9I11Gp79Kn0sBFvEiHENCGVowE7VgR/3KpoR
 /slgddILU5JMgj0b1fsnAO7i7R99VYylgp7bpqCQP+OIH3HyuhpncM4T57m5fp/VuUdiwwk7kXp
 ldvHYRRrkECHVGbz5behFf4HoeTxq7YFYU6XR2fdZOyJxSA367urH5vYvyLmd6UPuPS6r2MSLRx
 j4VrS3WO5C6s+xEOjrfgWQSrEXIBI7CUVVeklGvfMFPTkaN1XigC+bOtnE8MvKBjB8kqK8tpdJq
 MkUL+rg00IJuQbGYmeRPs0+1a8LlT+VM2L62DiVqrSKiptg8g11HzaKxnhnEKYSyaxXdUyqYnVX
 5AgrRBfVwJmHGR4c8+co7BhoNiY2iFkPe2oL5TW++veODtutR7U+F2KhIzBTZvfX1NYN7mOeuO2
 nHe4du51FXHg5qVmwIEp4=
X-Received: by 2002:a17:90b:4b0a:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-38f293cd11amr1733315a91.8.1784972575359; 
 Sat, 25 Jul 2026 02:42:55 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f292d1d75sm687180a91.5.2026.07.25.02.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 02:42:54 -0700 (PDT)
Date: Sat, 25 Jul 2026 17:42:49 +0800
To: Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Leo Liang <ycliang840519@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: riscv: Add myself as a reviewer
Message-ID: <amSFGSFqkLR4cRLr@lliang-1876.localdomain>
References: <20260624045648.524454-2-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624045648.524454-2-me@ziyao.cc>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784972575; x=1785577375;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sc0sdGj/8nbedST/0nDq/k9X5wCAXZwU0IZZvAoKY7w=;
 b=gtArtpmU/DM7SSF5LPHy/y8bF3NITZyFBE5Sz1b84MB3hAmKf3vyYgyy451ZAUDmGv
 xuO3eGS7jDUbnFvvVTTnWIEr3d/3ZLRPV0RW0ifw/e73+gIMwedKCMIuVKUDKuj2HxYV
 gu7gomkg3HUQT63a5ZggQbptwLxVKCY2zhwF21dzZR05s7SxVinf0g/4SJLO3yMEVAPb
 tWAMmbItqkinqpk3eBfGx+veOtpDIBml4a1foqrPzvCAOJR3WPRl2DRDHv4qILZ/u0a7
 j4l9kVvlM8SF2xrLU25w7DfiiOh8IimhRdo9f8CN70mMz/FAGpU0ru8bUnogi9GE2upZ
 PZCg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=gtArtpmU
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jun 24, 2026 at 04:56:49AM +0000, Yao Zi wrote:
> Add myself to help review patches for RISC-V port.
> 
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Thank you Yao!
I will rebase this patch and apply it to u-boot-riscv/main.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Thanks again,
Leo
