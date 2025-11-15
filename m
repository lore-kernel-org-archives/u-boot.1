Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD4CEB2F1
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D77883A3D;
	Sun, 16 Nov 2025 01:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TvhHreX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78524839E4; Sun, 16 Nov 2025 01:20:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FFA83A35
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d8BN84Ptdz9tTZ;
 Sun, 16 Nov 2025 01:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOSDoAu80u+SKNYSR4WkI2StcbQvZHU2loWBxiv07LI=;
 b=TvhHreX8ZNZD0swyrdlM4QpAKbOHhuUYj0y0gkBsCuoSU/S/u8YU5UDvNIOEzmwDfsmTdn
 F9kMjX6Sjqf+Qnl3ATmD5POJ9bE1a5Ke9rXKBMZZeNdCZHt/qFKjtLl9k2CPP1oIPqHroG
 BwbdlvWO/z90cQipAT2oKtP3ORgunM68JvkRDtXaSkrGtJhzDh3qkbd/wb/mcttXlAyfKo
 EE6D8tcrrc/K9XkZNW4FhRum+Uio3g5dwypLhS/s4XiQgGfv+wJ4+4hV1yuLoONF40YUVc
 qPL5fRCGOZtJljeZxOgePE9JrDsoudbjmRTP9hzj8qkRfWrD17len2Kkw8dEdg==
Message-ID: <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
Date: Sat, 15 Nov 2025 17:49:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8059890440614170174
X-MBO-RS-META: j6spgx987699pfpiapgjumwkw9uh7axg
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

On 11/14/25 8:03 AM, Ilias Apalodimas wrote:

Hello Ilias,

>> +               img = memalign(8, image_size);
>> +               if (!img)
>> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>> +               memcpy(img, image, image_size);
>> +       } else {
>> +               img = (void *)image;
>> +       }
>> +
>> +       ret = fit_update(img);
>> +
>> +       if ((uintptr_t)image & 7)
>> +               free(img);
> 
> Initialize img to NULL and make the check a bit simpler to read (or
> get rid of it overall)
This part ^ I do not understand. The img variable is used by 
fit_update(img) , where should it be initialized to NULL ?
