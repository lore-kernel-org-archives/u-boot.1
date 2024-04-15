Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35FCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74FA88228;
	Mon, 15 Apr 2024 11:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="JWZh+XDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485F888229; Mon, 15 Apr 2024 11:59:43 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C84881FB
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240415095932epoutp011c89741c2f04b9cd7d44b63f7a5f7df5~Ga74NfOYR1316213162epoutp01Y
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:59:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240415095932epoutp011c89741c2f04b9cd7d44b63f7a5f7df5~Ga74NfOYR1316213162epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713175172;
 bh=30nxeKAPkYLXiCak0ftemAYss8CeYpR7dDxyw7xJos0=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=JWZh+XDOuRW9N+QE2YdfYzVm8AwgOFG5YK3TIO3yRaEdliv2DBlqUAdB75OiXQpX3
 NKLcW1mhPS/xxTl06961xYZWHoqE8bHiGYeQ8vcAO3jE4ja0b63HVQ+F9+xzbKhIRQ
 K9PY7EOy3Ty9TBfe2iUBerdMp6ZJO7utg1TkuLoM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240415095931epcas1p38f36a6cc113e90e61c65429a904fc659~Ga73xwWks1395013950epcas1p3y;
 Mon, 15 Apr 2024 09:59:31 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VJ2hL6j48z4x9Px; Mon, 15 Apr
 2024 09:59:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9C.C2.08627.28AFC166; Mon, 15 Apr 2024 18:59:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240415095930epcas1p1798eddbbf0225c06c76f7155f6440c57~Ga72kH5PQ1897718977epcas1p1G;
 Mon, 15 Apr 2024 09:59:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240415095930epsmtrp24737c1032275040946834a37cf551ecd~Ga72jEEzV2748827488epsmtrp2V;
 Mon, 15 Apr 2024 09:59:30 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-f8-661cfa825ce5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9D.BF.08390.28AFC166; Mon, 15 Apr 2024 18:59:30 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415095930epsmtip137bffe929c3b7f5dd3a2e13b6748b079~Ga72Um8LK2140121401epsmtip1j;
 Mon, 15 Apr 2024 09:59:30 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <curtis.machida@intel.com>, <u-boot@lists.denx.de>, "'Peng Fan'"
 <peng.fan@nxp.com>
Cc: "'Jonas Karlman'" <jonas@kwiboo.se>, "'Kever Yang'"
 <kever.yang@rock-chips.com>, "'Peter Geis'" <pgwipeout@gmail.com>, "'Sean
 Anderson'" <sean.anderson@seco.com>, "'Simon Glass'" <sjg@chromium.org>,
 "'Tom	Rini'" <trini@konsulko.com>
In-Reply-To: <20240412192641.2912914-1-curtis.machida@intel.com>
Subject: RE: [PATCH] mmc: sdhci: programmable clock calculation needs
 multiplier +1
