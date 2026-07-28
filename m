Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA89C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 15:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 930048126B;
	Tue, 28 Jul 2026 15:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id is1nkGtooPjy; Tue, 28 Jul 2026 15:09:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4A3D8127B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785251370;
	bh=tmD3rSHQFilYeUk0vugCYpHGLzXFgiOr2R0pVRDetX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HNaaSymrGdUo20rYrZWzQ+3akt5qGPNoE3gHFXs3phrMYQZdNgQNImOhT+e1W3CbR
	 rnpI7CveJBsV8L19FETILM13t6eLfA7lm0yTjVuHbarBB7nd5OJ2e6DCapqaLAXnVG
	 DmotQnljZWQ1TS7w1xl0t3B5MoHXDuyntM62bS3jk9yw/Ww6lT5FzVcvMHA5wBBbT/
	 LL6U/W4NNyFcL4qmAQB0jIom475wdNM0+mT5ey90E4p2/Mh95T9o9JoG3LPte58LWF
	 1stNyqk4d3jghPofejpgB2/RXZB2t1ZFCrEQ6FnS7pc3QC7RA2VRQQmDrSrc3bj0pF
	 46dKeOTSfTm0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A3D8127B;
	Tue, 28 Jul 2026 15:09:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B003490
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60E938127B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyBj8Q5cbLzr for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 15:09:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A55E8126B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A55E8126B
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A55E8126B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:09:27 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c167bda216fso570507166b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785251366; cv=none;
 d=google.com; s=arc-20260327;
 b=iHAPcsUvenIRcQlYg6c/9O/qaCWm2OW6+nDF7sKuKLVoaPMDUM9MWfwKbbjI+Ks78W
 yZTvMUzM905N5WSR+6LVQLVgl9QFnV2dh3d/u0IlBHkttM+P7udbqRIhU5LAYQzGb6VO
 Lhb2iEcJaEvpuKQdo170xOHohb3AaH2Dt//hOmgf3aL4JtgReLynGiIwGPRVRUpt8MB/
 IUer3gMdA0x8GF5NhZsKnQljwRu0lu/fkock696uaEVW/elqPqU0QbU4By9ixP97wP2y
 MIY/oSKLp5VJS7e/u6dF0p3A/H62A5TcRKvoMgYMGwuzW6E0NAPWW+2R9Ppoj7OgzpuQ
 koaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tmD3rSHQFilYeUk0vugCYpHGLzXFgiOr2R0pVRDetX0=;
 fh=y9NiEHPo2YNK7qj9/zGFfw/AcF/F3XeWFzgJrUaNwmg=;
 b=SKGN315tg3VCSOvYxUJiO8TXutDRYYDI0RVjc2fxX7MxdzJee4+5uHE4SAlt70rghO
 cEzafxdhP1M37n4vA0gcNcmnHo4Pb7CiR9nYddUxDBsewW4n0H/OrHussGBKJ9u7Rgd1
 zCwybGj4Ak282wYWnfXVBdx6xrsl2x0Tk/uq6ykZ3U/q+uWLmrhs3OhMs9EsCgFN23l8
 vKQElMK8xYCxpQnzncSjKM3JtqIL4VivloiDMqUHhdz0b7flXRJNyJjfuJLh94NDPlOn
 376WasFuCfiktYnah9/kPwaJTtMX0lCrhHTBFpCUovHPMVIYfs/G2C657uopbIesYpAE
 w5/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251366; x=1785856166;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tmD3rSHQFilYeUk0vugCYpHGLzXFgiOr2R0pVRDetX0=;
 b=jrg2AYYZTjCJ2DxPbVVZMZhjTdB7N3cD/zjKQuTYiyq1nBhhK/mKUcsA2UzkP/xsgk
 tPaz1BZJuv12yZGuT3P50eFuQoBAoo8Y+kMu2NaWVb0UPbzubrSqRhUb5MgiswJwvk4+
 AVqvFTP+eQf6LMfcMkjuemtxr/NlxhfpleMfGLiiBrtFRnya78EmPokZmFWD4Lf3xpUG
 q0/o8nWVakZOl/HpJQ5xIZHWNloX1y46OXJISIIBkohvDzYMJLDrfPevIRbia0uO4a+Q
 HdkkqFZ1KjvvClqmVnzOiZJwaELIBHsgM8e+OVyFvtv7Pyws3JPay/n048Ox9Mlp8ad5
 SUfw==
