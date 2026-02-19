Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5474EE9A05A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910E583CEE;
	Thu, 19 Feb 2026 19:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="syoL8X3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF42E83CF2; Thu, 19 Feb 2026 19:38:42 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A8083AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fH2Fk31yXz49PyF;
 Thu, 19 Feb 2026 20:38:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1771526314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkXszijFFzx9ThaxYMVRx+xNVP4oSZFlBVon3Miwl8w=;
 b=syoL8X3O403aIL1gAjqZbhXWMObqDHqrZ0fw6fx5iMiBrS1AF44jI4+GIiJK0Fsc5qUkiQ
 NP7GDvZfl9+ceGdBI7XnQcCMxESgUSAG0SKPDkwc8XhT/igv0QA7ynft/YRoDh8BOn8v19
 JuITJtJCRujt/wtwJ7+Om8j9yMAeSzmAZkbhc4rIOz8nzUt3m8u6OIZQox4eXci1jkTz6H
 GrBz/pXyLcZaKAvNdPRP2NPocrfCjl4Z9eBqqUnDjb9kw4bHzCsUYcg18Y5sqqRYP5X9Jv
 J9SvAfrcIDy2Zi8pHUE2wlDSaZjv/bX+r/0gTYlWxDKfPqej3MHPdfgpFAECLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1771526314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkXszijFFzx9ThaxYMVRx+xNVP4oSZFlBVon3Miwl8w=;
 b=hBGMQBTQ9OySWob9sPIlSSmzCtT49foVEiB+FwqQ3tgWDGBlxFQ/eDmbXen07RjBIVZrwc
 5oNDhUq5TUJFYsq9UHE9fqjXs1nXAdoNAjQ7DABhGmJixz0dy0aIcs+rkSezcyU3tnhqUL
 6er9KEj6ebjwosIAPvW1+Z/1UeDfP0foXYc6LussVRGoZoMWCZqfS0pXgSHC7MAOUzYI2D
 eBTTg+x5HmAkNrukgPN+GjCEeYO9+ZbvBWoRCC4uvlW0+sAE5BRC6db9bYhujG8TImjUo4
 KQmjRWwKDzmvfHn4nIzcIDAYBgvBgYvPalMfhQomU3FN71abU5Rm+ZT8dNBzNQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1771526314;
 b=kjZ5xtuaCvr3Vvr7awvunWilpwsbsAic9JsLyu4UW+8PMDSNWaXW/dKU+7ekBPs1UDv4Gt
 QQn47R6hwAXRTrON6dedzuGmFyqnWwDcBl8KaGUchuuVDV3bUd6MM+vBdCs8Eb4kJ+zQan
 fumoYgOfGqoWHN1AkGHEEk1TJRWvvK5UDRkG+XQTmVrLufmo/DTBXZGZn4tJkvhbrIPnKZ
 FFO5deIjMJG59STXWoh2zf4mUC9cFdITLTHGnr5Lef4VKM32HG5N3LkExinqQZxmiAK6T6
 W6OSD1zHh6VSA+KJ14TfbJ3w9IBUUc6l1DmxJmHUQhUEpyHZYod4sqFIH/TWAw==
Date: Thu, 19 Feb 2026 20:38:33 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH v2 0/9] add software ecdsa support
Message-ID: <aZdYqePplQvF8C5t@kehys.lan>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
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

Thu, Feb 19, 2026 at 02:25:43PM +0100, Philippe Reynes wrote:
>This serie adds the support of ecdsa with software
>using mbedtls. So boards without ecdsa hardware may
>also use signature with ecdsa.
>
>To add the support of ecdsa with mbedtls, I have:
>- enabled ecdsa in mbedtls
>- add a function sw_ecdsa_verify that uses mbedtls
>- add a driver sw_ecdsa that call sw_ecdsa_verify

Tested-by: Marko Mäkelä <marko.makela at iki.fi> # Raspberry Pi 4

on top of 7dca54ef4c44c82bdc6716ac6cdc84c22c66e9ed (Feb 18).

I tested this in the same way as the initial series:
https://lists.denx.de/pipermail/u-boot/2026-February/610196.html

My crude patch for including bignum*.o has been made unnecessary in by 
the BIGNUM_MBEDTLS configuration option in patch 1/9.

Thank you!

	Marko
