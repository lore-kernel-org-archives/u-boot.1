Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C99CCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F6D83F8E;
	Fri, 10 Oct 2025 23:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LV0SRGoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B6F83FB0; Fri, 10 Oct 2025 23:36:29 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0FA83906
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so2662207f8f.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760132187; x=1760736987; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=f9Gf/LCpHZK5dQhjArtBvDC8tOfgKEu7/eQXm0ArTf4=;
 b=LV0SRGoWtpTeRp3k77/EWaQjXaNT/iydIS9TB81giq+g+JsoNVnyHGtpwnwiV9jalU
 Es9PHrAcB9TvCWXv1rNtqoEkW1u6v4bro+dRH18nggqLqjoAzMHQvH81P0QvarcYEWeL
 8ihbo9aMDWUJam/2kSefhuFFsf6PQEdjoLnMHCa77/4W8hhAT+ltp+196F4OvyO5VCAi
 sbxgJkMjCabXiBz3YyT7UGyi3TTEYF+Uy/IP4E7/Fgjj9jIBen0m6HVnO1M7EaGLgcWV
 swnHQeZxYh0N4m+Jtbg/ozzqtXIyCnAqal4sEsFjeuhMyDB5ehR/tGSult87OaTlDk/V
 Cr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760132187; x=1760736987;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9Gf/LCpHZK5dQhjArtBvDC8tOfgKEu7/eQXm0ArTf4=;
 b=CvTHHf1viuRklsJLvvl/2T16iC1Xy+NnX2+Cw0l/3fPmFbJNzBWa41slXFdcpYCZ6J
 poHM2Is92nmY9PCGAWJIDzv5hg6uRBH6XPUoF+SPdlq0C6e8FwY6VYwnKFm03zwAlBaD
 b+bYqnauEnjgauCs5Mz6qOCwFU55bRNhJ0ZBpU48UWKI8tMUDv/TBJsH/m4gmpAMv1nf
 LsJivFUJzo2rxdJJjk8uipvlNDhpROGE2U211ei/Db+Fqq+JTlLXxDfnJ/GWKXpUFAGU
 fkfUfRDjxbEVb+zpCkEzppAaB+q/qTG+80CL5pdkjE9hgBGKYmj8QGVsJNB6OArlrmCl
 BGdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiYe4uj1FaQ1dfVK5Q9+NChArqAaBA3yzRS2atwIbQV42GFGdvK8fnOudsfMaoCOugq2Fttas=@lists.denx.de
X-Gm-Message-State: AOJu0YyqT3CXstEM2qT52GQTfJgC1pxVOffj7qlFbp8b5WWMufpzWwjO
 eiqxAjfYNnppdFqrikC9BObe/5nZbcBCItPzDSP9h/xVcyzKMMY927ioCRWEENFxKPY=
X-Gm-Gg: ASbGnctqsyHEwQ2JgfBbCHa4CuyBcueDLm14qzS57R/pkxxfCzzXMzqZ3s/G+c7REwX
 ctmcXwx4d2euGf36ijxcoQbtduenQJKWZZzGm0SbNsjkAazY4QiQmGasiIyosUysBeQBak5JKm/
 ZbILgCJBmfM4Ea8UjnDo+zGDfmGZTZiO+VeK3HJyxtJEwis5qOE74Dri+hdR8B0y9Q54u+RJ0rb
 FGj8oiWuioxSKWWlfpsRiCFop3zgMs3OuNuSdw8cQ1Ly1ZBhxNNatBRb1p2/aXRZSL1n0wc69kp
 XBQcJGwe7NoApZf63iO/Hq+W4JvANn3d4DyCjtEjVOZAkBYwSsG18J21aGQK+TRao9MV9yWVgmF
 W6s/5TlgQ9BoiXIxMOgjYi25etYVki2YyiU0H8tXJQ9bFgPD58j0Hsw==
X-Google-Smtp-Source: AGHT+IF9R/c7Rahy/JUKb39id6817Rx348tXV/ZIopYo/V2y63ST6KpcSrLhPjTEB4xuJ7d2alFZfw==
X-Received: by 2002:a05:6000:430e:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-4266e7c4ed5mr10104269f8f.27.1760132187466; 
 Fri, 10 Oct 2025 14:36:27 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1206sm5754499f8f.43.2025.10.10.14.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 14:36:27 -0700 (PDT)
Message-ID: <83d5b542-e648-4849-80c3-a3073242f72c@suse.com>
Date: Fri, 10 Oct 2025 23:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
To: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251010161442.410C4227AAE@verein.lst.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Torsten,

On 10/10/2025 18:14, Torsten Duwe wrote:
> Hi all,
> 
> This series is basically a resend of Oleksii Moisieiev's from February[0].
> I forward-ported the code where neccessary, rephrased some explanations,
> retested and reshuffled the changes, grouping them into at least 3 parts:
> 
>       1: Fixes
>       2: PCIe support for the bcm2712
>       3: RP1 chip and MACB ethernet support
> 
> Haven't tried USB yet, but with the full series NVMe boot is working,
> and I get a "file not found" from my DHCP/TFTP server.
> 
> Let's start with the fixes, they should be undisputable. Credits go
> to the epam guys for tracking these down. Patches should apply cleanly
> on 2025.10 and on current master [ecdc3872a767].
> 

Sounds good, but please use ./scripts/get_maintainer.pl to get all the emails 
you should send this series to.

Best regards,
Matthias
