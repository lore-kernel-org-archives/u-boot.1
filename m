Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676F7C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F4688199;
	Thu,  6 Jun 2024 09:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VagtvAdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59583881D9; Thu,  6 Jun 2024 09:34:18 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C595488199
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 09:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-804efaaae87so236153241.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717659254; x=1718264054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA31EnqKdkmzpqvQ5E3jv35k2G0V89V4zTAghFOKGxU=;
 b=VagtvAdH7ay14a/Yn2doGJq2CPJkr77MGjuLS+x2J99vds2ABZgZA8k38d93cyhAyz
 sIbms0Es6E6ZmlDWYbHp4CezQMf6WQ6X7Lwo2veJCQTYYMQ+qz9BFggxoAcVyc7HsGA2
 p7MJVkOfBvZPZojVZn1ufGvapyxXBNBnDSGr3n1txWNRORTTtIxkQmHLYZVM78v3CDZH
 F1RsxyRiuk2AlFSspIqGw7VV7G0fVXf6mp6oUovknY4vE3NEY7YWwtuGAiRIgE441eEX
 I9wMN9F2undwzBuZBIaHsazKs3ujroHT9kSrlpcNUA88YSHEV59b4E0IGzT8Y+PDJJkI
 UfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717659254; x=1718264054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZA31EnqKdkmzpqvQ5E3jv35k2G0V89V4zTAghFOKGxU=;
 b=MrlxHRUzcDHfPpym6cGlbXwe7pin24KDXlRY+xPEaqRmW6GLOa295NvdDELN5mOnlm
 a3UDp84HPP9Cup41EhdHYUmM9gam394JdUMoy+zuLLP3H9ypiRf9bjIcRIqk7DW3UE0o
 ZXarLyD7chT8yuHIi5LJJVe4g71I/KlqsITUAhF9Q8L60txdHISXExOYJaEYYfbl8i70
 MgC5YL3lEi7VUsWF6yzxnVwKUzRD2WGKwgqtPlpJSfIphFPFgRUWCLP0514Otw2W5wS4
 l49uQ69DP3Szqy0J+6dGdJxCW9wcvlGMxFWRxbociDPp7N1tSdDJ8Ado/fzeComWdiAg
 mifQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUosx6w1DC3HMI6wDySkQbm5C0xQLNIZ7tnMN17Bu4dy9F9fPexs2jAwgChcVPFhkER6u77XDOOr80T+FSHjE26cfFAQ==
X-Gm-Message-State: AOJu0YxzUaKE7Ed/cxVNdXA913fpe078+/l4qBdkK6ELPO1DmYtzCqhp
 V+9BajuAY1jEdkSKBWNAst12DJeam0Q5Is8ukv9+shcGrl6qYMzcFKOKNNAR9xJ4+f86p7tL0a+
 sFCeR02ceY7lWe6D4mbAZd7ugCViN5p+lSthzVg==
X-Google-Smtp-Source: AGHT+IEW3nKuhP8TIOTbpdGbEn09RdpVbq4jmTk/3r7LtTJ5XF3Yl5lXvOjNGUSzEeeWgvprhleeaVyOkexEfVniLuY=
X-Received: by 2002:a05:6102:292b:b0:48a:3745:ca72 with SMTP id
 ada2fe7eead31-48c048c6b3amr5992886137.2.1717659254537; Thu, 06 Jun 2024
 00:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
 <CAFA6WYP-1tuELgthx=Ky9JYAkgP0mRNEsnHdw2ZmnjHXMAm8Rw@mail.gmail.com>
 <22924b95-5181-4aa8-9014-9a030ee7fea3@linaro.org>
In-Reply-To: <22924b95-5181-4aa8-9014-9a030ee7fea3@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 6 Jun 2024 13:04:03 +0530
Message-ID: <CAFA6WYMVdwfMGK+DhGbkZ79PWTEMhj_=ZVWedZDDTgqWx=XNBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] qcom: implement capsule updates
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 5 Jun 2024 at 18:12, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> On 05/06/2024 07:31, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Mon, 3 Jun 2024 at 18:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hook up support for capsule updates loaded from disk on Qualcomm
> >> platforms.
> >>
> >> Most Qualcomm devices have an A/B partition layout, with most partitions
> >> duplicated. The metadata on which slot is active is stored in the GPT
> >> headers in the vendor-specific attribute bits of each partition.
> >
> > It's good to see capsule updates support coming up for Qualcomm
> > platforms. AFAICS, with this series we only update U-Boot on the
> > current active partition. IOW, real A/B support is still not
> > supported. Do you think it is possible for U-Boot to update metadata
> > in GPT headers and for proprietary bootloaders to pick up the U-Boot
> > from the updated partition?
>
> Yes this would be possible, I have some WIP patches to let us modify the
> slot attribute bits and write back the header.

Nice to hear that possibility.

>
> The reason I haven't implement A/B is because we don't support it from
> the OS level on any of the boards I work on. We often patch ABL to
> disable or skip the slot logic and flash a partition table without
> slots. It also unlocks a bunch of additional complexity...

Please have a look at an alternative FWU Multi Bank Updates [1].
AFAIK, the UEFI capsules updates feature from the OS point of view
remains transparent. It's more about how those capsules are
interpreted with the logic to update the inactive partition and
metadata such that subsequent boot uses the updated firmware.

[1] https://docs.u-boot.org/en/latest/develop/uefi/fwu_updates.html

>
> This isn't super high on my todo list but I'd be happy to help if
> someone wants to enable this functionality. We'd need:
>
> 1. Upstream support for modifying the GPT (see my PoC at [1] and [2]).
> 2. Logic to configure flashing the active or inactive slot
>
> This logic would have to run after the capsule update, I don't know if
> there is currently a way to add a callback after the update.
>
> If we enable updating other images (like XBL, hyp, tz, etc), we would
> need to either agree that a capsule update would have to update ALL
> partitions, or implement logic to copy over partitions that weren't
> flashed to the other slot.

I would be interested to see how we can plug Qcom specific pieces
underneath in order to have multi bank updates. However, this patchset
is still usable in its current form. We can later add the real A/B
functionality.

Apart from patch #4 where we are still discussing the finer details,
feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> [1]:
> https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/34d3de6f79550527746303e0bf6337fa37e31fe5
>
> [2]:
> https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commit/656d9e816bef85e586460a999cc7874255be9f1d
