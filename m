Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A737D6CFAA
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 00:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3698397D;
	Fri, 23 Jan 2026 01:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVbyeyjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63507839DF; Fri, 23 Jan 2026 01:26:06 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C92838FA
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59de38466c2so948905e87.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 16:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769127964; cv=none;
 d=google.com; s=arc-20240605;
 b=jFoVzrzUPMyw2LZwHsSYOzoOq+3KQPzClke+7NSmNwC5D4jsd6Vi38FhRyXaWjmLMt
 tQERtZdxzldGlWCdlb2YZcF0IKqy2d90SuysxtWXKRcqJZy0ajjLe3aEVZAraWJgURXp
 KnIm+HbVSLbQjiMyGC/zXnalm88/Ez3xNKP8KblC+cWV0m77P/zANb5dj2ciqeft/PkS
 mdgreyKgL76uqCbBWoRf+1ZMq5mqw3+Ca8WqHeoQwCX46ObJpvIKXEswMrno+QgmmUFj
 oc5yHD9uZO1uzO5rqsFwpbM9wLH6+eBuSzhNPl8YnvIObsw1lL3hA6fcbvrqMrvdbJvE
 YiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EcKJPWaRPFXZOxkC1ICydCFVz2mmwHWgZVbW5thL01A=;
 fh=qsYcaLr+fIhxpR23Q3BPvuvwRTGYTS5w53WnZxUxhc0=;
 b=GfRBzjCvbMfRW+XqiS7Rrc9pUMkY/a/0shKF/UGa2hrFv+RUGZ/na0D0xtPMWfRePv
 uVtttHtv5/SJhZEJPDjmmGoed4DxjTbCSc8ipdvETTsy/DLUROxqLd+OA0VVb8MW/2wB
 qOq5T89gxefTt24gQhDHEAkkYR/s+u3wyD4KbrgaXcvHGtY4o2naTSTa6965l56tFS2x
 HiSjI1tU5tZlzsJF6aNJigT1HXa6zv+Sx4/U+tfRTbrGj+cMJcFVoU74tugRwI5pGxVb
 zAJBxOsBBTNpZgTwuDkdsB2s+IHIjyfQ76c3REzvXUkKAKTuMRo38LrxNmEhDf4OkwFc
 zjiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769127964; x=1769732764; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcKJPWaRPFXZOxkC1ICydCFVz2mmwHWgZVbW5thL01A=;
 b=IVbyeyjSEnHlB1YZ88t/u296hCzsyvo6/dEh8xt+YT0HUjozyFXvMH7/Lb5j8TwQjp
 mtFEud95w4DOZ672ANaj+y9/F+escnJmY+5TfBFbJnzZ0wPjMoV6RgwGakif5unkjTmG
 dWQe6fzwODDHltKRJDezgI+wL0iWW5ZFCFEYrSed5UDDuw5VE54UuSPazWagoNWHhd8V
 qQcs4/DQ42pgjvaqXdbZyUJIxRnJU4+5rWvIr3P5FPSGRux+2Sv4vp9sxGv1JPuiDyvv
 Dp9UZSpqST5nDx4bzi2TBeJV4oURKz3TJgSQPVhnxstI3lCJQm6j+iJIrthU8BUJmvB7
 Un5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769127964; x=1769732764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EcKJPWaRPFXZOxkC1ICydCFVz2mmwHWgZVbW5thL01A=;
 b=Kh/EhN9xStaJFSUkrUZT+pwRkKI/u3bQr5p9NxRC0NFfMrat8Dik/K30/cQENktFpR
 LFm6E+54Dshn9CHbPuUhgqp+bkj8hJzeG4SSRROXekFpxG5DH80NiTl/Romh/2ZlXse9
 AiyV/59Vdhc0Frq27+hYaF8IXHAPB+AFaqtyRcuH7ox/KyfVswaigoDebjmfHu3PpvL1
 0lpkMS0oRjDbVBRdCwbFaW9JtyDr5NraOke8jvOOHqEEixJCS1cftT6iIcnzgHucJKrg
 xLmm19XE9NJF/a6zoNgCGVz3ZLWnX1M9TFhZ0M+J0BRxZwXpIqAcuRHpvB2UkUttmV+1
 lpDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX17hsC1/ck/qtB4zhpTCH7BnerCZNj7j6OEVaWxBb6q+caZnySGA4aS8LIw2uxhvrR70B55k=@lists.denx.de
X-Gm-Message-State: AOJu0YyN9wg92JpHlL03xcBpTy0Ywc35Lx/l2x0nLewMHLfrATi1/lUX
 Udz17XqBtRj9mGK6cu+gFEz3+4yD2Jwa3kKzjAFneYk9WC4omRkfOvb10gkrnnEcryfycaDNj9b
 8tBulXh4nPw3gRz6osoviF9DlK9y7LDQ=
X-Gm-Gg: AZuq6aI/iJMkgHEngu9ZB6zEs0qd5QoWBu3UCw+VYB7rauK+5Ef/6FhnNSpFCN2yp0A
 SPKllqfhoo3aZND5YzEjABsO79bDiEdPkAJBK5+Lh3KooUvVkCA3mwn7PC7Aj9qYfiVW9V4zc2d
 2lCl7tcznBAzUjB1G7HXQOeD8nfnNAI/EkJqGzxKfkaxjE0U4ptOg0emiGlKZfkPQJpxmocKgT5
 UO1HJHqHZ0tIVIK7Cy3gOKxknjs0Z/yp4OLNXbWRJoxDAKZA3ngjLKKDItEqcyJu1OFBweWgNyp
 mSjAR9Na0HleglaruZUkjIQxAuM=
X-Received: by 2002:a05:6512:31c3:b0:59d:d5d1:371e with SMTP id
 2adb3069b0e04-59de49086a4mr301494e87.20.1769127963695; Thu, 22 Jan 2026
 16:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
 <20260122232407.GG3416603@bill-the-cat>
In-Reply-To: <20260122232407.GG3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 21:25:52 -0300
X-Gm-Features: AZwV_Qhxx-GSBL-5-AMeNAdcwMRg6VHX5H1WTv5xxyTATzZ7Erg4M4fyEopIJ3I
Message-ID: <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 8:24=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> So with SEPARATE_BSS the dtb is found where it's expected to be? But
> that then brings us back to what I'm saying..

I retried with SEPARATE_BSS, and it also does not boot. Sorry for the confu=
sion.

> What's appending the dtb there? With SPL_SEPARATE_BSS off it needs to be
> at __bss_end, and that's the same location for me, in both cases.

Correct: spl/u-boot-spl.map shows:
                0x0000000000015f10                __bss_end =3D .

So the dtb should be present at 0x15f10.

The commit in the Subject is what appends 4 bytes, and the binary is
now shifted, causing the boot failure:

hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |...........C..=
.8|
