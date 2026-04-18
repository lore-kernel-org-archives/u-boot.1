Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF5EF99C88
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 17:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11E183B99;
	Sat, 18 Apr 2026 19:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SW65SdqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAB983BC8; Sat, 18 Apr 2026 19:54:30 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E75E836AC
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 19:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12c45281a06so2256197c88.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 10:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776534867; cv=none;
 d=google.com; s=arc-20240605;
 b=DvYJRTq//ZcBYHQT3d2r9lKk/vnEB79jF7WuLKNwXG4bEfLYjxDJs81VWx63jCA+xb
 e0w3WDZQTc1xLf5AT6ANq1UK85EOr8u2Lfm7U4vD/O3JEYfuxTOkKl1dr/zbQdARTnlg
 RZCDCDrRruEPZ1ib/hcbfSvzH1Te6RyJXODol+VMFUImn8DVv8+QWScmDhgMqxm8mjks
 MRhO2ZKSg7smKTayKTm4hjOZBaqpDs3VzfdjNEilBvJLQXv1VveR0fH3NRfJwyEoiO2c
 gT158yUdpiw2aQy+aWrU7Hy7pbQwKkkb90O6NxpwnUoi/7CQajZEmkI7dFsKhGhk6UOZ
 hL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x52ISNxeEG6wUxeIk9KaZre5ZLW3C5eRCNdaEIHn1Jw=;
 fh=i3ZzfB0TqT4ttlmahJKBcR0TFB/WALhhJT7Yax2YNOM=;
 b=ktn1z3RirJf7sCvz6ZC0pJ/34PnFZ3QNMGYNvOhzSwKloKk3icxOYyFZPCzXG0dr8y
 NMESqHM2UdgkrecGpYUqZxwTSVPZdF8a8/4C5TpXc7MVdQfCs8zuGN6bVo6AkpfVOmPn
 vTKZ3JAd3OeGISUSfVNjDoGWbU5ZQR7dvlXmzlQg6KkS9rTQpZtSSUShvQBUXB/b2En9
 k34/TbzjbovXEGOHP5JxKmyU0jeSTc9LBX+YSjc2cH4irML/fVcV8KhBOFEbuzOrLfMH
 qojWtO0BLj5C1udEp6alxWU0UiXodqZwyEkeby2ev0+nJCbDUwbcq+JRIy/tHUw8VBJv
 SNJQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776534867; x=1777139667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x52ISNxeEG6wUxeIk9KaZre5ZLW3C5eRCNdaEIHn1Jw=;
 b=SW65SdqUdpySF8Q6LMgoW9vgBh4YLjorBNo1Z2dz7FFWOUDEAXj92w36kPHmeu/lAO
 VIadk4ImKpYmWrVSnsIsylifeJn8Vgi14aUqmrpTq9oELnc+ZbFRerLtQgu4ElIIuVea
 syl8QutwpjwC960RX98P5ldQFNKK28b7N0C8aIkOB/5o4iaB8vEXWFwVOsJsJOcKinAA
 0lnWS6ifVqvpJwUgeSoE7opR3/nD9TTSK2061MdHTvwdfUm0Paz3SYWijVeND+paZwbB
 aYPIcHrq4P3Ke0JK8lHLwE5nUA6+Hm7XB+Q04/t7LIBkpR8UEV2wSiGAKis1/HpABPg1
 6uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776534867; x=1777139667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x52ISNxeEG6wUxeIk9KaZre5ZLW3C5eRCNdaEIHn1Jw=;
 b=OIEm0bLzWOV1Tbd/irliGPzzz2Oxlk3yYoHshS7ICngWbuhDOF6+hntF04odXu9e6n
 ouFGIuISGxTx6RILLpj+WEaxFhk0ry8a7sCEqjHR5sFzm5JUe/e+cN9lvNPtT2fAPobe
 beQSxeK0bQOOLgjM+NHTlgKMtpcd3V2d4n58qwRc7Il0gFIWIJD9Ml0QZ8J/rteoixen
 50900bAQiWvksQcmV/AbdzPzYIYD//egt1+mGjdE1GQiyRdrmgx+pvXySej8SgNyDAbm
 oVnn5a2Gq8jOjok3MdAE/VuCSpV3SkJ5BT5x3TD87h6qNcvX8T109AISOgaM03IhUrPT
 Ml2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IUFAInl5oaHt+FxL3qz1ZA75uVr59wynWvTNznGMdd0qlyYC3Vwmwg7nYWEiphwIn5OI6V2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxoBL0p5y7YCeUEC1fUB81sp+B1ETbW7GMZpsg8l9L7kwGa+hSn
 OSk+sFhxlN5+AbRvdVwnMgfqmd7CNzbc16fYqhzQN8toupleYZugO401nVmd3/V+yFDXy4wv52l
 S/sxE58yQkLdkupGMWeG3yr0AOw8LklU=
