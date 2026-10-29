Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED1606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vQeR1e6X;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=BQnvxMLV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F851810F2;
	Fri, 30 Oct 2026 06:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PoWEKqSqs98U; Fri, 30 Oct 2026 06:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CDD5810EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793343298;
	b=rSY50ypTTnfe54kQKwnJN72mruNBJk1bGlpqg4VYwYQDK0h0isJYfMs0OwGiGPMaQrXO
	 uoPFBDn/W/LAGr2Y0fyUNnGyqZONn5OQ7JxnAzgvsQDiUljDYUBcY7JQG3M4sFneCDUny
	 YyJmg13/ucDCPBqhxccm9XfLHNHR3wD7nXQHuWRUT+jO/oSMaADZE7YXz4ChXhRAT4XZd
	 9DIUzI9OzgYIrSL5qTVlRnCtc5/Mv+Mq8tkmyUV2HODAfmW0lnncA1446oiXwrUW9OODj
	 dBTQkbDxFXslxfFrGz5cwPjWFkH1w2okGL5VQfJjAuYRtnIgUJHzd9QTphT3ez5+b2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793343298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7tTvrExZ6niSflh0cNs6EI7my5z31WnhsePamkpfyt0=;
	b=Zp+9HcqF95uSogZiIV0kwo3SXjeVYjAJot9s8bd3r9phWoacdkxo9Bo+4eY+HyNsBjN0
	 MhS+/TP8kZaLjDHAUqywYHOzDh9n3vIMGjNIBnPEmvd5GHeSWgLOy2VIMxSK/r3gxmSsg
	 kHx4DEUoO6eitpWb37LempwkqjZ/WXpq862UoNqUccqfXZX4PiHO/HDFl90rxkAUYaxZ3
	 fhCmgV5lPL/FcGq1xTb/fXSL9nYiprW3HXXkh1z7KM6EUi75XW8+XQxy6raejGO2BkR6W
	 KJlTO1UjqtZywY7K/k2jKkxujN8AsldBG6FiiqB2c8p5B60C9Sc1GrMR+7wsxGm2jrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793343298;
	bh=7tTvrExZ6niSflh0cNs6EI7my5z31WnhsePamkpfyt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQeR1e6XMa7QANTb7W4d/PaBOa+fpohRCwjGVj9TkvlhHUXxk5DHpf4IfZRVhJIfo
	 arCMdUbj7LnO0qzBxSsjcqpZbnKzz/+YXsH87xzQNb+m1mQuAkOmEgdt+PS7rkkWXi
	 NWbCKT5LdUj57iTYJeYrXEkyMSbe+zylavqft9VPql6r8TdI5dxdIIwMkMNr+WZPdR
	 jUEL5l4blgIv3Ddgp5yBhoCJw4QVlnv3F4OTRRrdRPPLAf3+jP5cPV9PR8Kia309XB
	 swMHHNPOXROIyGVWUWP/E3zkxz6WWqC64HQtNyys9ExvWQqT6CQrm0sUvI2Z1GwcJ8
	 SMCHY77nUu5RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CDD5810EF;
	Fri, 30 Oct 2026 06:54:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03E9C2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE10F40ABB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGMpu82OmOeo for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 252E340A8D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793343296;
 b=LsdG4SObeBgpcm2FOBJyuyf1VGzCFGUYNeE/nBwXysBaGhGwcpJmFOqXnjRx78boTmHU
 5ztqjWrJsGmDXFSjQEHlff4DXtIZV3Vr0ZA1o92asVGOSfERCtuO+er9K6ExFuW8KQsJo
 KdKApMQGg5Hj2qcPQ3Hl3unjswzj44hrZ6yBos4qQKxGejk7WAeJVp5GjZ+b+sWRu1Kc6
 n7SRYAuoETj/KnP0IPka64O45YNMYT5vaCup1hWGgjI+GV8VQ0HA3W/KwEEUC6ZywIcYK
 4LblQo74IPuec8ATy3Ly77GHnPIZoMeAxQaAcsBtCHYuGMKzK3Zo77EYy8hnGuETHpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793343296;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=7tTvrExZ6niSflh0cNs6EI7my5z31WnhsePamkpfyt0=;
 b=e7hra5T9O4iYWSg+4EagLA7z1ubw+jTe1+nFWtIXCSHzhReu4gf9zzILrfPX9zewZhOk
 ksrTcQZoa/BkoK+NhGO0go8uCdhuDR3TRRwz0OHERKtj840vc9zoDKHBmOWq7g9nrRktT
 HPnIvTDtbCBIdodhukpzfknw2yeKNF6BGymqKIJ7ouJYVD0zYJbZCkX09K8+VdyuWTEM9
 Uh3OY9AsXb3b/IYSdl/vqBTn619OIJudOkQ1AfoM8v5XiDlzAZ3mBS51A+DLL5CP+Wtbk
 aibu46M3PbqUDXoCWSkDuN6uEUTlFxxM3bS6usONrw4Sgo8YeAtgfbw15/tZzBe4JMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=BQnvxMLV; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=BQnvxMLV
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 252E340A8D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 23BD610BFB3; Fri, 30 Oct 2026 07:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793343287;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7tTvrExZ6niSflh0cNs6EI7my5z31WnhsePamkpfyt0=;
 b=BQnvxMLVb1hSVIrCq28kucNG7+ypBSFC3on2PEs8sOYXbpf4rjo1FDeZTKhawid0coydf5
 1daQjMbAdPAvfZPoVdZ+acG1X8MnRHGjjxweUNCOCNdyhnQOt6aaZeDfmax1XXQGEEEBaM
 vpEFN0XvhoQuAVPNJnegJCzYnfY2fgHOhN9NLcZ9zjToGLTN3oPtNl3k/UQ3vOuhU2i5OS
 wjGvnw3B5cexm4uJ7UNiAvwv3E/rCAUNdejxNxZlyjFYdNxzJUEzA8aX/VS35HEMY4WrHM
 P553/WzicM6bOwaVwBYjLVhT74zVqjWA2VWyVEhZ2eN1ldqKfR1j2+CTum0EMw==
