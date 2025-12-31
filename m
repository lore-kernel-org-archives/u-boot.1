Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB42EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91E684113;
	Wed, 31 Dec 2025 18:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LHjq6taG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7CA84158; Wed, 31 Dec 2025 18:46:18 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D794D84105
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dhHSM439Gz9srd;
 Wed, 31 Dec 2025 18:46:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767203171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eM9fBy4/XEkdIQwTeappVgArnimI7UQLN5iKR3tKAw=;
 b=LHjq6taG8o9QzrQcsqb+SUXM54sEAJe/JXQCtMk2G3iDzaVgghjcPEWPRuv4Xs812XlaWU
 +QN4AdJvZ0J3y3Nbvvk5g8T+VSFuSCbFfbNIpoFpZ8nmqpqIsXlbvG+YHrXjK+f7pkFTs7
 Fjnz7ps+xXcmKo5zdjfcbnhnScTKR0bco5tMB2YItCSxp/WZy+ERpFr5gg9ENaVL6Nvuvv
 l1+FZceaRQyftkyKeEu3esNCILLsAax66JVMGB8waZAj9p0oMGw7h0YXS0uTLmwtEzuoJn
 Uvhj/mQV2rcawTQVm8EZlmrJzUEbgVLWPc7y3C2C7+ocDB8IVPTJpoo+ojwJ3A==
Message-ID: <cfbe8213-a5e6-48f9-84b3-815943b59450@mailbox.org>
Date: Wed, 31 Dec 2025 18:46:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] test: env: Add test for environment storage in SPI
 NOR
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
 <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
 <20251223233205.GG847766@bill-the-cat>
 <56df64f1-f3f8-4fb8-b85b-e1b1e30f5f49@mailbox.org>
 <20251231161120.GB710860@bill-the-cat>
 <364a3396-8c37-49af-b4da-01ab5dfc5c16@mailbox.org>
 <20251231171804.GD710860@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251231171804.GD710860@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0e33f314b3ec1a0dc47
X-MBO-RS-META: mc16tp9qjbjbfqc4t9ypc4x38rrf7xmb
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

On 12/31/25 6:18 PM, Tom Rini wrote:
> On Wed, Dec 31, 2025 at 05:50:31PM +0100, Marek Vasut wrote:
>> On 12/31/25 5:11 PM, Tom Rini wrote:
>>> On Wed, Dec 31, 2025 at 05:07:31PM +0100, Marek Vasut wrote:
>>>> On 12/24/25 12:32 AM, Tom Rini wrote:
>>>>> On Tue, Dec 23, 2025 at 07:55:45PM +0100, Marek Vasut wrote:
>>>>>> On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
>>>>>>> On 12/23/25 15:31, Marek Vasut wrote:
>>>>>>>> Add test for environment stored in SPI NOR. The test works in a very
>>>>>>>> similar way to the current test for environment stored in ext4 FS,
>>>>>>>> except it generates spi.bin file backing the SPI NOR.
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>>> ---
>>>>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>>> Cc: u-boot@lists.denx.de
>>>>>>>> ---
>>>>>>>> V2: No change
>>>>>>>> ---
>>>>>>>>      test/py/tests/test_env.py | 99 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 99 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
>>>>>>>> index 383e26c03b0..48e31f19b3c 100644
>>>>>>>> --- a/test/py/tests/test_env.py
>>>>>>>> +++ b/test/py/tests/test_env.py
>>>>>>>> @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
>>>>>>>>          utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
>>>>>>>>          return fs_img
>>>>>>>> +def mk_env_spi_flash(state_test_env):
>>>>>>>
>>>>>>> Thank you for adding the test.
>>>>>>>
>>>>>>> Unfortunately pylint doesn't like your code. Please have a look.
>>>>>>
>>>>>> Is this something we run in CI ? If so, CI builds did pass.
>>>>>>
>>>>>> If not, how do I trigger this ?
>>>>>
>>>>> We only run pylint_err not pylint in CI. The "make pylint" target has
>>>>> been unused for so long that the baseline itself is out of date. I don't
>>>>> object to trying to improve our python code to match standard practices
>>>>> better, but this isn't the place to start adding complaints.
>>>>>
>>>>> All that said, a newline before a new function is just a normal good
>>>>> practice and so at least the quoted here example should be fixed, just
>>>>> like if it was in C :)
>>>> There is a newline before the function, the code is incorrectly quoted in
>>>> this discussion, see e.g. patchwork for the actual content of this patch:
>>>>
>>>> https://patchwork.ozlabs.org/project/uboot/patch/20251223143130.16266-1-marek.vasut+renesas@mailbox.org/
>>>>
>>>> So, what exactly should be fixed in this patch ?
>>>
>>> Thanks for explaining. The only problem I have now is you didn't give a
>>> cover letter explaining the feature and so I need to come up with
>>> something when merging the series as a merge commit. I can do that, it's
>>> just easier when I don't have to.
>> 2/3 basically describes why this series is needed, and implements the actual
>> functionality. I can send a V3 with no changes and cover letter if still
>> needed.
> 
> I'll just paraphrase things from 2/3 and note this extends tests. But
> for future reference, please do cover letters. It both makes my life
> easier (b4 shazam -SM, re-read, commit, begin tests) and helps make sure
> I don't mis-characterize something.
ACK, thanks !
