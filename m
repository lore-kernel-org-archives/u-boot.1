Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10852FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9557284874;
	Wed, 29 Apr 2026 16:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oItxzd4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4670F8487C; Wed, 29 Apr 2026 16:18:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE53784869
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso676033a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472309; cv=none;
 d=google.com; s=arc-20240605;
 b=IVVfOM34tw2/SeNd9Y1ow/pogiSDdDxB/neH9B+X3IuD0ih8MA9vidudwKJV3MiykO
 t90Du03gOnJ5HeI+8iCPU1SVOKQJ1UyCJBSB6pm1A/tpMafE0MKSjNWX4q8aIdo42xN4
 SwEzKsUF75+BCxQ7zjgtTh5zF4bmqBDsq5nOdngHRkE4wTj/BpEOH0OeCTUohVIOT32n
 HQOcAMgbi9G3SVguuKKWxL0FEjh9g+QUqheN8a4qcSJA0JQVpLTT9ry5ubmCMsUtVCCs
 iLTpw0YON/hOY56kD/ItimB9Q1youuVP/y+CrCrBuCI+gRL2yi51lbHlG8GWfH9A92Ha
 4/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8qG+pQdS5HNHUL22qTDQ4T13L4fRqlqlAeNTu6QcxOc=;
 fh=svZgl15q5OtEe2wktK+LWJIgZCf65obVTtlH38DM9o8=;
 b=EfKsqsOm3YjmyCwuFoX9dlJ3xcxRtPf6vjbhhZraY69r24tmYRk5nq7bi6CQReeX/O
 N58pkiutTAOlSCUlIqsi32GM0BjMEfRLC+QnhzMwI67yQFIJSfyd/Yhnh3f33gpJ+0KH
 8+xtYNWIEY+ytKtAJutSXINueNIm/2W9dkTFu7olSSEGkxesJt6VJSf9XPSzOTyhEDUs
 KmCRBleL0dEGO865Z3uhzaTDGu1zL9TNetiVOEVSeMd5kOvI2I0f1MjkovhVnUe5hlV7
 hti4Yo7d6mf0wtdJ0rHmS4rgzzC4vME0RtcQ8yfo+dTU6SZm/MLoEWQRyg67rs2VKOHx
 sZ4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472309; x=1778077109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8qG+pQdS5HNHUL22qTDQ4T13L4fRqlqlAeNTu6QcxOc=;
 b=oItxzd4JxXJamkBeUNZIy8VUeOm5xaaPpr7gjAUL044TW2usXdhZ2H7nUOGZakg5bX
 5YLorqc1NmkCchD0PJR2A/IeNspUXXp8SYZzcegXbDzf1mfUYLUH1NjrnYVubDgNFZhG
 XdknP6z+T1V4vBz+vxuWHTtLziPm5SRffpD0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472309; x=1778077109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qG+pQdS5HNHUL22qTDQ4T13L4fRqlqlAeNTu6QcxOc=;
 b=KZy581Exl7FZkgTxUMggZDuPcSIQz6vYUuKEuZE5O4c5GaZAhwrRuQBhJuOyEobYtB
 8UE3uyUCu7V3xwUcNEvJfByM9uqXTUy+v6aBw7GfSYqH281P5WqdcLnMtUkjqPGbqotl
 1FUSPNv6qLakaiBjpZrh4EMj4wNd9of9Tdg+MTkOTvCMGZwcyoxqGOHTcX/ThwHcJstR
 bJpYRLIYTZ+pp91FZ5kV8Bs9dpJG8vIPTpX9T+uhNNEfr9g0MF/Yy755hY2hrfl+m9Cv
 cgF7PniMV87+1e2sdkoHDOKFOVVQhC3cHRuQIWx7t9c+3dMstw6UlR+GbZcP5dVRk2zR
 YNFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+PYBmDuCwfT9wlafHDR5dsBJ3JdpgXFw42FbYm2tMi8KfRowZHnH1kmbErbDEs4/RyZJIHRg=@lists.denx.de
