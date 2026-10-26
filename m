Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HxAXrjfv;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ZHGVVNzI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 155B680DAB;
	Mon, 26 Oct 2026 08:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-aG9h1fa2HB; Mon, 26 Oct 2026 08:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E85FD80DC9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002221;
	b=TGLdhiRvfVNx1k5Rwt0IKFoZfhKkCR5LjcC5J6ce9ClD6DOYWHrvCs//8oytuHxFzKMe
	 PCGkWLlRJXZIkEtd3bMQtP3PoVZuf95QETXudGgbBaYFstIyTapbG5jcKRshUf2VojSK2
	 mPdDdOGt9oJ7ZSQzUfaVUIrQo956ccjMrKeXATHByznoFJ5yeCKUZY5ybLwccjgzbnk5k
	 GB410vB9uwI8XUdTiqIJG88SxfYjdra5l9OObfOMJ89jzNboi7BfleQSc2a5v+A6TUtEz
	 2xUpkuIqB1tQogbzj1dHSVQ1amHFFGSgxK6cAB3SuVBDZYpc3J66OWimzgR7eGKryvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ck6ZwT5B29WmYILJB1CZQx9MuK36G8kiZKnCfMcX3yo=;
	b=o5sYrrIU7tZDDW3o+cLagrrbecgxC0dAbNtD5X1MTo0dwDLICi/dCcw4NUvsGmVuDIli
	 BRSkvIWIX0MSof70fjUHVcOegOwsIgfax7kfHsw7TdpimADzxvpmcQm6fcB60Y9qeaxZq
	 oYS9xrg4OKJiuhyafPjRwEJWU207iTCVI5gn3IpUIyv6z9gSx7+xx8UHKaexDGZOZiJVU
	 s9xBdlkOD+Gza1IqiHkKKQ65HxN3msBGIzQzOSAZ4fUkPD2fNwYFRKbdKntclx9Oz4db3
	 vF5yxY+HW09K4/7kb1a1qHTIKfjhjaAgnLdbbe80zhH/DfwnhvYF3QwFR/sSQiGbcOw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ZHGVVNzI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002221;
	bh=Ck6ZwT5B29WmYILJB1CZQx9MuK36G8kiZKnCfMcX3yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxAXrjfv9LYCN26cFgjg79C+E49trMbvYWTekU0AAfNyUYvWEs0BmbE52DvBPgfLF
	 tM7EWKzytK3ZBS0AkAHlTsTc1cfPBfnhKKpxwv7LhnAISR9fj3jZ3dzBG20B07bU5N
	 HYvHXlKpQs6pPhBtm0zbyRRhMKyZY50nzE0ykl9cQVJQkvbXPPLhBgnx0N8fB1A7JB
	 DmbFV+3prZ7HBJcWPKKRcieP36BSolUZnCu2pZJXRrXJpCxOtGdH8/rNQ0KLpgzdJe
	 tnp5mPWZcWFzUn3g0oOa/iu/Ofi0aGGlnkHzC3yXhZ/Tq2A+WNLzLU8XFI7NvccltP
	 oeAEK38TQP00g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E85FD80DC9;
	Mon, 26 Oct 2026 08:10:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C90D5235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEB8A80DC1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCrUJvZWvJDJ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2EF9A80D87
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793002218;
 b=RIVr3gvxqZVgiHXtkz6L9gSL8MN8755ljxYQwI0wWjnAw+We+SbgCM4X7cFG0Pn77+84
 Hecj6R7Z+o7m4ryJ8ixmqS71WTRglLxe/XvObm73J6UatarYkVG/CpKg1qlUUocJczzS8
 K3uBJQ+kcENQp7JF9WiQJIFJe8U4/qacY22fQAByzcsvYvrhWWNqk7A9oyz/DVx3D3Dag
 qZgjYyPOIaCt4AHBsE2iSLtzXn2070lXhHW6wiRjPeq5CP96QM0/x+PQih1SfwKM4tWAD
 6OU8voyxzVKcrnGuAFERcO5mfYnv6HxwTx1mZeA8vF8ygJPyqKaRv7SeqawZ0F6DL3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002218;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Ck6ZwT5B29WmYILJB1CZQx9MuK36G8kiZKnCfMcX3yo=;
 b=cestZK2hVmkosek6kIQkOYm3iNreqsrXykTwoi90rmL6iWRA2zxxaYdBJgi99aDcueoS
 yQG2Qd49gNBjd5HTq0cBmVrVQ24CVWA8Ef+HtSrXgI2DiWhMx3z9S7gWDKz0+M+7icKNV
 1vsLyGy07Lthza0s0ZvbKJogBVjPpdTBpBnUqDXi4QEkH8fNsoNZUq6f+HrkjKTi+8gBb
 Lb2WdJC8kczuQhAYh/KQls8s01LRtsVg8aow7uWEVE9M2f+rF0+o+rKNYB8nTbxNYl8Nj
 I+KWr71GUL8QTuWc57xatov3MhYZ4FZCVHoGQNwJdx1zsuxvBuPxw4MV+sM4/1eCF9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZHGVVNzI; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZHGVVNzI
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EF9A80D87
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:10:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2CFB510B569; Mon, 26 Oct 2026 09:10:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793002211;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Ck6ZwT5B29WmYILJB1CZQx9MuK36G8kiZKnCfMcX3yo=;
 b=ZHGVVNzIrfUiafM/dTUcLqvOW+xTDW5Btcw/6iIi7F4Wb8cTrPsEAhi0k7dGv4K63a4UAV
 gyo/uOR/p5jWqvFHXNztC225wA+XYthb5V+ktiHV9MusmRhI/05TK9t4stst7UGTX+iF79
 R77znySGLAxH+BQmKzuUnIb4zZZABRz2rpQT9lA7ES6sZc1KHeRcRnm676xuNsXPagkCHg
 mZvLn55wzV9EcMyd8qw7No8tD8EWLOpOPDjNnLGX4hjIcPEK7jlxB6lsrAxLlKsOj/QBKq
 DP2R1U9DE5K4Nsynik5aX3CUsAXx5yeim8kigoMp+aQ2ORmvkcOKxGS3SmySqA==