X-Gm-Message-State: AOJu0Yze8ZXSpFlXZC+Yz89ts4pHfRLE3htHnIGgX3viqf+VyV5n9/Z7
 w6xi5CG8j1OMwIRflLES859Lx5n8zOjsQngRtT8z+u6sg5fDTmCtS+klAACmFVEQQF745mOctAN
 KVHUA7diyjcPp5qCSzOG/29CzVOFvPOnSo6PCmaGhBA==
X-Gm-Gg: AR+sD10LEEnNeM8GWzVfpAsJFbpSgnO3hoC61H27/IPY+t4LpSyNipWwGrFm3h9IrM4
 FvjMSz6+xgm0i4dZxPRH9eKzpZQ2YerZTXdmZ/hZIwNyugB6/D/tjJqn0NO7BHkXUCHxKL3j5Qx
 6IFiTtdXVexboCpi48KhXvYzTrCl6V1zeFaHs1oFiHiPD4qHFOGDFlpjoNgpeBdK/DwNV2ZmauW
 G1Axlz/XWH+DGxOWS3L11hXC+Nn27BuUQYjCPT4aqGS50up+eMpxl9k928Vg5Q+cb/lBLbXH/Rh
 1Q5/IxNopcRaScyItQdBCHRs97LiUDUavjCSi2ty97wNsMz+KWcu/8tQdZkZoaUDjjsC21rvWWF
 C757DgQ==
X-Received: by 2002:a17:907:6c12:b0:c16:19fc:9976 with SMTP id
 a640c23a62f3a-c1f721f08b6mr165722066b.53.1785251365992; Tue, 28 Jul 2026
 08:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-mt8188-clk-fix-top0-gate-polarity-v1-1-56bc92ba6055@baylibre.com>
 <b567151a-edea-450d-8807-8be93bca20c2@baylibre.com>
In-Reply-To: <b567151a-edea-450d-8807-8be93bca20c2@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 17:09:17 +0200
X-Gm-Features: AUfX_mxpzpyIl4GNMJ0Cyk_YAUf6yHhk30x35lmt7rjcF9az9zlxob0Y6K_zYaE
Message-ID: <CAEHHSvaSjwn9POS_RPzPsN6sH_VOAD2z0ncOWRzt=_t=0oJrNw@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8188: fix top0 gate polarity
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785251366; x=1785856166;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tmD3rSHQFilYeUk0vugCYpHGLzXFgiOr2R0pVRDetX0=;
 b=gjQUozT39P7agvRX0cB/1FOFh+9itT1WuaBIBqV9N75XSdDgzKdh4P/Jrn25RBdnl3
 Hr0Bo+YEBRgF8tiHJpwdRKSKbmb8cGOWVUZBohPsjNfh2Dd0jtmgJHpAVqhoSEVO4vgn
 lXPRLwm1c/HHVnWV/JT250C6TB7bR7UflN1q6rqE+QTbk5rcS7XqqEF0KN6YBdlrl+ed
 VW6Tto4TinVm+6WJ2hB0GaS5zZfGGP3EreUzlLpMqvNrIdN00K7olD6gkqteElHtCb4n
 IeAj0xGjHsoENLObrLsP7XSaLq9IS6y0wZVM1ZEHP5ucGg/XBlBuJSIzf/3iz93BgPWU
 W9Bw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gjQUozT3
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

Le mar. 28 juil. 2026 =C3=A0 16:12, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> On 7/28/26 7:28 AM, Julien Stephan wrote:
> > Gates in top0_cg_regs are active-high. The GATE_TOP0/GATE_TOP0E macros
> > set CLK_GATE_NO_SETCLR flags, which treat them as active-low. Enabling
> > the clock is currently disabling them.
> >
> > Switch both macros to CLK_GATE_NO_SETCLR_INV to use the correct
> > active-high semantics.
> >
>
> Can you reply with a Fixes: tag since this is fixing a bug? (No need
> to resend.)
>

Fixes: 11f3cc46322a ("clk: mediatek: add MT8188 clock driver")

> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
