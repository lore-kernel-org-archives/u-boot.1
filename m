Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11397F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A833E84319;
	Wed, 22 Apr 2026 00:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lRwrgMkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E537842FD; Wed, 22 Apr 2026 00:51:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8920D83AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so813853066b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811859; cv=none;
 d=google.com; s=arc-20240605;
 b=G7Xqsq1hHM+CH9oFMHKsBBY82jLPSKQBIYCFoqlE4z9QIW9T5wVJRDTZ2KxwB6wmV8
 W6yhtTsXie/0iOVPfUJcjuxZewhV7QHh6QNOTifK/CMpKlrTxAMJkgwRS/f4/3mslNg3
 TuU52y+uCk/k1r/w0KRjdkxB42UiRDCGTUnNOOtGqNpSrVLKk5z0sNUfMzlNUvmu2p9E
 +jIYdSjaAwxzaaqMMTW4NCFbXmARVWbH6RScPgQrkvHGQZDOM95VaACEWrw5qNZyhMZQ
 zi30VjTHBCdRpb9rxDavpbfpvUrKHG2NC4RPG4FLoY0NC8nwsVkaijSDMvGZmIxUK/OJ
 npKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Dc8yUHiogEq0hoKKQDXrfGWTfaHY5KTRzzGmvkb7Og=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=INnKbWowX+goougqJBQaaZlB5/cXrW7JGGuyKxYhsG3N5H6D4J4Wn4bbmzYjJ1c2Vo
 /+f0Zy2X0bej8Zt51X8QVsJ9TlYjaCqZ/ae4/0Q6ELeW9MONkjs6gYk0NIJzBDtuffGA
 DDmIO6ursIVuWT5McIEFqh3XVSQW9MpW6RM5WQ1j6AMYJ88CBOAm5HShB5472qfnVaDR
 a2Dpf+z3dXm8JmZKk8ypxGzeIysg1T6LJdvqi/srbo7DhFuBGK/3YjsYegyqqh+NlGe3
 x+sDgWdJ4hbjY/hb4wwXxdX8XhwuqQYOjKP8Nf17rWtwrbaiCvdtW2cMiL08ZKC3c/sY
 FO4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811859; x=1777416659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Dc8yUHiogEq0hoKKQDXrfGWTfaHY5KTRzzGmvkb7Og=;
 b=lRwrgMkSMwO9pmGA3WgLIBGAHvG/4P2gZkgfmAbBliJkShjyTrtK6o0FbPMrAI3tKI
 0+ArF5HHLYyUyRaALhA26Zy11lgep/8/f6Yka7a8skUsgYAf+ndHjozSlIZ+hvFjeQrd
 H53PZshB+2k0UMKAzwor/I6FFtMTd+djv1huE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811859; x=1777416659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Dc8yUHiogEq0hoKKQDXrfGWTfaHY5KTRzzGmvkb7Og=;
 b=k/q2xHA7tv4EMjznogQozLRI7BageB1afE+oK7FALdYvnCovsaI0aW2anUCB5DAmWp
 +lE8T6XszQMW11DLTksQIWatmCI3cCd8rZ8uzKouNiFqu4qBRvd0Uenc5i3an4nX/O1Y
 clxItpB7Ttf6lOHb/EcvWsoyUIjxGOcT30rXxaC2DRT4k+Vaz3DyijBQ2JB79/YCJydx
 m9WnAZbuWUVvTPvWK9vEzBS6/1dg/zykRqIAqWbaU2qD5hvwFZndTEf6+tUvEGNqyz+G
 LRRYgD+VeJzB1a8FYFpNsNcw1YmPW3gEwQkbbpPZ8Hm2BSCFCQ4FzMzBiPgM1itzY+B9
 7tgA==
X-Gm-Message-State: AOJu0Yzhuw9V5pQlK3b7PRM+PwQyT87nk3ayxg7eYms3IrCLLwP1G9MH
 pDNsbzdUnLYFgVYoAYkpcc24UG0X35rUfNpKAWxBEYp1NisxLx7UVVAVflFGIC5L1QAM7SJwF6N
 JFcBiYTIVmA2OtNPg8IoCQg3Cy5U2zFjoFA1WiMov
X-Gm-Gg: AeBDieudn4OjkQEtsp9I5JQ14EbbJtq0tkFWiSQbrCnDNqCvncJDLpONHpV3ygYPfsP
 0h18Y/Pz1EyAstz+H2126VC53knNBO9GahAaybtggdr9EAqmoUC4Z/ICDYLnM5C0Z5TjhZiGsRV
 V7WSLgL/wFfCbCEpKVU8c4fB/JD4tXbPr2lMqS1yau2iMkhkLta6HhUfzNB9E4CvcM3xc/qYj8z
 1ZZeWTAGADUPbdGG3LcMoFTJlBXc4z1zOaSAG5BkTWac+Tpf/0jLm9se7kkFHwo1KM+KvBk5CBK
 +VVlDoucnnC/pR61aRbk
X-Received: by 2002:a17:907:970a:b0:ba7:9885:b56e with SMTP id
 a640c23a62f3a-ba79885ba4amr500815866b.20.1776811858917; Tue, 21 Apr 2026
 15:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-2-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-2-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:50:44 +1200
X-Gm-Features: AQROBzCiW7U_AloyWMMGClzlX9a8JeZdrTFW0iK3YEoX-ADoexhqnVgC12KaKa8
Message-ID: <CAFLszTgq_M6TxjD0Kcsh63M6Td7CeHF4p6v9Q67v4JAMmxQ2OQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] board: ten64: add fdt fixup to hide usb hub
 topology
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Mathew,

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> board: ten64: add fdt fixup to hide usb hub topology
>
> The USB Hub (microchip,usb5744) can enter a dis-/reconnect loop
> if a driver tries to re-initialise the hub over I2C.
>
> On the Ten64 board, this process only needs to be run once
> per system reset cycle, which is carried out by U-Boot.
>
> As there are distributions shipping with the affected
> driver by default, the best solution is to remove
> the USB hub toplogy information from the FDT passed
> to the operating system, so the OS won't attempt
> to re-initialise the USB hub under any circumstance.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> board/traverse/ten64/ten64.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

> diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
> @@ -186,6 +186,50 @@ void fdt_fixup_board_enet(void *fdt)
> +/* The onboard USB hub driver (microchip,usb5744)
> + * can cause a disconnect-reconnect loop if the operating system
> + * attempts to re-initalise the hub after U-Boot has already done it.

Typo: re-initalise -> re-initialise

> diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
> @@ -251,6 +295,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> +     fdt_fixup_usb_hub(blob);
>       return 0;

The return value of fdt_fixup_usb_hub() is ignored here. I understand
from the cover letter this is intentional (when the control FDT is
passed to the OS, the fixup has already been done by board_fix_fdt),
but a short comment explaining why would be useful.

Regards,
Simon
