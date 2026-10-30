Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F1606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tm35lr7y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvoBApmo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFBC440B26;
	Fri, 30 Oct 2026 22:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GquaUUA5Aq2S; Fri, 30 Oct 2026 22:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3768640B0A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793399333;
	b=qLH4JkKwQe1uvgWFRypPHYjy61Yu5t03X0T6BX3RxJWPQ7bPfJyeb1affwjGYP1Ob0aw
	 u7l1RkLND/IpBwHxtMr2n77pCyZdOm1nIG8vOI5ua2slQQc1nGFe8fy1NV6ReaX5Kq+na
	 rbfRt/4x1uL/NkLGPbssd9DaoX/d8K8ATyRBTjOHvxjqH77o+ZzVeS0z7G1yp2L5RrTXH
	 nKODj/LX+nAi9uwqhdS37K4nwME6xNQQjSA4fSQT7q5rxA33CdNy+lfAg7EylhWD+q3R5
	 WO+NiEZDerE3soPtx97Oe2X9tF9EBMY8C/Faky+6zYzfhJ6UTN8NaP+7wcEwWUAMA0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793399333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HRrINy50S5gNtTZLJp9KO2q9Yg8RPwHtJqphCJv7MXQ=;
	b=bPRsrbTqKQ5wMimERdCawCEMWdyRvxhACHhUgkyw4jT4r2itZAOa8yNhKp9kgGeIyUPr
	 t5xO18Jy8YPDwgUi+W7ZTKFHVWvnHRmM4mG/iARn5u1d62IkHBWQuG04G+IY3/hwDTf7E
	 +F6tvSOUh4qUDOegDu2ewaaqXt7WiWSr6KwRijfDt1E63APQYIsJB6CwWq6GHcb+njJ2b
	 LjQrcPeJCIehQDYuZoeZ2OF23aMj8R3fw0KbKHork0GHu0sJqRa7EecZ0SeB2tzjjZpFy
	 s7qhVAZ4Yu4bn1SXjWyqzNQNe2GqMjXYuVFacLEzMkcCMyme7Lyovy153YsN8cgmShA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793399333;
	bh=HRrINy50S5gNtTZLJp9KO2q9Yg8RPwHtJqphCJv7MXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tm35lr7y/qQm2kjfGDDrMeRCsiXYmH1nkp1hYSgXDozC/KkTZIv/jwri3/t2edMv0
	 UJxMLUoCS0XJGfnOt+R6RuzLPOdfiRuVzKZ4NyL2HWfs8JkLk/4aoM0QIlpEuN5jmX
	 kBdBlRtgQQUM59jL4eY43YLffQ2q48ovvXZGAJEmk1lsmO287zHcEO0fWKl8o7YN1i
	 V9/6qLWxOY7zQfUdt2bfEHE3BCsVuf6m3YrM/7L7zGsTrSFTeMCZh32KAsFiFEfLhH
	 Vo3GhVu8z+XfjqNiQ7D1E+cxqsszYEltrhxE00VlGWdJqCNuR5/h8eOE7h+hMbEEtI
	 930XgCo1b9o7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3768640B0A;
	Fri, 30 Oct 2026 22:28:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0D3A156
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C687340585
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJ2RK0Rryhcc for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 22:28:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4542E4057C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793399331;
 b=ekIitXGC9ycCUSgOwFUiO2dZOY2oQBSv/y1j8+mqQeSW5CFOUZXG6BFCcx7jLQT8Ze8I
 b3xDsyKB4qG5BCsMD7WlHZVvuruB49wnisS45YpVcZ/qsvrEz0+Xc7mGuNulVILAR3Lf1
 jDUMfYCT4Oz8+KWlGxpWLqjdNzyveeHMjcr1qVB5DDgTRJwknSfBrSBR5xHWwaiyvSY+B
 18QJHB1w5icDWOecku3GTnBuFyDdwWfcuf1NLfBCSejTmMS1m+25Wz16FK2LGx85D70ij
 nMLEix1kKbtHrKaYlBh3+doLh2Ac1GOvCPO7z5x6vdo+8QYY/x85KiMWTXSmjgJ6rTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793399331;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=HRrINy50S5gNtTZLJp9KO2q9Yg8RPwHtJqphCJv7MXQ=;
 b=Sf+bW5k9iCUrb3RbJcasCl7hVVLD5pGA1122OBPl+xi1sXHSW9jvzB+4YNf0aL5qUl+M
 zR5j0KW+Z85BwPKnYhxXjWm5PhnBgT5USfWt5PMC9kEdHIztrL79oQ8bELEsa6hZ1NO7A
 gTR3P0NU63Jn0/2/Vnk0DDEHLVNJNSlNhN9aY+HKQ86WIO7EgcuRhDjGCYcqJ9X/EyM/L
 LKJ0J3bLwdYGGK4DbyW80u05PZSdXplbEGGABJJ2y8cNoCu+rxMyJdXP/plB2gELj8uvO
 iIt1OktpEjlZWicleqcUoI2wNNCP4c6PFoYIlcyh8eYNVMoa2Xj9VENi0mOA7TUkbwA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=lvoBApmo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lvoBApmo
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4542E4057C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 22:28:50 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3282db206d3so324624eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793399330; x=1794004130;
 darn=lists.u-boot-project.org; 
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HRrINy50S5gNtTZLJp9KO2q9Yg8RPwHtJqphCJv7MXQ=;
 b=lvoBApmo/e8eiZPuLzuTx9rxXsdzG39mm1Ign9MSYOctzmW0eRA98dmMzkFiVzJy6l
 k2giDSJVrUSiyDmqLEbbQm1DaHvvT8XN+IkUdSqpnABEU0L3PyfzRTQW0e+QpOBPBDnf
 0pRGdAiidIqTwet8PWPbr05hAXyQWaAweqAd2GKmSKMqPb6FHQNjFllqs/nS+Th1qZu6
 IKDma5dJ0D6YrViv1qGGV7gkqGjUN7nwYkBl6ntrOZeY8UW8OwcjAQlnfeoiVhRCn+J7
 z18e17JLjeC6c4aLPGQhtEQdMrBkyqc/38RzWWKe4qrE446BIAlcwhI7xXFirmOnKm/c
 WZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793399330; x=1794004130;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HRrINy50S5gNtTZLJp9KO2q9Yg8RPwHtJqphCJv7MXQ=;
 b=WUArX1pPW8kb34F8yt8K+XEagzPkbwZSJMTdtuu29cbdcHSd4CUC27JI1ToMT2e113
 AIpfxVVkGX0I4+IbMnDHt3W3KkMZwArKWAoP+nLF04TtpRJMVXKtoEkMfYzYYuYUl4Nn
 64bq2PDy9B7RYZ2ZNfyRHGAc6EW/OvjUNTfKc7R9WrBFqFs/a8w9veBNUOEjD6TSZJdS
 pUfWJQ4TSx0/PpMI3oQGkwn5KxHPW0u5ADxRsd/Cu4dVmlEmnEM/eYnhp4pYceZMqMYR
 2B1oovQfltcf+1vBX6sHDfx5S1ETBG1nz+lOvJzjgDUvhUxutF7+aFPJQPDra8xETVW5
 j9UQ==
