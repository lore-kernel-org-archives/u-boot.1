Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6BF532F6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 08:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1874E80212;
	Tue, 24 Mar 2026 09:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZmEXQteH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B0D80517; Tue, 24 Mar 2026 09:52:19 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767F380087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 09:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso133195966b.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 01:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774342337; cv=none;
 d=google.com; s=arc-20240605;
 b=N1TVVsh8a27TrIb5yNTfykm550GxRUPENtAiFjskjmKwZlNOT3VBHlMVpTFD1p8QGU
 gnXSNdBo+xX0OfDTWJ7CcjkNqFCgMzHdh6NS2xC8b4AGNpKv/m8uMIDe9Z8Xj2bIaPsu
 uaiVGnBmLe5GKqdwzrPB/81dd8TaP+t3X5jGo7tHfw/Q0OfE3ye9z4BB9cnLfhznGUfn
 1PmKj5fBFANfO6it+XfIhcfwsRj0jgaHy8c2GNBH9FdkZag6v/upxysHOZaHx3hX2TNa
 KXuC8n9c9FyUObNTlDgxkF2oMxsigBRJ0lfcp9LSe5+d8lqo1852MOa4SvwLQMW1xySq
 EBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xrpRrOYJ9qaYKD8T8VBQI4Rxy71XO2djd3rYW+HXJDg=;
 fh=y516F1kj/cMFqE82c9KGhMLVkEHYD/k8z9fDE+hE3Ag=;
 b=dytJZ05ukXf7EW8u+rCUvmD3xd8K0hLJhVVsnE5kIKyfQ/MLDZvBNH2wf9xb2nwsBF
 tKdtjl2FNHTrPzPGkpsz+LnbXoSMt6dSd2SZzfkwYeKebcHxfJ4mxclN3OTV7M9U/MID
 eE9pnT5qMsCMyUhgyMc0Tc3x40Ton8utJrO7hPg+9qrBDymWLNiVlS6GNhTDEJjQt7gM
 K86/fiJ/YGYC1ie5RfJYAwERze2/l68azWNHzdDo79NQY3b1D6MB4A6IGlWPL0Nku7sI
 Wxx3zzYUImwvBOB4ikyzg3HY9af2In1dT5+fRGUFpq/JxA82Pjl20lQiRoh8GWh0OFm1
 CmSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342337; x=1774947137;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrpRrOYJ9qaYKD8T8VBQI4Rxy71XO2djd3rYW+HXJDg=;
 b=ZmEXQteHeXAp0y7B6s3R8DY7X94M6VDfschEGK3Rttd1v6ZSoyn3DbVW4VRLtxYo7R
 2/iD9NqAsQSPMt3vFGlGfy+Db7XdMQ64Ekgcr7NLQQlnqyDkESeU5tzkBWW44bpHTS6+
 ltZwfX14WnQemi/MDFgdwTjFvYfE3jSUrHJTL7OC9Ra1R3C10AfnqX31ymxNE8Sq/+RC
 /PtQitOXY8ZD/wkYs468bmUEglsDyPgwDIt+PZ11EGZGHh659cxuDuY04c6fhUUMQDnC
 XiWlLhyyVMSSb4c8hxpCEwYq6JBqSOXPLgIoeFhdz+s8PBgIqWJQFfV19CXy2VtTXpP0
 1REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774342337; x=1774947137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xrpRrOYJ9qaYKD8T8VBQI4Rxy71XO2djd3rYW+HXJDg=;
 b=UX76hvz5Qx/Kryc85YgOUEQQ8k17rQ+BGT1Yi+u9arLDdUZKR+/RXZbmBSN9AXZ/oR
 FzdrJozy34hlPGXQShThbHSJH6TqpMWzuRXLqEpexeW1fmVcZjlStz/Hk3xhQIVFtBJL
 YnwBCDMlRF+sMkTUMpby+eTwJ3IVaIz2zvQaG3WpgFT1GeaVIVSY6ItyfsYUGiuT/mtU
 hRcKPRPIjZwTmzM4XK+mdbXSx3PDMg5DBirtManm5xHmaN+WbuFBY0EYUB5LpD0sp4t+
 RaT3F7e1bcA9uJEbM4JukdmBRAEx/sblvzkYyoCvS0aUjmrIlQxu83faZEyJ1zpjA9RB
 z9FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbO4fwouJ5wUOw/NkyAcDfXoWaz3MYIQG4UuNqrPKiIwmOwJ1TmurGGpsEjdIlIKhJ+KtdUE=@lists.denx.de
X-Gm-Message-State: AOJu0YxO/jG1GKuIuZFZL48q/Ys0XWiULhXNhjt3GcOo9xEP9jV9QOJJ
 drX5s5w4gt8fxAfqVOhbW/1tvWEpNtoJmb0XDhwazwDXFiOtM7Ou+7MKRVDrm1lShJvs3eg4mB4
 ewpWqSbgM+SgsN6p0+wjsWjX3SPI/S0oG2jztIZfX4w==
