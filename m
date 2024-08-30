Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D7CA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CEAC88D3D;
	Fri, 30 Aug 2024 03:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBj17aIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A458891E; Fri, 30 Aug 2024 03:09:37 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66E688D35
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6b6b9867faaso11386287b3.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724980174; x=1725584974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zlzK5Rj/Gdn2a8O9h0yA55+/OVVhKEv96Ckj52VcICY=;
 b=hBj17aIES/ldoxZEFycUf3ZPCfp+4TzoQ0nC2OlkUZtxQm0HmZYM+vFAYLQvKvFpnK
 9NKTLiyIU13eyd3/ZsfSX1lY7LTUgMLjumDP0qldjRiVI//FJdcTbbYsV5njbzI0sNta
 3hlKACCSSgpuM+LMuL3ygP2Qk+QZhfbQ9GwPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724980174; x=1725584974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlzK5Rj/Gdn2a8O9h0yA55+/OVVhKEv96Ckj52VcICY=;
 b=wOe2dZnJwfirnPkg7VbI8New8R6nuK3qsBh54XUKeUKNl0Ngb/URpYq31wa9TXpNtj
 M68sExE8Zz8Y2Lf73Gd2i/jLKtUsUr5TzvrPc2r2YaKOjodb874bTrfMh1fKkEjiWQ3p
 n9Wg2ZqpAcUpXfBav+w7IXq5IME/IRTHDnVFTJywyP0VtZQvGzYY22qkvW+cCugVEs52
 A/AMa46bAn5ebY/01ALJZm9vGfX1ldCY8qUFPwDcbX1LZkk+As+vPSBWlS3029twqGjl
 /5d8qcwyoke3Aa+R0NWm9vK9j1qY2hzdmVqJSDVWqOa/Jq9ErupDKPEzt+7mKclz+AH7
 NNRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZtNHdHSI+gOcOyKOIc9wDqbyv6D3uKkFcVU5mcIM1zHFfYiTcwBr8hQ5sIzYY5qx8iF3CXho=@lists.denx.de
X-Gm-Message-State: AOJu0Yxuo7OVecuZjpvQBe5BJAAue6+MTwO+uKjk8l9BSe+YX0DsbmCW
 Q45quN5e/yc4/3bKMuZi5CIPDYP8kRzi5wM3d/1K+P+GxHiDKq9Ww1YMyYQ+/8SVAYkRPMiWH5I
 AdehL5AmKVfyq55P7GF6teeu1IPgDbRInrfvb39KaU73tOdZRTw==
X-Google-Smtp-Source: AGHT+IGZ+zgsN5zgEXtIXgpDArKMe32RaGp5Vp/fEvAYPENGdZS6p9hQ6XUSWBBrOGSQtbW8pQAfp0pyoktbwFCHXJk=
X-Received: by 2002:a05:6902:c0c:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e1a79ff65ffmr922412276.9.1724980173604; Thu, 29 Aug 2024
 18:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
 <20240829152052.GE2479150@bill-the-cat>
In-Reply-To: <20240829152052.GE2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:09:22 -0600
Message-ID: <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Tom,

