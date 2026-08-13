Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA5EC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A27B360B0D;
	Thu, 13 Aug 2026 13:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6tjmfojPv6a; Thu, 13 Aug 2026 13:18:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACE3760B05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786627105;
	bh=hXqgctjwkGOZKfx9bck8fWivYfU7+Qn0z544DYFP8y4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=vkZU7f3f/haN+KnEvNQWuejqi6SIklQAroYthfDrFj9jfaF78DraUbSw+Z2XAs85A
	 KakqCR54S3FycW4rxgyIUEskXsQvl7lvavkwMHJVNy+hyJRiHA5hR+A4OY/s8Xc5TQ
	 ZxjsbmHGrIWYEgMYr9i4dlMuMS8Q3A2+iGMTf6d8Thttxwlhw0jzc95VYzebFfK5Zk
	 To7aBvrbe7rO8F2AO/stxZptn0dvEfp/hMsveJsV7v3cq1R75zQtjlBFAuslNCipIM
	 yDfQ8/TuBuxi5/uNg7Zuq7jvcP/C3lWM45a2UOR6QieH+TDP9dzEvgbNSvQxWpJmHH
	 DGBhbufaz/yAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ACE3760B05;
	Thu, 13 Aug 2026 13:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E0AF3A0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23E1240983
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gL7rmSIWmfT for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:18:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 357994096F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 357994096F
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 357994096F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:18:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 02AAD4E411FA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:18:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B5675602B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:18:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF59711C4DF23
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:18:14 +0200 (CEST)
Message-ID: <458309d9-4655-4cfd-9deb-dc0ce01d7b68@bootlin.com>
Date: Thu, 13 Aug 2026 15:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pylibfdt: Replace removed SWIG Python 2 compatibility
 macros
To: u-boot@lists.u-boot-project.org
References: <20260811133433.18852-1-jaipaul.cheernam@est.tech>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260811133433.18852-1-jaipaul.cheernam@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: fc92476046d305a7304aa5e3a89d331c86706a8860f55d2651411b4a3660045dd5dd8de1e8efbc95203731585d49b94bd0322fce187301f2d963c8915ca328ab
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1786627095; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hXqgctjwkGOZKfx9bck8fWivYfU7+Qn0z544DYFP8y4=;
 b=YrVgQn3jRPOAo0cbB+OA/+cHFwsyrQ6fyYCtZ5RpwQ2oRdmH5Zw+v+KVt79Ysq8g6lZ6SO
 APb0JC79HI50SxoMwH7zGll7JZ0KW6QQg1s0vqnx3pIcrInopNVy0GT27OMMYplrwV/9N6
 9pBK4hjFZ42wZd6jthlsVzJ/WtpTLln4dSmGQj+6vz8HSCHuN29I4bVJ3duVDasrSSuAfn
 7ddEp2O24iZS3kWulqH7I/PX4hWNfCXS/isZikobP4idqg9/umfRhavCTk3vG85gdzHq95
 05XDZhgXknAE8x4rKc4t2ncBZOZSbIpSr4O8PvJE9JHbEX2GH2uA91YsvLOwwg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=YrVgQn3j
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/11/26 15:34, Jaipaul Cheernam wrote:
> SWIG 4.5.0 removed Python 2 compatibility macros (PyInt_*, PyString_*)
> from its runtime header pyhead.swg (see commit 79f7a2b7cb7d). Replace
> them with their Python 3 C API equivalents:
> 
> - PyString_FromString -> PyUnicode_FromString
> - PyString_AsString -> PyBytes_AsString
> - PyInt_AsLong -> PyLong_AsLong
> 
> The replacements are safe since the macros were already aliased to
> these exact functions in SWIG's Python 3 code path.
> 
> This is a backport of dtc commit 5008d1d6a356 ("pylibfdt: Replace
> removed SWIG Python 2 compatibility macros").
> 
> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
> ---
>   scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
Tested-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>

> diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
> index e4659489..326a15c7 100644
> --- a/scripts/dtc/pylibfdt/libfdt.i_shipped
> +++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
> @@ -1033,7 +1033,7 @@ typedef uint32_t fdt32_t;
>   	PyObject *buff;
>   
>   	if ($1) {
> -		resultobj = PyString_FromString(
> +		resultobj = PyUnicode_FromString(
>   			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
>   		buff = PyByteArray_FromStringAndSize(
>   			(const char *)($1 + 1), fdt32_to_cpu($1->len));
> @@ -1064,13 +1064,13 @@ typedef uint32_t fdt32_t;
>           }
>           $1 = PyBytes_AsString($input);
>       %#else
> -        $1 = PyString_AsString($input);   /* char *str */
> +        $1 = PyBytes_AsString($input);   /* char *str */
>       %#endif
>   }
>   
>   /* typemaps used for fdt_next_node() */
>   %typemap(in, numinputs=1) int *depth (int depth) {
> -   depth = (int) PyInt_AsLong($input);
> +   depth = (int) PyLong_AsLong($input);
>      $1 = &depth;
>   }
>   

-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

