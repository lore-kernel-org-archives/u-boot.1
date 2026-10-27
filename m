Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8C606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BnpiPnrD;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=e+IGlP27
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 555F1605D5;
	Tue, 27 Oct 2026 12:56:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HoH8fNUNUUlS; Tue, 27 Oct 2026 12:56:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EA4A605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793105763;
	b=R+U7/S31lo9DP/QkRqMmItY98MCW59sxuvp3GYHvdZ5qUw4prgKdwcsbmqpKRu++//ni
	 cNNP5yEUPJSAtLk4IUP5QAny0ho6EkSlrvkDq2FiVsF/UH2hhztZ95uHHRoDfMsFH2lEH
	 zSwfaKVBv7tIKpFnjAisrAMeMpiEMnCFU/odc/qtKUBLrfyCEFkzXweR/e5rR2VMbVgSu
	 qoq6FwXH4WXmAeylxmdSvehfYiPKq5A3v3UgNQtTRpz6wxk/SxHdg3aDR9wQz/FFiJbCv
	 Fe164odYq1WHJB52FJoaWPrsiYhL3Z7LDM4FTPQRu4mahPsYbhYRH8pBpe3uRMd4cuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793105763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gODfNEni5598wK6dUqq+31XHcLUWAKF0CKbtT7IIwQs=;
	b=cEoYypPUKJ0abfBkpiPzFC3ViWuWjOajQwu3FiCABwvLZ0mGQAoBsXXzA5tVLl3HH4ze
	 ftjUhbI3tTJVdIymVtfbpOx3W6/rPMq8Aif5pE/qbn1cBViuozLa2DnCUHXTS/o68N7Oz
	 2q+sXXb1zM9iqbF/bgbYq//mnMR7VvvRYCPyH6/kJvSyFxLt74OCewdnW9CwCauim03FL
	 n0Zh/6HvdNKzj/uhR87Ho/YPl9ZAB5sbY0MNyBokLLO3qpQo5MJVjexbiY1LufeakQE0Z
	 96S4qUIACXvpNcdnwiJetcmImqRZnriY2SdVJnpdjqA+72kEVUKyneI1u32ninr7sRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793105763;
	bh=gODfNEni5598wK6dUqq+31XHcLUWAKF0CKbtT7IIwQs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BnpiPnrDIQzqgO2hv3W6z7TOoaspC3IhINEM3X/w/TKLKKR6v7jej2xBuB1JaFeE/
	 hhM7UGMu3ijxD02tfPu4TWS5e4gohB31ZlqYw3CEXjZq1G4R2j37KVZq31kViC75m7
	 nqm6nxKNSlUnWIkr+nT5WmzLmUKLaac1SizhrzbvBP4J5PhBQ0JyFdroi85KkzL+ha
	 yz8GZR6NXVXlo+Rz2e45EQFRJD90Sk2kbqABIUYPGdJODqxwUPGUE+mVHQP61NsuxM
	 O1OfWjNJvTmc8IFKrQHjWGjJAcpU88QlK9XmTL2bd7RP42sQDegj7ycjgT4rx7HdUi
	 EX7973eU5P3/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EA4A605EF;
	Tue, 27 Oct 2026 12:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C11B13D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEE0E40708
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uYqzX_vYB0y for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4533840707
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105759;
 b=eTV0QzA6mvnn2MtIk9tA3S5o/77RxYGvTmFntzfvHBrGAjTcteLuN3cy4JdnJcy0/pNS
 Va6LSTdbLRKxOAR1ZCDFmwUPAHgEB4Fo0tG+D6Nku2mzF2bHiTK8u9QYhFz0mP0G66qih
 Qwau9mINjKkWiwAWE5ZbA7p1TlI+V/CW8/UeQKBDRdkM724pZwvoF1ZK6qGaeuwAuXBAw
 MFns8kLzytBsLENT6XCwgW4uf9QQLU3w4BN4J1H8gjyZZMeCZk9U91YoX9cOfOHtjtnkc
 4QbUwuc1e55dCrFK5yJE0W7QGr9pDxVX3MRv0ggYZ2rKebsDcnT73F5r1q8r5rA3niA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105759;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:From:To:Cc:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=gODfNEni5598wK6dUqq+31XHcLUWAKF0CKbtT7IIwQs=;
 b=BG6LQxvsWbHXwEjBs5j1SCk4S7CWwTorZ018ytptcr/m1P9HXRhxNwE2pdXMgM/DllFV
 biwek1Z/I3aFcsVBqima3ewMfKYR98//efKu4HZYQIYdcbj7oOfiNMKBDR3oMrIdsMC3w
 hfW813FlwuEP1P4CbOty18dgGe44z6q6aOQD/AYQZgb2A3/HOI/zLPb5h6OOnhkl3zaoy
 fuF5yQ5WnmTbFkG+IUlItCeQGWhkzjx9MXgib/zu2f1FQG9YFbqRFN+nFSt6h+LIXb0d0
 rU3OKR28x92mUVlRc2Dm4zQOlmbYlSVk9+v6rTWEj/g6o9zsOqirj2raePK1N2fAE6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=e+IGlP27; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=e+IGlP27
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4533840707
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:55:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82047106B60; Tue, 27 Oct 2026 13:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793105752;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gODfNEni5598wK6dUqq+31XHcLUWAKF0CKbtT7IIwQs=;
 b=e+IGlP27rhtyCbTvGwME/dX5ZrJ3O7NZQZOZqUsJ6nugosGM1KmECE91v7+FmiYtL1HBX3
 F2dGtXN04MAnj+hO35oF7GY0vF1d0liestCbn1HNaaQ+YCyeXsqqzpRo7X7igTb+4fWrgM
 3OpT117SnBjgX5jsWCfRHXo9+MSc42FjrSOvSCrO6Bdyc578T/nOOKn4KTn5+Tkl2ENgM5
 w1YnXvoULWwwzpblAs0zbqdw7r3mDYk8XIlaI5NyoFH5FnBxRY0Evb3Ry3wU50hchVigfr
 q4fcE15oLFF/jgfLUeW4/yp0eQJRK3IeEp6nqIov+LSF0XRsFw9v0I9OtayokQ==
