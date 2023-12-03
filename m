Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69096C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 23:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF9F875BD;
	Mon,  4 Dec 2023 00:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18590875C8; Mon,  4 Dec 2023 00:41:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 975B1875B6
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 00:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9FC1684;
 Sun,  3 Dec 2023 15:42:20 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABE963F762;
 Sun,  3 Dec 2023 15:41:31 -0800 (PST)
Date: Sun, 3 Dec 2023 23:40:14 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <stephen.graf@gmail.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Piotr
 Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/1] correct documentation for SPI flashing
Message-ID: <20231203234014.5dc4cbe7@slackpad.lan>
In-Reply-To: <ef003512-e433-4d83-87a4-5ae3341f6399@gmail.com>
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
 <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
 <d410fbe1-bf0f-4cb5-99cf-3353b952985b@gmail.com>
 <345d9916-6ae6-4dbe-99a2-33aafeebcb60@arm.com>
 <ef003512-e433-4d83-87a4-5ae3341f6399@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 1 Dec 2023 10:50:39 -0800
Stephen Graf <stephen.graf@gmail.com> wrote:

Hi Stephen,

thanks for the patch, and you almost nailed it, some little things:

- The patch should start a new thread on the list, so do not reply to
  an existing discussion or (un)related patch. This avoids the patch
  getting buried in longish threads and helps tools like patchworks to
  find and process it. Also please just send the patch, and avoid any
  quoted text from previous discussions outside of the commit message.
- Please prefix your commit message with some context tags, in this
  case "sunxi: ", so that people scanning the list can ignore it if
  it's outside their scope of interest.
- Please limit commit messages to 75 characters per line.
  $ scripts/checkpatch.pl
  0001-correct_documentation_for_SPI_flashing.patch
  will do some checks on the patch and would report this.

Anyway, those are minor things, I will just fix them while committing.

> The mtd_debug write does not work in this context. The flashcp command does work, provides
> both the erase and write functions and with the verbose option gives good feedback.
> 
> Signed-off-by: Stephen Graf <stephen.graf@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   doc/board/allwinner/sunxi.rst | 3 +--
>   1 file changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/board/allwinner/sunxi.rst b/doc/board/allwinner/sunxi.rst
> index 797222d8d3..d0c89b956b 100644
> --- a/doc/board/allwinner/sunxi.rst
> +++ b/doc/board/allwinner/sunxi.rst
> @@ -251,8 +251,7 @@ the SPI flash content from Linux, using the `MTD utils`_::
> 
>       # apt-get install mtd-utils
>       # mtdinfo
> -    # mtd_debug erase /dev/mtdX 0 0xf0000
> -    # mtd_debug write /dev/mtdX 0 0xf0000 u-boot-sunxi-with-spl.bin
> +    # flashcp -v u-boot-sunxi-with-spl.bin /dev/mtdX
> 
>   ``/dev/mtdX`` needs to be replaced with the respective device name, as listed
>   in the output of ``mtdinfo``.
> ---
> 
> On 2023-11-30 4:27 p.m., Andre Przywara wrote:
> > Hi Stephen,
> > 
> > On 30/11/2023 01:13, Stephen Graf wrote:  
> >> Is the attached patch file going in the right direction?  
> > 
> > yes, thanks, the change itself looks alright, but it needs to be:
> > - in a separate email, with a descriptive subject, prefixed by [PATCH]
> > - have the diff inline, not as an attachment (to allow easy commenting in an email thread)
> > - have a Signed-off-by: tag with your name and email address. This is to signify that the change is an original one made by you and you are happy to submit this under the (GPL) license conditions.
> > - an explanation *why* this change is required (mtd_debug write being not reliable, etc)
> > - sent to the U-Boot list and the maintainer (me)
> > 
> > Look at the U-Boot mailing list (archive) for examples.
> > "git format-patch" creates everything in the right format (mbox), and "git send-email" will send this via an SMTP server you point it to. Or you import this into your client.
> > 
> > If you could try this (with the Signed-off-by being the most important change), I am happy to submit this with the next push.
> > 
> > Thanks,
> > Andre
> >   
> >>
> >> On 2023-11-29 3:57 p.m., Andre Przywara wrote:  
> >>> Hi Stephen,
> >>>
> >>> On 28/11/2023 20:07, Stephen Graf wrote:  
> >>>> Below is the console log from trying to use mtd_debug write. It returned immediately with a strange success message.
> >>>>
> >>>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 /home/sysadmin/u-boot-sunxi-with-spl.bin
> >>>> file_to_flash: fread, size 0xf0000, n 0xf0000
> >>>> fread(): Success  
> >>>
> >>> interesting, I was under the impression that "mtd_debug write" would be the way to write to flash. In hindsight, the "debug" in that name should have probably put me off. Anyway, "cat" is probably not a good choice, "dd" is better, but it looks like "flashcp" (also part of mtdutils) is the go-to tool, since it does the required erasing automatically and also reportedly does some error detection. Can you please test this?
> >>> # flashcp u-boot-sunxi-with-spl.bin /dev/mtd0
> >>> I would test this on my end ASAP as well.
> >>>
> >>> Do you feel like sending a patch to the U-Boot documentation to get this changed then?
> >>>
> >>> Thanks,
> >>> Andre
> >>>  
> 

