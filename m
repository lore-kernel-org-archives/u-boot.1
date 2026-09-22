Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F4C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8914D80E7B;
	Tue, 22 Sep 2026 16:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcMvOW5wdo-z; Tue, 22 Sep 2026 16:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 907D280E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095414;
	b=E265+dVczl4K6eiG5qXj39wPS8rjHM1u4LzgUt9s5pOg48dPpzQZg4mXe/IF600JCbKS
	 WLjI4NPwdpcrde7L6dTAwG2HYi4Zz4soUL9j31bIlID/SzwpU+lUeSWq6rRvNCtoVJP6Y
	 /tq5+RrqM/ncYCxDHICRfR6019hKeSx051et9CHA0+iYO9zbVSErQ1eZ+7Z19e0iVRaPd
	 qbVG81hA3p7yC5/y34smm1fJ60vyw+MzNZpwlMkkS7wFeAkrlQP3CeKOzHPxR2cl7fBzB
	 8+Putv8uhh14sW2y24coIhzDnoBfz86xEh+EBkbvRFf7SmunacnljshyBqpQEh2Lrcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YeKmJPssdSqHp2Xxm+oJy8zXFjb1E1sW27w3fYksHLk=;
	b=iJe/CYr9IaeuXFYiCnwnAPo2LJLS4IrzaSd4MluOrwZ80IOtrQpuh2uFtrs06B7nQy6Q
	 +gi+oKNVFfAudWezFkjh9RQumnnTzdqOP5xM3kfm4X8FzXWcHE1Op8shrumu6Ahdooy7t
	 GEassS3iB+5bnOzpA6qPAmBaGecJpgkM+pQc/v1JqkzEpSS8HiXM4zc0u+SUBG5STey23
	 hWVt2uyQWPUIKaG+4o/4GKxED/8IuaQ57zeUy+T6s6kYofWGjTm+NB9UDtrFoNP5S1gtx
	 5dRdXyx6f+dCw76DNZV0T05VqaI8LkNjKnLvVlRLEWiR4jgDwXHilyo5jPMA942sTgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095414;
	bh=YeKmJPssdSqHp2Xxm+oJy8zXFjb1E1sW27w3fYksHLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yqKdC5zHUedym16geMFvdP5VoOfDFjAuSJBlWINpqXi5vATix7RFL2CueDJjsPTrD
	 sIdP3rTvZ85gp9C2DSSGaxrh3R0Ehya5uH1ykwpxbDgSsDCBK7gEly5niLMb8NHuFz
	 BVYPB+guoOih6Dwy5qXkCnihCYdqmOInOO8ql8wQQ/Fymxh4GQMFASU8fpxHNV6oOp
	 vbhABxrPvxPBxQnhkAXAvM2ZRj3gyPNo1GyTBmdJps2ZXJsmCcEMHLmLtd2Xps6tA8
	 kBXxDjb5adqOVF4ie7kZXXjtGDU100W8flSe1zJZfun2vLBFc/pQbFnbb+pjYsrfBb
	 oQyev4VoxVB7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 907D280E3E;
	Tue, 22 Sep 2026 16:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0BA35A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44BDC406E6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJfA8kD0V3Li for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5BF1740647
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790095412;
 b=hCOdPM9ZQJyki1k4xdrKq8PYbd8/d1JsZgLZPNfnpzuiZmCzMyMeXFAuSEVSyW3oXNW8
 QG+ePOjWsYoO/Cz3cN81+Yb6hApKhBKXWRMBvNIyiDSsaEv6J51gYubQD+5R5Crn/1kcZ
 hml+jichLgcbI6jIs3UrnaM+ynSwQV8d40DMkaczABI+HZV76ifIFJxcEP137modqLiAJ
 aFLzHkVZTC2/pE3WZRLbHhmco6m4DaLOuSYv8V1zMlFkX7/TuZwzYP2Wzh9CKL1RdaonG
 MQRACc33QZfE4fE4bh4tOmPLP3OfRT9+Glz3QjB9Z9jNNvemHUMnqUnp7nIrIMCTXOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790095412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=YeKmJPssdSqHp2Xxm+oJy8zXFjb1E1sW27w3fYksHLk=;
 b=QTLcGLJACTyvdthrVPjLbR63OEsUI8jouGYnEa6h1jp4/GRrOLDuu+Zv8CI23lgTwZZ/
 oPrz2ShKJhCyKKgEE+Iz1C96JCmYpcPGqq9OT/N7cKV2NY8DgXe9X2VlvIk2BrqxGZOY+
 eGW+utYier6hOersj4VzT3hQv/DOilxqAbXE/KTwge0EM9nOKIhF3oFIX40Yflt6Vn1+G
 LDfP4/7PLAgFNiKRsCYsdcq6kOQIQ6x/LfCawDEWvfyqCSkbBCvpHjABNPeM0nIG1Uhrq
 K2+p9UakgI+lUf/zQHFsYncgdEW76u3P4ZT3BVcGpIpbKuqF8dk9jKsKBPIGOEL5pKA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CGp8gP0K; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CGp8gP0K
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BF1740647
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:43:31 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-46ae9734a12so37907fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790095411; x=1790700211;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YeKmJPssdSqHp2Xxm+oJy8zXFjb1E1sW27w3fYksHLk=;
 b=CGp8gP0Ke2kzUoeN1PrC2n7T4xuwExwZIahyDAQZJEY1Wfd0v3FiYZWGaWE9j2nQf3
 i5oppB4zNgXhI4TO/4UqYl1KKa3ZQxM/rvNnQuwHp1YSwpZHIzKphuHU5JOh7XfsycMe
 HmWjTDe+I12sbRaaj4nn2XoOm1rlddVme4M2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095411; x=1790700211;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YeKmJPssdSqHp2Xxm+oJy8zXFjb1E1sW27w3fYksHLk=;
 b=X1iKgOIRNcMZMqOCKPd9Sx1ZcuR9goTKXw3lDEg8XYAnJ6S2yKqB27EKV10K4R6LjR
 ZIoFnoQk5EZAnAb3mkpYHpqf8SjI8S3B8/WaN+7RwYOsal+yOh0wX+joPQSepjkMi2kW
 YsbJB5vuqPjsHK+kD1L/HourEQgUf4B/ktdL5ofhBTVTS9LITtqyw9lKPTFwu3nr96sR
 qebWfakLR09wLRQoSKUpiHMmh/f7a65u1lX9hfAkJ1jXJ8t9KEiSVetJUarUFAvrNT0w
 jg2IR8lTqS3SVwLlywvenxH+jTZKa96ZewBKw68CC9lWv9FWpj9jCmJ/fjquLEpf8N50
 sLkg==
