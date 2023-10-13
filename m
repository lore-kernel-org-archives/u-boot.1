Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD78CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 17:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F7386BDF;
	Fri, 13 Oct 2023 19:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="baNccCvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A723A86E5E; Fri, 13 Oct 2023 19:09:29 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229F9869CA
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 19:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7c08b7744so28486287b3.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216957; x=1697821757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syj+BsR++ixbzPvAYQMdf0LELBlAkJyKam00DqVDle8=;
 b=baNccCvqoXpvaNNniseiGuSUWUm/tdzjpppKMLZgAZjDpQJg5cQT39q/gJ85Xi33MI
 Tai3Aa88jrC0rsSHMRbpE8ShD8tpXvY9tciY0vD/oqUq99xeCRdlt81oOT8xLMtrGaqq
 Js0FtLX1C9HBZP8PqoPqDPiW6dpXeqFxMfY5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216957; x=1697821757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syj+BsR++ixbzPvAYQMdf0LELBlAkJyKam00DqVDle8=;
 b=h35mKpn4j9Y9UV1yEafKu7rCQShNBx1OBcqqccffcHQbcudhTf6XwxL6cyMTQV1YkW
 Z+gGgnr3CC0M3fgqXuS2JC5S7ydBwbKsrkJATeb75PrmQ/8ib1klfFGMUplWnBBydHz9
 pvgFOjvQoAoIvdG88xavzfVOuxEA+ILjo6OvhY+i+qBWWRYmBeCcBKASVGDpB7VN/qNT
 21Dl0pe99M/6hE65A5/eJJnl+1mwDe1lhbn3YepzvnLF2V0SqjjbEIDbVjUuZ4hzu9D/
 Pjl3G/UiF1TuNRGbqgvaHiL+oDQEtWZ4uLRb2+VHV2m0uPUZaEzxopBIadprhOLBBPHw
 OcVQ==
X-Gm-Message-State: AOJu0Yz2GAtMsc+axF398riCYZBzTAp2ep3d78W5IR6t/vtGhHkEAq80
 gGypo7Gs7ObjNmc51o5sSL6nrryfC4Qan3MMoqzqXqGAqrtzydaacVzp9g==
X-Google-Smtp-Source: AGHT+IEvFCYPAzin4iHwhYxcxNLOR0E5pv0PSIGaIWHVa0t5nqDPE+qjaWYVHYwDo/ZfdLqE0+GbyAAhCakwQq+gAMc=
X-Received: by 2002:a81:a24a:0:b0:59f:7f8e:dc4a with SMTP id
 z10-20020a81a24a000000b0059f7f8edc4amr30139501ywg.22.1697216956689; Fri, 13
 Oct 2023 10:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230923205017.1754340-1-sjg@chromium.org>
In-Reply-To: <20230923205017.1754340-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 10:09:04 -0700
Message-ID: <CAPnjgZ2pCB4K61tcQ-VZApRgM+w36hjpMt8WpQqp5H0BW-tu0A@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Scan all bootdevs in a boot_targets entry
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Date Huang <tjjh89017@hotmail.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi,

On Sat, 23 Sept 2023 at 13:50, Simon Glass <sjg@chromium.org> wrote:
>
> When the boot_targets environment variable is used with the distro-boot
> scripts, each device is included individually. For example, if there
> are three mmc devices, then we will have something like:
>
>    boot_targets=3D"mmc0 mmc1 mmc2"
>
> In contrast, standard boot supports specifying just the uclass, i.e.:
>
>    boot_targets=3D"mmc"
>
> The intention is that this should scan all MMC devices, but in fact it
> currently only scans the first.
>
> Update the logic to handle this case, without required BOOTSTD_FULL to
> be enabled.
>
> I believe at least three people reported this, but I found two.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Date Huang <tjjh89017@hotmail.com>
> Reported-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> ---
>
>  boot/bootdev-uclass.c |  3 ++-
>  boot/bootflow.c       | 21 +++++++++++++++++++--
>  test/boot/bootdev.c   | 10 ++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)

I'm going to pick this one up. There are no formal tested-by tags but
there are two reports on the mailing list that it fixes the problem.
[1] [2]

Regards,
Simon

[1] https://lore.kernel.org/all/ZSMlNWJ9f7HkoaNg@Dell-Inspiron-15/
[2] https://lore.kernel.org/all/VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1P=
R08MB2847.eurprd08.prod.outlook.com/
