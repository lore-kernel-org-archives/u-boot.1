Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C2ED0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4DF88D8D;
	Tue, 22 Oct 2024 13:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595445;
	bh=GiRavWVn3RqxzKZxcfV1GuNz/41wNSFXTumkKyiI8mU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dh5XI6hlZKK+em2VzM00ryFirR7HqdnyJyAhy2cydIb2Z3ErF4CFIgKtCvlE+sXnF
	 WrNzCnioqobQhquy0OkxlcY2O+fLkG8nKp+SJvt9oRsx2dJz7oKSa5HCWcF8uW2BLl
	 WNJSc5kXElR7m66RGrAbRn/MZNhN6Ybm4oeuxYSmOlsrDN0CMbQzb/AjTLzUM/67p/
	 dggp33nsqcFNYZtO/7AZBf0UJbeWPiYPH+Yi3BOd7ARptoAFsQYCWyNCjWwYUZ78Bh
	 jH7YHbIbJ6yWrrTDtz96XcUpMss+hWNuw4aMEmolB19+9CBZjTxPLhiPDjpLPuQ77y
	 iA595arXozXLg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2785488D91; Tue, 22 Oct 2024 13:10:44 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BBD88D5A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqGl4fQFz9sRJ;
 Tue, 22 Oct 2024 13:10:39 +0200 (CEST)
Message-ID: <e22fc564-f968-471e-959a-f115ca8babb9@denx.de>
Date: Tue, 22 Oct 2024 13:10:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/13] doc: cyclic: remove reference to WATCHDOG_RESET
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-2-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-2-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqGl4fQFz9sRJ
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> WATCHDOG_RESET is no more. Replace the reference by schedule().
> 
> While here, rearrange the sentence a bit so that "cyclic_run()"
> becomes the object and "the main function responsible for calling all
> registered cyclic functions" a parenthetical rather than the other way
> around, which at least to me makes it more readable.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   doc/develop/cyclic.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
> index 893c269099a..6f1da6f0d9b 100644
> --- a/doc/develop/cyclic.rst
> +++ b/doc/develop/cyclic.rst
> @@ -49,8 +49,8 @@ executed all 10ms.
>   How is this cyclic functionality integrated /  executed?
>   --------------------------------------------------------
>   
> -The cyclic infrastructure integrates the main function responsible for
> -calling all registered cyclic functions cyclic_run() into the common
> -WATCHDOG_RESET macro. This guarantees that cyclic_run() is executed
> -very often, which is necessary for the cyclic functions to get scheduled
> -and executed at their configured periods.
> +The cyclic infrastructure integrates cyclic_run(), the main function
> +responsible for calling all registered cyclic functions, into the
> +common schedule() function. This guarantees that cyclic_run() is
> +executed very often, which is necessary for the cyclic functions to
> +get scheduled and executed at their configured periods.

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
