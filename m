Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65844C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 01:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A424F87083;
	Thu, 30 Nov 2023 02:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwJ1V74V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE95E870AB; Thu, 30 Nov 2023 02:15:57 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2591886F64
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 02:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=siarhei.siamashka@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-daf7ed42ea6so350617276.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701306954; x=1701911754; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXKP4SSt0qypx9B+Eqm6qceJHM70vdhk5fcUjlGzGN8=;
 b=KwJ1V74VMyKCfqjPgXD8TdxniGD5cCSrk4bgiPTdngITcwwmHkWszb8DgpdIuus95F
 /Fx4UTDulIWq0WRW451yF2E1tk6HwczMehMRzZxCH5iy4QuTAg+JhRcDoxinMzPIqsQD
 3em8fARCxTWFW1YIVBgpgFxkM5IqJJcl7iva4dtYrncTRzL+LVx0xI15GYSRFh11qxku
 hRz453dFj26LrUQejy/eNy+tpl4CrggXq0O6MK+8lk8ew54IwXH+Vj2XpM0oKV3FM13d
 Q+5Db+WEcSzJIwgrVhsgnm7y7Arpxx7oNLLw9zC7B82W6QvaBlCLye35/sq0YFCmzX5Q
 Dg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701306954; x=1701911754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXKP4SSt0qypx9B+Eqm6qceJHM70vdhk5fcUjlGzGN8=;
 b=wk4Hi/VRQ3ebX+1VILsmpO6d/Yk5McZEmEb/Dwv3cROlg5ZzUS2yTpEmedopBA+Haq
 iZXWQ0oW0zR7Je7AXgdLadaAabuDaPMCHXizyWaZjg3Zho9E8FmLM1qde5AoFjqz0VIh
 HY0yTRmiTGQYXsNcqMcGmXjrnLhTn2UdjTCYVurJ75HQp97V3jX7jABJ4RMSlFObrIBk
 +OGwwRTQQV6X8xQE8Op8cdQKgmCEhq7rRinZWDNXs6B5SL6Qq4W+k0wXAdWyQNAKTVh5
 Hrs99EQeLqpScNNGPrELlAbRO8X6rdu0iHviYsIW+b70qyJaXfHIPoYHu9F2YECMFW10
 DdmQ==
X-Gm-Message-State: AOJu0Yz80zjy3nh4AhWPNaOhE/svqi+uPVKScvGCTSxvMxk/AJMuw525
 uyAY9g8XMzYqmZV6stc55XBk5BBdM1oGUnNJedo=
X-Google-Smtp-Source: AGHT+IGVRIudbBlARhfV3dqZtthM4lt6AohTe9WBzEO80sP2IC/7J1wKXyHc+Jc/g8aFGGvcWpsz4G9o1OVuGCeySIs=
X-Received: by 2002:a5b:550:0:b0:daf:18e5:3935 with SMTP id
 r16-20020a5b0550000000b00daf18e53935mr18397982ybp.9.1701306953718; Wed, 29
 Nov 2023 17:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <0560924e-119b-4122-ad5b-bd563554eb10@gmail.com>
 <3c5b7d67-f8e5-41a3-a34b-8f59f9adb117@arm.com>
In-Reply-To: <3c5b7d67-f8e5-41a3-a34b-8f59f9adb117@arm.com>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Date: Thu, 30 Nov 2023 03:15:41 +0200
Message-ID: <CACY+gR35tzYEiGvGVgBw6hH8D451-dsi3G+4bLbLipnYDpD62g@mail.gmail.com>
Subject: Re: OrangePI Zero3 memory timing testing
To: Andre Przywara <andre.przywara@arm.com>
Cc: Stephen Graf <stephen.graf@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de, 
 linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

Please try to insert udelay() calls in addition to dsb() in the
mctl_mem_matches()
and see if this helps. I suspect that there's just no way to do
perfectly reliable
synchronization all the way from the CPU to DRAM and back in this particula=
r
scenario (which involves wacky things, such as accessing aliased physical
memory addresses). So just having a generous delay may do the job and
solve all the timing issues.

Another comment is about the use of memtester program. It's actually not ve=
ry
sensitive to memory reliability problems as-is.

Back in A10/A20 and H3 days, it was necessary to run memtester simultaneous=
ly
with a Mali GPU rendered spinning textured cube animation for best results:
        https://github.com/ssvb/lima-memtester
For example, a misconfigured H3 DRAM was showing no problems at all in
the memtester test at 624MHz, but couldn't survive memtester together with
the spinning textured cube until downclocked to 384MHz. Only aggressive
simultaneous access from both CPU and GPU really exposes reliability
problems. The other types of DMA transfers couldn't replace the GPU. It
was also possible to use the G2D accelerator instead of the Mali GPU, but
only when performing 90 degrees rotations. Doing simple non-rotated blits
with G2D was useless and couldn't expose reliability problems.

I would suggest to install 3D drivers (whatever is available for the
modern kernels
nowadays) and run some textured spinning cube demo together with memtester
before deciding that your DRAM configuration is alright.

On Thu, Nov 30, 2023 at 2:11=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> Hi Stephen,
>
> On 29/11/2023 18:45, Stephen Graf wrote:
> > Some testing results:
> >
> > With the default DRAM timing of 30x24=3D720, most often when my system
> > boots it comes up with DRAM 2G, but I have a 1G system. Once in a while
> > the boot shows 1G.  When it shows 2G the linux OS also shows 2G and
> > continuing does not make much sense.
> >
> > On one boot where u-boot reported 1G the OS agreed and I ran memtester
> > successfully.
> >
> > If I build u-boot with CONFIG_DRAM_CLK=3D792 (33*24=3D792) I have never=
 seen
