Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA2FC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB0988476;
	Thu,  6 Jun 2024 14:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGcuw2BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E3487DEA; Thu,  6 Jun 2024 11:52:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9873A878E2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42121d27861so8767655e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717667541; x=1718272341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PaAipwo2IZqNMY2sdh8fDxxF4KHhOsbiYvRqbkKh0QU=;
 b=lGcuw2BJacr9evTZXIy25aLcBKyecJ2e4amVrF/3jWtBPT/Kxi2a232FAJi8zmlo7a
 50c4VXf7WmE8UOyjPhIAke7gYcdfIfaFRTr1I3w6QXZpR5a7A88hEyvYulbfCIYRENR5
 n8PUiFeYc54EeDJyhUtfumtTFNNUK8pNrB1+grNHSTQEabt3i9RcZFM3bWxEYngImMES
 BZN68Ex19ymA98uqPWUgL78VDChauniDpNAbjjjdNkS+73qEpcnvbcfn0ObtYfUkYw1H
 5dyAbTRktslXpdZHlhx5ugu0bSLm5TCX5MYZ7audAGb8nww2RwcoSpAgyMqopEzXo18e
 jOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667541; x=1718272341;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaAipwo2IZqNMY2sdh8fDxxF4KHhOsbiYvRqbkKh0QU=;
 b=Ihc2+rON6mwUoMWpQ5475kUVLaQ7cQ35I/iXN4gRQSr9EJWf6V0Hhf0xWBeJ3qxpD3
 l0bOe0wA/6ZrIl9i2iUrY2oK8DlQ1RWIWgqmmKDNgByTWfdwdK4cXnUWi2v0ApRIQcwH
 vcCflHRdlgZdr2GTElcgklCACKrCLVuR6/zJefRRfY2UZJxvcZtk/3hX5yfQAzQllZSA
 LCuKxj3UEwIHUgyu9eR219InL+Dup3gxp0OFNagVMdliC/nAYv4qG0MbGZReDmY0Cv3d
 GuuqKRAHkxbfbdPH5tyDZ4Yud7HIXiapf/Z0C0N2dt5Wzpq+IZkQSZpmtIcHFavGxzLm
 LiAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvsfxe9M0BRjJjy++bHNvdsNQSCP9SfsyGaWDaFqz7Qq+TD3f2TIwq+C7ckmdeLl/Bq653CzEFwPJ/h7agJN/sLs2hg==
X-Gm-Message-State: AOJu0YwXVA6NIYj1Nq/uGQuMQmdSGLIwSsqM+c0LDZbEv7iSytKpFVR/
 N/MFwDLj0wW/G/E7ipVmr+zDvXCRSzLyuxRxyKOGQ1BiYwSwkJdK
X-Google-Smtp-Source: AGHT+IFNJGY/KyR3lMgXQ2GITXijqbgSMscxB+8/3EVN8RCO7CQsDLy4X3PTIUxBxnSXvel90Vj4gg==
X-Received: by 2002:a05:600c:4fc5:b0:421:3c3a:e828 with SMTP id
 5b1f17b1804b1-42158111611mr35012105e9.17.1717667540617; 
 Thu, 06 Jun 2024 02:52:20 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102a69sm50328415e9.15.2024.06.06.02.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:52:20 -0700 (PDT)
Message-ID: <666186d4.050a0220.fbb8b.00ff@mx.google.com>
X-Google-Original-Message-ID: <ZmGGzyYAOu_-FhoD@Ansuel-XPS.>
Date: Thu, 6 Jun 2024 11:52:15 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/7] misc: introduce STATUS LED activity function
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d02b8a-dee1-42db-a804-d065517391aa@cherry.de>
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

On Thu, Jun 06, 2024 at 11:12:11AM +0200, Quentin Schulz wrote:
> Hi Christian,
> 
> On 6/5/24 9:21 PM, Christian Marangi wrote:
> > This series expand the STATUS LED framework with a new color
> > and a big new feature. One thing that many device need is a way
> > to communicate to the user that the device is actually doing
> > something.
> > 
> > This is especially useful for recovery steps where an
> > user (for example) insert an USB drive, keep a button pressed
> > and the device autorecover.
> > 
> > There is currently no way to signal the user externally that
> > the bootloader is processing/recoverying aside from setting
> > a LED on.
> > 
> > A solid LED on is not enough and won't actually signal any
> > kind of progress.
> > Solution is the good old blinking LED but uboot doesn't
> > suggest (and support) interrupts and almost all the LED
> > are usually GPIO LED that doesn't support HW blink.
> > 
> 
> I haven't used it yet but we do have a cyclic framework now for things
> happening in the background. I think this is a good use-case for this
> framework? Something would set the blinking frequency (could be from CLI
> directly, or as part of board files, or architecture, etc...) and the LED
> would just blink then. This would allow to highlight stages in the boot
> process, though that is not like an activity LED so if you're stuck in a
> stage, you wouldn't know if something is still happening or if you're really
> stuck (e.g. no packet on TFTP or TFTP very slow). The benefit is that it
> would be way less intrusive than patching all commands that could make use
> of that LED. Right now, this only adds support to MTD, SPI and TFTP, but
> what about MMC, NVMe, USB, other net stuff (e.g. wget), etc...
>

Can you hint me on where is this framework? Checking the tftp code i
couldn't find extra call to it. Maybe it's attached to the schedule()
function?

Also notice that it's really not a one setting since almost all device
have GPIO LEDs and doesn't have a way to support HW Blink so the
"activity" function needs to be called multiple time to increase the
counter and toggle the LED.

Also this have the extra feature that you can check if something gets
stuck in the process. The lifecycle is:
- Turn on the ACTIVITY LED at the start of the thing
- Blink once in a while (for very little task this might not happen)
- Turn off the ACTIVITY LED at the end of the thing

Soo if something goes wrong the LED would never turn OFF but would stay
solid ON.

More than happy to rework this to a less intrusive implementation.

Maybe this can be generalized to some generic API like task_start(),
task_processing() and task_end()? Might make more sense than having to
add specific LED function to each function?

(AFAIK linux kernel have something similar used for all the trace
framework so having something in uboot to trace these kind of operation
might be interesting)

-- 
	Ansuel
