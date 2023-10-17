Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1093CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 21:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B681E86F51;
	Tue, 17 Oct 2023 23:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6w0t6Rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AD886F54; Tue, 17 Oct 2023 23:00:27 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1564B86EE0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minecraft2048@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso54825991fa.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697576423; x=1698181223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fuVMn98iKp53vXbVj3IASYsK5qhOR2w16K/X8r1Ry38=;
 b=P6w0t6RtrmC4UIV4Px1zod0VC4knNferzyVJ9kzvq7s4oo9nxN32EG8ks2keBJhMQb
 VnCgIPwUnA3t9pAi9EXD/s6qPg9+SQfP4R535n00TKoNQkHNW2/+GxDfTzVWHJPaeXNd
 7edkmQNMcAatMOsRCn2H9qKgcvGOaTI2kJaVdOfXChaCI1tp4L9LzmpOQrLFLabSTp4R
 WybuosLQx/cjZP5zsVXTf9/3Cn92t2fUSWAKwRBb45+IaDin8q3mC5/dxcOrxaw6CNYZ
 dhaUxc221WLwTATu3XXqYu99o+XoryGp4BFfibAUZZJ1u4NppZ39ub/IxIcgm6ROGjSs
 /1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697576423; x=1698181223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuVMn98iKp53vXbVj3IASYsK5qhOR2w16K/X8r1Ry38=;
 b=W194OQyxk2n1JrlpSYKhyPUFs8Z6wRPKw0pfpQaM7WPLAWla817BcQm3JiFIFVpBjR
 8RHwWlx1ZL2mStNXUL2S11tumi5F9CxXsXK8q1+kf+v4nK5+tWJ6T1sw6AuYrphhBtn1
 mCeIjYQOhZzDaYKJo7IMj1WOMDIpsL/MXRMNRKbXv84LqqOoW1BNJWUdwRaIT0QBQMmO
 XErsCejoU7LvcABPgRFeTsQ8WSVhTACnLMy6TwCR9JzE2LQSy2w3QUrBcAi/Yj7VW3kF
 vtzfE6KOn02MOp6dp9KbkegEPdt694RFEqSG/DMmuhYX8XS6GEXG7v84KzzLwcI7NN2H
 8PHg==
X-Gm-Message-State: AOJu0YxEz9NKAmABP4lZV74kLm87QfgH06IFIRo7R6GhxJlQHNNVPWly
 8wEC6vhlZnDQKaRKWS/u3mIN1VuUQQerc/2TdDM=
X-Google-Smtp-Source: AGHT+IHKCVKImY4UsbX2W34nkTcxNCLrGW1JRkf1su71UCq/ZmqxgCNqedQfk6/hjhpQffv/ko2Ihu4Jv6wS9Izr8Xs=
X-Received: by 2002:a19:7616:0:b0:503:17fd:76bb with SMTP id
 c22-20020a197616000000b0050317fd76bbmr2631084lff.39.1697576422799; Tue, 17
 Oct 2023 14:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ1CVWj3zLjK=tJr=T73JzOyNbJgMjrPdchsxVk0bMsAPQ7d8w@mail.gmail.com>
 <20231017081731.2u7qdmvj4a6bd724@GBR-5CG2373LKG.adwin.renesas.com>
In-Reply-To: <20231017081731.2u7qdmvj4a6bd724@GBR-5CG2373LKG.adwin.renesas.com>
From: Ignatius Rivaldi <minecraft2048@gmail.com>
Date: Wed, 18 Oct 2023 08:00:10 +1100
Message-ID: <CAJ1CVWhb9ZNd_hpmcogDXhzAFYw7BJrW01uSwrp=ys8FhvwLhg@mail.gmail.com>
Subject: Re: Understanding how .config for uboot is generated in buildroot
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, xdrudis@tinet.cat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, Oct 17, 2023 at 7:17=E2=80=AFPM Paul Barker <paul.barker.ct@bp.rene=
sas.com>
wrote:

> On Tue, Oct 17, 2023 at 04:35:20PM +1100, Ignatius Rivaldi wrote:
> > Hi all,
> >
> > When I edit the config file in BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE in a
> > buildroot recipe, how does the config statements from that file got
> > converted into .config file in u-boot?
> >
> > The background is that we're using a custom buildroot config file at
> here:
> > https://github.com/kubos/kubos-linux-build/tree/master to build u-boot
> for
> > a space grade computer. When I added a new config statement
> > (CONFIG_SD_SWITCH=3Dy) in the BR2_TARGET_UBOOT_CUSTOM_CONFIG_FILE, it
> doesn't
> > write the config statement to the .config file in the uboot build repo.
> >
> >  Unfortunately the company that owns that has been acquired several tim=
es
> > and all the engineers there already left, so I can't just ask them
>
> You're probably better off asking this on the buildroot mailing list.
> See https://lists.buildroot.org/mailman/listinfo/buildroot.
>
> Best regards,
> Paul
>

Thanks for the pointer, I kind of solved this by adding CONFIG_SD_SWITCH to
uboot kconfig definition file, and now when I added CONFIG_SD_SWITCH to the
_config file it works.
I'll ask about buildroot stuff on the buildroot mailing list after this.

The next problem is that the way Kubos implemented SD card slot switching
is by calling into their own proprietary(?) binary blob through the
standalone application thing:
https://www.emblogic.com/blog/12/u-boot-standalone-applications/. What
happens now is that Uboot is stuck at ## Starting application at
0=C3=9721800000. What are the possible causes of this, and how do I start
debugging this?

Fortunately Kubos gave us the source code for that binary blob before they
go bankrupt, so we can tweak it
