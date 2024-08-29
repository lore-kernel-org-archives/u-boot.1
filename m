Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098D3C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC0788107;
	Thu, 29 Aug 2024 17:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KUJb7ckl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45D788107; Thu, 29 Aug 2024 17:01:47 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C2987BF4
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf7707dbb6so6489336d6.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943704; x=1725548504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OnliMOpLogzUJ2HZNU5G6L75dgCcPxeMPfIbQO1X33Y=;
 b=KUJb7cklxqVEsk0D7kIfL/VS3hnPStmlUt0GSTX5AXnIaR36OJaytuYim38ecRp1bf
 qvKhK9DN50OV3Hqg6TL40N/FlwU5yypq1QmZkbZeVCVKFz5z3R93181eH4R7AmKHQ1RQ
 RG3HmYuVziIV/mn8BVJu/vzB/DydMOVSm2hIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943704; x=1725548504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnliMOpLogzUJ2HZNU5G6L75dgCcPxeMPfIbQO1X33Y=;
 b=H+07rXIDdQ4v8gz6kOYAgT0OJsqtGDDssfDnppGkks3W4HjsFDPOGxqEIgIo91CfYY
 WauGkMFP2iKlLx2ZEewcylLZ4YyNQVQ5zOA+Yv+f/PmjF3p8tFNo4XveebWx+s7Fa04B
 W02ZJ9Qe8mOu64uwitSR/fBuT2xMwBO4f4U3B/kffFZLzATxwMQrA3UH/UPM3hgKXHyL
 1U16ZGVxFq1rD+aCp0Xfae9NnMyw1wGedXHlZbocuMVoAF02nMy0PFLPT/US2JB9ASGZ
 3ETY11WXs+S++SG114v8eXtxrt28rcCl+E0Qq0+v4uHU/zOCZvw/bYCw3khhIcGC9hyw
 rTbw==
X-Gm-Message-State: AOJu0YwrQzULqLA0VhQCPYhcMO2LBdED9bMgRj266wEL0+GNJko+Ccq8
 GCU5lC5EgA80FOkatjmAlSTU2AcBclkfhYKSx+7Vy4PhwnEyucJovXBOqwrjKo2EkptMYBsjo4f
 LjO5zFU4KKq6omL4K+hAG1ayq9XlNGMb5J8q+
X-Google-Smtp-Source: AGHT+IEPBSMOy09eWFa//Bs+879lYJyPzcl9710sqJdfvfbv7G2QZlTMCYL1eXiGPWeJnd7h4+/1TwrF9Uojq1A9sqo=
X-Received: by 2002:a05:6214:1946:b0:6bf:7efc:1117 with SMTP id
 6a1803df08f44-6c33f33d66emr48582356d6.9.1724943703910; Thu, 29 Aug 2024
 08:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-2-sjg@chromium.org>
 <904f71d4-b2b4-428b-bb2f-31fe6d916135@linaro.org>
In-Reply-To: <904f71d4-b2b4-428b-bb2f-31fe6d916135@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:33 -0600
Message-ID: <CAFLszTiJ_w72+U0Uba2kvVfKjPpQ+q5atydSajuExseY-L7WGw@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] test: Allow signaling that U-Boot is ready
To: neil.armstrong@linaro.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

On Thu, 29 Aug 2024 at 08:22, <neil.armstrong@linaro.org> wrote:
>
> On 29/08/2024 00:08, Simon Glass wrote:
> > When Labgrid is used, it can get U-Boot ready for running tests. It
> > prints a message when it has done so.
> >
> > Add logic to detect this message and accept it.
>
> So labgrid can boot and wait for `board_type & board_identity` itself right ?

Well, it just waits for the U-Boot banner. See Labgrid's UBootDriver[1].

>
> It's cool, but if the boots fails for a reason, what would happen ?

Several things:

1. It could timeout, meaning that it gives up waiting. In that case
any output the board did produce is shown
2. It could see invalid output, in which case it will likely complain
and fail (showing the output)

> Having the U-Boot pytest to parse the U-Boot boot log makes sure we can identify crash
> and report them in the pytest log.

It should work the same, or at least it does for me.

>
> And this adds a labgrid-only string to parse, which could potentially
> collide with pre-uboot or whatever log when not using labgrid.

It doesn't seem to. I made sure that {lab mode} is not checked
anywhere else in test.py

Regards,
SImon

>
> Neil
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/py/u_boot_console_base.py | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
> > index 76a550d45a1..882d04cd1e9 100644
> > --- a/test/py/u_boot_console_base.py
> > +++ b/test/py/u_boot_console_base.py
> > @@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
> >   pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
> >   pattern_error_notification = re.compile('## Error: ')
> >   pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
> > +pattern_ready_prompt = re.compile('U-Boot is ready')
> >
> >   PAT_ID = 0
> >   PAT_RE = 1
> > @@ -196,15 +197,15 @@ class ConsoleBase(object):
> >                                       self.bad_pattern_ids[m - 1])
> >               self.u_boot_version_string = self.p.after
> >               while True:
> > -                m = self.p.expect([self.prompt_compiled,
> > +                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
> >                       pattern_stop_autoboot_prompt] + self.bad_patterns)
> > -                if m == 0:
> > +                if m == 0 or m == 1:
> >                       break
> > -                if m == 1:
> > +                if m == 2:
> >                       self.p.send(' ')
> >                       continue
> >                   raise Exception('Bad pattern found on console: ' +
> > -                                self.bad_pattern_ids[m - 2])
> > +                                self.bad_pattern_ids[m - 3])
> >
> >           except Exception as ex:
> >               self.log.error(str(ex))
>

[1] https://github.com/labgrid-project/labgrid/blob/master/labgrid/driver/ubootdriver.py#L142