Message-ID: <a4ffc051-d597-4c9a-8490-7e3af4f461cc@nabladev.com>
Date: Thu, 29 Oct 2026 16:04:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers
 regardless of CONFIG_PHY setting
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
 <a829d462-e139-4905-b2c7-f8140a6cb2f2@nabladev.com>
 <b94621f8cc783f5f1e97578ad7bed3405862574f.camel@ew.tq-group.com>
 <a0e9aeac-0c20-460a-897d-b2b9163739d4@nabladev.com>
 <3cdcaff197b59c6b9e3b376f0e2c15e1d6902973.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <3cdcaff197b59c6b9e3b376f0e2c15e1d6902973.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 11:09 AM, Nora Schiffer wrote:
> On Wed, 2026-10-28 at 16:16 +0100, Marek Vasut wrote:
>> On 10/28/26 11:40 AM, Nora Schiffer wrote:
>>> On Tue, 2026-10-27 at 18:24 +0100, Marek Vasut wrote:
>>>> On 10/27/26 10:39 AM, Nora Schiffer wrote:
>>>>> While a separate usbmisc driver could be added, no such driver currently
>>>>> exists, and it would not necessarily be part of the PHY subsystem. Rather
>>>>> than making the misc setup conditional on CONFIG_PHY, make it depend on
>>>>> the existence of a fsl,usbmisc property. This will allow enabling
>>>>> CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain support.
>>>>>
>>>>> Also update the code that reads the usbmisc address to use the modern
>>>>> ofnode API and fix the portnr to be determined from the usbmisc phandle
>>>>> arg instead of the alias seqno.
>>>> It seems this patch does multiple things, can you please split it up ?
>>>
>>> Okay, I can split this into two parts:
>>>
>>> - Make the setup independent of CONFIG_PHY
>>> - Use address/portnr from ofnode
>> Yes please, the clearer the separation of changes is, the better
>> (=easier to review). Also, please split the series by subsystems, so the
>> maintainers can pick it up through their trees. Thank you.
> 
> I get that these will need to go through different trees eventually, but I think
> in the current stage having the full series to show the whole picture and have
> something testable makes sense.
> 
> Will the ehci-mx6 patches go through the USB or the i.MX tree? I feel like
> pushing them through i.MX would be less of a pain due to the dependencies
> between the patches.
USB, since this is USB stuff. There do not seem to be many dependencies 
between patches in this series.
