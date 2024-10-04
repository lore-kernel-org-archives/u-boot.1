Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F39CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 09:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF9C88875;
	Fri,  4 Oct 2024 11:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2+2jYsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DE588580; Fri,  4 Oct 2024 11:38:15 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F558899C
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 11:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db1f0e1641so572528a12.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728034692; x=1728639492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xYnTS8RHQM3oXL3sRihWNXdysht3eLew3mo97X/d/0k=;
 b=h2+2jYscopcpRWeK+OnDBKz5tdyicv+N1K+3KtnL7E4F+WA0fHQwBSUsfyPRaKS2WS
 Ej2SAF4CCJn+XiovjnW1Tded0RdihIAmpWYYTMeVO7+QsDZjuaYpUEf4CUmnBMzZUS6R
 voCU+x0E85XvtZuOlUuhtn9HbJW3YhWDXRv9f9+fiWhNsZ0/zgetunGnwg3avOYJP8wv
 CLAmwzDTJOO4dooPRA1S4AhV4zqYFTkHfMKmlKDCx+g9G+1oDu5NM1oZxhcizguP0eAo
 0Um3Cn9R8tXkDmMvH3RRkJdVMtMLx3MA/7u9Ye0/GmVwXPITyTiQXNCtSppknew9C/9l
 q2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728034692; x=1728639492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYnTS8RHQM3oXL3sRihWNXdysht3eLew3mo97X/d/0k=;
 b=gBBgXIWZjDHCeNAGoLfuFlQx5wKptm2Wa//DD0y2bAVKBlTEhShO2GiA02kLF0IiAP
 ixNVMV2j/2jf9B3jIWZnCSM9Vy3hJEZTt6vF0V2vfiwjtyc2ec0DT5+WqjsJAPSPT5pp
 kq33QuF1gXxXhNE34kJyFXyLzpgfE6m875AIaOQe0qEcTd67/2rxdr81zKuxyv5S+Zc3
 DumYh24aSA05e4TEK4CazP9yVgZOolUQL+VDZnFTDpqA4spscqibGWhkbYbso2vq3o7e
 YACdPsACfWx5bSwk/zc2V3dMT7CRsVm5v4TzKQQ+UtdOOUmJa7sOz4LiiKSS4GyshaQK
 w9yw==
X-Gm-Message-State: AOJu0YwFLYMUucpBHKEATlXE2U6GfMZj9Eys5ZSjihuoD91ANkNnQcKr
 WOjHA7oN0CLFh+UB9eryKzJBiCDhteDd1emOHcXDAVON/g6I4QuVUTbK7hutKaEbqdXKXDiQdtR
 NXQ/A3xH73tVwho406t9Cp+lIpRowFmvG1ndSgw==
X-Google-Smtp-Source: AGHT+IHzc1W9JlyawXB+nBpMh1Rs4/15DP42V57PAR/XqBEEFCGzOC9o89f9mXnsgXbnDTwY01s6U4ZLmjp4/muYrAY=
X-Received: by 2002:a05:6a20:e615:b0:1d2:e8a5:689b with SMTP id
 adf61e73a8af0-1d6dfa38d59mr3193004637.14.1728034691692; Fri, 04 Oct 2024
 02:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
 <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
In-Reply-To: <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 12:37:35 +0300
Message-ID: <CAC_iWjLS21x3ZOGDnvWWj4y1Hfs_vuw=YnMRZCSAaL42mYYGXg@mail.gmail.com>
Subject: Re: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
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

On Fri, 4 Oct 2024 at 11:46, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 10/4/24 08:55, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
> >>
> >>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
> >>  [...]
> >>  Scanning for bootflows with label '9'
> >>  [...]
> >>  Cannot find '9' (err=-19)
> >>
> >> This is due to the device list containing two less entries than
> >> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
> >>
> >> The actual use case is NET_LWIP=y (to be introduced in later patches)
> >> which implies DSA_SANDBOX=n for the time being.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  test/boot/bootflow.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> >> index 6ad63afe90a..c440b8eb778 100644
> >> --- a/test/boot/bootflow.c
> >> +++ b/test/boot/bootflow.c
> >> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
> >>          * 8   [   ]      OK  mmc       mmc2.bootdev
> >>          * 9   [ + ]      OK  mmc       mmc1.bootdev
> >>          * a   [   ]      OK  mmc       mmc0.bootdev
> >> +        *
> >> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
> >> +        * dsa-test@1).
> >>          */
> >> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
> >> -       ut_assert_nextline("Scanning for bootflows with label '9'");
> >
> > Shouldn't this under and #ifdef, IS_ENABLED etc?
>
> In theory yes, but we can avoid the conditional by using index 7 which is always
> valid, i.e., in all configurations we have at least 7 devices (even 8 actually).

Ok, but I *think* Simon was trying to match the exact out put here,
not 'at least 7'.

I think we are better off being strict on this test

Thanks
/Ilias
>
> >
> >> +       ut_assertok(run_command("bootflow scan -lH 7", 0));
> >> +       ut_assert_nextline("Scanning for bootflows with label '7'");
> >>         ut_assert_skip_to_line("(1 bootflow, 1 valid)");
> >>
> >>         ut_assertok(run_command("bootflow scan -lH 0", 0));
> >> --
> >> 2.40.1
> >>