Message-ID: <695a45c7-c3e0-d18c-5dff-15c798d31a06@nabladev.com>
Date: Mon, 26 Oct 2026 09:09:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: resolve "." path components
Content-Language: en-US
To: Altair Bueno Calvente <abueno@airzonecontrol.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <d0dbe72c-7531-9556-2ec0-f147d6c3160f@nabladev.com>
 <DB9PR10MB793033E1A2F0E254B4C53235A4612@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <DB9PR10MB793033E1A2F0E254B4C53235A4612@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Altair,

On 26.10.26 08:26, Altair Bueno Calvente wrote:
> Hi Heiko,
> 
> Thanks for the review. v2 fixes the From:/Signed-off-by: name mismatch and adds your Reviewed-by.
> 
> “Assisted-by: AGENT:MODEL” is the trailer the Linux kernel documents for AI assisted patches (more 
> information here https://docs.kernel.org/process/coding-assistants.html 
> <https://docs.kernel.org/process/coding-assistants.html>), and I believe U-Boot’s checkpatch doesn’t 
> know about it yet. If you’d rather have it changed to anything else please let me know.

May Tom can help me here?

Beside of that, please send the v2 through the list, not as an attachment,
but may wait for a resopnse from Tom, thanks!

bye,
Heiko
> 
> 
> Morphing_Logo_Airzone_v2.gif
> 
> 	
> 
> *Altair*
> 
> *Bueno Calvente*
> 
> *Ingeniero de Desarrollo*
> 
> _abueno@airzonecontrol.com_
> 
> _+34 952 028 575_
> 
> _airzonecontrol.com_ <https://airzonecontrol.com/>
> 
> 
> ♻️Este mensaje y los ficheros adjuntos que puede incluir, son propiedad de Corporación Empresarial 
> Altra y contienen información que no puede ser reproducida total o parcialmente, mostrada a terceras 
> partes ni utilizadas para propósitos distintos a los que han originado su emisión, sin la previa 
> autorización escrita de Corporación Empresarial Altra. Si recibe este mensaje por error, le rogamos 
> lo destruya sin copiarlo ni distribuirlo y lo comunique con el emisor del mismo.
> 
> 
> ----------------------------------------------------------------------------------------------------
> *De:* Heiko Schocher <hs@nabladev.com>
> *Enviado:* lunes, 26 de octubre de 2026 7:16
> *Para:* Altair Bueno Calvente <abueno@airzonecontrol.com>; u-boot@lists.u-boot-project.org 
> <u-boot@lists.u-boot-project.org>
> *Cc:* trini@konsulko.com <trini@konsulko.com>
> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
> Caution: This email is external to Altra. Pay special attention if you don't know the sender. Check 
> that the content is safe.
> 
> 
> Hello Altair,
> 
> On 25.09.26 14:57, Altair Bueno Calvente wrote:
>> ubifs_findfile() resolves each path component with ubifs_finddir(),
>> which only matches directory entries stored on flash. UBIFS stores no
>> "." entries, so any path with a "." component fails to resolve. Such
>> paths are reached through relative symlinks to the current directory,
>> e.g. OSTree's "boot -> ." at the root of a separate /boot volume, which
>> it creates so that its hardcoded /boot/... paths in uEnv.txt resolve:
>> loading /boot/loader/uEnv.txt then fails with "file not found".
>>
>> Treat a "." component as the current directory without a lookup.
>>
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
>> ---
>>   fs/ubifs/ubifs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
> Checkpatch warns with:
> 
>     WARNING: Non-standard signature: Assisted-by:
>     #16:
>     Assisted-by: Claude:claude-opus-5-5
> 
>     ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
>     #16:
>     Assisted-by: Claude:claude-opus-5-5
> 
>     WARNING: From:/Signed-off-by: email name mismatch: 'From: Altair Bueno Calvente
> <abueno@airzonecontrol.com>' != 'Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>'
> 
> May you meant "Co-developed-by" ?
> 
> Please fix the name mismatch, thanks!
> 
>>
>> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
>> index 6121fb0b1..fe6d0cd7a 100644
>> --- a/fs/ubifs/ubifs.c
>> +++ b/fs/ubifs/ubifs.c
>> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>                    while (*next == '/')
>>                          *(next++) = '\0';
>>              }
>> +
>> +           if (!strcmp(name, ".")) {
>> +                 if (!next || *next == '\0') {
>> +                       kfree(buf);
>> +                       return root_inum;
>> +                 }
>> +                 name = next;
>> +                 continue;
>> +           }
>> +
>>              ret = ubifs_finddir(sb, name, root_inum, &inum);
>>              if (ret <= 0) {
>>                    kfree(buf);
>> --
>> 2.43.0
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> 
> bye,
> Heiko
> 
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschäftsführer : Stefano Babic

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
