Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47537C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C8480D6A;
	Wed,  5 Aug 2026 21:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ffuXa0DJHGnl; Wed,  5 Aug 2026 21:25:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98FD580DCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965133;
	bh=Ij2Of9bKscVICrX8m0eQ3qK4cEK1efodidKS0Ce37N4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lky+wdjQFB/15cDpc+XMS/3xGcMGegQcdniEbq9sNldZOrDPzPVtcXhY+5CtT/k2c
	 2/6LmhtmME68JIUfWRtspWMelEZtZwJFRm2QenWoD755la4AYzF6yo8BqlqVqLA9/K
	 IWCPLgHckDm/21LXegltW5j4x9zilfJwantA2abAplHSSoIOtJMp01p7LWNvNA1Crf
	 1WQ1OH9XJz4EF1CjBwq9ocHJwr+yYPmNRFlPpXvOffld3sqaAP32mBFfbksBrAairA
	 SqCmtg9afUpLrlY6W1sKAAWsoCip2qUmVY3cSCCsYVjxaaE1YTlPkgzXSjhu5pktyQ
	 mgFmOi3k6EbMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FD580DCF;
	Wed,  5 Aug 2026 21:25:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A95C029C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A51A80D6A
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDFCF0uG0leU for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:25:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 976C2809AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 976C2809AD
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 976C2809AD
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:30 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so2538588a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965128; cv=none;
 d=google.com; s=arc-20260327;
 b=rtHp2yk4dVY2PBWvW6kXBYIdhu5vFmLhf924fHtLIq5mlsotUqeeUz1rZdiHO8kz3p
 MxyMZuiuuY/1brCqNHaZFufDIWVkOahZlpyNwb4fMcTdUTpC0EYKl8H5sCEl6dH55aaT
 S23a1TqIKjV8cz7S/KQItErvfYUP2SRzQsrwY4GRFkVSLnF1bM4d6OVB0T7yesRJocvj
 t6HhddJQB8+iOYxsjMytD2GFjcGibyIrQ8zkxpstpYiCP4i8AnC6zBonCjUPd785Vi/8
 g9zrzd6B22vBKe83igEdT8OPsa8fHYFeOFixDS8KiTynwptLr+dKeJSTRXfiSrlZE5fz
 RUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ij2Of9bKscVICrX8m0eQ3qK4cEK1efodidKS0Ce37N4=;
 fh=xEUUUSHU18FrDNuh9/VGJ7CSs9Vhzj8W0EfEjn0I01s=;
 b=QLxHOlIFShVLMHTA7wMpJz0b9xLBZuqE/iV8dmYLefmBbTTEfN+qudbpUHFduhOH9A
 mimU8jwTYqS4okyt3k8lDoAQZss/L+/o9YI93xJ/Er5PGxG+v3aCqF+EB9pX1r1jbJxx
 wcoUbP7qSvY95PZl4enFgkQh5dliSMHQO6zs6LeGBZu1im9MuG6l7mIJR0Rcy3uVHkka
 Crmrsa4VRYsMWHbu4D//umnFLckZENSkmNMAmcxOc7ZvwhchjNuENUa1xXA9wMOxPgMZ
 tELT4E8huh4kJe8TgGzfTV+hCJXQ5LDKHdfy9Ks8l0+dcC4PdL6hue2tYE2JDjAdGo2E
 c2UQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965128; x=1786569928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ij2Of9bKscVICrX8m0eQ3qK4cEK1efodidKS0Ce37N4=;
 b=c76ryi5aluXGC4FeXNKsG58ic3RQMDl0BztKpGo/25syVrVyA+D0F8El3FONYxNunX
 Kuj78iDIobvzL0YnsOYo4IlvJmgOKlhKLLt7HsxeRRuqOaE9UQD4NuPELSaSCtuIzDlH
 qWmUacmsJI1sirI1stZJMwqCm7LdaFcSco1tfsA09cbff6HeVXLko+XtkpJ3ruv662/O
 JXYkzf1UtYXShX7jCnrekREUcLXdglazlkY83ZpXXHiYxrhvWULV5XL0apFBakPBxQEr
 IQSMUWlcQO3xqzWvhYwPeQJqz1CJv1E7smwbLJim2KGVtSSRs5on/IfT1jyurPs3kF+f
 cquw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZVeTK+zHFB0Fm8fmZ5FVXhx6QhIQZcFs4XCfflduLafTyX71ceLvjcLyEZG7/+Szd8c93S9g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywu3FfxEPZgX2iBWOO4mi047DVyYUW2KZ88t34XwFYrvNYUb4xY
 bOUSI9GGsibXRGp/Znw1Bdm/Ag8kKAzT4X0AFdfGBCu9oIrml0KIuLHoloZ8y9erzjUlXLymrp9
 qbEEvSV3RvGx/o3JL3MPIzVlDplZAddFozn2FczhN
