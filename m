Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09DFFF4927
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 23:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D545883B48;
	Mon, 30 Mar 2026 01:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ipnSqydE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646AA8403D; Sun, 29 Mar 2026 16:25:52 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF1184011
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 16:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 37A7810E855; Sun, 29 Mar 2026 16:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774794349;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8ZyRv8SVq140r9d7O2Tkp7N+hM9csT/7MCKFnu1npgk=;
 b=ipnSqydEoSGOK0Om9MmlD4kYF8ckVAhvhHIL+EjLyvUBpWRHBgAL3p/tJGhCX3jE1hKf3B
 Z3LIolFbl0d60yjXh3vvdcBNRVYH5XumU5h+Wx53fhkoNtQ9ifXaapnNUDnW6JVUjLsVo9
 Ns6IeS2PDRvPf+ibuzNMy0sm8Mbd34w2HWUSKi2jMgZ5u7nilHxy5RWy/FGqxkK6SlLYg9
 H+cK+VYVgRlz2JIqMGToM1rlOfXxz9m0z+pcas9vrb6OIMgEvn4GanCjOVYsPNJU4sWjf1
 RsVSIgHkLe3iGyG/xW2HwKO0Z9eZDkBfopQMcpKqrIfdv4YiLjgsUFRHIaIUJA==
Message-ID: <9f5c1c47-410c-419c-b272-2a44a0e4a4d9@nabladev.com>
Date: Sun, 29 Mar 2026 16:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binman: add CST backend selection for i.MX8M signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260321195238.174658-1-marex@nabladev.com>
 <CAFLszTjdv78kSfFwBXxGq=wxP7y-bc4O_8jDeVTtQFtLct4L4Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTjdv78kSfFwBXxGq=wxP7y-bc4O_8jDeVTtQFtLct4L4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 30 Mar 2026 01:10:37 +0200
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

On 3/29/26 2:09 PM, Simon Glass wrote:
> Hi Marek,
> 
> On Sat, 21 Mar 2026 at 13:52, Marek Vasut <marex@nabladev.com> wrote:
>>
>> Add support for setting the CST backend, both via DT property and
>> CST_BACKEND environment variable. The CST currently supports two
>> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
>> CST tool is invoked without any -b parameter. Keep 'ssl' backend
>> as the default, but explicitly pass it via the '-b' parameter,
>> unless the user selects 'pkcs11' via either method.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: Fill in documentation for all used DT properties
>> V3: Fill third copy of documentation into nxp_imx8mcst.py
>> ---
>>   doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
>>   tools/binman/entries.rst                      |  7 +++++
>>   tools/binman/etype/nxp_imx8mcst.py            | 19 +++++++++++-
>>   3 files changed, 44 insertions(+), 12 deletions(-)
>>
> 
> This is missing coverage for line 177 of nxp_imx8mcst.py:
> 
>     cst_backend = "pkcs11"
> 
> Please can you use (or mock) this feature in a test.
I already invested a lot of effort into binman tests before in [PATCH] 
binman: Fill in most of the imx8mimage and imx8mcst tests and it went 
nowhere.

Can you provide (an example of) such a test ?
