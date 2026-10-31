Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671A606A31D
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fXF8Byhg;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZD69sBa1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F2B760ACF;
	Sat, 31 Oct 2026 00:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjUTHhCVzA3u; Sat, 31 Oct 2026 00:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D39160ABF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793405701;
	b=QMeoBptxE+U20dXM+qSiNUTSRLc6/BVhZ+ulCo/ED6xOv4R8W6n52/UVy8FmiHu36ue/
	 0PI+Pla5DNDSKv+t2rWolJK3q9ffiWStmpf3youcH4vyPsrUn6MPCPpi9wdXu7QM2sR1B
	 S8jwfncpqxl2AQlvIxjJ9JGRlhZDpHofgngInazaHCUgH0/X7aYUXmbUD7vyUjdVD3tuR
	 S0nrrapVAb0IkUVrK88Jb4/9UJDsWbHiBA6+A9YyoW/wByXpgyZeFPpvNXBFyAQz4xR4q
	 vULDGBxcde68gTTW45+71FfMK+IQkB8+IP+qOfxjR74emPtMfNFbjtctpffSsKsDwgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793405701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G9B7vr6Q/Gj5LjUpEe/CwidaCf4BaamcdVgi9H08Vyw=;
	b=GgIjSI1TIICgRHcr5rATWzro0MfAvJU8PVIpYKaI/0WjvcBLjMSQSPydSsCevSsgBykf
	 mCNZpLD20qOR97AoVQ4XsWUfx3/4zPn/63fxtxRo43nZgc+2VgyIbL/Vx7awRovKNYFxz
	 GbfIf+4OJWfKTyaGeJUWfy0lBIOc9ktJ0h7ipBoKONMIuBAdP+kDEZPRe1nTO36hbtPSC
	 oAiCZwYDtYNj1G+ptPVc1mt73vfH/NjRAq9HgkdqWDvx5gp0zdVQ2UU0c4B/BCwfdJ5Km
	 +dfXw4WvZUetJseSQcb+iQW6M/sSv/lY5f3kOkbnN0a/yyDgVUGvAhw1zvK1SEnUcQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZD69sBa1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793405701;
	bh=G9B7vr6Q/Gj5LjUpEe/CwidaCf4BaamcdVgi9H08Vyw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fXF8Byhgnlek4xRIpKqfVlIetcqaEsC7jeNsPEevzVHG9U3YPNP/XhpvGmZEi+reK
	 n2VnSU/miLPf3EmFumtSc8O10y3+24fGGCFg7I4YSiN8M9IrU1T+d64JOv1WgyWuYf
	 n7uVoCdh8gENrZUt+dJZO9KxHaaC/ILYNFRLCtab4l9lHdUwKMPjAvwaaycnCSdWmU
	 0fNdtkpygtcTKJHCncZannWh80NkxPi5VeU24RfS/asMofCablaH4TCD2LTTwnSIEY
	 raKjXrIkAtwhR+bVcrN89NbxmdZi9uMdUCDWU0nhQVBYP+nOcfEb+FAKcyn1YHlGrM
	 86Fg0CabxXwJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D39160ABF;
	Sat, 31 Oct 2026 00:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 931C52AC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79EFC60ABF
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8Ox-inR1gd4 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 00:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D103D60A88
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793405693;
 b=AQNxMY3bxA/i7JaG91wLOBBsqV944v+hoOLqf1WbC3x4h0ZWP+bsWtCL+Eo1cOCSh4cj
 xbRHk/Vzyi8n5YhmKWtMBLJk1OY/O2UtcsgCnUyI1OldVTp/GHvv+Nb2A0paa6zs+u6qX
 waN5XQ6E+noimrl5N/jw0NaEKSPCq9gPjd7HN69fXpotg38oP2QahZJL3r2Gam7loGDR3
 2mLucRwxMFi+pxUsH4W49C/uJEZae7e21flocQoo6XZURQ9NOECqvDLaSIJwEaaGaNBRv
 jxlUooJQKPYd543lqY/8KlLphlOEh5cMUPQUDTLE1UJ4BaQfoFP743uQ6DXmbFfp8WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793405693;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=G9B7vr6Q/Gj5LjUpEe/CwidaCf4BaamcdVgi9H08Vyw=;
 b=WYCzaUPoa7YiZqtP+J/rk5mF3GbpqgllhTw2dW4UYXMzRXWy4IyJhnQGp2n3DA4NHihE
 zD5qSFrE8jlUfTn7ZrI7bPCx02hdm64Wa7a6Hv0W5rLlF4NB4UHQ7jqMekWupUw4ixU8Q
 b6V/8f0yh9c8zlDQ8zjYk8i+ZahAacjcwF4VhPhGXzk8/9OHp/VQUnnf2GYgglZnpPUH7
 CvFjLs8qtLXJ7e3poZmbghHQgZR9gWsyIOohU+vhD5Qi/vctTlWZBVA2WN2/ph48f243p
 CtvDZV7hLDFM8iFdSt4JuUCZCVyE5f+FP5YGXJyllRvwIOxtUZ5W8vP2KWkc0xNs46w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZD69sBa1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZD69sBa1
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D103D60A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 00:14:52 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-70b875f6f13so1139774eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793405691; x=1794010491;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G9B7vr6Q/Gj5LjUpEe/CwidaCf4BaamcdVgi9H08Vyw=;
 b=ZD69sBa1NbJQ4NONg8+vgdIOdy44KRMx6RhG6roPTSNTTvU2Leqz78UbYNILw1kzFu
 Dz+N4g8k6g1PRhOMYmbUn/WDTgLo9alS3DYqiHoL4TqDuckwFUFh+U6xSTGoig4q15aD
 T+T2rqsWFXrVaR6RaHya6RACDMXhW7vDSiug0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793405691; x=1794010491;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G9B7vr6Q/Gj5LjUpEe/CwidaCf4BaamcdVgi9H08Vyw=;
 b=PnFxBVoFQwt1aGEvMI0idVnRPGqwFcUchob6nKajrM2BT8yNQFcaJcJnvjouCLvw2D
 OslRV63591vH0kQznH5PEruH9ojxzNRxAWWbltPZI4P35JlUJOLSCMzphhKLPR+ybLC0
 D2qC4/+4UqhwThsroJYXg+3PtYTQRFTO2Utltk9FeqloaW/D07TQhspdqqp5wD4LaVG0
 X6LoXqU1jGpuaXcKmL4p4IQoUks2dvbv0YH6LZUtPWagOUTupccLELrKaVct36IB6vrl
 WCXzsqzaWt76mrHXHKyqF60T5S5L9Gl7iGdYg9eP5W9ZytKy1mzn5WGEWWIZ4kV2BpV1
 nhaw==
