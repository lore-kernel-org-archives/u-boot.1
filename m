Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50952CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CECCD828A2;
	Tue, 30 Sep 2025 02:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AC283045; Tue, 30 Sep 2025 02:32:16 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB8181D6A
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.29]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A5DF3B220123;
 Tue, 30 Sep 2025 02:32:10 +0200 (CEST)
Message-ID: <b5d83815-a4cc-43d1-a770-4553c3431e9e@freeshell.de>
Date: Mon, 29 Sep 2025 17:32:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, Marek Vasut
 <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@xilinx.com,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
 <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
 <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
 <49902e34-a01d-422b-bd60-e97aef7d859e@amd.com>
 <88692c72-1c86-45d3-bf2b-1a21debc5785@freeshell.de>
 <a69aecba-186e-4ce4-ba8f-2c72b1d94267@amd.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <a69aecba-186e-4ce4-ba8f-2c72b1d94267@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 9/29/25 05:36, Michal Simek wrote:
> 
> 
> On 9/29/25 11:49, E Shattow wrote:
>> Hi Michal,
>>
>> On 9/29/25 00:08, Michal Simek wrote:
>>>
>>>
>>> On 9/23/25 23:18, E Shattow wrote:
>>>>
>>>>
>>>> On 9/22/25 07:51, Marek Vasut wrote:
>>>>> On 9/22/25 4:02 PM, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 9/11/25 07:40, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/11/25 05:28, Marek Vasut wrote:
>>>>>>>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>>>>>>>> In case of ENV_INVALID (uninitialized variables) the first env
>>>>>>>>> location
>>>>>>>>> should be used for storing variables.
>>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>>> with
>>>>>>>>> offset calculation.
>>>>>>>>> This will also fix the print about Valid environment is showing
>>>>>>>>> proper
>>>>>>>>> location where variables are saved for the first time.
>>>>>>>>> And also fixes behavior where the first two writes were going
>>>>>>>>> to the
>>>>>>>>> first location instead of the first to the first location and
>>>>>>>>> second to
>>>>>>>>> second location.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Changes in v2:
>>>>>>>>> - Simplify commit message
>>>>>>>>>
>>>>>>>>> Origin commit message with more technical details.
>>>>>>>>>
>>>>>>>>> When both location for variables are not valid (or empty) gd-
>>>>>>>>>> env_valid is
>>>>>>>>> 0 (ENV_INVALID) which is setup by
>>>>>>>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>>>>>>>
>>>>>>>>> When saveenv is called in case of SPI env_sf_save() is called
>>>>>>>>> which
>>>>>>>>> contains logic which describes new/old variable locations.
>>>>>>>>>
>>>>>>>>> if (gd->env_valid == ENV_VALID) {
>>>>>>>>>            env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>>>            env_offset = CONFIG_ENV_OFFSET;
>>>>>>>>> } else {
>>>>>>>>>            env_new_offset = CONFIG_ENV_OFFSET;
>>>>>>>>>            env_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> In case of ENV_INVALID option the first location is used (else
>>>>>>>>> part)
>>>>>>>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>>>>>>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>>>>>>>
>>>>>>>>> And
>>>>>>>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID :
>>>>>>>>> ENV_REDUND;
>>>>>>>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is
>>>>>>>>> setup
>>>>>>>>> but that's not correct because the first location has been written
>>>>>>>>> and not
>>>>>>>>> the second one.
>>>>>>>>> That is confirmed by
>>>>>>>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>>>>>>>> which is showing number 2 (ENV_REDUND).
>>>>>>>>>
>>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>>> with
>>>>>>>>> offset calculation which also cover the case where initial
>>>>>>>>> state is
>>>>>>>>> ENV_INVALID.
>>>>>>>>> Then print about Valid environment is showing proper location
>>>>>>>>> where
>>>>>>>>> variables are saved for the first time.
>>>>>>>>> But also it is fixing behavior where the first two writes are
>>>>>>>>> going
>>>>>>>>> to the
>>>>>>>>> first location instead of the first to the first location and
>>>>>>>>> second to
>>>>>>>>> second location. Alternation is happening after it.
>>>>>>>>>
>>>>>>>>> v1: https://lore.kernel.org/
>>>>>>>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>>>>>>>> Sorry for not being clear, the original commit message structure
>>>>>>>> and
>>>>>>>> technical details were fine, it only needed slight rephrasing, in
>>>>>>>> the original form it was very hard to understand. Can you please
>>>>>>>> reinstate the original commit message and only clean it up
>>>>>>>> slightly ?
>>>>>>>
>>>>>>> Can you exactly point me to part which wasn't clear? It has a lot of
>>>>>>> details about flow and obviously it makes sense to me that's why I
>>>>>>> would like you to point me to exact part which should be improved.
>>>>>>
>>>>>> What about this?
>>>>>>
>>>>
>>>>>> When both SPI environment locations are invalid (gd->env_valid ==
>>>>>> ENV_INVALID), the first call to saveenv writes to the primary
>>>>>> location
>>>>>> and sets the active flag. However, the logic for updating gd-
>>>>>>> env_valid incorrectly sets it to ENV_REDUND, which does not match
>>>>>>> the
>>>>>> actual location written. This causes the first two writes to target
>>>>>> the same location, and alternation only begins after the second
>>>>>> write.
>>>>
>>>> nit, the use of word "alternation" here reads as splitting (no
>>>> duplication) the data one-by-one into multiple targets. I would give
>>>> the
>>>> game analogy of 52 playing cards and alternating to deal the cards to
>>>> players, each player gets one card in a sequence of alternation; if
>>>> there is more than one player in the game then no player will get all
>>>> the cards from the action of dealing the cards.
>>>
>>> tbh before this patch I though that both copies are the same but that's
>>> not how it is implemented.
>>> It is switching from Location A to B and then to A, etc.
>>>
>>
>> Okay. That is also surprising for me.
>>
>>>>
>>>>>>
>>>>>> Update the logic to alternate gd->env_valid based on whether the last
>>>>>> write was to the primary or redundant location, ensuring the first
>>>>>> write sets ENV_VALID and subsequent writes alternate as expected.
>>>>>> This
>>>>>> aligns env_valid with the actual storage location and fixes the
>>>>>> alternation sequence from the first write.
>>>>>>
>>>>>> With this change, the "Valid environment" printout correctly reflects
>>>>>> the active location after each save, and the alternation between
>>>>>> primary and redundant locations works as intended from the start.
>>>>> Yes, perfect.
>>>>
>>>> I do not understand what this description is saying because alternation
>>>> of write operations to multiple targets would not be redundant.
>>>> Alternation with the meaning of "fail-over" is similarly not redundant.
>>>
>>> How the code is written is that you have location A and B.
>>> And when you call saveenv variables are written to A.
>>> And next saveenv variables are written to B.
>>> Next to A, etc.
>>>
>>> It means unless you call saveenv twice you never get data in A and B
>>> equal.
>>>
>>> It means it is not alternation of write operations to multiple targets.
>>> It is alternation of location where one complete write is done.
>>>
>>>>
>>>> An alternative method has the meaning of "do something else, do not do
>>>> this". In the common use, an alternative may have the meaning of "do
>>>> something else if needed as fail-over from what is first being
>>>> attempted". Do you intend for the meaning of "fail-over" and
>>>> "duplicate"
>>>> or "duplication" where you have written "alternate" and "alternation"?
>>> I am not a native speaker but the word alternation between A/B sounds
>>> the best for me.
>>> Feel free to suggest how to describe it better.
>>>
>>> Thanks,
>>> Michal
>>>
>>
>> This is not easy to describe with a small quantity of words. The common
>> phrases are "taking turns" and/or "round-robin".
>>
>> It is clearer to say what this is not, as:
>>
>> "... results in alternation of saveenv location with each invocation.
>> Data is not duplicated or striped between locations for any single
>> saveenv invocation."
>>
>> I like your explanations, you understand the functionality and can
>> describe the problem clearly. I just do not expect that functionality
>> would be useful so without additional context and full explanation it
>> seems unlikely to be what you say it is. Thank you for expanding on the
>> meaning.
> 
> What about this full description?
> M
> 
> When both SPI environment locations are invalid (gd->env_valid ==
> ENV_INVALID),
> the first call to saveenv writes to the primary location and sets the
> active flag. However, the logic for updating gd->env_valid incorrectly
> sets it to ENV_REDUND, which does not match the actual location written.
> This causes the first two writes to target the same location, and round-
> robin switching only begins after the second write.
> 
> Be aware that data is not duplicated or striped between locations
> for any single saveenv invocation.
> 
> Update the logic to perform round-robin selection of the environment
> location
> based on whether the last write was to the primary or redundant location,
> ensuring the first write sets ENV_VALID and subsequent writes follow the
> round-robin pattern as expected. This keeps gd->env_valid consistent with
> the actual storage location and fixes the sequence from the very first
> write.
> 
> With this change, the "Valid environment" printout correctly reflects the
> active location after each save, and round-robin switching between primary
> and redundant locations works as intended from the start.
> 

Michal, great and we can condense that to terms of location (and not so
much write operations that are now the most confusing word use)?

My edit is as following:

START

Update the environment location selection logic to perform
{alternating,round-robin} selection of the environment location based on
whether the last write from a call to saveenv was to the primary or
redundant location. Ensure the {first,initial} {write,call to saveenv}
correctly sets ENV_VALID so the subsequent calls to saveenv follow the
{alternating,round-robin} pattern as expected. This keeps gd->env_valid
consistent with the actual storage location and fixes the sequence from
the very first write.

Prior to this fix the {alternating,round-robin}
{switching,change,assignment,selection} of locations would begin only
after the second call to saveenv.

With this change, the "Valid environment" printout correctly reflects
the active location after each save, and round-robin switching between
primary and redundant locations works as intended from the start.

{in absense of a cover letter then insert triple-hyphen here so git will
ignore the remainder with more technical details not intended for the
commit message}

This corrects the existing behavior that when both SPI environment
locations are invalid (gd->env_valid == ENV_INVALID), updating
gd->env_valid is incorrectly {selected as,set to,assigned as} ENV_REDUND
and allowed the following call to saveenv to target the same location as
the first call.

Note that data write operations are not duplicated or striped between
locations for any single call to saveenv. The location switching is
being done between completed saveenv operations.

END

Here also are my notes and advice about word selection as might be
suggested from the above:

"following" may have a double meaning of both being a sequence and being
a copy of or adjoined to.

"subsequent" is more precise than "following" but not as common for easy
understanding.

"alternate" if you want the meaning of A-B-A-B for two locations, and
possibly A-B-A-C-A-B-A-C-A-B-A-C (alternating, non-circular order) for
more than two locations.

"round-robin" if you want the meaning of "A-B-C-D-A-B-C-D-A-B-C-D", in
that there will always be one-or-more locations taking turns in circular
order.

"the last write" can have the double meaning of "the previous write" and
also not the most recent write operation, but I figure this out from
context these two concepts are equivalent here.

With this I have focused my attention to give possibly too much
information :-)   Does that make more sense or is it less clear?

Best regards,

-E
