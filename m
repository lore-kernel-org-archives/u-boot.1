Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3008C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A15A88360;
	Tue, 13 Aug 2024 06:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723521931;
	bh=yzGfuorFNS9tmCKLDseELordQwehOUR/P9OrGixwGmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zZH1vVYraevElMUjaUWSYCwQSb6sqKu5mrziJb/xiTXg33IWoC6DwYvqWwLvsj06p
	 dtPuoifWzKnkOilkE69XcVGRwTHJhJEZ44dA8p0eQXoPmgfwRhci+yupciVEbSLnh+
	 qQisQHDr2qo4XW3fRkHUIuFCFwLCdUJdZrBQ0Vm/Hs3aDqfJ9t60yAJvj4q8i0eZq0
	 VZmqYBju7zPw5UD3GcjVuryF4NBVvIKe6TJZdVIlv+jfpfRryHi9pILhfw8beW8fXx
	 FUDM6iVbN9u4sEUZHm63595AnDBiPHSoQhC+j7XqxL8KVIEX18jovFi2PLIv2qLUUJ
	 +aCetd/mbbx8A==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1B98787E30;
 Tue, 13 Aug 2024 06:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723521929;
 bh=yzGfuorFNS9tmCKLDseELordQwehOUR/P9OrGixwGmw=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=AtKAuYhSHu8ahNRV5PwwwNfdW6P91ngK6vZNSTrEoO1rSM+dZ/2b5J4/twNIkckPF
 xoxggQu8n+oke9fhjOzIonK8zB3c64vnlfTuO3DW0FwJXNRBZTXm+N3RymeO3JFl7w
 /I3mCEzwmrNxMbGxfEqmYCEGBUZChaYc7Yxkg6XB3brAlv4/VQEdN3VXTZ3TfoLxYH
 93cre8QMdZWQ74gYTv3VHQARs44DLmMxhTrfbVUDt+t0qU80Ypv93jAtot094Kiwo+
 KgaqXVhfA1RoyVe4gn6Evkhvnz/D2km25aBstns0w08JLdHXtuZ4UI9Q5Ic7mHQM/U
 0WNU58QtZIfyA==
Message-ID: <06a32385-329c-811e-0dcb-7d5622152b13@denx.de>
Date: Tue, 13 Aug 2024 06:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 02/18] i2c: Remove IC2_xxx enum
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-3-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-3-sjg@chromium.org>
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
> This is only used by devkit3250 which is being removed. Drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/usb/host/ohci-lpc32xx.c | 4 ----
>   include/i2c.h                   | 6 ------
>   2 files changed, 10 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
