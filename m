Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F928CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 19:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB4C83C2B;
	Mon, 11 May 2026 21:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lofsmtyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4414983E36; Mon, 11 May 2026 21:22:34 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602FB8394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 21:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67e43a8996fso5121820a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527352; cv=none;
 d=google.com; s=arc-20240605;
 b=Y9AemjtQpvFweUPNRWN6UuNBIAsizjK3zUzL/a8avRuNYU/KKkiShZP6GvZZTB3uwv
 MGCSPuehQ3q1b5dBmPE4wRfVpx+6KZXP8Bbd1KJieZE+EUfIE1JX/3LbircU6yCdljfd
 QWqPDjNm6Ih+FVJxwfCwSESGTSOo5KXeAyRhZoh37pQu77qg/EZtcf9wZtneLBE5XdAD
 d1frpWDWsTwgIZUunNh90rME285tK3hpeyjY/mvZHrkq4Ed/zLX5Q4bsPkngxJE58x2y
 PfUQ0JHVULvHiz258oaCVzobXcQs8JXSt4Hz2tyBY4lbgPbp5EMm+wW5w/Y/cv/sQ9kf
 /wUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E6YWwAc4X/KvpB3yyybxPyMeCumEyiQM1DT9qcri2rg=;
 fh=/9DbBFgKQb/qhaH44wXR2qbYR6QWht2YpdwJgF+82RU=;
 b=kDbFiOEwCno9onD1YG9+oT4GwJSIFnT/buBxxINyiISem8scTqXQ+9Oe8M1orPASAg
 XykBP1nV23CVT3VHbX9YaX4nVv8xADGqDQxhkRYWeD8TpfWCbdrmLmzTaC6BFOxl23Fn
 pJhu7IU8H82Xm6+c4Gt6LBN7qWV+GB6hF/W0Wjc6loSCqArR091J/zvQOp5csZgK9Xqg
 KNvSVpF0ELMrtedHJ3klhCTY3/fMaP7RyozoO2GL1YcYB19iJypvW65EsAPlEN8w4Ekq
 Zx9bVsFcrF8f6wm5VtLGp7jtpngC+PAny2L3DVWa1+7tkJizkcq5OO5NHT5ArnxqBa1/
 25aA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778527352; x=1779132152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6YWwAc4X/KvpB3yyybxPyMeCumEyiQM1DT9qcri2rg=;
 b=lofsmtyzyOLVCgZG2/q3r2brUoJNfzrnJWkW4bD74ZHhF9SZv5AuxXhuS01L7K3A8Z
 stL6VmNs568q2bCXsdmAPJck3IFoklSJfDwRSeC4ycq3pADPezyqwEtINEtMrR3o4WOh
 CxOpTNKnlTNb5xVDveo/9SXJiOmjU6CUmfHVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778527352; x=1779132152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6YWwAc4X/KvpB3yyybxPyMeCumEyiQM1DT9qcri2rg=;
 b=qQ6dWQaSVerm5MXq44EBEmlN8GY6H6vdnNftVUB7wyobrG67lSd8MLkBU9GRoq+Ch4
 pdu50kedwJ1K6y7Fj/rdYHrT/d5ibAywghYgRX7o8z2vcGHBRZ9pauaiQDeFBIYSYjPa
 o6kwRyvGfUv7fjF+y0IgTNSFszCdzxQ7ZQ548a3faKLBbaengb1wwiFSMHV2iErSj7qA
 xG6d7W76bOfNUSdUjHDfW9upsEJrvgPBfBlJhVo0+ivuJsds+K+bvIb6QzOrt+ZwVrNZ
 F3P8lpWWjE0+bQwbyNLUb5v56+4hlz2S3yi1PjPD86R+0c2gidOeTwRWj3HMB6cR7l/S
 zR6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o4JBM6IOULSCpz3D2e9z2g2xdvi/qXCBdLUfK0hzP8MZY4RjvzPyIilQRKu3duLuatWgFWjI=@lists.denx.de
