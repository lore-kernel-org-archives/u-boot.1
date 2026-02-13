Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930ADEF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5F783E13;
	Sat, 14 Feb 2026 05:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BFFe7rde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E55183CF2; Sat, 14 Feb 2026 03:51:21 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5568F83AAB
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 03:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3361E10FAC3; Sat, 14 Feb 2026 03:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771037478;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=wGkhxBVy/G76Fsgs80yTYZvpHeSXQom+u/ZnkNDZzDs=;
 b=BFFe7rdeF/Kpb8NQwFgPQnDRYRiz/fFS/wH2IQF82CyWeY83o4+32jH0XRxBO6C0WKrTlK
 VYgmc75NpU4rHIQEVEAMYFier9lSifTXhAp7H5+ZgbuerY+fJK12vwcqMMMiafJ/hnXNCa
 ArUsnZVh7lVemWP3fa+VYQLpGgEzCShmKCwO6kQzhBGazMD4+rDGnbSSsSocNflCJr2SuC
 d+1u+ulqXSGz1k23q4/HxoeSkkifs35o2pC9/TTEPFJarW7P+I60bwwMthDf2hfWcTEDPZ
 AetkNEky7q9uvFW7q4vx3Ou0WhvNEg0R3Bzhl3Fom5D7e5b/LUtzi6jF/vEx1Q==
Message-ID: <8d5ea1fc-6dc3-43e1-b90b-8f6a1de0818c@nabladev.com>
Date: Fri, 13 Feb 2026 22:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: add CST backend selection for i.MX8M signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260213001212.157033-1-marex@nabladev.com>
 <CAFLszTi1M=J6+R1CcAJRY4gnQa87ScFkQ-YOK+NWzsB02VKnwA@mail.gmail.com>
 <481a2418-4a4c-411c-8028-db7c5c4c243f@nabladev.com>
 <CAFLszTj0PjocZLL_3VSP+ckDKW57j99jPbZ3nmUKdA-M3-juFw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTj0PjocZLL_3VSP+ckDKW57j99jPbZ3nmUKdA-M3-juFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 14 Feb 2026 05:59:31 +0100
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

On 2/13/26 9:20 PM, Simon Glass wrote:

Hello Simon,

>>> This should be documented somewhere, likely in the comment for this
>>> entry type, so it ends up visible in the docs.
>>
>> I will send a V2 with documentation.
>>
>>> Also, this code path will need a test, please.
>> How do you propose to test this ?
> 
> Extend or copy one of the existing imx8 tests, perhaps with a new .dts
> - and I suppose set the env var and see that it works too?
> 
> Note that imx8 has basic test coverage but there is quite a bit missing:
> 
> tools/binman/btool/cst.py                                  18      4    78%
> tools/binman/etype/nxp_imx8mcst.py                         89     69    22%
> tools/binman/etype/nxp_imx8mimage.py                       38      6    84%
> 
> I shed a small tear whenever I see that :-)
See [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests .
