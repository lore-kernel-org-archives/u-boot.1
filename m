Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D1CD2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0848084175;
	Fri,  5 Dec 2025 00:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yf0klPtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131D284129; Fri,  5 Dec 2025 00:10:34 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAD3840F1
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c78d30649aso1403249a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889830; x=1765494630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6fXx1VAj+XzVl4YAyJbj4QhTHKesf//E2WLfbrDtAU=;
 b=Yf0klPtSOHAJqJoiX8jja4UB0PyBziS9ANEtx5HIRKZxP3BlKI22rdfoEeIw46BJJ3
 HVYXjV4k5wZh2aEMZ0CwzJ/tMJKh7N6fmLi/tWJ85slWx12XOFjDpLdgtAxWkf90GBk6
 R3unacYEYZLthAMaD/85HRScMv+RWGk/1GpTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889830; x=1765494630;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6fXx1VAj+XzVl4YAyJbj4QhTHKesf//E2WLfbrDtAU=;
 b=OKneCbkMiL037bayBcNlbCXs8DUmX1xDASiDNT80+Y9R0H8FLtUn0v+6Zxnm169Vgf
 zhG0TFF85t+CwyzDvzfWpnEePJ3XwmvZuI6e2w41KFWS2ut9RtEBvqnKs6VnHzbxdDNj
 fXIv5oLxpPU5fNlhUegO6I2vjG+RFm5K+ncoGZkcyVRGakj6o54emo7iGrZpnTR7xEKI
 CKiX6wQdNMwugrQJ7CJTcbifDLJG+NrufrKeoVKgETYrUnuyCRLTk028Uh8fvLZkJ47S
 JLrDP9hwsW5Zasp6T5FCRZrPBgloweUkmqTqe7EImSMdvWq0ZDm3ejbtuo4Qwrg1Nxa1
 7pMg==
X-Gm-Message-State: AOJu0YxfzrDKev9cSx1Pz+vWaqDwGyIB+zcyji0cIzPltsY3pu1odCdt
 Jm2qP4vm32x8FkdZHRYMLqtc7GV5SCJQnwyBfsVpWDSDBPvz/WMHkHm5E6/pc4vqzWc=
X-Gm-Gg: ASbGnct7R3H3p3u//cUngk6S+Smq4D3GIRQ2xL4Ol2SHOutvGgDQFV1cAciQ/v9P+Rf
 X8JCRZPc5gUMWV2f1pk+ZmUTUOYFNZD5lq68gZUqcvFdmej92jlrYZmPW3aZIbbzsNUO4LQWxlV
 K404OhOciSC9QS4VRvuGLNbWftsWoZAceiJKnpOUeUxe+D2SZ8OSRt+zhTxxuPipzPqzQ3jjIJM
 ugWdofJ6pTDX/XtiZESYZlSud4+rkmpxQeH3NHLgzysPqQpqeADaxitgm86/t71fTTOeIzW6uLr
 rh3hqzBpV7RxS2NlNI+YT6NETqvArreC+M3aZB9Hd+PErE6viMJXQyI7GdxEIyoUani5N27eWuO
 JV0e/sFVPrIcy/Lf265ZEnzkx4zNM1Qn0VXBekdBqk3n1tMZr08QFwGchPdItyPIMfq7TPDFaQr
 w8fig59Nd+rWAo23d+OoBoiuHLo8Xp9sbiQAIswYxnUlvXaHIW
X-Google-Smtp-Source: AGHT+IGGq7j7VjY5zP+/dESYkeGYQcwvoAhdAu6V5mPjkffYnPiyuRo7XTQCGqsF+ZaNv52ayl9+Ww==
X-Received: by 2002:a05:6830:4487:b0:7c7:5d01:a888 with SMTP id
 46e09a7af769-7c94db164d4mr5657134a34.28.1764889830308; 
 Thu, 04 Dec 2025 15:10:30 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
In-Reply-To: <20251118142641.526356-1-trini@konsulko.com>
References: <20251118142641.526356-1-trini@konsulko.com>
Subject: Re: [PATCH] adi: Stop disabling device tree relocation
Message-Id: <176488982937.2091996.7812921842239636954.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 18 Nov 2025 08:26:40 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] adi: Stop disabling device tree relocation
      commit: bcc53242b95f0d2e4b51e7e3e6b26c0b34790eb6
-- 
Tom


