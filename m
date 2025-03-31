Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE70C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92398171B;
	Mon, 31 Mar 2025 18:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="MW/epclb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9C781026; Mon, 31 Mar 2025 18:50:06 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CC981026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so7054358a12.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743439798;
 x=1744044598; darn=lists.denx.de; 
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lx2XU/NmERWsYvZ48LwHeM4pRGEkQeb7VVKf3LBnt2A=;
 b=MW/epclbBLmyaeu6LJeW4P3ibZTXhH+iIM7I4ESXs8drk/GiYMNAEHpGsoAQvUlHOl
 qHuZMBPtWSEk34b5UOhVewa0noQJv1WGDotvC0E0Bnw+BWDahEaxbCEr8zhlL+ODhJ2s
 XKaqhuxZ6Xl9cdKnQdqqtPQFBhTocP6Zyd3wQiHbr08kDzwrYvoYq2Wa5gtr/wgw2648
 +jVVO27XRjgpV8q+CqOn5nnCHHLAbH1u2EFai1P3BS84l9sd3LTD+XPNcuLqyCYCxZyb
 GVBAn40DovYLOBvF6KmYBT8DtE6nBoh+VNJJlVGkYcN1yrrF1/QkyNChmJVEdTyoIlsj
 QfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743439798; x=1744044598;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lx2XU/NmERWsYvZ48LwHeM4pRGEkQeb7VVKf3LBnt2A=;
 b=kzm9kwn+lpnqjWVNARLAVUAZ5DHmAgCcjHKb/JSnz+Qie2T7sPfu8p2fdZvFFPiaXj
 /3vMnYJNIHEudZ4PXvrRTac4NNi1z0t4sfcoTqXfSjXZ4GZBawCiH/JvaUwmEsOldZ5W
 AsiRjAe1kAST57XnI0R0cv2gxGH6nMAv3z8E9NVU4u7wR32QojZpu+CEkMOvPqyFOh0k
 bFWEAxxEuuWgV1/CbR7pMuY7S2YerPnHii35Ww+5JwDaL+VEhz+nVO2hBVLQws+/bmE2
 BFM98SfEn04FDR9e7/8i/gfinTDXbETyRbYPXqtvRaZpMTmxezBOm5uYowQ0LXhON7BH
 N56Q==
X-Gm-Message-State: AOJu0Yx3cZ17zanQSwl/hpcPPhlnrgu4Uuv012p97vmNvNmnjTB6AnS6
 hhEWjLszH818uTPed+KitCC55aBQk1cJ77Tez7pRwObDcB8ePDJYQATkutw3MAT4VhpQiAf7qXV
 htb4=
X-Gm-Gg: ASbGncv4mqSOenGtCUEC5m81qtE+Nr96kw6lq7gVQPbqWXBpI5i8MIABvN7trXOJ8Wo
 GuVWs+qAYvwomLIAxe1KZh6lgwa1Mjk8QUYZeNHkvWB0XgakOq7RNPXhUwdGx+MQtLpMiM9P8P/
 5QSRoa/G13qQ1lHimDpaNdZrypvFfHXsUlNcpvRsmbApW1Hg6IVH1Fq1dg3vldngLoV2/2ECCBA
 a6+W3ND/oX0y08xwXDh6FcptTiiFWBtyhpPjX4TPTooFQ5yzXrpHwzfa2xmlosyycg7c1hJWEVc
 rjAGcMT1iY4d+vO+XA2fX40/crfhu21yal07xwUGE9krN98wFZuEL4QntovgpqBwrsBZ
X-Google-Smtp-Source: AGHT+IEQLeHlWVnRK+ayUNoWXV7bVFnInMboI+SnvSH/HMdfsjeQUKPjuV/kiUiSgm3d+GxFCYk7bQ==
X-Received: by 2002:a05:6402:358a:b0:5ec:fd7d:fdd5 with SMTP id
 4fb4d7f45d1cf-5edfdd25e8fmr7522291a12.29.1743439797445; 
 Mon, 31 Mar 2025 09:49:57 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17b2abesm5833366a12.60.2025.03.31.09.49.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Mar 2025 09:49:56 -0700 (PDT)
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: =?utf-8?Q?U-Boot_interferes_with_initrd_binary_=E2=80=94_Revert_?=
 =?utf-8?Q?=22efi=3A_Correct_smbios-table_installation=22_=3F?=
