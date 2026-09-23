Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65BDC98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 15:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79E3860890;
	Wed, 23 Sep 2026 15:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id USs3GomDvyCp; Wed, 23 Sep 2026 15:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B70E36089A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790178730;
	b=TxYYQ5Ro1yB1cJ4tTkheZZddOgMIqAIZKOVPIyHFplWqmSG3Y6wRXetFBq+nhKijiEr6
	 qzT2s+IKkZsdEfOstlrG9ykbUtm46ksDuXw2gU1mHZUWR+23/E9jIZbF2nxBDtVwLsttK
	 Grm3JMh380HgQyWCSYsTqjJ13cvc9YqUC95NPUyBnHBCdfJae8SYFtQHZq6/MKJ4OKtCT
	 Vl0Jhig8Qi9EViF3ORJVdz0RlSckaA25hlTxJbNiFwAbkbDDY0KQv/FdHCsfej8o+/qo+
	 esaZ0nr/koHS6pW2oRnCkz+RVly9fmdPmqr1Iq8E/uAuxe+HBHWNmRCSmYUPE9IW9yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790178730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vy84pYWAKo5VP7nHyUzzJBGIeen0SUTjQOqitZ+Z8H8=;
	b=GEYNSMYY8PMf3xTUxFLaZOfNTy6PKYjRIoLEJS8g593Z2UhJ4xIo1sPoZYLzOSigPJE7
	 BZtgBVsxF0j8/HVSzsGuSogH7rKyx4qLJAZKaNIzGE/EhIShnsOK2Kk3Fz0zgfGpEDpZo
	 CFk1ASaGA7fCkIEmjsJzqUfOMoF7WfBT25lEjgH6k2CBMxv5qyTX7nV1Sm/fOa5lJtr+d
	 IO6kVIeWsocdZjPEJzMvI8XNX5zqFvu1SjGvb7VUH7pjRaJa5naYD79kvf77mbKHGcxXm
	 85ZBm8ex0zkcEwVAS7xntG88AesQbn5kHyJKfAqXNV2D5bWA1n7z4Ig3dti4rjjCmhg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790178730;
	bh=vy84pYWAKo5VP7nHyUzzJBGIeen0SUTjQOqitZ+Z8H8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvG1Tl73HVFjcCfzzOt6cBWE3esKXtIK7s6wFylxjN4InW+cENXpeoCPkvCjN/VoB
	 lMSMBHcluJfOWtdTtwJHG68zN+tyGoiAzG8XMVF5L/L9DJ0Wc99od0ltxrekjpmFAP
	 QWC/TMPs6zgm4VAR9vL0zGPWJ/YOuVNJK0bSzPjnaIVqbtVfqQVipIvfdcgk1oHD3n
	 KNgKN0HAtrVqHTZqCkcgHjsMEVn9Ugx+PV1Sz1fkLHqmSz64ZHv9jDjOtSXV7DGn+U
	 Q5JZr7JD+WdhAYDvdzfBPfL77Ih1E4TSNqvsh1vikxy/7PsSn1+svAUTVeqn+inNfa
	 S5wocerP1PY6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70E36089A;
	Wed, 23 Sep 2026 15:52:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EAFE13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90BA780C86
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oiTZipAHUj6J for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8297880C84
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178729;
 b=LZ56hgTSAvpNKszHnl+L2V0zOH9TeVQ1DoMLsLlX0UIPfzPOlW/neaB9QQHa1Py9hmFO
 5lrq4B/T0x6oeMosIl7QlqGcJqkURJm80+rh3SGiluElevs20abVfZZ8N5YrVV1CcU9Lo
 P4Ws8T7ZzFesSG2L9qK4AFo6XyeDu8qC+mf/RE8HhGqqYxVc2ewTnWBvT6eQF1PEmK955
 N/ll2X8Ut7b4K/k+kyhXltdGU1ww54wR4mygQdBn8rVF7E3wUZ/vlA8JmmCAY+PLnHKDZ
 YsHp756hif+577x+vyljb00J6thf6e1rnl0pzIs5rkndmNMKoZdoBM/YT0Uq9fIjf4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178729;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=vy84pYWAKo5VP7nHyUzzJBGIeen0SUTjQOqitZ+Z8H8=;
 b=Vo/28ogaC3h1pLs91jU0XqSVWoGL/LxzbyBenwfwz1PT2f6fSn7UevHxtFG+BomOuY/i
 0sT1xsUSdmms+nnPFTMHGc3VHxX3VSQ6v8VLQoui4k7ac87rGKG36s3q0eoMg3CdcSpDL
 Y/aJOmQ1OlhoYrNznB7fiXnMttRDdqL1pzLPntaeR+bkebtIAAYjh8VwXHVp/Fx4M/tcA
 ygYqtUjEH770JiHW20UeqWwMcmJG9WzSCALU+NFgar9LS4MfgjraQCDnP/XijC57t+dqQ
 dNgyT+uHehZKNi86J+5N+HBPfq657WNN5iVa/wj9Hcby1UMTSXPUsWBobZzIk9dY4CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BLn4gKJK; 
 arc=none smtp.remote-ip="2a00:1450:4864:36::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::11; helo=mail-lf2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BLn4gKJK
