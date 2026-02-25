Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BAFD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88C683EC8;
	Wed, 25 Feb 2026 15:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p/em0ZcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6700783FB5; Wed, 25 Feb 2026 15:35:49 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BCD83FFF
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6774d63d2e0so2249718eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772029967; x=1772634767;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xa40CRykofcYq1mlQsfoEvA28d2A6vpDTrbjhGpDXzc=;
 b=p/em0ZcRLAmDiB1SKAb5uKupSSCL3fhZa3VAd8/enuDGqU+S740CNijQq+o2jBZNVT
 1ug4Ww8/FEshGymspfNiqiqXHpZcTCvZSVwpE0XvrSv2ZYKo5/wqgQVon+JzCd3JzgoB
 zJ2CfczQ9tRt/etZhGIv5FEC9iD5UXdBN5SMk6kPta3OSFLWrg+AHaTo9Ga87iLLwAu6
 b70O+6scZEezT7JURn8N1Jxng8PLSoAU2judcOwGaNQ/EGPJKYh4cvcW30CTZzale+xC
 H2G+VUl6rXE9jihm5QOBDuyQIJ7044j1XoI5NVA/bCq3wxVv99zqdSGC8ZYc7yqBKX5J
 N9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772029967; x=1772634767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xa40CRykofcYq1mlQsfoEvA28d2A6vpDTrbjhGpDXzc=;
 b=Sow8g/xvBbbSjhjwmA28cg776fMnNCsUJ0UraYzRw52YgQCiLd5kt2uhxWGhmFSXg3
 Q+rYYLlr1UUFEq38Pj7ac/MVsHzl8VYSsifJzYlNlMIW/ioswR4mG/Hf1uA21fGJ6Mwz
 0AiKWoqHXk9ioJYHSn24NDUGCqdqMtkeAj8M0Azvx4w+QUHqPYba8OS65tlqVi26DnUy
 Db6MPBISm11fdVGhzdj1vmbPY7gXufFDhIcaXYfTrCnWRi+HQ1/Mk6lY+7LcV8DC9uGA
 MSB6ThKIZ0LvPd3O5GnUvve26tNw3C3sMe8rtbCFUuxhR7YPi+c5r4+mqdusnfirqhCa
 5W5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh4+E4aKTdSO3zEGHXHdbPW9D2aSE7jJ/XCn5wM4T82Nlsu3CaFeWo2YqU7Gx+1/mq08qJqt0=@lists.denx.de
X-Gm-Message-State: AOJu0YxvA/sYPpeb+IMyAsXF2oGg3EWm0u4AIplg9L3L1zfKnCl7UBb/
 xZ4HJb/nxxDFOCz3zn3O5PqdO0m/XCmm4F2RLTL/WaI5g2c79uuJ7IVtdKDNgtLzaRQ=
X-Gm-Gg: ATEYQzxHloFIAKKWhdoSc7T/oO5SppsJW6nZfqWU8x0sGLKNmqreAdeB6WMYYAaunFx
 YhpucnP2RPgxN9iTRirBxFtvCqqQQOTOFl7PgojothLit9w+YEUGQfceFzwx1oLZM5fsWtwzUVA
 6dMbhbiVt+/Z6oXjAa7XUG45t0T/qojI5R8B8hDXJHDmU8QQQHZQNihACz1D662i7Sqneue5iuv
 XRqMklxSxffMvHCSjWZhsJS/KABhi55X729Z5PSLvTRj5dEAjVG0zNshhWJWQaxv1Um4iGDfsjM
 CQzocGSna+vFgK+a2nZcueH12p06LOong5X/UvHnUA/8DT4j1lkOS2jiiZvV1hJ2RmhDqbPoRI2
 44k0TMSlL6rbGh6V5zN6smoc7bBHnzPB28ZGz15KvSJSMOhN5NZsKYqkSCA4Iz6WrQwHomFb06x
 S+UgZuzTq7DZS43PK4E4dDuIpvGJ5EvyxH0JbAAC2eM77XEQrWuYKx/gDT+FMrVg2qn2KTbzZYh
 FkwCOoyuA==
