Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6931DD5B154
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA282890AD;
	Mon, 28 Oct 2024 22:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="vIJ4tfcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9869890AD; Mon, 28 Oct 2024 22:40:56 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070B9890A9
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241028214049epoutp03ebd687b4b4e70ed787aa2b0444e07488~Cu8Ie9UM11522015220epoutp03W
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:40:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241028214049epoutp03ebd687b4b4e70ed787aa2b0444e07488~Cu8Ie9UM11522015220epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730151649;
 bh=XvXmi9xSdy3q+i4V3cpwYcoBW/LJuaJtEGqwubMrwAU=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=vIJ4tfcYKAnzBK7LPCrWaUirRvdCVwMppro1u8Yii3H2OwpuGcTrwRjUSV7+vSvsb
 KiGgxCgsgkCFnANWHk5INVkPbSDfOdyaBGNWC03H3oIxglM5Zim0e4IPv4RjywjRdg
 i9WSJZGXN0Cxwzv2IuwekFSQgvQh9XWxIhq+4DOo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241028214049epcas1p1af63556d2fbd44cae926824620d24ee6~Cu8IUi0xz3229732297epcas1p15;
 Mon, 28 Oct 2024 21:40:49 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.133]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Xcmz34KRsz4x9Pt; Mon, 28 Oct
 2024 21:40:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5D.8A.19363.FD400276; Tue, 29 Oct 2024 06:40:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241028214046epcas1p206ac18392fbc49a060ce5f0d465c8b78~Cu8GGh5Ar2618426184epcas1p2h;
 Mon, 28 Oct 2024 21:40:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241028214046epsmtrp18824a35a151ac58bf89cfa5fb20cbdc7~Cu8GF7ZJU1935519355epsmtrp1X;
 Mon, 28 Oct 2024 21:40:46 +0000 (GMT)
X-AuditID: b6c32a4c-09fc070000004ba3-62-672004df7990
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A4.04.08227.ED400276; Tue, 29 Oct 2024 06:40:46 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241028214046epsmtip222fb84a0a1955a9ad6680cb8c35bf2ee~Cu8F3yfHp2538625386epsmtip2Q;
 Mon, 28 Oct 2024 21:40:46 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut@mailbox.org>, "'Paul Barker'"
 <paul.barker.ct@bp.renesas.com>, "'Nobuhiro Iwamatsu'"
 <iwamatsu@nigauri.org>, "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>,
 "'Peng	Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <1aa8a914-dbd6-429a-a6ad-1c3753cad9c5@mailbox.org>
