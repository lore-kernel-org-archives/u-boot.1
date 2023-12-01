Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C05C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 08:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8D986FFE;
	Fri,  1 Dec 2023 09:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="XLFnQ1n9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA99E87686; Fri,  1 Dec 2023 09:28:19 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30BC86FFE
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 09:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 0E42B323;
 Fri,  1 Dec 2023 09:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1701419296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlpqiPn1+sBNQ/PBi02b1vbpM8Rn3yUKGnazE2oC6VQ=;
 b=XLFnQ1n9G0wJaf8puK0aRLCwfjT1pzeSATeSBMStgMxZHBR5lN+0wlVEjBuBIboiW+RVGp
 NXLYr0MnPS0Q9X1a7Bc8Zn4dqCCz+gqwEERaQBiqlbIEFiT9SURfXCNlHV7nXfyz3lfK5Z
 fW+S34EOmR+ePxJI0zq08DNYKl4L2YOalUYmxKaFqJRqJQ1upFiJ/NV/t+SYhCvlQDyK4M
 iEd1CrAeMwoLC461WUkDEd19qj9OwiXhbTMpifKSi2J7z4yoyK9jBkMooCKxw+IPrPcOuX
 Z0K/5OnnBoihyXvychcIFWL11GsLrPS5n+DXI2ynf2AFYiDogNQXM6BpL6FmZQ==
MIME-Version: 1.0
Date: Fri, 01 Dec 2023 09:28:15 +0100
From: Michael Walle <michael@walle.cc>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, Alexey Romanov
 <avromanov@sberdevices.ru>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil
 M Jain <n-jain1@ti.com>, Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Sean Edmond
 <seanedmond@microsoft.com>, Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, Peter Robinson
 <pbrobinson@gmail.com>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] cmd: mtd: OTP access support
In-Reply-To: <844cac45-c28f-bd1e-5dd9-cf316ebb878d@salutedevices.com>
References: <20231130112817.98827-1-avkrasnov@salutedevices.com>
 <060f979ddfd1e257bbb3fe225d9af0c5@walle.cc>
 <844cac45-c28f-bd1e-5dd9-cf316ebb878d@salutedevices.com>
Message-ID: <b2992daa47947c29c0c4a8c9dd5b42fd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
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

Hi,

>>> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int 
>>> argc,
>>> +                char *const argv[])
>>> +{
>> ..
>> 
>>> +    printf("Caution! OTP data bits can't be erased! Continue 
>>> (y/n)?\n");
>> 
>> Please note, that with current SPI-NOR flashes this is not true and
>> there is usually some kind of erase command for the OTP bits. Only
>> the region lock is permanent and with that set, no more write or erase
>> is possible.
> 
> I see, so may be just rephrase this message, like just "Continue? 
> (y/n)?"

I don't have any strong opinion here. The code may or may not be used
to write to the OTP of an SPI-NOR flash. Also, this patchset doesn't
support the erase op (I guess u-boot's MTD won't support it either). So
from an user's perspective these OTP data can't be erased ;)

-michael
