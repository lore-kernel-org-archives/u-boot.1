Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B399C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B723A40714;
	Wed, 23 Sep 2026 15:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hTWzTzTat5Ir; Wed, 23 Sep 2026 15:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0847440689
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790178664;
	b=nqivp58pfnlU0LM/tve3Xttk55DvULESXwEqhTnsBCSUm12KGLvX6CuYxT/v7/AJCq6d
	 0lleAqPma2Zmyw2/A1BU3OvVpUzIfN+LYwlckixxvIX6lL92NuBRvGr6zVXc9+hExWJ1u
	 mloNIoDAgaPqjVrPRRJc8WW5RZQtW0wtn8qqHFAu81mVkSwCuvOMV+i+WQSASplGN44dW
	 eyc2SXIsmQTRpIKMgT9KAh+B/9JkuGsxWK6vr0QbpO5+n9wtOs2T4GIZCUlxVg/UTIMNN
	 dRVyWCsZkJ9SZLgEF7kiUcef1aVA0U35ttzD4Fvg03CJxgu4EQxZ81sTidL2CqMZP3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790178664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b6+CkNOQ2QDqAvL4wBs2AgeU3BR/LFcdrVqLu0+rqhs=;
	b=HlNsIcmh9kfHu31Ei+Oo7ecev7yw4pEnUeaf1r+vZLxkp4et37KVW9MJKAD4eQYZbUts
	 0ysiUbh4Qkvnx3dybFkxeSDO1/oUqrE42GFOipeLK6OP9w6bWgBW4QBh5z7rDn5NKtQIX
	 UbQdn11wKkGZTH9FCKVt5eyVzZ0TEy9YbOD45vDZTsoKbXfdne75boJZwgfzT6wUzfD/1
	 C1X50xAxxF59x15mSBKjL7Zu8GM27keV4St/Jt+3cSxGnqECQaSSlz0hB0lWe6EgFdVkf
	 bM6qBUkMKRryLVX9wPB3TQ558skO7UQ79Ol4Uv/NvsqgX+Gm/aHVm0hV50OPK7gJ5GA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790178664;
	bh=b6+CkNOQ2QDqAvL4wBs2AgeU3BR/LFcdrVqLu0+rqhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zkOc7HKihoCaWmYQ/r01Suvht8BnzBTzw24btcxxQP9TyUDGN3K7BiaGXBhPzsnC0
	 6e45iKlffR+eVw4o/OBmpLz7Vl2/vtUDDdzF897R+ffB4u54ZRT6LeArO+xHLhKlus
	 LMIS03eaoJEWTZYd4EA2AUljpyynuV7IxgJo4nmkJtKjFoWouyOYowPC8I5l34le03
	 ZKsjjoem6iZS5NL4u93zLpHqyIDDumPrjO/ka7AML+5a4PeqFYqa5dDVv68WETuycb
	 pUDcek4MR+oGYrQENCKWHuhtutbWljTL5AZ7ej0jueFMvqTVaJysJPN8vKA0sd9En5
	 qikXKaGP6Wc3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0847440689;
	Wed, 23 Sep 2026 15:51:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 806AC13B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E3C260890
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZBHBjruBhKM for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8763A60889
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178661;
 b=Y4hY/QNi7MmP3+SWe2wHAQiLYi9uvcnYkZBzDuk3494IVik3peP1Bbsa6NnUuDf5J4u5
 PD4AB7Pab2AgT9KCfOZ3mKpG1Pe9m1qVjFrV360zkKyZ9NBTAyZG6V9tExqH3m7oWV9jT
 CwjTSpgw66vQMUC6iZ1YfHUa63Hnd5fwutEchibQbm4SBShozm2Vjguq06D0ez24c9dqM
 xtnMLEzk+Bl1wYqNosx9wPGFw5fzDyLufFPhjVybbdhvDGNsYDDNoxRij9TnzxxUI6+57
 WvuI2yRNXENexSaUv3s7HJP8pME9Pr4LaX3VBokYrgjaG1Au54SPvFvV09Z4KtXCtGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178661;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=b6+CkNOQ2QDqAvL4wBs2AgeU3BR/LFcdrVqLu0+rqhs=;
 b=qyl0JGX/Z+dc7w6OtmyGFDxXh6LkmN1QMOMJg/gBLie8Pevug4M5Gqg1qSJo4ZLK7Gx9
 o8HBrxYF2iLqgN+gcKMO74G0vkO9B5RiApwyu6n0BkAnI5HRTN8ndqmhu7Xfrl3SJGT7+
 3bUb5gtX0SN7sCEc6XQ/atJe+ZnnJACFJ0vwucZxXV1fp3YY2CwFACqbXiOtEQw53Ccj+
 cpyBkCe6gJilAs61bwBpma/8QxjN70eImzmYaoRlKBoJPe7XxpHM9Vuue6X/lNR4xDjky
 gVRWQh5zVtn69WM32Mlm7j7azesncd9POcvSd8LqRyJkJ2w4WpPif7BA4B8CW4vNIVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=O9d2xyLa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O9d2xyLa
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8763A60889
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:51:00 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso7664e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790178658; x=1790783458;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b6+CkNOQ2QDqAvL4wBs2AgeU3BR/LFcdrVqLu0+rqhs=;
 b=O9d2xyLaM6oQLX6H33XSc1zmlDh5g1OBQ9q7pGqaFdKTMXD1tH57kT4mNDy3jJMtZb
 bIg0i8oKhpJEs/r/pm7e85irNKWwj9ffTFr0qUmKUn6yX7ySAdTrIn2qV4cCbyJ6nYDE
 GJbqyHPE6OfKi92CtDlDbl0tvUBe2DjBvqE4tEK9p0pSxer3BzL3qzKIE4agEyrxl/7I
 c288FL1w6i875wA9xgKuhFadHr5r/sOUjmEIPS0Jkmgfi474an4oCeAmNVJQNU4PrEYo
 FMIfsSf4rblRJxXvuJsGw0va8nz5YQtoErsT0+3WV2kz83k1Mz1pcGUhhZIuEermBazy
 e2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178658; x=1790783458;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6+CkNOQ2QDqAvL4wBs2AgeU3BR/LFcdrVqLu0+rqhs=;
 b=I5wlm8A+Sg8dugPJBPazLUIldnYjliwUn1q7q7rxLF0yi6SIh7C85/JODZpEPr4zrT
 LdDcd7RPB7kwUE5u3wHgv78CgTaKm19FmPExlkF5oqm+tPkI0a947ddvB1bQJJO8mxxn
 wXXYXonFXFoCDyzZfZ7z+o0LiCAyPKpg3qaGWr8AnETxW3IktPp8IQloPl18v7h7vps1
 CgFCuyrHv+pifmXiILECWt8JoJ9B7DJbXFjxc/kQEPEgYcebAGAphFiGCRSjqN6mLtwZ
 6w2/C2s0wtz+p4PuboJrT3w7DKqS7WJUJi3Ns/10QYsS3cY0NdhTGhFq2kqsKzQBetTU
 Mujw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPcHPRCslpUA7fSn+USXXJI63Lm7WWZMFPJpqtBd/lCanoWknc+/lA31BYeElovt10fgQvLGE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nt2PAH6upI3BP55V0PKD3Ju2u3U4jT03t602P8dVk0p4ZSq0SH
 2VoPqiGYXKG/2NACDOeXMKeQXvQA6AwhL+G9lSpn0bCqz2JCJ9TGQ06+inctYwoXFdQ=
