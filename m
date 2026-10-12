Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C6ECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 651F180851;
	Mon, 12 Oct 2026 13:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mhq-3f9KvdZi; Mon, 12 Oct 2026 13:36:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B750780BE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812180;
	b=Gg8ZY30wUNY5ux7DSDB+ETl/Thn7Sc43HvHPXPAQfFvIidOLhKi4bQF+b73ZyXKvb7qe
	 DSBcRj2U4X74Aogwmgr+bllaio3qNkUHEGKWHEAIz4Tbt6EzkdzuwEyz9tFJjEPqjRZE4
	 ppoUBsmIYgKhC4ay/kYHWbiia2iLvk8iAwvCAVz1EhN1ErvLo3zSMx6bwlIMP8qfzxfzf
	 WxaDiVgi3LozTR/2zOcueQu881KK/kgy15ZFpYyYo/xZQAdna58JAEWhKeohAFPD8o2tz
	 o55FGmxgdpYBNidG+CIu/dQE2LlsMh2PL+hp7X1Lm1d+sRYMUaHhxl1ahJcqSChgSrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812180;
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
	bh=RlNll9dhvsH5kJd5e7dAF6ulQAVXEurDkKf0nNocGN4=;
	b=R3hNCtRDQojYP3Nb/WDhTUeeiWpLbhzMz13+ro2jlrfzirhZvoCJBtF3sf+RYtHUL6I9
	 6kJ4PQMUKS3GOgZVKwuw6T9ajyqD4nbqA5OyhHu4Ky/gW9tZmvVUI0jrg9JFwStaqsfBw
	 nlTK2dqDvQ8N/vxZ/MrV449D33K0w455Jq+5ivHQW+/el4aU5kCCUP9A/7oh2aL8YgMb7
	 vbVoi7JhBkcGu3Dx+0EPFgMd7v9MWDhcFyKoOCqpMDnmq2EkhrYAdDKkvj72FzfVrfhPd
	 EPN1n+5WQCj7tOjHHxmsQl0NMCRsXJXD/B9C+gBgT2K/0h9pL7X9Hab6qEZfZkXJmqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812180;
	bh=RlNll9dhvsH5kJd5e7dAF6ulQAVXEurDkKf0nNocGN4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6jG0L0iiDvoQQhYaI7zRJ20Y3QL2E+a1BV34AMNXlkq3ZSJ2uNd8ndraI2tc0J0u
	 eBjk+He+nqeTU7dQCpGI2C9TOWvoE9ISBp0bTZj/a9ZI/djkFlR+gef13dB/jOa1qS
	 SGENUQpqmKgVPcpd44VXBpGcDFuQJO2I4O3vbHBqG8TyJGZz9N27QsRRTnZTXFGl2V
	 R3FmrNQcl+HuaUZ29/mHQ5V4gD1vCeajnFWXSA46Zm3aDjB2jNTbbt2l6dGju8NNDa
	 UMDKdnNRxBrJvgctkWfALHRKkWDEpkDrUMShmgeOlm70y0Z3RbF75944FkT8dWwyXx
	 5cZDALW2uvwbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B750780BE2;
	Mon, 12 Oct 2026 13:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04A042E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA0E3605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGoQ44gPEieP for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87D2F605CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812178;
 b=sZUi9tOoce0rhDsAyLb0TQDAJLvxzXiOCfYDa6WlCFbL4jPzGM/cjmUWzqDsrauW7tcQ
 4nYpC1bJX9voqGbQveacrM1MRaaIE14T10mP24oS3WTH3ZT6856urvm/sdSsLdLT5ImI3
 XFEL+8uy1J1a+X6RFnv4+uRHlOtoZkdRJpnXomy2LA1U9S98wIWWGeWn60kuXtOexTn9w
 a2UUWafILisVZV1DszPaQMAeL+fYyFHxDA/FKW6GhSE9NPPzSxsGVZFYgqQ8GXd8c1xSs
 o79CsZmJ0IUfmcP6rcyeGAI2g4JQ+1ZGlvu0m2Q0KrfJLMw4Fp6ccl3fS9+sP/ArxjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812178;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=RlNll9dhvsH5kJd5e7dAF6ulQAVXEurDkKf0nNocGN4=;
 b=AWE5KbJIvXjbqxptx3YbjvaZd/gSV+ic6f3ZR649m51gvuvho207IZxfLVKOtyA6Oimp
 M6s1RucpBfgety5DOvBtixGkM4grsqkgzu0YKjFaVAHNTfd2vBHx09raQ6GLa8LARwLA7
 Z8B8DiDNHD6pAW9LpbOflQgGmvR3LInh+70ibkm8dlcfwlO3PuLXZrZLQU2zN5wwea7eT
 waunc4MBQhcNx3R0FX8yjuuRLQn3jTZihqBJ/I0NftkMYVKzpvTTiyJNbCMZwe4/qnb+0
 sV76FchtoP6b4V0fPSucrBVuo9nq+GnYQmyxiAsr22zcKo4QwZn7594Cpg9BVLdDoYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Z4hWs3hj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z4hWs3hj
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87D2F605CA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:16 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b0946c2c2so1080301f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791812175; x=1792416975;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RlNll9dhvsH5kJd5e7dAF6ulQAVXEurDkKf0nNocGN4=;
 b=Z4hWs3hjrP9EZ6a9BnImpClwTeWOg4LC5fsv2aaIm07IxlueDNWUlO/8EgZknsQkwG
 V7p+52jlJPofX+tCueurA6jZH0x8keVQZsC2tk/wuFn4cOgYi7Pc9ZyhbQYwK242eon8
 yC5wtvdEKgXr0svbPZeqm9eyrEYmgnv2mq4IU2w9occo4rQTcQh1hV6GBaEKRAigy6C8
 HaPUFDU9sIy4ZDRjSD3mDvyMweXH2eP/VBTUu90yD9toDN2jx6BbHGP4wezfbGkPE6Px
 Ry/ZJPdKcZiZszTBdSqKgRY2MWmlX9JZ6ekParCFEvLFFCfMUw6hkDQmWMlWqXy17pka
 IoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812175; x=1792416975;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RlNll9dhvsH5kJd5e7dAF6ulQAVXEurDkKf0nNocGN4=;
 b=f48JgET37QrFHvwA11J8Gs8vulswmvpAypA0a+wFmWB264Tdj/umAOyi+GgU1goD7f
 sFoPe+fKDNjIVqDeREZRYKL7UYKGZgur43Sx5OAAdb0rYG5mRo5143PFU+O2nsjBja+M
 8PnK5fvj6w0NRAk1L2aD4SGYSfay9pajKwwcTlZck5cVSuxWN5M2qkxsBaARkhVRJTnV
 PL7SzQIYceQEgF63oh0BcqBPYPNfQg2zp4X0qQGMJ5VljPUcNhCKcSEygtsGgcjyUc6d
 ljB7WV/9f0/CDNrOetzKdaJ9i3LzwuK5ubnQajNPVRhsuGX/PFDdJj+E6paCzYfkG86g
 CSCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUxryw517geO9Dlr8GOqJk/c0k105CjULU9o4+HZbqBlIjy8Uvd0JWq7pop2IzWm6v2fTLsdo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEJrtYDPMWSkml94GjJpTEZM3LooKmTgqamNbQ+bmZbrYVYA1w
 m868AQCN4eI5u4cipfGnKnQACgsxt7uSiSijkArvJnRx+EDvTbA/4dh25fJfdtq+sbg=
