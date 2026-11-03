Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B122606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HsJw3vDS;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tE3wD461
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DAA06070C;
	Tue,  3 Nov 2026 08:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSE9zqc58GzU; Tue,  3 Nov 2026 08:22:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 832EE606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793694174;
	b=kziY2+2jbSciJNzvsbtgh9jVQ4LEH5Fl5gdTNTuZp5wWdMACMw6o3eL5mN0WzalF+5SF
	 Ji/4Q6fLeV6C1xwsXxvzivhSVICjb8CiievrK9GnJ5UQldoWpUoH5oMSKA/+ZdTrsaW+x
	 VpAWV2gZJriqNzmjxtriwoX4X6Ko6A40tbM+kgc2cSd2zTlyVml3qYKzhPb+8/omeOWcq
	 2aWeL4UofF/k8vL+2BYyBMpk4qiDaUTJK0jqZI7NZ4aCoQxWUXKagVFlR63tnF2fWOv47
	 UtSOShZDhqogMv033ZEZ3PkwqFrQ0YX9ZtqS7fM/w4ScMqvhXAouluhbqyn1XxCCmRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793694174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A3mybXghO0NuoEQ21bYV9NVzHv1e/h69jveKULrLyNA=;
	b=B3bLhetYTjvqj1kawM5X+4RkHxsYQ2BuXY/VfDREYuJ9D9aON9I4bunYkoFdN5U48OXK
	 VpallyUa8ctYo9GoFBedCc8Y5bNFwm2+pjaKv5eUee+ULDIcgheRaZcKkczTX2+Iul0rq
	 sJEKEMxy9t75Uz4yFKgFbR3ijjwPcEibXXb8A/kqtyeSUMxb8hlff3KEtyGyzunKIq6P9
	 +OjfB1qI0jvEcXldIwuzUtuNJzFqSGQIT2lHUpbmGZ1d5k+yNmPryuTPkRTzjMhe+Oz6F
	 4DCkIX9wmWbcFAllmNlGzesmVgHKhvWYIKrjtZAthGCimPvKs5DUZtrBCGhxRa4rmxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=tE3wD461;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793694174;
	bh=A3mybXghO0NuoEQ21bYV9NVzHv1e/h69jveKULrLyNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsJw3vDSGDOmG4SHG+6CMci0SDYjI+M4LJSPGB2nPaVt/OyH1IrG2fhjYIgUelaJ0
	 KAXyoDWySYvZBr475la9WG2ZLc6b94A8Nkp/1WAl37d4wsxlpeiMylpM3qnDZdYWaC
	 oCux0xpfxhQnwaDP4xArWb1NaJoWT7WtOTZuzTduf5fP9E874XkROH+tnZtsOgrA7E
	 hqwU9RSoWu0TqHE19zC4CM/dBVdO6sTj0F8+0M8OzAeWd8JX2+7qggSPQc/oy4WcJq
	 DgOHmFGpg3GZmYqkh8qVMIYGZAslxIM9Ssjjx5gsDv/4Wh9PsAno1kA98umAdAiuiC
	 8cBzpMJd25pgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 832EE606E9;
	Tue,  3 Nov 2026 08:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16AB22AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06BDA606E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3ioqP6_eCHp for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8EDA6069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793694172;
 b=GNvuGnjwPGlFQZz5B4nmOOlLpCUbyK0PjwZMMfMaTgJwW+cOAtTVaYtTUQw9PR9aUZ2J
 ofP5qOIiSfSEqi1VMHCEmD0L/yBs+zjqxScxhus3OM3XCodX7iiFB0hWnH8b/j06Tj2hs
 gqwsPJTLUTr9lFTnYsOb/gQ6kG5edRgDn+CZGTS8EyPEr/Eawx6t8gAvdbh34iwSfQWti
 zUcpLeZgSegY362n2utZTiaAAWKtUWLdFxn/EZjXxX5NBgCAG/Vppb5VDh1jGJwAv18ji
 XDKhbdk5BvdWFKCc0pPYQbnrreM3yPXsv75nbP3vOfVIBJum02ifaBEsmwvCd58vlGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793694172;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=A3mybXghO0NuoEQ21bYV9NVzHv1e/h69jveKULrLyNA=;
 b=L+DZqG+yIQThE0CR2PLWyDZtEfdGQn69qykPT6JLj/8+rJdyVce02iXjeYE4Cd9yeT15
 VABMpw4cQKSxgLJ1Dv/ldaCIdWomcl+m3PNgGb2+4vP0WUpfRe9g/LY0SQPCGdPuIu/oR
 JEcFawJeVutPaocE7qEp3uUae2VMcUOX91Uarpbu6NT/WRmqCfC4j9AQfEgaQIqMe0zKe
 egJnGQus62SIqgv+L9Xm+ahkRW9iMytY8sokGAlSZUp72SVY/xyMhKsx14+6HXPgj6Len
 VfpRDMNZjNQOu/KeSYzGHmBlQQW5X1qnIw1IdeqTZ6UPyNAHs5XYoL+6Cp1C/OnlQ8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=tE3wD461; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=tE3wD461
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8EDA6069A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:22:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id F34824E413B9;
 Tue,  3 Nov 2026 08:22:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BE14C6046C;
 Tue,  3 Nov 2026 08:22:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED88910328C5E; Tue,  3 Nov 2026 09:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793694166; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=A3mybXghO0NuoEQ21bYV9NVzHv1e/h69jveKULrLyNA=;
 b=tE3wD461OnqcpkpR1YJFK9LwOIs1XbKnKKxKFrYVl8vqcNf4ciGkANp+k4y5+xVCvDLhHX
 0XRXnJZb7QuVq2Ue7aQnwIbGs4g3ACQDPogz4zN971+IaDQjJ00lN61gDmCoJnKd8vUWJB
 f5FnhhYT0fIfXWTDat28g40e1965RVkr3XhB7x03mFX7HjXvmXgVgsPO0/yI+9+xPDHbEt
 2lxL1miZ/koadySN/jtjyZraZ77nYptZ+HAVAStYCctYUI/h66224VKwmTDoEwO0SzCffN
 57ndRswCQT97IIhdwtIEiti0Yv1f6WEDf7Tz4+XfadaLUFdJnX7jXm9/V5fjxw==
