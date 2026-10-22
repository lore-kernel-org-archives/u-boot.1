Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF769606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V4JqMQAr;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pY7ajF1n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31B964099F;
	Thu, 22 Oct 2026 11:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUWgeZPibsoA; Thu, 22 Oct 2026 11:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C53C40879
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792669877;
	b=b0BouzWqs77rTMp3VC96MxMFHrYEdOSMeteQnr9WqfGBpqz9l0+0wzwrtr30IracdVxS
	 /RJQD/aOibcHADbfvLw9Wsn+pkR7JhJXh0i9mwX2V8IDQh1J3jh+zPS4s3Jl3aJY8cks/
	 A3Nar0/wqdO5jVI6qlZ/pSlwiHTI9tKMjriQBt5mZBoKQ9p/PdMr7OQBG8e8F33orLox5
	 mCNaTy/yDbHtMr1m0irsmBjQr5hcydZqOUINwM2SW2XHF6Hr5QHN6bytReLJ+0lK3PDn3
	 uLY2NEWzwr23png8W4pXCPyvJpDRtjQVH4sRAhDyqFtJfD7gCNLEGM4kflxtG/FxAnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792669877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m4xItRmbCmCGGov/WNdAhSq+aYfLRxTZN6xTD7LexKU=;
	b=ajr2v3q1qWv9Qs7jSm4KU3A/j/zoayY7p7dgj897iEgHnMuEKGtcrXaqdOIMYuMmJeOt
	 NgZAzWD3PNQ1P0TxrwB/KqMclTZRa2ikxsH8dMjW36+gCmEsLEfX6rGvEIUqt99OHIVQC
	 yLzORV2btCfN/YfPDQeuL226szgAjJjWib4QDon8G1j1PkammexgfR7i/RObO3hDduTyD
	 xbw4cOdGalcaopSknbodThKMWXiXvgf/jdpy+tVaHZbHWV9Ta/JWQhuQTevcCdtphj6eZ
	 I2GfNzwhFji0D1uZaY1BxNgs8Dx1hJcXmCmraoCjr0Zr5Cr1Tjfrg9CmIRY8JfA/iYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792669877;
	bh=m4xItRmbCmCGGov/WNdAhSq+aYfLRxTZN6xTD7LexKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4JqMQArwJO8vVkS+sJVkt7L9wKM888MiijTeTKFTk3cHoJB18NFV3xZQ6QYPebHR
	 VlYOaV2MDFKIWdlkmoHJX7rB/JUHUqD7b7UtGYx4QRI28ilrTLcCTF0FHUMkmb6YBZ
	 iDPp4cOuXkOuXHqkK3hW5cVYWxj6+LH52hoGDzLJjvJ8JoQ2m6oer0emAZhSmCtgRP
	 Aef4nKR00YhDJXnlHXEuMBBjn7LqlgSglNrVn05MGikh85kLPeT6kCf6y1f2IfJzOJ
	 wYdJs8VlVd30t/DfCpD53w/NEpbJp36fmxPAARhbVMNCTHQqtezh7gyJw7FSHBXsju
	 5798rQwQ+c6BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C53C40879;
	Thu, 22 Oct 2026 11:51:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80C651AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66B7B81285
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwZ87mwB5aL7 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 11:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B26581255
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792669875;
 b=HGy7LKBZgr/t/tjbY9KDjrb8BbCaaZUDBzrAe0e+NC9zwiMAXeWYR8KyNFiUb0Jduugn
 ofJ5/la7uDAgq4oK5xjCp2d1WmAQtLmP0aV2AiQ4idwmBQSJKZOvNI//bFGeafYpFPEA3
 NxmCpG5G/Xa2mPmBQ78D+cCfITDEE1eBgO36aiM+E9e7v3jhHJ+dmzOOgyfJrXim5s1n1
 fMrSLGJ9EhrWI8ttjkOECcgLrt6Ms9cYO3hdL+vmNfVfVHk9ZOY48PwVnEA8lVyI3iokm
 g0+ErpAijMi9BDy9V4HuP/Z1w9dOjuH8ugtCgMEhleGZDpYzntw97Q+hrRHylgfvOlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792669875;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=m4xItRmbCmCGGov/WNdAhSq+aYfLRxTZN6xTD7LexKU=;
 b=QrOQ4A7EWbnz4drgwdm8OuQQBWRU4jg/CGqqb3IWOLSm/7Udq567nCLnqF0edP/JupEJ
 NzZMe0xndTT+MxWtWzPaN2skoBQ0nbe+MRCBHI7ZBo+2EuQ1rOGVeMDiWuh03HII3M6Jp
 areWgUGQp04FaYaIOtbKVgNQhCeOwm3XamhwTMDpnTwQp2Mczr4LyphD2mOcHDqOSJsAS
 2AonX4OARIvj1y8JgO6rVqB8ViixFSI9T3fZr1itVfqXEOak7B980XDKlOnk9y9whKIDf
 S1zanWsxuCjcigsb95x85xNsbL2QWPfVIOPgWMFenCl/yG/Uc3Na2v767xHqbpU4Iow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pY7ajF1n; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pY7ajF1n
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B26581255
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:51:14 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j9Pcb1gz8zMlWp;
 Thu, 22 Oct 2026 13:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792669871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4xItRmbCmCGGov/WNdAhSq+aYfLRxTZN6xTD7LexKU=;
 b=pY7ajF1nHrntWdoET2Vdc62DMLLZoZriX56YhHoeqjf/FtVylz1PH0ejOFHx4CCZbcDsvJ
 5zIlPR5KRkRMi5ULMSKRbq3jMg+f4L9sQMcVrWIKWY7jvIN3An5QP1pqYZPZ71sMDNJ54O
 qgXwoOoSLd9c8ei0ZBp8sfK3iibCxqQ5motNn+st533XrKutTaXHolF1xUwkjRqSwnoXI2
 aAnvRRtDUMdUGfLpUliFsJXWa/s3PRui4U+36qOERSeIz1fU/RGA8ktheLIUXmC/TStkcN
 n6tWaPd1WIZNZGVKA4R4u+1yUD8qpL9Ynwi4a8+GrGjDQ566x/8NsTiPe7Y6Rw==
