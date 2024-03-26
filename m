Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BD9C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71C487C69;
	Tue, 26 Mar 2024 16:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXVbznk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B81B87E47; Tue, 26 Mar 2024 16:58:00 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F198987C60
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 16:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d862e8b163so1212320a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711468675; x=1712073475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdlDC/4OAhHJHYE2jz7dYmbrQtvSi8amUpcxzYgzY1I=;
 b=lXVbznk2KJdbIJeaoboiSoa7sk+3kJDjbGTruHfrzX3SztfogP/UJhl0I2th91q28/
 NOTQDS/Fyv6Pn3cn9AfNiC6oVSViSI6jCHmnVwm27gih19qHiZZ3d/eK7K3hlab6VdkI
 VxjiLVd4uAcBsTXKIArN91zygihsfmONv6JzgSJbmhMOU6ejFHVonmGMqfmR63vEQ8n8
 QlnVYbR4XfVxjunjVVIaotNSrCkypA3H6+QmDMqfWdGjHJR+JIhQ+pqNO80lAYXvh1nI
 fIZqpS9N3i9PgSi39pjHBcnXy7c+AMA3hDPhPum0x/hZFdmM7oCCFcFmSrIFbsFsadWY
 0x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711468675; x=1712073475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdlDC/4OAhHJHYE2jz7dYmbrQtvSi8amUpcxzYgzY1I=;
 b=JuxXnH8fUuoI93JN1eCp1SJIp4qBERRJN9n1Ss67lrRq4ayYpBNVEjgWz4jYRhbYgt
 IJGzxGiK9LIQyviGggb9aaUBi6xZMEvpo6gBBM2vBO5TWZi1iY0X6OmjCo6Ue7hdd1Yz
 2NgeEknXwrx8CUP9JOM+WGqp5ZbSyUpo5RvtUHM6f8XQYa72qhmJ3CQ7TitwwbsKeB3/
 kkHBfkTncgUUiulJ1ao1Qxxd8h4qNL3RKakiIzGbXWjhj5TI1W1z/g7q2KQ4+k6VVkLu
 fiIb1UNh39lNroMhfD2WkJeeIGjN3LYexcBkdJDCobMZQix/s8f3FU2uCkbvHva36qoi
 wMpg==
X-Gm-Message-State: AOJu0YxCsn71Yo0RhF81brbJ0clZKEpj2aOyhaknTpeWj2v8BvR6RP/+
 GgGnxx8RnaGo7RvZ5uJZ3fFGRvHl1flKoWnK9fcMCLwCMmFS7o3kOUhZNcoPbb5L/M4ZseDGHPe
 TPtXRRBwZAi3NDt6k3UNHbAfMxW8=
X-Google-Smtp-Source: AGHT+IGFkwkZ6DHaTGMzL8mW25fpHC2pTa6W7lme+jsoWUfzNR6ns3XbjfuBRNgVDgXGqJJcaTkoM+Cj09LUWbCmnEY=
X-Received: by 2002:a17:90a:bb94:b0:2a0:2605:69be with SMTP id
 v20-20020a17090abb9400b002a0260569bemr9013353pjr.2.1711468675283; Tue, 26 Mar
 2024 08:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
In-Reply-To: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 12:57:43 -0300
Message-ID: <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
Subject: Re: mx6cuboxi: failes to detect model
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, jonas@kwiboo.se,
 josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
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

Hi Christian,

On Tue, Mar 26, 2024 at 12:17=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> I am seeing model detection problems with the current git master.
>
> U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)
>
> CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
> Reset cause: POR
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
> gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
> gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
> gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
> gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
> gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
> Board: MX6 HummingBoard

Unfortunately, my mx6cuboxi no longer works, so I can't test it myself.

I am adding Baruch on Cc. Hopefully, Baruch or Josua can take a look.

The 'not reserved' errors may be caused by the lack of gpio_request().

Do the changes below help?

--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -336,18 +336,21 @@ static enum board_type board_type(void)
         * HB             1     1    x
         */

+       gpio_request(IMX_GPIO_NR(2, 8), "val3");
        gpio_direction_input(IMX_GPIO_NR(2, 8));
        val3 =3D gpio_get_value(IMX_GPIO_NR(2, 8));

        if (val3 =3D=3D 0)
                return HUMMINGBOARD2;