X-Gm-Gg: ATEYQzwkJqgO+xkZuoHS5RI2cY3Me5wZyMOtfLeee98sZPetV92tQo8q2Ztr8X13Chq
 gM9IHq7XTKjS5sVv9sUqt9O6rKxGHRMiUSkEKQSfHCJdiwpOQ5lQ9Eqe/5M5WuTJGb/6oywDeiP
 um7bD4uvXPUqoaCm0lv8V/Wbz8vN7Xw89THgldvZ9yq11c14D0E6+caC4G3ORbWYi/rD84h9U2S
 FDy33MsfpHsxsbbyg4egef3AAylgwZTu9kieDGMfyYppIlLscMCqmasq99xDwiv+1KjrfPE8GEO
 BEG3P5g5ua+e0iVIjmnc1mgA18Mb7r0LrSLO0pAUWuG17YFfFPzWFMazxvVAlt8EQjbEigqMhHg
 7QGVgHSpQ2Tk+ouy27Lu+vns2Rw==
X-Received: by 2002:a17:907:1c0d:b0:b98:82c9:d1ba with SMTP id
 a640c23a62f3a-b9882c9d29emr223025766b.1.1774342336308; Tue, 24 Mar 2026
 01:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
In-Reply-To: <20260317-clk-mtk-unify-mux-parents-v3-0-a4760f5b0a80@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 24 Mar 2026 09:52:10 +0100
X-Gm-Features: AaiRm53qrSZj2jgxlOI0VtPsELutEnQA0i1Ejrjf6fjR7jGFDLHe8WOX7tDywEE
Message-ID: <CAEHHSvZT1w2VzaYW=e7x00b-kJoMbkwpxF4K0h6MZVr48nML3w@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] clk: mediatek: unify mux clocks
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le mer. 18 mars 2026 =C3=A0 00:26, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> The MediaTek clock driver currently have two ways to indicate the parent
> tree that contains the parent clock. This adds to code complexity and
> makes it more difficult to know the "right thing" to do in new drivers.
>
> The plan here is to convert all mux clocks to use the more robust option
> of using struct mtk_parent to specify parent clocks.
>
> The conversion to the static const struct mtk_parent arrays was done
> by script to minimize the chance of error (and save time).
>
> After the conversion, we can drop two of the clock flags that are no
> longer used and remove the dead code.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v3:
> - Picked up similar patches from another series [1] and updated commit
>   messages to match to this series.
> - Squashed the mt7622 patch into the one from the other series.
> - Link to v2: https://patch.msgid.link/20260309-clk-mtk-unify-mux-parents=
-v2-0-b084ea74b99d@baylibre.com
>
> [1]: https://lore.kernel.org/u-boot/20260306-clk-mtk-remove-clk-bypass-xt=
al-flag-v2-0-b253b49f17b2@baylibre.com/
>
> Changes in v2:
> - Rebased on updated dependencies.
> - Link to v1: https://lore.kernel.org/r/20260302-clk-mtk-unify-mux-parent=
s-v1-0-32f45085f4d0@baylibre.com
>
> ---
> David Lechner (16):
>       clk: mediatek: mt7622: convert to struct mtk_parent
>       clk: mediatek: mt7623: convert to struct mtk_parent
>       clk: mediatek: mt7629: convert to struct mtk_parent
>       clk: mediatek: mt7981: convert to struct mtk_parent
>       clk: mediatek: mt7987: convert to struct mtk_parent
>       clk: mediatek: mt7988: convert to struct mtk_parent
>       clk: mediatek: mt8183: convert to struct mtk_parent
>       clk: mediatek: mt8188: convert to struct mtk_parent
>       clk: mediatek: mt8195: convert to struct mtk_parent
>       clk: mediatek: mt8365: convert to struct mtk_parent
>       clk: mediatek: mt8512: convert to struct mtk_parent
>       clk: mediatek: mt8516: convert to struct mtk_parent
>       clk: mediatek: mt8518: convert to struct mtk_parent
>       clk: mediatek: remove use of CLK_BYPASS_XTAL flag
>       clk: mediatek: remove CLK_PARENT_MIXED flag
>       clk: mediatek: refactor duplicate *_mux_get_rate()
>
>  drivers/clk/mediatek/clk-mt7622.c |  288 +++--
>  drivers/clk/mediatek/clk-mt7623.c |  649 ++++++------
>  drivers/clk/mediatek/clk-mt7629.c |  371 ++++---
>  drivers/clk/mediatek/clk-mt7981.c |  233 +++--
>  drivers/clk/mediatek/clk-mt7986.c |   12 +-
>  drivers/clk/mediatek/clk-mt7987.c |   78 +-
>  drivers/clk/mediatek/clk-mt7988.c |   82 +-
>  drivers/clk/mediatek/clk-mt8183.c |  584 +++++------
>  drivers/clk/mediatek/clk-mt8188.c | 1522 +++++++++++++--------------
>  drivers/clk/mediatek/clk-mt8189.c |   12 +-
>  drivers/clk/mediatek/clk-mt8195.c | 1349 ++++++++++++------------
>  drivers/clk/mediatek/clk-mt8365.c |  450 ++++----
>  drivers/clk/mediatek/clk-mt8512.c |  620 +++++------
>  drivers/clk/mediatek/clk-mt8516.c |  704 ++++++-------
>  drivers/clk/mediatek/clk-mt8518.c | 2088 ++++++++++++++++++-------------=
------
>  drivers/clk/mediatek/clk-mtk.c    |  112 +-
>  drivers/clk/mediatek/clk-mtk.h    |   69 +-
>  17 files changed, 4611 insertions(+), 4612 deletions(-)
> ---
> base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
> change-id: 20260302-clk-mtk-unify-mux-parents-1bf35aeabf00
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
