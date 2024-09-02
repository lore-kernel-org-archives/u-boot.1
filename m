Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3BBCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9737B88C01;
	Mon,  2 Sep 2024 15:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mL4nskke";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yrJ4jPa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5FE88C35; Mon,  2 Sep 2024 15:38:59 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A22188C1C
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wy8wx29R2z9sWQ;
 Mon,  2 Sep 2024 15:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725284337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDpgjGx/zLzY2edRTKFJvKCwklJa6410pPS0pUITJF4=;
 b=mL4nskke/7KsFtF4841fbiy8IX9UrzgNu4p0syxf6QWMx1N7Ly8DLlStSySYPIhVntYpia
 0nt1KA5eB6xkowGfKsu0s32RFR5Xgfxbn3kcoTcBmp9zbzIfmFMOik072OtHg9IgeHcvco
 DvUND0OEak8iTOuvR35++V4mWtc2wCGTZ+60zyJ9a3uoAW9oTHiO86kFZaMNY8NIqzrn6u
 LY6bWWeoM0FvX86XEGyEHbC/0fE8JbJEtUrgPN9b1Qdw5OVRb6nXjfdvoYUdtojiKy7gmZ
 QNJqlmaxm0vTTpArRJN5AnEqyWbuYQYb9I4FYBoowyq9qAhB7D8Mh+niFVLBTA==
Message-ID: <03f79033-1b0b-4be4-905c-7f15d04032de@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725284335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDpgjGx/zLzY2edRTKFJvKCwklJa6410pPS0pUITJF4=;
 b=yrJ4jPa8yKbWiW2aOBhtsUvmkX7qWJbOyQSR78zsfsDdio3AGa2eNjLtO6lKNrITUr1Jls
 GFlqLFEiEFcrymq4LS0edDq6NKWRUh/lAqE4cUoppNUBua948kUdPR9JYHo5ZEleIyijIu
 kT9G32mLCHlQ2A/NWz9FdfMPd/CKluHUpxZnh/E964C3Olc+6vDG80yoxjZTpb+m+SKAGy
 5B6ok98jkQ1O1P7jlN05MZBYF604TplX9BGP4mmD1RGXrNVMcVzatarcoZgvOIojjFYcYa
 DvlfzLlpwXs8gsyrw6SDxTJC11gdY2BkOiO1zjo7td1dpta+jN94NjvigYenoA==
Date: Mon, 2 Sep 2024 15:38:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Hide mmc speed command under mmc command
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240829012210.179436-1-marek.vasut+renesas@mailbox.org>
 <63463eb1-d7cd-481d-ac08-c08d2b66eda9@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <63463eb1-d7cd-481d-ac08-c08d2b66eda9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9ickneqw848m71zk7fd5kzx3f1gz5q7t
X-MBO-RS-ID: 414725a3034991b336f
X-Rspamd-Queue-Id: 4Wy8wx29R2z9sWQ
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

On 9/2/24 10:48 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 8/29/24 3:22 AM, Marek Vasut wrote:
>> The mmc speed command configuration option keeps showing up in
>> Kconfig even if CMD_MMC is not set. Move MMC_SPEED_MODE_SET under
> 
> How is that even possible?
> 
> Shouldn't
> 
> depends on
> 
> be enough to NOT show the option?
> 
> I just tested now and it does NOT show up when CMD_MMC is disabled, so 
> not sure what your issue is?

See V2, I totally messed up the commit message here because too much 
back and forth rebasing.