+       gpio_request(IMX_GPIO_NR(3, 4), "val2");
        gpio_direction_input(IMX_GPIO_NR(3, 4));
        val2 =3D gpio_get_value(IMX_GPIO_NR(3, 4));

        if (val2 =3D=3D 0)
                return HUMMINGBOARD;

+       gpio_request(IMX_GPIO_NR(4, 9), "val1");
        gpio_direction_input(IMX_GPIO_NR(4, 9));
        val1 =3D gpio_get_value(IMX_GPIO_NR(4, 9));

> DRAM:  2 GiB
> Core:  82 devices, 17 uclasses, devicetree: fit
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... *** Warning - bad CRC, using default envi=
ronment
>
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eth0: ethernet@2188000
>
>
> I did a git bisect to find the commit that broke model detection:
>
> # good: [4459ed60cb1e0562bc5b40405e2b4b9bbf766d57] Prepare v2023.10
> git bisect good 4459ed60cb1e0562bc5b40405e2b4b9bbf766d57
> # bad: [873791433602281ed230486606e326983c97a285] Merge
> https://source.denx.de/u-boot/custodians/u-boot-riscv
> git bisect bad 873791433602281ed230486606e326983c97a285
> # bad: [6e0a75d3162a024cb0cdedd871d435e6ee782447] configs: Resync with
> savedefconfig
> git bisect bad 6e0a75d3162a024cb0cdedd871d435e6ee782447
> # good: [99b46477e3495f819f6826d11470d46f12a4f9f7] clk: Dont return
> error when assigned-clocks is empty or missing
> git bisect good 99b46477e3495f819f6826d11470d46f12a4f9f7
> # bad: [50fa67d091b6ffbc1d77d3100d7b31795bf64928] arm: mach-k3:
> j721e_init: Move clk_k3 probe before loading TIFS
> git bisect bad 50fa67d091b6ffbc1d77d3100d7b31795bf64928
> # bad: [827cece3aa550d41e9c08c640b3a73372c8fb14a] pinctrl: renesas:
> Synchronize R8A77980 V3H PFC tables with Linux 6.5.3
> git bisect bad 827cece3aa550d41e9c08c640b3a73372c8fb14a
> # good: [623b3e8f9718a1fbd612b3e42451859e9f98a947] x86: spl: Change
> the condition for copying U-Boot to RAM
> git bisect good 623b3e8f9718a1fbd612b3e42451859e9f98a947
> # good: [ad57b98e212bd15492398cea3a8d4df6297e16fd] x86: doc: Split out
> manual booting into its own file
> git bisect good ad57b98e212bd15492398cea3a8d4df6297e16fd
> # bad: [6d53b50888315252cdd3251551add7a9108a1300] ARM: renesas: Enable
> DM_ETH_PHY on 64-bit R-Car boards
> git bisect bad 6d53b50888315252cdd3251551add7a9108a1300
> # bad: [283dcb63cb7d124fa427938f39aa9362872e02fc] buildman: Show
> progress when regenerating the board.cfg file
> git bisect bad 283dcb63cb7d124fa427938f39aa9362872e02fc
> # bad: [9e644284ab812f2db23f6185af77c0e771b0be73] dm: core: Report
> bootph-pre-ram/sram node as pre-reloc after relocation
> git bisect bad 9e644284ab812f2db23f6185af77c0e771b0be73
> # good: [b05a184379631d13c4a49e423aa1324dc1ae6158] Merge tag
> 'x86-pull-20230922' of
> https://source.denx.de/u-boot/custodians/u-boot-x86 into next
> git bisect good b05a184379631d13c4a49e423aa1324dc1ae6158
> # first bad commit: [9e644284ab812f2db23f6185af77c0e771b0be73] dm:
> core: Report bootph-pre-ram/sram node as pre-reloc after relocation
>
> If I revert 9e644284ab812f2db23f6185af77c0e771b0be73 on top of git
> master everything is fine again. As I am not an export in that area I
> am seeking
> some directions on how to fix this issue.
>
> --
> greets
> --
> Christian Gmeiner, MSc
>
> https://christian-gmeiner.info/privacypolicy