X-Gm-Gg: AYBFou01mJ969iTkYzxsr/ZXJ8oTPeHRgscHpo6jGkniyQA/4AKcai0JdrDUHU++rcV
 AlxkRjKxwkRA2zNktHpzZsHEoORqosk9XMNjDP8DtkrQR8tDlUlUL8fIilSqKUbeJxuUjU93sVI
 ybWbDkYivhT3nnm8juxf8tNplOmv5iuL/pFoIf+dn27Gmf6lTGx7Nuo+qGskecUZv47lxqXqltn
 TmUY1nSuzdu5TTRt/IfvEYZcBaruzJKZzu4e11UTxVS3A9MtXwWP3S/XancdWKRx/QbvVrXPC6d
 j8NRTdZb85WdqSDd26JsXoeqc3OJAYiOXphIwA+1rXIe06gOMSGs3VcAKqKf0h71q1ZkJJfkNOH
 1H/JGMJVGcJFuJQYOjWBzvvekWuFmEzG0i3xWwPgsrV7tdh0MvMRH1oEXhqaxEswyotRy28naQH
 ugHACVNvTj5SKKIpIC3n6aNDuHazgndVtK3WfWL7EnnSa8kHT71dLOQXUnf5PSFrTqjFWAiq50L
 h0L8/179ejdxP9mOKeS9+ExGi69lr0yMbm6+4ujJvTgDDLaz1vhb+v38io2YaeHNNIR+MNtVkZW
 DmMAG15FwGr0pKWFFmGtM9p0PDlkksRGgC+Mk32uFuWS2ZhFlkE28yE=
X-Received: by 2002:a5d:5f89:0:b0:488:8850:50ec with SMTP id
 ffacd0b85a97d-48dbacef19fmr19559656f8f.46.1791812174816; 
 Mon, 12 Oct 2026 06:36:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acdb6dsm20414147f8f.48.2026.10.12.06.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:14 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/8] arm: dts: mediatek: mt8189: add the display blocks
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-6-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
 <20261006-mtk-genio-720-dsi-v1-6-7fa10e9c4506@baylibre.com>
Date: Mon, 12 Oct 2026 15:36:27 +0200
Message-Id: <179181218751.53105.12547308733220097956.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791812193; l=1442;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=dySueUi+sjPLNYKI0gLt1VTiOtAm8I6mthARcoI7YcI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA7eFYiCwNlBUe8RJGzAPkD3Psz2so1KEYP+zYPCc88ecs0aSa7hFM9nsE+FXFskysvlD8IyVCP
 3RQ/FSgPTiwA=
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

> Describe the vdosys0 display path: the display mutex, the two overlays
> and RDMAs, the DSI controller and its MIPI D-PHY, the two display PWMs
> driving panel backlights, the two display SMI larbs with the smi_common
> block behind them, and the multimedia IOMMU the larbs hang off.
>
> The nodes follow the in-flight MT8189 device tree, so the overlays and
> RDMAs name their M4U port through the iommus property and the larbs
> carry mediatek,larb-id, which is how the display components find the
> larb to enable. Only the two display larbs are listed in the IOMMU's
> mediatek,larbs, since the other eleven belong to blocks U-Boot does not
> drive.
>
> The aliases are the ones the DSI driver uses to reach the pipeline
> components, matching what mt8366.dtsi already provides.
>
> Everything is disabled here and enabled by the boards that have a panel.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
> index 656f5488c72..22c1c7761f1 100644
> --- a/arch/arm/dts/mt8189.dtsi
> +++ b/arch/arm/dts/mt8189.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/memory/mediatek,mt8189-memory-port.h>

Nit: should go above dt-bindings/phy/phy.h

-- 
Julien Stephan <jstephan@baylibre.com>