Message-ID: <51728b98-7aeb-431e-9367-fd5f5cf42380@mailbox.org>
Date: Thu, 22 Oct 2026 13:51:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] usb: ehci-vf: take the register bases from the
 device tree
To: Krzysztof Kozlowski <krzk@kernel.org>, Mehmet Fide
 <mehmet.fide@gmail.com>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
 <20261022070900.616265-9-mehmet.fide@gmail.com>
 <1410119b-e8b2-43a8-bf57-7db53be44eac@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1410119b-e8b2-43a8-bf57-7db53be44eac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h8qu1ak7czfihacp4y9ega9dj6ijmpby
X-MBO-RS-ID: 6cac86b361642d446dd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 12:52 PM, Krzysztof Kozlowski wrote:
> On 22/10/2026 09:08, Mehmet Fide wrote:
>>   
>> -	phy_addr = ofnode_get_addr(phy_node);
>> -	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
>> -		if (phy_addr == phy_bases[i])
>> -			break;
>> -	}
>> -	if (i == ARRAY_SIZE(phy_bases))
>> +	ret = ofnode_get_alias_seq(phy.node, "usbphy", &seq);
> 
> Just for the record, this looks like undocumented ABI which would not be
> accepted in Linux kernel, so you won't be able to use OF_UPSTREAM.
This does indeed interact with the enumeration of USB controllers in 
U-Boot, which itself is a legacy crutch to prevent the command line ABI 
breakage. It seems to resolve PHY node using the /aliases { usbphy = 
&... } which is already in Linux ./arch/arm/boot/dts/nxp/vf/vfxxx.dtsi :

  27                 usbphy0 = &usbphy0;
  28                 usbphy1 = &usbphy1;

Mehmet, would it be possible to parse fsl,usbphy = <&usbphy0>; DT 
property to arrive at the PHY node instead ?

441                         usbdev0: usb@40034000 {
442                                 compatible = "fsl,vf610-usb", 
"fsl,imx27-usb";
443                                 reg = <0x40034000 0x800>;
444                                 interrupts = <75 IRQ_TYPE_LEVEL_HIGH>;
445                                 clocks = <&clks VF610_CLK_USBC0>;
446                                 fsl,usbphy = <&usbphy0>; 
<----------- HERE
447                                 fsl,usbmisc = <&usbmisc0 0>;
448                                 dr_mode = "peripheral";
449                                 status = "disabled";
450                         };

I think you might still need the portnr sequence number, or could you 
get rid of that too ? (I would be fine with a follow up series too) ?
