Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E753C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DEEE4074E;
	Mon, 20 Jul 2026 18:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8qLXFgKgbya; Mon, 20 Jul 2026 18:17:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A124A40708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571444;
	bh=VB0fZ204yw60ZK4E8Uj2fADV7QCHIGrU7VdV6wriAYY=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=l/+a43mmWs+zNKqOWU24OGMwiSX+izgkjG1FfklC1zfWky97NXDgS9BJ9YNNgcLqF
	 G+tIF6qJMo/8mP/+9M/BP6fL8OzcFnPwi8BMRM/ppEusXjoZVhwksasZacwDb0kL2Y
	 EI2EyruzsMCPgLqAIjz9oMu6gIjl5AE2j5IxLi8IIY+vPVzdVR0aIAVKFjSGLDf4pA
	 1KS2ehSlr4S/vsKgoW/7Iv2ET1vA2kbNZSWXGRvFPbwgDOHgti31Cg4ZBMy5gQvF8k
	 +uddp9d2j+sDxFdh5qjYnwCvZ5M5gP6nZvMI84dYL0mzPaTNJAZwoUQMyJf5aNh7up
	 wxFQjBvegKS3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A124A40708;
	Mon, 20 Jul 2026 18:17:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAD922E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D881E60711
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xanX8LrcRyOO for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:22 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A3CD9606ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3CD9606ED
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3CD9606ED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2390B844F6; Mon, 20 Jul 2026 20:17:20 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2719280433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:17:18 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69e08ad526cso7204277a12.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571437; cv=none;
 d=google.com; s=arc-20260327;
 b=rwE0bX5xUl7rIYOeAORivaMeCQLao+3jmooDYO1ZWJWNGmnwqQuqMZqvi2YPHrIiS6
 9P3YuckbRLp35cTimxovge9G4EUZ9WYgonmyADudmiR70vgvgzRqTPr78Eqyl7lMDWac
 Tgd525pxOYICVD1CYadVE38qiDhLvOsV8Dn6hbFUh3dyBomMmY89G2CeTNgalHyuin7c
 V6TOHzujj/qJN7zcl/Dm6E5eGO6MKT/wJ0wAR/3mp67dRnHzPXfgBO2IIkVV5z6r+UBe
 Iwj65oN3rW0PJn68AwAJ6/VkQ8hA8IUOKQD5G1GTFMhH7udGpd72m5RxqDFnNfYITkmD
 Do6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VB0fZ204yw60ZK4E8Uj2fADV7QCHIGrU7VdV6wriAYY=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=X6KUA08tCp8NtH7mEWYYttF6IsA3HuuASeVNO0X7zgciGTEvpqgBarcudQ++3jryqn
 m1pYZ1UkhDLw9I42gNxWYEPEn55yEwucNzy8+s9i30vOlcVU4pREyOATXE0Yu4mEM7IV
 RWtkP7xcTDsoDhyxtsCRKIw8baT8xBZPXJRatfqzWXWiVYsHgv5leDZ/qH/3RzA/vF8C
 tY7izUW6NcohY5RI2DBBZWwkgnqr23FpzNEtvf4ioI8rw9r4NNK0a/vOyMYmJc9eN/Pb
 vh+4S27C+5mhN6IXOZnl86H4nXpQIiaEuA57134JJNToT1V169nOwCXk4iSStIcOc+CO
 KQpQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571437; x=1785176237;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VB0fZ204yw60ZK4E8Uj2fADV7QCHIGrU7VdV6wriAYY=;
 b=dNuO2RephgxRU4GKqczvBqANnthlOQAkp390atwCNU4m7KVxULqdLGPT+PGvFJDQr/
 ZY3zLt4CcbAFC4B1fUqAT3oHPPB91jIqeNGZQ1J6WYUq5ogfMMnO1eSgsShn/rpDooH+
 MVhQErwM0f85ymCbg4m8MQO5rj1B44rwNV0Uu+fSc9d36TIutDDA1jFuHMNrjUsh6s4k
 i55VlciXe8iZoi52rR6ju4IU0w7hlOKx3PRoGQdhEAO0v63EfxUHpCoR4p/Yl9x5/Ef4
 pQFNqL5Zzi4liF09mfSzgrJHGPRIYnuw5yIU4wPiLsfNT4wOAFpw5iWnpFdgfSo3pJy0
 BL4g==
