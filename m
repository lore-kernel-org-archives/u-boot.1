Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAA1CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22B583FEE;
	Sun, 14 Jun 2026 18:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K3h1qzvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AA08485F; Sun, 14 Jun 2026 18:03:57 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D728B83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso5655684a12.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453034; cv=none;
 d=google.com; s=arc-20240605;
 b=P4bWs0vbdcO1nzMX6lveQUjiMhpPSHstpvCuUKYERxT9LvPCmtM8DNMfn9AHZABYRF
 xXpJnPGB0+Sv1T3lWxVsQAplNdv2BIoCHoPGsTzUOYxIVj6GGEDwFMPpKHlfVzAYfctz
 0Tds22bZ/f8hTm7MfFRhgLDXUzGwXxWmD6VqPybjeWYviYeQiS2fnKTAqSKvBaCpPyfz
 rsvPgYcBONciIV9js+Trvshf9UDoyLx/paRT+PEgjMbjqoZ0oXbOmJmJH5tL+p9Y4jMM
 yJstht5rIlnRTZz1Ia/0DnOOhHMKiqjdtztjMXujdKuZf0looDFsCJxadQiw1jLlp/g5
 v6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+E/iSmnxr2y4kV4PfTHe3Hyn+pCEhZSYsE5zCMfa9C0=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=ca1/1Y2AcI1Wrh1vBTz5YZ4oIjVCJU5Rm6VZ5j6XWpO7q78UT1/54GR/8Be5lkXVKB
 I3VkFE0Y6gJ7e7b4nbKzsAupkhLJ6E3eNM6HqH3jJ+tAV4VfQDU4os11isP5qyVvU565
 tMZITLye5Gh4byiQgVXeayKL+9S+C9xAI8XKHK6Tz12/1QYUpl5M7XdDhxCM66Td4znk
 BgQQojVFGpTspJPntBn0K7zLVteWJuHtP7ZgnTXyDrvSHcTW1j+XQIwU6Byscqv4argl
 +DwEi+EYJ6dIPiKojFQD+IWyyyieRZfgYmqt9FKTplmul/bMr4G1jj0641iI2JGSDD2O
 ujgQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453034; x=1782057834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+E/iSmnxr2y4kV4PfTHe3Hyn+pCEhZSYsE5zCMfa9C0=;
 b=K3h1qzvBIllKNmsiI9GD5MmQ/LSrJYRXuUjuC4Rc4EL337XwffyKKQmwb2j6uWOxKy
 X1wEXrjyrZKeCE6/qlCCNHBxClwr03ntNLulxG6t4zy2NVC0Ax2AXrnkEHRRPeFqiPe9
 aMf1bma9a5ffhMXslIHcK0ah2XP3Eeg1z5rdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453034; x=1782057834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E/iSmnxr2y4kV4PfTHe3Hyn+pCEhZSYsE5zCMfa9C0=;
 b=XTvR8EOqAcJMPYmUqieHuo08bauT8bpM3AZiFIxb1AIlWzTe7JbN2vZ56QR90PrjtC
 7u1foBSpU/oB3ZOBSjTeIx39Rml6bEDYVHGU3UYUyYwyhycmdTwfTVVupisZRNhFixDb
 KrLHJJh33sB9Tu+j0Ibnpvyd3DDx+gckLQYKbTZVhwUodFSd6iy92+myoFuO8gjwn0xJ
 zNb+XKEhIfxS6+kIE8NPr/Wh1UixiaAHcEeYO96TxJ/4E19mdL9czAVF10LDWbWIpk9f
 bDsCUDbMqKtoeMReOGWqsze6XWxqNzl9a7AwsDLvfls5XqfcJLsNJvOgNsaPNibo/NJI
 aUGw==
X-Gm-Message-State: AOJu0YybrLYDV6krUX0UD8zp3omoFWmjbd2JM+lA7tWgdDLZtfxcThqH
 2AxuKo5TR61KMKXTFADt0w9LZQ1nKnOBx3HHofbCy6OKsnTrQTqsMaotSlYfTPv9Cdjk4yq548N
 sBw+fdDWO8PiDJr9BMwimUn1ayU8GCP5SuP0ZUViu
X-Gm-Gg: Acq92OGkH1TZ+SJ0xLLVoREzRpi3D0PdC3OIbKno6qz/m9F7iAPtnJUBesgI/rZpvrM
 M6hXZu4FkLKpmAWiUv1iBRBU7y38NHTAiSSY2yEgZRlva95HGhYb0nf9J5Fegf6A5FMYBJ4RhZ2
 YhCN1VzjhbgvZS/c39zCWhmBtRTSOaCqHXCt6GlIKj0+Cvy/qI0th9jNnepsLeBvwIIQQMggXs6
 hVJ1ZoCThwE7EWDK4eaEuVAFzAXe8y69azJGgeSjYOwW+oNSlDmezJctF77H5JuTKHTHFD+qdGv
 xdKBFPZhWteqrNH8
X-Received: by 2002:a05:6402:14d4:b0:688:e4c6:fd1c with SMTP id
 4fb4d7f45d1cf-69368bfbbc7mr3014571a12.8.1781453034273; Sun, 14 Jun 2026
 09:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:03:42 -0600
X-Gm-Features: AVVi8CfcJYw-Z9sb8aoSR6Rvr_UYYCeSlTMCzCafYmgM614ZNsgOyPyMbq0Wxrs
Message-ID: <CAFLszTiUp-araejNuKwR6h6cZK3GU33oPsg18wo0hUDhQ-5Rfg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: exynos: add j7xelte binman config
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
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> arch: arm: exynos: add j7xelte binman config
>
> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
> upstream DTS tree. It was accepted into next so it should appear here
> eventually.
>
> Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080.b4-ty@kernel.org/
> Signed-off-by: Sam Day <me@samcday.com>
>
> arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
> new file mode 100644
> index 00000000000..0cd4c12a2e4
> --- /dev/null
> +++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi

As already mentioned the commit message only explains the caveat but
does not say what the patch does. Please add a sentence describing the
change - i.e. that this wires up binman to produce a DTBH+abootimg
flashable for the j7xelte's S-BOOT.

Just to check, is exynos7870-j7xelte.dts in the tree somewhere or is
that coming later?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
