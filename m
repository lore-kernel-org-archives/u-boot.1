Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC78606A329
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P1eq0i0V;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=dBBUftnB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1990E81201;
	Fri, 23 Oct 2026 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHjU9KTRrH75; Fri, 23 Oct 2026 11:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D53C811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792756669;
	b=emZS7111XC14wSE37s3psJG298fhCjnlyKetAzwmnjiZZJGJzFojOi+FPj6LM6zSeRah
	 Jt4KlynVpIAw/eGBfZmYHFf5lRh+7FgJ6IFkMU0Oi8SbDM31QR4JTsSoJzjRQfvHfeSii
	 +UroWQc9PDHm++4GNjy8tZ0X721zZDRQ012wBChHkw3A0SpmkdhyYmCJLkIWdoknZ9D3I
	 viOI71c9DdvylqL81VOGwAcxqiP85P2asJXwtL5Tv/JtchCg6HnTfTD8G/B03hgTC5mOd
	 Jtb8AAQjPtgRSn9d8MJo8RZiVE9psjH9tPe4IeOAxUPitqZ9f/2gdSUK9Bnh7YMTe3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792756669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VC92EjoBSMBOPzqhLRIxZOOVIsmayQ0sEWnCXR1Qz2Y=;
	b=i8ZcXuMvmZ/qo1tzRQCIphGHyechSWDXFht08pvNkUD5ubJo5atYf5jt8qwJjpT35P6J
	 Tf+7acG5vTdqA9bNPC5r0oU3IDPKMMYltQKmJhVYPnC/uwtkd2iGAta5rQri0Pte1LD4s
	 gPDTP1XsOiz3ZAUI6RMOLti3gGg5QzaVyxYbfn/Cf/w3TsHkDLIwVMb0XlILmCRa1ofwt
	 KSh/0cJ2brdMPfBmIufQAghrruCIiZ8mXz0SO0N+wJV6EhLLasWgN+Pmj4GH1it/QeFBe
	 uLLJ2J0tk3QE/78mo6WXdzRWiv9AVRkoCAj38GePoyhPq3VVyCDoPpTEgDv4ytaHYKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=dBBUftnB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792756669;
	bh=VC92EjoBSMBOPzqhLRIxZOOVIsmayQ0sEWnCXR1Qz2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1eq0i0VO7GiDFp5odEfecAdL7RtkXQ6Lx503a6+mjf0mfiP0eN2zTgmEKQPayiSq
	 XcmOQLX5r1CyuG1WUYrJg/RT7mQU6G7lnwXfebPZxWE60O1pThxoolnmH7loz7C44X
	 ASeaqQ22xLFU7fH3CrP/24c65iQmrbAHigbJO1HpbEnIoX90ncicTqD5G6u7xg+yaG
	 ZDcxvzbJ78dqC8v4GYSqfJiFnaTAEPSgTIZ/SAJWSV3j+VpbaC5UVQFO/gQkexlgzU
	 QOMH6dOUTklw14Xy8hEPRYMreZae7hEl2e75l3tiRwEuFELvBzS+7RwbvZQJp8x34P
	 cUhGa+02nCUaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D53C811BF;
	Fri, 23 Oct 2026 11:57:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD45B3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF1FE811BF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dz4ESxkZdUvy for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5899D810AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792756666;
 b=sWl9Pt8VIhb/9Hx2rNh3pnbK2odXFJ9CeRVfbjGh/DZ+EKBYkHaGn7Q/QnnF6e5OgkNn
 nLnFcbN+dVXidogcRusan5aH95O0yrzWCK6tbadyN6KGbCYLoBQu/oDO6CN0Mxps2q1tG
 1Zf1HAfEdo0grxYplelliru9yJozdqNTN87EUf+hD5BLRsDvBwKDVBlv6SpW9+XApGC8i
 +wbqm9GTOvXzRIQHkfkV4oo7DwTrv0H7we7qkGORnrMlEwly5EHeZd5U6kKza2o7WgaZt
 SFUAl/cXwQHEOTA8b22PObq1Iz+m7oOd63jlac13gONO6Y89NsBXeNpCe4CgwdMJ3cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792756666;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=VC92EjoBSMBOPzqhLRIxZOOVIsmayQ0sEWnCXR1Qz2Y=;
 b=n/zFli6RlU3LSCu96DRhLYfGi+JScPDeQro/mLc/78zvBL2IMuTwN7psnnjZnmw9GQdE
 JK+07efXKOrbD/pUOfs6HRneAg6ZY+uXIVKdhwAnBIR7s9VsJDhEV/A9woy/k+dmgFu8j
 2k207Hla2YIfc94WOQGYPt7ysjZVqcW9UMcObw9LqT5CjGy+JBlIHQZ7DmRLpybTNNfLx
 Yk18pvmWErWAMLrL3PRlVQcCBeSvtKBzIoD4Deicd3XpYVKjzmB3DD9WYGvfdbYWPz0RL
 Sxy+ZasVTsxlNIllfoAVe9GueJIeSjo3xLoySXRnx9W91mAocPeAHXFcgs4BtRDm0DQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=dBBUftnB; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=dBBUftnB
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5899D810AD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:57:45 +0000 (UTC)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64C9E402AB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792756663;
 bh=VC92EjoBSMBOPzqhLRIxZOOVIsmayQ0sEWnCXR1Qz2Y=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dBBUftnB21ve5Jl+cCeXAg2LrruN/CivRK3YEpUB1nndeWFIfEJvPhE4ruDcR56l4
 hf9oABlRPFD4uRWle8QM2ZngGgWiGjwxDBLmXsMczU4mPzKqNhczMVdsijD+WjU4lQ
 A2Jm+B0jrCH4q2pnxApkCkNMrDbAUxPVeaZeSLJDE/TIp1HVo3WB4a2iRlq+3j91L8
 nL+6Hw6+BpaZM3DJvkjquEaJJYiHKi6kfDAjVDa3oxcz3ce5WxBkFrSGj8QQfR+0me
 8OlYqRszq2l+ZsXR/97t9rGtLmKLyNWte4260ypnCQB5ObbSyHmZWh/N4JQopdBSI8
 2WYNbm0hCUaIIqhWPg6ICHjy4s450d+okr1+3P+skUOwh3BuRN4yJmSPWZBXeFjCog
 XTWbTAv8QuK/WetxYmF59xxgl2hsQLD3Atyikz1/2cXLrOpIn8IAqrnLg9aektLNRh
 bb3Qm4bphnevIm1HJ0Nx9UJQYyVsdK6Cql7vgfQ4moLNfnOMtsPf0gXDS8Td3a9X+a
 J0YBNLqZBVlUGnJMb4JnKbtBRG+ES31o3+6oY/rd+X91w5BSHyko0WQr4NkvjsB3x/
 UEWtNEvq8al2ANMKzg3GbiQFFb7em+b1cWNZLs4JaJQJLt5e2h0bSQ49M8eSkmn3yr
 BkSUteM0la7HnwGlteVvi7Wc=
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-869553205a7so13272507b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792756662; x=1793361462;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VC92EjoBSMBOPzqhLRIxZOOVIsmayQ0sEWnCXR1Qz2Y=;
 b=2L/rJnfp+63N76Nz4FKxZKWegtB5cHXoVvVK9MXb1oD7j+/f4HVcbSam+Z5Xrv7vkU
 lrLfX0zz11qzAq/wiw/gz+Cqw2afkk4UU98i2fR4A8U3xppdzRRzGGiKa85FIukgug/D
 0EFJLmCQ2jQt4Tc8cW5lYJh946A9HPzUXEvlslqNMt8f+13KsT5hKARsWP+qe84hKc3U
 aRP3jNnqFan6LNiQv7xOHBx+5alT6eP4h42dPbwt+7e7SthNvI0LLM/cNRZ/2jErEuWe
 aGoKdGLscTJaiuCmrIWIgh/auQLnerx5ldqKACUUVgocm9738Pvc53TyAcKsDE2gYfdW
 qtow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHxytTM7Qugy+HdM53d3Fhar66QoYlI62ZGQILhnELJUvqSK4SINItKLuyZAw+9ZBkOZb9SQ4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFcHYStNlaFBYXTdYrWexAsqPgB1wj5CFgMUuOG0uD1s7GM0Eg
 SpvlrvMhxpPATvkLLi+9V99bBo9RHvvbGbrdg93R46MKRrCNWBKV1edVNueB7vKbWxH8FVG5Tzf
 VfXCCxy8/DP1rjf21A71/LJQDUhDMcEbpoqxtoBECXGiQUM5ZHIUY5wqsgTyK7jXa3mG9Br2FQ2
 Dt3wxo55wDcNzeSznGyUpY
