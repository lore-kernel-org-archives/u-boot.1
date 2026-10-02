Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8C8CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 00:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E24D607F8;
	Fri,  2 Oct 2026 00:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VkwHT9LNyoR; Fri,  2 Oct 2026 00:28:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B31F60B0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790900902;
	b=dyyIhEpZS11Wo6I8BsgYrvfl01s8YE9OKxLKQ0Y7aZcRnFIPTlXt2i6G3yDRHlTDRstR
	 esglbrQx/NthXI6DHQm97+bQY4y7+rIO/ZDGdyOiuIIYqZC40UFU1QBlAUMVzwY9KqlnH
	 XexCSrK5QY25OgNfIX8hkjZd4JZ3VOB4aCl67ut4ir1hYb7tGDRRUOV36dq1kutk6sDfA
	 PxWs2BbnGIMLT4aWfxYhedZc79S49s5nOGeTlPU1Eh1OhwWRwp4QFADIION5EdYn71dHV
	 Z593SGjInkf8Gt59IqAXzSedA/T0/+nFR58jHqfbQdEuy5viQW2tUn722LQBieLQ9LQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790900902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZmiW8IuuQFGjsVxtNvf+GSHWrtAPq+S8/Bm8qzu8lq4=;
	b=T3UZzB5nfdDq8iOca+GZAAjIerjAqxdTp3E4AcYmzp5czbesiUo6cjjDVJAoHrN+lFzd
	 rx2F2SSF0+t3FNO6A3zmxHZfAcOvBWvO141r7f7Q36c/3mNe9Ve2KdJGgfgoft6JtH6ah
	 7eQKIM408rHUXl1kQpt5FOE82iZx/kM96lCUtjraXZtGiSdGbkrslH0MCwuMzCIzuk1tu
	 zq+8+hBRO3A1XS5NA9GFMB0mstKWaB+f8iBOli7nZ1Ak66CLViA4eT81Gj0MZWrjRbPSh
	 1cAjJaDiLUngVOhg53C4nAKP6cBvzBPVHt0znt0hxsHWokWphSxv+r3FAZtIV1Folwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790900902;
	bh=ZmiW8IuuQFGjsVxtNvf+GSHWrtAPq+S8/Bm8qzu8lq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLOMtQ0nTOgA8unrlaLx7nlcVfQajJ9RHd3LTCwJoPB4XQKIQoQjBoAaCcVlGD/Bx
	 pxMcofnP7HQ+b4fNwJK9m1NzVGqgXJhxxijBwi33e+A+y3jEeQ6jPgHJnnlslgck2Z
	 1S7keXKeQsWitMJj3oSTk2mm2ay0QHHz9b3kZqEI3QCtw5FoRDKmnqSJWjURQB6vOA
	 0n+7ZSUFDQXGEFP15h3HkBPEXwmfpKAwb7iPfmiMTZ2LWQ35Qg5o+/6gz4ta2i2eLg
	 LDZke4XxKM4IdjNZnKB/+uwiLfsqc9vUwlspjHQBz3tWJ8158XH2gAwfsp9er7xYiR
	 ya1lnNbAjGcWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B31F60B0B;
	Fri,  2 Oct 2026 00:28:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EFD222B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8581A40062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CSa5KQiAWtWz for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:28:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6DAF9400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790900900;
 b=nvm1LKmCk+NNRP+HJNgcfoYCihEEkNrM6SK0beiNN39T+Dczug9k8vwwfBDUaz5AWi6h
 kdZCzPaBhSnFwQAuTH9C2LnelNCLu9V01bk2XH7OPSKBcAqzeVpQqsMOIbs77twscTr7C
 OhwS9WeF+mFXcyWbFvtjG/zRfolZokt34zvYfvczqeSGnQ1Eedb0Da3+yh3PgQu7hH620
 iRGTXYx7ssSPIA8aUkYUCLz09GwaWCwfo0ON6FbuFMX1WC5Cj6WbGFfayCgLNgN0ql410
 gQNoddekgzwVjBpW2JxNWzxwepSkAFau9XGxee4oWgDI/RLplVR9gK/mfHzv43bpk1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790900900;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=ZmiW8IuuQFGjsVxtNvf+GSHWrtAPq+S8/Bm8qzu8lq4=;
 b=VQhi0pDQD9EAU5wLc8kQrgUmV/RqSf5pHrlMMaOKDJ96S8R/fh6uSZSGrsWDImReTskg
 EY16MPL2VFc8TJEsYjhFswFyqehQaCOHMHt/vWgZWsccQVxpw4qAYLr/ZFI/NwL/uSAcI
 A9CjKz1xQajrQMGHO9OnYHmb5m5JFK3sRUhiJ0ZnmTFkasPF8a2aKFO6fnqfdjZ7O5Ava
 ZlWX1PDqBYztntbYH9ZNn676c0w884WOBp8w7e31SBpmQ4XueBEBnlVnzYzwfizvDzbXp
 MyyFkJN1ojD1yKU8VJeR9y2MLHSoUH/GFpz6wn/WY/AyOlJw8LXxY85Ep7NQhqP66Ug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AfW1F9WL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AfW1F9WL
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DAF9400AE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:28:19 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6df4f4174feso64777eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790900899; x=1791505699;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZmiW8IuuQFGjsVxtNvf+GSHWrtAPq+S8/Bm8qzu8lq4=;
 b=AfW1F9WLIT3+qV+R8sy06QRaH6MrtyA4SLJ1Mu7gIEqnpNJJ3GbbjIp26Zyl4D+Uh+
 fwSuzBDuUkCxxwHCefzIcQZM0oR1G4xEp+03Dl10p1Y0tvhe7D2U+9ulF7uZ2G87H5rm
 ut+f76edvXKsZBIYdYYwTPlInAm18ukX/0V8AFV9L3IjM1yOXN799/n+voRxjBVPYeuS
 RTHlHirfUANvwh2M2faiVJJTjsGKflZ7P+L2KLIjicB7DKug6JumIAunltpM6JXDP8e5
 QiSMmkOopvT5b6SaVT4hbOhjQn3mJbDenMW+iILBKIDKg9NP6qW89537I8vku8hIMW1n
 3Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790900899; x=1791505699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZmiW8IuuQFGjsVxtNvf+GSHWrtAPq+S8/Bm8qzu8lq4=;
 b=IT/xkH0zr2SMa6UU2i2r5VQLYWN/EwWqN57iF6VGgEo7AqlvCZIBP5avEF61YD5srV
 zA+lvXyFI67U5TJ0Gf3JjfAAW2lhSej+37v5ZXgT95M+EJTi0yD8qXwB3tU9REhAD/PM
 Izjl1Tk0JCZ/2YfFsWA8ufdugKcuU06jaLQXRow29udro9ly262CySHjZY4E7tEcnozy
 J1PDW6HULfXTW0hAEQIZr0evR7wZHUIjRCeWb2PV5wbFgl1qdl9qgaCKOnOAhMW7hypf
 jIWKZgoYE4770iIzJWMnYag5703mGOKPUp7rbnepE4rNPXN3HGbDXftETjueGwN/YRd8
 Lwsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQknO8+zLk8mAX7bdzr6PD2TDaPvg3m4P4zXVvfwULePpDgV4lLpv7KRlW/6LFDKoVOhvHKYA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1MJBS65RoA+90TsNUeMAERGPIHLcFFjARzvxLk+K9rrgJKDoc
 7E63T1eyaKThYDefH4T+B+LnHXNGfSKWwuJcrlENvhrtdQ8h4hMSRlRGzdnNUwdhZ6A=
