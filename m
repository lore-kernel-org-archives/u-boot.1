Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAD1EE6B4D
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAA883AA7;
	Fri,  6 Feb 2026 21:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m1dyn9R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B06D83AA7; Fri,  6 Feb 2026 20:04:55 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E12836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 20:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45f0c1f1b54so1538999b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770404691; x=1771009491;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7utJJ5L7DEaFuikmnawKtiDrC5499RspxKNI2We8oP0=;
 b=m1dyn9R+obJcF4it3D5tmb4KpodRE8g0yeojcNUqzQu9bppgQnayc3M97kJJioWWaM
 Zs/FIV2gu/k8KF3H8duHQvBmafsgMLfvc5fqedBGTMKq+OgLvBZRy7VA2qAkF8bJjl+Q
 8zrZZX264MtCt9EsFmt65rG3cTscc+efEDKsRMrgn2ApfS0WbxQeGKlhIE5icIISdwNd
 qTBOqXeo5a24qUtpTUU4MyeciReKdZ1INzFPR6zkji1NpYe1FTN66DsJ8iv7ONfb3J/I
 dwPH1+ub1ib7nuf4A8YmQgmEk+uUyaaGzDdeC6rZLWdQh4ayxQUuxTkWf1aE/cKSruv9
 IjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770404691; x=1771009491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7utJJ5L7DEaFuikmnawKtiDrC5499RspxKNI2We8oP0=;
 b=XUK6G0x/ZZAuqNf2kbDpsmVexAAdiCZxWgbbZlCwcW3Z22BUMEM4HuSz/K9ehLPKbF
 kPvFvQOlUm/Y2DEAuV+kjo/nFUYTKiPzDYn1rdbRUaUfL8pCh7pfmYpPlmNcwEeeF9F6
 6s7mBKFWgdYIrquPbDwMdhEVBo0AwtEQEpBIsAwRujJlW1k/5D7rrDNIEZZMR8PJqOSx
 331OoE/SIAGmqresHauG9y2aH6Duri9j0OqUTmtu3cLxGFY6aFfqss7uZE7uoBt4f6mT
 NM3gRuqaEGNcRm6l5X7sp5QYlmoIm2HijZTBe3Jyi0Nr5q9ezf4llPfKNHtJjHTp1CE1
 37Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKNIt7vTrcOfBi9/fMmCWtQjVTPWPm4KX/YtSxDxqdlFOc6rQOzyie/5tIf8G1rwe2JWZ4Mx0=@lists.denx.de
X-Gm-Message-State: AOJu0YwFakzq126ZesvTQWxRbW3Z9aY8ybsG/T7Me2CSYLdAugqiyL+6
 07Gzi1nTRueE/Wzm4espUaFzAU+wjfILSxtK7zYHgOZmMeZznZgl1qYhUMd/AEv9mOI=
X-Gm-Gg: AZuq6aLbRXrJ4ZEh3AdDRjy4a4n+HQgRI4GbTC4EoMyc39WEOvG/rgaN5EQTE6Zi8p9
 /Qz75/wnrkCnP6R5Fqoz97YPCCq1VEvPFZKwwl1arVFRp1hY2APXnN4oiQNFnMq36uXIvSHTfhj
 N6FhM/uHU86mGWTk776dQEeifBWcCiD2rX0c8a7+mqKFqu9vwKAifr9gh3bjithwlNc7segWFLL
 o5WFzZ5GUem653YcQBufUKIRBsd/FMs243Y9uNB8zdTeSty6YYXooEkBZIMy3+SAbHaMrmtwRkg
 wKbujI6FPMw0Rt5p/XX0aCCeEhD9c1foCWSAGSbTYfpVbNr9wMX86W4IgtAkbLDAiAyZvT5wcvt
 6H0uRg1VFP41Wvm80k+4uev1w1jWDoGmLYq0eLA1ZlaBKj+sWCgDIHXHSolpuOOKpzEDUML6J09
 Wp/FIOb1HRuiASGA3uwPMM/vfsPKRMy2i284/C88dtTh+knl0oKn0ISEI3soMm
X-Received: by 2002:a05:6820:4dce:b0:662:f74d:69f5 with SMTP id
 006d021491bc7-66d32fdbf3dmr1535240eaf.31.1770404691384; 
 Fri, 06 Feb 2026 11:04:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7918:a69e:53a3:9e1c?
 ([2600:8803:e7e4:500:7918:a69e:53a3:9e1c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d38bdeed5sm1566823eaf.4.2026.02.06.11.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 11:04:50 -0800 (PST)
Message-ID: <49be5379-dbac-448b-b894-b8b8925b9b2f@baylibre.com>
Date: Fri, 6 Feb 2026 13:04:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] clk: mediatek: add clock driver for MT8189
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Chris Chen <chris-qj.chen@mediatek.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
 <20260205-mtk-mt8189-clocks-v1-7-bbac40932c2a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-7-bbac40932c2a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Feb 2026 21:09:44 +0100
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

On 2/5/26 3:12 PM, David Lechner wrote:
> From: Chris Chen <chris-qj.chen@mediatek.com>
> 
> Add new clock driver for MedaiTek MT8189 and compatible SoCs.
> 
> Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-mt8189.c | 1738 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1739 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 5bede819c0d..a8be9adf18e 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
>  obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
>  obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
>  obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
> +obj-$(CONFIG_TARGET_MT8391) += clk-mt8189.o

I just noticed a typo here. Should be CONFIG_TARGET_MT8189.

>  obj-$(CONFIG_TARGET_MT8195) += clk-mt8195.o
>  obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
>  obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
