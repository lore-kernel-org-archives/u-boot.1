Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4FAC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C4380B7D;
	Mon, 17 Aug 2026 16:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOWVOonYHnAH; Mon, 17 Aug 2026 16:02:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41E2B80E34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786982555;
	bh=gBXPso78gwcrMiENyhFZ0NaisFZyOGLrNI3a1eXh7Rg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cI8rDtpdRxlNGly92t0fZMwCnoiBgei2BfPit0IW30iy1/Ig2xtami7+eT7Ao/aXV
	 5jMgTalo/Gaw7VcxuBr5bIyChqdYYlMxnvg4hXbznNseStbNE1DYy0tzYKjHjHu2LK
	 oqpClCmIevOivkAVnsqFbzvbIHOZnNs41Va39A/GYNQCaX8uWn/9UdJDmYoQFWWxxQ
	 wBDKZIh6ywNr9wkodyaTVdMreGjLl3qUmxHJ6XR5gRpZFSY65DcjUIQddWVbdz2fBY
	 JMy6T0WnwSZ+iu9gHOxFWivOx35DPKIbpbIGkjSLEOUUIrPScx2uPMCM/VIvRa4P5y
	 YNecCssafZejg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41E2B80E34;
	Mon, 17 Aug 2026 16:02:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13F8C334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED99F40791
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6DshVu29VEo for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:02:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 148A240744
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 148A240744
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 148A240744
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:02:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EDA834E4128F;
 Mon, 17 Aug 2026 16:02:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B87D360352;
 Mon, 17 Aug 2026 16:02:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED49F11C738DA; 
 Mon, 17 Aug 2026 18:02:24 +0200 (CEST)
Message-ID: <30b11514-c610-47d0-a8d3-dea46f6a7534@bootlin.com>
Date: Mon, 17 Aug 2026 18:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] doc: imx: ahab: add i.MX93 secure boot guide
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-4-0c3c78020d03@bootlin.com>
 <CAFLszTjJ7ztxWuoTED2G-oECz8NoxPFmhOThTS0ifvrk7ER_Ww@mail.gmail.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <CAFLszTjJ7ztxWuoTED2G-oECz8NoxPFmhOThTS0ifvrk7ER_Ww@mail.gmail.com>
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On 8/14/26 23:23, Simon Glass wrote:

[..]
>> +See the introduction_ahab.txt document for the PKI tree generation
>> +procedure (ahab_pki_tree tool) and for the SRK Table generation
>> +(srktool, use the SHA256 variant for i.MX93).
> 
> Just to check - the default key material the etype uses is
> 'sha384_secp384r1' (see KEY_NAME in nxp_imx93cst.py), so telling the
> reader to use the SHA256 srktool variant looks inconsistent with what
> CST is then asked to sign with. Can you confirm which srktool hash
> flag matches the shipped default, and align this sentence with it?
> 

I'll probably remove this mention, as I don't think it's really 
necessary, but to clarify, there are two different checksums at play here:
     - The SRK table checksum: the i.MX93 only supports SHA256, so when 
generating the table with srktool, the user must specify this algorithm.
     - The signature/key checksum: the i.MX93 supports multiple key 
algorithms (RSA, ECDSA, ...), each with its own associated digest.

So in my sentence, "use the SHA256 srktool variant" refers to the first 
case, whereas the default key name ("sha384_secp384r1") refers to the 
second, i.e. the digest associated with that specific key algorithm.

Best regards,
Jérémie
-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

