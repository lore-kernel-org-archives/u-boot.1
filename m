Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AA606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rFK6mMFi;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GjYYVcqZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94A1880E0B;
	Tue,  3 Nov 2026 05:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVXbPK7-ajKK; Tue,  3 Nov 2026 05:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AF6780DE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793682636;
	b=MCkPxpXwu/vO6rBaOK31JRzZga0yqVP2eM4LfLhqjgnXOBWQt0+JoWBKQvoSj+jECtsd
	 gsgqg3yLI7IT7qTkXMJY2X+DqMkcsnHo5nB4s88gNNQvXsxKHeG3NuCarKKNsB35mwmCh
	 vLQsZ7h6ZIXpRXnYbI8fzuHnMD7Pzy4xKTGP2oWFUzUHy+jmtI6XNM8hm9/dq9DrUpKDA
	 o8LVp8hk+zKkX2IzyoBoyvUnKT9YL4iA1QLoAzyyFcOWiceyo5wi+RYftHRFit9O1dvER
	 MFTqaPpkbj/F5/zLJmN46usCJz/0/zLeHGZnWPIU3dFgDBrgMr4owMYDS9p00h37Ecw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793682636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fj/I62UeFmibFrzEzQ+7LeF6z4mt8jtRC122A8Arem4=;
	b=ROn8GYw5fhKBSrDPIp93uMckHbHcj5g/JqFN6OUpSduaA0qAQbnMndKw92FiZE6tjvKR
	 95ccDgn7KuKmTtZz5d+RDhuIKu70uWThFEdJKwXwYGeoMT9IQxKyj0J56n7ISP5owb5pK
	 DSqOldo3P3iFdFdO/2ep1tGIwjs4dyqXtPNPpV1VYm9bObD2IrlvqjFkIBp3EAfG9qvhX
	 CRIBU5HIu388SvvGTnelm3VXTHNiuh/jz11H91vxgSM2zai4/eWCHUSL1RQDmrvRqnVOe
	 heorHX5+htmg2Ey8QOBl8gAfOj6VXnbSV6zHd17tGLogpc5R3so8Ycp/IRnNAYTUoLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793682636;
	bh=fj/I62UeFmibFrzEzQ+7LeF6z4mt8jtRC122A8Arem4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFK6mMFiMt4OeRQlKvu0cABpLc3DnvpTHehql3YEbAlpxXe2wjDxOSUEhfiR/jirr
	 ato3BxhUE3g+oVjK6KUerpeputJ2i8ogKhw3WyV+xoZxLEoLaijZOJSTSeSmlJOaCa
	 T280rhBuSt9nT2Tznm5OBCkxZJ0Ww8jWUQoMM1bm3RrHhoofEASeadVE7J1eweDNz6
	 grSn156BAqSUNdQxDLgbpDf4+mybx/zkGFa5UcY0uCxyJNkbfSIuI+OFNrxd/epxBP
	 29bGSmVHefrzu1K+bwjov8+y5YZod4OeY/DthTCD5Zhtwzxp+ssr6Fxo1v0VXwTLX0
	 ztDa8FM9jzLbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AF6780DE2;
	Tue,  3 Nov 2026 05:10:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32017B00
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EE8C401DB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiIUMbDykbA6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 05:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCD88400BE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793682634;
 b=XMNWRppTRTbB9xYyUwiESbr3JBzr6q1QQTTnAMNlL5CnqjDKulWnFY/tFIR+hXCVXUos
 2OFNruSH5suCDNe65a90rhPwcsOF7r2zndhX1f48SerrdLWl7tvrHirEWQCpvWVAXdY+7
 0IusE0RNSwUfnnmVVg2IM4e4iHTWTDQAzBumNtlLvvON69EZI10L06raZQCa6H2zMnIjV
 oF+ibR9eu5vaxWP1k9GArsq67gm9sCRIRJPQCpzuHmlgN/NAUPpN/gXgNErJQIPWVXic3
 rkiMpwjCyiDj1d4f1BqZTbKk51kRC1chAMysZZ8e9JxEwTmgwqgtxDwN3B3dkBPMoQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793682634;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=fj/I62UeFmibFrzEzQ+7LeF6z4mt8jtRC122A8Arem4=;
 b=MOIZNAQcU0t395hTK4b9tUKXDQ91mh4bLyvAfDOPWgfb3G0CeDfzXQg40MYMbGbr83Fh
 yd4AVEgrG+UIMHi+dCPCYf43dHvG+YxAbeaZZvZyOri0pHEIeMRdIFDPCsfTjOxNiD1Tz
 wxmYyB9WuyPmrONWECpIU1CV9/r5KtfL+ATqSJR156AAb3IjrqjP00TmaeG8nbgrsWTim
 Oe+jIy4UQTWgCgDOhNbTgxK4D4c9CrAHKoZz1kuXyG8zYYmx7tU2sVh/SujWtotITnNz2
 MOYKc9Nb8XxjHbXCgRbhIrEMZbTvgP55ZkPCH70DrE2JMvSXy7IengiQvBb0R8Bm8cA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GjYYVcqZ; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GjYYVcqZ
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCD88400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 05:10:31 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jJc8g4dcHzKn5k;
 Tue, 03 Nov 2026 06:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793682627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fj/I62UeFmibFrzEzQ+7LeF6z4mt8jtRC122A8Arem4=;
 b=GjYYVcqZxD/Es/Y06n4UAzisRA3phvxNAqpgekKSJdIYK20W83MnOlDxlhEZKq+EEMp430
 stK8R96jatKS20K4EtKP6bMg2Hg6nXNo1eJ+vNnGJqId/kkUAmYk/Vvv5tt5bqFU7la8h7
 e+Nz6c4C32p4NdHw/ZPpZJHVpWduahAJ5UDIWCVyimTXMB4U3KRRyrxr35jrdBmCeki9M7
 Qa2TfL7v8yBH77kF0b/i4CUK8YIUqA0pRDdQ3DQBxcYGpgojiQvZIFogzzIPt4au8yFc8H
 eM+oQNnyoHaspLNlOR3aB1TH9Gotgc8q25IWeBUdV6Z8vrQ6ze2URP5fWJy9fg==
