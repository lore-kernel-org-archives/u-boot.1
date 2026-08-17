Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7040CC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 08:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF60640731;
	Mon, 17 Aug 2026 08:10:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPBLt0X-NMpu; Mon, 17 Aug 2026 08:10:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BC2B40718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786954209;
	bh=BaPXgIspm6teUqerLJGQYzUOVDq9YzdpzTwgYxWSV+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mLhPM8sthCtpH+lFUTGg2KwmxuNBejFhUGUAvGi+vk40sCM1vV0dAPalf0xiAoa3w
	 xpv4fdW8Q+fnnMLmeJcEJFDN047wu9veWMOyJkq2l5n7X12PhEy0dl8ZrxA9wDVT8D
	 gLNlN8ce09EhunyZVPdZaC8/WBRduMjS+OCgIClaTq+x8FdbP36wGc/s+SG/l0RYnj
	 S0vCuYDHu1YMZeecOFYKgKzWTpdemqo9tG3HYf89UVgIHWSAYUux8h0lm92nAGFKFU
	 N8YOzP3cfRlz5YsEaaRIjfnEUPiBOHvoklulSNRTRFKhEwgjXw8IXU6RwkCrLCXV+L
	 Wl4YF6XWLBlag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BC2B40718;
	Mon, 17 Aug 2026 08:10:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC79A237
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C233E6071A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2fNuxn0vc3u for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:10:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2540560717
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2540560717
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SV1RayMK
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2540560717
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:10:04 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so424574166b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 01:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954203; cv=none;
 d=google.com; s=arc-20260327;
 b=rItgxW7IiT86D1k6QnxrdH8QgyvPnPkAos3dvUhDoNDQJfj3VOwCvD1Jm//WAhRW7p
 3LiHJB6aER/gQqAvTOAUMLa+tSs6I1bp6VoTKiKCzCiyJP1KkEZPtjh19nE/vPdgD9e2
 qQunZYSjwXqJdhCl0qA+rgVXq3lON4Gq+y+tDGZXP3WTVYSh4dnwWnCX1dom0rU7Jc3y
 Kx0DiRd0Q1dk9mfxUgWJfb/IhfL9bGySPiScBdqL9q9v2fDKth1IfM/xqQKav52+W96n
 TwSQeSo5UcvFcnImEDroXGJzNEflfDDpGENsi+pBbkj+C4p4uYb4DbMLorortKJggukN
 eY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BaPXgIspm6teUqerLJGQYzUOVDq9YzdpzTwgYxWSV+0=;
 fh=7s8K/7dVGZAIgnkUG2KFD/JqpkpCOzy/HfXEJLYw4qQ=;
 b=BSOFQ4OgpdBSg8uGzkyhjGIeVe0yEUnc0lBNObqNGkwePANR0bIS6f4IQnwlElwY0c
 AuFov32PAZUe7ojlcG+QL/calo5PUolaVAfqpdUSyf256v/wvkwmiFdfto3qqnHOmU85
 nsc2xOju11MqxuFzzRQaunoUFMsRlDWDDl1iDPCs2QzRUDl2tq1ofUHFvJDCltWBCbAr
 Zuu0G9zFCK9SrlTRVWaNMedsj5nZG3dYmyqeysjuXMVqIdYLabzCjHfxMkpUdOROHP56
 kvhBMO66jJqqsZg73JrGQYXAf0St3yBI3B8bTlvYqcwx0JLBUvJNlD7BdpwaiehoukFe
 ihlw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786954203; x=1787559003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BaPXgIspm6teUqerLJGQYzUOVDq9YzdpzTwgYxWSV+0=;
 b=SV1RayMKR9RefZI5jb91adwjWke3SwDVjBR/M5b9I0wREYvrtChYGZPzI73ASDAwc4
 lb+bLqNbuYD7VGQZc+K9kx0JH9x8bKtkK+6fNC1OhBU4P74Ix+DLWOhtIxUYXEEpVjBT
 OuwfqklITn+EBInVTOjaAOtEudVikuejIW/kU2L9z9+Nh5kcKAv5dSDOY64gki/fHro0
 pDkm6QSdAgtoJbtVMkusdjmrs0PlRYM9Cqs577ct4tZtgJamL7h/RYmtllBtRAhdaoNS
 UTs+u+OtDtopx5+tv/U7+pUzLNwDmHfykapWxWarKI2EufMY5P3ciWbCpUS5DZwlzrbF
 V2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786954203; x=1787559003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BaPXgIspm6teUqerLJGQYzUOVDq9YzdpzTwgYxWSV+0=;
 b=RjHLkobRmiO2UhRO6GY7jBBDhdX9OaI5k4husbxkv3LyPTmQHab8khIgUeuymoQ18C
 YNuuq1Zm++AheoLUc7coE5lGEfNURkjvoWyZhZnB2IT1ZlrMoAbDkHI8MjY6cVk5Lk+y
 GFfsnFIE8pRpFgZVAoZsgTK4QDGdN5vOCaY0N/ycCBS+SCacvnFxyAgq/AmLN+8Uc3dt
 IKbVWdxWdVrYRIuP8MLQ9wNiiBJsnEWmTf/yBisJCAtFNuvg3WrZqgOc7A6XudPoHYyI
 +lFVLi+/3gWvih6DYw6pEFQ/DY8Ygbam5WTMGgMGbF+FjCsXHTQB0Tc1e0T4HN07Vo1f
 cMdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzZhlfqh+okLJPdFduItnlrLE2eM7uLzsKRu02nSPD8dkWAHrBkYhK9wGOMoU1QP/8/nggWcI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxdCbbfhngxLOYaps67ral1DYCPN87VZLz9YV2I/gisvfqP+/kY
 +9sOjKI/9dZH4prsQM89zpjavgC+lXUklCvtwJQz2S2EU9Ob7/dFeE4ZsyMTDa/1vC3Td/LK0+L
 xIuNUhiKM1vcZXxLXifYpt3564Q+M/lvY3VkmeEnLXg==