Message-ID: <33b6e3c0-f388-4fad-b76c-78b00676b2b5@bootlin.com>
Date: Tue, 3 Nov 2026 09:22:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] bootstd: rauc: Optionally check the partition names
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Frieder Schrempf <frieder@fris.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov
 <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-6-b5a878627107@kontron.de>
 <db177de8-a6ec-4600-badc-840629e1d6f6@bootlin.com>
 <a9d7495f-cb30-43a4-8aae-e6eadfe7bfeb@kontron.de>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <a9d7495f-cb30-43a4-8aae-e6eadfe7bfeb@kontron.de>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder

On 11/2/26 4:26 PM, Frieder Schrempf wrote:
> Hi Bastien,
> 
> On 02.11.26 11:03, Bastien Curutchet wrote:
>> Hi Frieder,
>>
>> On 10/29/26 5:23 PM, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> The RAUC bootmeth uses any MMC device on which the boot partition of a
>>> slot holds a filesystem and the root partition exists. This also matches
>>> devices with a different layout, for example a single-system image or a
>>> standard distro installed to eMMC. The bootmeth then claims such a
>>> device and creates and saves its BOOT_ORDER and BOOT_x_LEFT variables in
>>> the environment, which makes it difficult to run BOOTMETH_RAUC alongside
>>> other bootmeths.
>>>
>>> Add CONFIG_BOOTMETH_RAUC_PART_NAMES to set the expected names of the
>>> boot and root partitions of each slot, in the same format as
>>> CONFIG_BOOTMETH_RAUC_PARTITIONS. If set, a slot only counts if its
>>> partitions carry these names. As only GPT provides partition names,
>>> this also rejects MBR devices. The option is empty by default, which
>>> keeps the current behaviour.
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> ---
>>>    boot/Kconfig                 | 13 +++++++++
>>>    boot/bootmeth_rauc.c         | 68 ++++++++++++++++++++++++++++++++++
>>> ++++++----
>>>    doc/develop/bootstd/rauc.rst |  7 +++++
>>>    3 files changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index 8fcdc36c931..5f89c9d86fa 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -968,6 +968,19 @@ config BOOTMETH_RAUC_PARTITIONS
>>>          The first value in pair is for the boot partition and second
>>> for the
>>>          root partition.
>>>    +config BOOTMETH_RAUC_PART_NAMES
>>> +    string "RAUC boot and root partition names"
>>> +    default ""
>>> +    help
>>> +      Sets the expected names of the boot and root partitions of each
>>> slot,
>>> +      for example "boot_a,root_a boot_b,root_b". The format is the
>>> same as
>>> +      for BOOTMETH_RAUC_PARTITIONS, with names instead of indexes,
>>> and each
>>> +      pair belongs to the slot at the same position.
>>> +
>>> +      A device is only used if at least one slot's partitions carry
>>> these
>>> +      names. Partition names are only available on GPT, so this rejects
>>> +      MBR devices. Leave this empty to not check the names.
>>> +
>>
>> This feels a bit redundant to me. CONFIG_BOOTMETH_RAUC_PARTITIONS is
>> already a string, I think we could directly use it:
>> - If it contains numbers, we go with the default flow
>> - If it contains strings, we treat them as partition names
>>
>> This would require some changes in distro_rauc_scan_parts() to iterate
>> over the partitions until we find the relevant partition names, but IMHO
>> the result would be more 'user friendly'.
> Thanks for the feedback. I already thought about this and now that I
> look at it again, it seems not as complicated as I thought it would be.
> 
> The only downside I can think of is, that we can't handle partition
> names that only consist of digits. But I think this is acceptable.
> 

Yes it's acceptable in my opinion to.

> I will try to implement this in v2.
> 
Great thank you.


Best regards,
Bastien
