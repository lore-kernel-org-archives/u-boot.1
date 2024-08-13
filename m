Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12619C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C37A88360;
	Tue, 13 Aug 2024 06:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522275;
	bh=Q3d0SrQbdTA4EprFN0bR5NF+BqqEmBzoWKRLEv9gZGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RRxCvD3RWQ0nwg7rokE37Z//HvyKzlFX5/VW6lBSVUV92GHX9q+WqcSU7vvxpssas
	 HXuNFrpHhjcEwPspiAAjlo3bOdCvYOJ1v+LdSrh3wilEhoxvWrupLFOWJea38+nqQz
	 NuXV+NFCnbJ2YgZ5VC4M6Y+3z7K7o5Temq43zMSHloFfkVW+tG8FR8DpsRyzpsIulw
	 8M3bVMmpeiChqoRgMkvyXcWLUDr+ieIRGgSPtjT5GHOEjjNpJjKRzLit+j/vh0aAz0
	 jbvtacFpmx5q80fQ7KPaKbpaSCKJ9FnnAwUkcbk/DYDrZ+GNY9/wEeG7EkfFpJFX6k
	 iwP7dVHbvpy/w==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7E20587E30;
 Tue, 13 Aug 2024 06:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522274;
 bh=Q3d0SrQbdTA4EprFN0bR5NF+BqqEmBzoWKRLEv9gZGg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=qZ9F+7ugjYpZqryJoDoocT4o7rL8IlXbGDnly3UUXqql1JuT5GI3cdgFHXCsFWUwc
 /CQ66hGctKUPRKjKRSy9Dk+bf+9BcqQPZnXj8Fz6K5cSj3Y0wKT6ijEzUtmDePrV8W
 4lvat2+24ZADDSGtcSjciEp87M0LFIEgmSIUvUtUFI9skzZr9otT8njpx+19937c2Q
 L+VOuUR67+cQIKKIvRHqbyFITTOEJUQ0KWcFI0i5S1P8+0g/CRhyWE+qmRoVMU72N0
 k5znNctT6/warojpd3TONaJNCqlWtoW5UaeJnfPEFjXH5A3tbJnVnW2SgWHNpsXDFi
 +5uNkWLJK4B0g==
Message-ID: <4573948f-ff2a-1dbc-b6e1-1507480a63ee@denx.de>
Date: Tue, 13 Aug 2024 06:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 08/18] rtc: Drop CFG_SYS_RTC_BUS_NUM
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-9-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-9-sjg@chromium.org>
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
> This option is very old and the migration deadline was years ago. Drop
> it so that the I2C system can be simplified.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   README                        | 5 -----
>   cmd/date.c                    | 6 ------
>   include/configs/ls1028aqds.h  | 1 -
>   include/configs/ls1028ardb.h  | 2 --
>   include/configs/ls1046afrwy.h | 1 -
>   include/configs/lx2160aqds.h  | 3 ---
>   include/configs/lx2160ardb.h  | 3 ---
>   include/configs/lx2162aqds.h  | 3 ---
>   include/configs/m53menlo.h    | 2 --
>   include/configs/tqma6_wru4.h  | 1 -
>   include/i2c.h                 | 5 -----
>   11 files changed, 32 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
