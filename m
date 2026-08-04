Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F33C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30E1D6077E;
	Tue,  4 Aug 2026 13:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPWC0Y1_sgg7; Tue,  4 Aug 2026 13:05:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 426046075E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848759;
	bh=eu8O6Ab3uskVoc/SfbjbqZd3TAewf1BKm6/8xAAK9Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ISEET/v2uj8SFdKZNLDUlRBNoMC6xLDztfPT5JjYNUtONNwWv5aYxwPJCO4HMRENC
	 iooV7E7AhsVlcT4GC48LOaMgT1wzoL+lTIl6vZ6xNHy7awEUMTqG6hfZX8utBb4fbQ
	 6DwiNCxFiTrCCbMrhxNf/YIjMCxAo/lIIypu6BE/W6NKiHBDArWLEqP/HvMjcVHcL3
	 gEtz+0f8a41v//ZmIy2vUlb10Yvhr2aji4NFt1c9E8bv88FuUA6K7e/Nj1Yj5ZfPiZ
	 iz7FqEoQiRIVlfv87wFRJ69inNMfTC0xiUQjSM1ZmaiFFpwVS9lK6TSA3A/J2JCrbk
	 auFx0JnDvsztw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 426046075E;
	Tue,  4 Aug 2026 13:05:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7081C2AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 633EE80C6F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccf18RvixV3a for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:05:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 38AC480C7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38AC480C7C
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38AC480C7C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:57 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a0ed8a10ceso3821593a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848755; cv=none;
 d=google.com; s=arc-20260327;
 b=dVawmyBCJk3MsZHLkS/Tsk6/XTUpDc+3+wJ7nHSc6ou2yGXlxhKE+98loRZIrC4pQK
 PTBsfnF6b+rp5qBTZn+yO5UFV+05ZIfESM2bNmZe43RgBqW5lK4b+UvJEhlHbGR5jKnk
 BkrL7myvW48+OpTKN3+W1ncy9c2CnDgmWRnvEwQrY2NWUFVYJH8gUNd78KpuB/4eszPV
 pPbEYCi6Fad8ag6YGPY5HOf5Vo6s8hD4P0/saxSAWMitOtyoe4iiGNZmRRG+g0+dlemD
 Qx6UvaOc110POdE5c3mHWcJZcR9DM3Ft4KHCGkjgCI+VwCKkJjXVJYNudnCJMViu03Wd
 RRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eu8O6Ab3uskVoc/SfbjbqZd3TAewf1BKm6/8xAAK9Cg=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=JHDQIR45ETuhZENSw5Ax6TfjV3g9oVibHnNn37on5hBF9ImuaIrMx/mtqko1P7dLKW
 GIQa0dMo1g+Ooa45r5USfaXwvO58eyOmn9n/uIse+nivUJAds9Ik+eDPy+JS3p5yh4wG
 wd9mdL/H3q4lTHI05iXmXa5fk86XzQ7ahe7iVy/iZDUpmR8bTtAaSc4AevWxO1Qx6TDO
 JHQJgWKeGLUK67B6F47NWJt8kE1ylHa2xMYkizn2cqe3zlI/W2884y5o8AM4H3lBApeX
 knCpfgD587fJOM//+Tjdt6sUWnBJOy7fGKBWEDmwVWLnkio+gISzFHjzCvbPAKzjhzNy
 c1Rg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848755; x=1786453555;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eu8O6Ab3uskVoc/SfbjbqZd3TAewf1BKm6/8xAAK9Cg=;
 b=YlN4FN3yRREKh0UHm1+EJgodUHKSKkCqDDgPp57+505H1njxlDOqIakNN6Io1H+OIG
 J2P0XqMOhQMH3KUn8qcE2n6mllI9Utx1ZhuIobIL2OtQoBhec8kpfogsfbUO1UvtfYVK
 dHFpYDjJjRBpYtzoMm54QciFzmRbVuLKw8FB8ZAw8XigsSxQbkfjzl8zX5gEdn8MhOoj
 FL5EYs1j1KYi/59DG4h5AU+Shg26qykojI0uHH81aAUIavrKPRuG1oLFBkascj44jmYi
 2p9JNMyZvNP6h40LW2Z6xNdtlBg6yVs26qxcWWOj+0OIQS1oSv0QYFqiPoePUYwrY7Iy
 kk1w==
X-Gm-Message-State: AOJu0YyU48C5mhr5bwi+1+vnOIt/pJnE8tx61dHUjJldW5jGguxIkckq
 rShoXqclh0hnDWtxH7Y+uxhMcLYX+k3l3L9DD5yXgcF7ERQ9EpIDV7MB1Wc2/j08kkMG3P20mbW
 uMMigPuyqfU3YEAvPUGiTMwwkshj1rFkizgm4U5J6
X-Gm-Gg: AR+sD10mNKCWHnYNzPDcpgCwsz16piFCeoGrKKf0t+qjF0shhKBYQx267SouRo7pI5q
 1H6YeldIQUDBeRUTcjM4d21MS5YwoVL7shzhxR/BCdz6bG4wliVXFyJwTvHOaSSOnoi/6YKjfwQ
 BGWPPYCO5JhfRBY11BoxPWfaB3xtQyg3se/Oihnwf40/rBRFZ3bwO07AsCywEXmMTXu98FIgX6R
 sJ24677ZPplN7Y7tBA20ReTnp3PR3Z97C76riadb11FobTECc7dVkPkozXkDPFyUGpGWzQnSCTW
 E0SCTXExvIYFU66h6JYqMwgXrA1m1bJLSOCOmMqnObI=
X-Received: by 2002:a05:6402:a0c4:b0:6a0:6978:bedf with SMTP id
 4fb4d7f45d1cf-6a0a7ce53c9mr13273349a12.19.1785848755233; Tue, 04 Aug 2026
 06:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:37 -0600
X-Gm-Features: AUfX_myl0CBRylJ6sBZjCEmyWHJxzNbIkQI-OGSzIF01Mm2vMysVSMKKy04VJ1A
Message-ID: <CAFLszTgKqjbO=eTb5y3dUa_VGtOYag1RsRkS17vDos3Sx9xwhg@mail.gmail.com>
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848755; x=1786453555;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eu8O6Ab3uskVoc/SfbjbqZd3TAewf1BKm6/8xAAK9Cg=;
 b=oaQmVWJh6KdS2s5G+BN1WUrR9FkJvfjDKR4tJIp0n2r2kG9dFBHGXqNSYJuDTnK/wd
 TWCKe0879ijYavdxjT/NXzGIWAmyPjR/BS5bAu3DwPaoLULKBWP4HeAKKVPOkOG094Ot
 soFuefZ7Z33UtMVnDwUFo/ax5sJ6130CgP3yY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=oaQmVWJh
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

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> disk: part_mac: Fix stack corruption on devices with large blocks
>
> part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
> single-block buffer sized after the descriptor struct:
>
>         ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
>         ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
>
> Both structs are 512 bytes, but every blk_dread() below them asks for one
> block, which transfers desc->blksz bytes. On a device with 4096-byte
> logical blocks that writes 4096 bytes into a 512-byte on-stack buffer and
> corrupts the stack.
>
> part_test_mac() runs on every block device during partition probing, so on
> sandbox with CONFIG_MAC_PARTITION=y this crashes on any access at all to a
> device with large blocks, for instance:
>
>         host bind 0 disk.img 4096
>         part list host 0
>
> Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD(),
> which is what part_efi.c already does for its own block buffers.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> disk/part_mac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
