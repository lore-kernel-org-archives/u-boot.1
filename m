Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA2606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JxdAX8VB;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Oyf//l6b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 405798087B;
	Tue, 27 Oct 2026 08:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HN2zd73UI0-i; Tue, 27 Oct 2026 08:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F5F08098C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793088967;
	b=S4rFXwVZ4ORZUj2BlnyOiSxEU62LHfoNB38splwRHhxp6czqRNIQvwJ3/yQ1s6IYFsE1
	 yBhczpNI8EEgfdl6iyck7vqUptMMXkYUH5XrCCixSwafTa+1HWgRwfu0MKTc1nKVBeAdg
	 MsdFuAUdjHzutiuUXpMFy1gr7v23p04MiFEr9Q8lDOFG9P7mn8gDH/V8gz7dFwkxliygg
	 wiXfUymX9TGJ/DADsRxUTJT0rqXx4/TvOYg1wBzIIFrUk1y2n+hsBAN/ddTo9CJgUE1a+
	 ynF4yB9VvA2XWzSWBfCObufMLKNH0a6EPy+CNHfr3qIaz/9LTbNcBIgIDrNl/A/hF1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793088967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NogsLIRL6Sq0gEugxibhebGLMjf4kGSWoqQyI1oME8w=;
	b=PuSxND4JIMCo17fFI/J4TpO4Yx4BoYmg2L8INU45TTMzp8ehUKkDyayd635593TTIcdz
	 rJ3t0AKAt+CbJBeQQxJdpyYTHZWmguSfjG/xe/fvtIN8Y4Ain5ODFnMUNgZxRfcfQ2hw7
	 /4CReeOzCZUK8/2S4gha89F43Z34aB6qjSOviw9N5LAWstH75wzL4CyCxPEVD6WZKEFs7
	 /KHhQJs6vWj5PHhS5BrNmLg0aZEtxue8jEXzsbUp2N7yXKOHB4TXheZcExD0/YPdd5IvN
	 nHPxAU8jtHYqrf2I3EeS32DYjOeiGpNsTerqzJAPAz+ubBIItdYIK+0juqO9Wjr7Jug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="Oyf//l6b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793088967;
	bh=NogsLIRL6Sq0gEugxibhebGLMjf4kGSWoqQyI1oME8w=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JxdAX8VBcLjT/2B/8x9N/jqQ8qR3dhRv6fGJsuPc9Gv1NOuoQ74kgl/3KbvfcFsPN
	 GNDzUd8Z9AsfUbBqBRDSF9awzTFI8zymeBV+DT8XOErx7slweK1QlHwL4DXVDYmdci
	 gDn7oyMo4XqE2l62WnHELgmrD0Ar7dANYh8mYXv6Gp5pm7xIedIkwdHEL18oK64cgv
	 L1MfUsQSF2+2rxAgZ25pv901mSVoFtahhbmT7/MN4vYaZdMzF5i5GmOGjMplSOC43s
	 0CT1klL6bunc0ng6EXvZnBqjnIkZ0eERGJGg4ECXnc2BoBvrNy/mhF8Dj+F4i080C1
	 sQZttm2yJ6iAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F5F08098C;
	Tue, 27 Oct 2026 08:16:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B324D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CE898098C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAdtePg5pP1o for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:16:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE4EB8087B
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793088964;
 b=Mn86+Nc0mXJRx7bBpyZkEaKI9wOPg0Aeqahn7/qWyFJ/SvOl+sOonZa2cul+WVVASWg0
 blE40RHTZO1Di/Vjr6XQbARr5y0yw9v4RbqYnlmngJpdpzMop1982UD1z0KvPEfkQddyE
 jvwwLU7PxtDrQJvZWG40rnBdPq4//8aAppBmryeo6qszqARbxomo5aBbmu0vfvId9BORU
 L2YFYDSSExHwEoQjqSXoZSa6ZAKkACu1lV68q9syGTl8ToIHba8nfr4yyBP8k+gZQb6Wi
 6DbBcR3kZCYS7Z9qOlWTyRWX0/i1DgTu9/1VUXHUCCpR8WWFmLRP7c0N9ac8q5+RGXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793088964;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=NogsLIRL6Sq0gEugxibhebGLMjf4kGSWoqQyI1oME8w=;
 b=imf/E7miiEGrSLrxaCShH4elxPHwU+UjHT4ADqsMYhVkAhrrYnXhfDfRPQuiLOE3Y2ZP
 C0RKbBWasuy9UMRb/YUquw4v+AjwhVTTSeSsZpcyLp9dtUvs9jVHs0cKIQz87eNf8tHvV
 ZEYoVV7eQ8A2hisd5Y9VKXhQGKSa/jCctS4brhN0JtebRM80iQeAkBAgHT5ifTljiZRBZ
 ImzAiuB6Z/70WFHG1joaCKRgO5JNU6wpyT+FZX6FF/5z8HS5wOe2F7D1X10ce96Po3Y8x
 cKhWT2J4zY/1ETb0HrpvbImiZn9iiJedDQ37SZU9uWpT9VKktLFMn4bWFt6Jw8Mzzlw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="Oyf//l6b"; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Oyf//l6b
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE4EB8087B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:16:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4BFC10B7D9; Tue, 27 Oct 2026 09:15:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793088956;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NogsLIRL6Sq0gEugxibhebGLMjf4kGSWoqQyI1oME8w=;
 b=Oyf//l6bOE2Qv6sFn12oRLyA07KECyC3etTw12qAjx1kEvAHqU2KfWijdnbSpDBUEAg5/z
 MMEZKAB7bCqOmahejASReMmPw06PS7QJ8bHGDW1KMwuf088mCtEKm0vdbhzRNd+CJIU8eK
 SJ5CF+qwwjr+dnJpsd6h0I2huAu3YVuKSf/ILMoxQfh0m+xQtLeFFr4LZyEhZ38NHopuwc
 6LBP2mqXwV9uNwAetNQeyo9M1QfzMbrJuId2C8VUJ72uLH1in/oPmaQauN8zQCb6eaQ3/w
 HMH6Bgpser2iw1IkA07h8Qb9U3LUiGrzYMt14ExhMq1gZ/TOEiQovPeGWDgDZg==
