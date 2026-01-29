Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A8ED73E84
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 19:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00C5E840AE;
	Thu, 29 Jan 2026 20:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KXZJp/2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E100D840B0; Thu, 29 Jan 2026 20:34:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A383D84082
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 20:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 164FD4196A;
 Thu, 29 Jan 2026 19:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD30C4CEF7;
 Thu, 29 Jan 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769715255;
 bh=fLA6XLwCMCW9OTetG1S0UX9F59TvOli0qmxb8Zbpp30=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KXZJp/2TRwkPmOgfgRinTYxkLvTbfYIENWmdl5n5jdKj4zUfI25QhvpZNVDVKj8mS
 1ENnwMcD/AyOgt3mMefb97M7XNtKmapmbwpR2EVlIb5+E0qxZ+QwxxL4iRItAgpRsJ
 z6G6LMw9LZWhQ7q7AhoFEB5b6gNDk6wVGtaGB72hghHbfOktbeSHT5I91lZlssnyPF
 9fR6YWc+YfXBEZyKs6pxiT7swGU/Z7aPoAlVPnNFo+liVDv4HMnq+YGrd9aAQNRs3W
 unBAiRkzQFuClz5WwePC4uzCgePYnoDBAK6ApfGUGflPbxlX2NVUhl0LEePgXJ9KoT
 nVCvb8JasD6fg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 3/3] test: cmd: Add test for zip/unzip/gzwrite commands
In-Reply-To: <c4745b73-c85a-4917-b47c-85c1acce2f3e@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <20260127235914.1503663-3-marek.vasut+renesas@mailbox.org>
 <87qzr8mlll.fsf@kernel.org>
 <c4745b73-c85a-4917-b47c-85c1acce2f3e@mailbox.org>
Date: Thu, 29 Jan 2026 20:34:13 +0100
Message-ID: <87ldhgmcwa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jan 29, 2026 at 17:31, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 1/29/26 5:26 PM, Mattijs Korpershoek wrote:
>
> Hi,
>
>> On Wed, Jan 28, 2026 at 00:57, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>> 
>>> Add simple test for zip/unzip/gzwrite commands. The test works as
>>> follows. First, create three buffers with a bit of space between
>>> each of them, fill them with random data, then compress data in
>>> buffer 1 into buffer 2, decompress data in buffer 2 either directly
>>> into buffer 3 or into MMC 1 and then read them back into buffer 3,
>>> and finally compare buffer 1 and buffer 3, they have to be identical.
>>>
>>> The buffers are filled with random data to detect out of bounds writes.
>>> Test for various sizes, both small and large and unaligned.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> 
>> I've tested this with
>> 
>> $ ./test/py/test.py --bd sandbox --build -k ut
>> 
>> Followed by:
>> 
>> $ ./test/py/test.py --bd sandbox --build -k cmd_zip
>> 
>> And I see:
>> 
>> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_gzwrite] - ValueError: U-Boot exited with signal 11 (SIGSEGV)
>> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_cmd_zip_unzip] - ValueError: U-Boot exited with signal 11 (SIGSEGV)
> You will also need these four fixes, then it should work:
>
> cmd: zip: Add missing unmap_sysmem() for buffers in the unzip command
> cmd: zip: Use map_sysmem() with buffers in the zip command
> cmd: unzip: Use map_sysmem() with buffers in the gzwrite command
> gunzip: Fix len parameter in function signature

Indeed, when these four fixes are applied first, the tests pass:

test/py/tests/test_ut.py ..                                                                                                                                                                                                                                                                                            [100%]

============================================================================================================================================= 2 passed, 1464 deselected in 1.41

Can you mark these patches as dependencies of this series for v2?

Thanks
Mattijs
