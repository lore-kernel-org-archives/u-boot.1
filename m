Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ABACE7B1E
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378B488CC8;
	Fri,  6 Sep 2024 17:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O1KPn6cn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34A788D02; Fri,  6 Sep 2024 17:02:39 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8215188915
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 17:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c35b545b41so30394506d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725634956; x=1726239756; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCSQSrZbzX6fCDdGRiYiaY0N+jxmw6u2u0MfrWPHEJs=;
 b=O1KPn6cn7JWAdmDDm884Li+2+dNKl2VOTtYM9Ptz3Jgh+2T3sD9Ew16zYlUOoNhmP7
 8pJ9VX8/GhkteS/vlzPBoJjYryXI0Wwcf9vgM+HSlDbDx3twZho4um9pQamWWS6QW0Jj
 8hBUai7BH7trkKjdtmxuH8DQ4EPpibKcsrB8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634956; x=1726239756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCSQSrZbzX6fCDdGRiYiaY0N+jxmw6u2u0MfrWPHEJs=;
 b=UwSaNYXw67pcYaBPOQOyD06ZkeyK4ZawNeGGUqxZDXUAqLhM7ghWuIR/aflK/wH3+H
 cS/n+fsIHwQ0HYFJ/drKLaQ4P9J8Yr4QTLu8oDyiOloeN5RSau6bG+DAoBvhQZH0LYiP
 Lcb8a2tozsVGITWxN44wgWvqpN2qyKDG75jQPB4LwNnRquzjoIGzKjiiJccSAqlcJyf5
 xdi9VTGh6njAB1DTGdjpK5+dY8TD583sE+FhLCgX95/GfOoxbEi7wdIKTJcyXglpVWuD
 4yNUUghZmlBIxcA1+gJ9+6cE8/mEP2zaURlWCbJFkxcoWJ8GSrPZFnTgURShQRAsZYQK
 59TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlU6FGqkeAZ9ye2JwcfspIfPwWYApQW0fgPsRpyPW2yjRoaRs7hdGBTFGChGmjkVnvt7oWi/U=@lists.denx.de
X-Gm-Message-State: AOJu0YyIsAWOALc25DLoJ42R4jBpQ62g12p/PIyqs4N83HRz0jpHFewe
 wOo2r0k1wPTsqu25L/VOIK096FNomhy+lrIM4Gm65XH7YK0xwP+j2pEOxWZtNQy4jEL/9YoyiqD
 zs+sCJuzFYAwJHjVZ4WtPoYf+PR4gnxkKsb1MVQq1l8YZ/z0=
X-Google-Smtp-Source: AGHT+IH3q0yMS3kEwO2BrOGbwv9Sje+CXsPR0/li5WbkbHoKLSbcUEzYek1MHlHlawzYdbrFRFGLT1aEoDKsvtoauRQ=
X-Received: by 2002:a05:6214:3da0:b0:6c3:5454:6e1e with SMTP id
 6a1803df08f44-6c52850f35bmr62498756d6.24.1725634956360; Fri, 06 Sep 2024
 08:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <20240903191422.GM2479150@bill-the-cat>
 <722e2465-bd96-4fe5-a154-d48fbe78a975@linaro.org>
In-Reply-To: <722e2465-bd96-4fe5-a154-d48fbe78a975@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 09:02:25 -0600
Message-ID: <CAFLszTiXkq5=E_O8Y1o3NrAN+Y1ZoDmqrwSP9QwzF3pSoufZKg@mail.gmail.com>
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Caleb,

On Fri, 6 Sept 2024 at 03:31, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 03/09/2024 20:14, Tom Rini wrote:
> > On Sat, Aug 31, 2024 at 05:46:19PM +0100, Caleb Connolly wrote:
> >
> >> When using the FDT command to inspect an arbitrary FDT in memory, it
> >> will always be necessary to explicitly set the FDT address. However it
> >> is also quite likely that the command is being used to inspect U-Boot's
> >> own FDT. Simplify that common workflow of running "fdt addr -c" to get
> >> the control address and set it by just making $fdtcontroladdr the
> >> default FDT if there isn't one.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   cmd/fdt.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/cmd/fdt.c b/cmd/fdt.c
> >> index d16b141ce32d..8909706e2483 100644
> >> --- a/cmd/fdt.c
> >> +++ b/cmd/fdt.c
> >> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >>
> >>              return CMD_RET_SUCCESS;
> >>      }
> >>
> >> +    /* Try using U-Boot's FDT by default */
> >> +    if (!working_fdt) {
> >> +            struct fdt_header *addr;
> >> +
> >> +            addr = (void *)env_get_hex("fdtcontroladdr", 0);
> >> +            if (addr && fdt_check_header(&addr))
> >> +                    set_working_fdt_addr((phys_addr_t)addr);
> >> +    }
> >> +
> >>      if (!working_fdt) {
> >>              puts("No FDT memory address configured. Please configure\n"
> >>                   "the FDT address via \"fdt addr <address>\" command.\n"
> >>                   "Aborting!\n");
> >
> > Setting aside the behavior change (which I am thinking about), this
> > makes the next check of !working_fdt dead code which should be removed.
>
> I wasn't sure if we could safely assume that fdtcontroladdr always
> points to a valid FDT, if that's true then yes this can be dropped.

$ ./tools/qconfig.py -f ~OF_CONTROL
11 matches
integratorap_cm720t integratorap_cm920t integratorap_cm926ejs
integratorap_cm946es integratorcp_cm1136 integratorcp_cm920t
integratorcp_cm926ejs integratorcp_cm946es mx6memcal work_92105 xtfpga

So yes, there are boards where it would not be set.

Regards,
Simon