Message-ID: <c4450102-176e-bea1-d56a-f945846a2b06@nabladev.com>
Date: Tue, 27 Oct 2026 09:15:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
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
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v4] fs: ubifs: resolve "." path components
In-Reply-To: <DB9PR10MB79304225D3AB3BEE17A55B23A4602@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
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
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Altair,

On 27.10.26 08:52, Altair Bueno Calvente wrote:
> ubifs_findfile() resolves each path component with ubifs_finddir(),
> which only matches directory entries stored on flash. UBIFS stores no
> "." entries, so any path with a "." component fails to resolve. Such
> paths are reached through relative symlinks to the current directory,
> e.g. OSTree's "boot -> ." at the root of a separate /boot volume, which
> it creates so that its hardcoded /boot/... paths in uEnv.txt resolve:
> loading /boot/loader/uEnv.txt then fails with "file not found".
> 
> Treat a "." component as the current directory without a lookup.
> 
> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v4:
> - Remove Reviewed-by from Tom, added by mistake
> - Fix the version tag in the subject

Thanks, but I just see, that all your new version are added to the first
thread in patchwork... please for the future, send new version of patches
not with reply function of your outlook, instead send a new message.

Please read:

https://docs.u-boot-project.org/en/latest/CONTRIBUTE.html#contributions

And I recommend to use a tool, like b4 or patman...

Nevertheless, I picked up your patch and startet CI run.

bye,
Heiko
> 
> Changes in v3:
> - Drop the Assisted-by trailer (Tom)
> - Collect Reviewed-by from Tom
> 
> Changes in v2:
> - Send with a From: name that matches Signed-off-by (Heiko)
> - Collect Reviewed-by from Heiko
> - No code changes
> 
>   fs/ubifs/ubifs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 6121fb0b1..fe6d0cd7a 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>                    while (*next == '/')
>                          *(next++) = '\0';
>              }
> +
> +           if (!strcmp(name, ".")) {
> +                 if (!next || *next == '\0') {
> +                       kfree(buf);
> +                       return root_inum;
> +                 }
> +                 name = next;
> +                 continue;
> +           }
> +
>              ret = ubifs_finddir(sb, name, root_inum, &inum);
>              if (ret <= 0) {
>                    kfree(buf);
> -- 
> 2.43.0
> 
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
> *Enviado:* martes, 27 de octubre de 2026 8:30
> *Para:* Altair Bueno Calvente <abueno@airzonecontrol.com>; Tom Rini <trini@konsulko.com>
> *Cc:* u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>
> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
> Caution: This email is external to Altra. Pay special attention if you don't know the sender. Check 
> that the content is safe.
> 
> 
> Hello Altair,
> 
> Your [Patch] tag should be now [Patch v3] ...
> 
> On 27.10.26 08:18, Altair Bueno Calvente wrote:
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
>> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> I could not find Toms Reviewed-by tag in an email, did I miss?
> 
> bye,
> Heiko
>> ---
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
>>   fs/ubifs/ubifs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
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
>> _airzonecontrol.com_ <https://airzonecontrol.com/ <https://airzonecontrol.com/>>
>>
>>
>> ♻️Este mensaje y los ficheros adjuntos que puede incluir, son propiedad de Corporación Empresarial
>> Altra y contienen información que no puede ser reproducida total o parcialmente, mostrada a terceras
>> partes ni utilizadas para propósitos distintos a los que han originado su emisión, sin la previa
>> autorización escrita de Corporación Empresarial Altra. Si recibe este mensaje por error, le rogamos
>> lo destruya sin copiarlo ni distribuirlo y lo comunique con el emisor del mismo.
>>
>>
>> ----------------------------------------------------------------------------------------------------
>> *De:* Tom Rini <trini@konsulko.com>
>> *Enviado:* lunes, 26 de octubre de 2026 15:54
>> *Para:* Heiko Schocher <hs@nabladev.com>
>> *Cc:* Altair Bueno Calvente <abueno@airzonecontrol.com>; u-boot@lists.u-boot-project.org
>> <u-boot@lists.u-boot-project.org>
>> *Asunto:* Re: [PATCH] fs: ubifs: resolve "." path components
>> Caution: This email is external to Altra. Pay special attention if you don't know the sender. Check
>> that the content is safe.
>>
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