X-Gm-Gg: AYBFou1CAp7ppSiQR4wgDF13lAWBbxcpys9EyCs7UlPzSdB1/OXS0zCPwYepX5LiiAT
 o9Vkelh2FAPwaj99UJVyOvuRJxOHJn3Uaf9CHsf1qcmal3cugPP+Gr9JzLMroj/tGeH6oqMxzVF
 mYG17GYVr2TDHwpdTsuKw7j9VKU5z1OnmBfFHp7gv6hyXssA5mhqr2cPYM9euRm9nFbdwNk2zXe
 g3M3SP2eVjUDsTVF7RaBKvPVKq4NTUHVR+uxKdWedLL+COxSc5rH59tjC6AudWMOdHKJN8Q3f9Z
 RPiUVAB4MF3z3ImhofoZCX3louZ3Yh7/Sdw8VCaXWhQigApl0o+5iijDzPwMZP9RwRYVs4NTkXN
 pRX0r6FQjxlfLWhlHUpTt6F8y4tMLD2h240LEENLECnRKTR/vk+f32ATct61iJ7CU+YITCeiW0y
 igrn8oQgrU4MvrRGfLEUDwmQ==
X-Received: by 2002:a05:690c:298:b0:8b0:bc6c:9229 with SMTP id
 00721157ae682-8b157de57efmr18146867b3.27.1792756662336; 
 Fri, 23 Oct 2026 04:57:42 -0700 (PDT)