X-Gm-Message-State: AOJu0YwYzFgepI128+i++/gxp4jzUWv81O3HpSmbvfiQgjXR4UkYtI01
 VjaAWFdB/Rth4xdKJlUXrnCPWApGpdLmXDcips1t6qzdzLDX5m3NAO7GTCMK6ajquPlOzlD6H3j
 AB+TPBz+ogtbpdPefb4EQAWwOa+9CAO6K7dKYSIc3
X-Gm-Gg: AeBDietqM/nuQptDTL8jxPKsyF5Tlsjq0pVh5e33GevS+MvHR8Z5iu3m2y1m5VytC0M
 73zyCr2bWVBbb7apXeJztshoicFFRYuSoG/k+tw6qSuZ66u0evQ24UPZjSsZ9jgSbCknVgnG+It
 8iYVlksoovUx/nuCLf7ekwJjvoMAInWg9w8Lislf5WYynFTc4q72skKy0zevZ+3Tkbspj0h+BG1
 YCA94rTSbYKSVxzkYsxZJW9WEcmVGZd9xeLxd64eOJbcrcmCG+c9/wl4SP/RjygJJh38tYdXdL+
 PyErg8ylZiECDIzK
X-Received: by 2002:a17:906:9fc4:b0:ba6:79c0:c743 with SMTP id
 a640c23a62f3a-bb9582bbb5cmr203832266b.11.1777472309207; Wed, 29 Apr 2026
 07:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
In-Reply-To: <20260427144630.GG41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:18:14 -0600
X-Gm-Features: AVHnY4JT4H0s5V-8J1ZdxCdyqET2iXMiS1VheB2gathVEOq0f_K4Bm9aoNAZqHg
Message-ID: <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
Subject: Re: Couple of clang warnings for Rockchip boards
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

Hi Tom,

On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 4/22/26 11:57 PM, Simon Glass wrote:
> > > > Hi Quentin,
> > > >
> > > > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>
> > > >> Hi all,
> > > >>
> > > >> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> > > >> First, let me know if this is a bad idea :)
> > > >
> > > > I don't like it, as it makes development slower. I like to see all the
> > > > warnings created by a change and tend to fix them iteratively. We
> > > > already have a warning check in CI. A better approach is to
> > > >
> > > > Can you use: KCFLAGS=-Werror
> > > >
> > > > either in your environment or on the 'make' cmdline?
> > > >
> > >
> > > Well, if it's during development, you can always disable WERROR? The
> > > fact that I've never actually enabled -Werror locally in about a decade
> > > in U-Boot probably isn't a good sign. One of the things that make me
> > > wary though is compiler updates with new warnings. I've tested with
> > > clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> > > about to be released as well.
> > >
> > > By having the check in CI, we have a longer-than-necessary feedback loop
> > > for contributors. Has this been an issue in the past? /me shrugs
> >
> > This is strange though, because people should see the warnings during
> > development. I wonder if it is scrolling off the screen.
> >
> > One my bugbears is non-actionable output. When the build succeeds
> > (with no warnings) I see no output, using 'buildman -I --board xxx -w
> > -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> > -s' under the hood, so that it doesn't print a huge list of filenames,
> > etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> > check everything is clean ('buildman -m' does something similar).
> >
> > Note that buildman returns exit code 101 if there are any warnings, so
> > the build basically fails.
> >
> > >
> > > No defconfig seems to be setting this option, not sure exactly why that is.
> >
> > To me this is a difference between 'functionality' options and
> > development options. Putting development options in Kconfig makes it
> > harder to turn them on and off, since you must either edit the
> > defconfig or edit the .config file. It is easier to just pass an
> > environment variable.
>
> The point of a configuration is that it configures the build. Stuff in
> environment (directly or make FOO=bar) is a workaround and anti-pattern.
> Having to run one of the config front-end to change the config is a
> feature, and good thing.

To give an example, we have boards which enable LTO, but it is
sometimes useful to disable it during development - it used to be a
huge time sync but something seems to have changed recently, as I
don't see much of a performance gap now. We don't want people
disabling LTO in the defconfig, though. The same applies for things
like V=1

So I think there are build features which are of no use to end-users,
but are helpful for development. That is the distinction we have had
for a while and it would be a shame to lose it.

Regards,
Simon
