Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC8C5AC9F
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9C94813AB;
	Fri,  7 Aug 2026 16:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrRUM3OxNypM; Fri,  7 Aug 2026 16:16:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 585198137C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119403;
	bh=14Y0ODbcx+sHfetoOiqhRSP1dSYqO0UGwkGIi3sQIeo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QSeLwU4o2SI7WPoQdhBfOkwb/dQGOOMlgP0VPQMYBHHwIPzkg/N6wKX83g3a6h6Ej
	 INuGPt9krKEAlhFSRJ6LY6N28ECWjG7JmiGpkhV9svmOfKe6GEO2QPg2NoRZXaYDtx
	 bJZ9IHG76ojda+RTyIEepOflifmQU8iEBIP7pqII9WlqhvmtY3Kxh28xkgR4MmDtNb
	 rrMXcKdJoJ82ITrIQBNsaebwJb/XjQoMx1zBTez/Q8D+ifGApStJBvpayh8nmeRHRT
	 Gub4gCtsKhN66aiH+nNnrom47pM7EcilY44KhyCGXx8St4nLBBLOdKZ+5u4Ht5OzFC
	 8hVeWJz9xKSzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 585198137C;
	Fri,  7 Aug 2026 16:16:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58ECC198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B15D608F0
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cqv2jUtW-cp for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 72A4460601
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72A4460601
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72A4460601
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6aec68b03e2so982512eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119395; x=1786724195;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=14Y0ODbcx+sHfetoOiqhRSP1dSYqO0UGwkGIi3sQIeo=;
 b=riOi4pdTxS83PPSPKATK2UdA7iaPpNBwg82rTklDy7pvcI0BorHoP9LY1so7nDojqi
 qCn1oHPwOwVrCNvulny7Glgf6MdEOHGnRFG5rQ13s0WpndVlVRg/zt9hzqveUYdn6V6h
 yHg2rWlX0kgM8ruasUNGibJxqOtuaRk+mJU+SMoGXoUuMRpkr8ue+fYrdsOO7djJh5pE
 BC1ioWgCPbQhEpqWKnycodWl3QnBJjTMkJYHJo4JONDJBRSKk1ju6pcg5KcrBR4mlDG6
 SHyMZkRgWDaGbIV4J28a6qWPR9zoZZPXWPMrhYEG8DAzRrccHdjKlmPEaTKOkzndW0cK
 iNfg==
X-Gm-Message-State: AOJu0YyPj3GEQGIn7GrhafYUzrv2N1PcE+fh5M52hr2hmj3qcmSo6zEH
 ScMXJkjolOkt6Jt7tple13Ng5b7ii/V+xy6eoxTaTYZt6gOu3l63mZJk4eN1O5YX3sfG+D5oA/e
 hhHUUSWI=
X-Gm-Gg: AR+sD13k5kWvb73p8v+i/6J83YtTfFX5rTk71CheqLbQrSqEoUGdbGJGanr0+ngcCLm
 uHHqVLfmUepZbsGMOWi26FCX9LbVqyABKKMuI4yNf48aAYfxlTXln0rXG7a3pGQXTwlw+8NeoFl
 ARbsGQJNwkbIMkVYTEQ6QAJCaS2aTs6odtreeZIuJDbqrgWtXQcEY7TjafQMO99FVodmND4Ojnb
 oZxj/yp5i1ci08Y+DoGDzedTAglFTWrJsXB6ye4A9leMZdP8ZWyfjXOLUKjZtgWCs8P08x4wXUf
 +2JpzsN+xVcUjDeve4XwbjOKePB8nIb9WdzowEUjIY5VQ+P1chf/nFe6ebu/qK2HDZCTc6B5o/Y
 jCx9la/R5CQTRw0RuMNAG8aIuD5JxveJgUAO8wgy7kgxsO89hdhAhj2ZoYbX1zZYtAMKvujdWl3
 HiGVvxoGiyDbQeeNlrlj64ds+N8nwFDzQPJZll23uecmqg1WPEAdXZEc3nzQDFMdsxRyVCDxJ/Q
 AnMnIS4OOmeom/YyT8WjhS24zHsdj3WzEkZhIMlwXSqpuvd6SHtr4I2SyRlx7DiZHuedSFH1kpX
 6nj7uVv4
X-Received: by 2002:a05:6820:2908:b0:6b0:1eae:8c5c with SMTP id
 006d021491bc7-6b01eae8d7amr6248849eaf.30.1786119395361; 
 Fri, 07 Aug 2026 09:16:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <leo.liang@sifive.com>
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com, me@ziyao.cc, 
 hfranco@baylibre.com, jamie.gibbons@microchip.com
In-Reply-To: <anN_JWh_JneoPUOa@lliang-1876.localdomain>
References: <anN_JWh_JneoPUOa@lliang-1876.localdomain>
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-Id: <178611939463.381449.7397637414414902605.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119395; x=1786724195;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14Y0ODbcx+sHfetoOiqhRSP1dSYqO0UGwkGIi3sQIeo=;
 b=toB4b0K526BZDWNI6mL5XB4vLITnpL9ARUcXpbqLn3IzYN8aGI5rpkyfXjg71JN64y
 Crp8xouq0towHi/cFFEltNJA+XHbkJyROsJ5GjyKHSwtjk9XS234F91Np4DjHHvg9x4/
 tgj2mm1OZrcezSA1LHk+FnWprh7dgYc4GPo6k=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=toB4b0K5
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

On Thu, 6 Aug 2026 02:21:25 +0800, Leo Liang wrote:

> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


