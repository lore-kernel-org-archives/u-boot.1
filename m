Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C2C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C310883C2;
	Mon, 17 Jun 2024 21:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="FWErT594";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3657883C2; Mon, 17 Jun 2024 21:57:00 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4308831F
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718654217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W5NOHvXCltjRR/hTaQLfjvXjvkJIzCYFPR4hF5Ltdc=;
 b=FWErT594G5PDxrfeSeRQSu2LQ+FDM1kbNYmdAsD7oR3lsmlnOpOuV/xx9VFR72bbscw6SF
 PzVNoM5/dsRM9FmrAjHDBwplbif4V3sIHY8BYrWEq1soJFaQFzizzuttS5gXlyCQmNgUNd
 Y5JB6xE7C15dkPQ7rEn6G4Fm3l+c3mB6zI1mX1oWhM08H3uya2CAydu1Uhx9+it/Q82hTo
 SaWiFvmPdA/Ioae3XbG+G0b3ceHhVPWQi0DukulqufyI6IDm8HO5uoIrYzp+JaYXYLnwEr
 62XqwUREAw5BB3pJZZ2HNX2UCg0Vepx4x15WYZtefe/mzF63fSsY1CAoW9ffUg==
Date: Mon, 17 Jun 2024 21:56:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Dhruva Gole <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com
Subject: Re: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
In-Reply-To: <ae2f27e8-dbb6-4711-8659-0c47e3a9de54@amd.com>
References: <20240617041841.1336632-1-prasad.kummari@amd.com>
 <20240617062822.474khxwuq4yxs5ra@dhruva>
 <18ca247a-980a-4d6a-906a-bb5719482626@amd.com>
 <ce7685916d3b76527425368754ea096f@manjaro.org>
 <ae2f27e8-dbb6-4711-8659-0c47e3a9de54@amd.com>
Message-ID: <a84fef6e17f7d7b3f683e09bc080c9eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-06-17 15:38, Michal Simek wrote:
> On 6/17/24 15:31, Dragan Simic wrote:
>> On 2024-06-17 15:26, Michal Simek wrote:
>>> On 6/17/24 08:28, Dhruva Gole wrote:
>>>> On Jun 17, 2024 at 09:48:42 +0530, Prasad Kummari wrote:
>>>>> Add support for ISSI 128MB flash IS25LP01GG. This part
>>>> 
>>>> Can we have the datasheet link for this part?
>>>> I am assuming it's this?
>>>> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
>>> 
>>> Problem with links is that they will disappear when company decide to
>>> change infrastructure or is acquired by different one.
>> 
>> You can prevent that by making sure that the link to the PDF file
>> is archived on The Wayback Machine. [1]  That way, even if the URL
>> becomes invalid at some point in time, the contents won't be lost.
>> 
>> [1] https://web.archive.org/
> 
> No idea about it. Up to Tom.

As a note, that's what Wikipedia does with its online references
that become inaccessible over time.
