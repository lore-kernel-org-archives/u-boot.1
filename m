Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1DDCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CCBD405B1;
	Mon, 12 Oct 2026 13:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OtXSuHjQ7AzA; Mon, 12 Oct 2026 13:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A304F40583
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812183;
	b=bY0FDAGk2BUIzmRLafzl4HOC+ziWFs0Q4xo0I5MKSjIO/GzkHk/KtyyEFOOUSBshIAWE
	 P4lapGD2qHtZP6lDYdG9uhrFU6QLw6WqiGZLSDxa0wWPzxkrKCm8Of6xmugCRCJd8wbkn
	 aO+PNGSyAOagShvaqukUInOFlRGuzPYgWdHn4TF0IuH6UWo7xvnwxZYyZDvtKKZGZ+rfL
	 X5hAFYM0UuayvSPjRDLtkqOqT/b/RVUsbPbry5VkTqYWKUwKy6WPJHBhZTdaLynzHDPVS
	 X88efZJdjnImEvoolLIYmeZGOydjSuMUCPGhNGqqIVYHeAaP7Lshxn9c6rK5eOuV6rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812183;
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
	bh=gIsxjqFf5oEq5McBUOmz76k89ALBiE8AEuPgeeb8M2o=;
	b=NVdk9FB+U0TCU9/eELoMj7Ok07vYmdNj4xepSpFsjDWQFG2rymDj/jTejkuUHRUYPz2k
	 vl03627MT9FGrg6pn/UjVnuALpCqMYaYujQK5lPs69YU40e9FcFcnjhBRABlHBWokQaZD
	 WyGMMt+PNn0NVj8IqnSamYEf4GvfN7ETmdFgzzwL2mu+Ihwtka5rfjPwk9esDd+dnIQUm
	 gCmwYLUKugNLKrpFoUckRrNLDLyPNES+UMmg6Dx9c79WDx6VXE9Rmuf4PdnddSG6J+wXL
	 VoRaGdedSpNIVJwhsZ0KPZx0A5y7zzQ0D2Zf1B72/VN3l1jC/9VzAGWFpkxybaRuFwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812183;
	bh=gIsxjqFf5oEq5McBUOmz76k89ALBiE8AEuPgeeb8M2o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/09qskUYY1vkSXeEPiDsRmM7S4v2X918dlEfApgEbZ0AgIwBAx7srlbdWjHRvo6Q
	 xTyd9eLVFPTAZGTLHOCrUkm9/sm2cTIVHKFTWPHjHjHAfPWIMNmA4gPG37ojdFsmr9
	 Tz3sSg0Iix/luvYolEK9Ipj8AV1YJUt07APNFULYF009nzXk3QebQvT4oGO/w70BoN
	 z16YlxMKEMt5u8l60gzZjjogZ4TKTBa6+mR3bHnTuJeLux1vTlYEaNEYkPBlAIS6Uk
	 tXKHo4ieop2zvPE+wQaoGYNzFRn5PiLVGWep4Irjz6bKDRz3TGjhxp+PCIhKabJ2gh
	 x7mGdrsEVx0Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A304F40583;
	Mon, 12 Oct 2026 13:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA9539DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC27680BE2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VpipBpR7O3P7 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87C4B80851
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812179;
 b=Gt5Fe4ZjAYU9WE9eOgZeDBywwzawMFOj3+FXpjdFD6MZERPTN4YSZfSUZoPsqQYAMlzZ
 mH9oqeTxhvunpvCt93IbNQg1U4JzlkX7HkNT1GPOTTNXJsUN1+YXCt4lwwIcCEtuvBMW/
 XNpeUODnzo/nVu80za+1t77zaGiLvgPuYQhRmdgwU62JHERvQWPgyU9VgPeTD8+j/eKTU
 g+w2cV9ZRQnIHl16iUTJY8KsBc3L65J7olC8zogGPMVDH+eQZgSI6TT+uaGsdJDgvFwxm
 YCDdsHeQy1qIP+93GrbNphCjiN8e+1Z7WIJ7tFGgm1sRpODbsKQDVumDXHMXaQy024w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812179;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=gIsxjqFf5oEq5McBUOmz76k89ALBiE8AEuPgeeb8M2o=;
 b=afLFcVpwtLEAHhvXqUMGKlyl5HMl34nDIYVt76cAuADQz3cqvS9Dq66l4QQ1OhB4jAOY
 LIQzPPMuR/1xnEL6tV+Skf7RLbbIuLxHjSH+AU9aKc/CzFpsEs2D+JmXyJBC5s1uQvm/l
 8lP9ytKYIYdolRNlPpC2l+/ZkNA+x9R2sD73z147SMZJGmHv7v0Rz9GzEVEOnq6tNNem9
 FgJTb2wUf5Gwu+k0g1ub7ac94rzmt+DvM41UYq55SyS+GTWkk3bRUCOrOgotPxrs7OPMH
 69kEAh503IgBTWAfAa7dvQLFoEg6MXiHB8EQCkhPt3fox0OfZnuMnIrCyvIOBB4keHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Mu8JO3UW; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::b;
 helo=mail-wr2-x0b.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Mu8JO3UW
