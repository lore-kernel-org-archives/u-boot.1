Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A41606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zBqo2Mo4;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rA4E5suh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A7C28100F;
	Tue, 20 Oct 2026 09:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yjs0KrDmarX; Tue, 20 Oct 2026 09:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAEE58109A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488183;
	b=ae9C36WFDc0rxVjndA6Km1G3owjwqBFFcdiihL9fXFISkzaIpM1ikgsvayhOOBSiRdQ3
	 HI+6jToDJGghlSLlW+Dbk/K0HxZzp9u4vEzSsXzL0NM+b+BdCtyLmK/pS3uygpMF9VoW1
	 vQIRyRX5v2RDFtOhNaGIp4n+tBsYd4DoXp6fMM5IVR7stbJ6ykGTrXSUnLE/XXa8XxfNa
	 qlX2UjW/Vu3PwaPXhtDlAK4OXtuRw+HTRigmHRrXzK8AKC/3t01b7NZ17CbqsO5WX9ytE
	 kVc9vjfE5pkqT8gdYCPMO1b0nDNJn3Ic4hCuoFEySraemIRi4REjqN+Ukya3D0XIFKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BU0cw3qaKNUmCaNmnlDeC493DVsjClomaABg5Hstk8E=;
	b=iLeC/hIPjLa1qFdrk5g6EsVtJIDVqkdRbTmqgoNq8vQYvcynY9RSJf43KS6WWzYI3eVx
	 zTPQJ/HpNyNygKX2C6RQG0VVYRp03FwIZ3o42i4FGKW7RzDd+jnH/ddxDn18s/i2jfsaS
	 7Qr4ian4soXVpK7s3OVPnkG9ELqtnPtIT5cxPi6rdhqesNKsEVOR3dqlkJGdULjbkakkG
	 1POq3YhHgL9R9nKtDiUNAezuM/mxnTCvjv3UNlmdgcWvGEnFPT4SB41J7w1Xznceg9s+E
	 0+DcFvQA9VTF8PQ0OBWkndye72auZv2dSVA9l6dVApi8QSuirDO+6vmHe9N/Q9DuQ3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488183;
	bh=BU0cw3qaKNUmCaNmnlDeC493DVsjClomaABg5Hstk8E=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zBqo2Mo4bgeI2ow16mzPpg7JD3oLqUHjUSRtbMSoT56QLU1BJ8asOwC6lTpwLgNC6
	 YXD7Pb2pzjdGz9oYzLE7EvUQdkV8Do2gkgcqRj1NvQde7l0V0d38Tu/D3xEy77O1Kb
	 cYjUiPUJFbRG9tv5/D01qLRFDXCVrpgQAJl20c08dIhw0IHkgrUfRh4DxCIqIBVjnQ
	 t7hMT+nAmWYjLjGciDSV4KjiB0wcejJEzyw0+iY9fli/CSx/S18uyh5kpSfYeSrum7
	 42hxbXXAv4mwWwVunPPOpQZroM6KyeTwaAVt20Rf8nM7J4hWd4ko6TZOt3+VOJCOtI
	 RG0y6guwysXyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAEE58109A;
	Tue, 20 Oct 2026 09:23:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8565769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D808C6083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNH3pUk8euEq for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E9C960830
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488181;
 b=KTQEGVLU3IbLJlmVIKU6E0FYeLy/sExN83SzxOFElAZHNY/XCiDQ9vH8VLIjnqOoCNro
 5yBh0Q15Exaz8ai+DonzFzRhl9ncVyTQ+MunGzZH5eLJudT8vBhP1T1nYfjOJChL+aAbP
 WOazrSTp4aJzHiUb2t5YCipBN0kXlwi1yMz8SRHiTOAGKkEHixSq9jSiOeSY3MGxT2IQU
 6bd78OVKCvk/1ShYrdrlOprb48QRJG+Jv9ZdTFfp+LquXYuONV5YLUZHbvvLmbboA40ft
 BhKZ4MLKIkIAjZmx32v3IBpzPl5opby/3X6o+E2gFBbFewSJadXcMzvwM87XGtV4R+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488181;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=BU0cw3qaKNUmCaNmnlDeC493DVsjClomaABg5Hstk8E=;
 b=SXbNsKEnBpE27y2WbTndFcf/trTMdVA4eAoCMrCjMvEruvjE0gfwj+vaRp4DcpqNG2rq
 u++tNypO5zBSErOWmhYQCfTFymgfTfd9C+hKjfU0jeIh3OGsiv1jT/X7WHvmX/OlIC8UM
 qg6CQix7mJ8ZEU3HDf5BZ7Thz4chuisvjWBId4Zk4Oec68bXRoqFEsEE5005JvG6DpCWF
 rCwC9jD1u2WkSH8XQ2+JZpxXcv2tdXlpw7x+xldUmBTNhdT9i3vnmdFWYvsHOOUgmJSQ1
 YnH2oHy/kR4y46Ax0/X7qrq4Psdqz0uWjrLBZ/N4hHIOyptWJU+R4HLmZlJBtxwya1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=rA4E5suh; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=rA4E5suh
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E9C960830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792488173; x=1793092973; i=fiona.klute@gmx.de;
 bh=BU0cw3qaKNUmCaNmnlDeC493DVsjClomaABg5Hstk8E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rA4E5suhiyKNzePedulU4sdFJGRtW+5HiMN07EURJwOskqGmUkYE6daPJ29aNUOu
 WV+vvI90nsJJOSYhccc0aP7OnwnesFtsXRVxlv06WsCFfupLe3YB32kqHSvyw+7S6
 2YDtjg+rzOJeTB2HRfBoPxU6vl55KhNCDuxA6OTAyih2laPdIklshb5cjTSsllGYk
 SIVMQkO0juHX4rm8/bd2oqVZIROghiqe6+4pdm6J1HTRT8as6WulFM7dnTfSAgKkY
 fWHNMl6RTmnpKCzJrC1BkAbJ/CZiVHCKfSpE36PVP/CyKOn9trv5GjooCbba0kLX9
 vnkQBUO8QkSPk5ef/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1wyo1H1wAE-00Xnfp; Tue, 20
 Oct 2026 11:22:53 +0200
