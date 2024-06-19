Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0D1C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 07:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E876883F6;
	Wed, 19 Jun 2024 09:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="azcXESxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9616588400; Wed, 19 Jun 2024 09:25:20 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40190883E7
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 09:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c4af25f7d7so5306262a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718781917; x=1719386717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5yUcM2r7KgukhMAVi4mxJTid+HTbBYIp1p91NfG/n24=;
 b=azcXESxncfiLQlPYwJe/g4Q/50XLwpFyLO/rpP41BUL1p4zk3ebB0TOuqmbetTSiAt
 qOlXB38HrZUoMEHmYtUuMNBA1P6MtBOkWCb955/5KX626EKaxhkv3oj4nOEYjCheLcwM
 MkHiGI9RQ5nwJZDXxzWjvXsuldztMndaaeu95xrTDjhyPNAWexo2lFpTkNqaxNzq5obx
 wEATr9h+Nj2fh/LJSRdUs0d+5Pp4Ts5R8jzGBm+0H1cgtTgby7wgQJPOlTcTEgg34Teh
 814jZu0LQO3kAUNeaa9737/ih6+q4SWv6/j8jYhjnO4Kzj8EG8xY6GQJUJQFd2K4mjOR
 ln4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718781917; x=1719386717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5yUcM2r7KgukhMAVi4mxJTid+HTbBYIp1p91NfG/n24=;
 b=unKSYTEh31mewTdPoCBkFFC4hfl52OPjwND4889z96Em5FlmJkdHgb0wekyxviW8cW
 3JfuJ6lBp/L5jbe7lLwzT48e2QReedSTYADCAQZvaQaVvaq8ME+WcI00MH5Nkxc2T14a
 7U/FP8Il7fKUTGxa1MoCOXC06KWoIqF7wbN24MDyx0A/FtTmaxydGfO8TZYNmK/cMXpD
 c8JkWsYSLGqY3s+DHf9CGx1OXMHDyNBbwMId/dxnc/xNZEMSD/s2ahdRa4WqflqdGN3B
 tJShg6sukNC/fAZ34X4/hcP2iAKPmbhuKnXRV7rVQp+clEk3LIKNfeFsvOVIflr2Kl8D
 mwBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+hp9TbhBSHQYkOyuEMF4TTgJvTBKsmkxR+ZkypGNqYomr1Jv5hmRjJvm2HKK/cPxwjCtMYZEKloj1Q6zLHrN4tQLSMA==
X-Gm-Message-State: AOJu0YyQwcrHupe2xV+GxsZJSiBl9GedEoGWoXWmvLNZaD/+uPJl25hS
 uOKPLHB4QkYdITfSkVtyM+dUm75X05WBWQvrkBx11vS/HSOMkbroApYZil3MUiJ740wCkZBNf03
 ygcYxvsXNGR9c2wJyxQkolMEbsDvMbFBgM14pFsEtQiIfKITCx5k=
X-Google-Smtp-Source: AGHT+IF/ppxswOhbGJaqyVOh3AjXHVNOD6KQaF4WTHFxLN7l8gzpa0HPQtW1BVyNUdz/MKDgNYCLO2xMHI2CpmxX2d8=
X-Received: by 2002:a17:90a:3044:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c7b5d52cb7mr2006036a91.31.1718781916646; Wed, 19 Jun 2024
 00:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <20240618202123.GW68077@bill-the-cat>
In-Reply-To: <20240618202123.GW68077@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 10:24:40 +0300
Message-ID: <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
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

Hi Tom

On Tue, 18 Jun 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:
>
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> > has some additional lwIP and Mbed TLS patches to do so. With that it
> > becomes possible to fetch and launch a distro installer such as Debian
> > etc. using a secure, authenticated connection directly from the U-Boot
> > shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
>
> So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally):
> ========================================== FAILURES ===========================================
> ___________________________________ test_efi_helloworld_net ___________________________________
> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>     assert expected_text in output
> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
> ------------------------------------ Captured stdout call -------------------------------------
> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> Using smsc95xx_eth device
> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> Filename 'EFI/arm64/helloworld.efi'.
> Load address: 0x200000
> Loading:
> Bytes transferred = 4528 (11b0 hex)
> U-Boot> U-Boot> crc32 200000 $filesize
> CRC32 for 00200000 ... 002011af ==> 2b466005
> U-Boot> U-Boot> bootefi 200000
> No UEFI binary known at 200000
> U-Boot>
> =================================== short test summary info ===================================
> If I disable that test, it moves on to failing the same exact way for
> grub. If I disable the grub test too. After that, oh, a bunch of other
> tests get skipped because CMD_NET and similar aren't enabled now, and
> the tests are wrong. I'll post that as another patch by itself. After
> correcting for that, we're seemingly noticeably slower as I need to
> increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
> testing. We no longer have the estimated speed message, so I can't as
> easily say how much slower it is. After increasing the timeout, the
> kernel boot test does work.
>
> I can note that normally it takes ~18ms to get a dhcp reply, but with
> lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
> (which, not great) but if that has a similar level of slowdown, could
> well explain it.
>

Thanks for taking the time. We'll run the pytests before v5. That
being said, my wget tests were faster with lwIP last time I checked.

Thanks
/Ilias
> --
> Tom
