Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB749C7112F
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E55C86E7E;
	Fri, 18 Aug 2023 16:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="3uBeE83v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAD086BE8; Fri, 18 Aug 2023 01:49:20 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A80386BF2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 01:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomcherry@google.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so5296101fa.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 16:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692316157; x=1692920957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaGgBbZxGehuw4LzG417WFSfJbuRMN7+LJuQT1NuoOU=;
 b=3uBeE83vWGGjLNlLjaJ1iHYKGQ6QUkpjIBfqgaMAdJRg7btk5WNoZTlTnSRed1ahED
 oa7dEM/O+TMDNF0QavaWOYAtMdcjNkLaY7As4eHdDTsNuR6hMGpY4/eE3sOVhJlMBGib
 HNLTR+1Mf2dEJiO+L8djMngPf87iJAlwg62Xnjvt+mKeZoaYa4B+3QOZj6r08xUWMLqE
 aPKPcHtqNO1joiebxU3otNjWNyGMumLkMmPa2E3XbnPi+7FRnAjNgyG+0U/rxB2haGxz
 AQjjPpwnMMAQz06kp8j00l83PaGBBG3YyymadYEAZlL+ldLT8fgF6jcGOFwXZbXvdEPu
 eqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692316157; x=1692920957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaGgBbZxGehuw4LzG417WFSfJbuRMN7+LJuQT1NuoOU=;
 b=aMXDW6pEOAFiiTLx/lXFp2z6w3wK0kHN0MiaYWSIDbL8Lj+giltY+zqbTggvLIALM9
 o2Lqy62D6gAr+JgVgDc/ppIYHwOz/NlPPkEZ0+1OP6NL3DhkxnHT+gQYlWwCTqAhGPLM
 ZgrQFvJDFOhdj8p/PAKWlkQz4wDxeO1//EKBL6pHcBDWE+EnNUBxDPlF3OUvM80eP64s
 2ukALhFIlMV0Ivx5o58FuA+7hfEj2K7rRpnU9moyip0kp79+Bx+q4uJG3ecagIn+rBDW
 XyQSr8YuuK2LHdKpkY2uWX1uAI1NXh6IIGfWORV0Lt0ikivbWU2nvXstUzWYKU/9CuZY
 LX/g==
X-Gm-Message-State: AOJu0YyDp+51CMHizig+DuKhL7sGYeqKJTlZ7LIxj++sZMrAx518PMNv
 hKYqzJvNG9bCkk2P4TeSc5QYbJbefkIfghJ+5oRLtQ==
X-Google-Smtp-Source: AGHT+IFIuGLJnNx7c27TS6EWDI71hxDb6krpJ0VkLjF1TS/G7+PpWA3eellG4Bwut5QxmE0UInLd2zq3hspuRLIsXzA=
X-Received: by 2002:a2e:9557:0:b0:2ba:7fc2:cc4c with SMTP id
 t23-20020a2e9557000000b002ba7fc2cc4cmr544508ljh.24.1692316156519; Thu, 17 Aug
 2023 16:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230309021221.306044-1-paul.liu@linaro.org>
 <20230309021221.306044-2-paul.liu@linaro.org>
 <20230815144227.GI3630934@bill-the-cat>
 <CALG-KHwSCD=R-AFUHBCc4AxVEgyM37k8TH5aYSx9XSMnXcNXgQ@mail.gmail.com>
In-Reply-To: <CALG-KHwSCD=R-AFUHBCc4AxVEgyM37k8TH5aYSx9XSMnXcNXgQ@mail.gmail.com>
From: Tom Cherry <tomcherry@google.com>
Date: Thu, 17 Aug 2023 16:49:04 -0700
Message-ID: <CAPc65awXjZhnZk2dAU2YLnumOmM8KVrB5G9mECvL6CV_oU9=Pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib/vsprintf.c: fix integer overflow in vsprintf
To: Paul Liu <paul.liu@linaro.org>, Alistair Delva <adelva@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 18 Aug 2023 16:38:09 +0200
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

On Tue, Aug 15, 2023 at 8:33=E2=80=AFAM Paul Liu <paul.liu@linaro.org> wrot=
e:
>
> Hi Tom,
>
> Yes, I think Rasmus is correct. I didn't have any real cases that can tri=
gger the bug.
> So let's don't include this patch. I'll see if I can revert this in AOSP'=
s branch.
>
> Yours,
> Paul
>
>
>
> Y
>
> On Tue, 15 Aug 2023 at 22:42, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Mar 09, 2023 at 10:12:21AM +0800, Ying-Chun Liu (PaulLiu) wrote:
>>
>> > From: Tom Cherry <tomcherry@google.com>
>> >
>> > vsnprintf_internal() adds 'size' to 'buf' and vsprintf() sets 'size'
>> > to 'INT_MAX' which can overflow.  This causes sprintf() to fail when
>> > initializing the environment on 8GB.
>> >
>> > Instead of using 'INT_MAX', we use SIZE_MAX - buf, which is the
>> > largest possible string that could fit without overflowing 'size'.
>> >
>> > Signed-off-by: Tom Cherry <tomcherry@google.com>
>> > [ Paul: pick from the Android tree. Rebase to the upstream ]
>> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> > Cc: Tom Rini <trini@konsulko.com>
>> > Link: https://android.googlesource.com/platform/external/u-boot/+/43aa=
e5d4415e0f9d744fb798acd52429d09957ce
>>
>> So, this link here leads back to
>> https://issuetracker.google.com/issues/200479053 which isn't public.
>>
>> Rasmus followed up and asked pointed questions, that weren't followed up
>> on.
>>
>> --
>> Tom

Hi all,

I hadn't seen the questions from Rasmus, and I haven't had much time
to dig into why this issue happened. I'll try to get time for this in
the upcoming weeks.

I originally triggered this bug in a real-world use case. I was unable
to boot my platform before this patch and I wrote this patch to solve
that issue. I reverted that patch and tried booting my platform today
and I am able to boot however I see error logs that are not present
when this patch is applied (the below "Partition 1: invalid GUID"),
which suggests that there are lingering issues, which I'll
investigate.

With the change:

U-Boot 2023.04-maybe-dirty (Jan 01 1970 - 00:00:00 +0000)

DRAM:  8 GiB
Core:  8 devices, 8 uclasses, devicetree: separate
Hit any key to stop autoboot:  0
ANDROID: Booting Unlocked!!
## Android Verified Boot 2.0 version 1.1.0

With the change reverted:

U-Boot 2023.04-maybe-dirty (Jan 01 1970 - 00:00:00 +0000)

DRAM:  8 GiB
Core:  8 devices, 8 uclasses, devicetree: separate
Hit any key to stop autoboot:  0
Partition 1: invalid GUID
Partition 2: invalid GUID
Partition 3: invalid GUID
Partition 4: invalid GUID
Partition 5: invalid GUID
ANDROID: Booting Unlocked!!
## Android Verified Boot 2.0 version 1.1.0

Thanks
Tom
