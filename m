Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB04606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nKEetQT6;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B/+LuMyZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E85EB40611;
	Mon, 26 Oct 2026 22:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfhAcvDcfiKY; Mon, 26 Oct 2026 22:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 392224061D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793052798;
	b=fnNiG+C69mHIJU2h4JdFylSUC21IcD3VL4uxi9yeH4+SQ7lI2xA+krDkcRTglZSmFo/Z
	 tsBoybfqHicDnEdiLofyUBgTCJiYmqytBpU0ARL8V2m7GByjX9MMnlk32YOsB5ME0LzCK
	 sToq0BmHqSxDe9zLKauyECIMqeoOPi6ddzqm8Fnhcdc6Ygo2ZOuC+I5qGyWzMtHn7dgiN
	 6xuT+eoyYnjpaYHzB8lwO2SBJFNw5DVVRhJt5GpIU7fDiglvR1bz/gyEahotCPIPZ/E/+
	 BLofNs7gamZQqDB9lb4N6Gb79KPzY6f1e0Cp0y0+kbkVPAhl2Wtwx58gA+6nNlCrQeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793052798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pGFH4YtGUPPlQV/ZIxNwfIdKZrDCUmZYze2INPVOdVc=;
	b=EfeXyac7rp2caY9d8JCS8Yl+FbVsL5DU3wfX1qymtTj50WStgqtGKZtDGVo9csvxnJnX
	 mnxywk8S9Tc3+bQZmJaGcq5qjyHdedbwhGuMQU04hTX0hbAW9n9TWPoM8l3WC9v4rQ4oN
	 OGjz4BsovvAdRftMIsj68nNRdv3fIBpRQH9s+SHiEMJ3DYZ8pmMM9nYo6U9VO2IYpq05I
	 kF/oYLKnwd+n7VU1IQeCiF0YdcEclx4wPsmateWinhxWQYX5w20Vqccm8Trn6gRtzFokl
	 omchZgXdPy8fhWgCNuZyAwL/oEzPSyU/zyvZO0MKXlVuoEVsZwo3Bnj7P/jjjZgSKHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793052798;
	bh=pGFH4YtGUPPlQV/ZIxNwfIdKZrDCUmZYze2INPVOdVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKEetQT6rqVgpnzNqGOMjbQ19DBKeN47pg8DIr51WYNEn9ULc1G9QT8mUG3B7dkSW
	 LcAi/M0RSv9K95xWJFliMRKnpHO7wI927AQboOMxQRuz880yuykziAN7Zb2iW7qwnO
	 4BDq+KoPb2F80Xlq/Uc6i4Y0qnW1Lc8gCwu6md8h4+1TXDZEkhgOLJrsi+o8qhT5Uv
	 NGrTmViNOdWgWZ4wERcpLmKR9EDj8MT8buX5cnGjwnbPVbIJh1T8eB+SUz54T30pVW
	 E7wRWZU1Vnk+XSot3jenmQaNcgEU0tKN2S3i+lhT+I+UCT3anDbM7Oczs+xs1gOtpC
	 i8EiOaAJ/WQIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 392224061D;
	Mon, 26 Oct 2026 22:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E6763421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8375740205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0jgLTK0ZCUJE for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AACCF40075
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793052795;
 b=Pca7J9n8xQisfoEwMbc42CbDD5n6nMHn5KIV+4mBaRmPXOp57bng7rJLdmgD/kjmr3OT
 nPQkyhfas273b1gWs1NuEvaDu1v9sv7MVfUxqostR3TRicN+GQFAhk1RRtscNZiKnUcFH
 ZG+wS9HxXjjfYKe2y/dE3abpXLLLMnNID5WGINlgpEThSeS1q6PkFzxUlar4N0v0SMMT0
 TN8rEcSiK25RjkwR58pkHGey+Uc1dWMpXLQgrPvruHmVBbqe0QlV8Xyh7FDdiIRx+gwve
 ysvULNhomd/E1VprkTFQVFQbh+WnlV5JEN2OR4XAw6xQnMWUrlupXs0ZTVithb5xgUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793052795;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=pGFH4YtGUPPlQV/ZIxNwfIdKZrDCUmZYze2INPVOdVc=;
 b=SvkgF9h4D9oJbimXloSTlf2zfcRefKn2xKA8nBNRorIUMB0gXJ19pflRgFTv/gKPp/u5
 6q5VH2OmcFnTegPo1vl7HX+RNIIHMhJddlQDcXEAEX4AkRflvAclFsAqJqezNmuxoEvXL
 3ExibxtjqAN1Z3z8AZVi3x7SLqTTsdaKoXj8rvWAuHCwjkO2mwSEoj4A4F/iQCc+AOeG0
 Bne1qsIm7LEM7S12NwzEforETxqlNWfCE2/mzjvWEF9ha/hsaUatfx0ARjeD3cf1/53h3
 iUWR+2Lhjd+GuD/rKqrgvt+gBb6vbuqXaqNGsec4fPC6J1drzIzIY67XQIGQYiYIXsw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="B/+LuMyZ"; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=B/+LuMyZ
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AACCF40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:13:15 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jD7DR5Gv4zMlNL;
 Mon, 26 Oct 2026 23:13:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793052791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGFH4YtGUPPlQV/ZIxNwfIdKZrDCUmZYze2INPVOdVc=;
 b=B/+LuMyZJP4pkBjutn1xlsVznc1NYkdOo+1vUzUwA/MTJqh7xLKTvbgR22S4GivWmqNOy7
 u5TmVpYzsS47cTjcjePYLORBR9j/SXbZvJTZjaZVUj0KNOFJJoQ2vnyrQtentmcz8jQ6RJ
 GwecwmexPyQuzeyc8Cf82Bpg+zCKjfXPAeiw9CjNjSKc8rqSCtu0yf53k2lHUrErBYs232
 4MbZG2SoZRUbS1JlvNierqQhROZiY+49jdrCU6hq1/Ocp7BAav7BSP5nKK7t5bJBLGprYZ
 5VOa8Q1erTJhQ2b3vnjK5vKrB5A3WJB9INR3E5VIRWcRWIrq657XxQbKI2CxLQ==
