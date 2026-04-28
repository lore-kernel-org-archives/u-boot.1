Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8601AFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3C383FB5;
	Tue, 28 Apr 2026 16:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ibO6c2mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4687F84119; Tue, 28 Apr 2026 16:47:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9169803C6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1601012666b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387625; cv=none;
 d=google.com; s=arc-20240605;
 b=Nlmi7IWuXGYJBHw5dhSGUMl8Qj1e26ndFw8sXzRmH1/dNXcb2eWuWtWDCOzxLYo0mO
 I9PHrYVEPhz2F1lD5r0WMq8O9EP+6y/U1xkL2ThBxpBa+8MvGxJItBt+WfaFQPd+tObI
 To3fXR2K/rC9l1o2vKcXAMirxX2amBvC11h7xWtnO5szTG0ReW/czciENhXzZksj1QXj
 V28kWicNXLPe6pfT3eLQNfXwcIwDocM/Km+CEuXOt+cUD1T5uDwREW4IGDd9+QWZ6VMu
 wvrWrAC9gSd6kia/3uROCxQF2+ctax2W0mvi/jKbiVz4t6btNVbyjBP7dIgS/3xdNMWe
 zB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RvznvYWJoacBbVib35jpIUH0YYll071i7tN0kbV37PM=;
 fh=aP9sEteZyW2pqLZ+SuigqTzq+kP05wsPvh2O7Px2Eac=;
 b=WS95CoOnt+o70097pTCDdSRh5RLyBke12f1aJmze7noRtWQiOHhOKMET6i3zThwjrb
 LFRYq8DnqCIrpiK6iiqeWLYkT6EqaedB9G71M+M/uIlOPf4HTa5/zxiUGsQnBfSbSoHm
 arHiVg7tODqssZFAfjaWf4LuuGZfaZoBWddXEDmOJtSLa6iTN85gP59fmNssB9UBvvQf
 ScKAHecTH5Q+U6dmwCyn+MTo4tlvRTQDTVvknj4EG5sOOcOMvBIlXLf78b98k7yp3wu9
 iSAhkXYytljz07lTwTxigfBi2m1//Zlh+y4wgPUEsFPeeUHYNUSPHPhr4E2KXOg1gmSY
 vf3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387625; x=1777992425;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvznvYWJoacBbVib35jpIUH0YYll071i7tN0kbV37PM=;
 b=ibO6c2muPaJ2Nf16SL9jRrhWhltQ/M5lrfr4g0gyZZ8a/JQDLSbL6rATe2/2WeSqgi
 tdf12Q0md4aFkqKO19yjYskicCZem14F/PaNdO/+MAT6IdmrHm7rQcZMK2lnBinqzgEU
 WtB50oNKQxvO2eieN5304s1vIBhtgYRihtqRp/tfOp0u8Bfv4L19LMyXRbs3OeCsbrVp
 492Lgj+Ve+IdQ4ZlVMbnFj5c/qy6aDZpTD37Axwanl/GmG/HO7QHmiaR1ZozSqZYBinp
 S+pmhVSh7Yu9xtaUbdoUdl2DXi7rlALOo8meD6yqMWtsnprsojNkDLf89NaJrLRUhmAe
 BMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387625; x=1777992425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvznvYWJoacBbVib35jpIUH0YYll071i7tN0kbV37PM=;
 b=sECHLMRg0CeUKfJ+XhRbCPY6TvPXo4UV628Xw9BIHOwQ5W82LP2i/alomWYL4S4fcm
 zRHbs1Yq14K0AFudGPrPumgJCa1YvuNfPSkNLtW3Dj7NGqRPiEeD13oqa65bWW5REt1J
 ujuJ9uPAHMjXpRJCNrDHvvMxShLY3efRIkSr1omGXYyUlF1Lct/ULuPcVn3ZrfK/dpK+
 PZWAr0ak27RRAwFWPKNXtMNwE9VJT5+m4VuVeFpwVO97f/CKMsqM0ieMmoOnurZTOObG
 RXnUeMM4q+MxBp3Pe43lWzYUV09re9qJ7SUz6k8rr4WOMXvXd40mtqvj74f6IL1J9+Sd
 JFTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o1cVfg+7iI2FVzygDx4Q34VDYRqXZD8uqQi4MPy6GlnuLnFi6q+pN9zSFvm9qpPw1H1RxpLg=@lists.denx.de