Message-ID: <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
Date: Mon, 2 Nov 2026 19:02:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
To: Takahiro.Kuwano@infineon.com, u-boot@lists.u-boot-project.org
Cc: kenichi.nagai.ry@renesas.com, trini@konsulko.com, vigneshr@ti.com,
 vjardin@free.fr, yuya.hamamachi.sx@renesas.com
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
 <896390bd13f4439297a31492e1a3dda5@infineon.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <896390bd13f4439297a31492e1a3dda5@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x5qzzq1gookwg9jjk6ce9e49753qgjwc
X-MBO-RS-ID: 1e931152b7163a41296
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:12 AM, Takahiro.Kuwano@infineon.com wrote:

Hello Kuwano-san,

>> From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>>
>> Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
>> with Post-Quantum Cryptography, SPI, Quad, Octal and DTR . For
>> details please see vendor page:
>>
>> https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t-nw/
>>
> Please use Link: tag.

Does Link tag apply to arbitrary links in the commit message ?

I believe Link tag only applies to lore links, hence I did not use it.

> Unfortunately, datasheet isn't publicly available...

Yes, I know.

> Is it possible to add board information you tested?

Retronix Sparrow Hawk , Renesas R-Car V4H SoC .

>> Signed-off-by: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
>> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Cc: Vincent Jardin <vjardin@free.fr>
>> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index 67486d7a945..fce22300b61 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -670,6 +670,7 @@ const struct flash_info spi_nor_ids[] = {
>>          { INFO("w25q01nw-im", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>          { INFO("w25q02nw-im", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>          { INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> +       { INFO("w77t51nw", 0xef8e1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> 
> It would be helpful to see how it differs from the existing w77q51nw.
 From what I can find in [1] and [2], W77T is faster and wider than W77Q:
- W77T is up to Octal-IO/200MHz
- W77Q is up to Quad-IO /166MHz
The security extras are unsupported by either U-Boot or Linux, and I do 
not know the details of the security extras of the W77T part, so I can 
not comment on that.

And of course, the ID differs too.

Do you have any particular detail in mind that you would like me to find 
out ?

Thank you for your help !

[1] 
https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t-nw/
[2] 
https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77q-nw/

-- 
Best regards,
Marek Vasut
