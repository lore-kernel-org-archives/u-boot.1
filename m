Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7BDE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941238056E;
	Sat,  4 Jan 2025 20:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVg7yQON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 520C480578; Sat,  4 Jan 2025 20:40:44 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425FF8043F
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so19381116a12.1
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019642; x=1736624442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xsqomLTMhwT8V65JvIa6vr+7vmk9/5F3C615RRX9YE8=;
 b=DVg7yQON/u2R/eqFCVh9hWaVTycVZFhgufRD8xqXCqvBbx562W2rnGWNrmTKfb+tbN
 1dbNzzKMCRXLEayUiO37047sg6bGxrc5pfj/zXVNzoNjzPFeBHizNCteAOsGfZq+Fl3t
 9Oh+j8JKnx+PP3IZnoq0Dx6Y60Sqf5DZ1mcNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019642; x=1736624442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xsqomLTMhwT8V65JvIa6vr+7vmk9/5F3C615RRX9YE8=;
 b=w3UU4bz9Nxsqc5T64tLq/fpw9EWT5VexB4LfDP0wNAcCP3mdr75dbgJ6R2/A/eSDEp
 7cGhYlsuQI+ySNfXKNFixNgIasjoSRq6MCjdyr/XPQmUjbAObN3RgFziTB+Aibontcpa
 /XpSqPzO/x8ZnNjn1H4KnmNxTbX5iieJgcgElhxX/VfX04GcIjfnlZ+LM7B/GCMzaMsv
 OtMt0p7wI+gJciKfIQF2D4/0yYCMTfbK6eOdQ3Sj37CD+YcBoDUC3kakdarOKJSM5q5u
 MKRIs8ZYkcrl5GNyLMzaQu2PeJs5YGVlLhwhIPqwcXcYN4qbPwq1BbiznlpBdYh+Zq6+
 Kmcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2tJIHhHchdcRIUgnnDlHZOXjHJJxadrlVFgWkBBZSIkkO+jKkmhJK5ghnmDjDYRQO4uD+ykw=@lists.denx.de
X-Gm-Message-State: AOJu0YwDIhsUJ0QRdSr2X7TYLQ1B/C+fQbrr92jfnhacUtjmlza3L77j
 MKcWAwEUrV4Zps6v1gHlYZedc8JF57nGK8e2UYbNeAEL4bJ9ljHrKJxe2/95CMTfM6SAXJ+IWrp
 mHDiiK/NEv2V4cBy3om9g+BKsBmL8j3tyVCaL
X-Gm-Gg: ASbGncsrXliid0CLb+kyhfxgH5zpWZsxMh1AvOrMOrbryWU7Bxe7RpaNnRLB7pvIqpr
 L/RY5u3nWuq63xnfN8p19SYcFQHeHkvww0Q2F2r99
X-Google-Smtp-Source: AGHT+IF+oxlvxygRSJhpqsOcwdhtMV/sCStBO15PARqvnSiP+H8yK4sI69MLEFr6BiCn0S2436MmFH9Hk7t4LDnGSvw=
X-Received: by 2002:a05:6402:2150:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5d90ae58333mr15723937a12.20.1736019641596; Sat, 04 Jan 2025
 11:40:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1735896540.git.jerome.forissier@linaro.org>
 <c86ca0914ab1496a7f63371e47f36f2109d7d97a.1735896540.git.jerome.forissier@linaro.org>
 <b77c543c-56e1-42e7-a0ab-874921049873@linaro.org>
In-Reply-To: <b77c543c-56e1-42e7-a0ab-874921049873@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:40:34 +1300
Message-ID: <CAFLszTh8shuz2B3s5sQPRpz5_an_EuQL3+OD3OuZHQOAuju-LQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] board_init_r(): use static calls
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Sat, 4 Jan 2025 at 14:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Jerome,
>
> On 03/01/2025 12:13, Jerome Forissier wrote:
> > Replace the init_sequence_r function array by direct calls.
> > bloat-o-meter stats before/after on u-boot.bin for configuration
> > xilinx_zynqmp_kria_defconfig are the following:
> >
> > - With LTO:
> > add/remove: 87/128 grow/shrink: 8/23 up/down: 19743/-20923 (-1180)
> > Total: Before=1067882, After=1066702, chg -0.11%
> >
> > - Without LTO:
> > add/remove: 0/23 grow/shrink: 2/0 up/down: 795/-1112 (-317)
> > Total: Before=1119494, After=1119177, chg -0.03%
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
>
> [...]
>
> > +     INITCALL(stdio_add_devices);
> > +     INITCALL(jumptable_init);
> > +     CONFIG_IS_ENABLED(API, (INITCALL(api_init);))
> > +     INITCALL(console_init_r);       /* fully init console as a device */
> > +     CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE,
> > +                       (INITCALL(console_announce_r);
> > +                        INITCALL(show_board_info);))
>
> Not that the array was extremely readable, but I think this is
> significantly worse. Particularly as my IDE will no longer grey-out
> sections for config options which are disabled.
>
> I would honestly rather still see pre-processor #if's here, or at least
> something better than this semicolon-in-macro stuff.

Hmmm I think you have a point.

I was actually thinking about having something like

   INIT_CALL_CONFIG(DISPLAY_BOARD_INFO_LATE, console_announce_r)

i.e. a macro to combine the two things and the semicolon.  But I
decided it is really no better than this patch so didn't mention it.

So another option would be to keep the #ifs as you say, with
everything else about this patch left alone. I have the same issue
with the IDE (I suspect some clever integration could be written to
fix it). But I have changed my mind and think #ifs are better, in this
case.

Regards,
Simon