Message-ID: <6dcdbf5f-fd4b-4a85-92df-3f14f6e24b5a@mailbox.org>
Date: Mon, 26 Oct 2026 23:13:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on
 REMOTEPROC
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, MD Danish Anwar <danishanwar@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
 <CAC928HbBT6=qBN6KSV=WT+DEUEuUNdW+vant86xX+rpq-ZtDaA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC928HbBT6=qBN6KSV=WT+DEUEuUNdW+vant86xX+rpq-ZtDaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e3fe0a8384b2fb1e43d
X-MBO-RS-META: tusskqs93u97mxcdargu8df3785m781x
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

On 10/26/26 8:42 AM, Massimo Pegorer wrote:
> Hi Marek,
> 
> Il giorno lun 26 ott 2026 alle ore 00:18 Marek Vasut ha scritto:
>>
>> Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC, else it shows up
>> in configs which do not have remoteproc enabled.
>>
>> Fixes: fb49d6c289d9 ("remoteproc: uclass: Add methods to load firmware to rproc and boot rproc")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: MD Danish Anwar <danishanwar@ti.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   drivers/remoteproc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 7f9e35283f9..cde572d61c1 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -151,6 +151,7 @@ config REMOTEPROC_TI_IPU
>>
>>   config REMOTEPROC_MAX_FW_SIZE
>>          hex "Maximum size of firmware file that needs to be loaded to the remote processor"
>> +       depends on REMOTEPROC
>>          default 0x10000
>>          help
>>            Maximum size of the firmware file (elf, binary) that needs to be
>> --
>> 2.53.0
> 
> Wouldn't be preferable to have all the remoteproc options under #if REMOTEPROC
> and to drop the "select/depends on REMOTEPROC" under each of them, instead?
That's a much bigger change ([PATCH] remoteproc: Hide REMOTEPROC options 
in REMOTEPROC conditional) , so I sent that as a separate patch.
