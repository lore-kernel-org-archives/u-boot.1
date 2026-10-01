Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7A4CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 861C560D74;
	Thu,  1 Oct 2026 16:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RX-PoBUD-0EX; Thu,  1 Oct 2026 16:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADC9660D76
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870579;
	b=j7t0ymNWE0IGpLkIts90afFnRBOmSNCV5mr7tbBMuyeN4cB0YHsvfbbxmymykt2bYAl5
	 vZMTaVcltL8cYZjEJTfD/MY/uyw9jGmInWmDQhEFMC7ALhOeAPMDOB3sz7v7GvDlVkm5L
	 pAp7TDdQOBnv1L/b2j/0Rmh/X0KCdOd3QApB6bVqr7dCa9B2tJU6FAjwKLssWCoXQAeTO
	 0Q64gY3HXCQLsyeNgoCTi++fl5rLesekW+gDoIdnkdf3UDwNMH2A7fokVB4AQpNhUwJRz
	 9y4bek0r/hiKb8Nki8ylC4xpq8c06K7ZsSX6nKICI+gwH4vEtVCiQ0CVDRph7OhRvVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
	b=gbzh4DclwLMBGrGs5VH49ZuBgCG1ECpCBO1gAbiO3dbzY8iA/WE7mB7MMcnwb11252MS
	 25XsL+RyMY9goBRRpJRfkL5ZmkBqHaF/psgHKi6KDmzUITw+fnyCRixLQfGqRa0vcPYLk
	 U/lkn23Rd6a9wlfG3xDOFFRLh2cIz9EJWl8hwHGmv0YPnlbX9o7D6c09Qr/zSFH1imHSE
	 gvEiB03h22ZsfQBFBeI3fuAUDKyiI6NABsZ77RNI5GPF0mkAk1ZfI7ZFIdyCTsvD0fdgJ
	 j3JY6GfsHa7sc/FGF3nVEPPlP/g5pcK46qm5j4+0r5RPvOUatLJFTP6QicYeHHTFXPA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Wk85vkCJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870579;
	bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifxUWu5pUw9BCue0WEc4mnXwV+BbqiOr7HwdTIxRtueVswpWKRm1uQQxLbTRK2sf/
	 TZ3r9kZYeXa7wi2Bg36i667i9fhC6ZIdFYQpTDIitmrAtEzEK02PwtdaYOdmNu/LRY
	 DuMBLNPioAwz1GgpPLTVmOx207eZo7A6Nv832ab9IOIs+GvnkaFo2dxDKZt66+9q8f
	 OXL6WUGo1qmSqIv1hB+xBZHMtXhveRdPIyfNX4+QrFZ9UGuA3gV8EwYGLzz5OMbaUw
	 uALcTnZi7KyuKpdzPVWr5RLeTBMpO47qQ0uv8pl/k/u5zD95SIsKGXWJbgHxjq1+UY
	 wO9qYwKlhNgtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC9660D76;
	Thu,  1 Oct 2026 16:02:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76AC71A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C93A607F2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFV0uG4jTo6o for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:02:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6354A60D74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870576;
 b=r09H4D5QYgO3tJPQ/l9PHPTuqVEwxKzHZMVuG45Dk3Xg42uucrvATUewvXR/HR4wClvp
 1yTmhyuTpHE3yaF8qcPHgtQBpeYE8wtgRiZ09h20aTPOMsXwKOrLk1kujBDU28jj0bZR9
 P6Zxhi2Z8F+Vg/lJZ4N/KnJcHAg6ED8Zqpors5aP0H3LoNvWsa7FCGE0RRdLTLMw2qva0
 NaVculsiZLJzDm0YaM/PugLYFGjyOA0L67gtR2iB0DIgvtdeBGw0teRiB4vQUJ0yKvcrz
 NxX1DAnjr9GcHvrLPgyDUFvlNMXjI+DjqorKIC/dwTzjZ7VMe/X417x8sBtpN7ayVgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
 b=AyB6DMtgld5G4cwSOf4xz8YMNG4Q9k9WFQ3wrfs2O3eLYXhn3ljOPCq+Ea0NHDrcD6ez
 mckvhvn9cUh0B8gFrnUnJFjZ7u+gY8idQO67PBEVPehqfBiw7ORzDQK6iv7AnYZntuXBG
 U8E9vlcSsHKD7D1CiVOEYaLATGZnQkMRmZXqze/GFsW/HUvxyoZIGZJFVzzsvWIzLbeF/
 H5UBrNPzZVMWvFYfVe+GHx/NRfCRebmivp81kb83nPKUmK2Cm+8a4O80cvWoaEuDvn1zA
 EsVxYXYSahYtjFi7gZYKLzu/n27ypEMGBD9QVLznCaGQHE9v03NA/tbSDrJkGzLgwzw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Wk85vkCJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Wk85vkCJ
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6354A60D74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:55 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29703cb470so1027016566b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870573; cv=none;
 d=google.com; s=arc-20260327;
 b=LqHyhys8fk3Di//AD3/MS8SI+dUlCVom5EV//PT2UfDmsVsR/j7o/t9dNn6EmT+IDl
 TmLVTaFFq5eyNBhnS7XnOpB/B8LSOyKdPijoE81akIIU4yyHKjJzKrycS/gP+dQBuylK
 DYOTB8RBrhsehp0Y4J+Ag3jaTf2+w+Xb3+Y4DvSI9LlkwmiWl6R2PnS+3lMnK+o66Wjs
 c2Ti1A5tCP2l7zEGAP40dHCac47AgprAim9o0qaYguclzIjgZnImo4VFiQwozXsjEnR+
 0ZyHGp/x1DXbhh9L5xOvNyEGyR+L8q5lYas/bh+lozjkC9QlehkT2L8xbTiau9bopelq
 gXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
 fh=/8yMEM7RjVDzN88CMm9KZ7qK4j3VjmzN34tYMnPAisQ=;
 b=lOzzBrgHi2nsE9p6WrZEQS+055ZEKUF+Qi8VoeqHKPZlmE5Tmnbp2SYSNondq3Da3U
 kobHiaBMeLnX8TplglaTveRytcQGwu1hmIXawnSXQx9uOJjI6HDJey3iN35hvm1VTVLs
 teKYdESFh9wXycZqEfKmxQtx6F7z4Y7rsh7RyF0KHPtbc/pnU6O/knv8r/NoaVYiKbNH
 MNTx8MJLVXe80hw2BC3MMYuN2JwK43JrCNm/yfPtkXIj1drnUZ48jEOOaG0mkw2/kRH8
 IaTG7uv4gDTtxYxw38vYGPwIRQwn+P41hcgNTOfoAzaZabSHrHc6t4RX/FibjlBmTgbO
 WTUw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870573; x=1791475373;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
 b=Wk85vkCJeGhH889FVD7od98kKhTmkAXSnUCphJMax2U/x6B1pAQdkYKuioOIp4ambS
 cF0Wi2G0oI3yLayG/lXI0z4BpH6ChaOdlyScBLjfYPQ6WlEhF77Bdo+Ga8+A+KYGDyYu
 jCYlFVlQroOqssRIMnFV/renti9nEilRwlNL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870573; x=1791475373;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9REoB8wZHXLHrsqFmi/ZHMacSwl2GXxiT9tEDJx18Mg=;
 b=lRTbdhnt7LeGlAlQtEcGCTcsGkKK6kHMfTq99x7kKJBSRbpVDyMFmAPytE++9eB4En
 77kRkAztjUSlT91vRPPpsD2xfDIqu14yqpYa7T7pKOOG3ZiopF3usz/YTsWuj8xnGkgH
 d5y/9Y7573Or0DQJNt7Fxjl9OvjY428aY8HjRGXkDYD8SOS2ygbVu1OukoZS23nPyJRf
 lzF/O9OHcv4gAUafRZ9MXWBKB1588hr1dBzvxe397ZjKYQU688KTsQXd7TzzoPr8ABjx
 6fmVWWGXuaMf1FJtPE4yLzW7btcfLzF5GlH+b+SnGx45Nl/3MpHP9a0hpBjcOtIJYU/7
 UpPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCcrhM3javSUg/ELrN61oEFLIENLzey2u7EOpwgCJ9HUN5PSrnCRPlgX1Ms7LxhTua3taVvkc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++loIUZ6mONLPkJv4J/0vB9XqWxIlvboy12fqmxFL12lhwJL3EMf
 hgOL1GikW0LgLsin0jGpKtcabS9lOuKWTep9sEfim6LJIcPDwz6p4iH11+SQS3xo+ByPbNPRAI4
 UCdAEP1vfDiIckT0Oq10qpF1raO9luzyTqPvtl4IY
