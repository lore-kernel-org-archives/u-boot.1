Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB653E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307128020B;
	Tue, 10 Dec 2024 23:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="UnfGOY4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9DE680212; Tue, 10 Dec 2024 23:35:44 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E5780202
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241210223537epoutp04f9ec9e9e25b137eca354f68e556836b1~P8bQH7htS1852718527epoutp04M
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 22:35:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241210223537epoutp04f9ec9e9e25b137eca354f68e556836b1~P8bQH7htS1852718527epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733870137;
 bh=qZ4p7O2ykqtUXnL/QzAtg4ifrKSxi7NFjsdpcFEb5IM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=UnfGOY4XM79aJPop1MO1+g3nx1o/kJUSzro67Vte/niTzc/H9raDAP2mVk2+VE7Fw
 QHEs4IS+U7Lh6QBJ2b1kkRA+UmOfMUQc5hLMssNKJT61wmVKIm1uIuQROXWbCtXmRL
 97Bo0hW0TKISlevFT1j3Sr5x18sQCYc6qOTHMVBg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241210223536epcas1p453ae2719c9f91edc33d0b5c0438d9f0c~P8bPrTJ-Q3070230702epcas1p4A;
 Tue, 10 Dec 2024 22:35:36 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y7D8R1Xy1z4x9Pw; Tue, 10 Dec
 2024 22:35:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 8C.5F.23869.732C8576; Wed, 11 Dec 2024 07:35:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241210223534epcas1p4bf1b8d10ad7f68a8c098bc8036a21a4d~P8bN40VgG3070230702epcas1p4_;
 Tue, 10 Dec 2024 22:35:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210223534epsmtrp25b9fbafd7921373bb1e4d14272875f30~P8bN4LBR73275532755epsmtrp2f;
 Tue, 10 Dec 2024 22:35:34 +0000 (GMT)
X-AuditID: b6c32a36-6e9e870000005d3d-f3-6758c23737de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.99.18949.632C8576; Wed, 11 Dec 2024 07:35:34 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210223534epsmtip2dfad73a2dd53ba768d87b1129f5d4c3b~P8bNpUWQO0612906129epsmtip2I;
 Tue, 10 Dec 2024 22:35:34 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>, "'Peter	Robinson'"
 <pbrobinson@gmail.com>, "'Heiko Schocher'" <hs@denx.de>, "'Jonas Karlman'"
 <jonas@kwiboo.se>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20241209161434.6563-3-clamor95@gmail.com>