X-Gm-Message-State: AFuF++m9gJg5EAanuAYaDJLR6a8SfNSSbhq2ksMzSY+oWzXl0VW871+f
 RI6Wp/EHGM8ASbrPfuMKd0lE0MWG5VYRAbf4KZTeqfnwzvgtAyI0Oc2eyKwRYLlWixw=
X-Gm-Gg: AYBFou1LROIDIztZOksCuH9nUveQ7k55d215A9nAuC8tROAD1rVpKqsnydzLJwZ1tUi
 ii4zCKmmgB+4WrcENKN5jPYD5yVd67bIFmYX+bHK5zLHhRZUhGsDNAkGQrLhvbhqTtlqDoZQnps
 RHKuGcWcf3VG1dgc2UdKl8b54Ba9nl86EUDmLt21hc7/9aJHkceMSUaeXB6XLYxHpoH1ZM6ebij
 sJ9NUoDwyY9Ks/mspFL9sg0MPRmD8b2JOCU64wMuMiVsB8t8ncCSh3OlfCR/MLTnECagLhDBLlS
 wRXNdUQxewY2L+V57vu+L/x1n6Z2mXVA3L6GtRFN2QqXZVQhdQLoqMFUwfAd33U/zcyWNNcaqgi
 AZZxygh+C2wstf4bvK5GF8h28gWE+OsvgMTDCe/T9FQRabMO522MDN3B2Pumn7+ZdobO2XB63at
 N7LJWdHU5Ul3J66Y+1kLxiXM1u8p0LMnSJNccuCZ1vYMISgdlYX7+mFzBc6djGYTEmlkVPzId3l
 saWxRB22IHeFq7xeIJX84HUOjlbda2FCPOTol2b9a5IWroQtLtwxvS240+b2gbD18Hd30BT7c5V
 lLdYq09XaW/VUgVahVQ=
X-Received: by 2002:a05:6820:a518:20b0:6cd:3fec:de83 with SMTP id
 006d021491bc7-6cd3fecf3admr6700203eaf.89.1790095410762; 
 Tue, 22 Sep 2026 09:43:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d1df5b01c8sm1748218eaf.15.2026.09.22.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:43:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260921231304.3565381-1-dlechner@baylibre.com>
References: <20260921231304.3565381-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-09-21 into next
Message-Id: <179009540993.667067.4417036854384651903.b4-ty@konsulko.com>
Date: Tue, 22 Sep 2026 10:43:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 21 Sep 2026 18:12:34 -0500, David Lechner wrote:

> The following changes since commit 951132236b9adc592c2e49faadd103c6a355cac3:
> 
>   Merge patch series "spi: Convert drivers to dev_read_* APIs" (2026-09-18 11:18:46 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-09-21
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


