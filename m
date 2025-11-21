Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5338DCFC294
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7391B83A43;
	Fri, 21 Nov 2025 17:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NXmpWPTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B9D83A3A; Fri, 21 Nov 2025 17:59:17 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240A983984
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dChJc71P5z9t3l;
 Fri, 21 Nov 2025 17:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763744353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDcRzYcyJB9Kbxg7/4iRyw1IUd1pwQV2YF1kw89dc7I=;
 b=NXmpWPThY+38DgU6OOpwkMBbyqGR3OmwWLarP03Pr/mvBZYPj62MBOwHKlsAK3H69bgIUc
 j7od8j6VLyVk8FnJ9RTewTnSgLFG8G2d8CudKxZeEpvcieiMZB9V/qHEU8OGIhUpyMaQN8
 c62wQhSHbV4ns6q15aerDBrFTzidvWAKZzEABw/Ahy7SKJoa9Ob9MXqvbpGZqMQaFG/n2q
 PHS/NcNXypzPRDerAoQ8a8JRV0CMZ3FmI3G4jaCMRYMVffbFkL7+qHgQkbnez3Z9kzYh8w
 iugyHOMC1xD6yfrvfJHWnn7Vzcmo8SlTDMqIc11MFKPSiK++9g3+dYPxOxAyXg==
Message-ID: <37dc033c-12e8-46af-9bdb-aa68b20c08fe@mailbox.org>
Date: Fri, 21 Nov 2025 17:59:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] test/py/requirements.txt: add setuptools
To: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
 <20251121143903.GY2125796@bill-the-cat>
 <d78a79c3-cd28-4270-941c-a500bdff5432@baylibre.com>
 <20251121164856.GZ2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251121164856.GZ2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kbi7i5zf97d4qfh1wu3cah7h4hh4fkme
X-MBO-RS-ID: 87369c4f91f9c0b5b00
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

On 11/21/25 5:48 PM, Tom Rini wrote:
> On Fri, Nov 21, 2025 at 09:56:59AM -0600, David Lechner wrote:
>> On 11/21/25 8:39 AM, Tom Rini wrote:
>>> On Fri, Nov 21, 2025 at 08:36:14AM -0600, David Lechner wrote:
>>>> Add setuptools to test/py/requirements.txt. Otherwise, attempting to run
>>>> tests can fail as follows:
>>>>
>>>>      $ ./test/py/test.py --bd sandbox --build
>>>>      +make O=u-boot/build-sandbox -s sandbox_defconfig
>>>>      +make O=u-boot/build-sandbox -s -j32
>>>>      Traceback (most recent call last):
>>>>        File "u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
>>>>          from setuptools import setup, Extension
>>>>      ModuleNotFoundError: No module named 'setuptools'
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>   test/py/requirements.txt | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>
>>> NAK. It's the build of U-Boot that requires setuptools (specifically
>>> scripts/dtc/pylibfdt), not pytest. It was dropped as part of cleaning up
>>> the test/py/requirements.txt file before. A top-level project
>>> requirements.txt file would help avoid these problems, but we don't yet
>>> have agreement on that.
>>>
>>
>> OK, I think I see how it works now. It looks like most tools have
>> a requirements.txt already, but dtc is missing it. Would it make
>> sense to add a scripts/dtc/pylibfdt/requirements.txt containing
>> setuptools?
>>
>> Then `find . -name *requirements*.txt` would make it easy to find
>> everything that might need to be installed for a given target.
> 
> Yes, I think that's a reasonable step. I think in the near'ish future we
> might be able to instead switch to just installing pylibfdt.

I'll just say, I understand that adding those setuptools into 
test/py/requirements.txt is not the right fix, but it does make me 
grumpy every single time I use pytest with U-Boot. So I do fully support 
this effort to improve this situation.
