Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FEC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE608091A;
	Sat,  8 Feb 2025 22:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739050027;
	bh=8g4kHWben1J0zDszyxChxbfbyVS1/Y5bUDDchY16tdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gPJGOy9KlnCri65iwr031pz3FNH/4i2sNTu88DoGjAvugAjoZfsv2+DVKp5Qx3yGo
	 zQ204DM5Pz22XjyrK1sk7vtjn2ZkWVlYSLvoO2nzQNLz/tpNtAA7z5UkHbw1C5jU61
	 T4EHr9UgnBQzVuQfFoLq7OVww7nLJhhGRh4Z7qsmwtM5HLZJ+qj6iAb4lfcd3Du542
	 AQGYHtjtCIKo3nJyzBHLPkr81zt5yVIFpDydgfOee0keUPChxpefzkgQ+QJCaH6a1O
	 LhXFF+b3yEPz4G2PVxslsakkDz0ImhOuHCsnMBUxX6IPU09hDhnt76tX71CplcjI1l
	 wO5YakkZlLXFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2188092B; Sat,  8 Feb 2025 22:27:06 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A6C68091A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="b4Z3QDof"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 754D2101FF371; Sat,  8 Feb 2025 22:27:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739050022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8g4kHWben1J0zDszyxChxbfbyVS1/Y5bUDDchY16tdg=;
 b=b4Z3QDofHIC1F7Pb6kp1V+qwz3vvjUBmRRGL2xWILBiiNby+4Gn4xfdY0LFmRBMjQcJJnq
 xiKomxKpYIGCxLTkGuPsx67cZSFxE+Jf+LsZR10VOBTBPaFLOrSIkvtPjUrCQ8CYrfYizR
 Z2sB5UjV0RteTBHaclfDVq4AfVwZjaQVold9o5cF0rVAbYfHK9Vhesu9folU/NwNAlv7Tu
 kp3S9VrGxfIPioPMI82/DH9OlmkkXGUGFv3g+oNoDGdLCU0u0wYSlEvyHVNyrdQNx1pBFX
 rNUNt0CEkUw89zUmaK2KWFE2JTn7nLE4YboHTqWy6CyDHLgaYv5yL4jwf7BSFQ==
Message-ID: <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
Date: Sat, 8 Feb 2025 22:19:16 +0100
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
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
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

On 2/7/25 1:49 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/6/25 1:42 PM, Simon Glass wrote:
>>
>> Hi,
>>
>>>>> FAILED (errors=1)
>>>>>
>>>>> So where is the SRK_1_2_3_4_table.bin file?
>>>> See the tool documentation:
>>>>
>>>> https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/blob/debian/3.4.0+dfsg-2/docs/CST_UG.pdf?ref_type=tags
>>>>
>>>> 3.1.2 Running the hab4_pki_tree script Example
>>>> 3.1.2.1 Running the hab4_pki_tree script in interactive mode
>>>>
>>>> The hab4_pki_tree.sh script should generate all those files.
>>>
>>> But with binman we want to avoid vendor scripts, etc.
>>
>> I believe the script internally runs openssl to generate that file.
>>
>>> Could someone take a look at updating tools/binman/btool/cst.py or
>>> similar to build the tool from source? There are examples of others
>>> that do this, e.g. bootgen.py
>> Is this relevant to finalizing this patch ?
> 
> Well, I don't see how the tests can pass if we can't build/run the tools needed.
Maybe you can try to use the shell scripts to generate the missing bin 
file ? I suspect the script does some openssl invocation, which can be 
reproduced in binman ?
