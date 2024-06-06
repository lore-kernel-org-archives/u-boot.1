Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0BEC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 05:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050AB88440;
	Thu,  6 Jun 2024 07:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717653494;
	bh=P6omtETyKMaFvfh59fbPiWPcMmbRSe4zV2MQDvVu3bM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dv5rncgRnoszpY2sg5zHUkp7wBiEEUatWpmEj0KVaF++1DDA8HsHyKjeqJtBo6E+f
	 /TcN3+jcYrWEPiYSLrvTTnEUznOfaM0PvtTKBCUikEKoP9K2wql+WyWvSwqDjuWgCa
	 nDvUu9mst5jkpyYz1l/6eqLPzBcxsQ+t5o8guK/pIM4g7uJ/DX8spijd7CJKmiGRxx
	 DTVWPXJ0k/A9FoauiRospLEmDUTwBTigX7miAmq69jt7W46uZONOQeqkM4wrwIVThX
	 IXVZGz+AelVpm/jBXaq+1hMOlrnBEWubWRTxOkzooWTk4fFJBXl8jQlHUEUKUrXq1b
	 HkdlK2RoM0Kkw==
Received: from [192.168.1.107] (91-82-24-13.pool.digikabel.hu [91.82.24.13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D7FE3883A6;
 Thu,  6 Jun 2024 06:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717648084;
 bh=P6omtETyKMaFvfh59fbPiWPcMmbRSe4zV2MQDvVu3bM=;
 h=Date:Subject:To:References:Cc:Reply-To:From:In-Reply-To:From;
 b=CbHgdD0S3s0oyCbxa2hvsYC2VRi9ZA0OMdnT227bnNEvi5I2sYHhGEorTxvchLZIX
 HmNNVpTHE6LNqRHtY1AeFXGH7vtGrEl0uziMynZ473fyr2DGzkzzxbwfESfKmYGXIC
 qTvciOZA70Nyb3s2cCpDMuD5MuDGW6OQTzNrxuZeTsJq4iC25b1MNGxwpTxLQwDLuY
 1+b/ZhTgiiQ5emxfu1s0O14WkNwqHIkW6PdNnmHcHqKA0+nYEKV8SyPEnhtnzGjA3S
 qe0VSs2cn5byCimq0dAt2Ospb32MaWL8wENAwhYB/0mZ116YNvSTz5OBOz0L20Nyva
 hOVUw6vDInmMQ==
Message-ID: <8abcde75-c37d-b2f1-0d43-a3d6b72d9351@denx.de>
Date: Thu, 6 Jun 2024 06:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/11] i2c: mediatek: add support for optional arb and
 pmic clock
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
 <20240605190220.17616-6-ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>, Michal Simek <michal.simek@amd.com>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?Q?Nicol=c3=b2_Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240605190220.17616-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 07:58:11 +0200
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Christian,

On 05.06.24 21:02, Christian Marangi wrote:
> Add support for optional arb and pmic clock for i2c provided in upstream
> linux DTSI.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/i2c/mtk_i2c.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
