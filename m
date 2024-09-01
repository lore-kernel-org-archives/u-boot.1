Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED807CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9960288AFA;
	Sun,  1 Sep 2024 22:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H/yz84ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAF088A7F; Sun,  1 Sep 2024 22:10:03 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F247888C8
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3df13906bcdso1361290b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221399; x=1725826199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/RhZppK9oDu2XZghzMwzQirOUJjXJUj3cZnhEr3sLMA=;
 b=H/yz84otrhUkKCFspizJoXWGT+Nu+O8e4LCDv37B/8QPRlnNCzsFD9nB+eZiqC687X
 bk32jS9d5m7XvoEre1mL4iIVLY/27DqEByMAp6W8eqRpxOuhpBitAhjMVMLau8W6GQVn
 dc4MO7GuOwtYOZcCpAMa+JCtT5M/ZfHzKC6l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221399; x=1725826199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RhZppK9oDu2XZghzMwzQirOUJjXJUj3cZnhEr3sLMA=;
 b=ZwZywUdyVzianGz7FHGvfMZmI9juw1dl5eh0qx0NVndtreKzWFaMXLOsVcC1G+wBE8
 zaNggMjHgcHWYRALGGcfhykNHNKuZB3H3iWhTaONiOPVZ3RrwplPtIHlH5WdLbXnhLWY
 FCgeqjxiY25wqacsXerU2htfUVhNEB8JvI84cqhKitTxABjjPG5ga1icNnz8b77mFWvj
 BEnTDb2P7EulBq+nAiOCaMwYnfvUc+nwgplG+ydqz+sxNVR2UO5VDtUpwLPjTJN1c4jJ
 e9hVsEVdbqHxocG7gIGnCFqVdapahjV2NHq3kGoQcrfwfYyB/U7/vTK9iF4V1ctBs00E
 BH2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYC9aEof47w152oMhyHUgMmoYWOt9Gyd8AqY3qWLLwQxZsGC7LGDOzZEoZrnvhBV8uHPEKBw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1kU4VuMPawiFZk/Jl395fC6HCfyPY/mDHO6A2tA2g/jSliTq5
 /8+/joY1PboTfCP2oZMVNmCv8hE1uV093CgDR0CP/3HT/hMFYrqYO9HesbTFqRM5Y24gJvAl7yx
 +Gw59Naks+cqJE85sU3pRxKLM0112rV4DKkIM
X-Google-Smtp-Source: AGHT+IGzr2n2aRdY8Ch/YT3/poRMsPPPlsrR3nW3owgRzVJGwx5rWpENOn7daHQExwwfnhqOMSVd6/O+8fP2vWbP1QE=
X-Received: by 2002:a05:6830:2a91:b0:708:e969:e0d9 with SMTP id
 46e09a7af769-70f70703a62mr6300921a34.17.1725221398624; Sun, 01 Sep 2024
 13:09:58 -0700 (PDT)
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
 <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
 <20240830151327.GU2479150@bill-the-cat>
In-Reply-To: <20240830151327.GU2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:47 -0600
Message-ID: <CAFLszTiMTRenX_g6jBr3snv5mC50gK2HwCHHgWVjQU-4Dwfiuw@mail.gmail.com>
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