X-Gm-Gg: AR+sD11QRBlfkN6LAXsfpw9/VImNELrQMFE8LVHFiYBOnKKy5QazJI66JeETegX1t+C
 1EYHuqKw2Kw9w3Lacp1Sg2Hrpgwc36Se3aep6KeQD5DaxUjSoUQGYjEt4yUEvmKDXujLF74g8uh
 ATC/qOw1sBbPfQl6hb2oPD5p/cybaNOIxwJDWJR81e2JKkPeriJU/QU/KSMwKCW7Ebsw69i0VK6
 E5nIuxXODnZt2lmZDlu9ZWXARq3W9xdr6LxTlJyNPECOEkfgHS6PCohoayDXSxx84mU60XvhTY8
 kE5lXn8H14qHzzNX1BVfMtiZMBnKqHTLY3EdmorfOK4=
X-Received: by 2002:a05:6402:3506:b0:6a0:da09:885d with SMTP id
 4fb4d7f45d1cf-6a14eff888bmr5025403a12.0.1785965128410; Wed, 05 Aug 2026
 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <8e3babdf-dc50-44b2-a184-7d9f2a9938ff@gmail.com>
In-Reply-To: <8e3babdf-dc50-44b2-a184-7d9f2a9938ff@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:16 -0600
X-Gm-Features: AUfX_mwaCXknAJAcHbJXX9Hmekho_5ut1uU0xYa13TedyaWW9yG-JbNXBLkCb34
Message-ID: <CAFLszTj6KGwqA8Puidwk3-pWZdveJnXTXKX=NZtvM4Dk7sC75Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] rockchip: doc: add mask ROM mode text
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965128; x=1786569928;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ij2Of9bKscVICrX8m0eQ3qK4cEK1efodidKS0Ce37N4=;
 b=dT70yhDM/DpWs8XkQAkC7yLlssdZqcLFMvdhWjRwrvRSoTOtW/BFTo0vF8VesrMlLH
 MeBdwuNL6SqNojxLZ5TKTz0GZRkgurualrt6iRMhnqICj39Yt3HmFSMB/S7iotkZaLgN
 ZzJEFcTE3LpoCAl+9pIA5EMhRcPJWl6x/xYbo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dT70yhDM
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add mask ROM mode text
>
> Add text that explains how to get into mask ROM mode.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -321,6 +321,28 @@ To build rk3588 boards:
> +Mask ROM mode
> +-------------
> +
> +The mode that the boot ROM falls back into that listens to
> +0x471/0x472 USB commands.

Sentence fragment - no main verb. Perhaps 'Mask ROM mode is the
fallback mode of the boot ROM, in which it listens for USB commands
0x471/0x472.'

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -321,6 +321,28 @@ To build rk3588 boards:
> +Options to get your board into Mask ROM mode:
> +
> +* Holding the recovery button, depending on firmware support or wiring,
> +  when booting the board.
> +* Remove any SD cards, removable eMMC or removable UFS modules.
> +* Erase any storage media containing boot firmware.

Please make these consistent - the first is a gerund fragment, the
rest are imperatives. E.g. 'Hold the recovery button ... while booting
the board'.

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -321,6 +321,28 @@ To build rk3588 boards:
> +Methods of last resort (USE AT YOUR OWN RISK):
> +
> +Pins that should be connected/sorted for a
> +short period when the board is connected to power, so that boot ROM
> +cannot locate any boot firmware and falls back into Mask ROM mode.

'sorted' should be 'shorted', and this is a fragment. Perhaps 'Short
the following pins briefly while powering the board, so the boot ROM
cannot locate any boot firmware and falls back into Mask ROM mode:'
leading into the bullets.

With those:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
