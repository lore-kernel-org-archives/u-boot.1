Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2553AC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 07:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB0888308;
	Sat, 27 Apr 2024 09:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ukMe7t2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856FE882D9; Sat, 27 Apr 2024 09:30:35 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08998830D
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 09:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1714203033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ntvmuViseUnFUOpaEMHPTxtZoupndVaTs1A28RqVNI=;
 b=ukMe7t2d4ZC3kYPY4Slk7cobM4/4dkNfvnnDjELZyB6K+C7FR0mi+2v2g/GSQXo63qn5h/
 7xcedlTxqsYcN63msl6Cgomh5bv1D2nSbibuvB0+mXa3y6cwG0rbISYkMIiegrNyUJy5pI
 NsGfkRY2wXQjHZGy4IYszQ3GfqSZx3aeR1BXhZsVDBucDM70S20OxHoQ0FiQMcaP8r8hUo
 T/Eedv5rlde3OtuG5mGYW1vevlTD15Dbz0WBKBvExAwKumr7KtaoEAoa27PWC4FRDAY2Ue
 RZfXK5YquajbBzBm1vck0T5ouIr72qmEjzLcvCqnf70rk5xSpbnhD/0eEMiheQ==
Date: Sat, 27 Apr 2024 09:30:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: mmc: allow use of hardware partition names for
 mmc partconf
In-Reply-To: <7aac74dc3adf48f746520fa9e6c83699@manjaro.org>
References: <20240426171205.1382212-1-tharvey@gateworks.com>
 <9f5dc653-8252-4da7-81bc-a76280cf4c68@denx.de>
 <CAJ+vNU3U4P0wLcJ=_Bev++bsRF+=2inGEcs3pMuRb4f7ObSjBQ@mail.gmail.com>
 <7aac74dc3adf48f746520fa9e6c83699@manjaro.org>
Message-ID: <427816e0e69cad91b149a91136f1f290@manjaro.org>
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

On 2024-04-27 09:25, Dragan Simic wrote:
> On 2024-04-26 19:36, Tim Harvey wrote:
>> On Fri, Apr 26, 2024 at 10:25 AM Marek Vasut <marex@denx.de> wrote:
>>> On 4/26/24 7:12 PM, Tim Harvey wrote:
>>> > +static const char *mmc_partnames[] = {
>>> > +     "user",
>>> > +     "boot0",
>>> > +     "boot1",
>>> > +     "gp1",
>>> > +     "gp2",
>>> > +     "gp3",
>>> > +     "gp4",
>>> 
>>> Uh, maybe gp%d are indexed from zero too ?
>>> 
>>> (sorry for the confusion)
>> 
>> but 'mmc hwpartition' does not list them 0 based:
>> u-boot=> mmc hwpartition
>> switch to partitions #0, OK
>> mmc2(part 0) is current device
>> Partition configuration:
>>         No enhanced user data area
>>         No GP1 partition
>>         No GP2 partition
>>         No GP3 partition
>>         No GP4 partition
>> 
>> I'm ok with either, I'm just not sure what is more understandable and 
>> standard.
> 
> I can confirm that JEDEC also starts the numbering of the GP
> partitions from one in some of its documents.
> 
> Though, it's a bit intriguing why the numbering of the boot
> partitions starts from zero.  Perhaps there's some good reason
> for that difference.

Hmm, it seems that JEDEC actually starts the numbering of the boot
partitions from one in some of its documents, instead of starting
from zero.  I'll try to research that better.
