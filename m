Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E5606A323
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iWV32hDX;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=QDSAZfmh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5A2381226;
	Fri, 27 Nov 2026 11:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7CR6z2IGrSrd; Fri, 27 Nov 2026 11:00:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E65B81211
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795777216;
	b=Rsc65VEf/oykrBxwjIA4aEfeqNoDlK3j2JWRoBu1SvhvhL1O6A18DLEDNBPOglMpR2Jt
	 +82xePd5/9dkAheLOfycjQm14guwTRxKuwdQwmm8aMhTjo/L2AmbIzQD2Bg5681kdyCKE
	 UWNRhUX7n7jYQCk8XZSN9ZXjFNQQ9zesbWX2Uwl2/2dxzHt4wD2rJHACtbUo1Eug3lMEM
	 /u8TYYkntllD6JCqUfZNZs/NyZ852aC6sMJVrd6RCnQhHq4uhcpF7vR/ZGNGKGDK2MKDQ
	 6TQdkdc1kot2LQHN+IXIG67el5yk62ijKv+IznY91uxLJ3MzQh72S9BnsSQdyh7ccHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795777216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eTzdAuxqmMA+Wez9XEH9vQEUe6nTQZwZ6J0s1nknR/0=;
	b=JqbJck2pnFgy5Qla8OltTXhDcZCdNs084WY5Asqoql1UQXi/wK/Z8uMaFSygo4B+yYgf
	 xY3rVXdC96yXHXKFMtJ1x9+EYN3qQwwWFyYrw11kbBtoXxVK0Qrpbme0GUDYnG+/BMRNg
	 7ndwfp4BFPSM2KAyTKl3Ad6O6dBuLvsSS8mUNRYh6B9YfNg+kEPZU3KqzLZK4l0Bzi2j2
	 LrJgS9M3zFfxSRN9aIUg1Yap3W2OGYh4kp4xywxEyqNeBKfZ/6nR/zvDiHtyGcLI+MISN
	 fkS6EIWT9PcdBuJd6WInOMLrCQLJoUslfg7GutAVwgAJQ5A3Vzh1fkiZ+uXYt0q6DLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795777216;
	bh=eTzdAuxqmMA+Wez9XEH9vQEUe6nTQZwZ6J0s1nknR/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWV32hDX5TlUvQwyQ5mXElvLBoqINqTU2tXIqHoH9B0bH4kpG+gUGD+u1lBzwdNER
	 7KPwmkAXUr3c6FjyVAQW+4aglV9pi8FQChNbM+qyMRqBcdu2mPZV6/lRjUvt/9fU9j
	 sHyb6BJK4ZUefOPeNJ4tpHSic7sDGiJcnwEG/2umc5Pkr3jXL07XUL/aamgt5mEudT
	 osyKzcfGe4rcrwZYf+SN1kksBL/dftq8IsGjWKf5mCCyaktr4AA2MfjPT/3JGvNLVU
	 XdDzBan9Txb9xrgStI9nmLeCa7Ptql6X885Uip6VIegtfm9Dz9jkQc44/HxFIrkxTn
	 YFgx69QxpJeLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E65B81211;
	Fri, 27 Nov 2026 11:00:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD399373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2E0E608F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QS77pXbrrHgQ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB2AB605E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=QDSAZfmh
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB2AB605E8
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795777180;
 bh=eTzdAuxqmMA+Wez9XEH9vQEUe6nTQZwZ6J0s1nknR/0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QDSAZfmhe+ED3mRZf4L9klrK96umAr2q6fTQoBE980lO2UVUxlyL9ffs6EH1mruZe
 wXO8TXmpyenonP+hSQSeSiQ09h64mUswCG2DosJxn6BjHhSBCBqfKNXCWeKEB3a97T
 34n3v5AFM8RD5agBsef7vggBgYUiS1e1yRABkowKLlKw2QIF2zBoZl4SrqjjkOjrAQ
 cVmJF2SJsjmEGctlawYM1QtCKOiS8diOHZl40gBgo2G3aEy+q7d6QQ5tkis0xtvhkA
 Xlp+DMvIKcRpkZGi+ZHzE5kRjqQASUeSMV3l7LrPz5OISpRxoa6StO/nlqoBtyMhMV
 5hRYiTiL6gTMA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6030BB22040B;
 Fri, 27 Nov 2026 11:59:38 +0100 (CET)
Message-ID: <884702e7-7dd1-473c-838c-e7f99fe6a4a6@freeshell.de>
Date: Fri, 27 Nov 2026 02:59:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] riscv: dts: spacemit: k1-musepi-pro: Drop
 redundant DT overrides
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-3-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-3-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 02:30, Anand Moon wrote:
> The upstream MusePi Pro device tree already defines the serial0,
> mmc0 and mmc1 aliases, as well as the chosen stdout-path.
> 
> Remove the duplicate definitions from the U-Boot-specific device
> tree while retaining the console alias.
> 
> No functional changes are intended.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> index 03cfed10521..ddea04a8e3e 100644
> --- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> @@ -8,11 +8,6 @@
>  / {
>  	aliases {
>  		console = &uart0;
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
>  	};
>  };
>  

Reviewed-by: E Shattow <e@freeshell.de>
