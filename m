Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7968C282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C8181101;
	Wed, 19 Mar 2025 03:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oGeePfVG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RF5MlmcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915068129F; Wed, 19 Mar 2025 03:52:16 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F25681026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZHYCK6yPRz9smd;
 Wed, 19 Mar 2025 03:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742352734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQgYvZ9dTg5tbOzqNAgOk/t35ZAOPK9ddlqe7wCWevw=;
 b=oGeePfVGTqxBPGXCMXFwNkMIYtTqqWb52KWhhn6S/T2CMJuh54EMCH6eLB3CknFA0Pf9+i
 oVLS3BvV06H84w6cLNg4R7pxb5JkGyAi7k5XhLJHtM1ECakJJSrzufHRT+2A+kIrqJ4Zuf
 Wg70PdTQ/Txr+w+nEnSwnRggEwtNAGhndjPJLiLGbHimq+H5Jcsu+XaNufK9HCK95Nr447
 wPX90ReNAtJlkKm7A1EZi/zlye1OdbtU4DT0GHTt7oq+m8KaKEu+xlHrhNZP492rBZkwSs
 U825Ba/8uIRcHXYlbHplQbD8hv4yiuFZ+Ip+6q3T8xpWlSIqoSWvQinO2nkhqA==
Message-ID: <995192fe-c9ec-48f1-aa9e-514da0e0aece@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742352732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQgYvZ9dTg5tbOzqNAgOk/t35ZAOPK9ddlqe7wCWevw=;
 b=RF5MlmcPDfDq4BDZySitkSKoqEjt5CTGT9KBbslJBP4uC131KukiVybF3h3rz3T8C2Gcc+
 isMl/twjNHXm+rbA00cv2LSt1Q9UpabcQj2tR8MQ9aPN5SyQPXjNr6he9Yl4S6XSj7UAM2
 visfhTih6XWe8sH+5syQ76AQ7arC3pESy8zAxf1RW2w0HHj2LBlHApTlFnbYeU5ecNgUYb
 IoFytFiP5GaRRgpbjiwqCl14rFwMKss5CXK/0kEa89VttFShgJ9rxOXoVzXtJ9CDoH5Zte
 TaSZKcEOB3YXT+DhnPkj8qkoK4E8lY3gq4VYkfWiaznPXGZugzdWs8lqmh+Z6A==
Date: Wed, 19 Mar 2025 03:52:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: miiphybb: Update documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250308203625.1317615-1-marek.vasut+renesas@mailbox.org>
 <a2fe2373-08a9-483a-bdd9-9158f739898a@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a2fe2373-08a9-483a-bdd9-9158f739898a@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1c17fc27902f8332d11
X-MBO-RS-META: my7m6jxpmtqjg5s95aqiwa9act4othox
X-Rspamd-Queue-Id: 4ZHYCK6yPRz9smd
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

On 3/10/25 7:32 PM, Heinrich Schuchardt wrote:
> On 08.03.25 21:36, Marek Vasut wrote:
>> Update the miiphybb documentation to match current implementation.
>> The static struct bb_miiphy_bus bb_miiphy_buses[] array is removed.
>> The example is updated to match current Renesas RAVB driver, which
>> is one of the miiphybb users.
>>
>> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jim Liu <jim.t90615@gmail.com>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Mario Six <mario.six@gdsys.cc>
>> Cc: Michael Chang <zhang971090220@gmail.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: - Fix language bugs
>>      - Add RB from Paul
>> ---
>>   doc/README.bitbangMII | 66 ++++++++++++++++++++++++++++++-------------
> 
> It would be preferable to move this document into doc/devel/ as .rst file.
> 
>>   1 file changed, 47 insertions(+), 19 deletions(-)
>>
>> diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
>> index 05ab20376f3..78b4ef880cb 100644
>> --- a/doc/README.bitbangMII
>> +++ b/doc/README.bitbangMII
>> @@ -1,39 +1,67 @@
>> -This patch rewrites the miiphybb ( Bit-banged MII bus driver ) in 
>> order to
>> -support an arbitrary number of mii buses. This feature is useful when 
>> your
>> -board uses different mii buses for different phys and all (or a part) 
>> of these
>> -buses are implemented via bit-banging mode.
>> +The miiphybb ( Bit-banged MII bus driver ) supports an arbitrary 
>> number of
>> +MII buses. This feature is useful when a driver uses different MII 
>> buses for
>> +different PHYs and all (or a part) of these buses are implemented via
>> +bit-banging mode.
>>   The driver requires that the following macros should be defined into 
>> the board
> 
> CONFIG_BITBANGMII=y enables the miiphybb driver.
> 
>>   configuration file:
>>   CONFIG_BITBANGMII    - Enable the miiphybb driver
>> -The board code needs to fill the bb_miiphy_buses[] array with a 
>> record for
>> -each required bus and declare the bb_miiphy_buses_num variable with the
>> -number of mii buses. The record (struct bb_miiphy_bus) has the following
>> +The driver code needs to allocate a regular MDIO device using 
>> mdio_alloc()
>> +and assign .read and .write accessors which wrap bb_miiphy_read() and
>> +bb_miiphy_write() functions respectively. The bb_miiphy_read() and
>> +bb_miiphy_write() functions take a pointer to a callback structure,
>> +struct bb_miiphy_bus_ops. The struct bb_miiphy_bus_ops has the following
>>   fields/callbacks (see miiphy.h for details):
> 
> Please, add the description of struct bb_miiphy_bus_op miiphy.h and add 
> the file to the API documentation. You could also put the example and 
> the programming guidance there.
It seems you did that already while applying a modified version of this 
patch and the .rst conversion patch to master ? Thanks !

One more nitpick, the modified version should not be applied to master, 
it should only be in next, where the matching bbmiiphy code update which 
prompted the documentation change is applied.