Message-Id: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
Date: Mon, 31 Mar 2025 18:49:56 +0200
Cc: Michael Brown <mcb30@ipxe.org>,
 sjg@chromium.org
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.400.131.1.6)
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

Hi all,

After upgrading some rather old U-Boot/IPXE setup on two aarch64 boards =
(Amlogic S922X-based ODROID N2+ and RK3399-based NanoPi R4S), I noticed =
strange errors in the initrd phase of my Linux kernel =E2=80=94 usually =
something like "Illegal instruction" coming from "udhcpc", etc.

The setup I have boots iPXE from U-Boot (either stored on SD or SPI), =
which then loads a Linux kernel, two initrds and a dtb from the local =
network, and boots Alpine Linux.

I found that the busybox binary used in my initrd had an md5sum mismatch =
compared to what was expected. I ruled out network problems since =
checksums from within iPXE were correct.
So some code, either U-Boot, iPXE, or the Linux kernel, were interfering =
with the busybox binary at runtime. Since a single binary is used for =
many commands, and the changes were not always in the same location, =
there was wide variety of how things could fail, and =E2=80=94 many =
times =E2=80=94 fail in way that did not prevent booting.

As a workaround, via iPXE, I added a "padding" initrd to be loaded =
first, containing an 8MB long zero-byte filled file named /.aaaaargh. If =
there were any modifications, the would hit the padding file, not the =
busybox binary.
If there were modifications, the file would remain completely empty upon =
boot.

However, they weren't:
Example dumps from two runs:

# hexdump  /.aaaaargh
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0044100 ffff ffff ffff 15dc f9c8 6f16 e188 0000
0044110 00a0 52b0 a01c 6d59 0000 0000 0000 0000
0044120 0000 0000 0000 0000 0000 0000 0000 0000
0044130 0000 0000 0000 0000 0000 0000 e1a8 6097
0044140 0000 0000 0000 0000 0000 0000 0000 0000
*
0155840 0320 0040 0000 0000 0000 0000 0000 0000
0155850 0000 0000 0000 0000 0000 0000 0000 0000
*
0800000

# hexdump /.aaaaargh
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
001f800 ffff ffff ffff 15dc f9c8 6f16 e188 0000
001f810 00a0 52b0 a01c 6d59 0000 0000 0000 0000
001f820 0000 0000 0000 0000 0000 0000 0000 0000
001f830 0000 0000 0000 0000 0000 0000 e1a8 6097
001f840 0000 0000 0000 0000 0000 0000 0000 0000
*
0094f40 0320 0040 0000 0000 0000 0000 0000 0000
0094f50 0000 0000 0000 0000 0000 0000 0000 0000
*
0800000

By git-bisect'ing the codebase I found that the following U-Boot commit =
must have triggered the bug:

> commit 06ef8089f876b6dabf56caba31a05c003f03c629 (HEAD)
> Author: Simon Glass <sjg@chromium.org>
> Date:   Sun Dec 31 08:25:55 2023 -0700
>=20
>     efi: Correct smbios-table installation
>         At present this code allocates memory when writing the tables =
and
>     then unnecessarily adds another memory map when installing it.
>         Adjust the code to allocate the tables using the normal U-Boot
>     mechanism. This avoids doing an EFI memory allocation early in
>     U-Boot, which may use memory that would be overwritten by a
>     'load' command, for example.
>         Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
>  lib/efi_loader/efi_smbios.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

=46rom what I gather from the code, the use of "memalign" instead of =
"efi_allocate_pages" could be the reason for the observed memory =
corruption, but I'm no expert in this codebase.

For what it's worth, the commit can cleanly be reverted from a recent =
U-Boot HEAD, and indeed, the system boots fine afterwards.

I also once noticed that one time the memory corruption happened after =
the first few calls within initrd, so maybe it's a "free" corresponding =
to that memalign that is triggering this bug.
Or, maybe it's all good from u-boot's side but iPXE needs to do =
something, I don't know. I'm just the messenger here...

I wonder what can be done other than reverting this change (or using a =
padding initrd during boot) ?

Thanks,
Christian

