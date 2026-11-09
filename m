Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B930606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ShkemjTK;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=apJoft6/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C725E80FF2;
	Mon,  9 Nov 2026 17:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwSy1vU_3E-z; Mon,  9 Nov 2026 17:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D6F680FB4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244626;
	b=FCJAPSUlwO3yndIZjIhfsD0aBvbFzMN9T2f63VUanZYTH6h0J/FciOxHIVgg58W4nDru
	 6Bm7Je2kkvT1aKnMdXFsEHWwzyQD4vL6B75RTy4oybzYj4g+d3fXJO4CBZI+DMRAeOei8
	 aRuoXBvCSOadxx34qJSo/PggVo7t1MVNvdI/b9LdMcjQQyyCEc1D6mx1XkmpW498+UTwh
	 rEIooaOpcxm1M58Bcg20LvCD24d8nCPmdFkdgEMDsSV5hgzSV1kI7QRgS9n2i9aRq5QGf
	 8PjuUWGpG3EVG/91aZB8V9ghToaGtxUszFDIKX6JYZVjK7oVZq500L/j1/XFiT76W5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RKbTtwWQAHlP4BlfoLqa/KLTI8126fikJ0JV43eLTM0=;
	b=jSUuH9QPCW7N76iOBIDeHhk0uZF41TYKpYfaXjm2YsX6LganaRmaEGLD+PPVXVCGADYI
	 funnPqXbK7pIiYLKIim5cZ7AX02I2NpjlkfBEYmx+3Sapb36nhdOfbToKaO854kGULBU7
	 q5friVyXllKxTQwj3+w/ofkUh6YZ+w1dIm8zvXZN9rzaSxcNEx/s9Wvq2d4Hjo2hSE92/
	 W9Urq29G+dvzLcMTmrPbjmJiOUdVjKF+L94ItiQu4f8BzUyAy6SgOkrjCVxV6WS/Gg29g
	 Lz3rzSjoWqWbXRcm71v6UzUajoyAlp3RSGD6XNrt3H0DsYa8ZmaeyCreEsrAHRi1yvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794244626;
	bh=RKbTtwWQAHlP4BlfoLqa/KLTI8126fikJ0JV43eLTM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ShkemjTKsA7qwf1J/l0Bf4dX8BKoNNkmkXxabbhP3yRtBQVD/uR8WnzOkAVjcCFOw
	 shvDAVAD8zBm1GuNQMEFs615SXUcDsjGajPPjEgYYc06zTl2BpIRQXxyWk4RjeCpqc
	 +bo0VeXDNDfWfd29sFOMhlzMxvxwNCUgemqN4JFXl7oLM+8XKJBY2VbtIOUN1btks3
	 4vrIAVfmf4Uk3yI+tcuGsxHRpTztNX440ikO9NYLt1Urc6vvlUqXSJ8izOiG2MRqU7
	 CCFDlaR5qgcu77I1oeQ80nsUqp1RHHvs2B9rsDWd8AwDkB7e33s8N1I3/gxbpVOVk/
	 1+vbZr/lClhTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D6F680FB4;
	Mon,  9 Nov 2026 17:17:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCE51971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B043C402C2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDwun6rjNK-g for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 09F1E402A7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=apJoft6/
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09F1E402A7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:17:01 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4d30639709so140551566b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794244619; x=1794849419;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RKbTtwWQAHlP4BlfoLqa/KLTI8126fikJ0JV43eLTM0=;
 b=apJoft6/vS9npera13ieGcuvDg6LD25bzq2p/ptKXAtruR3ouLVVB0M0a4YZLM+6vE
 SSqCRjU+3flOj7Zl/Z95xsvd8pwzKR27OJXXQe+XOmkFdGScz9brnTY71Gs4pqT4hE0D
 YirSj9KgOZX6G/2/788Yeuj6JyFM33LBDACCuyXB8Yu2b2HOkZ4NByzcXEsuvujMrIZI
 a9ajZVU5sVeMq86YFeSDIGC6OOazq5+mlsFQ8XhPLtN27nrAP2bUZRpgkct7cCbOjZf8
 aD7C5ll3bSs4WwgG8Xgx4oiNl42y+uKoZVsEr8IRbw6zi2VbLMxy+F8mflG6i3h8+f7T
 UOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794244619; x=1794849419;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RKbTtwWQAHlP4BlfoLqa/KLTI8126fikJ0JV43eLTM0=;
 b=pQtjUtSLe/9Vw05h3MB8q18V1g1ASOSnivP5uDuV04W9Uyfk/sD4qTAJq/dYflOptS
 OH4IQ4HfCbWtRK9ZdjeZ29KHbeN9KN9Y5arShebvJN4GPOeo2SzTe4qKlyr2EOgKbuBA
 rJaZJihGKQ0uS6Z8u8BCdboRLdll77wQZioyaxzeAFgiKIefAWdyYTmaFTFRZwPdmHcs
 6gQCWQJd1SmiJ77o1Vo9vij4LqE15oR/6zwagmP06Z7bBLTyaSG9fTQ5tfEp3ltkSveZ
 wyZC8gXq7GsoZLeEWiGak8ZBibn/bhx53UTYGtJkjhKi9bAr+fFW1I7UG5GWm8fZP3xT
 cBeA==
