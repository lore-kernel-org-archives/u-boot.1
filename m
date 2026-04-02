Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90ED39422
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 13:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD5B84011;
	Thu,  2 Apr 2026 15:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H242wfI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EF0839DF; Thu,  2 Apr 2026 15:37:25 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F2584011
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 15:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso126072666b.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 06:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775137043; cv=none;
 d=google.com; s=arc-20240605;
 b=U1YcFA5EGh3tA8O7Vd4BXvv8REBIRwpqE82eZOVx1CV7s6NBeenACVAvYJn2B+L4Hu
 CX+S60zMBZAhn3ASwUYBWRp6EmoN2/GYd/LYjRxy9VfhTddkz7/UWeyMQlzcI1/LKV2+
 Qc+jqOqN/d3CfC9SfXCGSSPKmyeMxBKEiHv9fsE/zuhdjYot5iENjDBGOJwjFmzxhoCD
 fs9tJ4Dlb0kJu27KcE+fsdGou4CxL4pnJf5mfpgh+j/IRHXC3XXATuA8Hpr+UkepxbcA
 OtKmoT5dZtdqGZlZFlhs0HK1yqqQNEaqIOrSPTa5Tps/fidRpRcx1tTzHmybVRxaTN8o
 dr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sipF2Xns8faJirVqNvRaNVPTQFvyhVN28Rpam8dmrMk=;
 fh=WbrZUk7whje7UjbUyyUBrQjEqBWWfsdTB9ohTXNwJeY=;
 b=SQMhyUVfD93S/JW/mPyEbhzOu9xx/HJzg5vnYp5cGnWQiIa6o/v5xYBAk0TsABVSrm
 QLy2fYIyaiGjMl+nhVfZ3FVJQbseAOMtcJwexKenFzqMm+yZH3CKKD4ILQkaDIBen99L
 7C03B3woOz1PHRz4VM+bIMpllEHMXOnAz6kvULT2nU8zCDHs2PV1YxwzZEJLUBVmV/pd
 qasKd8TeKpyLV0qkLgd3SUbikTZ+JhQh+jPbfXDsNZaMh6gpcgJs5DzB8qAUV69bdpIh
 QniR9uFfTo+xf5zp7s0AqssabrZiSszAvGDHWZat/J74vT7li3yl8tPAYuTclqtxXIfW
 qxYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775137043; x=1775741843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sipF2Xns8faJirVqNvRaNVPTQFvyhVN28Rpam8dmrMk=;
 b=H242wfI2JYLeFfg0JBeV1/9dFC9Mqa1kiagiyREKoUuw8dfMz5KCENpsszGRUOqV68
 BwR26pK0rce0U7mKoscnwbRxurNjBsCguxVsWQ7UCFe+q32+64xzIODDuE9I9Bvc+OnX
 oP+LkPGwhhtwbPWT5FwEDU/KvLO7+d98UeMus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775137043; x=1775741843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sipF2Xns8faJirVqNvRaNVPTQFvyhVN28Rpam8dmrMk=;
 b=YK5GYo8c2fpuZ4yDdB64OsG7iwiMEjDQeeMrFv6U7a2ILx+5iXMgCjAgVXwQ6ac4XM
 ch6yLIKyUHHuUxlSi79NYg+vRf13XGTmokvgGSl2HG+8mSnFuIBo2gxMHA9wMcpmMcAo
 qCwbJhEKLHQXJfEfpFtCdA0y+B0GC4S17mlFc/KtTlXhx+smDVnsZS2ejMghUudkS9Bh
 8t9KcMi4ZZ990lyw4eoPRsq0ds1r4CZ9js1M3ewB064kmZezJHRzRN5Lh5EMdjTi0bmr
 Pn0JYHmCPhg/BA9lfkff8eCaJYv6H3atIAxR81AUBDEASQnoBh/xm0k/utg4FrcWacd4
 CXDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4trMYaaWegBR9YbvSaKp5PrOoqLetcRm54MkZyltE3phdMv58IpkhO3RzMFrfUSKHBv2bGMI=@lists.denx.de
