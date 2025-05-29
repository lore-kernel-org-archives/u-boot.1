Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A23AC5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 07:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11F781D6A;
	Thu, 29 May 2025 09:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ScP0OjGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C6C82991; Thu, 29 May 2025 09:56:42 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A3C80F0E
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 09:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso84163366b.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748505400; x=1749110200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A2ponGDLi3Pkj5kuvPS2eAUxEdCPH9f+qv25M5j4wAg=;
 b=ScP0OjGKwyw3QhUDpL/p8QuI2RePmkpphaJP3e8+AavJABao/SmMXFJfn7J2H8ZIZu
 wOcskwIePJbXmgcVKmBAlx7/QlsGcDZck0YyoPmIBUMr3ZowmxW/Ium5oNJ4N8lwsb4z
 uJ9cbg7skYiQIY8wriquMls0rz+gx57u+dm6fSLdwxl2DlZwlc772jCAX0JWyu1VAIKh
 4f2lFsYyD8v4/GYbpiEj3OSREVfF3NPENLmh5HsGxxj+VwHii6FKKNhXBgZSO8sTMC/U
 4NHdl6PN2yun+n1yPTdkdrvsHmtKGNitVvkh/RZORrFpm0QbKtpaicQmdno3TEQJpjuN
 gjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748505400; x=1749110200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2ponGDLi3Pkj5kuvPS2eAUxEdCPH9f+qv25M5j4wAg=;
 b=EkyS/7U6yXjH9VUZW/VZPSAar2KISlUmQlBoNHrcYMBlMEQTJ3itDak0Y6w9xh6DT6
 SpRSt8lkymx4uICKW0Iru43IKgr002tRNKxaiecr701nID0kN74vOJxOHXQa4plCoE23
 cjoAubZgJoM1c+8UZvua3RtDsrK9QFBprmIhoXSmmlBT+6UAYERBb9aM80Tw1OQHV/DR
 0qHb/8VfnZ6B721JdcnGFFMmJh/k/Y9rHNNu66/YrLscpi1zBzO/YDquiJYAsRN+yVsD
 U50Hxua5ZsVeIqHJzfweFEguXLmFvATxD8hCu9iYLXR/UGLBdZDCVidDjuaC3oTo7esx
 KVOA==
X-Gm-Message-State: AOJu0YyfWJYhlU6a5RmGIe4CRYtXs5MwfWEsf6LB4Ua4M+oxQCtkvhHe
 8DOwxyg6msNvB5tiZkYQlCpv+U86MTMdpOq2VNeUBsDYYPnvG4WgsrdNZQADjIt/4hHbRODz8+0
 2a0TLYIlsVsuH+PLFvxGRjSV5dpmoRLukOADC
X-Gm-Gg: ASbGnctY5UPOiUrEbBcDFZZiZs5jNUONWtbtyftbKxJjYLnzKDgYR8/zrj3oPch8q0w
 R99T063q60e6UGzGgxctZnC17N9cDTVqdIapRZHdfad8zwN9KzEb0T98A91mwwthS4PI4Paqybj
 +UhOg7cdRckg6s5Ap/JjPABlF3V9EYlMGAYBgct7iSsMAJAg+V7+Ua9XtlE0K2fduehw==
X-Google-Smtp-Source: AGHT+IGMaLJxBwnfH2pDidQSZ0YbdNatyynalkTEUT+qFnsKtiveC0j7WFA5bd4FSIalMhz5VkFmeqsP+0mKo4uHuSg=
X-Received: by 2002:a17:907:3f99:b0:ad8:93a3:29b0 with SMTP id
 a640c23a62f3a-ad893a32ca2mr807008566b.45.1748505399620; Thu, 29 May 2025
 00:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250528233050.3820722-1-trini@konsulko.com>
In-Reply-To: <20250528233050.3820722-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 May 2025 08:56:27 +0100
X-Gm-Features: AX0GCFu1Hn_qvQzsebxm5K3Qp7zlS62elNfsVN6b_uMtXmhY_SAiklUM8Zg3s0Y
Message-ID: <CALeDE9N2KA+JU1iyr3a9Dnhrw2uQ16ZtacWjQHhHkxB5+r6N9Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Remove as much arch/arm/dts/*.h as possible
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 29 May 2025 at 00:49, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> Taking inspiration from Heiko's patch[1] this series goes and cleans up
> all of the arch/arm/dts/*.h files that can be easily removed. The big
> challenge I ran in to here was that for some platforms that aren't using
> OF_UPSTREAM were didn't have a sufficiently deep search path to find
> files there rather than arch/arm/dts. This also showed that only ARM had
> local header files to deal with.

For the series:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> [1]: https://lore.kernel.org/u-boot/20250528090536.765499-1-heiko.thiery@gmail.com/
> --
> Tom
>
