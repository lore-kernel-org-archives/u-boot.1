Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0217C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 06:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2866B40585;
	Thu, 20 Aug 2026 06:19:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlA2rNvqrxRm; Thu, 20 Aug 2026 06:19:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787206759;
	bh=JYLCXl/wSGp7zLtq3jKjV1uAQjqSvGZpmk8iPhUs12A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3xVBoJr6wfIWx90/M0B7DGOplJocieYDJsSSL8UHSH40piYFjrqm0fTMLn+Y0F9s
	 AtCqNMMDCw58FgLfedE+dPeJ1TIwuKCvK/MWDPdT/NPUHVFP97tcScgFNKo4iZw1vz
	 C6NKIWORj05p/Dw+IRZTFRoK31k9woQDp2/fJhLdwRJku2scekCZMFuV37uyWHv+UW
	 e0fWRQQfmS2aL5hOvbTG8wKTbbgjME5PPeB5nBa46u/XYw94b+jEWBf7/P7pMp8WJN
	 +EFZTQ4vD6CrP1DHo/fZVb3hzhHtF/JN6ZVxgR2NQiNlcpyfHC+KzdWNY3KCEGZMFD
	 fXMSLU/yNDyGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DBEB4057D;
	Thu, 20 Aug 2026 06:19:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48EF72FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3545D4024F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuPV-6OU5ClY for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 06:19:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=petko.manolov@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cAuKBpJE
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C77540064
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:19:16 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so3657303a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787206755; x=1787811555;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JYLCXl/wSGp7zLtq3jKjV1uAQjqSvGZpmk8iPhUs12A=;
 b=cAuKBpJEP2YNo911eYBfeBsYyAIVcZryacs3f5U8TSGs90/Au7B16ldSMevXRmg0Ta
 PPE4dTWvJu3KzxX69b9UdFeHjGykg5in74nJe1gMrdnzypAPolKjeI602NHCWboDPP/3
 x8eM7YIpV/Y6D0ziWDrzJ/jBdykNk342dJQtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787206755; x=1787811555;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JYLCXl/wSGp7zLtq3jKjV1uAQjqSvGZpmk8iPhUs12A=;
 b=kipQcc32H7NxfzdILA25DoudncYjSh0HZLvLjLgfTd/7MOSWbwEszWLJhYSfFv3ZGi
 HDgx15dy+eOYBWxKLBY41IlxYjNQqrbWVJtIfS1VYxsBYWrMzDPKyvC6bOvCWeM8XlPO
 dNeXzRMhrkSzEfyKrFgU1wxqhKWKOsurVcvr+J5kVQv+JXoVrD/GByI4Lr17baMkkqHT
 fJ0y0wfMxwKXXjUxwjNxaphLlYto/IIlu9mt6BcYTTvYRrG9xTWp4uu7W4cFhY0CQ4fQ
 5rsyTNEI6liydNaXcwYCQ4M7tNJlhYVFDteFBCHBUKLi5hnRyhAv/sqjkJSLmkf8Rsj5
 wPPA==
X-Gm-Message-State: AOJu0YyXIb6lOS4G8Rr0ydS9BFgqht5GUlfEAdwhlda6ROHGlil/IjnD
 KLU5lBeVqT6TXGlaqLwWmmVz1m3jptnbbpN+9dBKlhXC/X7GP9jb3zz2qABRRSpEUCh9GOdiBm+
 IZz76AWU=
X-Gm-Gg: AR+sD10g1LoHResFhKnopchJOfvSD8K1H7KLUFAoWq+XTsFhTA0KXr7tUdpAp2Ov7fk
 nsTSGzhfBohYAdF4+WwV2xMHpqscEq3czSLhXJvx8d56FPbPqJmjHYI+Srp91NsnZoblMxsxUNU
 Q2X3Vke3ciwL5n4LakW4rtiAgU/NlgXDeq0A4KkIEQLy7rTP4lh1Vs8TWjQ4byh2dkfdlAomhPi
 PQQv2kgcJnzgWRWIxWbisffTS3dEL23vejh2dsMvHxzwC+emaZaUymHNJqSEky8Vo/pl6d/zdye
 85kPiiiMWiYy/8ilha+Mlgfa1J3rO0IC3AoiKmVl1l16d1rTGnobiPHFJcIL/t/95AiDTi74IoL
 gX4VxoG+DQjLtwLGlUWoaMIbpMbTFMn5iaUjZs0YvroA9hEX7mn/nHi0XZRSRMkCoJQAOqTmRfU
 lOA7pOlBsnkqwVd0nXfN0lybgoSWZHy3KeQzS7VD5TiRkLmxbPdWoCv8wBy9MckIyD7c8=
X-Received: by 2002:a17:907:7247:b0:c21:752f:c44e with SMTP id
 a640c23a62f3a-c242e214b60mr692462066b.16.1787206754543; 
 Wed, 19 Aug 2026 23:19:14 -0700 (PDT)
Received: from carbon.k.g ([85.187.61.220]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b09448sm30103966b.17.2026.08.19.23.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 23:19:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:19:12 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, uboot-imx@nxp.com
Subject: Re: [PATCH v1 1/1] arm: =?utf-8?Q?draeger?=
 =?utf-8?B?OiBEcsOkZ2VyIE00OCBv?= =?utf-8?Q?n?= NXP i.MX6(Q) and Intel/Altera
 SoCFPGA Cyclone V devicetree.
Message-ID: <20260820061912.GD24421@carbon.k.g>
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
 <20260819153014.834228-2-petko.manolov@konsulko.com>
 <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
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

On 26-08-19 13:43:26, Fabio Estevam wrote:
> Hi Petko,
> 
> On Wed, Aug 19, 2026 at 12:30 PM Petko Manolov
> <petko.manolov@konsulko.com> wrote:
> >
> > Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>
> > ---
> >  arch/arm/dts/Makefile                         |   3 +
> >  arch/arm/dts/imx6dl-draeger-m48.dts           |  24 ++
> >  arch/arm/dts/imx6q-draeger-m48.dts            |  24 ++
> >  arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi  |  20 +
> >  arch/arm/dts/imx6qdl-draeger-m48.dtsi         | 369 ++++++++++++++++++
> >  arch/arm/dts/imx6qp-draeger-m48.dts           |  78 ++++
> 
> Sorry if I wasn't clear, but what I meant in my previous comment is that you
> need to upstream these DTS to Linux first.

Unfortunately this board runs QNX, not Linux, so upstreaming them doesn't make
sense.

> That's where the real DTS review happens. Make sure the new devicetree files
> pass dt-schema validation.
> 
> You should send the i.MX and SoCFPGA patches separately to the Linux folks for
> review.
> 
> In U-Boot, we want to use the DTS directly from the upstream Linux repo.

Can i use some sort of DT validation tool that pass kernel's requirements?


		Petko