Received: from mail-wr2-x0b.google.com (mail-wr2-x0b.google.com
 [IPv6:2a00:1450:4864:30::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87C4B80851
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:16 +0000 (UTC)
Received: by mail-wr2-x0b.google.com with SMTP id
 ffacd0b85a97d-48af4c25844so717325f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791812174; x=1792416974;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gIsxjqFf5oEq5McBUOmz76k89ALBiE8AEuPgeeb8M2o=;
 b=Mu8JO3UWRKVUMVkt+TlasxYDRm7njtkBsZza9qDbkw+9XT14WB791HWVeycTf6P35I
 VIiD2KEges35F7Q+A09xrgwlTHFqsmL1c4n7p2EFkBOd3bkAExZ9Mb856LLo+emxY2Fv
 ymeXkNu63YaHHJzRF+RW32HXvRHC1dFkH0OTB0gnpKx0VgIAdNJk7zHT2aoni+U3XhX0
 Axqzz2O0AH8OgOjqhqWhSKRJqViHK0b/eiHi3k1UNbbQkqere9lCrFuK3dh8bylQhsW0
 2btqQhacQlF3AbVCKKzSNy9o3eem6NHh7kGYbiEEC5c4i98PvtULF2LX+jdoj3QEi9jR
 jEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812174; x=1792416974;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gIsxjqFf5oEq5McBUOmz76k89ALBiE8AEuPgeeb8M2o=;
 b=E/rPjTX8xiuIeE0rv7IioQ1ku87ksY8tRDwWRqqnzdsWIQmvNLxQbvsgEwDyWJLIu5
 wqt6SSJTvCFSbVBhpKElL9EO55u3bUGzAjGikvbbq8AZj0EycH2zDkrvDc5r7x6brCJx
 9s5eT80c1wxuVhl53gQSDhoaGXHk1vF1eI1RgbAxFh3ySKoF9E3hUL7uHiSGEL/vYzEb
 R1LrU7RVxaBF8u9c9AyBT/x2y9lpUZ+qgom1+js/XIQiHcR43AJub4UsmSMXFZuM5euI
 8s4zmK1x71tmWLFIYYXcFIhWzKajHuNM7ATG6sf8XiPO9ekGmRCeUXc4hhUG8Hedw/Sz
 QH7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfwMZWeqgsKzegqKlig4b7BHSSCYSvIqHfcKp6NzYjLsAr0nB6nFMGoAnYVeo0nL4ECCbFPj4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhNm44gNrMIMkAaA8aq00dMD9NtsCi+YHq+AbB6Q6CBOZIU8+c
 dDUhFu/+xHVTFM5gaYPp59UaeFMxY3oEAnqM7j06l3qHjn/toRgcut84XjjNzAvoFfo=
X-Gm-Gg: AYBFou1rrKf53v1vx7Rh85KOmgTBeDwDwryK8vpxD0xIr1sPQ9l98HtUKw90wk9gsYd
 lcKK1rz3LU6PsMvos8eyBlvNoDVQ99+Qn2YFY+7lmu3qhfavjSQQWdg3DJMKhkzGgeVKwaht1+i
 5tL7P3McOn10v0teCGPfWT7n7qRNQSsBJvvww/SP+eWUTsrN1v4qxF3BH6OJo3MneUL5fqVZk/T
 wCveyuDe3NkD0Qem7U4jRfO8HMmu/W3m+Tp9TsUtK81ZS3DFWRP/4Cl+Qc7n6Dk7LApzsGEKBZQ
 27pKtTC4hpITOmWwj72NH8+gQ9nE9vtDcoPLyQC9TRWoODnqPh0r0IUxjh4b7aocmmy9N5ObziE
 15oXHsX7r+wiZ+bU83HbM3IHAmIdGySteEwW8TnAaIgPOqQM0P0MyFuCmFc7x3Dr/H7m7qr3g6d
 mOWbT/G3XgWUZrYlJ0ucv4RJBjvdF++q1UQ3UpqY8b7GGP9H1x/wr+Im7WICRwneTNa2Y5RIIUj
 NmkKYzEURfbqaQOLAuRhYN0QY+nUuNlWjC0Ps6pLYNOj72f1PijFCYl5T7pn6L4Un3ZJjRRuqdr
 y0U8GldyF+8Y8RjL+imLWF0YKjK5mL7FCprSFePo8X0+my9WospG0do=
X-Received: by 2002:a05:6000:4313:b0:48c:77e3:6c8e with SMTP id
 ffacd0b85a97d-48dbacf4700mr17337980f8f.49.1791812173668; 
 Mon, 12 Oct 2026 06:36:13 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acdb6dsm20414147f8f.48.2026.10.12.06.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:13 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/8] arm: mediatek: add DSI display support for Genio
 520 and 720 EVKs
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
In-Reply-To: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
References: <20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com>
Date: Mon, 12 Oct 2026 15:36:27 +0200
Message-Id: <179181218750.53105.8193564789242792949.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791812193; l=3448;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=NGj6ANBTnCiE6tS586Cwl/XlkFnPTj38/xjl9cARwOg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP5BlmEQNDWwCsXnHaD5EZEs3+eh8lDc3dondyJKwjeRP+eL//LtXzv3de7eXEOC3GObmBi7L1I
 GLOyOgznRLwk=
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

> Add the MT8189 DSI display pipeline and enable the Startek KD070FHFID078
> panel on the Genio 520 and 720 EVKs.
>
> The MT8189 OVL0 -> RDMA0 -> DSI0 pipeline reuses the existing MediaTek
> display drivers, so the driver patch only adds per-SoC data. The panel
> has a VDDP input that these boards switch separately, so the panel
> driver gains an optional vddp-supply and follows the panel's power-on
> sequence more closely. The Genio 360 EVK panel node now describes its
> VDDP supply as well.
>
> The vddp-supply property is being added to the himax,hx8279 binding in
> Linux [1]. The mediatek,mt8189-dsi compatible is from the in-flight
> MT8189 DSI binding in Linux [2]. The mediatek,mt8189-mipi-tx and
> mediatek,mt8189-disp-pwm compatibles have no upstream binding yet, and
> mediatek,mt8189-disp-rdma is not settled: we use the
> mediatek,mt8195-disp-rdma fallback, whose FIFO size matches MT8189's.
>
> Tested on a Genio 720 EVK: the panel shows the U-Boot console and Linux

Nit: s/console/logo/ ?

> boots afterwards.
>
> This series depends on the MT8365/MT8366 DSI series [3] (and its
> prerequisites), the Startek KD070FHFID078 panel driver [4] and the
> MT8189 mmsys clock compatible fix [5].
>
> [1]: https://lore.kernel.org/all/20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com/
> [2]: https://lore.kernel.org/all/20260916110825.102631-4-angelogioacchino.delregno@collabora.com/
> [3]: https://lore.kernel.org/u-boot/20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com/
> [4]: https://lore.kernel.org/u-boot/20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com/
> [5]: https://lore.kernel.org/u-boot/20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com/
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (8):
>       video: mediatek: mtk_disp_mutex: describe the DSI pipeline with data
>       video: mediatek: add MT8189 DSI display support
>       video: panel-startek-kd070fhfid078: support a separate VDDP supply
>       arm: dts: mediatek: drop the USB port 4 VBUS regulator on Genio 520/720
>       arm: dts: mediatek: describe the Genio 360 EVK panel VDDP rail
>       arm: dts: mediatek: mt8189: add the display blocks
>       arm: dts: mediatek: add the DSI panel to the Genio 520 and 720 EVKs
>       configs: mt8189: enable the DSI display
>
>  arch/arm/dts/mt8189.dtsi                      | 147 ++++++++++++++++++++++++++
>  arch/arm/dts/mt8366-genio-360-evk-common.dtsi |   5 +-
>  arch/arm/dts/mt8371-genio-common.dtsi         | 139 ++++++++++++++++++++++--
>  configs/mt8189.config                         |   5 +
>  drivers/memory/mtk-smi.c                      |   7 +-
>  drivers/video/mediatek/mtk_disp_mutex.c       |  71 +++++++------
>  drivers/video/mediatek/mtk_disp_ovl.c         |   5 +
>  drivers/video/mediatek/mtk_dsi.c              |  20 +++-
>  drivers/video/panel-startek-kd070fhfid078.c   |  52 +++++++--
>  9 files changed, 399 insertions(+), 52 deletions(-)
> ---
> base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
> change-id: 20261006-mtk-genio-720-dsi-1cf87d259324
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>


Tested on a Genio-520 EVK and U-Boot logo displays


Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
