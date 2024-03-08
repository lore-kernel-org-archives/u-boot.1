Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AC9C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 06:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E00B8800F;
	Fri,  8 Mar 2024 07:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="hyV+fgY4";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="lIAzWpDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7834C8801E; Fri,  8 Mar 2024 07:41:07 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD14D87ECA
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 07:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id bbf9f391;
 Fri, 8 Mar 2024 06:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=Ti
 7NJhH/O3zeRlUIYZwyDlU9JiU=; b=hyV+fgY479iZNnclAkh2NjBSfRsrn05vrL
 QNnkNYkw29f70PrkWsAmcqggrGFAo643qkZkzaKuvvy3cQZn0PR3hMbKo6MC0eR8
 rq6O6QkVhaG44d2KewYGKzqGAvy/2Y0NsW43M6qUM6osr38Zf1RoLCaVqsTHXf7S
 hsO7Y1X1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 jKQHhiVoy8cf00iQyR4NvGo7wOWYOkFpOGaGEQz0qBxXPbollUr0YL4HxmYgmbP4
 otTDySW07MlEcaOSmS4wZgbQKCWYMPDc072h+ZPH/XM/sQXZnvy3qb9nHqvaxW0D
 Iwj2pgJjs8O43BboF8R/J7eWGFfoUepFf8PB5hU8Y58=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709879909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVhbJ0vVuO0T0OZkI93C8xtDpRGMj6rZZ8YW6+F7ntI=;
 b=lIAzWpDkGs9xPebiA8HwiuxtITVgvyKnF4MPmbznm/6gWB/wfNg8Ur2O/CXNtn7kt770Ne
 X1yx/bQ+v6g6jKFS3IwL0TGw9w9wcFRqoZNyRRieHWSWJwAy5v0jjtoF0JrukRFAzxlZLA
 i++ZB3Vn8eBj84vRPGw7ai35Troyasw=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it
 [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id def796e1
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 8 Mar 2024 06:38:29 +0000 (UTC)
Message-ID: <2d8843b0-df78-06ac-dcb0-2e42fb8a792f@kernel-space.org>
Date: Fri, 8 Mar 2024 07:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, git@xilinx.com,
 Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240307125525.GF1523872@bill-the-cat>
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

Hi,

On 07/03/24 1:55 PM, Tom Rini wrote:
> On Thu, Mar 07, 2024 at 09:26:42AM +0100, Michal Simek wrote:
>>
>>
>> On 3/7/24 08:56, Angelo Dureghello wrote:
>>> Hi Tom,
>>>
>>> On 07/03/24 1:10 AM, Tom Rini wrote:
>>>> On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
>>>>> Hi,
>>>>>
>>>>> On 05/03/24 1:34 PM, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 3/3/24 22:58, Angelo Dureghello wrote:
>>>>>>> Hi Tom,
>>>>>>>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>>>>>>>> Add a test for reset commands which performs resetting of
>>>>>>>>> CPU, It does COLD reset by default and WARM reset with -w
>>>>>>>>> option. Signed-off-by: Love Kumar <love.kumar@amd.com>
>>>>>>>>> Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
>>>>>>>>> v2: - Set bootmode through boardenv if modeboot is not
>>>>>>>>> defined Changes in v3: - Fix the issue with bad pattern
>>>>>>>>> found on console --- test/py/tests/test_reset.py | 61
>>>>>>>>> +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
>>>>>>>>> insertions(+) create mode 100644 test/py/tests/test_reset.py
>>>>>>>> I had hoped this was all sorted out now, but both this and the
>>>>>>>> saveenv test cause qemu_m68k to fail now. See:
>>>>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/791635
>>>>>>> looking into this.
>>>>>>
>>>>>> Is reset implemented in qemu? It should be skipped if it is not.
>>>>>>
>>>>> yes, seems not implemented
>>>>>
>>>>> => reset
>>>>> => reset -w
>>>>> =>
>>>>> =>
>>>>>
>>>>> Not finding any trace in the qemu code related to
>>>>>
>>>>> out_8(&rcm->rcr, RCM_RCR_SOFTRST);
>>>>
>>>> Does reset work on the real HW, or can you not test? What I'm wondering
>>>> is if we have a missing feature on the board/arch code (and should
>>>> disable the reset command) or a problem with QEMU.
>>>>
>>> I don't have the exact hardware (m5208evb) but:
>>>
>>> 1) i checked by tracing that on qemu the reset function is properly called
>>>
>>> => reset
>>> resetting, RCR fc0a0000
>>>
>>> 2) reset register address is correct. I checked also that writing
>>> directly to it by mw.b does now produce the reset,
>>>
>>> => reset
>>> resetting, RCR fc0a0000
>>>
>>> => mw.b 0xfc0a0000 80
>>> =>
>>>
>>> So looks not implemented in qemu.
>>
>> ok. That means that we shouldn't run reset test inside CI loop for this platform.
> 
> Agreed.  The TEST_PY_TEST_SPEC variable in both of the pipelines can be
> used to say "not reset" for this platform in the next rev. It would also
> be nice to file a bug report with QEMU too I think. Thanks for digging
> in to this everyone.
> 

good.
I also sent a patch to qemu, lets see

https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01899.html

Regards,
angelo
