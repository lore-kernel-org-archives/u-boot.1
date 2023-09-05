Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C944CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B819D869DA;
	Tue,  5 Sep 2023 20:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WvWDP3y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0652C86580; Tue,  5 Sep 2023 20:17:08 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CB1869D8
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so4016674a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693937825; x=1694542625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T5Pi0ofhHHBwxBYV1AwBDL00n/hn2lC5usRXOvtFy3k=;
 b=WvWDP3y7viG9bX4SicfVcrzvtqUVkkFg25YJRfz2NRLEIKyal7Rbd0P2qRoMhP3Xjy
 GE/XIT2vkB5/m/r+FR4Gk1NtqjAiN5AxxJ2QSSh/RiziSZJ/Bp4A0RFbw/w2ASSCiIiw
 Zdte5aORv8WehFIP87p/djd9boUVahFoRffxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937825; x=1694542625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5Pi0ofhHHBwxBYV1AwBDL00n/hn2lC5usRXOvtFy3k=;
 b=UJkxr04MyGcG/+7rOFdYm4Vn3uXndc2Al5t/A8YJNW2qxyMVS6CIhWRX4pBmM5j/Jb
 o36WJ5QKdlQq0FbCm06ZRuyZ9L8FPEld0iOmkPK88yBGy2Cs+2V3CtUXuYmrG/EYnfGn
 aZwxs2x2rKCWtPBWpHjYk2J/RmGAmyTzueUWOdw7x51Me5RWFyK4bL9n97iSSnsFmfje
 AxySQHf2w3ek4KUBL+RoilltEr513S1I2jictOgrv7Ht0xXgKOIpu5MLcZXBhr3biDd5
 wJvjK4rvWdbV4mtmSk+JMMpLfZOo7pzcerBngg/rUn+WkZqKrzb+AGwGJrfTFnOvSuNM
 iaCg==
X-Gm-Message-State: AOJu0Yw+0QTie4hwvusRGnczjEzrHQAhqIoqEDKGhehbTsfBpFRT1Kgy
 qYnhZiYZASm5RMDwiA6jyzys/IDxEK9eQTNIda2KHg==
X-Google-Smtp-Source: AGHT+IFAd/xJ8u5tk2k1FeVRoBlpR474Ruuv3n1d/L9lSisHHylv0Gb8kin8LXG1wRwI8C4hgzd3XvLPWiVAjt9Q9OA=
X-Received: by 2002:aa7:d050:0:b0:522:2aba:bc3b with SMTP id
 n16-20020aa7d050000000b005222ababc3bmr468664edo.28.1693937824854; Tue, 05 Sep
 2023 11:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
 <20230903192522.GZ3101304@bill-the-cat>
In-Reply-To: <20230903192522.GZ3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Sep 2023 12:16:56 -0600
Message-ID: <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
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

Hi Tom,

On Sun, 3 Sept 2023 at 13:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > > >
> > > > > > When lmb runs out of space in its internal tables, it gives
errors on
> > > > > > every fs load operation. This is horribly confusing, as the
poor user
> > > > > > tries different memory regions one at a time.
> > > > > >
> > > > > > Use the updated API to check the error code and print a helpful
message.
> > > > > > Also, allow the operation to proceed.
> > > > > >
> > > > > > Update the tests accordingly.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > [snip]
> > > > > > +     if (ret == -E2BIG) {
> > > > > > +             log_warning("Reservation tables exhausted: see
CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > > > +             return 0;
> > > > > > +     }
> > > > >
> > > > > This isn't the right option.  Everyone has
CONFIG_LMB_USE_MAX_REGIONS
> > > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > > >
> > > > > But it sounds like what you've found and fixed is an underlying
problem
> > > > > as to why 16 regions isn't enough in some common cases now?  So
we could
> > > >
> > > > I don't think I have fixed anything. But I'll send v2 and perhaps it
> > > > will be clearer what is going on here.
> > > >
> > > > > possibly avoid the string size growth here and have a comment
that also
> > > > > matches up with the help under LMB_MAX_REGIONS?
> > > >
> > > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > > > about 400 bytes. There seems to be a lot of code to save not much
> > > > memory.
> > >
> > > What do you mean here?  The alternative is not unlimited ranges but
> > > instead to define the limit of memory regions and limit of reserved
> > > ranges.
> >
> > A better alternative would be not to limit the number of regions, IMO,
> > i.e. have an array of regions that can grow as needed.
>
> That's not something that we have in the code today, however.

No, I do have an arraylist thing that I plan to upstream, which could
handle that.

But for this series, what do you think of the memregion idea? I am still
unsure of the saming we should use - see Heinrich's comments too.

Regards,
Simon
