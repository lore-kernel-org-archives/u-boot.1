Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF803606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O6Bght1w;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=n1HF0vy/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FEC0607B5;
	Tue, 20 Oct 2026 17:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbXWHKTB0kor; Tue, 20 Oct 2026 17:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 984FA6075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518130;
	b=SayLRbE+J9G9QtYaMjTrkzBH9T4FsSc+fG20kqjXxzYH4qhs6C3+Yjkk0TogpnUlryuQ
	 iPTzJxftUgd8HpG2i6GFvwvqcy1vxyfkVIDWWNaXJBrw11Z2fFtfycRCyMkJHS18AkoZE
	 j8ykUtyFN7qhQunnIzCeCKKFEr3o15RzD1kTfxTmuqb0Ny3WUmJEL7K/hadp1BqY5un19
	 IaMsQY+JBmu+KVaHARLDTpxScwwGtwrQA4YwRvcPYk+eMyNQoat8cfnyGJpqktSA3AXpw
	 jPoDywAw1j5j/ibmchEX/8vm1Z8xHi5/f1YrtqAJ0xl9jJ4HB6lAMTHNiHg/1iS1Scw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792518130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rXCo1Z6Fk6tXsxlOi4GMOCiJ2QLcs9NnVDc7/XKTnh4=;
	b=sqv9DIBEL/jjW7dDCEL4kdbL3fHVTrFkAhMGrF7OCRaGr7z2QYHDlIvcki/5fkT12jpx
	 KFV6t1dVlTT0MZ5Hv2RoSMBfoQNKpBLiWXB4BgQFDq8A4b7utBXxHpz/9NFMB0j7veVOh
	 HpYD0r4cugl+XRqYG1HJlX30EFUI9iRNWMjqT9Ob6k6CiDHWCWLymCb7Czz++OGrk2Tbn
	 +YIPyV0VaPJzLOdgppBvz6yo/NmEhIF3eX3qJGdofcse2OHfT45qTorb3faYriDmW/NN1
	 wOZo2jHrb1s1qhQgr5Sjgxy5fgHbEYgokrsKBGzRTkORkxy+f2KTypEo6smnCY/owXw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792518130;
	bh=rXCo1Z6Fk6tXsxlOi4GMOCiJ2QLcs9NnVDc7/XKTnh4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6Bght1w83YzuoG+/LTvdCvjwpXTy1pHjZvAL2/9ifEDNxfLNcQ4I/Io8RwWwYMWY
	 Q0ctpoS0kO0hsdV6cI6QoHoyR/o6j7gaTzxinOsIdgljVDaRqejpb+soeS1bjOqwaA
	 XSmzzUcU9apfSdxet4AcnI67wlGLcK/GdxrGuLr1ZapEcXZe0rKSC02ikAWKxI8Qo4
	 bpngzLTsGyI8J2ujx+krMUR4thJHMx+5FLoHL+6WUhHfGftKtJBC09g5mS9AnMAvja
	 LkBdNmNvqhKaYnJ8cTU2MyBkZroBmQwh4wDttS3Ry4l6eOtp/zMlJLsHwMtOSJ3ImI
	 8nHff0fCx8IEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 984FA6075F;
	Tue, 20 Oct 2026 17:42:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA4E52E0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBB8A810C3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFj4kOHO-f1U for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:42:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A275480298
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518127;
 b=Ehn1EqPdlgRAoUywCECoIPDWuAKpGlBaou2Wz6f0nJJMbZdNJjKVtVUXf/e92RtPxdxP
 cx6F+3zf27hOpeaQ0rl0DeeOlAnZgZwkBE927LjGqV35rCZ2uvq9qWSg1LAQ0f847H2OH
 cVw6AS0w3yQIfB/5QiCkf05hmxLBZ2g+wFSpGxsQSP0KrrrtqUcU5tXjMq74UdQaMXm4w
 cKF1WRSGBG6HtOEXOYJaM2DfPTqHeG5/t4cL7Cef65bKctcBndtZak/nMmo/2wRpHUY1K
 yU8566O2ynikAaSFkpCDSGbr+nDxpXK57FGt4RmmCLsBwNk+guSv4GVywlpDt5PkeKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518127;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=rXCo1Z6Fk6tXsxlOi4GMOCiJ2QLcs9NnVDc7/XKTnh4=;
 b=Jdcef3hGnn79qHYb+M+WWHTpoRJRD2IVrcVRT3MxoWzlWmFUGWoNyK74K7bmSZjVlt7/
 LGIo3YU/J57lxOvmCV9yYCXJ91XxXgOFykwEvgA+8/7RR5xCkgatX6NhY1hjQv/djHJ7k
 j/cchIMW+IheD7BR2tgeUodllWikpgVILVEh5WXTwa/7avK3+7XI0hcIEVoRTfKmd04G+
 LqvETWY5fk6fJmQCsHKRkju7vJWLx27wt7ZGCoWEulX31Z0lyRh0Zf9ojdwKs9Dq+W2UT
 Ez6Fu0I07uDl/LICLwnP5E7RdmmRCo9o5VGmY/p///Vg3btguyNq76CIrKH2ixhW2Ww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="n1HF0vy/"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=n1HF0vy/
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A275480298
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792518011;
 bh=rXCo1Z6Fk6tXsxlOi4GMOCiJ2QLcs9NnVDc7/XKTnh4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=n1HF0vy/HrlXDRfkQey0F1Ds5C+uXVFoiIeosML4/+4GnpMMeD/XXYAYmoJdT0QPf
 5gg9gLRMDDsCCWp2PnOpip7FrjaoH3liev5XazvRf+btvPcq6XK3UjtW3gYqmseHd6
 1vgKOx2T3l5NR7+LEqt/H2P1OcssfOZCcd48juHZksqQ0j8x4S/XsEYT87poGaLLa5
 pR8xZEl9pSAtulZSwszI0VysVezpyjal4rUzu6t1GD1pXBfJkQ1ImzN18icYBk5nN1
 2yUZBj/d5BsCBa1H3crZ088GoqJ1y68S22UG3jrO9XGqaAl8OlMB3FiXLI6w0fUw8D
 rc+IpX3jRfdRQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0D75AB22029A;
 Tue, 20 Oct 2026 19:40:09 +0200 (CEST)
