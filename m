Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727E3103E302
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA36284372;
	Fri, 13 Mar 2026 16:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VJ+fwnpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DDD8843B6; Fri, 13 Mar 2026 16:28:06 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA9B841D5
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b972641eb96so304015366b.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415684; cv=none;
 d=google.com; s=arc-20240605;
 b=ARs7oYYLiKD1tYeLUB0fl6fx+m+mAGIdVXuwb1K/Wxrn0djaz+aH55uXkcGOtMHFDE
 shgX6JtcZOJm/NUBab+6Q4aGZgwgaIX/fktCNfUC2ql8Li5D/DwuvAi000ZdB4aWZV19
 YDe8ZOaUk2887vi5G/NmwxAcTpUabtlAiNaNiuT16UhxQ3dHRkDlKAjcWsAziIQAQIZ8
 8hbGNjzy9Ufp2WDWIwh4e3X6+0lpYprMmp5gMQJqj5gTW5ikEDpZXkIIDPYU2+mXkbxA
 bHA7J0eZPNL2s+MqqwWSZulckuNtOMDSBKO/e/bA12D8ogBjNsFvlW+v+Ff0x7TMWrq7
 aSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VSACx4jJ/Z5HbV0On9H7Xnsrd4Od1MTk0JQ3hbtLbyI=;
 fh=i/PjCYBiRlKWW63tjZF6/rmrG8jlep3Ys0ZEk3jIfZE=;
 b=MMMJdEb95s8Ac4M/IiPHUNrZ9zeZ0G5Sl71IzHyuoXpzzwGScSZInumVvYFlt5NaZj
 E2X+dcd1zbpZchZWUWjdcNtVKnaOxq+x4fo3pWYJXu3Ufc5xMO8ipmWxJa/EMZfYMOzt
 suLaW1j4NOLy0ewzo+h5MeuzaFO3HyowQn2yd50oa7/wkUlISLhq4bMg8CegDL+0rJ+F
 l7gxoSF+vPSt4NDtSwuyhno4MK91Ivkyy5i5MswP49Y+QKvQcWWT9RzRFuuTKFZbbjsX
 Bti1zhhPZCrTKGt/QMGicPtbQpSqLcxgY+6ErHGuXtUd4TZcd0H+hDvATWYB9Lw+Fq+e
 a1aw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415684; x=1774020484;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSACx4jJ/Z5HbV0On9H7Xnsrd4Od1MTk0JQ3hbtLbyI=;
 b=VJ+fwnpHMYVLbjte87NIAdoleWqoewAFFtLLFLtPMOP4hNNXnM8X8HR7ODEv9yPmAS
 e0TK0PdJxImEjd5AzzgZjcLe+Hphuq6Gb6oPAPbRSTR9alBtvNhYPhx8m4LtTNxzVGQA
 Mz+vZGMdIn94CkokEyFH7SWfG5wI2W3s1Cv6XMvK5jNCi6dmRwL+gRNORaC69OCWc3Ll
 +t80KInvpOWXKfPw12m8Ui7f1/eBvSrVHH6+brZWer31IH2oxnnB4lUN/YaEQbikrD2M
 teGSJyYobi/EgUnxF1ZqT3bov8EKE2L38NAFasMWA+IvRR26jJO3qV66yJE41lE9tCqR
 gaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415684; x=1774020484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSACx4jJ/Z5HbV0On9H7Xnsrd4Od1MTk0JQ3hbtLbyI=;
 b=Sv9EBy/sAK4UKwgXPElEeqXMpGI4RH61xJ07RSNsv6RSl+Oqfh9bSFfX8ubh9Oza4C
 EA1pP1FyK+uWSNY4LlXWnx2TrFgDGV3vaaia9Kv1xrqBmL0s2bHRCt5CKGODHQOTh3Nq
 O+PbDkjFT93oRMoNSuG2R7XDRR5/S5ZLNkbZJx37CRN5zj52OgWgqhHav/UD/MJnC/PG
 NWXArX50MsWJE1avqfyZHOcHQhoAI6Cj1nEPo8rCnsvifgGsG1YdXp5hV0lHJSWvBInV
 cAFJUifWwM6APIbNwQo+s9dG39N0Sd64Srouli9oNB9T/0xgnHbjsSkME2x7/d7YiVx0
 NGhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6PJ6JowMcMayJW5bdjV9Wh+ZeUiOkDu9KNf5HDufqvZprlayJOeAZwIIXN4l4WKXB/f4ml6A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywrtkk2VygArPLFPJteYdbuF4fsoESIJXHVspJyF3YChUbbUJet
 k3JlDzHsQUyzPP05COR4TW3ywxDszRVZVNNMBgkgmEnQUATn45OQ881XC18WWJ/dAUHysUj6/yo
 Ltj4cacxYCdJBUHs9MuEJupC5+imOPk5hR7E82PVDJg==
X-Gm-Gg: ATEYQzz3sB99QYa52LvN2Cf9qJqJyZKN/YcqynhazOeOBQBGJ+JnusYUZX0/WM82iJI
 DT88Qa/LL07XuujWevFWECOQRmpZa8oLarf3wH0Yo5SKX/vZ0dwh/T3+tYTzZMFc/6zJT/kmDJ3
 o973wcS0hzrEa4vAr+n7GSHiNUAaoKKZ8YPzHPfjTs9nrveV1pzqPVXRd3IPL3udnQvcXuZd6gx
 ry8siCgMgNf1lq2H2ziqVJoH75J0MMg/BCpjfiM3KlThy0Q/5jIZVt7IFDincPSmWW9R9EyJyRJ
 TNtCB+O+IzNkochG0t0wfoDnERksBZg5HjX6LcoKgMbepLkXsF03M2OuHZnNz5XIqLkTimvfVto
 oUGtsyKWsd9MbmrG7RoLT55BGQA==
X-Received: by 2002:a17:907:d38c:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b976500f9c8mr218894066b.10.1773415683837; Fri, 13 Mar 2026
 08:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
 <20260311173210.GA378499@bill-the-cat>
In-Reply-To: <20260311173210.GA378499@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:27:56 +0100
X-Gm-Features: AaiRm51Syn7vRK8670xUZKgES_LCastIKxRrsr2Ee0kUqOonAtOAnKMtyKxA1nc
Message-ID: <CAEHHSvZsFO9ZiLd89RV2f9-whTO3=a0sChKjWSAW5UeMR1FuQg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add new MediaTek custodians
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
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

Le mer. 11 mars 2026 =C3=A0 18:32, Tom Rini <trini@konsulko.com> a =C3=A9cr=
it :
>
> On Wed, Mar 11, 2026 at 09:52:49AM -0500, David Lechner wrote:
>
> > Add new MediaTek custodians and the new MediaTek custodian's git
> > repository to the MAINTAINERS file.
> >
> > Julien and I have volunteered to act as custodians for MediaTek since
> > we have been actively working on upstreaming MediaTek support for some
> > some time now.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

> --
> Tom
