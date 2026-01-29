Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24259D73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 19:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D143840AC;
	Thu, 29 Jan 2026 20:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dgp4fT3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59917840AE; Thu, 29 Jan 2026 20:43:47 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F7984082
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 20:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f28hb17twz9thq;
 Thu, 29 Jan 2026 20:43:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769715823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMyUkPJeRcpUmCSeVl9Wvn9p6dApQcsYrv9Lkc35t+g=;
 b=dgp4fT3gdApuHVddIW0rbMwiTeQxxcqDAgarbEaxA+Prts3WEqXEh2eDj0B9gKs7c8/apc
 bGsoMwsZpoq2oqneumSn+zuWnwSanSw6BPpZ4sgMJBpIJx2CTy9pV0SOM6bq6kdtwqEFZS
 e6jB00SyLqAjP23pab/xfHHWBnThjGnztRfpPSaawkygBr3vtbVYAnhBlAXzCjBKndnIFJ
 b2WNJZD0r7cRE4TBtUFYKNT8bbin0pU59YwRaP+tmeX83fW6ZGB1l/7zJNskG2CJfcs0t1
 Weit+y8KBRxzmH9GfNMjLxWdXVLUUU4fF0/X45P2QvLfPHSW52tDmoBJOXogRg==
Message-ID: <12a8c1e0-a255-4805-85e9-281bd0da98ac@mailbox.org>
Date: Thu, 29 Jan 2026 20:43:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] test: cmd: Add test for zip/unzip/gzwrite commands
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <20260127235914.1503663-3-marek.vasut+renesas@mailbox.org>
 <87qzr8mlll.fsf@kernel.org>
 <c4745b73-c85a-4917-b47c-85c1acce2f3e@mailbox.org>
 <87ldhgmcwa.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87ldhgmcwa.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fxp1owrwhu1s4bn5b4kx4om4k7hudod6
X-MBO-RS-ID: b836f9ee266262b84b7
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

On 1/29/26 8:34 PM, Mattijs Korpershoek wrote:
> On Thu, Jan 29, 2026 at 17:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
>> On 1/29/26 5:26 PM, Mattijs Korpershoek wrote:
>>
>> Hi,
>>
>>> On Wed, Jan 28, 2026 at 00:57, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>>>
>>>> Add simple test for zip/unzip/gzwrite commands. The test works as
>>>> follows. First, create three buffers with a bit of space between
>>>> each of them, fill them with random data, then compress data in
>>>> buffer 1 into buffer 2, decompress data in buffer 2 either directly
>>>> into buffer 3 or into MMC 1 and then read them back into buffer 3,
>>>> and finally compare buffer 1 and buffer 3, they have to be identical.
>>>>
>>>> The buffers are filled with random data to detect out of bounds writes.
>>>> Test for various sizes, both small and large and unaligned.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>
>>> I've tested this with
>>>
>>> $ ./test/py/test.py --bd sandbox --build -k ut
>>>
>>> Followed by:
>>>
>>> $ ./test/py/test.py --bd sandbox --build -k cmd_zip
>>>
>>> And I see:
>>>
>>> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_gzwrite] - ValueError: U-Boot exited with signal 11 (SIGSEGV)
>>> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_unzip] - ValueError: U-Boot exited with signal 11 (SIGSEGV)
>> You will also need these four fixes, then it should work:
>>
>> cmd: zip: Add missing unmap_sysmem() for buffers in the unzip command
>> cmd: zip: Use map_sysmem() with buffers in the zip command
>> cmd: unzip: Use map_sysmem() with buffers in the gzwrite command
>> gunzip: Fix len parameter in function signature
> 
> Indeed, when these four fixes are applied first, the tests pass:
> 
> test/py/tests/test_ut.py ..                                                                                                                                                                                                                                                                                            [100%]
> 
> ============================================================================================================================================= 2 passed, 1464 deselected in 1.41
> 
> Can you mark these patches as dependencies of this series for v2?
Already did :)
