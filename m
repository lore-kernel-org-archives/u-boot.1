Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6322C71156
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 15:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDDC86AC2;
	Fri, 18 Aug 2023 17:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TVOHuc3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A146D86AC2; Fri, 18 Aug 2023 17:00:09 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02FF8522C
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 17:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff9b389677so1484387e87.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692370802; x=1692975602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=llsZvzD6cRnuvxnQcKZycup/elJHks9TtS96HYlYIQ0=;
 b=TVOHuc3nS2Wx+VsFLUx0qrq/rLRoKpK4snA7rB8Z9PmzmwrcYSBzANyrfPAsIwQknt
 dRRZRzCWbR8lTPZlF0xR62Ei4aa0U1i3naGcxGza+4rlS4j0uKIiE0pgVWI/kgTOXDD6
 klSp3fcm5DMjpWhPswzirIXigg4bWnv0JxyfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692370802; x=1692975602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llsZvzD6cRnuvxnQcKZycup/elJHks9TtS96HYlYIQ0=;
 b=b89isSDfTvWjk3Lh3vXDR9IWIBGdNPTt9QGb4pgO7NS9iFHeL2V8UYWRvhwI1EsRqE
 E1b54mU71at6Il6Hk292aHyCJIuRnHLaF1b7WQ6TWStIh+o+Vb5LD558rAidA2WDsd4h
 oLVkdKha/S8ENXEevC4C7L2Geygaiv5LY5aBIeyBo1Jb4q+PENR3uFZyPeuYFLxiBJH3
 ITLTCSQugo4FagtaL1eiAhMYUWz74+Bmkd+VIuz65j5pQ0RJe+zv22RAEhTW/7XPlSAD
 kQdBOp9aXtWdffbpahybLYU4OvTc+l5Rc3y6ExXgfb4as+AU4epym2lHTtU+R0IVde7t
 AjtQ==
X-Gm-Message-State: AOJu0YyiXUZxq224Uvj7WICEvz+2GtUP5G9DPXzUqnPB5qHd2bRhr5pi
 B6kfqJZznYTOORHHVvmzgiDCP4b429x2GXsua4zWcA==
X-Google-Smtp-Source: AGHT+IHsh1bLojCUOomU6vuGrkxQgmqFeKkYOIjnKbvpxH7S5hTc/89W3jtTqDC2sN5WVB9mUI5R7Gh/5j1sb55EZQ4=
X-Received: by 2002:a05:6512:2215:b0:4fb:745e:dd01 with SMTP id
 h21-20020a056512221500b004fb745edd01mr2607971lfu.45.1692370801446; Fri, 18
 Aug 2023 08:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
 <877cpusybz.fsf@meer.lwn.net>
 <CAPnjgZ3Lo4Na7YeKPFaY30bwsv_gBGapN_DXeab+k7yhCF3uww@mail.gmail.com>
 <dfac4932-7cbc-3a4e-bde7-c2048516ddf1@gmx.de>
In-Reply-To: <dfac4932-7cbc-3a4e-bde7-c2048516ddf1@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Aug 2023 08:59:50 -0600
Message-ID: <CAPnjgZ07G=+QZU9+qT23x+aZw4VES0jNkXUTu4Axm400NF-hzQ@mail.gmail.com>
Subject: Re: Doc style for method functions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonathan Corbet <corbet@lwn.net>
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

Hi Heinrich,

On Thu, 17 Aug 2023 at 10:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 16.08.23 19:47, Simon Glass wrote:
> > Hi Jonathan,
> >
> > On Wed, 16 Aug 2023 at 11:15, Jonathan Corbet <corbet@lwn.net> wrote:
> >>
> >> Simon Glass <sjg@chromium.org> writes:
> >>
> >>> Hi Jonathan,
> >>>
> >>> I would like to do something like this:
> >>>
> >>> struct part_driver {
> >>>     /**
> >>>      * get_info() - Get information about a partition
> >>>
> >>>                ^ causes error
> >>>
> >>>      *
> >>>      * @desc: Block device descriptor
> >>>      * @part: Partition number (1 = first)
> >>>      * @info: Returns partition information
> >>>      */
> >>>     int (*get_info)(struct blk_desc *desc, int part, struct
> >>> disk_partition *info);
> >>> ...
> >>> };
> >>>
> >>> But this gives:
> >>>
> >>> scripts/kernel-doc:292:
> >>>     print STDERR "Incorrect use of kernel-doc format: $_";
> >>>
> >>> Without the brackets on get_info() it works OK. What is the purpose of
> >>> that check, please?
> >>
> >> That's how the kerneldoc syntax was defined, well before my time as the
> >> maintainer.  This could be relaxed, I guess, but one would have to look
> >> at the parsing code to be sure that the right thing happens all the way
> >> through the process.  I'm not entirely sure it's worth it...
> >
> > I see. It is inconsistent, since we use () after normal functions.
> >
> > I think I can fix it just by removing that check.
> >
> > Regards,
> > Simon
>
> If the structure element in not a function pointer, we probably still
> want to forbid adding parentheses. Just dropping the check might not be
> the solution.

Is that the purpose of this check? Is it likely that someone would add
a bracket immediately after a variable?

Regards,
Simon