X-Received: by 2002:a05:690c:298:b0:8b0:bc6c:9229 with SMTP id
 00721157ae682-8b157de57efmr18146707b3.27.1792756661818; 
 Fri, 23 Oct 2026 04:57:41 -0700 (PDT)
Received: from [172.21.9.158] (host-209-35-187-178.broadbandcancun.mx.
 [209.35.187.178]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b1560cd2dbsm12197847b3.7.2026.10.23.04.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 04:57:41 -0700 (PDT)
Message-ID: <4ce18a5c-45c4-44a8-815d-e54df884499f@canonical.com>
Date: Fri, 23 Oct 2026 13:57:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.u-boot-project.org
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
 <81cfd720-f3c2-4807-9fd8-867d465b755f@canonical.com>
 <CAC_iWjLPxJ=TV5RtG0yGLSuDyN2GxsVPiJrHE_k6OCKSEoX3Zw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLPxJ=TV5RtG0yGLSuDyN2GxsVPiJrHE_k6OCKSEoX3Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 13:39, Ilias Apalodimas wrote:
> On Fri, 23 Oct 2026 at 14:19, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 10/23/26 09:25, Ilias Apalodimas wrote:
>>> Hi Heinrich
>>>
>>> On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> * Add missing parameter checks required by the UEFI spec.
>>>> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
>>>>     language.
>>>> * Handle querying the string size with *string_size == 0 and string = NULL.
>>>>
>>>> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v3:
>>>>           Update commit message to indicate that parameter checks are added.
>>>>           Correct a misspelled variable.
>>>> v2:
>>>>           string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
>>>> ---
>>>>    lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
>>>>    1 file changed, 24 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
>>>> index 90dff91e5d4..47325f7d8aa 100644
>>>> --- a/lib/efi_loader/efi_hii.c
>>>> +++ b/lib/efi_loader/efi_hii.c
>>>> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
>>>>    {
>>>>           struct efi_hii_packagelist *hii = package_list;
>>>>           struct efi_string_table *stbl;
>>>> +       efi_status_t ret;
>>>>
>>>>           EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
>>>>                     package_list, string_id, string, string_size,
>>>>                     string_font_info);
>>>>
>>>> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
>>>> -               return EFI_EXIT(EFI_NOT_FOUND);
>>>> +       if (!language || !string_size || (*string_size && !string)) {
>>>> +               ret = EFI_INVALID_PARAMETER;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       if (!package_list ||
>>>> +           !efi_hii_packagelist_exists(package_list) ||
>>>> +           !string_id ||
>>>> +           string_id > hii->max_string_id) {
>>>> +               ret = EFI_NOT_FOUND;
>>>> +               goto out;
>>>> +       }
>>>>
>>>> +       ret = EFI_INVALID_LANGUAGE;
>>>>           list_for_each_entry(stbl, &hii->string_tables, link) {
>>>>                   if (language_match((char *)language, stbl->language)) {
>>>>                           efi_string_t str;
>>>>                           size_t len;
>>>>
>>>>                           if (stbl->nstrings < string_id)
>>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>>>> +                               goto out;
>>>>
>>>>                           str = stbl->strings[string_id - 1].string;
>>>>                           if (str) {
>>>>                                   len = u16_strsize(str);
>>>>                                   if (*string_size < len) {
>>>>                                           *string_size = len;
>>>> -
>>>> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
>>>> +                                       ret = EFI_BUFFER_TOO_SMALL;
>>>> +                                       goto out;
>>>>                                   }
>>>> -                               memcpy(string, str, len);
>>>>                                   *string_size = len;
>>>> +                               if (string)
>>>
>>> This is always going to be true since u16_strsize() include the
>>> terminator. It's a nit so I am fine fixing it during the merge
>>>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> string is the pointer variable passed into GetString().
>> The value of string is not changed by our implementation.
>>
>> The UEFI specification allows to call the GetString() service with
>>
>>       String == NULL && StringLength == 0
>>
>> to retrieve the length of the buffer before allocating a buffer for it.
>> We must not call memcpy() if string is NULL.
> 
> I am not sure I follow you here. If string is NULL, aren't we exiting
> really early at the beginning of the function?
> 
> Thanks
> /Ilias
>>

For String == NULL && *StringLength == 0 (I forgot the * above) the term

     (*string_size && !string)

is not true and we don't quit with EFI_INVALID_PARAMETER. Instead we 
reach the loop where we look for a string matching the string ID.

We even have a test for this in
lib/efi_selftest/efi_selftest_hii.c:766ff.

Best regards

Heinrich

>>>
>>>> +                                       memcpy(string, str, len);
>>>> +                               ret = EFI_SUCCESS;
>>>> +                               goto out;
>>>>                           } else {
>>>> -                               return EFI_EXIT(EFI_NOT_FOUND);
>>>> +                               goto out;
>>>>                           }
>>>> -
>>>> -                       return EFI_EXIT(EFI_SUCCESS);
>>>>                   }
>>>>           }
>>>>
>>>> -       return EFI_EXIT(EFI_NOT_FOUND);
>>>> +out:
>>>> +       return EFI_EXIT(ret);
>>>>    }
>>>>
>>>>    static efi_status_t EFIAPI
>>>> --
>>>> 2.53.0
>>>>
>>