> > my system boot with anything other than DRAM 1G showing in u-boot. I ra=
n
>
> Interesting, many thanks for the elaborate experiments!
> To be fair, the timing parameters were from Xunlong's setup, so with 792
> MHz, but I remember that in my early testing this failed more often than
> not, so I reverted back to 720MHz. But I had different parameters back
> then, I believe. I will try to arrange some boot loop, to see how it
> fares with the 792 MHz, though I believe you that it's more stable.
> If that works, I will send a v2 with the USB and the DRAM clock fixed.
>
> Thanks again for testing and the report!
>
> Cheers,
> Andre
>
> > memtester successfully and this system has been stable running linux 6.=
6.2.
> >
> > Andre, if you can put together a few patches I can test them to see
> > which works.
> >
> > If anyone else with different variations of the Zero3 would test with
> > the two DRAM timings and report results.
> >
> > I also use the Zunlong image on occasion and it consistently shows 1G
> > and from my poking around I think it runs at a 792 clk.
> >
> >
> > Console output with DRAM default:
> >
> > U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39
> > -0800) Allwinner Technology
> >
> > CPU:   Allwinner H616 (SUN50I)
> > Model: OrangePi Zero3
> > DRAM:  2 GiB
> >
> > Last login: Wed Nov 29 09:35:15 PST 2023 on ttyS0
> > root@orangepizero3:~# free -h
> >                 total        used        free      shared  buff/cache
> > available
> > Mem:           1.9Gi       139Mi       1.7Gi       360Ki        82Mi
> > 1.7Gi
> > Swap:             0B          0B          0B
> >
> >
> > U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 22:46:39
> > -0800) Allwinner Technology
> >
> > CPU:   Allwinner H616 (SUN50I)
> > Model: OrangePi Zero3
> > DRAM:  1 GiB
> >
> > root@orangepizero3:~# free -h
> >                 total        used        free      shared  buff/cache
> > available
> > Mem:           917Mi       137Mi       766Mi       360Ki        79Mi
> > 780Mi
> > Swap:             0B          0B          0B
> >
> >
> > root@orangepizero3:~# memtester 700M 1
> > memtester version 4.6.0 (64-bit)
> > Copyright (C) 2001-2020 Charles Cazabon.
> > Licensed under the GNU General Public License version 2 (only).
> >
> > pagesize is 4096
> > pagesizemask is 0xfffffffffffff000
> > want 700MB (734003200 bytes)
> > got  700MB (734003200 bytes), trying mlock ...locked.
> > Loop 1/1:
> >    Stuck Address       : ok
> >    Random Value        : ok
> >    Compare XOR         : ok
> >    Compare SUB         : ok
> >    Compare MUL         : ok
> >    Compare DIV         : ok
> >    Compare OR          : ok
> >    Compare AND         : ok
> >    Sequential Increment: ok
> >    Solid Bits          : ok
> >    Block Sequential    : ok
> >    Checkerboard        : ok
> >    Bit Spread          : ok
> >    Bit Flip            : ok
> >    Walking Ones        : ok
> >    Walking Zeroes      : ok
> >    8-bit Writes        : ok
> >    16-bit Writes       : ok
> >
> > Done.
> >
> > Console output with DRAM clk 792:
> >
> >
> > U-Boot 2024.01-rc3-00028-g43f2873fa9-dirty (Nov 28 2023 - 21:34:46
> > -0800) Allwinner Technology
> >
> > CPU:   Allwinner H616 (SUN50I)
> > Model: OrangePi Zero3
> > DRAM:  1 GiB
> >
> > root@orangepizero3:~# free -h
> >                 total        used        free      shared  buff/cache
> > available
> > Mem:           917Mi       134Mi       768Mi       360Ki        79Mi
> > 782Mi
> > Swap:             0B          0B          0B
> >
> >
> > root@orangepizero3:~# memtester 700M 1
> > memtester version 4.6.0 (64-bit)
> > Copyright (C) 2001-2020 Charles Cazabon.
> > Licensed under the GNU General Public License version 2 (only).
> >
> > pagesize is 4096
> > pagesizemask is 0xfffffffffffff000
> > want 700MB (734003200 bytes)
> > got  700MB (734003200 bytes), trying mlock ...locked.
> > Loop 1/1:
> >    Stuck Address       : ok
> >    Random Value        : ok
> >    Compare XOR         : ok
> >    Compare SUB         : ok
> >    Compare MUL         : ok
> >    Compare DIV         : ok
> >    Compare OR          : ok
> >    Compare AND         : ok
> >    Sequential Increment: ok
> >    Solid Bits          : ok
> >    Block Sequential    : ok
> >    Checkerboard        : ok
> >    Bit Spread          : ok
> >    Bit Flip            : ok
> >    Walking Ones        : ok
> >    Walking Zeroes      : ok
> >    8-bit Writes        : ok
> >    16-bit Writes       : ok
> >
> > Done.
> >
> >
> > On 2023-11-27 5:37 p.m., Andre Przywara wrote:
> >
> >>
> >> This symptom is pretty surely not directly related to the DRAM
> >> frequency, it's caused by a missing barrier or delay *somewhere*.
> >> People report that this is fixed by adding another "dsb();" at the
> >> beginning of the mctl_mem_matches() function, but I don't have a good
> >> explanation why exactly there, and would like to avoid submitting
> >> patches that "just seem to work (TM)".
> >>
> >> If I find some time, I will try to setup some automated environment
> >> where I can run some experiments with different barrier locations.
> >> I can offer some rationale for putting it at the end of the function(s=
)
> >> that call mctl_mem_matches(), so hope that this fixes it.
> >>
> >> Cheers,
> >> Andre
> >>
