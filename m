Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA6AC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 21:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421BD846FD;
	Sun,  5 Jul 2026 23:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eMTMmUUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E54384832; Sun,  5 Jul 2026 23:26:05 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A69AB846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 23:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CA7B116F62; Sun,  5 Jul 2026 23:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783286762;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+5QFPHJ9MobA7QZZarwZehpwv3gEU5YbwfpSje1SbXY=;
 b=eMTMmUUbcSA0SD/rtbIv69Q/4EEitWY22nKi3MlH6W9g3ZOO894GHve/IgdnbyZW/l7QmC
 IZOisgD2C9vi8hjPzjeLhb23Qb+PeAojXUCwjvj9Uy0Zfpcnakq66zOC6m5Rl0W8Bdjm49
 9TbjLXYnAiGFPa2lkUVyohmd86O7texvHV37yU5+DIYto0+v6mLBXrRlnoJVXbYyWvEXbV
 fvP0zQ7Jz3eDIqF2QCvaZcdiojcPpaPZpZjqxEQDg2q0MCCx6h4vmjtELcrgj6j1/KlP7J
 IEPhMpMkl7FQwFR1XzIAY8H4qrlTHjmM6gh9nkWxUIsESWxw1XOEmgnfwGxsJA==
Message-ID: <b087280e-ae59-4852-8212-72866fa46584@nabladev.com>
Date: Sun, 5 Jul 2026 23:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260630084112.13259-1-marex@nabladev.com>
 <CAFLszTgCOOOxhgP3n7EXGK4eMWNmmiFyCtc6mKNGmCinRYZdDA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTgCOOOxhgP3n7EXGK4eMWNmmiFyCtc6mKNGmCinRYZdDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/2/26 1:13 PM, Simon Glass wrote:

[...]

>> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
>> @@ -59,10 +98,52 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>> +                # 0x80 ... lookupTable
>> +                spidata += struct.pack('<I', 0x0818040b)
>> +                spidata += struct.pack('<I', 0x24043008)
> 
> Just to check, this LUT is a single-pad fast-read sequence, so should
> we mention the fixed read command? E.g. if a board uses quad pads,
> what will happen.

Can you please rephrase this question ? I cannot make any sense of it.

[...]

>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>> @@ -8101,17 +8101,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>> +        self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
>> +        self._DoTestFile('vendor/nxp_imx8m_fspi_pass.dts')
> 
> Since binman now generates the header itself, please can you check the
> output data in the test, e.g. verify the tag at offset 0 and that the
> mkimage data starts at 0x1000? That would have caught the padding
> problem above. Also please use assertIn() on str(e.exception) for each
> failure case, so the test confirms the expected error rather than any
> ValueError.
Sure, if you can provide actual comprehensible example, I can add that.

In the meantime, I skipped this and sent a V4.