X-Gm-Message-State: AOJu0YzEdhLNIZjmhqEx6HNxHXn+0T6DxIvJEyM/SjBEIrUauID1ybfB
 PsqyLkZTaaRKWr8pxB8DlpEgI1VPOagi/Mw1Sct3R+pSjB8tol3+4jczV8uftCpga5S4N32QEGk
 bktgcJRswbM8SZv8hAvjPQc5/rvLmZWsg/eB3tds5
X-Gm-Gg: AfdE7cmpa/EjnwBD0WOlzRJLYzyZihsEuKbI2LHVoivScIB+htBzyxxF9YkZ0rDeZsm
 pqUoMEg/b4B96/XEsNlMgjZJb/KtpmdOrNjIUNbTyfbLZijXbH0UCqEpPfLavGojOCoz1MfyDiG
 rtfaWJStvkpQfUY8eFRW5c/CYtrGys26ao8V/iKPuIBTGTCp6x3z+RgvmZMj2ldX7d96ZKv6h6i
 xHsPnRQ5QEe2XMDTJqsqVsV7PdUIw0M9eDTt28MdCeSmZBQREsb+Uw41T548cWBxVWW4II=
X-Received: by 2002:a17:907:1c8d:b0:c0b:e9c1:93a7 with SMTP id
 a640c23a62f3a-c16b46f7c11mr771795966b.29.1784571437589; Mon, 20 Jul 2026
 11:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-6-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-6-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:37 -0600
X-Gm-Features: AUfX_mx8dzMmu1tYwbJauMHgjhWbErJ7f5rEzqbW28x7DA-MvdZbXqlgTFE7TS4
Message-ID: <CAFLszTjwEQbZKRFC=zomZ+zz5L8Y+zpVqwBJwLMteRyz7xZY+A@mail.gmail.com>
Subject: Re: [PATCH NOT-FOR-UPSTREAM 6/8] video: Add Aspeed VGA driver
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571437; x=1785176237; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VB0fZ204yw60ZK4E8Uj2fADV7QCHIGrU7VdV6wriAYY=;
 b=lLr73+6mKeQPn4YEeJzYbawZwkH6wxT6cIMUm2aFE4eLfrhC0E9s1sjn69IZ0rGlZA
 HDvVuNY8JNeiBV7k6X9swH6ldptFrH3LOX6Ao9iWPyHahbfGQalWaM5/lUR0TwHmGVaY
 og+rX5SOV8YGTwGSGgo1DoZEoHhW6afKi8U8c=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lLr73+6m
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="lLr73+6m";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> video: Add Aspeed VGA driver
>
> Add a video driver for the Aspeed VGA device that relys on the vesa
> video implementation and VBIOS emulation. The VBIOS requires a custom
> INT15 handler, so that is added in this commit.
>
> This commit isn't usable as is, and depends on the next commit for the
> device to actually work. And I'm not sure if the next commit is suitable
> for upstream, so I've marked this one as such too.

Typo: 'relies'. Please move the upstreamability commentary below the
'---' cut (or drop it once 7/8 are sorted); it should not stay in the
permanent commit log.

>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/video/Kconfig      | 10 ++++++
>  drivers/video/Makefile     |  1 +
>  drivers/video/aspeed_vga.c | 81 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 92 insertions(+)

> diff --git a/drivers/video/aspeed_vga.c b/drivers/video/aspeed_vga.c
> @@ -0,0 +1,81 @@
> +#include <bios_emul.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <pci.h>
> +#include <vesa.h>
> +#include <video.h>
> +#include <linux/delay.h>

Please add '#define LOG_CATEGORY UCLASS_VIDEO' at the top (see
bochs.c) so log output is categorised correctly.

> diff --git a/drivers/video/aspeed_vga.c b/drivers/video/aspeed_vga.c
> @@ -0,0 +1,81 @@
> +     /* ASPEED exposes a 16 MiB VRAM BAR */
> +     uc_plat->size =3D 16 << 20;

Please derive this from the BAR size rather than hard-coding =E2=80=94 quer=
y
BAR0 via dm_pci_read_bar32() at bind time, or at minimum use a #define
(e.g. ASPEED_VRAM_SIZE). SZ_16M from <linux/sizes.h> also reads
better.

> diff --git a/drivers/video/aspeed_vga.c b/drivers/video/aspeed_vga.c
> @@ -0,0 +1,81 @@
> +static const struct video_ops aspeed_vga_ops =3D {
> +};

You can drop the empty video_ops and the .ops assignment if you like,
as it's optional at present.

Regards,
Simon
