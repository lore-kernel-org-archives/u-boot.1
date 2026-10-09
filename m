Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29470CA601C
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 10:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ED1F4076E;
	Fri,  9 Oct 2026 10:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2j6AqRR5f77s; Fri,  9 Oct 2026 10:27:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1831406EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791541657;
	b=c7iTMF62I5k7uUVkano4bQYEcWlR/w1h3W26CyjdnjfAuZkIgt9VgT1Ut33ZcyYOpFoC
	 trZ0x9wQEwk8nrZUgYa6Tj5xssKpCmY2JL7Tcgv6Ok0HWzI+IzxA+FFUL29nBV09jtYmU
	 vVitay5o8lwtKYj10SSfNGY71kZuhYyOxjabxVEWTTT2OEIVp20zh0pnttSX2Vi0wwNMt
	 hzmtltoOgrUHNtUWiFNulQs7e2dG+puVvvzzxLO4agmCfgO9vJeUho86DrcsWCDywSyfb
	 +wywN6sWKM+NOQ0+Pzx+ePEs6CbdsyquJWIgDD+uCkhqcbyJcVM8iMWmHbP5TqKMY0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791541657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r0doIniwZr4MSuia7lIPKXrqZ4tdqBaOaqJ+UmqP3Gk=;
	b=CPTn+v7jDD4Wgj6mfdtf0X/ZBICu/zbjOnbPjqdKL8NvdMxXdYj3cLQYt++zWWS/niRL
	 FUKnuc0fP2mE4PWmt7U5v28FBQXl+wPXsj6BoEbM1wzPpXk9eYZQYlIkqQteGRLqK6zQ8
	 ii8IMklvrM36r7LBKCYtnd0UQ29bIyP8DH8cz1uAeWjD4n0f321VrYT4ey3AeYcWfYSMu
	 tyPniiyHJCpGVzSkO5Y1W8X8gukjjCXH2Oct98NK58Oi21TXMpJqLUe7N7/rhcuLwVNwx
	 SqqkbcxypLiiPjCbd24sIbnt7+2f9kdYWxsINUdWsWDKJAMnraI8CDJeB7DgqOkK6nQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791541656;
	bh=r0doIniwZr4MSuia7lIPKXrqZ4tdqBaOaqJ+UmqP3Gk=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cnEuUx9selO5zdW8OqT4hfUjL3+EVDPhOVYkvScJTFkn7r57ANqIM0I7uLld0nx1t
	 wXdVISjD2WZ/gJFo77XLFdYI5V3GGU1K/X0yc4v6zgw9ifXP6av/786MIAn79y/tN4
	 fho0HyKaIWot8ocdXFFaQ9o5gWCAC+CUAUB3PPGF4pFW3YKwlubzfb3/KMueZaGT78
	 mr3jxjLjhHV1zYL6ljoNsDykY1ucWyxLbdzAg3n3GGdK2rJ+BXfzR9jFzmgiSsdSho
	 6s1c6W7E1U1NnTV5pAyOQxiGFZACYyC2DGRWyTTqDs9AOtOGlYt2yywoCDVP3sbiOZ
	 Rgr92dKXvLDpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1831406EE;
	Fri,  9 Oct 2026 10:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF4D375
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1882400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90-4EkJAjsmg for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 10:27:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD74540061
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791541655;
 b=pk60dumySFtRf9fdOIxOGMs2bmfGsxvIUXtrGl2DATy5I7+hJwEpWTLQRcWyB2/4FzvK
 ngBo3NzjuDYEPSCjNrF7HLf6UPiDL80vC2tuD6GlfUlE6hVEnYA5CrtlzCkOMonfv/Qzu
 aDHtatGKmU5a/7znD5dEpwtfIBIjbhDiLpcHVIQoFhdLWK1chsqFQ8xYj5SxbyYvKuhQz
 UHdFA6Bn7wy8+cXTL+8Y4OZACyGV3RXvY0QcZLw9vLz+s2UoPx2kwZC58a3NqPddS+Dtw
 UIKXDYV87k+U0bbvu2zYLImu/N9RMuzZyHZxtqvZ2aKT1/eB0AlDwWmOaS7oLm7WWCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791541655;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=r0doIniwZr4MSuia7lIPKXrqZ4tdqBaOaqJ+UmqP3Gk=;
 b=QxS6w9r0eWeguuMwJWMpd3kJaKaqJuMu4P+6C2r5oosrYBg5CJ51wlLAvFYjBawPD8nc
 tLYyym1DDHu0lSGd1enw0Bfvi+HXzJFEcH76I/m+PLX3S3cGkuy+ZVe2VufTRsuk6JXRt
 RrvIHsZ0sDQaxVaRCy7BnMjMvN4K4jYDKYAPbkRLDdQ0Q5kBfWn/e2MuRz9HxbePTFFEG
 qj3dfOkGZPEShEVMEsnk758Jv9bo8uy/EMnWGtkzOG4/XBJjC7QF7x/YoBKrchw0zVbdE
 xgtlT5HibDpWIn958REmdv08VmPRSxz1uLsR1vuoGQOovFkFRDaD4R77iS7Z7ocquig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FVUwCPKo; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=FVUwCPKo
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD74540061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:27:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FF2C105BD9; Fri, 09 Oct 2026 12:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791541647;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=r0doIniwZr4MSuia7lIPKXrqZ4tdqBaOaqJ+UmqP3Gk=;
 b=FVUwCPKokfB45iJclTyUNaj9VTdp1osvgWCk9R7R8jGxMC1+L8nOnHacgVr5jOTNytqDrR
 AayF7nSWgcdhTThmH0vDM/X796WMStsQYdCjzM+srO4XKehlO9mVQuDON9c6Z9KsalKGbk
 MdA/f0iOur2sYwvxyX6oQIyZZrAvPn3pHOB45A3Bo0LJL78iSKEisJ08WMchsSCQ2nG29m
 vs+3LYelCI1zB7gP5JxUQJwYDhapfctk5o3I7MLwA4infLh28K13+lmy9sCoTT6+CIb24C
 +8Wf9ufNWt/a7WvqpUJeHBSuj3S77SWHESCWY8SAQf1xDuEnbvsyooxuOIDmfQ==
Message-ID: <d359b286-93b1-6b2d-e86d-70b2cec2869a@nabladev.com>
Date: Fri, 9 Oct 2026 12:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260918025347.1839402-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: npcm: Add segment feature for bus select
In-Reply-To: <20260918025347.1839402-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Jim,

On 18.09.26 04:53, Jim Liu wrote:
> Add segment setting for bus select
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>   drivers/i2c/npcm_i2c.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

After fixing the checkpatch warnigs, applied to u-boot-i2c

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
