Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95B0C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3BF8283E;
	Thu,  8 May 2025 09:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746689244;
	bh=xeOyREpCWDMsGCetsX1zbqNk1ne9I0vm1E8bITrtKdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lU1pVvLCd29mmoXaB+X837J10op6RfcyiB397T4Dk4GXDKy7aQmMz7Iem5PrR70Vn
	 rKb0NEmYP0fr5gLFacDQ+0FCAlnwAQtMptpP84OiK2qlH3uDO62bDzFKoTfTSLisN8
	 HEFtWlJ2/76yklBIdvnFa+8pG3a6UP36MUSVveY1g7C/nJUX5A0zTaA33+l9ckVk3T
	 qdGT/ThgqeVpDePY/1wSCr+mrWduMQFGB4k/LDGrP5sUA302iC5w4pwfSzSX1Hn0wu
	 OKW/hKmROlsZaWs9efTd8+7+TWyC9MZV+QWJ54GGM0l/A/V4PCu06lmjBVQi6kBhoq
	 OVG/vVc/RgMvw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F47D828A2; Thu,  8 May 2025 09:27:22 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28368059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZtNxf3qs6z9tX8;
 Thu,  8 May 2025 09:27:18 +0200 (CEST)
Message-ID: <0b184798-7f81-4822-8de9-a283036e334a@denx.de>
Date: Thu, 8 May 2025 09:27:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] cyclic: document new guarantees for
 cyclic_(un)register
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250507105821.484442-1-ravi@prevas.dk>
 <20250507105821.484442-4-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250507105821.484442-4-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZtNxf3qs6z9tX8
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

On 07.05.25 12:58, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   doc/develop/cyclic.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
> index 6f1da6f0d9b..a99b17052f5 100644
> --- a/doc/develop/cyclic.rst
> +++ b/doc/develop/cyclic.rst
> @@ -54,3 +54,16 @@ responsible for calling all registered cyclic functions, into the
>   common schedule() function. This guarantees that cyclic_run() is
>   executed very often, which is necessary for the cyclic functions to
>   get scheduled and executed at their configured periods.
> +
> +Idempotence
> +-----------
> +
> +Both the cyclic_register() and cyclic_unregister() functions are safe
> +to call on any struct cyclic_info, regardless of whether that instance
> +is already registered or not.
> +
> +More specifically, calling cyclic_unregister() with a cyclic_info
> +which is not currently registered is a no-op, while calling
> +cyclic_register() with a cyclic_info which is currently registered
> +results in it being automatically unregistered, and then registered
> +with the new callback function and timeout parameters.

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