Received: from mail-lf2-x11.google.com (mail-lf2-x11.google.com
 [IPv6:2a00:1450:4864:36::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8297880C84
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:52:08 +0000 (UTC)
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b79784a6edso1009280e87.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790178726; x=1790783526;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vy84pYWAKo5VP7nHyUzzJBGIeen0SUTjQOqitZ+Z8H8=;
 b=BLn4gKJKwYCrSGL4gXlGuBZgYrpNkS2fHG4oAvNKF3rPFASRYJ6BHtmPAgF6JhCTTk
 UP5g8K1DJaxec6IibkTwIefMZOjUOAaDfpHST4bXNMem5GkLJ6XySKcH6fymym4hjSrW
 QNO3xGhQpGf7+oBLpnD43pjyc0YZuKii5RJL6aewZ+gSbvkkHwF0Qp0RFyS2b2IZalmt
 jgbBlMpV1Ptu+Bw+FDiDsTBr5S2uyyBlyP1uzzcVn8+9mqqufznBVJDVnX/QGCPqmAlC
 /ePxDug1ewJGaMo+oM8osff0CwWYWaZK2K5oRq3GjV1Y9EF73skSTTVmGXqQ9hzLEIgw
 rrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178726; x=1790783526;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vy84pYWAKo5VP7nHyUzzJBGIeen0SUTjQOqitZ+Z8H8=;
 b=dJk5R0CumiWSwQfFCQpSefMWxsXr22QTwLDgZpM8271UNKWslh2g7hk6+XYPZgSNqN
 oAfbZJ2UiTRWa9Rb9nLjlBGTEiWnFrN3cGi0qfBQzEO7ACKIA/MRn0QiC9b5Ea+AVI1V
 rD47njepohzXj3d9VcMGlxvgKat+HQTdamxjoJxhpYhTRyIKqyqtu9UGvg+laLCl4mkO
 HrJAPzsVQuGIYFs9H4xC8llC9ZGlY5aYNhgh74OZESCtp+s4uNz78PzBwIQPgYPe6nCE
 R1PCoBmH1jyOhtheuHYraCuDkJcWz1D+Tljv3XuIj0Tgv9epOK12QMPT76uAN07xM3Tn
 YNTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6o4ku9HsEdC31lo3L48AkbfCs+2zLpUGywoORSlGyzsLeEgDq9qzW7ggJ7/C+J5VE0/+dl4c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mNT+/0eclpw/t8nuG1k/WlGVEHVe8BtP+fgHZ6+0lcCCeFamZX
 cO4y2rE08XywRGwtb+/H7pYArwIsBuNrK9wH7JPO0glJ4P5advrnag26oBIr4Kt1W50=
X-Gm-Gg: AYBFou1QXvHXojqoB5y/U4+51v84bhKBmkOOzyDUID1VMbiPEltXzcb0ciqeb1vX1br
 w/+DgLHJLsHJfrpviuD6RSGjxiFQfDFchh2It/FY6FwVb3UBgD4MkKFKDsfbRGWy9OOPhHFzBhF
 J/RPXNC+mEMWdUUTej6kAIllrknJZDMIyMf8+vhgI5PBqDzs0YDAMZG+rny3OrOUhzbdhgO0HF6
 zLT0GOZIYlcPo/qd7jnqF2m615ZNaM9kLmBwd4honoUiRf1cCx3OpnpjfbinTkmWwTnPBXaL12m
 2UCgFoor+NtOgCFdi0WIbusfCxvILyuu+YL/mmZC52ry0m/wK4Zv13j1pfR8jsiuYmX96epOnGk
 pVci7inSYj+tTMSAaELgO61CJ/IUaEx54VVB3TgcHUKPQGpmdwdqPCkc4AW8W9BwvNOH7Cr2Syl
 UsqCYgcg+cTmK3/kVThxtHYjddaBnG2By0MpXWDH+bx54RuyIQy1wThmEQ29cpwq8u9eIuuiebI
 u9DHpChAuL4d+XGSnwMoD2i/IpIj7xf374W5hl9dWWwdUyONoSVkZ9G7O8=
X-Received: by 2002:a05:6512:3b92:b0:5b6:180e:3d6d with SMTP id
 2adb3069b0e04-5b8d893ced3mr873693e87.9.1790178725629; 
 Wed, 23 Sep 2026 08:52:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d857881asm735494e87.13.2026.09.23.08.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:52:05 -0700 (PDT)
Message-ID: <2572931a-0d25-42b4-9f0d-2aa3e23cf8b0@baylibre.com>
Date: Wed, 23 Sep 2026 10:52:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] phy: mediatek: add MIPI DSI PHY driver
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-0-83707ed5242a@baylibre.com>
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

On 9/15/26 10:00 AM, Julien Stephan wrote:
> This series adds a mipi-dsi PHY driver MR8183 compatible SoC such as the
> Genio-350 EVK.  The driver is ported from the kernel driver.
> 
> Patches 1 and 2 are preparatory patches: drivers/phy/ already carries 4
> MediaTek PHY drivers and this series adds another one, so collect them
> under drivers/phy/mediatek/ like the other vendors do. Kconfig symbol
> names are unchanged, so no defconfig is affected. Also sort entries in
> Makefiles and Kconfig.
> 
> Patch 3 adds the MIPI DSI PHY driver itself, supporting MT8183-compatible
> SoCs, based on kernel commit 2ec9c210c1f9 ("phy: mediatek: Add support
> for MT8196 MIPI DSI PHY").
> 
> Two deliberate deviations from the kernel driver:
> 
> - The kernel registers the MIPI TX PLL as a clock provider and hands it
>   to the DSI host as its "hs" clock. U-Boot has no consumer for that
>   clock, so the PLL clk_ops are folded into the PHY ops:
>   determine_rate + set_rate become .configure(), and prepare_enable
>   becomes .power_on().
> 
> - The kernel reads per-lane impedance trim codes from the
>   "calibration-data" nvmem cell. MT8365 doe snot have that cell in DT yet,

s/doe snot/does not/ (makes me imagine an AI generated image of a deer with
a runny nose)

>   so rt_code[] stays zeroed and the SoC layer falls back to the same
>   0x210 mid-scale default the kernel uses when the cell is absent. This
>   can be wired up later.
> 
> Tested on Genio 350 (MT8365). The DSI host side that consumes this PHY
> is sent separately to ease review
> 
Most of my comments were just for typos, so could fix up while applying if
nothing more serious comes up.