Message-ID: <663ada5f-c670-fc12-cd40-29c2a556fb33@nabladev.com>
Date: Tue, 27 Oct 2026 13:55:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] fs: ubifs: resolve "." path components
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Altair Bueno Calvente <abueno@airzonecontrol.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <d0dbe72c-7531-9556-2ec0-f147d6c3160f@nabladev.com>
 <DB9PR10MB793033E1A2F0E254B4C53235A4612@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <695a45c7-c3e0-d18c-5dff-15c798d31a06@nabladev.com>
 <20261026145409.GC624796@bill-the-cat>
 <DB9PR10MB7930A525CD2941E7F4C2E609A4602@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <26062bf8-55f8-835d-e7df-883c763088a8@nabladev.com>
 <DB9PR10MB79304225D3AB3BEE17A55B23A4602@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
 <c4450102-176e-bea1-d56a-f945846a2b06@nabladev.com>
In-Reply-To: <c4450102-176e-bea1-d56a-f945846a2b06@nabladev.com>
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

On 27.10.26 09:15, Heiko Schocher wrote:
> Hello Altair,
> 
> On 27.10.26 08:52, Altair Bueno Calvente wrote:
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
>> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
>> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Changes in v4:
>> - Remove Reviewed-by from Tom, added by mistake
>> - Fix the version tag in the subject
> 
> Thanks, but I just see, that all your new version are added to the first
> thread in patchwork... please for the future, send new version of patches
> not with reply function of your outlook, instead send a new message.
> 
> Please read:
> 
> https://docs.u-boot-project.org/en/latest/CONTRIBUTE.html#contributions
> 
> And I recommend to use a tool, like b4 or patman...
> 
> Nevertheless, I picked up your patch and startet CI run.

pushed to u-boot-ubi, thanks!

