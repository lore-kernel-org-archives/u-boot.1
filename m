Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B51CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9028083B;
	Tue, 13 Oct 2026 08:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-mNyiJquTlK; Tue, 13 Oct 2026 08:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 228C4806C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881235;
	b=KcJSIEmUd/La7EssHOWcE+t9y86l2NLBDczPJt3QMGIM1WQDc3eFeMN765jVoJZ+bQLC
	 HpWOurrZ435/cskPG3SXnxjWgHH8HmJn6kog/GFbTvMxp5uUoU9Xvd1yv5/svsCnNBxpk
	 4Q1bwccoAf+Lv3x7oDyn3U7CjJz7IG7BWLOo/Q8fRuJ4vif+jETkjN/F2v4sSTiw9jOV9
	 FAlSiVQYrhzWZlJ80u26jhpT4Uz2OtFajHKaqzyIWLzOlO2yxMc/vt/uAKMElY3xZlHJM
	 Urn2LWgYHkU2hztQLToi0VrgjfMiHS9YP4l7VMVhJ6WqdcYJfiDAnZGm7u0ai4hPIzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fLma3oQgFfOtPFnRJM9+JBtQItlqWnlzJMifoE0ZOEQ=;
	b=RHPP5RkWRHUArDQHDQNNhWD1DwmFJ0GZZksCcr33OpGWDea0UzRqkUdZOOUb81CaxxAM
	 YkTUG+zFPMHyXk8yHJZNOk6Y8MF7RZqkQLrTOcigvwgnXoPrf9rP44vn/vuPNG6T7Xdhx
	 QJOrdpnNNfahxGYpKiyeo3Mx8n2u9g6WBl4fUMIJje2U0rsYtpDJ8w3HrOZUSq1R+ozui
	 irOophhiH/SYz0MhslovYrGAs2ElcDfIwfiIMtTkT11XYqu1yDYhMFamt6leiMkuA/8mW
	 u0LPehFhbgiW4viN7+orjvMmz2ZmHSSoRPftJEp31Z6pxMlBd+z2eX/K1ONQIVSnKHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881235;
	bh=fLma3oQgFfOtPFnRJM9+JBtQItlqWnlzJMifoE0ZOEQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HakYmSPyZu3ap/IfJZ/DjHuzxNtqJJMP4hzHV8pKJtlKPB2jFyhdofuCRRp7pq8wx
	 ipuF3OFa2Vn1PRMVjRhEWlWhwifJq89LBDb6Jom68twv1muU8KMGxVlsykkQhZe37J
	 36md+kZnl3wS0c3azDiNui2PhJtJDd/pppqqpPimA8XF++ScJAmX8hOGSTiii2wTzn
	 lEe4/60xQjPANfW8DMkNPO6RTivWK3vCqs52pPYf4Olrij2h9lkH1LWpQgcvPzbyH2
	 sphTDRmtCGz6Z3ikXyARSeyPspQ6KgXS7F/2OxGufnaJ2XHz7X6XBQf5i5ya59eQvm
	 5sFVwGQ/9Q3oA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 228C4806C7;
	Tue, 13 Oct 2026 08:47:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 591E41399
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A83B6075D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsOk3Z3NRlp2 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0DAF606F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881228;
 b=h6Js2T3jyfgD6PF8iCxMVUZDmIlHMqX+NLFOxT1Zyk/ESv6dt7IBNufa0kAk621Bmy8q
 twoDfV69Ds0bYVPWfJZNRZQd1DfFmT8Yjnc+h/S4bhqVlbnSxLJYPkibNh+XY1PsJD+3Z
 Xh2vHBMtl7mAlco5tmKA9HPEyuIus55VjSz1ivzLnB/lxBoKLkYb6r+IfQLczK2zjlQLC
 4oKeHSw9dvUnvX6ileoj+yHNmU33NxlJyooxMX9amqFgDSuEW7olQC3S/uT5BNLuukyiA
 ET8K/IBOiHdfJYDfCDfjxxllOsXPT/pRPIlDoXBtXbiatqeN2x79YYRvfuw0ZY3dsUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=fLma3oQgFfOtPFnRJM9+JBtQItlqWnlzJMifoE0ZOEQ=;
 b=sz/XtQs7xNAdQ75V40iItdXR4edXidiIpI73WFT0EjeXVEjXOZvaoPl8neaS64BByAli
 u+UtvS4FMKULKrvLabo2QUfXu5wl6qbFhapsrQR2ljFOeXYA8coGogH8uOB3Vs+WVTfG9
 18Vq1WZKlxKOmAcSujZLD1FjLNGxZd+TFdFZmRPeRk3wPWpsf4qMDBPAz95UtxMGHQiRK
 +QpTdQCyF13TuDx38i4RpStB9H1w+V4sG7kCXc5XboNeOziZA3iITawa4lcgH7JMN0SLK
 O/5JUF3XUQSqE4knfyvEn1LzvZCgoY1MORuTys+mh1YCmF9B6gncwT4dLY7/492m+bQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g2eqJxvp; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::6;
 helo=mail-wm2-x06.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g2eqJxvp
