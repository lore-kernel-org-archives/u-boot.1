Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2649C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 12:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D83280DB5;
	Sat, 15 Aug 2026 12:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8KF1BcQS8kFH; Sat, 15 Aug 2026 12:25:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D54780D88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786796700;
	bh=Uun6+qdRsAarWiLQmZyZk+s/S4fQ8YRaRkyOC4kURZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Av6xYdnUikrae0VBW4rXdhxXMwFfdpzZI2WGkVhohF5R/L6Y9RF+TN4ItzOVFZGiv
	 dYIpHkCzNuTRCcgGQ0BcqH62e1D2e6CmR0U723xsD7O4hnXedM9qLZYmdZGJ6XFf/j
	 gdC2qFDdIxkW9COUuoAuxsuDSLrONFoEB9uD5OIZTfhHMKGfN4K49nxCP3vARMK+tZ
	 ZwZWn+DdUn/6u0MP6h7qlCFx487akzYlKuLwLkR+BuLu/bcy/B/9W4j21HBJlmyItm
	 eFxhJhgSI6d4fbysZDkU93+41Dc6uA4CWPslu3p0pwlEhsYxHLldM3IMjakjmcjgtO
	 Gx1nzy5rxwFwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D54780D88;
	Sat, 15 Aug 2026 12:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4A1C2BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA04A4098D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBxNXrH9IKpF for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 12:24:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C9C874084A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9C874084A
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UtTPgdJP
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9C874084A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:24:57 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-52b3934af3fso19840441cf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786796696; x=1787401496;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uun6+qdRsAarWiLQmZyZk+s/S4fQ8YRaRkyOC4kURZY=;
 b=UtTPgdJPp4GCAY6tjXAKWPyx8i3y25OUBTmEuKjVV3lotgat7AgztKSRktp7QYkCcn
 PFLwwiA9BlGazeWqQ09RC1f2E+nOFzz7HT8W7sEYrY4w1a76gXIti7J35iILn9CrMNvC
 VZetNensgum6LS38eboLEjCDWZ4ib6oB6/rkB3QDYsIhIE0n9V5t4w4AJEQ2eGUYhojR
 QDUAMijxzoNhDtRJnG4LfWWZCXPerxBMaOy3fRYZio3/s/b4s4cDRr2xQAEkA6jbJief
 YBIOufZvM1Fnfwn5tbsIbSE0Wl0rvzA7M2gZQaM65dHw8LErEr5ttvCKmee6bgClepfG
 KMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786796696; x=1787401496;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uun6+qdRsAarWiLQmZyZk+s/S4fQ8YRaRkyOC4kURZY=;
 b=nfLMXhhVEmyVOzwSV2TyZv2xMUEt8OfJ/vH67A8zLhyGOHi3ienp7i61j+cCB09aFg
 R9RPrKeeTCyx2g/MTTI1bhTlWsDyvma0JDUB/TP1dvKNcT76ckse/HC5rwRHtu42ZNkM
 0mJn3k8VT9eRJtcnpgsecwCqbC/zi5e19tGOQYQiHa9fmmMM7jfJN0s5tdl1Km9Mod7M
 sgw1HpeUEISieCe4KKeg4skvAtjXjDfmiRQqVkvCEAWohT2EoCCcAzs79cxf5X5CQwup
 lIVbq0SjFKSyDfMPOcqUo1Kn3b54gccTjCyCTB/AU/otdEkgK8KGQ6MZ8db6bt20dg9h
 jytQ==
X-Gm-Message-State: AOJu0YxONKREWMi2pW4m577dJT1Ow+IVUinsbEYIVSQoi9fvwd590cby
 DrJ0xnLRMjfdr84x8tdTcDfGsn4kxE65g7E12wjXbhCZxGyfP5V6Qrq4VE/5kOZ/TGKj3aI5C1j
 Mf+Kn5xY=
X-Gm-Gg: AR+sD10MuUUFs1y+HW4T6Bf+xAWDKUNF90dc687TQj+5+wMJpOyDBK1kF61YIHSaYXf
 fLAFgD84JJAbhtBjhmAKYT/7A4bg1zqrsKMz97ucBaes64K/Wkas532RkddwOsnkNfyUP1kHjpt
 tsctn9K0XCNwH1hyo1H1OxEu7anw8hRHwdH0emtG0G9ojM/n/an4uuFgEr7UgB/RUR//ipg7NRP
 jfRhytQS4RjYunezLykId3sylD5eVydoqf49JmllABxq84e7ZMeE7UoOnVGuYlMuYrMNZJ1+w3a
 fZL9xbLOo98CbAbmT88du2RBAq3OCfr67E2JkO1A0gfdGrW+xQieEvxAJeb/rjhdrjeschFt4H6
 gPuvj0nev7rKYpKemHIpBBOoZzPkqBkYUwkMqW8gNbaSvYN2SH5Mg67ARApfiJgA16+2MVWorci
 il4KC9x6LMJ/QwDpooTQEzSXt1IyIyFuNUfp85VzBi8CMADNBd9ogHgWKh/SRRub4hjOhRL2XpE
 qNEqWrLkFG7U9BYfNQQlUz+3zOR79p5TQOCx2rtDNydgNINhMsoWg==
X-Received: by 2002:a05:622a:40c8:b0:527:7842:72cc with SMTP id
 d75a77b69052e-52d854e5526mr146971531cf.39.1786796696029; 
 Sat, 15 Aug 2026 05:24:56 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a935900d1sm39390366d6.42.2026.08.15.05.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 05:24:55 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:24:53 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
Message-ID: <aoBalbRFgBNJqZAV@maple.netwinder.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
 <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
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

On Sat, Aug 15, 2026 at 12:26:16AM +0200, Marek Vasut wrote:
>>---
>>  arch/arm/dts/r9a06g032.dtsi | 270 +++++++++++++++++++++++++++++++++++++++++---
>Can you use dts/upstream/src/arm/renesas/r9a06g032.dtsi instead ?
>
>Can you switch to OF_UPSTREAM ?

Almost, but not quite yet. The upstream version is missing the QSPI 
node, which just got added in the kernel side. So once that gets synced 
into U-boot then we can switch.

Ralph
