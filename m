Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45103C531DF
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 07:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9204988EA4;
	Thu, 22 Aug 2024 09:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0SLtBTFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E06288E7F; Thu, 22 Aug 2024 09:22:04 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E4688EA4
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 09:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-371893dd249so179190f8f.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724311320; x=1724916120;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=djNJOmnsNFriUmgJlGnidMODdNUeQ2UpQSjzuoKw4zQ=;
 b=0SLtBTFehuXQm3l/CINdGs8nxnVv7Bnm91VZfWB6Vqcs4eck8VGSTNvGxBptEU6ZF2
 T5C9vyJu8822M+Yd4hM2kCUiUVCvjv/F+jwhKJEhxwGDw1OAf4A+CiHxDVF5P51lh844
 Na2jl/ssronlQpaeoZ5JeseMyhUL3N89HmGi7f2cThE9mjq2jIQS7Qn8hgIQ+Irp3nbF
 pqtrz0dw0TtTLEeaOQDbLMwTcX4jNCwZjlChsK1dOxmd5A/8UqcfWCOYw0NG8Kp2D6up
 njZ/NwBP1kNv5fica+hETrt4THtFXwWqQwYxsFqYK1LBWLFPgnBr1dThTCWHi83DmlFt
 Y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724311320; x=1724916120;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djNJOmnsNFriUmgJlGnidMODdNUeQ2UpQSjzuoKw4zQ=;
 b=ZOmVvbei0ZVHnSsYsuVwRjFFirDl7ZanmlDPUpPNHfOMKCSHcHCLR/TzH/tfbNAFCY
 MpW+HWI0JXZQLvHWCyCWOn6KskVZHN7BWo4TJHrx5kzwS7myn1PT3Se1tlnpfuNJb6oJ
 KiAPhmFwjapTwFd/tjAVInMl1WqhcoyKJLDJ5ivEVPR64UgWUybDrsa3TVkbFPv5frBt
 LZGDONeIqN/ilQ9zKfaAo2LyXo6n2V+18Xv67q9zWH4elUHL/DjkbM4b02VdcMUo6E22
 yeBqKQeIuIIZh95q12Kk9reK8WRPot6AE2S4DgL2SpTmPnYvMu0s63TNR+Qm7ZnOfSXH
 OU2w==
X-Gm-Message-State: AOJu0YxAaTQsPZs+UNub816pMKBKpG4DokIP9mFLX0jicIPyGKx5Zmq7
 7Fg5Ac2ZLNkyFy23sE6V3v4NbE60MJiS21MNDFcr+ulzcGyYDadKJnC/6Jt2bHA=
X-Google-Smtp-Source: AGHT+IEhVZzIdVrJolWZLhhVFUHInb/0yBpkA5QsTZyuevwKUQ1Ru+Fe/aizQH8EIoHJRjR9AClwIQ==
X-Received: by 2002:a05:6000:196b:b0:367:9854:791d with SMTP id
 ffacd0b85a97d-372fd7015d2mr2423448f8f.43.1724311320068; 
 Thu, 22 Aug 2024 00:22:00 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308160426sm920675f8f.57.2024.08.22.00.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 00:21:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michael Walle <mwalle@kernel.org>,
 Zixun LI <admin@hifiphile.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240820
In-Reply-To: <20240820151112.GM1626301@bill-the-cat>
References: <87zfp7vf43.fsf@baylibre.com> <87o75nut6k.fsf@baylibre.com>
 <20240820151112.GM1626301@bill-the-cat>
Date: Thu, 22 Aug 2024 09:21:58 +0200
Message-ID: <87msl5c99l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 20, 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Aug 20, 2024 at 05:09:55PM +0200, Mattijs Korpershoek wrote:
>> Hi Tom,
>>=20
>> On mar., ao=C3=BBt 20, 2024 at 09:16, Mattijs Korpershoek <mkorpershoek@=
baylibre.com> wrote:
>>=20
>> > Hi Tom,
>> >
>> > Please find some fixes for master:
>> >
>> > - Fix crash in BCB on invalid block device (reported by coverity)
>> > - Fix booting Android kernel without a ramdisk using fastboot
>> > - Delay ethernet gadget driver init to ensure interrupts are available
>> > - Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST
>> >
>> > CI job:
>> > - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22057
>>=20
>> Please hold on before merging this. There seems to be some ongoing
>> discussion about
>> https://patchwork.ozlabs.org/project/uboot/patch/20240726083102.380719-1=
-admin@hifiphile.com/
>> on irc [1]
>>=20
>> I'd like to sort things out before this gets applied to master.
>>=20
>> Sorry for the inconvenience.
>>=20
>> [1] https://libera.irclog.whitequark.org/u-boot/2024-08-20
>
> OK, thanks for following up in email.

As there are still discussions on this patch, I will send a new PR
without this one included.

>
> --=20
> Tom