X-Gm-Gg: AYBFou0Bl4VNFG5LuArsjI5QEjpjKGXbfaRn6FPNcsckaSN0pgcCPOoRimvFWyP6uo1
 aJuGz0gQScdyZOcPqw/EJX164WeITj/8L82Uks46jAuyvccaM29S6t3zz1uyeW+FrYC5kTSDi1T
 t7QSx5bJIiTxOQT2WaiUgoMoywtD8FV6uL5AoaKO6I78q/t5Evk4rAIhjV5MiRjFHiPNbFGDSac
 QhXreI/EG66E1ckZPqUZp4XNkw5FQwNjLJ7YFJ7ckYA4H5kBFces7HGjTCHkyeXfD+trQXroEgx
 ujT3y32oR6kbdVZBoqgPHk8UlKDYByGNl9YuvPZzMWP4J6m7PRLWDPVc
X-Received: by 2002:a17:907:3f87:b0:c2e:1f89:df5 with SMTP id
 a640c23a62f3a-c2e4ade3182mr2603266b.29.1790870573520; Thu, 01 Oct 2026
 09:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <65e01a6d030b93716174a0536d7a0c6b8edf1aca.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <65e01a6d030b93716174a0536d7a0c6b8edf1aca.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:02:40 +0100
X-Gm-Features: AclHuK-14O_iPwU23m97CHreYxR_3iKKJX2b9EEcvPLQIfuiHLwTrTafiHgnAn8
Message-ID: <CAFLszTjG=tBTwOwPDUE+5ZhC8wxJwT9Th83VzaJVj4P4wFM8Ow@mail.gmail.com>
Subject: Re: [PATCH 08/11] boot: fit: keep the load message for RAM-backed
 images
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: keep the load message for RAM-backed images
>
> The "Loading ... from ... to ..." line is suppressed whenever
> CONFIG_IMAGEMAP is built in and the source happens to equal the load
> address. The test is a build-time one, so a board that enables imagemap
> but boots a FIT from RAM loses the line as well.
>
> Suppress it only when an imagemap is actually in use, which is the one
> case where the data was read straight to its load address and there is
> no copy to report.
>
> Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/image-fit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2468,7 +2468,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> -             if (!CONFIG_IS_ENABLED(IMAGEMAP) || data != load)
> +             /* A storage-backed image was read straight to its load address */
> +             if (!images->imagemap || data != load)

Dropping the CONFIG_IS_ENABLED(IMAGEMAP) term means images->imagemap
is read at runtime even when imagemap is not built, which isn't safe
for every caller. spl_load_fit_image() declares 'struct bootm_headers
images' on the stack and only sets 'verify', so in SPL (there is no
SPL_IMAGEMAP, so the old expression was always true) this now tests
uninitialised stack memory, and the message can disappear at random
when data == load. The storage check further up keeps the build-time
guard in front of the pointer test. Please can you do the same here:

    if (!CONFIG_IS_ENABLED(IMAGEMAP) || !images->imagemap || data != load)

That keeps the runtime fix for RAM-backed boots with imagemap enabled,
and lets the compiler drop the test when it is disabled. Separately,
it would be worth zeroing 'images' in spl_load_fit_image() as
vbe_common.c does, but that belongs in its own patch.

Regards,
Simon