X-Gm-Gg: AR+sD13Ss0QH8iu0yFMuUxUHY+xvsHCMs8l+r40DLPoXFuk/knbPQfVI7loI0RrbBy1
 C7+/q8kp6qcE9uX5J4zkeLzzlIlIc2GpfQMcDRYMLSxzu28qqG8RtBrV5UDFtubjN6YpXVzo8Tv
 xA9f5l+HLGZtDqSGGMa+tDQReuI7CqqPFtVt2SwbQufqCBSrtDzuHLUJOiKwR89tYdZX2+Jah/l
 v1dlcxDPhrRSKOau8icCPetyVrTXopm1y5nIUHRJEUDxjWV/J0vnShxBPmCgEiq2UpaBZNayeBA
 w24RM19tdeRo1oJY4W8MHWdkQ5LUQOmwaR/FV3NvYe4udO4kGjTvege6S6QeVri0nDZP+a3A8M7
 2EZ727vRCOTEkzalfGLP4+dVQS+hbE9XHVD9+7ju9gkxSYc/r74rxKJ6vYqGZI6R3blhVi2fOq4
 xf
X-Received: by 2002:a17:906:ee8a:b0:c12:1651:17b2 with SMTP id
 a640c23a62f3a-c212a1ff265mr972570666b.9.1786954202674; Mon, 17 Aug 2026
 01:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260813-mtk-mt8188-drop-tphy-compat-v1-1-9e28ce95ed75@baylibre.com>
In-Reply-To: <20260813-mtk-mt8188-drop-tphy-compat-v1-1-9e28ce95ed75@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 17 Aug 2026 10:09:54 +0200
X-Gm-Features: AcwNN1X5bo3dRf7RJ5epG4G3dOi0iMuDXhTPi35HhMmiE8rQd5if2oPd_KQ6sZ8
Message-ID: <CAEHHSvbuMKB_JdZv9jTjs_uWg4DhkU1Ex5vex-3S66nXTWEXAQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: mediatek: remove mt8188 tphy fallback
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le jeu. 13 ao=C3=BBt 2026 =C3=A0 18:22, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Now that tphy-v3 support is added to the corresponding U-Boot driver, we
> no longer need the hack to fall back to tphy-v2 for mt8188.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This depends on [1] and will likely conflict with other patches we have
> out on the mailing list. We'll see what lands first and fix the
> conflicts as needed.
>
> [1]: https://lore.kernel.org/all/20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@b=
aylibre.com/
> ---
>  arch/arm/dts/mt8188-u-boot.dtsi | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot=
.dtsi
> deleted file mode 100644
> index 6d1b2ab82da..00000000000
> --- a/arch/arm/dts/mt8188-u-boot.dtsi
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> -/*
> - * Copyright (c) 2025 Baylibre SAS.
> - * Author: Julien Masson <jmasson@baylibre.com>
> - */
> -
> -&u3phy0 {
> -       compatible =3D "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3"=
,
> -                    "mediatek,generic-tphy-v2";
> -};
>
> ---
> base-commit: 5a92645e1f9020d24d19e03fff2ae63f30080770
> change-id: 20260813-mtk-mt8188-drop-tphy-compat-bacaf973ae92
> prerequisite-patch-id: dd1ae5daecb5d7b3fdab8651c31b58cb4971dcf6
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>


Reviewed-by: Julien Stephan <jstephan@baylibre.com>