X-Gm-Gg: AYBFou2pdcpHaAdJhfKuPux6XHKKsDOIfmc6Wolqka0rea0EMhR1GYK62LqmTJMpCP1
 zx/H19MPGS2dWGDQCm9+gJ9PtmcUEHUapIkdbcQSpHMx/jhF/5/++EeL4OG/eEprVxgFgx8Zklg
 Mnv3zQFfPM5ttRN12CP3OZ+8/MbQeAY2Cz8C6iDIbloMz159scLbrdkBu/lR6iqT2sLET+7ulx2
 Oh9g+7jNBuwxf0mZgb/DQ0tg94f2kpMt/42dcBx9XeFBqVc3OEvBAnYci7oDWvZSTwig/PI23W0
 0BaZgUj4CwJk1eHH2usFUuPU+gDm46X5G+XpJ5BdCWH73rzczITRN/sE1IM8SDEaGpGe9cnPFnD
 W2wfhmCX5fKU8Dr7kEqZOe9r2vgFZg52w+PH44uFUbYmBEUxbT2QvNk+p9qSepGEuSdVLWhvfb8
 KJ40V8NwKKvLzjOPsiHcCmo+npId9bCkf+cKYS4TFvt4W2juwbp5CycvfkgCKrIRYx/MyOFS9vT
 +lGJEcZXYyJC5+8YSb17TujqY12GjFSQ6OIMqSEkZwXO4wH
