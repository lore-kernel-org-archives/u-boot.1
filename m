Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB07606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WnEj4o+G;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=KmIOFD7C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FB4260B97;
	Sun, 25 Oct 2026 11:12:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpkRjJHzE0Iw; Sun, 25 Oct 2026 11:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 316CF60B92
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792926722;
	b=n6Wph2ShWggT7mq6Y0aLkU3FhWQLTE5ntNLG/E58TTX6+6gvNKf7P+MMgilrXJ457z8s
	 SlBXjJcUpOO9qXhiS6sscNgVGMxEno6ihEKspzsppGpWni71iqD5HRVI6VMXCBO8qCYel
	 mmh8CqDRUdepHbdiMaisotA4bHLjORKqkOVdWgBOCblsAl8svqcZtKVHN1eozmTdX4uJq
	 C8ltTAg3Oz7mAgDEzi1ShyY0H1YMnLLmq/JdJXdLMiTU0a2szNKRBtHkVJfZra3UHiDKq
	 jtll0+NaaNZ5M3UsvR/hwmIb7iDhYzGiAcz8tOBhiZ2Rjzz6HZYptIec4XCjF5Mqtug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792926722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uQUDWhZmE5VviMAejBxvVyTecKeQ6HZ2J6HtBqyzo1Y=;
	b=APannRvwjzwwpvSwPXSVS0GOur6Oas6gRBp0ZcrzJlxrG+jjobH1tbpym6IGQ2I7gsTw
	 vP+dbZKl6Be4hqgaxguexwxPyOHX3yEVLxTFftfBOiMznJg99b7MuzuiQfgvx1egznhkm
	 Pn1x8EWigMzP57zafkzBvFhbwPdAZsBf3ENEt4z4y8hyDHcqPsIpJjpj70rkTDM9BubY8
	 JXq3KT2FZNEhNLBCfD4rhGSYhm02zx6sJgmTfLvDZwKvUbqXYWUqNt2NWDZ5I2eId5Ziz
	 SRVo/CkMWMcJTqvzZXiiNfNfDUOaOgjIwMAp1F5N4Au59pTJ2xR+t85ORH/d19s0rng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792926722;
	bh=uQUDWhZmE5VviMAejBxvVyTecKeQ6HZ2J6HtBqyzo1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WnEj4o+GgKwVIobSZdWc3MroFvKm3czcjPXAqI47LntErqYGoFsQRv5UysOwDNdPT
	 DkouifWgNUcMld3vyerxzVYpeejz1lvfw3TWriVoXSZ+/bwklLoJoBYkTA3eMYok0L
	 kRFVlFhS2hWvX9UhHR+e/ofzWZMnqZR/IyqYwFNYt36KPRGeJvtvposg5V/bJjUva1
	 UOk+IjgknLG1nbqY7tDtdR3gQvCgChDVpfTbcR9RK+O8c4fKMiuC/gcFJF2zmU1ZSh
	 /089Eqfn4C4FQHt9sylNIuR+JWXxFXmymVIv1cCeMkihBq9Jf6r4SoYqmZqvaLFrHM
	 pT8xTSb6ohl/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 316CF60B92;
	Sun, 25 Oct 2026 11:12:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E4A443
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 11:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BFD0816F6
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 11:12:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CsmBkbV8S-9m for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 11:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D275816D5
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792926719;
 b=UEOIy1Ysy7DlRTg9FuTW9H2t9eUCwQ00QUVLEks19Q9Y9hMOnUsr9iMqn/eaZ6zw6f/d
 71EZo8tc/JlOGOowuUlxtBmIZEVu4sM7LncPRJbWm+LeL6hSbK8R9L83YIuxe7/PYTZ6t
 ILHmE4VIUyn44wKxFLYrBW6G0sJiSSjqbC3fLwiXBlhmBBWfbKeoGeDuNhRlawFVbd5kV
 wzl08iwijpK58IK/PVMgSCT7h3JxeC05FiBEgGyMzXBgTlviRTxfdC5tgUKnVFoEmOmMU
 gE/+zwOFMBJuwHOYq4nFoycyHxfB2TRd1aVnRX68gNYn4OtXmbKfwDjm6t4bYJbGpTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792926719;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
 X-Virus-Scanned:X-Virus-Status;
 bh=uQUDWhZmE5VviMAejBxvVyTecKeQ6HZ2J6HtBqyzo1Y=;
 b=strK8h9cK52yfJnYZRu1s8i3OcZHmAGquVtlmBXF48OmEKumc6gR8qrWL785TSJOpFnu
 7undX4S5wiisZwpmv0lTBnlnMLerBJzVWnZCQ1Tk0CeV7CvhINcl4xetPNTwhQe/g6oH/
 BtM1jQhHip8lr9OkbT2EA7Qm24IxeZrAAz6beLwCN5Q+JH4BvKSYf7ySm6IJ5jCkJ83Zy
 U/ZiLz7gDEWBM9Xy50RnT7+N6SVH7gtJG9/XJyQvDoRcSEud4ZVZ8Fdu/53D1Yesg3B8z
 h6JgKSGQab3ygIeXaicQZmd5ENFx7Y+dY3rw11uxPbsxEM4+kpIkf31PSHnuOZBSw3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 spf=fail smtp.mailfrom=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=KmIOFD7C; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=KmIOFD7C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D275816D5
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 11:11:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6D08404D; Sun, 25 Oct 2026 12:11:53 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2489183108
 for <u-boot@lists.denx.de>; Sun, 25 Oct 2026 12:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 082391079E4; Sun, 25 Oct 2026 12:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792926701;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=uQUDWhZmE5VviMAejBxvVyTecKeQ6HZ2J6HtBqyzo1Y=;
 b=KmIOFD7C9FHq65JJ5dIPQNThccyWTSKACuZCH3o9fxSxgKN+msdRFF03tq9YF8cnfV32VR
 2XN5yhrIpuA3d5fDgJm+XhYFK7RGaG8k6NWlx41xqaTMS1GpQS8ZmGyJRzmJY2xT6mNUtg
 qc/NsUSn177F6ZFbEansb1yS6MbLZNpsSt+Ylfv3oTUX/PB1ZkMx4ZmvpJcL2HP+XYQbVY
 UeUDwoVuZX1J/6l3EVev7DvuFvgsd9lWgZZg/DBnlZVGFvjLnrAwddKNb+QhLAo3Gl77Fe
 4mdUq1hdrGj/FRXf/03hdVf87+0sxWF1dRIFmA97EjsDGthmHNnW24lVz7s9/Q==
Message-ID: <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
Date: Sat, 24 Oct 2026 20:05:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
To: Stefan Monnier <monnier@iro.umontreal.ca>
Cc: u-boot@lists.denx.de, Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 5:14 PM, Stefan Monnier wrote:
>> to the fixed indent:
>>
>> "
>> DRAM:  3.5 GiB
>> Core:  310 devices, 34 uclasses, devicetree: separate
>> SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>      ^^^
> 
> I'm probably not the targeted audience, but FWIW, I find the meaning of
> "SF" non-obvious, so maybe instead of adding spaces, we could use those
> 3 extra characters to come up with a slightly more
> self-explanatory abbreviation?
SF is SPI Flash , it is used all over the code base.