X-Gm-Message-State: AFq9FYJuHnNEkxKBIOizvn0uew/SwBPS9JqnxJHsyXHGdFJABbNUx/aa
 oTpnVTojcVCZaz/sO1Cp91XTSaXzpHr3nMl7wAUoU2NWUqp+EegRbL9UoU95zr6pNtxqk0WL7UK
 AyWRyAa/JRNq3
X-Gm-Gg: AYBFou0WFn6NajBnK3bQTgosruGekN9bf3MpFyVyXg0qWQBKfW/vVVadqhkBsh552JT
 KWwN0Lcrm+BQNLf1kCCzMDetCiqxjCUYCpjvlydw7dKPsa8hJ9r7zEO8UwPbrep9tpwmsEz32ew
 rKz2bvVSwcNpdRvg69ZcYb3gKwdhjegEnGmHPuBPhgeX0S5+EeLK/i7sS1+99tEyRPaiQsmCr2K
 PVYParrAMlGGFQ/lIBqLFRVYmkLMnSlq6kFyWAt/N50T/YblCxIYaMNtb/8yA+v/jylP0mV6GJ2
 YeAGFkEutadkXSZn3VP+mKNzrSaKY/6D3iO91H+JkC5u1w89RCdxTpiqub1cnqA66irg/MQX/ib
 Q4roE4726gVQmPGHTz0ideaTehrctQbLiK7/HoPZsOKooEvn7F5jl+3h2XPq9EWvs9Ybi0638d8
 Fc8dwf6iNM9ZcfM3isg73XX0qJDEOOevJ6ioD17PS0AwqthZISap56OVpeggP4E5xoOteHVZHIk
 /m2BOSnrnLFMSY8iiGYyBMG4DiMabXpgTJAaC008TgNCCOk5y+CfE0leWIzxwXc3VjnEUjFHGIH
 r1sxE15/vzFyPagDVZkcjlHYgj+TEaJdFeOaQ7xFNnrrleGHg1xKHJAKtmJsua/wN/Lz7CbWuS4
 WIw76Zr7qt33lV3cYsEq9SUh5MTLh+Lc6PCG5QhzSP6lHtIsje9z2rOsdBLqne4pu1hCcr6Zzlm
 etHSRJf4pJPzjZqMDkT0RZZmldnJ3QDg==
X-Received: by 2002:a05:6808:5093:b0:4e8:e123:70ef with SMTP id
 5614622812f47-5640e063a30mr2940044b6e.64.1793405691407; 
 Fri, 30 Oct 2026 17:14:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe45587sm2625427b6e.15.2026.10.30.17.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:14:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
In-Reply-To: <20261018-qconfigdoc-v3-1-196dfc8ff05c@gmail.com>
References: <20261018-qconfigdoc-v3-1-196dfc8ff05c@gmail.com>
Subject: Re: [PATCH v3] qconfig: Improve the documentation
Message-Id: <179340569031.3856789.18277880913023042292.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 18:14:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 11:58:12 +0200, Massimo Pegorer wrote:

> Specify where the database is created and under what name. Add text
> value lookup examples, including quoting, escaping and regular
> expression cases. Update other examples, or just their output, in the
> section documenting -f option usage. Trivial fixes.
> 
> 

Applied to u-boot/main, thanks!

[1/1] qconfig: Improve the documentation
      commit: 3401e006432abcbf7d73d7210f10df157f990ed3
-- 
Tom


