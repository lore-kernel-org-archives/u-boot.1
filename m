Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A09606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IpNGDRNf;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XkhJsDJF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC99605EC;
	Mon,  9 Nov 2026 04:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUd1xS4WGFjF; Mon,  9 Nov 2026 04:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A50CF6066E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794199175;
	b=fOg0d7pvERcQWHoGad40RCEbTCrOqGTTgL7Wm610tOS1xaivE9ldHtSiu1jnLtYvuINS
	 Z+V1h6jdzDx+ydorK0xfADFOsZvmXMzRhLShjT2CU1VX1ILhtY4i6D+K1+h0tU6KNFllv
	 Bpz2qtIQWd/ZGDeCTN8kG9WO6jlCJmdbHU+cbJBmF1PeuGsKcg5W4/QG0aOgAQ5r4Li71
	 GSHyXURxEmm3YTXqaAIVv5/X2+83tOCfWNjrqWF+XQ6ADOV5muzzJTS5/j9nLY7Jdk3K+
	 9Unb0VtmLCMT1pqLqAfBp/3kNvWPQn6i2HtItaRHcrCZ8KP/PgZDlI3nEqcwz/s14yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794199175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U6QS/xWwqS0spsfjz95DzHd8liZc7rBa/zqi8LGIepY=;
	b=nm2+7FNFDzXgBrhE94P87AjVLoTZBoH5QtSCIsQBmS0bk+6uNJ3N5PNifXwi50H0teNj
	 15q9nIvH4P+um+y3oHJQ8pCmfUlJs0dwC+WBeApuafFKD5YkvYdy9VaFwidgbAxhR4BDv
	 sMcorpREi/WcUPz5jo2ZOJhJ1sUl52ZIoJiHLI49JCHybRCCauuqt24T9+LL/ByaBMC47
	 i2hemmSg1Q2cUh/4XUFxyD5iAFwqY3AF+ilUSXPGgM9CKwYiojgWzP8kExW1tS1f7DCv/
	 3OB0NCS+zDNLKb+JIrqfBoiOAlRdVTSbkywk+gZbxl/ENsD2x04oGIzcrNcD/c2I1rQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XkhJsDJF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794199175;
	bh=U6QS/xWwqS0spsfjz95DzHd8liZc7rBa/zqi8LGIepY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IpNGDRNfKmREJ03QxEL9CYp154h+1z+HPUD7S5oO3FygRLo8k3N7/LLRI6mv7DYTB
	 s3Dg6RzsRzCJ622O5DcTHQoQtapGyhuPfxRqIF3572dvTXSxalDi/iMC+qk6ro3irj
	 jEOfkXGEqjZbtfwJvhxmU1l4hRQJcvSmbji9S6Td4WPzRYWjEO+4dnSbq31QFts2Ii
	 40BMqN4GNnaBRuv3Lo4hX2x5HhflP3z9nf8vuaBT1emZmk4SZlap6Yg3KMG3iFJZdO
	 X6vu6fewieIyIMckZ9EfZrEUZ0ax9V2X1o1xO9jLqIKlgn+US37bX/EaVSE7/gIb4X
	 GPgvwfCr1Gbxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A50CF6066E;
	Mon,  9 Nov 2026 04:39:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE7F6361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E02FA605EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7qjzLwhLoPo for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 04:39:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEDD86066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=XkhJsDJF
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEDD86066E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 04:39:31 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jNHB85h3qzKnP9;
 Mon, 09 Nov 2026 05:39:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794199168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6QS/xWwqS0spsfjz95DzHd8liZc7rBa/zqi8LGIepY=;
 b=XkhJsDJFp9XbXKGWVVMJK/Y4PdXF/drBjAqFpfNrbsi0J5IjjxpTdF0yZmLiaVqwL2itcp
 1g87QS/sOJJGWbFjhbiAeervjpKpg/lVuyOfxTW9t7LtLeOreiyz244ISKh3ZoQE4ixHwa
 PEYKY2yvZXvx3HPehhrsUJy302EPMFcRfUCHUP7AhNs2nH1Az/JZQegMPoG4gEY0G5Cd5J
 ie/XJ2crz1RMMPS4MCpWs47p9AwyDNWeptpEPhjexVabagP33oq1y+nYb3ph7JNaS3Hel6
 Ko9bmGXtakLEMzdOMI/4XpPr3m2UTNcsVSyNOgstzJxzvZA1bHFN8UU9eVyuZw==
Message-ID: <9cc1b249-bab3-4196-83ce-bfe449e18e7a@mailbox.org>
Date: Sun, 8 Nov 2026 23:53:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Denis Mukhin
 <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
 <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
 <avDgloDmuQcYP7ec@L30177.local>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <avDgloDmuQcYP7ec@L30177.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oycak73xha3szacxzndkozdja9ei13ny
X-MBO-RS-ID: 03a65f1b07b2293bb51
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 9:50 PM, Vincent Jardin wrote:

Hi,

>>>> Upstream your hardware support and you won't need external DTs.
>>>
>>> Even upstream, how does it solve the Yocto's and Buildroot's related
>>> issues ? Both did try to workaround despite they are all upstream.
>> Could you apply a patch which contains the custom DT instead ?
>> (using SRC_URI:append = " file://0001-your-dt.patch" or similar)
> 
> the patch has to be redone, again and again. That is what Buildroot went
> through: see [1] or [3]
> 
> For Yocto see [4][5][6]
> 
> Both do hand copy ! config/git management is not convenient neither.
> 
>>
>> What is the use case of custom DT injection like this ?
> 
> For example,
> 
>   - Bring-up. The board needs U-Boot to boot before its device tree is
>     anywhere near upstream, and the .dts changes several times a day.
>     Pointing the build at the directory beats a patch per iteration !

Why not compile U-Boot by hand outside of any build system during board 
bring up ? That is even more efficient .

>   - Linux sync. A DT that is upstream in Linux but not yet in U-Boot.
>     dts/upstream follows a kernel release, so a board whose .dts landed
>     in the kernel waits for the next sync.

You can still place such a DT in arch/*/dts and cherry-pick patches from 
Linux until the next round of dts/upstream sync.

>   - Board variants. A carrier or a memory variant of a supported board,
>     like the VisionFive 2 8GiB report [7], needs its own DTB but is not
>     something U-Boot wants a defconfig for. The variant .dts lives with
>     the product and builds against the SoC .dtsi of the U-Boot release.

Can the DRAM size be auto-detected by U-Boot based on e.g. some resistor 
straps ? If so, U-Boot also patches its own memory layout into the DT 
passed to Linux, so boards with DRAM size options can be handled by one 
DT. See dram_init_banksize().

> How to handle those cases + Buildroot and Yocto without such proposal
> for uboot ?
Please see above.
