Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F36606A333
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r9lq3QZ5;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NoFVr6jy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 253F2403D3;
	Thu,  5 Nov 2026 04:41:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYWqbnAW9gW9; Thu,  5 Nov 2026 04:41:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CF434078C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793853697;
	b=A2BwlNBUOZ1qMhJvtyFPp9q66y5xSrArt4MzefuFQP+3HoHt+dUGeRNwROX57hANfvH3
	 BgjiIigCmFQsCLnSF91NM9d6aqWTeJBg24hrg8V2ll85k8rgwM22G0LwGHyMHfG8ega3s
	 OXoVuUccOTlW2dL70m5d6d2ROlr4/CGlR60uOFcmC9u8uoBj9YeT+UGoRJUC7+5G6qRot
	 W0buPxhj/xkZTPrVujcKRU7BZUmLzdAyOQ9YQkaFUT3M/Nrr0VNPzvZPsnMzUnFy0Z4YS
	 IcHwR1YV/rw6Sdwj3lvH63EdF1WhjZDeH985mCfnKlCJfNb1oHc4kG0NdWE8HSsRsnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hQhI7m9Iif/+1NEZWZC2YDn1i7q9vkoVcvPxWiH/lIA=;
	b=lftoUI31PR3BWhDnGHUk3+K7OTHhyvX1Y1nY1UD15Etcsm/TZB5U6PKmLwtZJAdlc1iY
	 TbgX9Zb/+KpJmhpMTSzA9nTt6jOvZOFj8PJmdGTsglmI6Uy1kDSueqBxY47oohEKelfTJ
	 MmNHiBbBZ65Xz2lwX7Xd3B3cpLwByuGR3o2Ia1GnCD8E2c/s0o8+qMscWAHkUzhyOP9tn
	 hlUN8aaKDoM1+rUuRGdR8Nv5mS+Edb+w6OV470RIPvuevkM3K+UwhrQSlrm21I3kwoUxL
	 KxbHCymx8M5v+f+LrCUsahP4U9cw9X7eEiAxs5epnpG/nMb/4BnxN6/xJ/sBNzWJ9EQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793853697;
	bh=hQhI7m9Iif/+1NEZWZC2YDn1i7q9vkoVcvPxWiH/lIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r9lq3QZ5Nb3f0AszmLcHTDNXZdXFaoeqATqs8Lsmw3KzfENW4jhmiKJHytuUU1wNo
	 SKkpsAkWX4HmsxoO8s0Bnk4wBd3N/fIBHv3CUhBqIFlwKwI14vHOJFY+oZnTrQEfY0
	 qIFATZvMa+k4tXvrH9PLGVV2Zv/y1R+dicmsAIL6YACIYdDlsrKeM1jQN2x6SKsh68
	 e59kKeLZfMCvVXIVBrRUhwtx4waU6cbVX+HL54Z3GfiF1BVRktMGKZXSQfWyV/IUCp
	 KXcgCY8lpnuOPEZyJ+kbMNkUotKrYTj432OxDRAgYf0aCx7Bg7kdlarMMlYnCVfPo7
	 sYjy1oFmE/ImA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF434078C;
	Thu,  5 Nov 2026 04:41:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C142E52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7B58606E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I23aSA_ZLbRU for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 04:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B3C9606DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NoFVr6jy
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B3C9606DE
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:31 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKqQJ1ShbzKnm5;
 Thu, 05 Nov 2026 05:41:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793853688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQhI7m9Iif/+1NEZWZC2YDn1i7q9vkoVcvPxWiH/lIA=;
 b=NoFVr6jyM+FuqsSdCiQilKIYKoKielXZiI/AM29H/qGHWEy8RgrIQykNNfXq9i8h7709U8
 N0G2zw/GZPhJaLfDzxiyWgke28hCZiVupLtsnEOHInc/t61CZCfWk2u7nv18wZVcGZQ9K2
 OeIT1koSjbkF/Kh4nUWpxp+BrFvNr4HaLCsIXWnmsVTfptoxfQ+bQWDMXPBthKwuh4357D
 phjJxtMsSCWKlcb9IIFjoc30JGEK4PaZSXAEjBZiOJeoc+xaWSGL7y2CD6I+Ste5o6NBQX
 cbPZZEJz0lDaOaRit38clYu5HdhoUmsWgQY5P4Vo2l0tA8UT5S03HaLnPEywNA==
Message-ID: <636803e2-ea4f-47c9-9883-6cd070b1c772@mailbox.org>
Date: Thu, 5 Nov 2026 02:46:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
To: Takahiro.Kuwano@infineon.com, u-boot@lists.u-boot-project.org
Cc: kenichi.nagai.ry@renesas.com, trini@konsulko.com, vigneshr@ti.com,
 vjardin@free.fr, yuya.hamamachi.sx@renesas.com
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
 <896390bd13f4439297a31492e1a3dda5@infineon.com>
 <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
 <2d7719916f1a40288f80e0bfb63492ad@infineon.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2d7719916f1a40288f80e0bfb63492ad@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qo5gwrbxwtb3xqbaicodximhieecuxhf
X-MBO-RS-ID: d7e14099ab18e1431a5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 6:40 AM, Takahiro.Kuwano@infineon.com wrote:

Hello Kuwano-san,

>>>> From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>>>>
>>>> Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
>>>> with Post-Quantum Cryptography, SPI, Quad, Octal and DTR . For
>>>> details please see vendor page:
>>>>
>>>> https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t-nw/
>>>>
>>> Please use Link: tag.
>>
>> Does Link tag apply to arbitrary links in the commit message ?
>>
>> I believe Link tag only applies to lore links, hence I did not use it.
>>
> I have been using Link: tag with datasheet link since [3].
> I prefer to use the tag with datasheet link if it is publicly available in
> vendor's site, but I won't push for it.

The datasheet is not available, it is only this product page that I 
could find. Would you still prefer me to use the Link: tag for this page 
and send a V2 ?

[...]

>>> It would be helpful to see how it differs from the existing w77q51nw.
>>   From what I can find in [1] and [2], W77T is faster and wider than W77Q:
>> - W77T is up to Octal-IO/200MHz
>> - W77Q is up to Quad-IO /166MHz
> 
> Just out of curiosity, do you plan to add Octal-IO support in the future?

At this point, there is no plan to do so. If I learn there is a plan, I 
will inform you.

>> The security extras are unsupported by either U-Boot or Linux, and I do
>> not know the details of the security extras of the W77T part, so I can
>> not comment on that.
>>
>> And of course, the ID differs too.
>>
>> Do you have any particular detail in mind that you would like me to find
>> out ?
>>
> Nothing particularly. I understood the interface improvement in W77T.

Understood.

>> Thank you for your help !
>>
> Thank you!
> 
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Thank you !

-- 
Best regards,
Marek Vasut