bye,
Heiko
> 
> bye,
> Heiko
>>
>> Changes in v3:
>> - Drop the Assisted-by trailer (Tom)
>> - Collect Reviewed-by from Tom
>>
>> Changes in v2:
>> - Send with a From: name that matches Signed-off-by (Heiko)
>> - Collect Reviewed-by from Heiko
>> - No code changes
>>
>>   fs/ubifs/ubifs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
>> index 6121fb0b1..fe6d0cd7a 100644
>> --- a/fs/ubifs/ubifs.c
>> +++ b/fs/ubifs/ubifs.c
>> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>                    while (*next == '/')
>>                          *(next++) = '\0';
>>              }
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
>>              ret = ubifs_finddir(sb, name, root_inum, &inum);
>>              if (ret <= 0) {
>>                    kfree(buf);
>> -- 
>> 2.43.0
>>
>>
>>
>> Morphing_Logo_Airzone_v2.gif
>>
>>
>>
>> *Altair*
>>
>> *Bueno Calvente*
>>
>> *Ingeniero de Desarrollo*
>>
>> _abueno@airzonecontrol.com_
>>
>> _+34 952 028 575_
>>
>> _airzonecontrol.com_ <https://airzonecontrol.com/>
>>
>>
>> ♻️Este mensaje y los ficheros adjuntos que puede incluir, son propiedad de Corporación Empresarial 
>> Altra y contienen información que no puede ser reproducida total o parcialmente, mostrada a 
>> terceras partes ni utilizadas para propósitos distintos a los que han originado su emisión, sin la 
>> previa autorización escrita de Corporación Empresarial Altra. Si recibe este mensaje por error, le 
>> rogamos lo destruya sin copiarlo ni distribuirlo y lo comunique con el emisor del mismo.
>>
>>
>> ----------------------------------------------------------------------------------------------------
>> *De:* Heiko Schocher <hs@nabladev.com>
>> *Enviado:* martes, 27 de octubre de 2026 8:30
>> *Para:* Altair Bueno Calvente <abueno@airzonecontrol.com>; Tom Rini <trini@konsulko.com>
>> *Cc:* u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>
>> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
>> Caution: This email is external to Altra. Pay special attention if you don't know the sender. 
>> Check that the content is safe.
>>
>>
>> Hello Altair,
>>
>> Your [Patch] tag should be now [Patch v3] ...
>>
>> On 27.10.26 08:18, Altair Bueno Calvente wrote:
>>> ubifs_findfile() resolves each path component with ubifs_finddir(),
>>> which only matches directory entries stored on flash. UBIFS stores no
>>> "." entries, so any path with a "." component fails to resolve. Such
>>> paths are reached through relative symlinks to the current directory,
>>> e.g. OSTree's "boot -> ." at the root of a separate /boot volume, which
>>> it creates so that its hardcoded /boot/... paths in uEnv.txt resolve:
>>> loading /boot/loader/uEnv.txt then fails with "file not found".
>>>
>>> Treat a "." component as the current directory without a lookup.
>>>
>>> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
>>> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
>> I could not find Toms Reviewed-by tag in an email, did I miss?
>>
>> bye,
>> Heiko
>>> ---
>>>
>>> Changes in v3:
>>> - Drop the Assisted-by trailer (Tom)
>>> - Collect Reviewed-by from Tom
>>>
>>> Changes in v2:
>>> - Send with a From: name that matches Signed-off-by (Heiko)
>>> - Collect Reviewed-by from Heiko
>>> - No code changes
>>>
>>>    fs/ubifs/ubifs.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
>>> index 6121fb0b1..fe6d0cd7a 100644
>>> --- a/fs/ubifs/ubifs.c
>>> +++ b/fs/ubifs/ubifs.c
>>> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>>>                     while (*next == '/')
>>>                           *(next++) = '\0';
>>>               }
>>> +
>>> +           if (!strcmp(name, ".")) {
>>> +                 if (!next || *next == '\0') {
>>> +                       kfree(buf);
>>> +                       return root_inum;
>>> +                 }
>>> +                 name = next;
>>> +                 continue;
>>> +           }
>>> +
>>>               ret = ubifs_finddir(sb, name, root_inum, &inum);
>>>               if (ret <= 0) {
>>>                     kfree(buf);
>>> -- 
>>> 2.43.0
>>>
>>>
>>>
>>> Morphing_Logo_Airzone_v2.gif
>>>
>>>
>>>
>>> *Altair*
>>>
>>> *Bueno Calvente*
>>>
>>> *Ingeniero de Desarrollo*
>>>
>>> _abueno@airzonecontrol.com_
>>>
>>> _+34 952 028 575_
>>>
>>> _airzonecontrol.com_ <https://airzonecontrol.com/ <https://airzonecontrol.com/>>
>>>
>>>
>>> ♻️Este mensaje y los ficheros adjuntos que puede incluir, son propiedad de Corporación Empresarial
>>> Altra y contienen información que no puede ser reproducida total o parcialmente, mostrada a terceras
>>> partes ni utilizadas para propósitos distintos a los que han originado su emisión, sin la previa
>>> autorización escrita de Corporación Empresarial Altra. Si recibe este mensaje por error, le rogamos
>>> lo destruya sin copiarlo ni distribuirlo y lo comunique con el emisor del mismo.
>>>
>>>
>>> ----------------------------------------------------------------------------------------------------
>>> *De:* Tom Rini <trini@konsulko.com>
>>> *Enviado:* lunes, 26 de octubre de 2026 15:54
>>> *Para:* Heiko Schocher <hs@nabladev.com>
>>> *Cc:* Altair Bueno Calvente <abueno@airzonecontrol.com>; u-boot@lists.u-boot-project.org
>>> <u-boot@lists.u-boot-project.org>
>>> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
>>> Caution: This email is external to Altra. Pay special attention if you don't know the sender. Check
>>> that the content is safe.
>>>
>>
>> -- 
>> Nabla Software Engineering
>> HRB 40522 Augsburg
>> Phone: +49 821 45592596
>> E-Mail: office@nabladev.com
>> Geschäftsführer : Stefano Babic
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