On Thu, 29 Aug 2024 at 09:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 09:02:38AM -0600, Simon Glass wrote:
> > Hi Neil,
> >
> > On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 29/08/2024 14:17, Simon Glass wrote:
> > > > Hi Peter,
> > > >
> > > > On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >>
> > > >> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> > > >>>
> > > >>> Hi Peter,
> > > >>>
> > > >>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >>>>
> > > >>>> Hi Simon,
> > > >>>>
> > > >>>>> With Labgrid we don't need to specify the various methods, except for
> > > >>>>> the console, which simply calls labgrid-client.
> > > >>>>>
> > > >>>>> This allows supporting any boards in your lab, without adding per-board
> > > >>>>> configuration to these hooks.
> > > >>>>>
> > > >>>>> Provide ellesmere files as an example.
> > > >>>>
> > > >>>> What's ellesmere?
> > > >>>
> > > >>> It is a lake but also the name of a computer.
> > > >>>
> > > >>>>
> > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >>>>> ---
> > > >>>>>
> > > >>>>> Changes in v4:
> > > >>>>> - Support pytest fully with dual-build boards like Beagleplay
> > > >>>>>
> > > >>>>> Changes in v3:
> > > >>>>> - Update scripts for latest version of Labgrid integration
> > > >>>>> - Add poweroff.none and poweron.none
> > > >>>>> - Provide -n flag when querying board info
> > > >>>>> - Target the grpc version of Labgrid which is now in -master
> > > >>>>> - Update README to cover the changes
> > > >>>>>
> > > >>>>> Changes in v2:
> > > >>>>> - Make use of the common script (only) to set bin_dir
> > > >>>>>
> > > >>>>>   README.md                    | 50 ++++++++++++++++++++++++++++++++++++
> > > >>>>
> > > >>>> Maybe that should be in a separate labsgrid readme?
> > > >>>
> > > >>> My hope is that Labgrid becomes the normal way of running these tests,
> > > >>
> > > >> Generally I agree with automated testing platforms, I think <insert
> > > >> you're preferred platform here> makes sense, there's a bunch like
> > > >> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> > > >> bunch more that I'm aware of.
> > > >
> > > > I am somewhat familiar with LAVA and I believe it can be used to test
> > > > U-Boot, although I need to learn how. Looking at a test run [2] for
> > > > beaglebone black I see that it is using a recent kernel but the U-Boot
> > > > seems to be older.
> > > >
> > > >>
> > > >> Does it make sense, of course at some point in the future post this
> > > >> being merged, make sense to look at a general way of making it easier
> > > >> to plugin these sort of HW test platforms using this as a basis? I ask
> > > >> mostly because putting a bunch of my devices into some sort of
> > > >> platform can auto test things and of course everyone has an opinion to
> > > >> which is the best one :-P
> > > >
> > > > Yes. I had heard from Tom that Labgrid is the new hotness for now.
> > > > Having dug into it I believe it is a good solution, although it can
> > > > certainly be improved to handle scale better.
> > > >
> > > > Anyway, IMO the current test hooks are not a great solution, just
> > > > because the configuration is spread all over the place and it relies
> > > > on lots of little shell scripts. So I believe that the Labgrid
> > > > integration is a closer to where we want to be with others that come
> > > > along.
> > >
> > > I'd say all those scripts are actually here to ease integration with any
> > > system, booting U-Boot and Linux are two different beasts.
> >
> > That's fine, go ahead and use the scripts. My point is that Labgrid
> > doesn't need them and in fact it makes everything pretty painful if we
> > try to use all of them.
>
> I guess I really need to clean-up and post my former co-workers scripts
> as I strongly disagree with that statement.

See some examples below. Bear in mind also that my goal has been to
get my lab fully running, that includes interactive access to boards,
as well as running tests. For that I have been using tbot (with
integrated build and software-loading features). WIth Labgrid I have
been able to replace most of the pytest scripts, tbot and Labman with
Labgrid + 60 patches and some configuration files.

Let's look through the scripts:

u-boot-test-common - new script

u-boot-test-console - needed

u-boot-test-flash - here's an example:

. poweroff.${power_impl}
sleep 0.1
. flash.sdwire_common_mount
. poweron.${power_impl}

Here's another:

# Handles the common SDwire mounting (caller does power control)

mount_dir=/media/${mount_point}

# Switch over to get USB card access
sd-mux-ctrl --device-serial ${sdwire_serial} --ts

complete=false
for i in {0..9}; do
    if out="$(mount UUID=${mount_uuid} 2>&1)"; then
        complete=true
        break
    fi
    echo $out

    # If it is already mounted, try to unmount it first. It may have been
    # mounted by another user so we won't have the access we need. If this gives
    # an error then we know we cannot continue
    if [[ $out == *"already mounted"* ]]; then
        umount UUID=${mount_uuid}
    fi
    sleep 1
done
if [[ $complete = false ]]; then
    echo "Failed to mount UUID ${mount_uuid} after 10 tries"
    exit 1
fi

