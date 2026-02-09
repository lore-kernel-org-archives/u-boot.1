Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1C2E94622
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 23:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB8183C61;
	Tue, 10 Feb 2026 00:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tFazX9WD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D91A83C65; Tue, 10 Feb 2026 00:49:01 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8F9805D7
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 00:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d18dd2adf7so3014285a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770680937; x=1771285737;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eWYejEDlceC2B7eAds7tW3LyA7/0vQIbo8hy190u8nY=;
 b=tFazX9WD71dzbXSpWJDlJXLXnHZtf8lHoIT41WNWbaTtGLbGTxlqXVahF5+p5xL5xB
 3Aj6usuyH/QOZxL+pXnf9XPX2GQc9lDdTL7NC4wbXKA0CXue2orIIJsTaYZJa+YDORNu
 cKAehtEkFTlzt4HXH9eoiVp6dTFnS4M2nlp+I5KBKN4+4TuGoZ4z0deJM29C6vTqDv40
 GVP82U5+9cPPIEVsPpTK+UEo8vk9EBprmjVrbAxCGXeLf4Sb6NTcfdbshjM1PVW4fm9/
 mFpo1Umkwmnr+6Lt6AwTrivIcwtHCIWAOuw16rfAO3f5mUkZHKg99eGQIGhjG+IYiON8
 14sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680937; x=1771285737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWYejEDlceC2B7eAds7tW3LyA7/0vQIbo8hy190u8nY=;
 b=RO2m5TuwLU0OxXetV/kp7AbETXH0lHD2+xnWx1y+4Rqi5QGP0amzIQHKgPMyYi+0DJ
 BlzeNF0XyUhSOe3tU8//EBt66kMHsy1SGjOZlhiUBayHz/2JHZVnBSXfIn4tP+To2bBk
 lUgOfaT46ShP6bf7lr4KwpWjqDNy9ZMP0BA022HQ3qBlVNvh51FihsWSqwGSDfTSdRwl
 HpbmZwVneN/VgcRxy+BF8fJHYGRTyz8nTY/ozoq6xmw0SHLANXHYVrLqYxQbODZH5NGj
 9tg5ZIWpm7sOxl2PavLY5fcocdr1OHRN4Vhzi/7LBEQuKT+ISY6+ibr/wY5V/bIZ89e8
 8puA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYoakJg311Kes62CAa7OCM6ppRJcjzqAVm/CQO+3aa9xLbLiuMoAWhhZQiGsGLycAiY2FTgU=@lists.denx.de
X-Gm-Message-State: AOJu0YxTVD144lkNn7BDL3oEHNGsYUcrtO/k7zqblsW1Nnm6fxVr5QKt
 ZYYycUjeDal1tuhkVvYpBo3KMQy5AO+Cy+bHPztSOnXzJm6l2NJet93fJnZ3FKGtOx0=
X-Gm-Gg: AZuq6aKtzPBmZyz+ETUpeZRhontIbgN/tZjLmJ1b7feqMJERbY5h/FOoDPXIKeaGSYz
 540t45oZux485qV7f+DaDJeKF+Jtqj9iz5VFvihK3KwZf/xmik3NIqJnQIo+tnFeAoVbP/3V02e
 IGX7hyTcuT2wak+oTkLcxxC/IKRAOIsvSbCqkPNZAtvb+20qiKDn07yq27ev1nIhGimWj4CC2fT
 WzghzqHUzDg/RRNh0hFCL9G6mAnlkRrIPfh36a4sUEujo3p/5Ecoym89+qkTVgyjVnqKBjkl4rD
 lv+OFjZWdmrRveW58vCzbu7PoUlYyFqTwwa5fWxKCPPqQmhB5P7Qxaeuql380heg9Ciw/MTo85j
 vyak7ZPGSIBM9QvLJNUrxVHZ2E0DRoxWCGbbtiwWXI0gyFlWuoe/lyxWO6nDO7AdGjHZtUQTUyt
 v1f7N95GawqQJ6Jfn8heKhVWU+A4T/4eJZ68PtvmB4TnH8Vevm7iLpoXsJ4g7OQs7PTk+0Mo0l
X-Received: by 2002:a05:6830:2a8a:b0:7cf:d6d3:df0b with SMTP id
 46e09a7af769-7d4998a2e48mr146465a34.21.1770680932385; 
 Mon, 09 Feb 2026 15:48:52 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cee0:eb0c:b683:ad1d?
 ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46479b8cesm8440344a34.23.2026.02.09.15.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 15:48:51 -0800 (PST)
Message-ID: <42ff1e61-d898-4f3c-b3d2-84f31c396b40@baylibre.com>
Date: Mon, 9 Feb 2026 17:48:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: mediatek: Add Genio 720 EVK defconfig
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
 <20260209-mtk-mt8391-initial-support-v1-4-b23ab9d0b9bc@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-4-b23ab9d0b9bc@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/9/26 12:23 PM, David Lechner wrote:
> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> 
> Add a basic defconfig for Genio 720 EVK, which is based on MT8391 SoC.
> 
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

...

/configs/mt8391_genio_720_evk_defconfig
> new file mode 100644
> index 00000000000..07e7bebd0ad
> --- /dev/null
> +++ b/configs/mt8391_genio_720_evk_defconfig
> @@ -0,0 +1,28 @@

...

> +CONFIG_MMC_MTK=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_MT8391=y

Small mistake here. This should be CONFIG_PINCTRL_MT8189.


I'll do a v2 to fix this and add the addition pinctl dts changes
I mentioned in [1] as well.

[1]: https://patchwork.ozlabs.org/project/uboot/cover/20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com/
