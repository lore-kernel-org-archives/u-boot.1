Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7623BE94605
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 21:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4D383C61;
	Mon,  9 Feb 2026 22:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eu5nCbvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F23A80325; Mon,  9 Feb 2026 22:10:12 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF5A805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 22:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45c89d754dfso1504761b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 13:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770671408; x=1771276208; darn=lists.denx.de;
 h=mutt-pgp:content-disposition:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P819JpTVPxTAW5ZHC8F7RhOKJbC7t+hvpaaCSgxWYOE=;
 b=Eu5nCbvfS+FD7rO88ZmSrrUIb0a+HaxwO63TuTc224FtG78QizV0sJlgNJkDQmwNiy
 DvyauLheupIUEfOOMO3QlPyDy9fiYvELKLYz8Cc/vTjNfi8AxHMnvdTVHjoCHe18Ptjd
 6bqgxEaMQonP0q4NxJcgEMKnuoYamoUlCPUAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770671408; x=1771276208;
 h=mutt-pgp:content-disposition:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P819JpTVPxTAW5ZHC8F7RhOKJbC7t+hvpaaCSgxWYOE=;
 b=PtmnVOqnyABKZ/gli+1xhWQpt0gMBRdnehq7TAb1OTdS9XY1Y4cKwL1YmT3gPJX0ga
 XsldLh79+a5Ka4mSl3RKmAEt33Orf0s8cljhpsXScsslcfwDjrSsec1TiiY32iARwEcY
 89qYM7vYoh7gDLAPZdxRaIWNen2/IZkyYDKj6NBp5/ssQcFDIzXP7grgFEE08GSxDEq5
 37CZT87OVDe29MFuNIrt+rbzeX1eolLfNoWOQJTmxYOLL4HOwBZmEFklqqyLk8iaBswj
 ieHSsy3WQm2qRxGJpVsWK/JiVpxcFajrHoQB2ajsWtV/UenBTlAZwJiIoABcsBGk+2dB
 xdyA==
X-Gm-Message-State: AOJu0YxXBaqwUGiSmhI6zCP9syh+ituShGECvPkOi1HnQZHoRPWpl9tp
 WyO1MEzGAAxGU9W2x5+m9Qy4/+Y3fU3nrVMalGBcXZ477McquvBDQOCw9f3f7RvAQVEA46xNusn
 BiMZ9iqg=
X-Gm-Gg: AZuq6aLPsxSRaXl8te880H/3n3Qoiux7NQxjk8NuPzposVcGOcdDFSyNWWjaZK/cRxK
 m/94QRMivNvxt2ofp0nzSDXmpWF/N21ESRWqW+27C6SwiuR2pXUfpiYyaUcMG+ood7DQHKA1xGp
 VpwZrvkUvGIelwh2W40mPZsPuOLXpGb3wjAHzmaM444tnzM6+8in6A1u3on9g3Gt9iXRpmD4Evn
 Eeg3dKwsFlK6tqWJUmFTbfRAzMgdHoD3NpBnVsQje0DVLw7nipi7XcEuyg3JCu//vZEn8B4/9Dj
 KItm6oBfIYgAVs/cXVL58h4+TrFb18TtaSxyZNhcaY2M4lnKLma7bdd+jC5jqULHMbUwPWlN8O8
 mMCbOTZ9g21FkwYf+TrtMlnt2cFhtIZ4pjxI4YuMetVgJJAEno/Pch0YXshgkVF3qBSrRLgzUtD
 HKl7b0qL3dGcooU6ZK/d8+U6lAKtH6sg9UeXIEy1HYQRVm3LjGBceuEn05WsL3LZc5m4Tdi+uiY
 xonlXjelkkjQtNYsAGwoKj8bbNk6lhDkquiL1ghYdAihcTf5w==
X-Received: by 2002:a05:6808:bd0:b0:45e:a924:7ac1 with SMTP id
 5614622812f47-4635397e0f1mr10469b6e.23.1770671407904; 
 Mon, 09 Feb 2026 13:10:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462feb0d786sm7165186b6e.11.2026.02.09.13.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 13:10:07 -0800 (PST)
Date: Mon, 9 Feb 2026 15:10:05 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04-rc2 released
Message-ID: <20260209211005.GA2426323@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Mutt-PGP: S
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

Hey all,

So it's release day and I have tagged and pushed things out. Many, but
not all, of the device tree alignment issues I mentioned for -rc1 have
been resolved. The appended cases should be solved. The FIT image case
for non-overlays should be solved. The FIT image case of overlays isn't
solved yet. There's now two threads on this, and maybe it's one problem,
or maybe it's two problems, it's too soon to say. But it's being worked
on.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MHYzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/icv-nvmv-dbf
February 10th, 2025. 9am (GMT -06:00)

To join by phone:
https://tel.meet/icv-nvmv-dbf?pin=5493171900556

In terms of a rough changelog:
- Platform updates for Renesas R-Car, many NXP, MediaTek, various TI,
  STM32, m68k, Analog Devices, 
- Subsystem updates for documentation, EFI loader, NAND, networking
  (legacy and lwIP)

I continue to plan to do an rc release every two weeks and the final
release will be 06 April 2026.

Thanks all!

-- 
Tom
