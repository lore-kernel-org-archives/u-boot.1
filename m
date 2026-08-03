Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939BCC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FD47607AD;
	Mon,  3 Aug 2026 12:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id onYuJDqLqMpQ; Mon,  3 Aug 2026 12:17:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44DAF6076A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785759448;
	bh=kESVnQZ+HH+QrMa88CwLIOKb1qwyziyKnxeeUNM0Fl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSpQGG8mRozi98k6F/KwveaMlndxRT4ngeT1ID3OrYm/8oKWzZb7GLLo1KNl2qg5u
	 ds2erUmG6UU0sdBiAFQhbZz0jOYEV52UgI+dP2ylB5GHxLrBBue4oaEQXdAnvVKsay
	 9MZYIu1D4kdRYBJbWc8kga1BTEVdpJOFp/MXOhBS3mmDmygpF+2VzZgFXktsAR3Hsj
	 RGp0BupjDzysrfqx6y8uQNRMsEovHQDENHcMQRwk463EDKNn6easuUDsaKXILw6cYR
	 MCsPYguz1+D7I6UL6gaKZl9pOGtFTCJEHcYQqMpmTAwo7GloMCTsytP/dD4q9HxEgE
	 4jgo4vyCNX1hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44DAF6076A;
	Mon,  3 Aug 2026 12:17:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 070D5389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04E0F405DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kC1fFMnk1Ma for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:17:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2e; helo=mail-qv1-xf2e.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 395BC40541
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 395BC40541
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 395BC40541
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:17:25 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8fcc43c48f7so37111206d6.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759444; cv=none;
 d=google.com; s=arc-20260327;
 b=Hz9zZWXn+g7Au9qUdqtUkYTnfT4bl12p6j9u2YUcZ87C/2RJu8xeESQ9qtFwJC1gq6
 alEhvi9gOUCQ+ta2IRaXQ6eSFslhNFiLbG/Q+khniw5ock4WDTW0jnS8wG6Yda5ywyPN
 gFTYdLHap82TvU31lQIaGNJEZ4KV6xrlEa+AavF/ZWs/HU3MmN4nULDNWjI4SCrrBsUq
 vtJbwII1T9Tk/Qu3Yuch9ntNgNSSqWORgin05gb7cA4PU+924Kpzw+b2MlfhqTWmGj5f
 BaHEI87ZomLSSiOE+8pTMXzt8rH5Npi0mYkRLJAaww83fDYbryx+POIMMK8XjpwUMb3t
 quHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kESVnQZ+HH+QrMa88CwLIOKb1qwyziyKnxeeUNM0Fl0=;
 fh=ng9IPAskjaqNl8F9JMBmRFIDjWoyq94UpMn4A5ZM6lE=;
 b=g7rF7cakX2JQ0xiUce1aE6GGVe/63YNJUgcatD6sDxHn2BI28eNKl1K9spTqf/tJSb
 tUEj7Kwt4TngHqurgkZp6nQXStH81ue3y186HBunsIDIxNXWqTfRZu+t5b9KamPJqhQ2
 my/mFjxRpledo+zY8smYdedCep+aJy4oHHZIWAgoT0VdouxfwH84a2kC6jz2CcCHxn9E
 +ZQ/55ayRlU7TsUGY2G1ryL6dyqoQtw0gZwj2oLoiHOMcF4+vTxbboRC/ieRsulUsgKP
 QrBu7wVNQB0RJxZQnLNeJwnPc10md80ApccJ2ZDhSWe6xbgptto3RBkkjmoZvFxf4Fsw
 R+pg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759444; x=1786364244;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kESVnQZ+HH+QrMa88CwLIOKb1qwyziyKnxeeUNM0Fl0=;
 b=CJgDGSijBYf8JAu2wGXFgz2fQPMFWs/5YqqtKc8BwEXoFC67C4m8+b5tsKQYj4CnDO
 xyaVh6TJ9aud7XmCVMCAMs+BjJq6X2h4uxbq6bl9lXnUZhkICTy+mI9j+H43OG0JCKtt
 Hl+viuA5sdyAcmhLeE/Cq0GY36xC6W9zek/N147/0PQzYK0SUdGY4ouxGFu6yUCjXmw/
 U3rbKa6jYL1kBCvUY4EokA4stbeT6r1fyN5LNY7oRyxk78g6SJa8Z5ppkkkipRuxykC2
 ZAk0+N1XB+rvBHaM1pQEUe3HCOrf7HdX7L6gzrZP5hTMwDO719e1kCkeTYzweGSnB3un
 0P8g==
X-Gm-Message-State: AOJu0YwcsyMCMEZJJSvRlBuTaXajJPG0CZEmuWTLmFqeZoMHizXmBxGg
 i6mL5qcIkOmcjs5/f7YjGQ0Av85DxjjQWYGIkUyWDDJx1VVmP2fN/nl5KwhTKKsY1zBOKbyl3Dh
 g68MiQ/3BGwHtSi/7L9K1ZNsiwdqA6VZqDszc