Message-ID: <f27b3197-5655-45a2-9b2b-5101673516fd@gmx.de>
Date: Tue, 20 Oct 2026 11:22:52 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security: "Permit write access only to listed variables"
 restricts only environment loading
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
References: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
 <542b5753-9c28-4565-b03f-f7b300351821@nabladev.com>
 <0fea15c6-edd3-4f55-a347-d799aa86ad4d@gmx.de>
 <a3ece217-3d96-409b-ad60-623a5cab07f2@nabladev.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <a3ece217-3d96-409b-ad60-623a5cab07f2@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ge50+KJUTufc+sr4x/cCNG+ROR7X/KLrYcaQKG7Z1h7H75DmHPv
 4lZCVIVs6SWMMfA2+gcmrEiKk2onCu6Rx4NK1hhFQ16Dsysx7+IQKZr+K6EK/Qm9w3nDAjQ
 cWwFV35GzJbqdf2i2Yq2FJQPqZ8pyc02xpC5azFifPD7/kJGj71eWW9a/nMCnVIAKj3Gh6v
 qRXHS0YBR/rIM1LAlRzAw==
UI-OutboundReport: notjunk:1;M01:P0:3sFy5GBg8Kg=;5MuTNl2LYpAlW5SXn6GUXg2WlCU
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek!

Am 19.10.26 um 17:57 schrieb Marek Vasut:
> On 10/19/26 3:37 PM, Fiona Klute wrote:
>=20
> Hello Fiona,
>=20
>>>> The kconfig description of CONFIG_ENV_WRITEABLE_LIST says:
>>>>
>>>>> If defined, only environment variables which explicitly set the 'w'
>>>>> writeable flag can be written and modified at runtime. No variables
>>>>> can be otherwise created, written or imported into the environment.
>>>>
>>>> This does not match actual behavior, "env set" and "env import" can=
=20
>>>> modify variables as usual.
>>>
>>> Right, and if the attacker has access to these commands, that means=20
>>> the attacker has shell access to U-Boot, at which point they can do=20
>>> pretty much anything with the system. If the attacker has shell=20
>>> access to U- Boot, it is game over. For CONFIG_ENV_WRITEABLE_LIST to=
=20
>>> be usable, the U-Boot shell access must be blocked (bootdelay set to=
=20
>>> -2).
>>>
>>>> The only thing that is blocked is loading variables without the=20
>>>> "writable" flag from stored environment on boot (and "env load"=20
>>>> based on what I see in the code, but I didn't test it).
>>>>
>>>> As far as I can see, the issue has existed since the option was=20
>>>> added in commit d045cbacf2529266bb312add023e12c0d400bf67 ("env: Add=
=20
>>>> support for explicit write access list"), where the commit message=20
>>>> explicitly states
>>>> "env import" and "env set" would be blocked.
>>>>
>>>> I consider this a security issue because preventing modifications=20
>>>> that would circumvent security measures seems to be the whole point=
=20
>>>> of CONFIG_ENV_WRITEABLE_LIST, and it only does a small part of what=
=20
>>>> it's documented as doing. For my current setup restricting what can=
=20
>>>> be changed in stored environment is enough, so I don't have a strong=
=20
>>>> opinion on whether description or code need to be fixed.
>>> Please see above, does the security concern persist if U-Boot shell=20
>>> access is not available ?
>>
>> As I wrote, for my setup the loading restriction is sufficient,=20
>> precisely because I'd block shell access in production.
>>
>> But that doesn't change that the fact that the description promises=20
>> security restrictions that don't exist, and if someone relies on those=
=20
>> without checking they'll likely get into trouble. That why I consider=
=20
>> this a security issue.
>>
>> And for someone who does check (like I did) it's rather concerning if=
=20
>> a write access the documentation says will be blocked actually works,=
=20
>> and it wastes time figuring out what's actually going on, even if the=
=20
>> end result is "what I really need works, the documentation is wrong".
>>
>> It's fair to say there's no point in having environment restrictions=20
>> if someone has shell access, but having documentation describing such=
=20
>> restrictions suggests otherwise (U-Boot does a lot of things, I don't=
=20
>> know everything other people might get up to!). Again, I think fixing=
=20
>> the documentation would be an appropriate way to handle this, but=20
>> that's not my call.
> Would you be willing to send a patch which updates/improves the=20
> documentation ?
>=20
> Thank you for your help!

I've just sent a patch. :-)