X-Gm-Message-State: AFq9FYKbOFDJc+0T5I9OY62HF+CNUuTT3JYzP1uPccsLc5aBac9pwmp5
 H6tJvbElzh2taYicBf7wwE/zjQ19Mw7/LiBnp7kLul5XwFJ5TRdRxow/Ptu6kvt6kuk=
X-Gm-Gg: AYBFou0xaxUamjp4WKKg01PL1HaB8isf1RIDyk942gDYoSODHfbQ706fsNwOEjdcc/t
 P1p1GfkpiR32X90B5NA/HYcF+TkacByBpf7etP6uPgOKrdSgcSezPItPHlLhuXKOfqNARH2yGW9
 IBdITpGygCRvKW1479PEoXCsp/Q42ZFfTMh0BIjPCIWflX5ldDPJOQMiScGbeUweug88PBvLm+R
 hv/QXFG08bjjk3gf/aUZ0LsFR/Fx2oSgO1HkorACodX5cM9F5V8FC7veHWQZ+Po/yTTqZNZLDWF
 dtYlGUQfqRJCp2AAnzxFLXvOIo7f4lAEClq6R+ieJZPJGn7n2TPF0lgg4Q+sGUXICdgrAUympTj
 OOdpf7bpk8c7Fckp0uRL7FUp5V5i2GzPTc6s3YC2swILOfAvqtZAulz0oFuVGOYg2QbOGoT0/Sa
 HBm1mE14mj8muBYs3p1dIVTpZ1s+Oxd0ZSVqx/BTJqLkuxHJj/CXovtucaZeiEvwxugoYcoGvdn
 kkt23w3cC6LUQN1/cUWu/kJqct/jOPhYFCPW0dcgyE8sEnxnAvPOdh4cBDqy4oH4uEGgaLJDJyi
 ZiI1ChB+s11+2VlDJHdaqYGBuG5C5z86P4PPK1k16wo74jdz2hjZ3KiuGB7Xlei1aGpkfUhckhM
 P1HqEunyhaNOsD6Wgf0/MAlv+Mckl1Q==
X-Received: by 2002:a05:7301:490c:b0:36a:1819:4d0c with SMTP id
 5a478bee46e88-36a42438ebamr5274671eec.41.1793399329903; 
 Fri, 30 Oct 2026 15:28:49 -0700 (PDT)
Received: from [127.0.1.1] ([121.165.170.166])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af91bsm10133636eec.8.2026.10.30.15.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:28:49 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Date: Sat, 31 Oct 2026 07:28:26 +0900
Message-ID: <179339930697.12710.14888890033364215367.uboot-usb-v2-ping@gmail.com>
In-Reply-To: <20261006155833.68374-1-kforce@gmail.com>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek, Tom,

A gentle ping on this v2 patch.

Thanks,
khaliforce
