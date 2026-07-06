Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B687C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 19:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3B5846FD;
	Mon,  6 Jul 2026 21:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FzHAi5Cq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q6GBeOJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CD68490A; Mon,  6 Jul 2026 21:44:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5751B846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 21:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gvFDg1BPTzKn6v;
 Mon, 06 Jul 2026 21:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783367075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6h1GadI8xjTUI9OX/cEzLvgufLERp1wN2I2+gUJasE=;
 b=FzHAi5CqtPm1LBx1oFLOuxULYprcBbyufn3u+M+1G8B/GbQTMdydKfuYv00Jrjw+jg1bJp
 srNT9Cjrb5leF4R1DRi8UYTFYElK32gKJ3p1tVt6BvDfDdV5h7DPJSm3D/DVLhGTd6WLE8
 QAEWeH1vrlfrXL/jAIq+RYHRyAwzKeKT/jUtuEbhPSmPSnOkUHzeTwMA3TIrKeXSvQ9av8
 a515/bG8mB0sK3I4WYUE7CI6NZU41+T4GYx3YTn/CS2znfx1fCPsr90hH7LvZQyH246YUi
 RWuFBhRO/332jV9b7+3kTIYdhDH+fBwGjqGXv1qUR58F4SGaf/qnlUKG4vKiqQ==
Message-ID: <ec6ed9f4-b302-4336-af02-1645aff668d1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783367073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6h1GadI8xjTUI9OX/cEzLvgufLERp1wN2I2+gUJasE=;
 b=q6GBeOJ88tWe64RQf/4g5ZhrzlZtQOhbIprpGxgMBFMNN1my6qLxJtWTFAMfjLB85LAr52
 Caf/GDy2SR1rjMPQEViYzT4KH7cVkWFFOFSq1QiGhMW7mUi7nOWMjgPkAJ9VRkn+EGZ3Nf
 CKNE16PP0QmzLU4kpHgUD9BjtLY8jJYTwzFqCD8/a6UWL/q5fTZhoWOxAEeHpov0H1WSfW
 tnhxqgsykk15Ikpy+SDKoYrWMid4AHLa2ceCxgCoMMId7uHDjR+mh7xFphdMAwPM3PLSHT
 APcbCOw39kIoxc5tSOLOJdMEwcJNTehpWYyYbs5wPB1qo8KueiyDYU0VaM6NmQ==
Date: Mon, 6 Jul 2026 18:00:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
 <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
 <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aa2f399c83557d2972e
X-MBO-RS-META: rjhfq3p98i7qeodjggrd5y5z1ziowjdc
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

On 7/6/26 5:16 PM, Patrice CHOTARD wrote:

Hello Patrice,

>>> I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.
>>
>> Does the list iteration exit when it finds the first entry that is not going to be executed at this time ? If it does not, then there will be no improvement. But for this to work, the list would have to be surely fully ordered in incrementing timestamp order, is it ?
> 
> No, the list iteration parse all entries.
> 
> I see your point, on original implementation, entries are not sort by incrementing timestamp order.
> I did some implementation test, by sorting cyclic entries in cyclic_list when :
>    _ registering a new cyclic callback, put it directly in the right position in cyclic_list.
>    _ in cyclic_run(), after running a cyclic, compute its next call and insrt it in the right position in cyclic_list.
> 
> There is no noticeable gain.

Did you also break from the iteration when you reached the first entry 
with future timestamp ? That might actually help.

-- 
Best regards,
Marek Vasut
