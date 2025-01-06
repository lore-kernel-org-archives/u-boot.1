Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E89E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 17:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E618021A;
	Mon,  6 Jan 2025 18:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OdsrkoNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E588036B; Mon,  6 Jan 2025 18:00:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96059801E8
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 18:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736182815; x=1736787615; i=xypron.glpk@gmx.de;
 bh=oD7frBHyBmUsqS2p8zlWayrETzXOi+BHHxzAMrMV4Tk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OdsrkoNzagJA8kIWU1g3Ft9G9QLAFTlCwWDRo8mI74I4ECdNm65DFgXkvv4cAsMZ
 LQ9V0Ak/bWAjQfikqHRPAG8AVaE3khVQ4f9GP+bHrU4U+OM4+2eBHD2Df31qhU0lZ
 Y3car1c09wBK5g4XFMzCLS3NKHY2k+xX/6OVtZatSLmVcZ+lDQzgN0O/8XpqbOiP0
 cmZrgRnOpU1zLt+haV5ccNUZmmR3wKlbcxK40fSP6cQ/fuyFJYD1zeB+Exl0pT20m
 xe4b5IgDgv2MkULrTcmcbYehyhPgGJZG+u6oJ0k2D+gTKhu0Jbws+8EUnloX72LSc
 q3uaUVMtUX6L56o2tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1tpvfX0Bpk-00mp87; Mon, 06
 Jan 2025 18:00:15 +0100
Message-ID: <51c61e63-82ae-4660-b2c8-987a63c7d091@gmx.de>
Date: Mon, 6 Jan 2025 18:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] efi_loader: Complete the bootflow_efi() test
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250106144755.3054780-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lo3ggvb52tU/2p3l4kkSbGDjJuI2kOV/yyI/fkMqs+M50KlBSVp
 5DzQd8LK+bYuZPGWPd6YIZf8Pu57cpYVL/Jmc2qZ3ptg0Ih8zfuloaujUXCc60oD/29zM62
 SxrDdSxSz3cNQ+FFpImfFFzP3JunSENpgONXBxpzbxvTzojjXgE8hFU4u3dElW6QazTCe95
 7FWK6oaCFj3bj9WYWbz9A==
UI-OutboundReport: notjunk:1;M01:P0:/g8WS7DjOTc=;et7932krXQrB1Ng9AP4XCbi0Nki
 TIu6H3pa9jJ+TbrzJjvUgMXEYWzbUduxHPQTj6LNPtC0DmndapeSwuqfeeOAjMB7qad7K8V7N
 REv+q+1kZpMV5WfX1Bdv9OiEXhO8C7iB+pPP7e4718U6bDfzImGq0AqCnK5jo6HWo1zHLyovw
 wInxFTlhNdw709gWeZ6AQqTYdR84ZaGn85nCXLFhIL/UmGa/nELYqUzQOcj/MPycMr0YvZrjH
 CUsZXtm0hx/hS+IaHJfc7QJsL2vyMuYUopQvJT00xMAalV/kIEx/1aoIDj7V0XGIFruODNAKx
 lvc4ViRiOyns/DqYPzV4wgdxw56tqn4XEUKMhcBmKXh4UUL4hGCA0qDLhrn6Leg/T+uAhR7vL
 MZG7fY7CaBYzSjhZQ+ObKrNOMAHwJB2yWhgn7iqCVH7VXIjk3/xAw+Jf3dk6M3TuGcXxMSyrh
 +iuQdDj8BzeD/jA2z5aYtAgPIbV4bxURvgy+Cbv0OPTR5MkeiRRMv3vLn96LOZZ/DB2/FLryI
 8SjlbB0D16Sk1pqN15AZ1tq/XUmXCyBkTsEa/MLL7FH65EcL4hmUCKmw3Kv3HeAYtnoJ8oco8
 h7vFN/g3bYVs0RsTJKmvy1j09wMWYKDiqt0RHeYJI5s1KlDsCMDrTyR3XQl9exTzLPST9u6Ig
 nwlOM6XwyZSAOQu1hsvz7q91pU820obedSq3/kMmO6Wzf6Xok2hM8WnO6Rkck6p1N8fp+FgJT
 3gSq/u9oC2HIStoaxSdqRXkxAZqswe2dMCEoCluuJ4C00vjH5Hnff0IfXiWiTtyYDUCgh6nFr
 eRMrlZz5mZ3wiwsV+KWJqKybEjA74FzTYdgguxiLY1XJuA4vTUvcWaP66DFxEkmpY0YxDX2Xz
 UETW+IlVN0wS8pw8+eXgbv8jAy8OG3HfW7OC9CmIGFnO0miv3grZI1Jei49VbC0ake/GH3yN2
 1EO8IjspHxexaKX3iD6T7XFJpGqP/9XNPb7J1jUscd8rxBRQ3Ha16JYfPJeSe9u4C4DY8Fm+w
 e04z+s14ni/vG29+0n8ktjBg9VHc5J2Ht3x/y871vfxEnISGa3MOXHqh7ihReuom9KmhU4aoq
 Sf7O5RhaXzy9KQjqEMZbenarz7s9ki
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

On 06.01.25 15:47, Simon Glass wrote:
> This test was hamstrung in code review so this series is an attempt to
> complete the intended functionality:
>
> - Check memory allocations look correct
> - Check that exit-boot-services removes active-DMA devices
> - Check that the bootflow is still present after testapp finishes
>
> The EFI functionality duplicates bootm_announce_and_cleanup() and still
> uses the defunct board_quiesce_devices() so a nice cleanup would be to
> call the bootm function instead, with suitable modifications. That would
> allow bootstage to work too.
>
> This series is based on sjg/master since the EFI logging was rejected so
> far.

Yes, it was rejected because a solution at the lib/log.c level would be
more generic.

Tom suggested not to send patches that are for private enjoyment to the
mailing list.

Best regards

Heinrich

>
>
> Simon Glass (8):
>    sandbox: Make USB controller as having active DMA
>    efi_loader: Fix display of addresses in log
>    efi_loader: Return the memory map in pointer format
>    efi_loader: Correct bounce-buffer setup
>    efi_loader: Check memory allocations in bootflow_efi test()
>    efi_loader: Update testapp to get memory map correctly
>    efi_loader: Check that the bootflow is not removed by app
>    efi_loader: Test that active-DMA devices are removed
>
>   drivers/usb/host/usb-sandbox.c |  1 +
>   lib/efi_loader/efi_log.c       |  5 +--
>   lib/efi_loader/efi_memory.c    |  9 ++--
>   lib/efi_loader/testapp.c       | 37 ++++++++++++++++
>   test/boot/bootflow.c           | 78 +++++++++++++++++++++++++++++++++-
>   5 files changed, 122 insertions(+), 8 deletions(-)
>

