Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9BB105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6C884307;
	Fri, 13 Mar 2026 15:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E1ZbR9ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A4484308; Fri, 13 Mar 2026 15:26:40 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA5B842FC
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d74a59262fso2033300a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773411996; x=1774016796;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zI4Ghg6UDIpI9zZFXP1fpMVwbJV8AxL9pe+lrr/c7IE=;
 b=E1ZbR9ikaeLZ7FcpqubraLLaXB9HCPbzxCteLDnygPyMQqwxrcJmpkpEAkKq9E2BIf
 hwQnSXBAUQs/Ib6NTTidpa3IaWedTyPrWVvIIjZEgoT6KUzDcQonHk/lRF3q8UOKZ++O
 EYWZQ+ixfhbhK6+v2NmWhWBRhMJSYJkzWlSycuYGG5K+Y2iASGctS8FDHq+5GeziBFjt
 zJ4dhZEn1+i/Yfmods3sl/Jbf4re+XjZ58bsOY7lpT7h16wWgKeqsalPjY27RR2iy5Lt
 bK9GNYEMNfBZOr+XFigdFS4oPpFkGdWhlcdzLBOU+Ja46Pz47E9le58vUUpaKz6gI8jF
 q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411996; x=1774016796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zI4Ghg6UDIpI9zZFXP1fpMVwbJV8AxL9pe+lrr/c7IE=;
 b=LdzhiyqG7EHGSYFYmvPWEeTaidIKx4ZtjiM7eKb4UR8Y5vauuWWZC3shEtWo6VBZro
 Xf6puz4nMWPPjUdN6j9rvIL6ifEDvdKJDubB+fo8Zz/RJVNpvC/t6T8Rq/u7za14jG8U
 v0RmCg1G4aXKYT+8W7/Yfytj4zNZevHUc91h/SvSpCYYq9+mme/h5NxlFuOOXOXqmeAw
 E1Yf8wwMCg0GPBALcH9gmSUn+zaCpe0jVexoZ6vVjb3O1y52/5l3Iq7b0NhD6a+fdzBI
 4EWwPW1lHGIDzjslGyUSwiJ7mundwUm2+xyPSbZNihiRYrAyBTMzQA82a+j038bvmZKs
 nzHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTPoygwcWkQaPBxH8SMTEFFdslFGQuFykQ02et2QsmZK8Rf1YF/vpRclK1T16DTF9/rcYbSyw=@lists.denx.de
X-Gm-Message-State: AOJu0YwblAtwtMOEVXUC51IKeBQjR7HurzNNhzBpgUJc+5PeCkrW/YCD
 MKO1Xp3INMhXwfkx6WdKuSCjMJDFDw4Scweib+jGVVUAKa3F6Al5LKgf340s6ylsf1btOQe1s2J
 TrN8n
X-Gm-Gg: ATEYQzyq2QWSAzI9VQFL9VSjeYsrVP/h7MqI++z2NVSaeqPhyI8aU/TnzzX3HxgWWPd
 qxkhoqSm/AN1oG7GgnNElCyvnj+5AmpcE7bA0Oi0JSDyvUUTcrnTJcC5G1Oq64F6r2/eBsE6cKC
 ZCriz9Bbk+7LOJdPAnUokZGSpJN0TEscKU8l4HVHvkI6CUuBHfCqwt5k/nQnz4IqqHX6q+476Aj
 PVsqY6HJAA0nHKD1BH5dfXlZvOicB7siU6/u2dnAoCKxHHBOnAsGs4ZHhGo51Mtu6jAHru3eGLN
 xrAgM0H00WPyF2tqvXPWBPJnW0/sSwlxJOdd8zoErR/w6+RvmVulpVOiJ+EU82MMvwC+H5bfHa6
 s5XGm1CTw+cHzKwLiHz0LlsClRvpbPRZLoBeIp0MsvzXiCPIDzZl1pnBEDqGmrUc8GWmT4XoRXS
 /qQS6XKHrhpVPio5r6Zey2IkQsUjGSA3lVARGSOgiQUNBNSSv+uqDkA2HhCWrEkkpw5dFxyOsHc
 L+R
X-Received: by 2002:a05:6830:6489:b0:7d7:551b:aeeb with SMTP id
 46e09a7af769-7d7823345a7mr2383883a34.0.1773411996638; 
 Fri, 13 Mar 2026 07:26:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:bf:9982:ff59:466?
 ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm6505993a34.27.2026.03.13.07.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 07:26:36 -0700 (PDT)
Message-ID: <ae3517d6-fb57-489c-8029-f536ef68fdba@baylibre.com>
Date: Fri, 13 Mar 2026 09:26:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] clk: mediatek: use correct struct type for
 infrasys clocks
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
 <CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-8H1mT7S2FPD3_X7dw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-8H1mT7S2FPD3_X7dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/13/26 7:53 AM, Julien Stephan wrote:
> Le mar. 3 mars 2026 à 20:55, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> Fix the private data type struct type in a couple of infrasys clock
>> functions.
>>
>> struct mtk_cg_priv is a superset of struct mtk_clk_priv and has the same
>> layout at the beginning so there was no compile errors or runtime bugs.
>> This could only be found by inspecting the code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/clk/mediatek/clk-mtk.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>> index b4de38719e1..b3f05bf5a21 100644
>> --- a/drivers/clk/mediatek/clk-mtk.c
>> +++ b/drivers/clk/mediatek/clk-mtk.c
>> @@ -933,7 +933,7 @@ static const int mtk_infrasys_of_xlate(struct clk *clk,
>>
>>  static int mtk_clk_infrasys_enable(struct clk *clk)
>>  {
>> -       struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
>> +       struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
>>         const struct mtk_gate *gate;
>>
>>         /* MUX handling */
>> @@ -946,7 +946,7 @@ static int mtk_clk_infrasys_enable(struct clk *clk)
>>
>>  static int mtk_clk_infrasys_disable(struct clk *clk)
>>  {
>> -       struct mtk_cg_priv *priv = dev_get_priv(clk->dev);
>> +       struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
>>         const struct mtk_gate *gate;
>>
> 
> Hi David,
> 
> I guess we should also update priv_auto definition of mtk_clk_pericfg
> in clk-mt7623.c ?

Good catch. I think that is something for a separate path though.

> 
> Julien
> 
>>         /* MUX handling */
>>
>> --
>> 2.43.0
>>

