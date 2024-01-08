Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CB1C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9723E87AC9;
	Mon,  8 Jan 2024 01:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJHQJs9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3746687AA4; Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5673087AB2
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7811db57cb4so114155285a.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672993; x=1705277793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f2jLLPT7m1Fnrc0QYY1m5vDz3vy2YnZjIv/ZO0hJ9rc=;
 b=cJHQJs9c2fkY3v+f4WAjkPbncOFasH8uF40eOy7mwm1JeA0BPs+GLFSUr+2qPS4rBu
 60a703Fje5BXXfnzHQ7DWu416pmlBRa70duHFE5Rih/mXdpflXJP2Um7+FSQXP5wpeIt
 7h5onDqTpLzSj/c8iWoZZjtCcfvyeoH8Qz4fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672993; x=1705277793;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f2jLLPT7m1Fnrc0QYY1m5vDz3vy2YnZjIv/ZO0hJ9rc=;
 b=HU9znDIBVu7LqrxzWH9KZcXIfGmeD+HpwW4r9DiNdTiSzTrsfGMTc/iQOagiNuZDQl
 vFYEjjWCymmHSfaQGyXXzbFdUigGD1wNrmtZYW1zqSEjvvGLRAEdI+sUudub4aSlwB1s
 sQPqhdFL1QZNfs/DvHgZlnlMwUrLzJbTfnmTicpPR1k+yxjWEV9Bd6jxB7aOClgY3IUx
 gNpHTLuHQuix2HSD2Q2JD03VScDFI0OkQeWiojrSlVj6/BELRKs0NqhsWKAEJCIbOppt
 cARIDkDZysF0FlR62AtoSoHXP7PSj9XmKHJLMXStARKpqCFfuqzpVMzEWzSuwPvLorLq
 Tb3Q==
X-Gm-Message-State: AOJu0YwlaMSdLRAAfp/aiFvIjGSY6EoYI2ITEOXysVrGno3WXtcX64xU
 HHcgQkEzXTl6GkqPVwpMVpFeDcrJT3+khwC6gHqnna9p0aMp2ud35dcOAKJSpw==
X-Google-Smtp-Source: AGHT+IF1KozxGbDKMLYrvldqyRJr5OuVSmDVQKLWsdOVMFKRzDqWHs+JBudni4x55cQchU8Rxe39oZMnWnKp19KUxik=
X-Received: by 2002:a05:620a:1a1a:b0:783:18f9:b76b with SMTP id
 bk26-20020a05620a1a1a00b0078318f9b76bmr3369199qkb.51.1704672993113; Sun, 07
 Jan 2024 16:16:33 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:32 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1bfAk1f3Y1jy-5K_-waSG328wZSPKbh-2_ELa22Weeow@mail.gmail.com>
References: <CAPnjgZ1bfAk1f3Y1jy-5K_-waSG328wZSPKbh-2_ELa22Weeow@mail.gmail.com>
 <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2=Qd=u7z90nYXRXNUBK6Sdu4iDiBmT00OJMi0FU1_nbA@mail.gmail.com>
 <aff5eac1-3f76-4d3e-92e5-9554c5b6340a@canonical.com>
Date: Sun, 7 Jan 2024 18:16:32 -0600
X-Google-Sender-Auth: GS_s6Ew_s6kADxSw25A3pHBepBQ
Message-ID: <CAFLszTiQBdDiuRUs2yzhuf_CsGewihj3Yx=WXb9f63Pj2wY2-A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] acpi: support 64bit in acpi_find_table for DSDT
 and FACS
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 16 Dec 2023 at 12:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/16/23 19:45, Simon Glass wrote:
> > On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Use X_DSDT and X_FIRMWARE_CTRL if available.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
> >>   1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > This could really use a test
>
> I guess we want a test on library level separate from test/dm/acpi.c as
> this test will not be driver model related?

Yes, but it isn't that important. I have been moving DM tests to only
differ in their flags, so I'm not sure there is much difference
anymore.

Regards,
Simon

Applied to u-boot-dm/next, thanks!
