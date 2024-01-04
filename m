Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B7C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C221287A1A;
	Thu,  4 Jan 2024 16:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZ7HrYL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C8A879D3; Thu,  4 Jan 2024 16:14:35 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45B38787B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d4ab4e65aeso10796385ad.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704381270; x=1704986070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NsdSxCiejaDpTY+yb3lYxuo9sbTez++MQ9TzLX5sCzc=;
 b=dZ7HrYL57bzBs1xDgayOVkOkS/3ajrqipfO34CRgtM0nabWe58SOGx/yKpNKFOCo+7
 VfYeA9Rnl2S12V1DopkvPbbKD3WswWvgjcbb7PvZTwHAikAm3arz7qnMAOqOJIfNsbNG
 8QA8BmsPBQIHCmFm4XND2SERhlYtmYyHfTNndORY0w+eETCNRTbHfOqZSP8jBqk+r26e
 YrZgGgWqpo6JT2G7PS4J5BrbnPlUE9wRiptruL1/lPABTRTBn9VxrmPapl66Yz7oAZs/
 edbPduETDmV1qqC6qaBEzKC1/bJq29DUuuHKa6PHTzGom9ucoN0BkxtmNBJE3S4KdXhH
 wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381270; x=1704986070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsdSxCiejaDpTY+yb3lYxuo9sbTez++MQ9TzLX5sCzc=;
 b=fHWWQIXcK1IABNruSztijurRmafCq0tBkBbjNZQxSKGQlLT4ZwJgdZAESpExfsrE48
 69otr23PAuuhTfBEhR7u8U9IVD3fAhd6Zig/I9U+FcdXvbrgupckjkhXWYkqxM7Qq8Jy
 wJ1QWTojmXsyTnvSBHAmefPgUcVRI/P3jEaRCSlcM4GI9zcxgBWVHOtB9cQSrs+//awe
 XC+huJgMsOPB0V5nAh8OI8x3sTG9YC8lTX0NOupQSMgsWNXFPQTMIOMZCoZbVuwM811l
 w6SHfljYXASYbHoB+7co2R5M6Dgtm9zeOZxC16+LHEQfmACrNSuzLAsPDuPxkzKZkBbT
 JPCg==
X-Gm-Message-State: AOJu0Yx0ogJqHezAY3BDiPO0tPcd45TiU+VUmIm1jLZZO5iT00KXC2ze
 qnaySCPOKPSGDV9na8byPlzoRt/UvQruIAZ++Mwrec1f7kd9HQ==
X-Google-Smtp-Source: AGHT+IFuTkbjUvsOsOk+xGg3V8Z6amqbNNMtVFtGe3pi9Ix/vUY/4zOLw4ylsLAScecySaCKAR8475/ljALwWOZ4oiI=
X-Received: by 2002:a17:90a:5991:b0:28c:d39a:f10e with SMTP id
 l17-20020a17090a599100b0028cd39af10emr784191pji.11.1704381269881; Thu, 04 Jan
 2024 07:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-5-raymond.mao@linaro.org>
 <20240103190854.GN1610741@bill-the-cat>
In-Reply-To: <20240103190854.GN1610741@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 4 Jan 2024 10:14:18 -0500
Message-ID: <CAEfUkULEcgjco=T0SDwyu25LdwGXK7rNaueND7T+6KKkCvrHvA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] arm: armv7: save boot arguments
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 3 Jan 2024 at 14:08, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jan 02, 2024 at 02:12:29PM -0800, Raymond Mao wrote:
>
> > Save boot arguments r[0-3] into an array for handover of bloblist from
> > previous boot stage.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> > Changes in v3
> > - Swap value of r0 with r2.
> > Changes in v4
> > - Fix a bug when saving the boot args.
> >
> >  arch/arm/cpu/armv7/start.S | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
>
> So on platforms with SAVE_PREV_BL_INITRAMFS_START_ADDR /
> SAVE_PREV_BL_FDT_ADDR we have this same logic, but in C, and it's
> working and fine, given what we do. So could we not follow the example
> of arch/arm/lib/save_prev_bl_data.c and have
> arch/arm/lib/bloblist.c and have just one implementation for arm32/64?
>
> I went through arch/arm/lib/save_prev_bl_data.c, it looks that this patch
is more
straightforward and clean for working together with arch/arm/lib/bloblist.c
to support
arm FW Handoff spec.

[...]

Thanks and regards,
Raymond