X-Forwarded-Encrypted: i=1;
 AL+hErH3Ib0+SxJSRGn3+DiFX5BSjluYw2HmLkizGhvM5XxJNip+x9OyXDWwELGEWgTOHON9PtI77qY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9h56Wfn/NvvGToc47ST6ZFxi80fTaYYrlamj8111FSDW6PK4Xa
 oszTJc/3D+ZOAAD9SsEX70lOMV1zYGKku3QKTSq/15joMIKCQMI1HPyQD/4pwKGczfY=
X-Gm-Gg: AYBFou3mqF/9QnTK3jeFvsukK1ErwHQtqEiJ+UGIbDskGnL5uFuA6aD12XSaHwx4yQy
 Cl7e5FfcrHOkdXmy29PBNJUKcQaxsy0PYQB9Wzeb9maxnoskDC+e7xjTBe/4k80vqRw2CwyfsXY
 SeBoDmPNO/8Bo+geg8qTBea5HqVPkYqyphQa14p5AghzJ0GOpSQX+kOw0oQziiL171nvTfyheHU
 Oc1LXr4SXzEYnc09To3OO+p/ONDtam1jGQE/O/3B0HEJaWA9tnf0KgVNYUOc6SSWEW5SiOi/WpK
 huNuEqyPcLa8MxJ8VNUveMV/637Sj2Cmjn5vtGprMKEdy+iegdaF05Z829+y+ridPmTTnW1yF9x
 eYsZlvgJFe+hziEodLg3pkLiXqWW2NBCIV3MPDbUPeaZYuni+tk2gdxkot2BZ8vcL5kAP+VAhVA
 gDiEfEIWVuby76zlJmgRNcBgrsBxl8LSSdWjmyz8bPh050NMbpGaItcVxku6BqBh3k515OtT/Uy
 IxlsXUHtlyR1E+eWfSThBkBI4UHE8+ZD8OsMpIY0jNlQEN8hlHyVUGjDRJBLrqCkkbngMMvt53K
 OTklG4WRMU836b9++gqwm6DxlKMMi8mqoMYk6izQtNjk4YKaFI0k8wsA7qNLRvOuODu7jVk=
X-Received: by 2002:a17:907:3e0c:b0:c4d:2f6b:435 with SMTP id
 a640c23a62f3a-c50494e6ceamr3023866b.18.1794244619250; 
 Mon, 09 Nov 2026 09:16:59 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it ([91.80.26.234])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d6a4738casm193614866b.31.2026.11.09.09.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:16:57 -0800 (PST)
Date: Mon, 9 Nov 2026 18:16:55 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH v2 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Message-ID: <avH_uOLH5Op_WH5j@macbook.homenet.telecomitalia.it>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 16:13:07 +0100, Steffen Dirkwinkel wrote:
> Running u-boot without caches is slow, especially if using rsa
> signatures. This series turns the caches in u-boot spl and proper on
> early.
> 
> Measured on an MT8370 module (Beckhoff SM0101, not upstream yet) with TF-A
> BL2 as DDR loader and SPL loading a 2.7 MB FIT (BL31, OP-TEE, U-Boot,
> SHA-256 hashes) from SPI NOR:

Hi Steffen,

Could we add the early-cache Kconfig option David suggested, initially
enabled for MT8188, while keeping the implementation shared?

The problem I see is that V2 changes pre-relocation behavior for
all MediaTek ARM64 targets, while runtime testing so far is limited
to MT8370. A separate option would let other targets opt in after
validation.

Thanks for working on this,

--
Carlo Caione

