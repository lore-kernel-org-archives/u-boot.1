Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460E606EE8E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pMfihGJH;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Uly7Y9P6;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=sy1JbKa1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F30924052D;
	Wed,  4 Nov 2026 17:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wlFJ4kQJB1S; Wed,  4 Nov 2026 17:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F82640520
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793814981;
	b=bUxL0VUHVND45PvVOL28Knl6iDaeLc8uDewyxX5hcku5qphPEhQckPzoFs3QyhUizD5Q
	 FqE2JyvI0gLKSA9MOI0kzUQ3xXCqm4ChSs5pNSoMrJhffwgb6FBLPkGo6T3pCQrzZEfLo
	 iQvUSOMS7VbKhBN+FqjcuWjEj3vrwLYzLMAqLurVorY43muxzmoVkM+YJS4DBY6HgZC9b
	 7Rjsc5ZdLkAkamslT4dT5oVgH/8edit4RcKgWXANr4TKyYoVNPVRTYV9NCAc+KfsuMfqx
	 e/ppaK2l25S3zHjrbtADqLspZY2lsq+xJtIeMUaQb/TRrBsMIT8REKk4KVhMqzBn5Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793814981;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t0i3xwTKSEJ7+mF2pe6v2vNUJ5PqPaVv3XShvTTR7uY=;
	b=SrxoiqwrATF7J06pE/EpKjdgXkFBrXdUYBE/+Pt8HONgFql9qG06hBWMntFXy3tDWPQj
	 eklln3I0+HMjIjF7+a3vwvWO4xANU3CATSBc1ZNzbJnlgTmX4wxwlsBJbnxxbYo+ZaaZ+
	 kQepWtSY9ePb/mRyKmjyiLtZj+Z0tnUimnkDS7US/SkVilcsdpEl8kSiKs+uW0PoheV3K
	 fHq1whGyYrLky3gU/nmKu0OqNQMa2CF4x7WdQ1d9d3BMm8QfPpKbuGSB6wz5C3KKKQLzd
	 J6Rj5KE/UjWkmJqX7Sh18AfXFsx9hTNrySK5CClSAZk9HdEosQ09fSb/40egp6Y43Lg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Uly7Y9P6;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=sy1JbKa1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793814981;
	bh=t0i3xwTKSEJ7+mF2pe6v2vNUJ5PqPaVv3XShvTTR7uY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pMfihGJHYqUHXc+WKkNlnYzgRIwhRk63LXH0o09QtAuHqYGcFYvpGjo+pluUE+c0T
	 7XrovhJePM0oFVN6wBEDUYKXVQKH3KyW1mWIVVMdwoxvIQ9Fy+lXXsAAMMfQczQKlm
	 z0SIcykDJ85TqdpRmF/rOxtAiUiMrCnOt493WSBmOARhUNg2kqQ2FfAqKfAfVl7zlN
	 xKBoNkisH+/n6E6RZDY8LPUYNBS9qPgGM0gjNzYDir2hBzWL3mkGWqbHR46tDmxlX7
	 dBklKmuGKPL2mgm3CEq8I4OeBXPyi3fwPOKLCm3PAG1X4n1FMDr3gh+szH5CPE/PHn
	 pgQH2NE+1sleA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F82640520;
	Wed,  4 Nov 2026 17:56:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30535177B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21C2B4051F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcNEPhsmj_m7 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 17:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A890E40520
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=Uly7Y9P6; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=sy1JbKa1
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A890E40520
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793814975; bh=t0i3xwTKSEJ7+mF2pe6v2vN
 UJ5PqPaVv3XShvTTR7uY=; b=Uly7Y9P64lEFTsA9wfcVcEeZZ83Lc3yifcLyshusGDylIcQ6vD
 lA1sPuo9kBSOVuYnXo5plMhe7MxstIDuHcWZD5OODoVSwbtLYeD9F8btpHCDM5pDepDRW6ET4Kw
 ypngUiwqDnG6SswibF7vyhUJQ+lnaYiDcR4GK67faDntME4ofTU6S4VAZlugVpn0xP3fXXSqJK7
 yFbxcH0J+y8f30Qqn+l+t5KiaNNF835XXqJkdkUnqDQD5yCBxhB0g7HLAiKuhXvfplYHIteyALA
 5xhDuwjIOH/Q2Bx0ddPjHOdrcTWTQbQJ5qI5LG7FJO+vWf59XkNaJ85fDLe1Hee632Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793814975; bh=t0i3xwTKSEJ7+mF2pe6v2vN
 UJ5PqPaVv3XShvTTR7uY=; b=sy1JbKa1nNuU4wFfVEZ0FWop22pwMCCxX19PS06Bkc37XI4wRi
 tYYgxI+o95thcNa7c1MHW+wjUsa/FrQxP5Cw==;
Date: Wed, 04 Nov 2026 17:56:13 +0000
From: Bradley Morgan <brads@mainlining.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <3959b688-e0a0-41fc-9cc1-72806d71d30d@kernel.org>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
 <3959b688-e0a0-41fc-9cc1-72806d71d30d@kernel.org>
Message-ID: <62114896-739B-49E9-B993-4B1C9B50F593@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 17:51:53 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>
>
>Le 04/11/2026 à 17:23, Bradley Morgan a écrit :
>> On Tue, 03 Nov 2026 15:03:07 +0100, Christophe Leroy (CS GROUP) wrote:
>>> Some people have reported christophe.leroy@csgroup.eu being stale
>>> from time to time.
>>> 
>>> Change to use my Linux Kernel address chleroy@kernel.org
>>> 
>>> 
>> 
>> Applied to main at u-boot-ppc, Thanks!
>> 
>> [1/1] MAINTAINERS: Update my email address
>>       
>https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcustodians%2Fu-boot-ppc%2F-%2Fcommit%2Fbe7b24b50d13&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C1314009a4c2545fde06d08df3a90031e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639294062364712352%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DIN1SgCk%2FSUJjnB9hxQoWG6T9gH4lhApnwWyk1KzJTA%3D&reserved=0
>> 
>> NOTE: This patch did not apply directly, I fixed the conflict:
>> 
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org>
><boris.brezillon@bootlin.com>
>>   Boris Brezillon <bbrezillon@kernel.org>
><boris.brezillon@free-electrons.com>
>>   Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
>>   Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
>> +Christophe Leroy (CS GROUP) <chleroy@kernel.org>
><christophe.leroy@csgroup.eu>
>> +Christophe Leroy (CS GROUP) <chleroy@kernel.org>
><christophe.leroy@c-s.fr>
>>   Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>>   Christopher Obbard <chris.obbard@oss.qualcomm.com>
><chris.obbard@collabora.com>
>>   Christopher Obbard <chris.obbard@oss.qualcomm.com>
><christopher.obbard@linaro.org>
>
>Ah ... One more Christopher Obbard compared to main is the conflict ?

I git pulled main, the patch submitted was when PPC was orphaned (
according to code), so
earlier than I think a week ago.

>
>By the way, isn't Christophe after Christian and before Christopher ?


Hmm, That's where my fix put it.. would it matter majorly? It's correct to
a point.

>
>Christophe
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
