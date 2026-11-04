Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A6606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bj3Ojc/n;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USr3urwA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 012E783A79;
	Wed,  4 Nov 2026 18:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EAKyViTy3dcs; Wed,  4 Nov 2026 18:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D099183F93
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793815999;
	b=NWxjNat3pP3qi2XwcgdFgTH84+l87jtTCvUjTvOdGWqb5LPee9SwedEi2uSA9/s74bUu
	 Je8Z2gtEQgTPw7QuCE7Odu6jmKz0M4uSvT/jjeqnBwlNe9qMrlITI3+th5x0GXNHKzECr
	 iZ21u7kRGCFIJp/c+JtnRNNJPp1k1mXSOhCEj5wisgkN8cuSttHE4GziZfK1loS4rp34w
	 y1F0B6NuApjykkx/wDHrrgtIf2kUvHVn8Nr4maAfAQqOfV7moNBAzdyT6tOZjvSWS3Qa4
	 qcaJoCEvv/4pMr4GYuBKJfRDzZZmKRvq/Twri+d1Si4hfzv1hhX9LZk+Ota4PT+9RDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793815999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DPu87QdU8WjkW1JNSB1/891aw214CFB6SbWdQrZNzu4=;
	b=NXrYwwQRRi6XmM+rGvMCbSW8Evg6YHzLNn8J8rH21cJKvKu62xr+jiFPGftRDc4MgMgy
	 FrChu2/KgolZpg5mcehgaLVgys9hZCdvY4KqOESyaO0zLcLuKR/weUB4Yo92bOVBWP4aO
	 gwy5pN+0XWbX6+TRe0088WcPCoSUb+Eo/t1qmWwImHbN6HXq4Dnh/xjPbaYG+76T41KRP
	 Kd4oBxN7pOKP3TUIN2MrDR0p68DumOyx1EJ/AUpfd2v+F4YWvrCG4g2FlvgT3lm+rc0uz
	 rxi3GfaVfLaaffXZC0GnPeJsGOSuvnWslPu9nTDQIv1KISEdWZaGy5pnXMpMM+sxNNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793815999;
	bh=DPu87QdU8WjkW1JNSB1/891aw214CFB6SbWdQrZNzu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bj3Ojc/nuya01dlclp7TgGBg3j9JotTggZKwC46SzIOdpiAldciyQY/kqsvhXg4Cq
	 +7E4Vtze+l27ckTCfL3RE5cjQXJDxF63G0qtoiJqfHM810M2+UMpBsrFlJfpk/yCOv
	 CghO/hPEJ5bm6WPWP7C6ZohVwbUb/GTlUVDnGfCe5ka3UvsEiYdKGMF+lWSk4xwf/B
	 BeQ/8HvAyswGNPfo47KNW1Xy3gngW2yYKF2z011aw/2RKCBexG6OiISD2oq9+dL4uh
	 Nx5JS5fcZa65JglIhG2zYMqQU+P0NF+jkHC17aV9h18RuW0A1JIjZjwg5oYTu4rbhu
	 FZmUyieseRkog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D099183F93;
	Wed,  4 Nov 2026 18:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A334177F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F82B42D9D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKwJmM10Lifo for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 18:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37C7741A00
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=USr3urwA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37C7741A00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 18:12:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70C2C4461A;
 Wed,  4 Nov 2026 18:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B644C1F0093A;
 Wed,  4 Nov 2026 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793815950;
 bh=DPu87QdU8WjkW1JNSB1/891aw214CFB6SbWdQrZNzu4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=USr3urwAyZ2kW5x00gurorWo5VZvIGvDuRo0KNNdpZIZs65heuwWUavm8xnt2hmjb
 AOP2W8iu21j/svDKkGHVPN8mCC9VyrOrtRqR6xXijyv/ilm1fts4SG9Y5FtJt8P0eL
 7bNcUHMAWVWLSryqmCOZAxp9tF/mL8pkIVwAppb/QbXW1C59pmvdoZE181aj7Mg8bl
 TAHSNmmF5fUpCwdOegmekan2WmM7HRNcNS7ORB9Hu23knhnbUqwOJD3Yfzp/IR2G6P
 t2zXN4WcS/2gdZDawAfk1PpNF94RNXXhBbFfGxUCalYq5Q389rXFKeIbpYVozogoCO
 qIS33D80PqPQA==
Message-ID: <9069b9a2-3d9a-43d1-806c-5afab2845aba@kernel.org>
Date: Wed, 4 Nov 2026 19:12:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To: Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
 <3959b688-e0a0-41fc-9cc1-72806d71d30d@kernel.org>
 <62114896-739B-49E9-B993-4B1C9B50F593@mainlining.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <62114896-739B-49E9-B993-4B1C9B50F593@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 04/11/2026 à 18:56, Bradley Morgan a écrit :
> On 4 November 2026 17:51:53 GMT, "Christophe Leroy (CS GROUP)"
> <chleroy@kernel.org> wrote:
>>
>>
>> Le 04/11/2026 à 17:23, Bradley Morgan a écrit :
>>> On Tue, 03 Nov 2026 15:03:07 +0100, Christophe Leroy (CS GROUP) wrote:
>>>> Some people have reported christophe.leroy@csgroup.eu being stale
>>>> from time to time.
>>>>
>>>> Change to use my Linux Kernel address chleroy@kernel.org
>>>>
>>>>
>>>
>>> Applied to main at u-boot-ppc, Thanks!
>>>
>>> [1/1] MAINTAINERS: Update my email address
>>>        
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcustodians%2Fu-boot-ppc%2F-%2Fcommit%2Fbe7b24b50d13&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd3b934f1c6c346ff932c08df3a9cf4b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639294117940333766%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DXUjlYIZI0nzWg6GhjOWN8lbGIRNYVoQqQDo8TjMUYU%3D&reserved=0
>>>
>>> NOTE: This patch did not apply directly, I fixed the conflict:
>>>
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org>
>> <boris.brezillon@bootlin.com>
>>>    Boris Brezillon <bbrezillon@kernel.org>
>> <boris.brezillon@free-electrons.com>
>>>    Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
>>>    Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
>>> +Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> <christophe.leroy@csgroup.eu>
>>> +Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> <christophe.leroy@c-s.fr>
>>>    Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>>>    Christopher Obbard <chris.obbard@oss.qualcomm.com>
>> <chris.obbard@collabora.com>
>>>    Christopher Obbard <chris.obbard@oss.qualcomm.com>
>> <christopher.obbard@linaro.org>
>>
>> Ah ... One more Christopher Obbard compared to main is the conflict ?
> 
> I git pulled main, the patch submitted was when PPC was orphaned (
> according to code), so
> earlier than I think a week ago.

Hum .... ah right, my patch was on origin/master not main, sorry for that.

> 
>>
>> By the way, isn't Christophe after Christian and before Christopher ?
> 
> 
> Hmm, That's where my fix put it.. would it matter majorly? It's correct to
> a point.

Probably not. Can be fixed as a followup if it does.

Christophe

> 
>>
>> Christophe
>>
> 
> --- Thanks!
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FEE579805-42F2-4C58-B752-F28779EEB717%40grrlz.net%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd3b934f1c6c346ff932c08df3a9cf4b0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639294117940351803%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Q6QPgtZBPHmzCwbz6pE4ys4ayzGvJ0%2BfphtxQhDPjIo%3D&reserved=0