Received: from mail-wm2-x06.google.com (mail-wm2-x06.google.com
 [IPv6:2a00:1450:4864:31::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0DAF606F5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:05 +0000 (UTC)
Received: by mail-wm2-x06.google.com with SMTP id
 5b1f17b1804b1-4a01c6c0f64so8745915e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791881223; x=1792486023;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fLma3oQgFfOtPFnRJM9+JBtQItlqWnlzJMifoE0ZOEQ=;
 b=g2eqJxvpHIorfCI6iEo8bqt379JILtTDk2azUJp63DEWsjDL0SPSksZNx7gD4Csu1X
 tG7or9LLA57tXBmzutUBdk04xVUAJquXgUFQlZsJMotfMvKTJXNhfOQnP+4a8hMuVw/V
 BVkp8XD/Qgf9QQ/bp22mUcFs8J2SPPr5vSH3xi/QbQRPVOk1Np57IWtukAR5g35Jm0M8
 TIVeCtPZuCx4n2sn3LMhPMiLgtiOeTNPCqVPYdptnf+vLW71z+ESoBRgEfJQgI2PkQDw
 m2PnfjgOQtkLkPSdlm1K/hWUuds5XtkZBX8WXUIiE5mRbhBoJYW0JPvH1mNYSbEEfMhb
 sdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881223; x=1792486023;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLma3oQgFfOtPFnRJM9+JBtQItlqWnlzJMifoE0ZOEQ=;
 b=kNsucErmtVoJWeWyWkM2TZaSJ/cu3+KlHg74cCjcCjjc6HQYyag9SVp8jkQPayhJGf
 QZretUDtSJ/Aout5kzlGAtaSVXRKIio4+ldX/9eelCDMafHwMb00kuIAc1lGFWtBxDoC
 Z78C/ykkZwd7U+sFlpRw7X9Tad56rdF//HLcBT0lhyvagrjZ2spmZsP124EW6lX55nAH
 3RmZepEUHfvmyiXAbjjRbZIEOjrgl6z2PoLI38pdvF5QLgi3OyfKvedxfpqQ/AvwRM0m
 gGIa4uzQ6wxIJE594F4K1uEHlSetHLkfdt51jF50vZSGIUP97TEdC7IcEd/ySp2MUzGo
 xOCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl7D+LAzI76VWOB0KoCsr2CuyIsIAGCQs8cRpIfC67HJMpLhnzvHcf5IB1Me2v5kJ30dHIG8U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYtAmyBSD011Sgssvsf23IYn7wHNpBELFRhqy93McSBdjVRnbW
 jbfi+behoMI/hcs9oWXNB/JBQi+0Rp3gNKZM/yeWANkyjbNHYN/bv75ih6o3oVHeQoQ=
X-Gm-Gg: AYBFou1Ke1EgBtQrXImXVpdjFrFSRUNlZfMI9jO7DIeaSmqtRtJpnYAdliHWeez4E4G
 LaT7vRAUmVhhE8pQqRk8QkQi+kOGEuJLwuECwve38OHV9fEEImVSL8DTSnL/iQW6L3/NPMMXn4P
 V+Isv6edfbgVzuCh8hzV1tz9XZeoO+Ih2l0JNkWJMiEBsP+CnLOUPw+KWhKJ6w7NxTemPHD4P09
 Sg1nUhhhGfPTLO/qpIi73DHD5Ix5BnLvQvAkxVeQuGOR79b2aUGGF55CaRFsp4cDVzTx9nld6DG
 XVLoVabi7rNgUflIkP5n/O7UgKZX0yBgly67YgOPcc4v8MBfh8NGqZ1OD0+Q+1oZ/8U5yIn+0rJ
 kwPtK9fOTWNAQ099Y9iZDB9V3qxlpYzokfHjOefa5+i5zUt4wNDGw9RXfFEqrkYX2KgO3dZFFAr
 9yWfe9KQxzvrQucJhpOZkrdUWNW/toSC25x5jJ49wppXa2lfHkXs422dECqO5FBNr9ogSSYBTQU
 GfsBYSUZA2w3Dfb75qK1IucpprWY2FApcCQFH4wJU2cpsys/kO36WOTApvnq3kxpjHHhX2cm/cw
 dT4PmYa5bQbJRZS6A1sVPSoIavTDiwEi5I6cLhZGeBPAc4uCm1p3ej0=
X-Received: by 2002:a05:600c:8184:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a18e4d854cmr196836225e9.31.1791881223113; 
 Tue, 13 Oct 2026 01:47:03 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm271972705e9.2.2026.10.13.01.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:47:02 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/13] arm: mediatek: add eDP display support for Genio
 520 and 720 EVKs
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
Date: Tue, 13 Oct 2026 10:47:18 +0200
Message-Id: <179188123837.53105.9173696789646709069.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791881242; l=4448;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=7y6kvSyAZ3K1larwccukBDo1jfTr5ejbGwy4EI+srLA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKKJB2lg66oG6qSRBRx2ELcG6KAdJL55UGJuw7asQWEFPy1qcuT5THZFdnmWWOFcx/EE1OAxMeR
 6QUO1OdNoHAM=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add an eDP display path for the MT8189 and use it for the panel on the
> eDP connector of the Genio 520 and 720 EVKs. The pipeline is the same
> OVL -> RDMA one the DSI path uses, with the output crossbar switched to
> a DVO stage that feeds the eDP transmitter. The panel mode comes from
> its EDID over the AUX channel.
>
> The EVKs drive the DSI panel by default. A new device tree overlay
> switches them to eDP, and is built into eDP variants of the Genio 520
> and 720 device trees, with and without the UFS overlay.
>
> Tested on a Genio 720 EVK with the eDP variant.
>
> The device tree does not fully match the upstream bindings yet. The
> Linux bindings it follows are still under review and could change, and
> some of what it uses is not in any posted binding yet:
>
> - "mediatek,mt8189-edp-dvo" is added to the DVO binding in an in-flight
>   Linux series [1]. That binding also wants an input port@0, which is
>   left out until the MT8189 display path is described as a graph.
> - The eDP transmitter and its PHY are separate nodes linked by "phys",
>   following the in-flight MT8196 eDP [2] and DisplayPort PHY [3] series.
>   "mediatek,mt8189-edp-tx" and "mediatek,mt8189-edp-phy" are new
>   compatibles, and mediatek,dp.yaml has no "phys" property yet.
>
> This series depends on the Genio 520/720 DSI series [4] (and its
> prerequisites) and on the MediaTek clock rate propagation series [5].
>
> [1]: https://lore.kernel.org/all/20260714114414.184512-1-angelogioacchino.delregno@collabora.com/
> [2]: https://lore.kernel.org/all/20260709113148.49090-1-angelogioacchino.delregno@collabora.com/
> [3]: https://lore.kernel.org/all/20260910092038.48291-1-angelogioacchino.delregno@collabora.com/
> [4]: https://lore.kernel.org/u-boot/20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com/
> [5]: https://lore.kernel.org/u-boot/20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com/
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (13):
>       board: mediatek: MAINTAINERS: match the Genio 520/720 files with globs
>       linux: drm_dp_helper: add the definitions needed for eDP link training
>       phy: add the DisplayPort PHY configuration options
>       phy: mediatek: add an MT8189 eDP PHY driver
>       video: mediatek: mtk_ddp: allow routing the OVL output to DVO
>       video: mediatek: mtk_disp_mutex: add DVO support
>       video: mediatek: add a DVO driver
>       video: mediatek: build the overlay with the shared pipeline
>       video: mediatek: add an eDP driver
>       arm: dts: mediatek: mt8189: add the eDP display path
>       arm: dts: mediatek: describe the eDP panel on the Genio 520 and 720 EVKs
>       arm: dts: mediatek: add an eDP overlay for the Genio 520 and 720 EVKs
>       configs: mt8189: enable the eDP display path
>
>  arch/arm/dts/Makefile                     |   12 +
>  arch/arm/dts/mt8189.dtsi                  |   48 +-
>  arch/arm/dts/mt8371-genio-common-edp.dtso |   54 +
>  arch/arm/dts/mt8371-genio-common.dtsi     |  134 ++
>  board/mediatek/MAINTAINERS                |   11 +-
>  configs/mt8189.config                     |    1 +
>  drivers/phy/mediatek/Kconfig              |   10 +
>  drivers/phy/mediatek/Makefile             |    1 +
>  drivers/phy/mediatek/phy-mtk-dp.c         |  276 ++++
>  drivers/video/mediatek/Kconfig            |   30 +-
>  drivers/video/mediatek/Makefile           |    6 +-
>  drivers/video/mediatek/mtk_ddp.c          |   24 +-
>  drivers/video/mediatek/mtk_ddp.h          |    9 +
>  drivers/video/mediatek/mtk_disp_mutex.c   |   47 +-
>  drivers/video/mediatek/mtk_disp_mutex.h   |   11 +
>  drivers/video/mediatek/mtk_dvo.c          |  417 +++++
>  drivers/video/mediatek/mtk_dvo.h          |   33 +
>  drivers/video/mediatek/mtk_edp.c          | 2385 +++++++++++++++++++++++++++++
>  include/linux/drm_dp_helper.h             |   12 +
>  include/phy-dp.h                          |   98 ++
>  20 files changed, 3599 insertions(+), 20 deletions(-)
> ---
> base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
> change-id: 20261007-mtk-genio-720-edp-3685b2cad31b
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>

Except the small nitpicks in this series, that can be fixed while
applying, LGTM

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
