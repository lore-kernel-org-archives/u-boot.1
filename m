Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E87CFC29F
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 19:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F51583A9F;
	Fri, 21 Nov 2025 20:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="afCedQEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D2283AA0; Fri, 21 Nov 2025 20:09:45 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA92083A41
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6419e6dab7fso3403493a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763752183; x=1764356983; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xmn4wFJW7qwmH1/hjjtxtVNoH5rilU/xRTzSW4kow0M=;
 b=afCedQEVLo1dcVhc+CKNKBBRQ+oXzSdZtfavpu217YpRU7/y7JPNNXvfvA80yp0Roy
 9ZnBo6YrEGkBjH1jlnRIoCZ5QljIQQ+KUL9/DorADKnC05EUQIROxAelhHDh3oE3M4C3
 Tap1NohslA5AgYwv/Wi2dBqLhiFKaFSx5dwTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763752183; x=1764356983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmn4wFJW7qwmH1/hjjtxtVNoH5rilU/xRTzSW4kow0M=;
 b=Jo06SLty+Kk1PkdauqxLb7z0t1nGh5bkWUQIB3zyK5KzlTWvybO7Q1vZYb4tObXdZa
 5IMJMAkV09Yjc3fubA48lkK3SUzoEbQRpfmJ7O900cpyHdIJP2HG8pVowLs8QKzFEz1F
 83NlKW8hwS7BjPRY2ilA/QE/fFsiLGdFmi2nHlW8gX88j4GuPGHuZaLe7nMVNXCqytRJ
 QUri8twnXJI1I30+32a/g5m3m+cswXqfaSoJKxMg2pzKspSmrKoFPWY7w0HHXOwny8+S
 tzdLlxEcD0obZcig88vVF5+ANtonWv2DATp74rai2Xnz638ksSV9GKLwhLXXe0yOgIpS
 Qdjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVUnw9YHsPIyyt2KpfPZ8kzXRIlXxCoVkjKzWKeUPOpS6vW3VRTMyebpQXeQIwdm1+pvTUbxM=@lists.denx.de
X-Gm-Message-State: AOJu0YzYz+UjhUZE2ZmOulp6UR4zwHFmIYUqFxrROf1o/OYo8yvFZEPi
 gOQ+8oRmGbLdOBOFsUn2eTwbkPm6gEDSMy5w4SlSk2VUu/dxVhoznMq29cWjUHCx0TqwWoKWRo7
 /wmTMb9GgBatt+rSsMQTyPUQNnHVVCXK12/AGkzrS
X-Gm-Gg: ASbGncvqJDc66xRrQey1zx92ys22MP51qSlSchOgSiQd7Zgc2z8qK0GqJZRSK5Co/us
 FjLZT5okkqLO2mOa0CCEXNl2EyGu3NaFOkky23czpH5ydv8SKrj9wGPULll7Wd6DKwQdGxQ2X3Q
 N5RkEHK3pIeQBQEpyeoTtg2ibgoFkY47AUtlgmmjNXwo22FCRWjx2kj1x21eaxfyc/nm294PYD/
 wb3+i+Kj1Rfj5Fujw2/ZCtMvUxPA6jiJ7P38ae1gNOK4uI4pUT1hQmZzseHRSgjdkEQFg==
X-Google-Smtp-Source: AGHT+IGBeD4DWyw8k/MPre/CFedXLe3Mf84VbzWm+/h5f7USzyTVAl7WBqfowEdpuxDe+4kTD1Hvq3u27CuHKw0av+Q=
X-Received: by 2002:a17:907:3f1e:b0:b73:6e0d:4f6b with SMTP id
 a640c23a62f3a-b76716d9e95mr394989966b.36.1763752183197; Fri, 21 Nov 2025
 11:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
 <20251121143510.GX2125796@bill-the-cat>
 <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
 <36b44a71-e98d-4b89-b639-cb1e31f41865@mailbox.org>
In-Reply-To: <36b44a71-e98d-4b89-b639-cb1e31f41865@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 12:09:31 -0700
X-Gm-Features: AWmQ_bn8ZPVL-kffBQtiN6B6C1vAPfDqu8-7uJ1JJ70zsTPszkJl16bULNhxETw
Message-ID: <CAFLszTj_RJuGXriRMpEnf3ZM8Jd4zmSB87KiTdk7umjzfcw4Og@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
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

Hi Marek,

On Fri, 21 Nov 2025 at 10:53, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 6:35 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> To be made to clk_fixed_rate_ofdata_to_plat_(...) in
> >> drivers/clk/clk_fixed_rate.c as it does not currently call
> >> dev_has_ofnode(dev).
> >
> > Ah OK. So the call stack is something like:
> >
> > dev_read_u32_default()
> > dev_ofnode() - returns ofnode_null
> > ofnode_read_u32_default()
> > ofnode_read_u32_index
> > fdt_getprop(NULL, -1, ...)   // guess
> >
> > And I see that I put assert() in some of the ofnode_read..() functions
> > because I don't have tests for passing an invalid ofnode.
> >
> > So perhaps fdt_offset_ptr_() should check for NULL and return? I
> > haven't traced it though.
>
> In previous patch
>
> [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value unconditionally
>
> that approach seems to have been rejected, and these dev_read_*() fixes
> were implemented as a replacement.

I don't think it was rejected...but I think the commit message should
better explain the problem, e.g. using some of the info above.

The only choice is whether to add the check unconditionally (which I
think is fine for now) or to add a new type of assumption.

Regards,
Simon
