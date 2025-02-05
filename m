Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F65C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 10:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23F280562;
	Wed,  5 Feb 2025 11:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738750813;
	bh=mJngBEJTlhJsjhiv3J7pIL6ASv0tR00jslAa22PmALw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Be9XF8BsV9xOBYDvZ3OzHhio6KwnLNWmpClvmL/vqleixo4IzrGhXOs3hqfzr9tFK
	 UYNTJESgcNs69HxoqkCd05npBNwq9LRxB63NOeyNNIKtT8MilqXaMGU5YkU04E2y89
	 tw/g82ZBMOs/ebYX7ufHesf6sw3hg5t42IdK6R3HkSlEL7n7sRxRoORnbt9sdWxg8u
	 9IzPwokc+V63ivYoo7YKWLPiGSAInvvaoykTV2VYwu6cc5QPZstnyM4upWNx1pPYzA
	 /gTEmhFyI0GHJSi9qToO35PB4TKUByQVz7+r2g1nnKLi4O/u6Ge21w9uFYutY1Fo5u
	 xbZTxRQ+aP6/g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B000805D7; Wed,  5 Feb 2025 11:20:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D1080207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="apKQ6j3X"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 83D3110382D0E; Wed,  5 Feb 2025 11:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738750809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJngBEJTlhJsjhiv3J7pIL6ASv0tR00jslAa22PmALw=;
 b=apKQ6j3XEmpraV6RrU9qVcgKvGKV4aDBfEZ4qrqJoFuqsqBr7LjvkyutwRTFYMsqlIIGBk
 X2L0TmAvCyZC8sSmiZhXgrzfEAhVj7cvsuIWEjl3nYxEg5xUYd4I1loTAFlOcrIQmkdhrN
 iir45OOeUeH2ZO7x68qcvJ7FCoypXRgTcNbrViySrxZPACrYqRpCwvtjLOuHPJHfnRJMZe
 J7acLfSdRY2MnuyHf2S6r/1lXJ+49/RhkYI2osPVvEM+3DzVDVU/ETYc4QJUeOwwpMvqcm
 Gj3twOTNVuamUF/yU+x+N3NZQRnztbEKxjRUpQj2g00sCbGY67xXnS8dEWcF0A==
Message-ID: <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
Date: Wed, 5 Feb 2025 11:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
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

On 1/9/25 3:10 PM, Simon Glass wrote:
> Hi Marek,
> 
> On Tue, 7 Jan 2025 at 04:24, Marek Vasut <marex@denx.de> wrote:
>>
>> On 1/7/25 4:50 AM, Simon Glass wrote:
>>> Hi Marek,
>>>
>>> On Mon, 6 Jan 2025 at 13:51, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 1/6/25 3:38 PM, Simon Glass wrote:
>>>>
>>>> [...]
>>>>
>>>>> I wonder if the cst needs to be updated (binman tool -f cst)? At
>>>>> present it is using apt-get and has:
>>>>>
>>>>> $ dpkg -l imx-code-signing-tool
>>>>> Desired=Unknown/Install/Remove/Purge/Hold
>>>>> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
>>>>> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
>>>>> ||/ Name                  Version             Architecture Description
>>>>> +++-=====================-===================-============-===================================
>>>>> ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
>>>>> signing tool for i.MX platform
>>>> Perhaps. Can you suggest a fix ?
>>>>
>>>> I am also unsure how to get the CST test to 100%.
>>>>
>>>> I still don't fully understand what exactly are these tests testing or
>>>> whether they are even valid.
>>>
>>> Well, if I could run the test and have it pass (like presumably you
>>> do) then I could suggest something. Could you point me to a cst binary
>>> which works for you and makes your tests pass?
>> CST 3.4.0 from debian/testing works with real hardware.
> 
> Unfortunately after much messing around I cannot install this on my
> machine (jammy). I do plan to upgrade to Noble at some point. But we
> cannot rely on people having a particular distro to build U-Boot
> images. That is what 'binman tool' is supposed to fix.
> 
> I got the package source and tried that. The build instructions use
> docker, which I have not mastered. The container needs curl but does
> not have it.
> 
> I was able to build it from source code without docker. Is there a
> public source-code repo somewhere, so Binman could build it?
> 
> Anyway, with this patch applied and the new cst:
> 
> $ binman test testNxpImx8MCSTSPL
> ======================== Running binman tests ========================
> E
> ======================================================================
> ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTSPL (subunit.RemotedTestCase)
> binman.ftest.TestFunctional.testNxpImx8MCSTSPL
> ----------------------------------------------------------------------
> testtools.testresult.real._StringException: Traceback (most recent call last):
> ValueError: Error 1 running 'cst -i
> /tmp/binman.t45m9_fv/nxp.csf-config-txt.nxp-imx8mcst -o
> /tmp/binman.t45m9_fv/nxp.csf-output-blob.nxp-imx8mcst': File not
> present SRK_1_2_3_4_table.bin
> 
> 
> ----------------------------------------------------------------------
> Ran 1 test in 0.151s
> 
> FAILED (errors=1)
> 
> So where is the SRK_1_2_3_4_table.bin file?
See the tool documentation:

https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags

3.1.2 Running the hab4_pki_tree script Example
3.1.2.1 Running the hab4_pki_tree script in interactive mode

The hab4_pki_tree.sh script should generate all those files.