On Fri, 30 Aug 2024 at 09:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:09:22PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 09:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 09:02:38AM -0600, Simon Glass wrote:
> > > > Hi Neil,
> > > >
> > > > On Thu, 29 Aug 2024 at 08:44, <neil.armstrong@linaro.org> wrote:
> > > > >
> > > > > On 29/08/2024 14:17, Simon Glass wrote:
> > > > > > Hi Peter,
> > > > > >
> > > > > > On Thu, 29 Aug 2024 at 04:43, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > > > >>
> > > > > >> On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
> > > > > >>>
> > > > > >>> Hi Peter,
> > > > > >>>
> > > > > >>> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > > > >>>>
> > > > > >>>> Hi Simon,
> > > > > >>>>
> > > > > >>>>> With Labgrid we don't need to specify the various methods, except for
> > > > > >>>>> the console, which simply calls labgrid-client.
> > > > > >>>>>
> > > > > >>>>> This allows supporting any boards in your lab, without adding per-board
> > > > > >>>>> configuration to these hooks.
> > > > > >>>>>
> > > > > >>>>> Provide ellesmere files as an example.
> > > > > >>>>
> > > > > >>>> What's ellesmere?
> > > > > >>>
> > > > > >>> It is a lake but also the name of a computer.
> > > > > >>>
> > > > > >>>>
> > > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >>>>> ---
> > > > > >>>>>
> > > > > >>>>> Changes in v4:
> > > > > >>>>> - Support pytest fully with dual-build boards like Beagleplay
> > > > > >>>>>
> > > > > >>>>> Changes in v3:
> > > > > >>>>> - Update scripts for latest version of Labgrid integration
> > > > > >>>>> - Add poweroff.none and poweron.none
> > > > > >>>>> - Provide -n flag when querying board info
> > > > > >>>>> - Target the grpc version of Labgrid which is now in -master
> > > > > >>>>> - Update README to cover the changes
> > > > > >>>>>
> > > > > >>>>> Changes in v2:
> > > > > >>>>> - Make use of the common script (only) to set bin_dir
> > > > > >>>>>
> > > > > >>>>>   README.md                    | 50 ++++++++++++++++++++++++++++++++++++
> > > > > >>>>
> > > > > >>>> Maybe that should be in a separate labsgrid readme?
> > > > > >>>
> > > > > >>> My hope is that Labgrid becomes the normal way of running these tests,
> > > > > >>
> > > > > >> Generally I agree with automated testing platforms, I think <insert
> > > > > >> you're preferred platform here> makes sense, there's a bunch like
> > > > > >> Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
> > > > > >> bunch more that I'm aware of.
> > > > > >
> > > > > > I am somewhat familiar with LAVA and I believe it can be used to test
> > > > > > U-Boot, although I need to learn how. Looking at a test run [2] for
> > > > > > beaglebone black I see that it is using a recent kernel but the U-Boot
> > > > > > seems to be older.
> > > > > >
> > > > > >>
> > > > > >> Does it make sense, of course at some point in the future post this
> > > > > >> being merged, make sense to look at a general way of making it easier
> > > > > >> to plugin these sort of HW test platforms using this as a basis? I ask
> > > > > >> mostly because putting a bunch of my devices into some sort of
> > > > > >> platform can auto test things and of course everyone has an opinion to
> > > > > >> which is the best one :-P
> > > > > >
> > > > > > Yes. I had heard from Tom that Labgrid is the new hotness for now.
> > > > > > Having dug into it I believe it is a good solution, although it can
> > > > > > certainly be improved to handle scale better.
> > > > > >
> > > > > > Anyway, IMO the current test hooks are not a great solution, just
> > > > > > because the configuration is spread all over the place and it relies
> > > > > > on lots of little shell scripts. So I believe that the Labgrid
> > > > > > integration is a closer to where we want to be with others that come
> > > > > > along.
> > > > >
> > > > > I'd say all those scripts are actually here to ease integration with any
> > > > > system, booting U-Boot and Linux are two different beasts.
> > > >
> > > > That's fine, go ahead and use the scripts. My point is that Labgrid
> > > > doesn't need them and in fact it makes everything pretty painful if we
> > > > try to use all of them.
> > >
> > > I guess I really need to clean-up and post my former co-workers scripts
> > > as I strongly disagree with that statement.
> >
> > See some examples below. Bear in mind also that my goal has been to
> > get my lab fully running, that includes interactive access to boards,
> > as well as running tests. For that I have been using tbot (with
> > integrated build and software-loading features). WIth Labgrid I have
> > been able to replace most of the pytest scripts, tbot and Labman with
> > Labgrid + 60 patches and some configuration files.
>
> That's certainly good and useful progress. And I feel like one of the
> lessons of this thread is that every lab ends up a bit different and so
> there's just not going to be as much standardization as we'd all like.
>
> > Let's look through the scripts:
> >
> > u-boot-test-common - new script
> >
> > u-boot-test-console - needed
> >
> > u-boot-test-flash - here's an example:
> >
> > . poweroff.${power_impl}
> > sleep 0.1
> > . flash.sdwire_common_mount
> > . poweron.${power_impl}
> >
> > Here's another:
> >
> > # Handles the common SDwire mounting (caller does power control)
> >
> > mount_dir=/media/${mount_point}
> >
> > # Switch over to get USB card access
> > sd-mux-ctrl --device-serial ${sdwire_serial} --ts
> >
> > complete=false
> > for i in {0..9}; do
> >     if out="$(mount UUID=${mount_uuid} 2>&1)"; then
> >         complete=true
> >         break
> >     fi
> >     echo $out
> >
> >     # If it is already mounted, try to unmount it first. It may have been
> >     # mounted by another user so we won't have the access we need. If this gives
> >     # an error then we know we cannot continue
> >     if [[ $out == *"already mounted"* ]]; then
> >         umount UUID=${mount_uuid}
> >     fi
> >     sleep 1
> > done
> > if [[ $complete = false ]]; then
> >     echo "Failed to mount UUID ${mount_uuid} after 10 tries"
> >     exit 1
> > fi
> >
> > # Sanity check
> > if ! mountpoint -q ${mount_dir}; then
> >     echo "Mount ${mount_dir} not available after 'mount'"
> >     exit 1
> > fi
> >
> > # Perform the write, pass along as much environment as possible
> > . writer.${flash_writer}
> >
> > complete=false
> > for i in {0..9}; do
> >     if out="$(umount ${mount_dir} 2>&1)"; then
> >         complete=true
> >         break
> >     fi
> >     echo $out
> >     sleep 1
> > done
> >
> > if [[ $complete = false ]]; then
> >     echo "Failed to umount UUID ${mount_uuid} after 10 tries"
> >     exit 1
> > fi
> >
> > # Sanity check
> > if mountpoint -q ${mount_dir}; then
> >     echo "Mount ${mount_dir} still available after 'umount'"
> >     exit 1
> > fi
> >
> > # Back to card access for the DUT
> > sd-mux-ctrl --device-serial ${sdwire_serial} --dut
> >
> >
> > Of course that assumes an SDwire which may not always be the case.
>
> Or some other piece of hardware that sd-mux-ctrl supports, but yes.
>
> > Abstracting all of this into shell scripts is just too painful.
>
> Abstracting it to something else sounds even more painful however.