Subject: RE: [PATCH v2] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
Date: Tue, 29 Oct 2024 06:40:46 +0900
Message-ID: <122401db2982$0c2c51c0$2484f540$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJZyvFaJ3x/1VetZPK9YATeG7lX7wJqBjUVAWXIgnGxgO9nAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmvu59FoV0g/O3ZSzeNhdbtK68w2bR
 cfcWu8Wfkz9YLX6s+sJq8XZvJ7sDm8fKF7PZPc7e2cHosXP2PiaPA5PPsXpsfLeDKYA1Ktsm
 IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
 oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xurn
 /xkLFgtULLtzmqmBcS1vFyMnh4SAiURjy3UWEFtIYA+jxKsFIV2MXED2J0aJO7/+s0E43xgl
 lv+fyQzT8eFlMytEYi+jRNu17UwQzktGiY3/T7CCVLEJ6En8X7SQGSQhIvAMaNbFZkaQBLOA
 lETTyV1gNqeAvcTfY+1gtrBAoMSpvt1gK1gEVCWenXkMdhSvgKXEwfnH2SFWK0j8fLqMFWKO
 iMTszjawehEBJ4mFO9vBTpIQeMQu0btgGlSDi0T/ob9QtrDEq+NboGwpiZf9bewQDc2MEkuX
 HITq7mGU+NdwnQ2iylhi/9LJQM9xAK3TlFi/Sx9iM5/Eu689rCBhCQFeiY42IYhqFYlLr18y
 wcy/++Q/K4TtIbHo7nVoeJ1klGjdcJRtAqP8LCRPzELYsICRaRWjVGpBcW56arJhgaFuXmo5
 PEKT83M3MYIToJbPDsbv6//qHWJk4mA8xCjBwawkwrs6VjZdiDclsbIqtSg/vqg0J7X4EKMp
 MDgnMkuJJucDU3BeSbyhiaWBiZmRsYmFoZmhkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1M
 K2qkjx2despBY2ONZvBco9605IsNv659SQ2ZnbGeR1k/RXHSawtLH4sFYpf3Bmok7n+x3+F5
 gmfw/TW651PWRYs1te/0ZeFZHFtvE/vv7evFf1UZPbIS9hw8Hb+k4thH9tc7rji8DknSXmKn
 9s4kWPvHV3+zaTPzxPSnHor0NBL+Vq8T+cUm2uXkhAALc/9ffDfNg+0ye2dOW2hhe/dAjNCK
 lKZ6S7tZ75pcj6/7vqLInylB+8HyR+7Fydej/A86MFQWTbRzXMt+X2A160Me9mPzr4sq+bku
 X8ub6c/YuvcCa9pf5XPKsi0O4VKrtT4tz5FvPeUwY/t3Vpc5+RfX+cUp5OVvX6zucvrAwilK
 LMUZiYZazEXFiQB7iU6SCQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO49FoV0g8X3VSzeNhdbtK68w2bR
 cfcWu8Wfkz9YLX6s+sJq8XZvJ7sDm8fKF7PZPc7e2cHosXP2PiaPA5PPsXpsfLeDKYA1issm
 JTUnsyy1SN8ugStj9fP/jAWLBSqW3TnN1MC4lreLkZNDQsBE4sPLZlYQW0hgN6PE61nKEHEp
 ic9Pp7J1MXIA2cIShw8XdzFyAZU8Z5SY2dLNAlLDJqAn8X/RQmaQhIjAC0aJ43dbmUESzEDN
 TSd3MUJ0HGWU6Jz8lw0kwSlgL/H3WDsjiC0s4C+x+98UJhCbRUBV4tmZx2BTeQUsJQ7OP84O
 cYWCxM+ny1ghhopIzO5sA1sgIuAksXBnO+sERoFZSFILGBlXMUqmFhTnpucWGxYY5aWW6xUn
 5haX5qXrJefnbmIEB62W1g7GPas+6B1iZOJgPMQowcGsJMK7OlY2XYg3JbGyKrUoP76oNCe1
 +BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQamhuUKKUVx+csdr1+tm6hmy7impayV
 555/49MnBY0zNM4s/hU4L/D6wZnL0h77z/7mnPXxaPd/HT5nM/7WqrnJ0Z0/7AQTzmewWHz/
 YC5z9bmB8vUJ2jkGkx/wnt12xyXgzvsPlldnsC/MznZaKv8r7IL2XqEL1na/jVbPFOHXdWle
 NSHUtvloec78tZM3ZXDcsbrx7P6xg1VfI5m3ubrfavzH6C8Svu5QXJxUuNfeS9XSdnuvayda
 HdKdOrvl1+6+xJiIy9FmX7+dynd8+1b2g2mJ/IeuhpX3l5RdOZSXsP+1S825l4kFCfa2LMqh
 yV/sDFau8Y7i5F5jtE0kPXOZ05yY6V8t9CdnS21nEsxSYinOSDTUYi4qTgQAK8DJzskCAAA=
X-CMS-MailID: 20241028214046epcas1p206ac18392fbc49a060ce5f0d465c8b78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241027163220epcas1p450e4c0dd3bf0fd840c433e128b6d2447
References: <20241023105319.334-1-paul.barker.ct@bp.renesas.com>
 <CGME20241027163220epcas1p450e4c0dd3bf0fd840c433e128b6d2447@epcas1p4.samsung.com>
 <1aa8a914-dbd6-429a-a6ad-1c3753cad9c5@mailbox.org>
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
> From: Marek Vasut <marek.vasut@mailbox.org>
> Sent: Monday, October 28, 2024 1:31 AM
> To: Paul Barker <paul.barker.ct@bp.renesas.com>; Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; Marek Vasut
> <marek.vasut+renesas@mailbox.org>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH v2] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
>
> On 10/23/24 12:53 PM, Paul Barker wrote:
> > After the recent dts/upstream subtree merge, the sdhi compatible string
> > used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
> > not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
> > and SD card devices on RZ/G2L boards.
> >
> > Fix this by adding the new compatible string to the sdhi driver.
> >
> > Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
> > Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > ---
> > Changes v1->v2:
> >    - Moved new entry after "renesas,rcar-gen4-sdhi".
> >    - Added Reviewed-by tags.
> >
> >   drivers/mmc/renesas-sdhi.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> > index 23db2a75c444..92afa6adcdac 100644
> > --- a/drivers/mmc/renesas-sdhi.c
> > +++ b/drivers/mmc/renesas-sdhi.c
> > @@ -864,6 +864,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
> >   	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
> >   	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
> >   	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
> > +	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
> >   	{ /* sentinel */ }
> >   };
> I can take this via sh tree if that's OK with you ?

If you're asking me, I'm ok.

Best Regards,
Jaehoon Chung


