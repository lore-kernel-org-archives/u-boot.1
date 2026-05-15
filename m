Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA2CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF32784713;
	Fri, 15 May 2026 23:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="labb7VUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F41846DE; Fri, 15 May 2026 23:59:46 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6281A8484C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-90d665407baso5235685a.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778882383; x=1779487183; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cWgETKwPBhkfKC/bp8ZhmhCXh1mVNu7krn1NSPYcG4Y=;
 b=labb7VUINoG0zTQ9o8vJ2CbPRaGHJZriQyWK1R215/PSd5hyZa5wvyKLYNJ61Gxnz5
 i6rom4hkPDaBIHirB/v7ZXOUHd9aSJ5aA4pGaeC7ax5I0BtSDCLG5wYi846zQo1Vo7J4
 9JVacccMPhhGoO+NDI4TGCq/WJfjVugb6gwYIi4qm0ARswfKxYmuRJdKaomojux17KwT
 JXTc1NxxZ66YB4K5De/DND6PsqvJ01Xh7v1lp6C+pLbRtPKgXGqLeXLZreyFnywUtuAE
 gIWLfytXGNWQAbtkqnCjTVoGpPFepQQlRbIl3RqkDmUVWNta4/Jwp7RTmsnImWQxangz
 pmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882383; x=1779487183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cWgETKwPBhkfKC/bp8ZhmhCXh1mVNu7krn1NSPYcG4Y=;
 b=BgBivkjLkvWZPiF5Qzjf8ubYbX3i05ukXx4e49lVm5LcGDKMF9jnOwxXQlgipsvWjk
 i5ak6uVeR2iQOToj+5KM7heFv4HbRBwmkbrsnfxCxzyi/khZzRgWwCNpyTKP14IywLWN
 6TJM1x7J7W4X8kPJb0bXYvkDA/Z43lNSDrCwktHKoTfr3a4G7wzjliy5IQhubkJxXR82
 1nz2NQp+j2vSUJEnhVj31oPbdWDa3BMer2kliYa1DEfobl39Kw+DZNAXNCWidO6hp5DJ
 eg8UPWXXWstnelUiS/0D/XjW4T1xlTU4xcyGVZ43QgXFehqasSH7SiLz5FJJ1my7XDUP
 /geQ==
X-Gm-Message-State: AOJu0YzU1Mpgi1PJZarN3C+mzzjecwsL1wHR1runvYX9y+Ro6U5Wjymx
 1OfZwrJTwRaECEbZssYu3JGXrF8wiu+0UwHGbke/l5jwwiR3r1xHCt85
X-Gm-Gg: Acq92OF6VotX9uJlrOLvH4M0437FMvScK7+BMYsUHRT+l+coS1V1IU2+ewWiUmChTV2
 ADg7IMeAiR4HMaL1nVRbWzIm3SjlZNHfid9CJgtacUX8SDl6VgwIUuJyxncSodTZ5z6+Asd9CjU
 WnaYMiEnjVzUSXq/TZOd4btOaiNgafDEPCFZYfGB8DQuLH8Qy11KnmDVTITf5XFQRAhMdRqg23A
 tYBf7hdCLS92YTO92zeMA26UkSIE7T5AMVqxlnatF48SgU2Fqjla5/eYTCnKrHg/ciLReoRfUJP
 +31hH3dY1KH6nVLvbK2c6Ik4DjMXc1oTzrQH5SV50zh8LH6yI+uLg7ASbzN0zHgoUFbDV1dRx2T
 8OPlhf8EnOq+23tG+8eHpzS3+ZT/93DjsCVh6KN3YT4AFTLGNA0qxWSYiCR+D6SBngjDNRGAc/p
 Ip70sbvHkTO814gogw6hXtviwdIDO7aY5jvhvQrrgVtSu4BOnVt7C26neuldvKU09hh4A=
X-Received: by 2002:a05:620a:1997:b0:8ef:2118:aecd with SMTP id
 af79cd13be357-911cae1542emr634320585a.0.1778882383050; 
 Fri, 15 May 2026 14:59:43 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83bbf5sm672516285a.28.2026.05.15.14.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 14:59:42 -0700 (PDT)
Message-ID: <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
Date: Fri, 15 May 2026 17:59:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>, Daniel Palmer
 <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515214305.GL1858239@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260515214305.GL1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/15/26 17:43, Tom Rini wrote:
> On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:
> 
>> We have had getopt() for over five years but it is not much used. It is
>> much easier to understand arg-parsing using getopt() and it avoids
>> common errors. As the named maintainer I decided to look at how to make
>> more use of it.
>>
>> So this series explores the impact of converting a few commands to use
>> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
>> anywhere in the cmdline and provides a few helpers to reduce
>> boilerplate.
>>
>> The chosen commands are:
>>
>> - echo: very simple with no flags
>> - hash: fairly simple with just one flag
>> - env grep/export/import - fuller examples
>>
>> The series also adds a recommendation to use getopt() for new commands.
>>
>> To try to reduce the code-size increase, a lower-case function is added
>> and called from a few places. The difference is fairly marginal.
>>
>> Overall, the result is not pretty (see below) with about a 1.1K size
>> increase on arm64:
> 
> I think that means this is a no-go, and you need to work out what might
> lead to a much smaller growth here.
> 

Unfortunately, the only way to get a size reduction is to convert as many
commands as possible.

--Sean
