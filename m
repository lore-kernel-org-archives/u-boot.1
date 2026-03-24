Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626FDF54AC9
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA614807C0;
	Tue, 24 Mar 2026 15:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ypHpRto/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79FE83AAB; Tue, 24 Mar 2026 15:47:00 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AD980087;
 Tue, 24 Mar 2026 15:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fgCYF2jx5z9tSh;
 Tue, 24 Mar 2026 15:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774363617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QE5gj0k0V/ovtY9Zcydl317H8+UQT5fd732Qr/YDhJo=;
 b=ypHpRto/Zm5XxgMTtJJPdh+PZ0lSxuE8a0uvmG7sxBFzZ/qTuh/Lu4i8+BiFsj/eFowryY
 Qe8u4r+1lTvd7bEJdFrMPJuio4mdUBnn8pYLC6KzaSe+8s6ndj7fZJdOWGaRYBQjCW2DMe
 YZqIr1ikONCBFW/L7Ef+8jwyTBdJYYTENq7iA3nux0k2EDJ5A9YK0eEFF0/MRq6w9BEedK
 F4MuqiX/OE17uASc6kWKtG166Or1LIwTWdAJ/J/s5FryG+ZtTAXzrBfxuBJMAlA2uu3aGX
 WwL6ey3jLrsFhwE0mGIVJiE4s3P9pR2Jp1ZG1Nx8MsI4aWPm7Lt+BO86170lXA==
Message-ID: <6d48f321-d0d8-4e9a-b190-4586cb3539c0@mailbox.org>
Date: Tue, 24 Mar 2026 15:22:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Gary Guo <gary@garyguo.net>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 mbrugger@suse.com, pbrobinson@gmail.com, yuya.hamamachi.sx@renesas.com,
 andrew.goodbody@linaro.org, casey.connolly@linaro.org, xypron.glpk@gmx.de,
 holger.brunck@hitachienergy.com, jonas@kwiboo.se, kettenis@openbsd.org,
 semen.protsenko@linaro.org, sughosh.ganu@arm.com,
 u-boot-bounces@lists.denx.de
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <87mrzzbg5k.fsf@bloch.sibelius.xs4all.nl>
 <DHABV5ZOLJOQ.1H3Q6TEFCTBET@garyguo.net>
 <f2e7af73-569a-49fd-95ea-011c37d21cf1@mailbox.org>
 <20260323181815.GJ502704@bill-the-cat>
 <65974391-a29d-4dcf-ab56-7d6b4a297f0d@mailbox.org>
 <CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0KgLNP2VJxRA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKFAzpj3B_MEW7-dnOrcAV-rfkhXXo8Bv0KgLNP2VJxRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cdd54196dfca7a17eac
X-MBO-RS-META: 8ghxp3eeyh6848i6z54zx1ncap1u6a3c
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

On 3/24/26 11:13 AM, Ilias Apalodimas wrote:

Hello Ilias,

>> Unrelated to whether this is going to be an issue or not, I think we
>> have two things to do here:
>>
>> - Consider ram_top , get input from Heinrich on that
>> - DMA32 ... how to design that, should that be a special LMB pool ? How
>> do we handle hardware which has no memory below 4 GiB, iommu maybe ?
> 
> Why don't we add hints in the driver model that explains the device
> limitations? That would make the core code more readable as all the
> info we need to decide on the memory allocation is packed with the
> device
Indeed, this is what Linux already does with DMA masks.