# Sanity check
if ! mountpoint -q ${mount_dir}; then
    echo "Mount ${mount_dir} not available after 'mount'"
    exit 1
fi

# Perform the write, pass along as much environment as possible
. writer.${flash_writer}

complete=false
for i in {0..9}; do
    if out="$(umount ${mount_dir} 2>&1)"; then
        complete=true
        break
    fi
    echo $out
    sleep 1
done

if [[ $complete = false ]]; then
    echo "Failed to umount UUID ${mount_uuid} after 10 tries"
    exit 1
fi

# Sanity check
if mountpoint -q ${mount_dir}; then
    echo "Mount ${mount_dir} still available after 'umount'"
    exit 1
fi

# Back to card access for the DUT
sd-mux-ctrl --device-serial ${sdwire_serial} --dut


Of course that assumes an SDwire which may not always be the case.
Abstracting all of this into shell scripts is just too painful. Also I
have found it to be error-prone.

There is also bin/flash.sdwire_relay_mount:

. poweroff.${power_impl}

sleep 0.1

. flash.sdwire_common_mount

. poweron.${power_impl}


u-boot-test-getrole
- New script

u-boot-test-power-off
- This one fits with Labgrid quite well, but of course there may not
actually be power control

u-boot-test-power-on
- This one also fits with Labgrid, but since serial output can come
out as soon as it is called, jumping back into Labgrid later to bring
up a console results in lots of missing output. Also there may not
actually be power control

u-boot-test-release
- New script. Actually this isn't really needed, since I added
automatic release to Labgrid. I was just worried that Labgrid might
crash

u-boot-test-reset
- Unfortunately labgrid doesn't provide a reset option, although I'm
sure it could be added. You still need to know whether to use power or
reset or both, though, so again you have shell scripts with this stuff

reset.recovery_download - another thing I had to add, BTW

. "${bin_dir}/recovery.${recovery_impl}"

# USB enumeration delay
for ((i = 0; i <= 100; i++)); do
    if [ -e "${board_usb_dev}" ]; then
        break
    fi
    sleep 0.1
done
if [ ! -e "${board_usb_dev}" ]; then
    echo "Cannot find device ${board_usb_dev}"
    exit 1
fi
sleep 1

. "${bin_dir}/download.${download_impl}"

or another case, this is Zynq which tries to wait a bit before calling
picocom. It mostly works, but it loses output

# Some boards have a UART built into them and it doesn't appear until the
# board is powered on. An example is zynq_zybo. Try to handle this by waiting
# for the console and then continuing as soon as possible (so we don't miss
# the U-Boot banner).
if [ -n "${console_wait}" ]; then
    for i in {0..99}; do
        if [ -e "${console_dev}" ]; then
            break
        fi
        sleep .1
    done
    if [ ! -e "${console_dev}" ]; then
        echo "Console ${console_dev} not found"
        exit 1
    fi
fi

exec picocom -b "${console_baud}" "${console_dev}"

So that's about a third of the reason why I don't think the scripts scale.

> The only "painful" part is
> the shared pain, regardless of framework, for "put blob $X at location
> $Y", which I believe you abstract out in to python?

Sort-of. The Python knows how to handle all the different writing
methods and is at [2], but it is entirely controlled by yaml[3] (the
example_env.yaml). See the ti,am625 method for example and the 'play'
board right at the bottom of the end file.

I very much like the configuration files (although I hope one day
Labgrid will allow the two files to be combined). It makes it easier
to add a new board, since there is much less to think about. It really
did take a long time to fiddle with all those hook scripts and I got
tired of it.

Regards,
Simon

[1] https://github.com/sjg20/u-boot/tree/lab6a/tools/labman
[2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c7ea03987362af70bbbb94d14ff74c54a1ee5ed8#diff-e994502495dc8083c0b70ab20ace18fb5f85217805d01a54270a69c84ec31023R107
[3] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0cfc7e35e0547dcd14065328df4b4b5e1f#diff-66f82743402c95b2eac8f9937c61c582bd0aca2b35e841477d62122c811b7750R1187
