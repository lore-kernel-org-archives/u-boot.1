Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD1CD5E373
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 15:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43ADA88B9E;
	Sat,  9 Nov 2024 16:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cCvRGWhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCBA88C0F; Sat,  9 Nov 2024 16:12:56 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD6B88AE8
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 16:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so37093271fa.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731165173; x=1731769973; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/r6UZ6UwEM92n5uzdFsM/Casbfgn68C6dWpWE62sbKk=;
 b=cCvRGWhJhVlcdoX6Nvzv+O6QbqtbYYfXqGTpGQ/W/BvAd5Xa8pZ+/4hydGo7x7ob3g
 3E9Ojsz7xR/YRzgvUpn+5ZQwF0whZuIJYJwDDTQzVhImLa/W6Pc3IrMteOhg2APf3uTa
 pU7I9xS6xbPR+nVWIgfnw9dza7/V3L6+D+wcpeqkvs/kS9fHeEuMG6biZoMYiJnCw2/x
 XrwqMK6f1Ll3lhW8rT4fykn4/sw1cmeaf6lyGT536x0xepRM8+SI7AlUwPreYuEZhcJQ
 a+02V9pmY6IZn/lm2ai2QBCrjbOS5+PG49eJN72usW6zrEJqz+DRQdXXtg/9mPktC0Be
 PWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731165173; x=1731769973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/r6UZ6UwEM92n5uzdFsM/Casbfgn68C6dWpWE62sbKk=;
 b=OpyidbIf63eLOlwhvqND9GnO3oEOTD3eLos9HFJc9SDcmhWG0Q3xvbCJfWDetfVsYc
 G1EGPmV2pWsXpjUm6nzn1b8XpYcE6FVewDE7QrEtsJrEb91CechHfTrbbEv1rD4CDeku
 WSDi4sDQlBDLcUWCC8BtPEyOf9SZ1GM8C3b0tRDg8nnPs/RpQlP2j2Mv3TaFPPBXhfK3
 ZgL0O7z4RGB/9REmvwb1xkSAglVQzlMIZwqQpROyq5cK2Dr7GhftLGbSIQ3BTYtkPu1q
 95N/swb4DFupgCzgU7Lqag37Qm22xmNRZ2MrJMKZM3oRAxSAxLEGcQuDyNh6UNp/HtKA
 rBdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwsy3G/w6H2Wj8z/siFwxPUUPXaz7ObFjfZUpFgzLlFQsN2pvOy33gnO2eiRRn9PGKdhNpODQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs4pMmXjwhAEGULHpxm+9j6RTnjZfPxnB342h+sjG7xiKIcjg5
 dbJvph/hSJD6huCGalshrqCBMTVT2+FAqokie5hna9hzJthB+mPATY0bPlwz96nE7iI/g7il4RS
 f2CHINAhIhLYiIUAVlk4aGABW9aBloOAy
X-Google-Smtp-Source: AGHT+IFrl9aNA73zvHNb0KJk1Bt3e/yVl0Wz4Ab8yUv7QlHL7KFRoXr7xhOhaBrWcQ9k65dp0ppDqBLpiuvWm7vrmew=
X-Received: by 2002:a2e:a551:0:b0:2fa:cdac:8732 with SMTP id
 38308e7fff4ca-2ff2028ad8fmr49677151fa.30.1731165173033; Sat, 09 Nov 2024
 07:12:53 -0800 (PST)
MIME-Version: 1.0
References: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
In-Reply-To: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 9 Nov 2024 07:12:41 -0800
Message-ID: <CANV2PTNScpCfP3vuwHFchR7ZgP5oDGUe1-9Lg5u2v8-cU48Pig@mail.gmail.com>
Subject: Re: [BUG] dhcp fails to download file with CONFIG_NET_LWIP=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sat, Nov 9, 2024 at 6:20=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Hello Jerome,
>
> Using the old network stack U-Boot's dhcp command can be used to
> download via TFTP. This fails with the lwIP stack:
>
> StarFive # dhcp $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
> ethernet@16030000 Waiting for PHY auto negotiation to complete.... done
> DHCP client bound to address 192.168.1.47 (233 ms)
> StarFive # tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
> Using ethernet@16030000 device
> TFTP from server 192.168.1.103; our IP address is 192.168.1.47
> Filename '/vf2/grubriscv64.efi'.
> Load address: 0x40200000
> Loading: ################################################################=
#
>           ###############################################################=
##
>           ###############################################################=
##
>           ###############################################################=
##
>           #########
>           4.1 MiB/s
>
> We should try to provide the old functionality to make the move to lwIP
> seamless.
>
> In the CI QEMU instances we already have
>
> test/py/tests/test_net.py
>
> to test tftpboot. We should add an equivalent dhcp test.
>
> Best regards
>
> Heinrich

It is useful to have dhcp assignment without the side-effect of trying
to load files. Your script can be updated to:

dhcp ; tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi

I agree this is a change in the user interface, but this change makes
sense to me. There needs to be a way to boot tftp using the DHCP
optioned tftp server, but a command 'dhcp' does not have boot in the
name it is not clear what this command does. All other commands that
do a boot action have 'boot' in the name? Perhaps dhcpboot or to make
tftpboot with an option to use DHCP options for the tftp server
location.

I don't think 'dhcp' should do anything except DHCP.

-E
