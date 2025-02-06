Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D38C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 20:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E0380C96;
	Thu,  6 Feb 2025 21:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738875154;
	bh=TDxy2AYc1jdsRN3pbsDitAehiX3DlJv4qEAjV8zG954=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fh17myrpPnqTH3jhseoMomZh04piun0EfRgyRtTMK1HJeRRxRep77fwm7Au6/VJnD
	 pZpvoy9UOjZB8UokVJ+583IQe0npLVHSWMVfQFbdNydn4l65K7Y02jwkD2VxUhmTT3
	 6RQ8mwo/VSph4uONOvVjNG9RPdWNvjRD+Zdl6HhKDGRiSTUxdcvsZ6FNsuoW7UxD6a
	 HuaVozswihZLF8+8ybWwe7IZmuLe7tBLGMHRfRrItj0LjbdNbPmrrZEh7JfiDD87nC
	 3e0tXyxrMjA/LEFz9RKjxC8M3so9O7N9HN4PTrTfWLPgJSiL1nWzMbdbWUMe8vkLlx
	 k8H3UQOZY9XZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85ECD80E94; Thu,  6 Feb 2025 21:52:33 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4495780C72
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 21:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="c4fdRRXe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3804010202684; Thu,  6 Feb 2025 21:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738875150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDxy2AYc1jdsRN3pbsDitAehiX3DlJv4qEAjV8zG954=;
 b=c4fdRRXelTwr6CSPnp3OcbYGogN/EYjpr8AjXDLZpGjzf14oNq3nSHjAiKdUokysAIK/8e
 qwmcD/8z9doYdGeP2dz0IEJ5EOqciQJOClkWTcVDtLGvfZjtmckU1184IgOQYtOf1zRTi8
 GPXaJ5ZO16OyIS2tO2bGONbwauwyKVEsl5VGReIcKOsxvDw3mX6UNNM/T2MUVwtaAZyPeB
 vQM0g+fYt721kBD2wcJRhbharWlorJWhKoOz0iL8lFQgTGQBKjj36snNuPOwMn1igVb+M9
 2Ei/nA8t8akybz6fZaFDONaX6oiBX6F+auA4jN4KVGG5kZ8iMHI+SIuz5qwSSw==
Message-ID: <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
Date: Thu, 6 Feb 2025 21:40:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/6/25 1:42 PM, Simon Glass wrote:

Hi,

>>> FAILED (errors=1)
>>>
>>> So where is the SRK_1_2_3_4_table.bin file?
>> See the tool documentation:
>>
>> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
>>
>> 3.1.2 Running the hab4_pki_tree script Example
>> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
>>
>> The hab4_pki_tree.sh script should generate all those files.
> 
> But with binman we want to avoid vendor scripts, etc.

I believe the script internally runs openssl to generate that file.

> Could someone take a look at updating tools/binman/btool/cst.py or
> similar to build the tool from source? There are examples of others
> that do this, e.g. bootgen.py
Is this relevant to finalizing this patch ?