X-Gm-Gg: AR+sD13Oh0SSqeLs8eVUmnAVwnveJtHNrjga4X0rEd0K5tK2SNQ/Xd5dXBUgxHC/oci
 apciuRgC1bltsbIQRhFS0H50FPZTrdZPNyMO7FI7zeTRUQXTerEqADAHTthgniKVRq0zkpCQRxy
 W/z2tdkfRV4wYE5o4ottVf7Sq6fJl+epIt4tAOGXF8rgYuIrbN6hqWqEOS5rgpe/Mk8LexCTJeX
 dGmKLfVt2/J0gHLBiqwc02T1ioesiKFNIudywyTzfkcfGWUwrvRQbgzUwwsIaS1QSUKXgA2wCTU
 /Vc6SBycqCEZ6CYXPMHEfGqa/MZb8hoeJEqSPe8NH95w0B525c7yMSzUfcEK41tMEPNIkFDZLbQ
 Y+CSv3uV/oyfg/NpzyiemfzPo960g6B4zvDJCjFO/i+ejwfr8Zdonxu5YOD6G8tpU899ClbyvTF
 KwPLa7EbEq1CtjLBCxuuJL7HrDK6NlIVXQ0/VzUds=
X-Received: by 2002:a05:6214:3a8c:b0:8ee:756a:f1d3 with SMTP id
 6a1803df08f44-908496e9b8emr229024046d6.28.1785759443760; Mon, 03 Aug 2026
 05:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de>
In-Reply-To: <20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 3 Aug 2026 13:17:11 +0100
X-Gm-Features: AUfX_mygMzmnWXgCbbInWd9wmrzQze0OT1sMXHnDCijF42aK1VP89eDWz05whNQ
Message-ID: <CALeDE9PhmuHkiR5k0H=7mdCwq=n=1gS80vuQQqb8GdpKMYM3nA@mail.gmail.com>
Subject: Re: [PATCH v2] rpi: copy /chosen/bootloader partition and set
 boot_partition
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.u-boot-project.org, Matthias Brugger <mbrugger@suse.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785759444; x=1786364244;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kESVnQZ+HH+QrMa88CwLIOKb1qwyziyKnxeeUNM0Fl0=;
 b=GEeq/wE5dh5dyYxRwONAaxpcO+f65U4p0Zw92nkaKdVFFK0l7IkMrmvzRGrKurdsm6
 ETA9iDjcUuGxNjN/Zp1nfuPR763ROHOntopuxtmIv+Mp9SIT53v8/npN7U7I2lrglp7J
 XkUJ6nsUwntd8vMfvM7a+zJ5OdFv3LlDune0BnadhJvZ5K9NjvnAfTnp0vgQPZxoTF2m
 dXhAWT2LZPVVp+XE1Xjabr8JuTcZFocoh+k0UXw8iVaBVsSPEDb/4Kyog/HCUUkJo1q8
 msLaCHR3ykLF+Q37d4U6Qlxt9looiW4dnLfsvcPK/o4wENa577YaV0n6HnWPkLyfKFCn
 r6MA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GEeq/wE5
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

Hi Gregor,

> The Raspberry Pi has the "tryboot" feature where it can boot from a
> different partition enabling failsafe A/B updates. After boot the
> firmware sets 'partition' property in /chosen/bootloader. Copy this
> property to the device tree and set the env variable boot_partition.
> This allows boards to create a bootcmd based on the boot partition.
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
> Changes in v2:
> - update Reviewed-by tag

You don't need to do a v2 for a tag, patchwork will deal with that
automatically.

I looked at this briefly on a RPi4/5 yesterday and couldn't see the DT
bits being passed through to the kernel, purely by a simple test of
looking in /proc/device-tree/chosen/ directory and didn't see the
bootloader/ directory or added/amended details, where if I boot off
the FW DT I see:

# ls /proc/device-tree/chosen/bootloader/
boot-mode build-timestamp  capabilities  name  partition  rsts
tryboot  update-timestamp  version

Not sure if this is the versions of firmware/U-Boot/downstream DT I am
using or something else. I wonder also if we should just amend
everything in the branch of the DT as no doubt others will want other
bits for other features.

Peter

> ---
>  board/raspberrypi/rpi/rpi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1da5df92351c..7a2ff646ac8c 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -480,6 +480,20 @@ static void set_serial_number(void)
>         env_set("serial#", serial_string);
>  }
>
> +static void set_boot_partition_fdt(void)
> +{
> +       void *fdtp = (void *)gd->fdt_blob;
> +       u32 partition;
> +
> +       partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
> +       if (!partition) {
> +               printf("Failed to the get partition property.\n");
> +               return;
> +       }
> +
> +       env_set_ulong("boot_partition", partition);
> +}
> +
>  int misc_init_r(void)
>  {
>         set_fdt_addr();
> @@ -489,6 +503,7 @@ int misc_init_r(void)
>         set_board_info();
>  #endif
>         set_serial_number();
> +       set_boot_partition_fdt();
>
>         return 0;
>  }
> @@ -641,6 +656,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>
>         /* copy uart clk as provided by the firmware */
>         copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
> +
> +       /* Copy the boot partition */
> +       copy_property(fdt, fw_fdt, "/chosen/bootloader", "partition");
>  }
>
>  int ft_board_setup(void *blob, struct bd_info *bd)
>
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260803-tryboot2-8c5221376e5a
>
> Best regards,
> --
> Gregor Herburger <gregor.herburger@linutronix.de>
>