I see this a little bit like the situation with Binman. We now have a
description for the image and can build for any SoC which has added
its peculiarities in a Python script.

In a similar way, I believe it is valuable to have each SoC encode (in
some sort of description) how it writes images to an SD card, over
USB, etc.

Now I am not a huge fan of yaml but it does the job and it is what
Labgrid uses. So my vision of all this is that if someone wants to set
up a lab with 5 boards, they can get the gear together, wire it all
up, then copy and modify some yaml and it should all work.

>
> > Also I have found it to be error-prone.
> >
> > There is also bin/flash.sdwire_relay_mount:
> >
> > . poweroff.${power_impl}
> >
> > sleep 0.1
> >
> > . flash.sdwire_common_mount
> >
> > . poweron.${power_impl}
>
> Yup. It's possible we could do some slightly nicer check/sleep loop but
> it probably wouldn't really get us much.
>
> > u-boot-test-getrole
> > - New script
>
> Which is for how you abstracted hardware from software configurations it
> can run (for example, the Pi 4 case of rpi_4, rpi_4_32b and rpi_arm64
> all being valid defconfigs).

Yes it maps a 'role' (like an 'identity' in test.py) to a particular
DUT and the corresponding U-Boot board. It can be many-to-one.

>
> > u-boot-test-power-off
> > - This one fits with Labgrid quite well, but of course there may not
> > actually be power control
> >
> > u-boot-test-power-on
> > - This one also fits with Labgrid, but since serial output can come
> > out as soon as it is called, jumping back into Labgrid later to bring
> > up a console results in lots of missing output. Also there may not
> > actually be power control
>
> Right, but in both cases, poweron/poweroff.labgrid could just do:
> labgrid-client power $state || true
> if power isn't supported (which sounds odd, but, maybe makes sense in
> some setup).

Yes it can. I have quite a few boards with no power control (they are
just on all the time). I find a reset line more useful than power in
some cases.

>
> > u-boot-test-release
> > - New script. Actually this isn't really needed, since I added
> > automatic release to Labgrid. I was just worried that Labgrid might
> > crash
>
> What I saw in working on my scripts was that if you don't release you
> can't acquire later and there's not an option for "you already have
> acquired it". On my scripts, I should update the cleanup function to
> release the current LG_PLACE.

Yes I hit the same problem. I added an '--auto' option to acquire and
release, so they are more forgiving.