X-Gm-Message-State: AOJu0YzabrsP8RuAZHCDzm7F3UxUBv6SQof4Qv3n3hZcJYaTXN5SLExi
 PndFYnik2UwqU4DKhDII/oRzeAp4aqrCl8oLktbglM0nXRTCuKDRap2eINSCk/YwdHlxFYQHMiD
 hyDLbu7gpwgPK9bgf7qQWusP3VClmTVOt4VMPzbnyj5MBZ/v8o/a4wo8=
X-Gm-Gg: AeBDievDzTGWPqXHH6SJebsncve32YqO+mjONXAn/Tnelqdg4K8BC0PdzX4hHYJs05g
 AoqNvZN5MlWn0v0vdRuGaGSOesy+nyL+GaVozCU9aUisQsM3usvSBdrg+biMwRLzNvPJbWH/d5G
 HsWAbC+M6ryk+pw7slIwMEzL4322UXUAGYxWNTwxPWBoJ1p5Nw7QNt8CRKch4HMh9H/hT5Xiweh
 tuxlQptEAWGrtWb7ecdrTDQeJ9zkE73R6nVwbCavlP/XtUBUI82R0zovm43mJiXGCOeRTxWnrPS
 Jx8YMtOFqL0ZR01RadGdKd/YFT5HPIeUOzE82dTkE3hpQRJhE9aO0bX5Sq11qUyFwtD+Wt1JRax
 gi/nf2vIJTX7nhdqLxXUZF3TiS9S+ndF5WCOX
X-Received: by 2002:a17:907:2d2a:b0:ba8:30a6:c35a with SMTP id
 a640c23a62f3a-bb8022c14fbmr212473066b.6.1777387624972; Tue, 28 Apr 2026
 07:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 16:46:50 +0200
X-Gm-Features: AVHnY4LjEgpu-7Am3XsTrwTZUcLlJjItsNLmeM1rAl8ZRVDSblZKZvsCWHlXPnw
Message-ID: <CAEHHSvb7qS0Zv4vXY7w_eV-ztoAugiDkUYi+W5hivh+bErVUpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] power: pmic: mtk-pwrap: add more capability flags
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Macpaul Lin <macpaul.lin@mediatek.com>
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

Le jeu. 9 avr. 2026 =C3=A0 22:31, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> After using the mtk-pwrap driver a bit, we noticed that there were a few
> places where it was writing to registers that were not defined on all
> platforms. The undefined registers are treated as 0, which is the DONE2
> register on the affected platforms. This could cause the DONE2 register
> to have an incorrect value, which could cause Linux to re-initialize the
> PMIC unnecessarily.
>
> To avoid this issue and ensure that we only write to registers that are
> defined on a given platform, we can add some more capability flags to
> conditionally call any register writes that aren't common to all
> platforms.
>
> There are also a couple of other cleanups that we do along the way. And
> in v2, I've picked up Julien's patch to add support for MT8195 and
> rebased on top of this.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Use EOPNOTSUPP.
> - Reorder patches to reduce churn.
> - Added new patch to fix driver description comment.
> - Added new patch to drop chip type enum.
> - Picked up Julien's patches from [1] and rebased on these changes.
> - Link to [1]: https://lore.kernel.org/u-boot/20260317-mt8195-add-ufs-sup=
port-v1-0-7d731ec438ae@baylibre.com/
> - Link to v1: https://patch.msgid.link/20260327-mtk-pmic-fixes-v1-0-ef874=
ca82409@baylibre.com
>
> ---
> David Lechner (6):
>       power: pmic: mtk-pwrap: fix file description
>       power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
>       power: pmic: mtk-pwrap: add init capability flag
>       power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on mt6359
>       power: pmic: mtk-pwrap: remove interrupt related code
>       power: pmic: mtk-pwrap: use pmic compatible to select child info
>
> Julien Stephan (2):
>       power: pmic: mtk-pwrap: use tabs for alignment
>       power: pmic: mtk-pwrap: add MT8195 support
>
>  drivers/power/pmic/mtk-pwrap.c | 115 +++++++++++++++++++++--------------=
------
>  1 file changed, 60 insertions(+), 55 deletions(-)
> ---
> base-commit: 2a1bcefce835b827bbf88a9e112d646c5c4af9c1
> change-id: 20260317-mtk-pmic-fixes-c1523b1b0dad
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Thank  you David for adding my patches on this series

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