X-Received: by 2002:a05:6820:c2c2:10b0:6c0:7620:fccf with SMTP id
 006d021491bc7-6df3516054emr682962eaf.57.1790900898903; 
 Thu, 01 Oct 2026 17:28:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df37fe3061sm1160467eaf.1.2026.10.01.17.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:28:17 -0700 (PDT)
Message-ID: <32de885e-f9ae-4f39-80ef-79f213c5c5a1@baylibre.com>
Date: Thu, 1 Oct 2026 19:28:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] video: mediatek: add ddp component
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-9-212f51b1742b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-9-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/26 10:08 AM, Julien Stephan wrote:
> The display data path (ddp) is the set of muxes of the mmsys register
> space routing the components of the video pipeline into each other.
> 

...

> +static void mtk_ddp_ovl_to_dsi_color_pipeline(void __iomem *mmsys_base)
> +{
> +	/* OVL0 -> RDMA0 */
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
> +		     MT8365_OVL0_MOUT_PATH0_SEL, MT8365_DISP_MS_IN_OUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
> +		     MT8365_RDMA0_SEL_IN_OVL0, MT8365_DISP_MS_IN_OUT_MASK);
> +
> +	/* RDMA0 -> COLOR0 */
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
> +		     MT8365_RDMA0_RSZ0_SEL_IN_RDMA0, MT8365_DISP_MS_IN_OUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
> +		     MT8365_RDMA0_SOUT_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
> +
> +	/* COLOR0 -> CCORR0 -> AAL0 -> GAMMA0 -> DITHER0 -> DSI0 */
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
> +		     MT8365_DISP_COLOR_SEL_IN_COLOR0, MT8365_DISP_MS_IN_OUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
> +		     MT8365_DITHER_MOUT_EN_DSI0, MT8365_DISP_MS_IN_OUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
> +		     MT8365_DSI0_SEL_IN_DITHER, MT8365_DISP_MS_IN_OUT_MASK);
> +}
> +
> +static void mtk_ddp_ovl_to_dsi_crossbar(void __iomem *mmsys_base)
> +{
> +	/* OVL0 -> RDMA0 */
> +	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_BGCLR_MOUT_EN,
> +		     MT8366_MOUT_OVL_TO_BLENDOUT, MT8366_DISP_OVL_BGCLR_MOUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8366_DISP_OVL0_OUT0_MOUT_EN,
> +		     MT8366_MOUT_DISP_OVL0_TO_DISP_RDMA0,
> +		     MT8366_DISP_OVL_OUT0_MOUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_SEL_IN,
> +		     MT8366_SEL_IN_DISP_RDMA0_FROM_DISP_OVL0_OUT0_MOUT,
> +		     MT8366_DISP_RDMA_SEL_IN_MASK);
> +
> +	/* RDMA0 -> COMP_OUT_CROSSBAR4 -> DSI0 */
> +	mtk_ddp_mask(mmsys_base, MT8366_DISP_RDMA0_RSZ0_SOUT_SEL,
> +		     MT8366_SOUT_DISP_RDMA0_RSZ0_TO_OVL_PQ_OUT_CROSSBAR1,
> +		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8366_OVL_PQ_OUT_CROSSBAR1_MOUT_EN,
> +		     MT8366_MOUT_OVL_PQ_OUT_CROSSBAR1_TO_COMP_OUT_CROSSBAR4,
> +		     MT8366_OVL_PQ_OUT_CROSSBAR_MOUT_MASK);
> +	mtk_ddp_mask(mmsys_base, MT8366_COMP_OUT_CROSSBAR4_MOUT_EN,
> +		     MT8366_MOUT_COMP_OUT_CROSSBAR4_TO_DISP_DSI0,
> +		     MT8366_COMP_OUT_CROSSBAR_MOUT_MASK);
> +}
> +
> +void mtk_ddp_ovl_to_dsi(void __iomem *mmsys_base, bool has_color_pipeline)

More on this in patch 11. Boolean isn't really enough here to cover all
possibilities.

> +{
> +	if (has_color_pipeline)
> +		mtk_ddp_ovl_to_dsi_color_pipeline(mmsys_base);
> +	else
> +		mtk_ddp_ovl_to_dsi_crossbar(mmsys_base);
> +}