X-Gm-Message-State: AOJu0YysJ8pb8qwHpt4xEDvNtNpaw8S90sGCp30fTGkkowImrjJDxjqJ
 Dv6CvTLTR0vzN7DqYqW3H1CzfSoNiaqr4XXvDj7chiiaTNdOuhyK/g/dB6ZpfojxiX9eXb4NlIJ
 fR4qPaWQjffc2557agXlpj6uiOPscKqwMAsxCiy+W
X-Gm-Gg: Acq92OF2KOsm7gf3ZETmmoFLIo0WjmIM4Rv3ZHOPdz7XypCdMU0K2gzdua7Vab1AHTW
 VSxKlwwcORLe8AkkfTv/cRnWIIeNH9dUUw4qSGSFW9iv7OKVkhGFLMD7UVtScyFkaP15eyq9fE3
 GYb7QlNH2V55S767B0YXBug0iy+9QhHOWXwIF3nE22lfhzu5iZcY9cvgAIQ7XF/TvAQLMmdlIE0
 jNVywyPO/0Zn7/yS3480ddS+r/7GIYDPqoDzej8C8kI/1WIUZpHjUDJdKvMahw8JiFhRD9A94fz
 8Q51iA==
X-Received: by 2002:a17:906:7948:b0:bbe:384e:4c4d with SMTP id
 a640c23a62f3a-bcc12764fb7mr674644566b.14.1778527351679; Mon, 11 May 2026
 12:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-2-rs@ti.com>
 <CAFLszTgDu56LqCfzXgZ2P=V6szOYytMSvj0LRn4u4S8YWOcEuw@mail.gmail.com>
 <DIG2J12J21HH.K196O8LVE6B5@ti.com>
In-Reply-To: <DIG2J12J21HH.K196O8LVE6B5@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 13:22:19 -0600
X-Gm-Features: AVHnY4LpcLBKzhixD5TRYEwCHGhG5iUdPhJOdVAzhCjxzyWFp5mdK3tLXDG7TEM
Message-ID: <CAFLszThDN1K8YeGDJ7siD=ywW+N42he1JKMnPmBVEOjP1hriGg@mail.gmail.com>
Subject: Re: [PATCHv6 1/3] sandbox: add board_get_usable_ram_top
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Mon, 11 May 2026 at 12:44, Randolph Sapp <rs@ti.com> wrote:
>
> On Mon May 11, 2026 at 1:26 PM CDT, Simon Glass wrote:
> > Hi Randolph,
> >
> > On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
> >> sandbox: add board_get_usable_ram_top
> >>
> >> Add a board_get_usable_ram_top definition, since currently ram_top is
> >> equal to ram_size. Attempting to actually map ram_size with map_sysmem
> >> results in a fault.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >>
> >> board/sandbox/sandbox.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >
> >> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> >> @@ -105,6 +105,11 @@ int dram_init(void)
> >> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >> +{
> >> +     return gd->ram_size - 1;
> >> +}
> >> +
> >
> > Please describe which caller actually faults on map_sysmem(), since
> > that is the real motivation.
> >
> > But this contradicts the documented API. From include/init.h:
> >
> >    The returned address is exclusive (i.e. 1 byte above the
> >    last usable address).
> >
> > See the weak function in common/board_f.c
>
> Ugh. Why is *usable* ram top exclusive? That's returning an explicitly
> *unusable* address. Fun. Suppose it's my fault for not reading that first.

It's just the way it is defined. It avoids lots of ffff's in
addresses. I know that ACPI tends to use the last valid address, but
that's not typically how U-Boot works.

>
> > If the real problem is callers doing map_sysmem(ram_top, ...) and
> > faulting, you could fix it in those callers (use ram_top - 1 when you
> > need the last valid byte). But I could take a look if you point to the
> > code.
> >
> > Also, this uses gd->ram_size as if it were an address; it should
> > really be gd->ram_base + gd->ram_size. It happens to work because
> > sandbox's ram_base is 0, but it reads as a type confusion.
> >
> > Regards,
> > Simon
>
> Fair enough, but it seems that this board definition will not be required given
> the above feedback.

Ah OK...but I'm still interested in knowing which caller caused this problem.

Regards,
Simon