X-Gm-Message-State: AOJu0YxDFGLN5T4YH0oYkPzZ88sC4nrwDxreYYeo5UIcibpl9SMN92N3
 BsigB7KNdrzdIXKzdvh3H04IF/XbEo5kBkxnCDGFzSwTeW+Pngn4hPPK8O3+5MdWGIMxjUjdjG8
 ++Jc8/ST3aJq7dwcI0GjZe86+C+/9zSo3vos0BFEn
X-Gm-Gg: ATEYQzzlZ/dmZc1ya0etDjCnY1TvXUs5CMGadQFjFlZpAXjYoRC8LVNuQ8AK2ZOztIv
 F4CcB/xrPSIzcrNCVA49DLEWxMANBE2HaRhhZsALYp1N4SPjkfEjEJ4fhizZC3MyQISFH5Io80y
 /AsKfP95t9286V8OejlHv6zCVMgl/j7hATyt6E5txjfaxduv3Frm23fvm6+HEdOK+lEU3k6OLYX
 HbxlJXcnM7aPhFGdEdRxVJqtCpkvDyuQP81PFjya6tc4ogp+MgBnZzUyfty6lRMCjDi5q/bw9Yo
 BxiVaA==
X-Received: by 2002:a17:907:3895:b0:b98:13a:c92e with SMTP id
 a640c23a62f3a-b9c1379a41bmr562182966b.2.1775137042534; Thu, 02 Apr 2026
 06:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
 <7d08e7ad-bd02-412a-a3d1-30a5edc27bbe@arm.com>
 <e096202a-17f5-4c0b-919a-45f2d232757b@amd.com>
 <7876118d-d702-4b1a-a289-e230bc47f5e9@arm.com>
In-Reply-To: <7876118d-d702-4b1a-a289-e230bc47f5e9@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 07:37:09 -0600
X-Gm-Features: AQROBzB2S2VsvLtO8iRH-g_3rpxyQu6HJYO2oJv78fSgui07h8YOH1t9asVjm_Q
Message-ID: <CAFLszTgvJOuzhuWwwrAeEvku_96OsjHbF4N5Vj101PTfoGzo7A@mail.gmail.com>
Subject: Re: [PATCH] .mailmap: Fix Jerome's entry
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Heiko Schocher <hs@nabladev.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Linus Walleij <linusw@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 nd@arm.com
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

On Wed, 1 Apr 2026 at 03:26, Jerome Forissier <jerome.forissier@arm.com> wrote:
>
>
>
> On 01/04/2026 09:22, Michal Simek wrote:
> >
> >
> > On 4/1/26 09:20, Jerome Forissier wrote:
> >> Hi Michal,
> >>
> >> On 01/04/2026 08:10, Michal Simek wrote:
> >>> When patman is used email address is composed together with both email
> >>> address from .mailmal file. Having two commit emails is not proper format.
> >>>
> >>> Error:
> >>> error: unable to extract a valid address from: Jerome Forissier
> >>> <jerome.forissier@arm.comjerome@forissier.org>
> >>>
> >>> Fixes: f2566c3a71a5 ("MAINTAINERS: update my email address")
> >>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>> ---
> >>>
> >>>   .mailmap | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/.mailmap b/.mailmap
> >>> index 31d4970fff77..6ac4b9b9e5ef 100644
> >>> --- a/.mailmap
> >>> +++ b/.mailmap
> >>> @@ -69,7 +69,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
> >>>   Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
> >>>   Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
> >>>   Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
> >>> -Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome.forissier@linaro.org>
> >>> +Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> >>> +Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
> >>>   John Linn <john.linn@amd.com> <john.linn@xilinx.com>
> >>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
> >>>   Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
> >>
> >> Thanks for fixing this.
> >
> > Is this any official tag? :-)
>
> Yes it is. Ah, I need more coffee :)
>
> Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks, I hit this too.

Reviewed-by: Simon Glass <sjg@chromium.org>