X-Gm-Gg: AeBDiev5HeEzlrRjGeOpZtnCvT5l/1KEnDIRq1q9eAocXYLUjNkBQbqitY3cm4cJ5Of
 R/SFpDPQRDc7QFFF9xKpHZXJYX7HhHULDD8iBX6srrCUz3/8SuyEtFFgAKYr29+4fcqWLrAY+fp
 sE85P8LqC+3WPVQnViXnzqtuWNFJHGaeT3+fXaDMCRHOc0nroQpCpgIGCXZEQRjQ1xZrovV+UlP
 H/DgYD4m2HzcDj9f72vHJSeCyWak8bffBXQd10zmCsQVUQCSWqw6S1jHAxIQYgJbDHM/qFVhI3t
 WpSU2n8RjL7Lvgdw+kEmfa58EKWl/zHE25kL/HYcM/FH3iAtjTorPJgrUVYwGT8S10P5st/K62V
 Ki3gulpfAmXuacXS90gbBqXNqRU09yHpyVtdSJaJmfLPQu8Ti
X-Received: by 2002:a05:7022:2381:b0:12a:6c4b:9d01 with SMTP id
 a92af1059eb24-12c73f6d5cdmr3390207c88.7.1776534866556; Sat, 18 Apr 2026
 10:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
In-Reply-To: <aeOdF46Ny1AfNsMi@kehys.lan>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sat, 18 Apr 2026 12:53:59 -0500
X-Gm-Features: AQROBzBKZEguLMhu1kqiawLWxUoj7-Vn6sqON2mqIJ3f99sfOJvxGUbkcZlK9SI
Message-ID: <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>, 
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
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

On Sat, Apr 18, 2026 at 10:02=E2=80=AFAM Marko M=C3=A4kel=C3=A4 <marko.make=
la@iki.fi> wrote:
>
> Hi Robert,
>
> I found some time to spend on this again.
>
> Sat, Mar 28, 2026 at 11:39:00AM -0500, Robert Nelson wrote:
> >Side note, here's my ci builder for u-boot.. :
> >https://github.com/beagleboard/u-boot-pocketbeagle2
>
> I got a little further by adopting a few changes from your
> build_u-boot.sh script, namely the UART 0x6
> and the DRAM start address 0x80080000 for both OPTEE and TF-A.
>
> Previously, the UART output stopped right after switching to a 64-bit
> core. Now I am getting some further messages, but nothing for the 64-bit
> U-boot itself:
>
> U-Boot SPL 2026.01 (Apr 18 2026 - 14:03:05 +0000)
> SYSFW ABI: 4.0 (firmware rev 0x000c '12.0.2--v12.00.02 (Clever Cat)')
> Changed A53 CPU frequency to 1400000000Hz (T grade) in DT
> SPL initial stack usage: 13416 bytes
> Trying to boot from MMC2
> Authentication passed
> Authentication passed
> Authentication passed
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
>
> I/TC:
> I/TC: OP-TEE version: Unknown_4.10 (gcc version 14.2.0 (Debian 14.2.0-19)=
) #1 Sat Apr 18 14:03:00 UTC 2026 aarch64
> I/TC: WARNING: This OP-TEE configuration might be insecure!
> I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/archit=
ecture/porting_guidelines.html
> I/TC: Primary CPU initializing
> I/TC: GIC redistributor base address not provided
> I/TC: Assuming default GIC group status and modifier
> I/TC: SYSFW ABI: 4.0 (firmware rev 0x000c '12.0.2--v12.00.02 (Clever Cat)=
')
> I/TC: HUK Initialized
> I/TC: Disabling output console
>
> I am using the ti-linux-firmware branch (tag 12.00.00.07) of
> https://git.ti.com/git/processor-firmware/ti-linux-firmware.git; I
> couldn't access the repository in your script. I pointed both the 32-bit
> and the 64-bit U-boot build to it via the BINMAN_INDIRS variable.

Hi Marko,

My repo is just a mirror of:

https://github.com/TexasInstruments/ti-linux-firmware

Since my ci builders are inside the network they automatically use the
local mirror:  https://github.com/beagleboard/u-boot-pocketbeagle2/blob/mai=
n/build_u-boot.sh#L39

Please don't upgrade to the 12.x.y.z0 branch of ti-linux-firmware

After this commit you can't even upgrade to `v11.02.09` without other chang=
es!

https://github.com/u-boot/u-boot/commit/7403d26bea36315f2008ed3ef80125b094c=
0bafb

I'm pretty sure OpTee 4.10.0 is safe, but otherwise this is my current
stable branch:

https://github.com/beagleboard/u-boot-pocketbeagle2/blob/main/version.sh

i've been away hacking on other projects so i haven't been back yet to
do my 'stable v2026.04' rebase yet, on Play, AI64, BeagleY-AI, and
PocketBeagle 2 yet..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