Date: Mon, 15 Apr 2024 18:59:30 +0900
Message-ID: <007101da8f1b$9be4c100$d3ae4300$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQH1h8AYvtifljG6EILm2G5B4hW+5AF+S9U1sSc1M6A=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmrm7TL5k0g+ebzSzOfzrOaHHyzVUW
 i23Tf7JZ/Fj1hdXi7DNvi3n3W5gsvm3ZxmgxddJmdou3ezvZHTg9ZjdcZPHYOesuu8fiPS+Z
 PF4dWMXucWLCJSaPs3d2MHpsfLeDyePvrP0sHs/+fWMP4IzKtslITUxJLVJIzUvOT8nMS7dV
 8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
 kV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ0x5WhIwQ6+itWbjjI2MD7m7mLk
 5JAQMJGY+f4pYxcjF4eQwA5GiUV777NCOJ8YJc4vWQmV+cYo8f/nN1aYliW9p1ggEnsZJRav
 +QblvGSU2LFkDVgVm4CexP9FC5lBbBGBSImbd2aDjWIGmfti6yNGkASngIPE695jbCC2sECo
 xJvfDewgNouAqsSjY8+ZQGxeAUuJqbc62CFsQYmTM5+wgNjMAvIS29/OYYY4SUHi59NlrBBx
 EYnZnW1Qi60ktnb9YQJZLCFwgkNi959Z7BANLhJTv/9ghLCFJV4d3wIVl5L4/G4vG0RDM6PE
 0iUHWSGcHkaJfw3X2SCqjCX2L50MNJYDaJ2mxPpd+hCb+STefe1hBQlLCPBKdLQJQVSrSFx6
 /ZIJZv7dJ/+h4eghcfTYfsYJjIqzkPw2C8lvs5D8Mwth2QJGllWMYqkFxbnpqcmGBYbw+E7O
 z93ECE7CWsY7GC/P/6d3iJGJg/EQowQHs5II7zU5yTQh3pTEyqrUovz4otKc1OJDjKbA0J7I
 LCWanA/MA3kl8YYmlgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqemFqQWwfQxcXBKNTAJvqzY
 liB848yX6VdEfzPuy5y54tC9iKmKzkXHtkZuyn5tvvaRTv3vfrHMsofznstb+/u6/BbdcuPy
 ni2/Zmn/+/VuH6PAyj0VZkvi/96L+7nc9+96aTaJvwaqD0OuSGXMapjHx3fbqf7KNobmJ+4i
 i3a53/+YtSlyvbj3yy+GLX0v5GL1zlesmjvPOkn68P8dQb8s034X3s+z3SUqEL8jpXXCiu1l
 s6eUdOk/i/91puDdslub1lixHFkU9eHLvbf/hU9GCPDN2vBOU1DD1GbRP+0DMkZdnx+4xAuU
 RWkeUTDm4ffNLtHPytP6VhG9vGHDPNV7iQtuJp5Wr7t0pG/imjubjcsPPi44e9235jP3HCWW
 4oxEQy3mouJEAM6mq2dLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG7TL5k0g453EhbnPx1ntDj55iqL
 xbbpP9ksfqz6wmpx9pm3xbz7LUwW37ZsY7SYOmkzu8XbvZ3sDpwesxsusnjsnHWX3WPxnpdM
 Hq8OrGL3ODHhEpPH2Ts7GD02vtvB5PF31n4Wj2f/vrEHcEZx2aSk5mSWpRbp2yVwZUw5GlKw
 g69i9aajjA2Mj7m7GDk5JARMJJb0nmLpYuTiEBLYzShxbPEHJoiElMTnp1PZuhg5gGxhicOH
 iyFqnjNK7PhxlwWkhk1AT+L/ooXMILaIQLTEzae/2EGKmAW+MUqsvH+UGaJjIqPEqXVNjCBV
 nAIOEq97j4FNFRYIlui/xw8SZhFQlXh07DnYYl4BS4mptzrYIWxBiZMzn4AtYxbQluh92MoI
 YctLbH87hxniUAWJn0+XsULERSRmd7ZBHWQlsbXrD9MERuFZSEbNQjJqFpJRs5C0L2BkWcUo
 mVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyJWlo7GPes+qB3iJGJg/EQowQHs5II7zU5
 yTQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamBynR76q
 /DQ/3GrijVUqH2r+3Poitu+eEqd70sWNR6JjQ92Ob9OcztvAs8Tb7pxr1NU10wUjSvcsyxf9
 xSltIn7+xF3hb95ec44w3Nqd95i/fPulU/qKbP4lPx95KD2vVjx/ruetc97Ga0sW7o0++50h
 683imvs5riV3CkyPlzPy1uw6+iB8tqSB7tW6RzeXpvZVv99v9M8lkGtzuqGetNffG49cxBQv
 XZIQEJqx684k1bXqGZsFn3++y1E9aQqLkM105du/dv15Epd4xPyTdAEzm6TCt89rEtLuXzFd
 lP1HfOVSvyc3PlvJSAlsW93T9GV7cYuAwaU7U4BR0yXXd6zxgKPD553uRx5bNs5XO6vEUpyR
 aKjFXFScCABX4059MwMAAA==
X-CMS-MailID: 20240415095930epcas1p1798eddbbf0225c06c76f7155f6440c57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240412192703epcas1p3b18cb3376111bfb7ad1c92d1565aa2d7
References: <CGME20240412192703epcas1p3b18cb3376111bfb7ad1c92d1565aa2d7@epcas1p3.samsung.com>
 <20240412192641.2912914-1-curtis.machida@intel.com>
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



> -----Original Message-----
> From: curtis.machida@intel.com <curtis.machida@intel.com>
> Sent: Saturday, April 13, 2024 4:27 AM
> To: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: cmachida <curtis.machida@intel.com>; Jonas Karlman <jonas@kwiboo.se>; Kever Yang <kever.yang@rock-
> chips.com>; Peter Geis <pgwipeout@gmail.com>; Sean Anderson <sean.anderson@seco.com>; Simon Glass
> <sjg@chromium.org>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] mmc: sdhci: programmable clock calculation needs multiplier +1
> 
> From: cmachida <curtis.machida@intel.com>
> 
> According to the SD Host Controller Simplified Specification v4.20,
> the multiplier value M is one more than the Clock Multiplier field.
> 
> Copied code from Linux project.  drivers/mmc/host/sdhci.c line 4405
> 
> Signed-off-by: cmachida <curtis.machida@intel.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/sdhci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 0178ed8a11..a8476ec4e9 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -929,6 +929,15 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>  		debug("%s, caps_1: 0x%x\n", __func__, caps_1);
>  		host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
>  				SDHCI_CLOCK_MUL_SHIFT;
> +
> +		/*
> +		 * In case the value in Clock Multiplier is 0, then programmable
> +		 * clock mode is not supported, otherwise the actual clock
> +		 * multiplier is one more than the value of Clock Multiplier
> +		 * in the Capabilities Register.
> +		 */
> +		if (host->clk_mul)
> +			host->clk_mul += 1;
>  	}
> 
>  	if (host->max_clk == 0) {
> --
> 2.43.2


