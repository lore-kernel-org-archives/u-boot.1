Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45543C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 11:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F8F881F1;
	Sat, 20 Apr 2024 13:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rAMLJ+dX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01B2881F6; Sat, 20 Apr 2024 13:58:20 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8589188074
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 13:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516ef30b16eso3599462e87.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713614298; x=1714219098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/OUvx91eakPbLcsmO47211eTUSoP2f254AVE64AYmQg=;
 b=rAMLJ+dXzRDyGfxWFbxkR1l8qTvQkZ/Y3frA5WGBswp+6TYv6olsA+0qtcpz5g0mdf
 Y+u8ULFFiV4K/2e6rgYIBOMSu2wx1QG/pGtk6lsyHuSJOF9OvOWopnYxamyuN6w0ycl2
 4y8gaC0ZRajS8XwFhc2L2Hw2TLEsEVOvQm8wRPpsYZsyXX2smZsSF7x8QANtw6u64Elp
 Bz99QGCDD7bEJ4VyEpwUGf5nlun3ur6VQ3P8avpeIv9UK95/MF0y3tzrehz5yFTPGjvb
 PQhIuBZ0S+A0+BEkTgbKo0kTIO3sULSR1ZrWWQMhiCnQFQY6zn8W00frKsGaOyOn/Drg
 lnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713614298; x=1714219098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OUvx91eakPbLcsmO47211eTUSoP2f254AVE64AYmQg=;
 b=JV/10I1bMQJ0DfSTmZqeJHWLi88csChZGT3y7CmwsN1Zr1yf20tkgHOgd1n2zM3L31
 2l1vQO1jIn2/VKhTHSbLGiihzP8uZSHCNe/DAN9bj0cEgupLBfrQXwuZWnYA3I1/Z1+C
 YcTqK34M+xn8cK/pVnlf3pTBBFJbM33j7BVOW/APz/uakXMR87u6w5iO/hH6QG6S1f/u
 FRf0VVSrgkdwl3iD3plU31raRJWuGrYd+Xud/guLgTnQRcO+OwsmSIFV13giOvW+KDu7
 cblZVclSlhrERrIKHX9Vvkfj9iNiO46QCcQ2v1dSwoqGd+sJX5etllw5l+RdDaNfr8nX
 bVTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjCKooHyZ+MRZygRnBKvOwvuLmuRkV6+ZHDs9OkmdZV3y0PMMtoXPuRnHdRvlkvkLi9KNEbYQbzgYj/lhq4LjnJMe7AQ==
X-Gm-Message-State: AOJu0YwaNEv5QzjVpFH4/u7kkQMMGYVKnFgSYxG8BA3nZ3nKlGbkHVlI
 FaKGEbolXxhN73loqBUYO26sIl1+MtQ3gp+0cItbObHf2RvvoglhGgiKqh67AWSZLQxTs50O9kn
 uoPqAPjvy9NdpKyBOO8VgyOfek96wjyWYEDfKjA==
X-Google-Smtp-Source: AGHT+IHFIk9JFQ4bGBFCg2YOmRBp8/0XjkJYAy8/KIw8AH16/NCWzXw2qN8woAV0MKYYfL7v/IiRKPSj9r4zrpAWzIM=
X-Received: by 2002:ac2:4eca:0:b0:518:c564:1089 with SMTP id
 p10-20020ac24eca000000b00518c5641089mr2749496lfr.52.1713614297634; Sat, 20
 Apr 2024 04:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
 <3fd5c650-293b-482a-8f23-7ecdb28bc4c3@gmx.de>
In-Reply-To: <3fd5c650-293b-482a-8f23-7ecdb28bc4c3@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 20 Apr 2024 14:57:41 +0300
Message-ID: <CAC_iWjLZ-PgV-cbhNKq_JEMKKQtow4PArjEZdOJp5f9H_5dkFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4]
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org, 
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com, 
 pjones@redhat.com, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, 
 Janne Grunau <j@jannau.net>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, kettenis@openbsd.org
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

On Sat, 20 Apr 2024 at 10:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 4/18/24 14:54, Ilias Apalodimas wrote:
> > Hi!
> > This is v3 of SetVariable at runtime [0]
> >
> > Nothing changed drastically from v2.
> > A few more test cases have been added, comments/suggestions have been
> > addressed and a bug where deleting a variable by setting 'attributes' to
> > 0 has been fixed.
> >
> > Changes since v2:
> > - Add more selftests checking for variable deletion as well as the
> >    VarToFile header format
> > - Use unaligned sized variables on tests
> > - Add a new function to get the variable entry length instead of
> >    repurposing efi_var_mem_compare()
> > - Converted VarToFile to RO
> > - Added a few comments requested by Heinrich
> > - Fixed a bug where SetVariable with attributes set to 0 did not delete
> >    the variable but returned EFI_INVALID_PARAMETER instead
> > - Run FWTS 'uefitests' and attach the log in patch #1
> > - Added r-b tags from Heinrich
> >
> > Changes since v1:
> > - Instead of Creating VarToFile at SetVariable, create it on GetVariable.
> >    This allows us to get rid of the preallocated RT buffer, since the
> >    address is user provided
> > - convert Set/GetVariableRT -> Set/GetVariable at runtime
> > - return EFI_INVALID_PARAM is NV is not set at runtime
> > - Heinrich sent me the efi_var_collect_mem() variant
> >
> > Changes since the RFC:
> > - Return EFI_INVALID_PARAM if attributes are not volatile
> > - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
> > - Add 2 EFI variables and allow userspace to write the file
> > - Add selftests
> >
> > I also have a patch enable QueryVariableInfo [1], but I don't want to
> > introduce new patches now. This also needs a few more testcases of its
> > own so I'll send it once we finalize this one.
> >
> > [0] https://lore.kernel.org/u-boot/20240417101928.119115-1-ilias.apalodimas@linaro.org/T/
> > [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/ce35270aaeb93686d7e013f3b028808e8af88cc0
> >
> > Regards
> > /Ilias
> >
> > Ilias Apalodimas (4):
> >    efi_loader: conditionally enable SetvariableRT
> >    efi_loader: Add OS notifications for SetVariable at runtime
> >    efi_loader: add an EFI variable with the file contents
> >    efi_selftest: add tests for setvariableRT
>
> I am missing a defconfig change which is needed to run the unit test in
> Gitlab CI. I would prefer testing this on the sandbox.
>
> Best regards

Ok I'll send a followup since you already sent a PR with these

Thanks!
/Ilias
>
> Heinrich
>
> >
> >   include/efi_loader.h                          |   4 +
> >   include/efi_variable.h                        |  16 +-
> >   lib/charset.c                                 |   2 +-
> >   lib/efi_loader/Kconfig                        |  16 ++
> >   lib/efi_loader/efi_runtime.c                  |  42 ++++
> >   lib/efi_loader/efi_var_common.c               |   6 +-
> >   lib/efi_loader/efi_var_mem.c                  | 151 ++++++++-----
> >   lib/efi_loader/efi_variable.c                 | 122 ++++++++--
> >   lib/efi_loader/efi_variable_tee.c             |   5 -
> >   .../efi_selftest_variables_runtime.c          | 211 +++++++++++++++++-
> >   10 files changed, 495 insertions(+), 80 deletions(-)
> >
> > --
> > 2.40.1
> >
>
