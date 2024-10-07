Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6978BCFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC25A88D82;
	Mon,  7 Oct 2024 17:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KphOPFLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB7588D61; Mon,  7 Oct 2024 17:24:09 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B85886A7
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb2f344dbbso35892656d6.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314645; x=1728919445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OhuqJybY3WtgkyW67E50yfFoPjW9N0JQcc8/GW8eDUU=;
 b=KphOPFLL0+aZTRuAi2iuRVYEpeFaUKQpJyTQh12bGPqzBGUuVzoJukr2dwwQzv+hLA
 7DFbKph6LHWa8VfrbrYruzhJOQpkFMqetXuhQuCgEwMg5dmToB/vYiTfOOqZ9AHMY9Wu
 Y2MavEvOhkQUSnC7yYumOmvpVZ6Wp9oe8jwGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314645; x=1728919445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhuqJybY3WtgkyW67E50yfFoPjW9N0JQcc8/GW8eDUU=;
 b=fAnSrZS62QW+8DWLfViTyUFFik7FIs6w6TnQS5JBDJaepaCvP+YVZmS4rrZNAKBvRd
 cwx5TUtq+4nDDhbCgCvYmbUhmhxn+cuWmGg4ivIVbwCS+EtILU98MH1ez6ejz8tD9awE
 8gTtnnU5H6fUeO6JPl9+lWGo4jc+ih5LBnVFvpoEiBLj76ihWAsVnbi5mNxTBpQQJeAd
 IdPb9lhxtZ8JvtuH+LahIzB8ZOYyIyAZ//mmBAqSmb26dj8U2rHy3MQXbKCrvw5Lb1zS
 wTVDC43QXD4Gh+Ky94/izTynkI0sIZ9fuo4Elr+faVc+O7kAJZqBnbahgQm7ehkvgbLo
 tRrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp38EmNqN0YeJG5lcSYhEoGbXmpisJUMG/Y8Rg7ZQ1h9rcpUp6/wsk6j1rbAi96nNCML6C9hw=@lists.denx.de
X-Gm-Message-State: AOJu0YznzMWEPwtBGcKJdyJpFNHm+ZcbwtGVjlGqNDbVW9FNRX1YxQCu
 lKkY7yq+H+jwbFjx7AgKfwYkgFCC6PhWAhAVgBndXzt1/HGeOgatpA5PYtot4mioUcm7fAImCxx
 cWw/SN9sX5AfcRFIs2L87uS/aQPm4JwjVNCGDQCxHPsXxd+c=
X-Google-Smtp-Source: AGHT+IHaE9EQRctAwLBx4B9FynqN3UegJs4MOfF8ZwVe2WHOm5iv7dmwMCI1wP8IYwKAjzwHWJNOfEF63A4INIeTOPY=
X-Received: by 2002:a05:6214:3f83:b0:6cb:99db:bdbf with SMTP id
 6a1803df08f44-6cb9a4e7955mr194637386d6.43.1728314645061; Mon, 07 Oct 2024
 08:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
 <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
 <CAC_iWjLS21x3ZOGDnvWWj4y1Hfs_vuw=YnMRZCSAaL42mYYGXg@mail.gmail.com>
 <6d9bfd36-848a-4c9b-b5cb-929752bf3c7a@linaro.org>
In-Reply-To: <6d9bfd36-848a-4c9b-b5cb-929752bf3c7a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:52 -0600
Message-ID: <CAFLszTjGMeLky3xHAAn=52EsyayM7Ungb8ZD5f8gbobQ1zR8Ug@mail.gmail.com>
Subject: Re: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

Hi Jerome,

On Fri, 4 Oct 2024 at 06:01, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 10/4/24 11:37, Ilias Apalodimas wrote:
> > On Fri, 4 Oct 2024 at 11:46, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 10/4/24 08:55, Ilias Apalodimas wrote:
> >>> Hi Jerome,
> >>>
> >>> On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
> >>>>
> >>>>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
> >>>>  [...]
> >>>>  Scanning for bootflows with label '9'
> >>>>  [...]
> >>>>  Cannot find '9' (err=-19)
> >>>>
> >>>> This is due to the device list containing two less entries than
> >>>> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
> >>>>
> >>>> The actual use case is NET_LWIP=y (to be introduced in later patches)
> >>>> which implies DSA_SANDBOX=n for the time being.
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> ---
> >>>>  test/boot/bootflow.c | 7 +++++--
> >>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >>>> index 6ad63afe90a..c440b8eb778 100644
> >>>> --- a/test/boot/bootflow.c
> >>>> +++ b/test/boot/bootflow.c
> >>>> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
> >>>>          * 8   [   ]      OK  mmc       mmc2.bootdev
> >>>>          * 9   [ + ]      OK  mmc       mmc1.bootdev
> >>>>          * a   [   ]      OK  mmc       mmc0.bootdev
> >>>> +        *
> >>>> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
> >>>> +        * dsa-test@1).
> >>>>          */
> >>>> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
> >>>> -       ut_assert_nextline("Scanning for bootflows with label '9'");
> >>>
> >>> Shouldn't this under and #ifdef, IS_ENABLED etc?
> >>
> >> In theory yes, but we can avoid the conditional by using index 7 which is always
> >> valid, i.e., in all configurations we have at least 7 devices (even 8 actually).
> >
> > Ok, but I *think* Simon was trying to match the exact out put here,
> > not 'at least 7'.
> >
> > I think we are better off being strict on this test
>
> No because there are 10 entries according to the comment ("a" hex being
> mmc0.bootdev). Simon, what do you suggest?

I don't think this is a huge deal.

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, 'fewer', not 'less', if you can count them


>
> Thanks,
> --
> Jerome
>
> >
> > Thanks
> > /Ilias
> >>
> >>>
> >>>> +       ut_assertok(run_command("bootflow scan -lH 7", 0));
> >>>> +       ut_assert_nextline("Scanning for bootflows with label '7'");
> >>>>         ut_assert_skip_to_line("(1 bootflow, 1 valid)");
> >>>>
> >>>>         ut_assertok(run_command("bootflow scan -lH 0", 0));
> >>>> --
> >>>> 2.40.1
> >>>>
