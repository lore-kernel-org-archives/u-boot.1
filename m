Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889AEE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808A4801E8;
	Tue,  7 Jan 2025 12:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249092;
	bh=fpbgGuiu2bJQVjRNa2c429QBjOW6P3NCNGPj0kbFrzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVDJMsqK8ZjE5cUcnvnJ410Ns6a8ZG1dslR9d122r6T/iIJE0I/Zgh9opqTdqEYiD
	 Xq7qzJrlYY945DPMhoq+fXXiO7SHmXPf7egjxJWE0uYFGvugHLbhyhc0e8lyTykHiO
	 fkqy3MHO+EvXqwi4Ct1mLaefpxrbKSo985hJ/AsHMaH/H/aemjOB5VNgAt/ljxM6EF
	 SwMNRnNJ6sU/4Oee0n7qUh/8Lln1TrQAEIsky7BfyNWgH9wYq2wNHBPdhzLUMHrMJb
	 L2E1sjli71rotfdmRtg9KnLxrCD+M2HgRlL0IKQodpZ/u3STbFaMWiDTo/kEkE0I1f
	 ja+wMOWtfEk7g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA7B801FD; Tue,  7 Jan 2025 12:24:51 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F85801B6
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hDfffxhS"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51392104811F3; Tue,  7 Jan 2025 12:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpbgGuiu2bJQVjRNa2c429QBjOW6P3NCNGPj0kbFrzk=;
 b=hDfffxhSe3yuHy4adKZRxHWNkhFj7pp/GujAGctrAhCpCXAZm2yW8zD/F2+HBJGzi/PgQu
 h/ZPkiMPax35MAt397vaPv0JGFw/opPMrwMSPNQ5l8CgDg+y8SnP5l1XgRCNdIPwmF3c4K
 SIx4+3gkuEsNBq11WZ3ldhQ4np42BKYs4elkfUgjPcJehwSWMNaHzVXeb0Bu21XjbcmCbX
 E/29UWY4Ys/eJFIZB2lx7Cy0CQ1NdlXP1hh73fMqolnmR82fhSto1zJgz6xiYoGmJx/+jU
 hF/e80hT8njewRPgtZD6IE2k84Yxas3T7EKgBhxxkAzH7zkwnbHNPOjbvhVdnw==
Message-ID: <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
Date: Tue, 7 Jan 2025 11:39:55 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
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

On 1/7/25 4:50 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Mon, 6 Jan 2025 at 13:51, Marek Vasut <marex@denx.de> wrote:
>>
>> On 1/6/25 3:38 PM, Simon Glass wrote:
>>
>> [...]
>>
>>> I wonder if the cst needs to be updated (binman tool -f cst)? At
>>> present it is using apt-get and has:
>>>
>>> $ dpkg -l imx-code-signing-tool
>>> Desired=Unknown/Install/Remove/Purge/Hold
>>> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
>>> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
>>> ||/ Name                  Version             Architecture Description
>>> +++-=====================-===================-============-===================================
>>> ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
>>> signing tool for i.MX platform
>> Perhaps. Can you suggest a fix ?
>>
>> I am also unsure how to get the CST test to 100%.
>>
>> I still don't fully understand what exactly are these tests testing or
>> whether they are even valid.
> 
> Well, if I could run the test and have it pass (like presumably you
> do) then I could suggest something. Could you point me to a cst binary
> which works for you and makes your tests pass?
CST 3.4.0 from debian/testing works with real hardware.