X-Received: by 2002:a05:6820:1903:b0:66e:4279:3de7 with SMTP id
 006d021491bc7-679ef99ef2amr271533eaf.53.1772029967506; 
 Wed, 25 Feb 2026 06:32:47 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f?
 ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679e546f4a1sm2481562eaf.5.2026.02.25.06.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 06:32:46 -0800 (PST)
Message-ID: <cc219fa7-669b-4ede-a416-4f7a76b28ba8@baylibre.com>
Date: Wed, 25 Feb 2026 08:32:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: mtk-sd: add mediatek,mt8189-mmc compatible
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
References: <20260206-mtk-mmc-add-mt8189-compatible-v1-1-5243eb8b7e2b@baylibre.com>
 <aZ6gwSLjH8IYY_uE@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZ6gwSLjH8IYY_uE@nxa18884-linux.ap.freescale.net>
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

On 2/25/26 1:12 AM, Peng Fan wrote:
> Hi David,
> 
> Thanks for your patch!
> 
> On Fri, Feb 06, 2026 at 02:50:06PM -0600, David Lechner wrote:
>> Add support for MediaTek MT8189 MMC controller.
>>
>> According to [1], this is similar to, but not quite the same as
>> mediatek,mt8196-mmc.
>>
>> Link: https://lore.kernel.org/linux-mediatek/20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com/ [1]
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> drivers/mmc/mtk-sd.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
>> index 4928a880038..7a4bdee7496 100644
>> --- a/drivers/mmc/mtk-sd.c
>> +++ b/drivers/mmc/mtk-sd.c
>> @@ -1979,6 +1979,16 @@ static const struct msdc_compatible mt8183_compat = {
>> 	.use_dma_mode = true,
>> };
>>
>> +static const struct msdc_compatible mt8189_compat = {
>> +	.clk_div_bits = 12,
>> +	.pad_tune0 = true,
>> +	.async_fifo = true,
>> +	.data_tune = true,
>> +	.busy_check = true,
>> +	.stop_clk_fix = true,
>> +	.enhance_rx = true,
>> +};
>> +
>> static const struct udevice_id msdc_ids[] = {
>> 	{ .compatible = "mediatek,mt7620-mmc", .data = (ulong)&mt7620_compat },
>> 	{ .compatible = "mediatek,mt7621-mmc", .data = (ulong)&mt7621_compat },
>> @@ -1990,6 +2000,7 @@ static const struct udevice_id msdc_ids[] = {
>> 	{ .compatible = "mediatek,mt8512-mmc", .data = (ulong)&mt8512_compat },
>> 	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
>> 	{ .compatible = "mediatek,mt8183-mmc", .data = (ulong)&mt8183_compat },
>> +	{ .compatible = "mediatek,mt8189-mmc", .data = (ulong)&mt8189_compat },
> 
> I not see this compatible being in dts/upstream or arch/arm/dts/,
> so has this patch been tested with upstream U-Boot?


It has been accepted upstream [1] but hasn't made it's way back to U-Boot
yet (famously, the MMC pull request was rejected for Linux 7.0). And yes,
I have tested this with Genio 720 EVK. I will be modifying [2] to use it in
a .dts in U-Boot. I am still working on some other dependencies before
submitting that.

[1]: https://lore.kernel.org/linux-mediatek/20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com/
[2]: https://lore.kernel.org/u-boot/20260209-mtk-mt8391-initial-support-v1-2-b23ab9d0b9bc@baylibre.com/

> 
> Thanks
> Peng
> 
>> 	{}
>> };
>>
>>
>> ---
>> base-commit: e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9
>> change-id: 20260206-mtk-mmc-add-mt8189-compatible-6a71d5c710dc
>>
>> Best regards,
>> -- 
>> David Lechner <dlechner@baylibre.com>
>>
>>