Subject: RE: [PATCH v1 2/3] pmic: max77663: bind children to parent node
Date: Wed, 11 Dec 2024 07:35:34 +0900
Message-ID: <0bf101db4b53$d3b38d10$7b1aa730$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHwBcTaW7dMJxSGs0Uxb68V/PRZywJfs4YxAbXarJqyle+WQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmrq75oYh0gx1POSwO9PcyWuy4c5/Z
 4uSbqywW61atYbP4tmUbo8XUSZvZLd7u7WR3YPeY3XCRxWPerBMsHjtn3WX3eHVgFbvHiQmX
 mDzO3tnBGMAWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg
 65aZA3SMkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK
 0MDAyBSoMCE7o3HfetaCfp6KOeu/MjUwXuLsYuTkkBAwkTi2bTJrFyMXh5DADkaJSzvuM0E4
 nxglFm6byAjhfGOUWPD4FitMS9OHTVBVexklNk5YygzhvGSUePpgEztIFZuAnsT/RQvBEiIC
 rxklNszsBGtnFpCSaDq5ixHE5hQwl7jx+zJQAweHsICHxNyX+iBhFgFViV/vnjOB2LwClhKv
 r/ayQWxWkPj5dBnYGBEBJ4ne9R+YIEaKSMzubAPbJSHwll2iY/EnRogGF4nZC1uZIGxhiVfH
 t7BD2FISn9/tZYNoaGaUWLrkICuE08Mo8a/hOtQ6Y4n9SyczgVzHLKApsX6XPsQ2Pol3X3tY
 QcISArwSHW1CENUqEpdev2SCmX/3yX9ocHlINE3ZwA4Joe2MEofnn2WcwCg/C8nhsxA2LGBk
 WsUollpQnJueWmxYYASPzOT83E2M4HSoZbaDcdLbD3qHGJk4GA8xSnAwK4nwcniHpgvxpiRW
 VqUW5ccXleakFh9iNAUG5URmKdHkfGBCziuJNzSxNDAxMzI2sTA0M1QS5z1zpSxVSCA9sSQ1
 OzW1ILUIpo+Jg1OqgYlrq4z7lCNq/l83bIv+FlmhI2Xt3PbMVE33R0jB5Iklxiejq1P15NZu
 4OY8FMToWXr30u24lNf9R6dmir+3uu6zzrCtkuvUamvO7axnF0T7/Q7g/Vj57V7E7qx1a02s
 FVLW2HGWe6Zzza+SY3J9MdmltThuYpRm9rYDj4rPvfTxC/NqmKjrF3b+xOtY3j6GtyFW2szJ
 1yaxKTVc5UlglviX6ial5dHndMlgC8PZpD2fFP1WBv2XD14R+Gm/u+0ymXlmGur7Ngu+fv9a
 pDk2Tk/m3j9Os7Ip7HxSxyb5SUoFdIUvFFbd+jFXIsDXU1r6x+a/7t9zpxy6w55Vs0hc+cWe
 n19vNIhv/cBymHW/EktxRqKhFnNRcSIAIl9i1hAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvK7ZoYh0gz+nFS0O9PcyWuy4c5/Z
 4uSbqywW61atYbP4tmUbo8XUSZvZLd7u7WR3YPeY3XCRxWPerBMsHjtn3WX3eHVgFbvHiQmX
 mDzO3tnBGMAWxWWTkpqTWZZapG+XwJXRuG89a0E/T8Wc9V+ZGhgvcXYxcnJICJhINH3YxNTF
 yMUhJLCbUWL1xutMEAkpic9Pp7J1MXIA2cIShw8XQ9Q8Z5RYP2ETWA2bgJ7E/0ULmUFsEYH3
 jBLbr+mD2MxAvU0ndzFCNGxmlLj7swmsiFPAXOLG78vsIEOFBTwk5r4Eq2cRUJX49e452Exe
 AUuJ11d72SBuUJD4+XQZK8R8J4ne9R+YIOaLSMzubGOewCgwC4m7gJFxFaNkakFxbnpusWGB
 UV5quV5xYm5xaV66XnJ+7iZGcCBrae1g3LPqg94hRiYOxkOMEhzMSiK8HN6h6UK8KYmVValF
 +fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFwSjUwSZdz7VtWPGnFTP+Dv8vn
 VN5wtethqinavF25eLm/kZv1ocU5EiHp+ZHlfknuwmoB12PLZLbc28n/i6Hs42dXQ+d3a7pO
 uLE8rHFdG3xdzkCnL/TU8T/bnA+b2ItcPn4hPXQfS+D5197nxGVPHNbyDJ512FFp2abpNaec
 PNe854+P1/xZFXfm7iGxnZPfvRO7J/dhwZ/21tdp19obRb+7Z/7hm6rV8HDlDQ/mydKMVj/S
 IvPCkh4t1P/dIWmTfEr8sbxySYzRbVdj8f1+ixI4G/bX2udbfSveX6VzYcV5Vf6/skYqUycd
 sP0bunZLpNoih8evT7xaf/m/y7ZfG0v4F22Pf1e1IP+AV/aVtes5lViKMxINtZiLihMBvvLN
 19MCAAA=
X-CMS-MailID: 20241210223534epcas1p4bf1b8d10ad7f68a8c098bc8036a21a4d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209161506epcas1p384f604946b713727b25649d48da58a67
References: <20241209161434.6563-1-clamor95@gmail.com>
 <CGME20241209161506epcas1p384f604946b713727b25649d48da58a67@epcas1p3.samsung.com>
 <20241209161434.6563-3-clamor95@gmail.com>
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
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Tuesday, December 10, 2024 1:15 AM
>
> Bind GPIO and SYSRESET children to parent node since they
> do not have their own nodes in the device tree.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,

> ---
>  drivers/power/pmic/max77663.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
> index cf08b6a7e1d..c2a7cbf7e40 100644
> --- a/drivers/power/pmic/max77663.c
> +++ b/drivers/power/pmic/max77663.c
> @@ -47,8 +47,9 @@ static int max77663_bind(struct udevice *dev)
>  	int children, ret;
>
>  	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
> -		ret = device_bind_driver(dev, MAX77663_RST_DRIVER,
> -					 "sysreset", NULL);
> +		ret = device_bind_driver_to_node(dev, MAX77663_RST_DRIVER,
> +						 "sysreset", dev_ofnode(dev),
> +						 NULL);
>  		if (ret) {
>  			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
>  			return ret;
> @@ -56,8 +57,8 @@ static int max77663_bind(struct udevice *dev)
>  	}
>
>  	if (IS_ENABLED(CONFIG_MAX77663_GPIO)) {
> -		ret = device_bind_driver(dev, MAX77663_GPIO_DRIVER,
> -					 "gpio", NULL);
> +		ret = device_bind_driver_to_node(dev, MAX77663_GPIO_DRIVER,
> +						 "gpio", dev_ofnode(dev), NULL);
>  		if (ret) {
>  			log_err("cannot bind GPIOs (ret = %d)\n", ret);
>  			return ret;
> --
> 2.43.0



