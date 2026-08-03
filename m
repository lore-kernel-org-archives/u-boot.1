Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1DC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 14:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAB6A60711;
	Mon,  3 Aug 2026 14:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sot9AoSVMjLz; Mon,  3 Aug 2026 14:12:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF7086072F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785766361;
	bh=W4lZ/Vy+s28dfPnXxDQ/OCXNEglzu5aD7DP1U7cMzIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u5/kW8uC4ps6Ecg7tiXNbbr3hytVLnYN+UldcyIAERLKjXd7kOm7fxrVnQReB/v//
	 EcBwF+CkOc8qibJ+TqgcsZY3DaYMMcFyIRp+76aGN7pFfpUEp4iTwTJTHT07IEqq/B
	 JFoBAA901XjKBUtnLrma9ZZgfC+3Q/Ipamg4PHAbwnJZy8PsgYxctlcEjzEHrfgy8i
	 RpmJ85xx8fHnWtC1zeq+S0j/LaB0lgHSzU8z1+BlgxB4iuQnzyaWdlYxsfyPHVia9F
	 IQcHXPPTBJBnUhrcExorc81dh0DowVBqIXnjWLLQXMiHZ8AvjFMMzMhzT7SpDLAgBK
	 M4R5GYJcCIZaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF7086072F;
	Mon,  3 Aug 2026 14:12:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6E46218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 14:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C77B400C1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 14:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Px-LJHcvgQZ7 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 14:12:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=gregor.herburger@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5CAE140042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CAE140042
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CAE140042
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 14:12:39 +0000 (UTC)
Date: Mon, 3 Aug 2026 16:12:33 +0200
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Matthias Brugger <mbrugger@suse.com>, 
 Tom Rini <trini@konsulko.com>,
 Filip =?utf-8?Q?Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2] rpi: copy /chosen/bootloader partition and set
 boot_partition
Message-ID: <6mekppoipr35wecczz26vktsovqzwgwvsxuo6u7ltalpl4yyfl@vsmbtmecofkp>
References: <20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de>
 <CALeDE9PhmuHkiR5k0H=7mdCwq=n=1gS80vuQQqb8GdpKMYM3nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALeDE9PhmuHkiR5k0H=7mdCwq=n=1gS80vuQQqb8GdpKMYM3nA@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1785766354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4lZ/Vy+s28dfPnXxDQ/OCXNEglzu5aD7DP1U7cMzIQ=;
 b=Xaby3HieuODkCOAwlOFcoMYHKhzDnyWzTKpx/NkLPYIfYC4HvqyTdu2FJGF7sXUM6bZp0a
 d+plie2mb5085x5JpJuaqIn4f0xhAaRbU//haOqJr/VBRTIFgTe1BVvz+dSDpBq7kIyBs4
 I8tRiNUXJ/hIwE0ceQksjzePCJdb5D4gNHgQIhyO2GqjmuKBPwYYS42YDXyoCLqrPyFl00
 FwCMmPzeh2Ubk3Jb0qT28B4AG2G5KXdF5WbdJSYCt0succAqOpgx1K/6+oDKEshsm1KdH6
 0zg1xROmeDulAWRyrNwQcBGLwXn1rR63GuCKJm0t6pqqqt3cE8RdYdf14falTA==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1785766354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4lZ/Vy+s28dfPnXxDQ/OCXNEglzu5aD7DP1U7cMzIQ=;
 b=tMgpR0kYDWziYEmvSsaVtg4aCXJQxTr8Rmuis9zhdck0aYdtEYldI9bIDeLQv6XcddJ9ip
 YwHbeYGVFTI1d5Dw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Xaby3Hie; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=tMgpR0kY
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Peter,

On Mon, Aug 03, 2026 at 01:17:11PM +0100, Peter Robinson wrote:
> Hi Gregor,
> 
> > The Raspberry Pi has the "tryboot" feature where it can boot from a
> > different partition enabling failsafe A/B updates. After boot the
> > firmware sets 'partition' property in /chosen/bootloader. Copy this
> > property to the device tree and set the env variable boot_partition.
> > This allows boards to create a bootcmd based on the boot partition.
> >
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > ---
> > Changes in v2:
> > - update Reviewed-by tag
> 
> You don't need to do a v2 for a tag, patchwork will deal with that
> automatically.
Ok.
> 
> I looked at this briefly on a RPi4/5 yesterday and couldn't see the DT
> bits being passed through to the kernel, purely by a simple test of
> looking in /proc/device-tree/chosen/ directory and didn't see the
> bootloader/ directory or added/amended details, where if I boot off
> the FW DT I see:
> 
> # ls /proc/device-tree/chosen/bootloader/
> boot-mode build-timestamp  capabilities  name  partition  rsts
> tryboot  update-timestamp  version
> 
> Not sure if this is the versions of firmware/U-Boot/downstream DT I am
> using or something else. 
No I just tested it and couldn't see it either. I think it fails silently
because of the missing '/chosen/bootloader' node. Don't know how it ever worked.
Maybe I had a dts with that node from somewhere.

> I wonder also if we should just amend
> everything in the branch of the DT as no doubt others will want other
> bits for other features.
You mean to copy the complete '/chosen/bootloader' node with all its properties?
Yes I think that is a good idea, there seem to be some usable properties. 

Here is how it looks on my board:
bootloader {
        boot-mode = <0x00000001>;
        version = "5855b10b2bd22b2a116dc91f6b5b1bc4b2ea849f";
        capabilities = <0x0000007f>;
        update-timestamp = <0x00000000>;
        build-timestamp = <0x684bf1ce>;
        tryboot = <0x00000000>;
        rsts = <0x00001020>;
        partition = <0x00000002>;
        arg1 = <0x00000000>;
        count = <0x00000002>;
};


I will copy the complete node in the next iteration of this patch.
> 
> Peter
> 
> > ---
> >  board/raspberrypi/rpi/rpi.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index 1da5df92351c..7a2ff646ac8c 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -480,6 +480,20 @@ static void set_serial_number(void)
> >         env_set("serial#", serial_string);
> >  }
> >
> > +static void set_boot_partition_fdt(void)
> > +{
> > +       void *fdtp = (void *)gd->fdt_blob;
> > +       u32 partition;
> > +
> > +       partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
> > +       if (!partition) {
> > +               printf("Failed to the get partition property.\n");
> > +               return;
> > +       }
> > +
> > +       env_set_ulong("boot_partition", partition);
> > +}
> > +
> >  int misc_init_r(void)
> >  {
> >         set_fdt_addr();
> > @@ -489,6 +503,7 @@ int misc_init_r(void)
> >         set_board_info();
> >  #endif
> >         set_serial_number();
> > +       set_boot_partition_fdt();
> >
> >         return 0;
> >  }
> > @@ -641,6 +656,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >
> >         /* copy uart clk as provided by the firmware */
> >         copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
> > +
> > +       /* Copy the boot partition */
> > +       copy_property(fdt, fw_fdt, "/chosen/bootloader", "partition");
> >  }
> >
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >
> > ---
> > base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> > change-id: 20260803-tryboot2-8c5221376e5a
> >
> > Best regards,
> > --
> > Gregor Herburger <gregor.herburger@linutronix.de>
> >

Best regards
Gregor

-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
