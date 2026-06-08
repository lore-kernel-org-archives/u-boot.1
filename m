Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EA6CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7543C8407D;
	Mon,  8 Jun 2026 15:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TcEGE6M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B68084895; Mon,  8 Jun 2026 15:27:58 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A8D8405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso4190008a91.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925274; cv=none;
 d=google.com; s=arc-20240605;
 b=Mi3qX45R+iPZ0L7Sy8y6y+bRKe+hbgcub/9DWCN7BZ1rvqpeGiuCjsM0BreppxUNYr
 f4+uj0BoPdHjzN9pfZV0ZzODoEQpLeWQfP/RpV/tSG84dAOP4hsuzt3fAj7CRCjE1Q2U
 f34IWILHtuoPXNqSfcjgEyJcFc9VZD7CsLU26PMf5YnCAc7z5q+TVNVSSOQwX8WisAtN
 miqRvvOnH+BXA9Iu0ZRhaMiRwZC86IIWp++1ZlwSZfx7mML8hNPc56GuiXXbl6thARQu
 V871gXNLxNa3HrqdihZ+X87Iu8hy1UakAmIkMMmbcBtnUhN7eOMcyOE46bjy7qMEMcnH
 nxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vQ2vG368qDCG0H4lEQhh4y54Lqk+bTblS572kij0K1o=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=fbcKDTBDERW+BApijfEdYUbvLAnk2GT8OQNS/BV33rZP0kJen3+l0NkWKOLDRs1ueD
 h3abnL223xPoECqBrCUQOBPHJQLJcczF0zoF57kimIoU0P4U7VfymDStp769JUSR7rZC
 BYXvBqxoxYK/8zKZLfCeEhL7xj/8G59a5MAQufLJjxZaZOtJR6zUPGe3R47sjsAaOHc3
 qjTzDYbTy3DBDgwGl+wn5RVpdbix4BU3VvEagUqLfsfjK/ul3ILZKrkAG0d9pXKbGXgb
 D1X1Tu9POq9SI6uLl/b3Fl+hPXi+n3u7wgnE5MJnsUe9kpuPu4BEAywiAIjXAxaoNUNt
 lZBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925274; x=1781530074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vQ2vG368qDCG0H4lEQhh4y54Lqk+bTblS572kij0K1o=;
 b=TcEGE6M9ABNdDZ1Yr0HH5eKw7sEMeKNhldWvzEKvI4W2F43aQoigMBEWqcZZnQ6Y7I
 iCwzYR/Qf1AolaUCWhxpZNtNjY9Oy6RaAgZWISERyPlBZEzReTSGDBhZHnbIQ6knHCXV
 3v3ovUCp9s6dVfl2WlbZkgUagn7cWi2FWVgow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925274; x=1781530074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ2vG368qDCG0H4lEQhh4y54Lqk+bTblS572kij0K1o=;
 b=eSbTQtWzfu5tfEFu8SN2ftJ4+hc3t4yBfySpmaV66xAJI9xyXpHR9vLld42aXFv8tn
 +rNaJIAq/lsWc3WZ1EelojQgStGe9oSICCX2Hfol9GDSC6of/LvHGedSB+bBc86Byv7e
 P/jWnCV5nN7hBBHyxAHqrnCbUl4qcdkYGvJIB7d+3749t3Di7wBoLBpK9Dq29krFU96s
 gYu6oE01tS6J+kHKMCDAMRbjiXwxqnKNyNaF5PJThZRhG/xee3kxiaz6/AyGFOFSLR9I
 d21q9jOXQF6WtpxvIWvccL0MnBmnFqDUmIZq4a/jO1pDjV0J7pW4a2ae92Prb/uRNR5l
 wSiA==
X-Gm-Message-State: AOJu0YwiT53MAl/tkpqsORXvVdvht1YTZUv6Wx1eMneYEd0PKif6okev
 eMyKBPuWCdLA5ocAmk7w5Soc7JU0244ZVCRwq/8CvlaIYVcPSyzkqc7avaqTPTV/hjUy6QnEPRq
 S6jteEK8kIUFFzzVpTutzS3zAfPQsje9AphVNSKts
X-Gm-Gg: Acq92OH68h1NwmVbGSNFX7vS00G3wob5oNZMTb9vNSTF5Ym1VkkdQjG450DrzmFKOVJ
 ijVrFxkVvpMiERauEw4M8es6CbyT2XqR/uwH2FwpQdjUvPYemJl9Sp8B4IQPFm90awwwwKdcTtE
 5X32f4Ro9s0PGwDT3JjUU+3jPVjw99kHiNwgwZYmPc/LtNysYxTCj2tpBFGcpvmKvAdy+w/lfCn
 KD2QojPJn1vEB3zUDQsbQlQaLa2qzKsmtVQV0n91nOFWA6TlMA9GmUJu0xr1F4EK1VDi4d6Diun
 QsgADIScvQFfqQ3D
X-Received: by 2002:a17:90a:d885:b0:36d:bc0d:f78c with SMTP id
 98e67ed59e1d1-370f122c125mr18230105a91.21.1780925273862; Mon, 08 Jun 2026
 06:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-7-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-7-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:27:13 -0600
X-Gm-Features: AVVi8CfLv39a-KbRJGrCSV4NhElvbKgwPdSzKEpxJrfV-vARd6GFCqL-0_j24AY
Message-ID: <CAFLszTjXckdYQ4kQmmH9yFsh0GQtea2TGkRfsitNn55RkPFF5A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arch: arm: exynos: add j7xelte binman config
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

Hi Sam,

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> arch: arm: exynos: add j7xelte binman config
>
> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
> upstream DTS tree. It was accepted into next so it should appear here
> eventually.
>
> S-BOOT expects a DTBH with hw-rev == 6.
>
> Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080.b4-ty@kernel.org/
> Signed-off-by: Sam Day <me@samcday.com>
>
> arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 24 ++++++++++++++++++++++++
>  1 file chang
> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +     binman {
> +             filename = 'u-boot-samsung-j7xelte.img';
> +             android-boot {
> +                     kernel {
> +                             u-boot-nodtb {};
> +                     };

No 'base' is set, so android_boot falls back to its default of
0x10000000, putting the kernel_addr field in the abootimg header at
0x10008000 - nowhere near Exynos7870 DRAM at 0x40000000. Does S-BOOT
on j7xelte ignore the load addresses in the header (so the defaults
are harmless), or do you need to set base = <0x40000000> explicitly? A
short note in the commit message on what S-BOOT does with those fields
would help.

> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
> @@ -0,0 +1,24 @@
> +                     vendor-dt {
> +                             dtbh {
> +                                     dtb-0 {
> +                                             u-boot-dtb { };
> +                                     };
> +                             };
> +                     };

Does this indenting use tabs? It should.

'S-BOOT expects a DTBH with hw-rev == 6' is terse - worth a sentence
explaining that this pins both hw_rev and hw_rev_end to 6, contrasting
with the wider 0..255 range used by the j6lte overlay, so it's clear
why that DTSI's approach wasn't reused.

Regards,
Simon
