Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F795C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A715E8895A;
	Tue, 13 Aug 2024 06:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522443;
	bh=2SSiqrKj4qJv3pAA3dn4nJIwvidf04g2zFj/K7gc2B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NjIGgdiFQ7NgIA8kWkIJa3VH/iMczTHQtz9yBHuilhrjrjdxxh3DbjZZ2JxB9cAbX
	 fnLpXweC09J2QLjYG2MT3wqRh07fLgDp2OG0g2Yl9iQ/KFsjMac1tUb/QTGEGY/c/J
	 vrEfKxCUoBpNwmSO2EUWR2WwQy4wb2BXy2l0K5utfWOpoA+HTdGx0YknqrMiX9DSei
	 KwpVW4xcWAFlbFNy1WJGMHDb1ZLM2Og6BmHwPkEg7pQKRGveHK3D9rB3QBG+uSBqcq
	 4aZX8cdBwwhVzx4OHpDbqcfNO6lyXJMaKxgL4M1/633tCEiuU7aRqWo/N/lq1KoG7Y
	 vILJbbaOwvabg==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C428587E30;
 Tue, 13 Aug 2024 06:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522442;
 bh=2SSiqrKj4qJv3pAA3dn4nJIwvidf04g2zFj/K7gc2B8=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=TEcAUuUgMCBWa3SXWQVYw4FM4lXACGEiuWTO0og/8Q5iXcfLz6zWYCnwdT756iYd9
 OPvJ7D1+QWtVECYZCMq1Vlr+uybjGNvnSpvvVUbrr7dEyugWhGvz/V4dS4X62QP8NJ
 SoPmpcXGEy+lcrgA+3g5Qof2w3TTuU17T7g6gDGnOpNy1ZwlMAq7DAK1SaGqwNEoCR
 TlSrISjIz/frgICHvbFTW++0RU62+448GSajktq9TR9L3eMC7PxnsijbpYdjfXcU1L
 hHCF/6DEzRZXd8q0VdEEid+8cgeOfcLU1bJzeC7dlwl8bn1YnyAngTJFU1NS+xaxtO
 1u1JRZcM1X6gQ==
Message-ID: <d4462eaf-83be-f57f-5b56-381f42e555a4@denx.de>
Date: Tue, 13 Aug 2024 06:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 12/18] octeon: Drop OCTEON_I2C_FDT dead code
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-13-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-13-sjg@chromium.org>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> This option is not defined by any board, so drop the code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/mips/mach-octeon/octeon_fdt.c | 7 -------
>   1 file changed, 7 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
