Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80375F54AC9
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB54838BB;
	Tue, 24 Mar 2026 15:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cFEvcQhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0B2807C0; Tue, 24 Mar 2026 15:46:49 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A3380087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fgCY12S4Zz9v1B;
 Tue, 24 Mar 2026 15:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774363605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDZJuxds6NLupsQsKF/HA87tDWFvfpnJAcgPuLZKQYw=;
 b=cFEvcQhuurqaKzPokvKJwYhVT4xAt6wWGD093vnuq/bHuunuiFg+BTWdgKrp92OO0DCIpn
 1+h15izTSsNkcXi5h6NRoSfnksXFVHKsPMAFLtqjCC1Jn0YaGpqsV8TggpwxFdIt4Cka6x
 P0PaUZm8LXtUDlc3T8gzCCI1qDMw9dQB2fAXvFjzCqtYa7/CoUREZAZEkoKTPlB0RHXlIj
 coG6T3Sy5HT962wycjDnIShCvKu/stOvytaU0bPXWas9TDdyHksfI/CC55Y1+tt2om+UfU
 AF1lAzpc63E06SiVDUWbq7INmvSod8p4uCY9p0suXIlAUyODYf73W3tEGMqAvQ==
Message-ID: <23b3e3f6-719c-4da8-8839-63ad04f9517c@mailbox.org>
Date: Tue, 24 Mar 2026 14:59:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, u-boot@lists.denx.de, yuya.hamamachi.sx@renesas.com,
 andrew.goodbody@linaro.org, casey.connolly@linaro.org,
 holger.brunck@hitachienergy.com, jonas@kwiboo.se, kettenis@openbsd.org,
 semen.protsenko@linaro.org, sughosh.ganu@linaro.org, trini@konsulko.com
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjK2ARXUS2cpYLVHQx7Jxn6VYnon3ZU0V_SCJxH_hjtmkw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjK2ARXUS2cpYLVHQx7Jxn6VYnon3ZU0V_SCJxH_hjtmkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 800ba0d4edb1716b418
X-MBO-RS-META: ncpiz5wwtqknci9bh4gtfni7xo56kqkd
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

On 3/24/26 10:53 AM, Ilias Apalodimas wrote:

Hello Ilias,

>> That said, is there really a benefit in giving U-Boot more memory on
>> systems that typically have 2GB or more below the 4GB address
>> boundary?
> 
> The only benefit I can see is loading live images or linux distros
> that are pretty fat nowadays. It's worth noting that we can load live
> images and boot with the recent pmem changes we added a few months
> ago.

This is very close to the use case I have -- tftp/wget an image that is 
north of 2 GiB into DRAM above 4 GiB boundary and then write it into 
NVMe storage.
