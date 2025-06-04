Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA69C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 15:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881768006D;
	Wed,  4 Jun 2025 17:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="V8EWpGxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C91D80584; Wed,  4 Jun 2025 17:07:03 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB79B8004F
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 17:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8250fb800b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554ECtla014517;
 Wed, 4 Jun 2025 17:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 xVsfdyy9zTvtGRsWTfOv8o9Yiiey14qPYk+JDzIdzsQ=; b=V8EWpGxEejcbVpH3
 sLTVWbuisiQ40bGgPnO7Coob0c+IxEV7c/5nJ/EIlsC2SMBdHRmUSIHwris15SHe
 1UJsXuZc/Z28GjHRFGIsr2qQmoe4BtiEXR1KbHTal+OgmXmjfrziP6Wa02GcMUkP
 Vi2g5ye9fkUgAhYI4ANDCK+SvvIcbskwK31KGR0NSbKsZp12VBKYzj8dFAdE+ASV
 vDnT6RRFmAcjeioEJwy+zGzVP5w7/datnaTDSIB8lCDVLq/vcplu4E27ctMC9MZb
 bmkaramCZeoYIx61Qm8C1VrN+OcyxuCTMnE+czPUy0U9KAXwp5GbNLNWN6ugFcE8
 OdqQ0A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8vaax1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 17:06:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AA1054002D;
 Wed,  4 Jun 2025 17:05:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 335D3B272BD;
 Wed,  4 Jun 2025 17:03:46 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 17:03:45 +0200
Message-ID: <6c8b029d-a4a0-43e6-a229-89c6f0583553@foss.st.com>
Date: Wed, 4 Jun 2025 17:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
To: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, Raymond Mao
 <raymond.mao@linaro.org>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Adriano Cordova <adrianox@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>, Sam
 Edwards <cfsworks@gmail.com>, Prasad Kummari <prasad.kummari@amd.com>
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
 <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
 <DADNW2131HYB.V2UGC24FOJJO@ti.com> <20250604135612.GN1382132@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250604135612.GN1382132@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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



On 6/4/25 15:56, Tom Rini wrote:
> On Wed, Jun 04, 2025 at 03:33:31PM +0530, Anshul Dalal wrote:
>> Hi Raymond,
>>
>> On Wed Jun 4, 2025 at 2:30 AM IST, Raymond Mao wrote:
>>> Hi Tom,
>>>
>>> On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
>>>>> Hi Tom,
>>>>>
>>>>> On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
>>>>>>
>>>>>>> This patch is to solve the sandbox building error:
>>>>>>> $ make O=build-sandbox -s sandbox_defconfig
>>>>>>> $ make O=build-sandbox -s -j2
>>>>>>> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
>>>>>>> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
>>>>>>> collect2: error: ld returned 1 exit status
>>>>>>> [...]
>>>>>>>
>>>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>>>>>> ---
>>>>>>>  arch/sandbox/config.mk | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> OK, but how do you get this failure to start with? What host?
>>>>> It failed when I started any sandbox unit test like:
>>>>> ./test/py/test.py --bd sandbox --build -k <any_test>
>>>>> My local host: Ubuntu v20.04, x86_64
>>>>
>>>> We don't see that normally, is there something odd about your compilers?
>>>> This is the kind of thing which should be failing everywhere, but isn't.
>>>> Thanks.
>>>>
>>> This failure occured in my host since v2025.07-rc1, but with the same
>>> host, same setup and same instructions it worked fine in v2025.04-rc5.
>>> Seems that some impacts were introduced during v2025.04-rc5 ~
>>> v2025.07-rc1, which might be worth investigating.
>>>
>>
>> I am unable to reproduce the issue on gcc 15.1.1 and glibc 2.41. I think
>> the issue is likely on your host end.  What compiler and libc are you
>> using for the build?
> 
> This feels like if it's generic, CI should be blowing up too, even if
> it's Ubuntu 22.04 not 20.04 these days. Please bisect down to the
> failure, since you have known good/bad commits and 'git bisect run' can
> use the test case you have.
> 
Hi 

I got exactly the same issue on my Ubuntu 20.04 when trying to compile sandbox.
b989f9ed9fe1 ("test: lib: add initjmp() test") is the the commit which is causing this issue.

Until now, i am still using the default gcc (Ubuntu 10.5.0-1ubuntu1~20.04) 10.5.0.

Thanks
Patrice

