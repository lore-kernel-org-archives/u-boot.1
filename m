Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C29C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB83E831E0;
	Tue,  5 Aug 2025 16:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wt2aFjrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269EC8338B; Tue,  5 Aug 2025 16:28:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2012583045
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxFcy0p7Mz9sNv;
 Tue,  5 Aug 2025 16:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754402882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRHw00X/NwMfwTbW2o6hYABgPHt9CrVPxahPhVvDplE=;
 b=Wt2aFjrJE6BE1hwFrZzdlZZzKqgEWLBenEqcankGL34Fzvh/0BoKc0fa4UlUUnhP6ZORuC
 DCGoz8QVQq6ko4ERXY2WdIcjjt67UiSIyyr1BXergsCnzy4i5jdho+9Qniec8P01X9bNdj
 y8dypEH1D1HHMHvHOh3KXmMCkNjl4Kv6f+Yu0eN78j1jVn4Ff5zcRuk8iuN8yrbIEDOQW0
 kO8U9Qjp97yZaKjuUP4e+fAVZyJj3HaalXJwq9JZ9mGWjoiZ44J7MM+cgzbJ0SgHmPRY0z
 ba1CFAq5oQ/xYBi/Y+GZZYat+jwaWv8TLYbHEHkICZtYABIL40D64LQuVz0JbA==
Message-ID: <24e748e3-a746-46bb-b893-887dfa2e7a4d@mailbox.org>
Date: Tue, 5 Aug 2025 16:08:00 +0200
MIME-Version: 1.0
Subject: Re: Smatch issues reported for Marvell a38x DDR4
To: Tony Dinh <mibodhi@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
 <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
 <95d77991-77ed-4af5-8ba9-a4acc57e7a21@linaro.org>
 <CAJaLiFwFpZTiM5_QnB=jq7FSrFqmf0QjbNPBsYFPMyY5=FB3kw@mail.gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <CAJaLiFwFpZTiM5_QnB=jq7FSrFqmf0QjbNPBsYFPMyY5=FB3kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 889db99a78e22db2ab2
X-MBO-RS-META: o3r3r549ypwr9ciu79cbzigtdud8gq4q
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

Hi Tony,

On 05.08.25 15:11, Tony Dinh wrote:
> Hi Andrew,
> 
> On Mon, Jul 28, 2025 at 9:25 PM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> On 25/07/2025 14:02, Stefan Roese wrote:
>>> Hi Andrew,
>>>
>>> On 24.07.25 18:01, Andrew Goodbody wrote:
>>>> Hi Stefan,
>>>>
>>>> Smatch reports the following issues
>>>>
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029
>>>> mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less
>>>> than zero.
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192
>>>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270
>>>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
>>>> mv_ddr4_centralization() warn: unsigned 'if_id' is never less than zero.
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
>>>> mv_ddr4_centralization() warn: we never enter this loop
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911
>>>> mv_ddr4_dqs_reposition() warn: always true condition '(delta >= 0) =>
>>>> (0-255 >= 0)'
>>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924
>>>> mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than zero.
>>>>
>>>> As I have no way to validate the correctness of the code I am not
>>>> confident enough to attempt to make the appropriate fixes in this case
>>>> as it could affect its operation. Perhaps you would like to take a look?
>>>
>>> Sure, thanks for all your work on these smatch issues. Really
>>> appreciated.
>>>
>>> But frankly, it's not easy to test anything in this area. I still have
>>> access to one board (AFAIK), but minor changes usually don't really
>>> make a notable difference in the DDR controller configuration here.
>>>
>>> My suggestion is to send the patches (or one patch) "as best as you can"
>>> to the list for official review. I'll try to review and perhaps someone
>>> else with access to such a board will take a look.
>>>
>>> Thanks,
>>> Stefan
>>
>> OK, patch coming. It was not as invasive as I feared.
>>
> 
> Please add me to the CC list of your patches. I'll be available (in a
> couple weeks) to run regression tests for this Armada 38x DDR4 area.

The (one) patch is already in master. It would be great though, if you
could run some regression tests once time permits though.

Thanks,
Stefan

