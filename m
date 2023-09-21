Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE8CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 07:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648EB86784;
	Thu, 21 Sep 2023 09:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IB+7qTPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F42B864E9; Thu, 21 Sep 2023 09:10:10 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2492B86784
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso67919666b.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695280207; x=1695885007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y7Hnl1GpfGFys+QFYFycZgz/GBcey6SURxC954qouYI=;
 b=IB+7qTPVTBGe72ncjnjBPUllLJmAWMUZA68bA747N0osh/bZOz9sWmfCcfDExlqfHa
 7vUh2WtZOrk60JwbFOor/YP6ltZYl6s/BxFXSX+Pzb95ZINqf6z62C+bW22UReh9UybP
 KWtmLV7JRhymSIrMrCUWm34jWKm57xGHbnvPGBqntS9ffE9gWIK2TehH6FfrQ92doMhm
 DzJsbXgXeNA2sH2iqMb9GhM8OSGxEx6LsKQZxpCK+9g4X8gyQXlb8SHSUEfpDd4dYQd1
 1jCAEfMJ1TAZVZi0aKW3d7g8yoxXZ1jcsH31gIAcOC1/toc8gLB4jVBmiPjuR/KOeib+
 lkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695280207; x=1695885007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y7Hnl1GpfGFys+QFYFycZgz/GBcey6SURxC954qouYI=;
 b=bS11JeEt0r3jln4bbKVNtTFPt/ZkCt2b+tjlhEWg1IxJ8yhDAWceWsgIxKhLettJ6A
 ATBqompQcqLKfS841OTA3bAlvAPTjwmSJ5ZIK49yqk+Imi2aRN3EknSbeE8y55tOyQ3+
 OCdROL3pi1vknkx9wbFvQNILrDx9Bc/sfGYG4j/3Lv46jrr01DsKowS71WuHcHSA8Ujf
 0/NjixAJSllO4dMPHEOod4EpcaKLQANTGvUacy/zlsdVKM9KY5XDeM+/eRxGbKJNKu/I
 NdQ/VsFnL77A6ArWl9g9m6cbDMQI6LvFnJOQyUxVLLVE+8gHEwCbQkNR4yRDr80UnhDh
 cEdw==
X-Gm-Message-State: AOJu0Yx1fIyswSjQFClCmMwQm366yvPnx03sWkrzefYGnOpUlRN/NTKo
 DuBC56PKCQAQwt3zuH5wVj28f9vGnXjyA4P0wEvwOQ==
X-Google-Smtp-Source: AGHT+IEVTbtt7SOQD82i+qlNU9H0E9r858Prcbp+2PcIrZ/bsR97JcblUWZ8+2zkpRzFgWR0v79Lk/sKxt/ZC+v2RGY=
X-Received: by 2002:a17:906:2012:b0:99c:b0c9:4ec0 with SMTP id
 18-20020a170906201200b0099cb0c94ec0mr3748284ejo.30.1695280207583; Thu, 21 Sep
 2023 00:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
 <20230914161828.3662-2-maxim.uvarov@linaro.org>
 <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 21 Sep 2023 13:09:56 +0600
Message-ID: <CAD8XO3b3VMCwOBsU1fHGiF7VeGSSFd6qKgK8B5HhdCHOtF2sWw@mail.gmail.com>
Subject: Re: [PATCHv9 01/15] submodule: add lwIP as git submodule
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 21 Sept 2023 at 07:06, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Thu, 14 Sept 2023 at 10:20, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> > add external lwIP library as a git submodule.
>
> Oh dear...what is the motivation for using a submodule?
>
> Our current stack is nicely integrated into U-Boot. This would make
> moving between development branches much more painful.
>
> I would much prefer that we bring in the necessary code, and that you
> send a patch every 3 months or so to deal with updates, making sure
> there are no code-size regressions.
>
> Regards,
> Simon
>

I would like the project maintainer to make the final decision.

And this time I'm trying to understand how lwIP maintenance works. And how
long does it
take to merge a patch to lwip. For the latest Ilias comment I did a fix to
lwip, which is pending.
https://lists.nongnu.org/archive/html/lwip-devel/2023-09/msg00004.html
and created a bug with the same patch:
https://savannah.nongnu.org/bugs/?64697
And it's interesting when patches get merged.

Also there is a long list of not yet accepted patches (86 open items):
https://savannah.nongnu.org/patch/?group=lwip
I am afraid that if lwip patch acceptance will be too slow it also can slow
down U-Boot development.

Best regards,
Maxim.
