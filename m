Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF15C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62824877E2;
	Wed, 27 Dec 2023 15:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BMK6OAVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D9087823; Wed, 27 Dec 2023 15:58:45 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A866A877B1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e7dff3e9fso1930265e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703689123; x=1704293923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ye9hxg/I539tPxsI8zfEVRYLWRTnYba5TjLGVHjh/bQ=;
 b=BMK6OAVr3sHLyfEMBMM5YH5PsCQcCQHuhp3ON/KsaBMkScYNNWcHdyEzHFbsmDEKIm
 oqKiGobFQuMHXv7VPexZfoZ6cWCASZCnwQxodG2TLHzcmJ/MB/CmvgRFW6ch5UQ4hEMM
 1kz4Vzv/S1vYA38xd+zorlt2NCu3ZJMF4TR8IkSKFyaXpL7v0X+0S4wh+TOCYGDCLWTe
 dVEA0TV14IKeSILmVtIwPj//jMNNRrbwZaYcEXntqXNNulmLdvo9z8u057Lqls/akef+
 VdLhDP/p9mYvpLDrLC6iL6aH82ChlmsseUvKSlMUQvk8sD5fwltP7Es4t+0anTX72/rq
 afQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703689123; x=1704293923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ye9hxg/I539tPxsI8zfEVRYLWRTnYba5TjLGVHjh/bQ=;
 b=oXdtT8kjmI6bWL1MLyPOJ1Ra187h+K/LPMRPKBxQdpmYECTc5/1L7DBL7bXMhuJqKY
 fSdI1WpCf6OwxVh19nTBHJluEMHBpgPKg67gj/JZDxtI2ZGH47bBMU/BBlS5ZsyTDojz
 3cYliiEAA6dKLE0wXKnK0cqlRcsfSkzluAM1F00IC6o5yM58dULWz/GMU82i3TzqSMxB
 eHeOT3GoL97PLAVc6NS/xKJb2XzL7yGs3fIj7xGg/W+pQ5XGEIAM5FSYbnrxVqCIP/A9
 eSyOsY6UHxjVrk8jPcTy3RflYBFw4xydYXp1oS3gYp/4oJPCkkEMb5RCJVl/QT5MZbg0
 n1Rw==
X-Gm-Message-State: AOJu0YwfijpiePH7Bu7xNwa2p1rAZxbojbBSyM/9k/nbWBHQMnJ8oCWR
 2/l7ELlQV9/7bKDLmP3Ks30Lj7M4lVjEctjGInQ1H4jKBviekQ==
X-Google-Smtp-Source: AGHT+IEIPgLqV1H4uJHgypDtgtDDImNN0W4T2RO1ZKfKJ0iShK93uxzHNNavpLnsi9bJD4wcM8SJbYd1t2oUr01rtEQ=
X-Received: by 2002:ac2:5f67:0:b0:50e:4ec6:ed15 with SMTP id
 c7-20020ac25f67000000b0050e4ec6ed15mr3326313lfc.107.1703689122886; Wed, 27
 Dec 2023 06:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-12-raymond.mao@linaro.org> <ZYv5wc_D1VgRcQKw@hera>
 <CAEfUkU+4ePLot_81gx7JH4Fcs=qPxa-jCSEDrEXswwbHA+uyQQ@mail.gmail.com>
In-Reply-To: <CAEfUkU+4ePLot_81gx7JH4Fcs=qPxa-jCSEDrEXswwbHA+uyQQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 16:58:06 +0200
Message-ID: <CAC_iWj+fU6kVZd2Eq6y+mw65Y3mRvq3GUkE=0Ci5WvJMvqUC+w@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] bloblist: Adjust the bloblist header
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 16:50, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 27 Dec 2023 at 05:17, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>>
>> [...]
>>
>> > - * @chksum: checksum for the entire bloblist allocated area. Since any of the
>> > - *   blobs can be altered after being created, this checksum is only valid
>> > - *   when the bloblist is finalised before jumping to the next stage of boot.
>> > - *   This is the value needed to make all checksummed bytes sum to 0
>> >   */
>> >  struct bloblist_hdr {
>> >       u32 magic;
>> > -     u32 version;
>> > -     u32 hdr_size;
>> > -     u32 flags;
>> > -
>> > -     u32 size;
>> > +     u8 chksum;
>> > +     u8 version;
>> > +     u8 hdr_size;
>> > +     u8 align_log2;
>> >       u32 alloced;
>> > +     u32 size;
>> > +     u32 flags;
>> >       u32 spare;
>> > -     u32 chksum;
>> >  };
>> >
>>
>> Aren't fields still missing from the current version?
>> e.g max_size and reserved?
>>
> They are all in. Please see:
> [PATCH v3 14/14] bloblist: Align bloblist used_size and total_size to spec

Ok. But why aren't we squashing this to #14 then?

Thanks
/Ilias
>
> [...]
>
> Regards,
> Raymond