X-Gm-Gg: AYBFou3PKcbILYF8MMgLBu5NR4reCYeqMo0Lu1Zg0ySFPuOfZCE+LC1SFxVULiKKGmw
 rKk/YyYhlsC4YdB/F1Jya4lYQI2TkwOcnxEq2EpWXvM/jn5i468HvVAiCxEsSge+9fOo9vOMIEE
 VmiB4nFtJdBf4F7JkVuk7a+dptIGVV9+zL6+k2zoowHklEzM0wKHgTTOLYHLDnMAEE7LTwmtBit
 AdqCmtnl/M0m4/KFjhcdJmM4zKtFuKLCop0xBV5p10OAhDwZhgqONFiRWMfAnBEcD3QUcYSY5ph
 qIcf4GzzPHJrnBIeoyYTwwI3PDWqiBOwhfDLwFHX7SC5i9NCw7c7XN3/2Bg3jmoqBkuWx5wsTcC
 CYa+hvQujktsYFy0M3z41DP3C2WyUThCIdRIHbNRwZOQbEXLgei4o0Ha/KvQJPnZ9EWx3m7nN+i
 Iuju7p8P3Ri2l0YCx1QWvCrur8bcsp51B8IdFgjgCO3AfC84k5Er7gmQ2v+8ysvVGo6d+o9wUyC
 cD9CsRzgzuTzBzWVWeQwPNfPCBY59ZkgVh6QP8xctf1Syyw
X-Received: by 2002:a2e:bd8a:0:b0:3a3:61ec:43c3 with SMTP id
 38308e7fff4ca-3a624db6c3cmr14690911fa.20.1790178657898; 
 Wed, 23 Sep 2026 08:50:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d8580c16sm712323e87.42.2026.09.23.08.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:50:57 -0700 (PDT)
Message-ID: <1bc1cda7-cf04-4962-844e-423e6e0805b3@baylibre.com>
Date: Wed, 23 Sep 2026 10:50:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: mediatek: move MediaTek PHY drivers to their own
 subdirectory
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
 <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-2-83707ed5242a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260915-mt8365-add-phy-mtk-mipi-dsi-driver-v1-2-83707ed5242a@baylibre.com>
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
> drivers/phy/ hosts a growing number of MediaTek PHY drivers (T-PHY,
> XS-PHY, UFS, HDMI). Other vendors already keep their PHY drivers in a
> per-vendor subdirectory, so follow the same layout and move the MediaTek
> ARM SoC drivers to drivers/phy/mediatek/, together with their Kconfig
> symbols and Makefile rules.
> 
> The MIPS SoC drivers, mt7620-usb-phy.c and mt76x8-usb-phy.c, are left
> where they are: MIPS MediaTek support is kept separate from the ARM one
> elsewhere in the tree (drivers/clk/mtmips/, drivers/pinctrl/mtmips/),
> and Linux does the same, keeping its drivers/phy/mediatek/ for the ARM
> SoCs only.
> 
> No functional change: the files are moved verbatim and the Kconfig
> symbols keep their names, so existing defconfigs are unaffected.
> 

...

> +config PHY_MTK_TPHY
> +	bool "MediaTek T-PHY Driver"
> +	depends on PHY
> +	depends on ARCH_MEDIATEK || SOC_MT7621
> +	select REGMAP
> +	select SYSCON
> +	help
> +	  MediaTek T-PHY driver supports usb2.0, usb3.0 ports, PCIe and
> +	  SATA, and meanwhile supports two version T-PHY which have
> +	  different banks layout, the T-PHY with shared banks between
> +	  multi-ports is first version, otherwise is second veriosn,

s/veriosn/version/

> +	  so you can easily distinguish them by banks layout.
> +
