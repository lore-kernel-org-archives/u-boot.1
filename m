Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3505CC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB5D8144A;
	Sat,  3 May 2025 23:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWtFfZeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481CB820FE; Sat,  3 May 2025 23:26:38 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414ED80EE5
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so4968089a12.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307596; x=1746912396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OxmaOizvEf5NjZJfWPsSnCEOspEeeDLKPTnsxJnUrm8=;
 b=cWtFfZePPJ28IE4OJfekKEIH76HeUhYghk0/N3FxPmLDuPxj+ySpf1/T40CPnfeK8m
 yC5Futna96OKLy1jMdFJZGzTUj6lP2uxh5V4uXUBxo34Seb6+cnyH/jO5yOjurnGdQbD
 CzvLQRwocMnj0XP8q+Sy+5hLocqSpUTlDyt7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307596; x=1746912396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxmaOizvEf5NjZJfWPsSnCEOspEeeDLKPTnsxJnUrm8=;
 b=sO7iTtBps/I5C/uqzWu//eMdaUgWdKQ2kjEaLF+bOV9SNVBgQ4Alk3xNkIfV33ls7W
 bIypXrmXSShOIoME1MWww8rcQ7Qu9BKGjj1g2hK3OmsoE6b439pm/r0iIKKPi3mSsIby
 yaxZWjjwUw63Mh6TfG2WCfgu8P6UTqsziOATeF4yjYrtH0Uo39WF/Fh5R8T5IKUaLY5u
 pbN2vt6ayzEx0lR1HnqThg9krUV4qt424UY2Gv65tZjS0bJ/THQ9g2yZk74LSzf9iWXU
 68IMstb93BTuy3a8TJ3wGY4DJiLTMjXFbMAfD2lON3EwAkFOQ7d3UW1n2kjDfEbxh2jd
 Q71w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf/YFvO57c1NeT6hj25BtTxo4XnrPusXGHKH6z+01uSs/dA35hLCOL8PxI9cmgiR+9ViVOXYk=@lists.denx.de
X-Gm-Message-State: AOJu0YwqZkBllZczr4L6adXTWjOzsmQO7+Py4NJUHyFJ2Mkqf0h21IXB
 Vu2p6JHMo8/gQuHXG+Wj8XIFiaB96yDWSvMqg2+DDv01nSEu7pFtkSOGWGxfvhkvgNKhBjk//Ky
 WzGjD72bfY3sbMUz2a+fMxsj3+sQ1FosCtF8b
X-Gm-Gg: ASbGncuWGMPtcla+bGDLM0dRsEVrVfGoHPFOSkJeZnyEe/VhDKq/sgF5eHeUJ1Y3lrc
 Nf26tjYA9P6JNZHe5KIhNw0pTsTz5WMcI7FdGbVkHXQmAHgqA8I50s9C0dfAK36pF+yQ3eZEek2
 Mw0/OHM5U126amemHbwelLNutDHmFEd9as02uv2S4nmOpifcgQzRX5ZTY=
X-Google-Smtp-Source: AGHT+IGGicGOvIIle5+/IDGGzucrSKRDnjuwrUaskB+P3RpUi68b9Mu+E2JUe5Mt9FkDekJJ1axeGYpzSea+ShLJg7I=
X-Received: by 2002:a05:6402:35d5:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-5fab05e2278mr1632183a12.29.1746307595673; Sat, 03 May 2025
 14:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <CAFLszTg1Z7PArfxUUiyoNDsBj1N7Q23dn_xwhAJQ3pGikR0hzw@mail.gmail.com>
 <CAM=mAOmqSN7XOQonsOA6Q79T0MZRKpv3eObDCFMa_v4_3QzE6g@mail.gmail.com>
In-Reply-To: <CAM=mAOmqSN7XOQonsOA6Q79T0MZRKpv3eObDCFMa_v4_3QzE6g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:26:20 -0600
X-Gm-Features: ATxdqUHXYJnjYUDp1jsDAB7UjMeQZQKlvhL3jrnV7pBUaI1OGbP_XkVa-3Fc0k4
Message-ID: <CAFLszTg9iecRkid=fp9FgPQjak93J0pLAt0+KYhd3sb+3CkKqw@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

HI Heinrich,

On Sat, 3 May 2025 at 01:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 04:10:
>>
>> Hi Heinrich,
>>
>> On Fri, 2 May 2025 at 10:09, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > On 5/2/25 16:49, Simon Glass wrote:
>> > > Hi Heinrich,
>> > >
>> > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
>> > > <heinrich.schuchardt@canonical.com> wrote:
>> > >>
>> > >> The EFI boot manager bootmeth does not require variable BootOrder to be
>> > >> preexisting. It creates this variable.
>> > >>
>> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > >> ---
>> > >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
>> > >>   1 file changed, 3 insertions(+), 18 deletions(-)
>> > >>
>> > >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
>> > >> index 42b8863815e..1669cbed5bd 100644
>> > >> --- a/boot/bootmeth_efi_mgr.c
>> > >> +++ b/boot/bootmeth_efi_mgr.c
>> > >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
>> > >>
>> > >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>> > >>   {
>> > >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
>> > >> -       efi_status_t ret;
>> > >> -       efi_uintn_t size;
>> > >> -       u16 *bootorder;
>> > >> -
>> > >> -       if (priv->fake_dev) {
>> > >> -               bflow->state = BOOTFLOWST_READY;
>> > >> -               return 0;
>> > >> -       }
>> > >> +       int ret
>> > >>
>> > >>          ret = efi_init_obj_list();
>> > >>          if (ret)
>> > >>                  return log_msg_ret("init", ret);
>> > >>
>> > >> -       /* Enable this method if the "BootOrder" UEFI exists. */
>> > >> -       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
>> > >> -                               &size);
>> > >> -       if (bootorder) {
>> > >> -               free(bootorder);
>> > >> -               bflow->state = BOOTFLOWST_READY;
>> > >> -               return 0;
>> > >> -       }
>> > >> +       bflow->state = BOOTFLOWST_READY;
>> > >>
>> > >> -       return -EINVAL;
>> > >> +       return 0;
>> > >>   }
>> > >>
>> > >>   static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
>> > >> --
>> > >> 2.48.1
>> > >>
>> > >
>> > > How do we know if the board is using EFI bootmgr? My understanding was
>> > > that this was a way to find out?
>> >
>> > The boot manager must always run.
>>
>> Are you sure that is true? It seems false to me, e.g.
>>
>> - if we are booting FEL on suxi, it must not run.
>> - none of the boards in my lab use it
>> - the Ubuntu 24.04 test in my lab doesn't use it
>>
>> So how can we say that it must always run?
>
>
> If a boot method that is earlier in the sequence boots the boot manager will not be reached. But the existence of BootOrder or any other EFI variable shall not decide if the boot manager runs or not.

So is there *any* way to know whether it should run or not? Should we
use the Kconfig to control it? It feels like disappearing into the
abyss when we run bootmgr, at present. I'm wondering if we can improve
this.

Regards,
Simon