>
> > u-boot-test-reset
> > - Unfortunately labgrid doesn't provide a reset option, although I'm
> > sure it could be added. You still need to know whether to use power or
> > reset or both, though, so again you have shell scripts with this stuff
>
> Perhaps this is something to talk with upstream about, for the cases
> where "reset" is not just another name for "power cycle" ? I know we
> have scripts today for a number of cases but the only ones I wrote are
> just power cycle (digital-loggers) or power cycle via USB (ykush, the
> USB hubs that support per-port power control intentionally).

If you did down a bit it ends up being intertwined with the U-Boot
strategy...e.g. you for USB you often need to hold reset down while
holding recovery, then release reset, then write U-Boot and wait for
it to come up.

>
> > reset.recovery_download - another thing I had to add, BTW
> >
> > . "${bin_dir}/recovery.${recovery_impl}"
> >
> > # USB enumeration delay
> > for ((i = 0; i <= 100; i++)); do
> >     if [ -e "${board_usb_dev}" ]; then
> >         break
> >     fi
> >     sleep 0.1
> > done
> > if [ ! -e "${board_usb_dev}" ]; then
> >     echo "Cannot find device ${board_usb_dev}"
> >     exit 1
> > fi
> > sleep 1
> >
> > . "${bin_dir}/download.${download_impl}"
> >
> > or another case, this is Zynq which tries to wait a bit before calling
> > picocom. It mostly works, but it loses output
> >
> > # Some boards have a UART built into them and it doesn't appear until the
> > # board is powered on. An example is zynq_zybo. Try to handle this by waiting
> > # for the console and then continuing as soon as possible (so we don't miss
> > # the U-Boot banner).
> > if [ -n "${console_wait}" ]; then
> >     for i in {0..99}; do
> >         if [ -e "${console_dev}" ]; then
> >             break
> >         fi
> >         sleep .1
> >     done
> >     if [ ! -e "${console_dev}" ]; then
> >         echo "Console ${console_dev} not found"
> >         exit 1
> >     fi
> > fi
> >
> > exec picocom -b "${console_baud}" "${console_dev}"
> >
> > So that's about a third of the reason why I don't think the scripts scale.
>
> This is where I think looking at https://github.com/bootlin/snagboot
> which Kevin Hillman pointed me at a while ago might come in handy,
> instead.

Oh yes I ran into that at a show a year or two back, very nice! Better
than having a lot of little tools.

>
> > > The only "painful" part is
> > > the shared pain, regardless of framework, for "put blob $X at location
> > > $Y", which I believe you abstract out in to python?
> >
> > Sort-of. The Python knows how to handle all the different writing
> > methods and is at [2], but it is entirely controlled by yaml[3] (the
> > example_env.yaml). See the ti,am625 method for example and the 'play'
> > board right at the bottom of the end file.
> >
> > I very much like the configuration files (although I hope one day
> > Labgrid will allow the two files to be combined). It makes it easier
> > to add a new board, since there is much less to think about. It really
> > did take a long time to fiddle with all those hook scripts and I got
> > tired of it.
> >
> > Regards,
> > Simon
> >
> > [1] https://github.com/sjg20/u-boot/tree/lab6a/tools/labman
> > [2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c7ea03987362af70bbbb94d14ff74c54a1ee5ed8#diff-e994502495dc8083c0b70ab20ace18fb5f85217805d01a54270a69c84ec31023R107
> > [3] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0cfc7e35e0547dcd14065328df4b4b5e1f#diff-66f82743402c95b2eac8f9937c61c582bd0aca2b35e841477d62122c811b7750R1187
>
> Yeah, personally I don't care for that. I know I'm not going to convince
> people and it's just one of those "goodness, I'm the old guy now"
> things, but, no. It would be easier if you had comments for each SoC as
> to what / why each of the magic values, but then shouldn't it be
> abstracted more? Perhaps to a file per SoC, and at that point how is
> this easier to follow than a commented shell script? But in sum, I'm
> just cranky about yaml and I know your opinion is the opposite.

As above I don't like it either, but it is what Labgrid has chosen. In
fact I used it with Labman too...it really needs proper phandles like
devicetree. At least is isn't JSON though...:-)

>
> As an aside, please review the ti,am625 stuff with some TI folks, that's
> both far too specific (you're going to need to add different am62 and
> am64 and am69 and j7... and on and on cases) and I forget if there's
> some work to have a slightly easier way to know what file to use going
> on.

Well, perhaps they can take it over and get everything working? I have
done the hard yards, e.g. supporting two builds together.

Regards,
Simon