Message-ID: <48b19c4d-83e1-4599-a940-dc31880cf5f7@freeshell.de>
Date: Tue, 20 Oct 2026 10:40:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] riscv: dts: spacemit: add i2c aliases on K3 Pico-ITX
 board
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
References: <20261019014044.698294-1-e@freeshell.de>
 <20261019014044.698294-4-e@freeshell.de>
Content-Language: en-US
In-Reply-To: <20261019014044.698294-4-e@freeshell.de>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/18/26 18:40, E Shattow wrote:
> From: Aurelien Jarno <aurelien@aurel32.net>
> 
> Add i2c aliases for i2c2 and i2c8 on K3 Pico-ITX board. This is useful
> to keep a stable number for the /dev entries after loading the i2c-dev
> module.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Link: https://patch.msgid.link/20260623204431.498700-5-aurelien@aurel32.net
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> [ upstream commit: ae4e84366b5d621171da2e9fae2b1f8bea3312b8 ]
> 
> (cherry picked from commit e1f4b93f2a556b0ae661285aa72cad07b3c65fa4)
> ---
>  dts/upstream/src/riscv/spacemit/k3-pico-itx.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> index 143bf6f41260..309b4554d064 100644
> --- a/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> +++ b/dts/upstream/src/riscv/spacemit/k3-pico-itx.dts
> @@ -14,6 +14,8 @@
>  
>  	aliases {
>  		ethernet0 = &eth0;
> +		i2c2 = &i2c2;
> +		i2c8 = &i2c8;
>  		serial0 = &uart0;
>  	};
>  

Drop this patch that landed in u-boot dts subtree with
devicetree-rebasing v7.3

-E
