Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4945C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 11:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8AB82CF4;
	Fri, 20 Jun 2025 13:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LscSqLkU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC1382D17; Fri, 20 Jun 2025 13:03:30 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC0782CBB
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 13:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54b10594812so1761267e87.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750417408; x=1751022208; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZuv1X/Mi30wWNeYY2hBrvb9gVhUVwcVkvBDPCeweL0=;
 b=LscSqLkUn5bEc2/reydtdlX+dYLKOXDJHgpnrPiRx1Gda30FVrXxyG+aIV369sCOW9
 /GkkotTskQmvlobVwhyZYItBozlrMYdH/TfrxN6XTXBaoN44e27em+aWZHlbbvG4olj7
 C5ah1+LDLPiKPtI75ch9G7Cj71jPIslrv0rXg/dEMYLXBD++ltrYfQiZD/VWC68p4FXM
 xTE1o6s7aPRU77G+rrJG6bVe572Z29yqX9wzt+XjH36bQ7NIQIavWiiZSTV3TdlQ0J88
 K8x660gok7GVphxbr0MZRWIeFNQVGK77bh7mCWIOhJBY/OEvectSU6z4TPHFQrehDKhE
 5r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750417408; x=1751022208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZuv1X/Mi30wWNeYY2hBrvb9gVhUVwcVkvBDPCeweL0=;
 b=cnT8FHFp7UXkTA4+A67D5Lyhkx0B7WgM8mwYsmtaoMqaGZY61fpBxNbvPHyF1ptsz8
 hPQeMjkKZUEnJDBLxbTYzV/3duviCkhQe15ZLHKtMzuVu7UMdovnxFwQsPveIzCC4o0Q
 NucBGGaq9eVBxqJa2oPvzpr/kyE58siGRTNGOLL/uOcsIYNhEoMeSzY8pLWlSGtcfkFQ
 lMtFrlJpN35sNUnzejQ4p+Wude49DJ/KHmDC3YyOfBZm8mRe6QhNyGc2W2tmacqjPr0w
 f63hl4rZm9ivY9e0heT9MucmILsgmU1cXWi9GBM+JAZasDKo6Pig/b4YoFzzJF1iN8ZT
 by1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrd166ZcT6FYj7cZgMk/vSS/IVYovs+X0N+YG84HzVe7SiF7VM3QXsb+FS6/ogLxgqiwFLtFk=@lists.denx.de
X-Gm-Message-State: AOJu0YxYv/dMFBsmErSi/ou0GOZQBbOSJzXtkOkHLTuscu0xYa25Yv75
 YM11htnFqhgFxmTr01YXBEtEPiMEN7vkhpZ78/PkLPLeNeyyyfOSsrNZMGebQE6gsTyfxAyRFkk
 K4ey/q6LMOvafIwyRVgpx8mb9z+T5sEnX/Q==
X-Gm-Gg: ASbGncsuSbOHFj33eRm5GH1ml80pQbGjLjsLtt0hjt1CUISIVDv2Jg+YVNLbk8FZQvZ
 BfDIrKc18Gf1ZKJaWV+6Lk56Bvco0YrHpyOvmn4PBJ6E3UZHeT7WEaUe2gkMx5R78dXpF4TGs/T
 57eOM00su0JaiROkNYbg7doIv3bzoOfdTNsoP97YVYEHnG7x2Nly1M1isB6cBNTj7JuEyFkpPuy
 zo=
X-Google-Smtp-Source: AGHT+IH7IQxNtqN3csiseDLH+lVHtCTVrJSnKV7NtQ3SWktsgJ9Z/uabt/l6rm3okvK/q8f5SDV8yr59FdNUNYmVKyw=
X-Received: by 2002:a05:6512:108d:b0:549:5866:6489 with SMTP id
 2adb3069b0e04-553e3d10f73mr806678e87.47.1750417407510; Fri, 20 Jun 2025
 04:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
 <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
 <PAXPR04MB9644F6AB9E22A651421A81D3E27CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644F6AB9E22A651421A81D3E27CA@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Jun 2025 08:03:15 -0300
X-Gm-Features: AX0GCFuLr2XGgTVRAwir7bIpA0PzcO_F2OZoHWKEfVTRAwmKvMl-FbB7LMH3TiU
Message-ID: <CAOMZO5C6en20oG6u21RWRh6xcqv3a790hGrwTc_3q4EPXK9vVA@mail.gmail.com>
Subject: Re: [PATCH 0/8] (no cover subject)
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Alice,

On Fri, Jun 20, 2025 at 12:33=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp=
.com> wrote:

> Hi Fabio,
>
> When checking the bug Enric reported, I found that there were some code t=
hat needed to be modified in packing i.MX8QXP/8QM flash.bin.
> Patches for i.MX95 B0 are based on them. So, I made this patch set includ=
ing a bug fix for the issue Enric reported, cleanup for i.MX8QXP
> MEK/i.MX8QM MEK/i.MX95 B0. Should I separate them?

Yes, please separate bug fixes and new features.

As we are at the rc4 phase, I prefer a minimal series to address the
bug fix Enric reported targeting master.

Then you can add the new features/improvements targeting next.

Thanks
