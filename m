Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A580E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE42E80209;
	Tue, 10 Dec 2024 23:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="m+NsWRdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A468020B; Tue, 10 Dec 2024 23:35:23 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BCB80202
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241210223510epoutp039a48d2856ca55955e6cf7295ff8478b7~P8a3ACLtd1886418864epoutp03V
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 22:35:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241210223510epoutp039a48d2856ca55955e6cf7295ff8478b7~P8a3ACLtd1886418864epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733870110;
 bh=JRG1EC5pqUi1ZvT+0pxaMIiR1+Oh/Kh0U0UYT5sNpzM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=m+NsWRdpTwap6hZ1syaYHlDugATdq9nsi7dGmYteKe2KR4WtFlfbDtsj08PK0r2pr
 7Z11x4spbwbFPBsPnUiWRWipFytsqsCjHbRnpl3uPyrVhV4hT/gQkx8KDpvh96cy8w
 z2saB4TTcQ0r1ds2sZEFuepaPLukKVWwyim9Kw6k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241210223509epcas1p21876350dda42cdb08811034a3cbf3198~P8a2p0EzC0421804218epcas1p2a;
 Tue, 10 Dec 2024 22:35:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Y7D7w2n8fz4x9Pp; Tue, 10 Dec
 2024 22:35:08 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 F4.54.23379.C12C8576; Wed, 11 Dec 2024 07:35:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241210223507epcas1p290e1be041168db1a6054ea76369eb193~P8a096dxR2928129281epcas1p29;
 Tue, 10 Dec 2024 22:35:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210223507epsmtrp2c77fa679b607528accca46ef708e3ea1~P8a09NsAd3275532755epsmtrp2U;
 Tue, 10 Dec 2024 22:35:07 +0000 (GMT)
X-AuditID: b6c32a37-171e970000005b53-a9-6758c21c9f4b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.57.18729.B12C8576; Wed, 11 Dec 2024 07:35:07 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210223507epsmtip1f0166baf625e1a843e0ed06182691121~P8a0y-DUi2960029600epsmtip1Z;
 Tue, 10 Dec 2024 22:35:07 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>, "'Peter	Robinson'"
 <pbrobinson@gmail.com>, "'Heiko Schocher'" <hs@denx.de>, "'Jonas Karlman'"
 <jonas@kwiboo.se>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20241209161434.6563-2-clamor95@gmail.com>
Subject: RE: [PATCH v1 1/3] Revert
 "drivers: gpio-uclass: support PMIC GPIO children"
Date: Wed, 11 Dec 2024 07:35:07 +0900
Message-ID: <0bf001db4b53$c3cbbe40$4b633ac0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHwBcTaW7dMJxSGs0Uxb68V/PRZywGVICLmAm/eI4yylnPcIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmvq7MoYh0g9k9IhYH+nsZLXbcuc9s
 cfLNVRaLdavWsFl827KN0WLqpM3sFm/3drI7sHvMbrjI4jFv1gkWj52z7rJ7vDqwit3jxIRL
 TB5n7+xgDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
 dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJl
 aGBgZApUmJCd8WJeZMF53ortHQ2sDYyXuboYOTkkBEwkGj7+Zu5i5OIQEtjBKNF9tp0JwvnE
 KDF95w12kCohgW+MEiu2MMN0dF7ewAJRtJdRYv2rc2wQzktGiaevWlhBqtgE9CT+L1oINldE
 4DWjxIaZnWAJZgEpiaaTuxhBbE4Bc4ktf7+DxYUFwiUufp/FBGKzCKhKTHp7mA3E5hWwBIo/
 ZYVYrSDx8+kyMFtEwEni36nDLBAzRSRmd7aBLZMQ+Mgu8bb1J9StLhIf9j9hgrCFJV4d38IO
 YUtJfH63lw2ioZlRYumSg6wQTg+jxL+G62wQVcYS+5dOBurmAFqhKbF+lz7ENj6Jd197WEHC
 EgK8Eh1tQhDVKhKXXr9kgpl/98l/qKM9JK5vuQ4N4e2MEmuf72GawCg/C8nhsxA2LGBkWsUo
 llpQnJueWmxYYAyPy+T83E2M4GSoZb6DcdrbD3qHGJk4GA8xSnAwK4nwcniHpgvxpiRWVqUW
 5ccXleakFh9iNAUG5URmKdHkfGA6ziuJNzSxNDAxMzI2sTA0M1QS5z1zpSxVSCA9sSQ1OzW1
 ILUIpo+Jg1OqgemKTJSkt51W6KL9rALGTTVrMxbeU0sQXP6qJuXeGjmLt4lnp/rujLtwQjOy
 8euWv3PXCthfCTZavGdF/s6J7gsntcrZ180K2zNR1H0yU1xT3JpOha0FK5SVhGWWqwdEMXu/
 S3fytrD2EfU54V447/mzlb9XZq/6NSXV1pU1/WQle5DXBmNxP7m7e0JEfXTmLfPj1S8oYXix
 qunb5Sjl7hOPe27P5Ln4x7zPrSWnzuyRyqay0vspKg+e18YdPaDQrH1Cyy5DJp49JOqqQ7kx
 j2maUeJNvbmJ37oXhAW/+Wzs2SfRPlP7/fN+d+vD9za80krlnf5tGX94fdAp1XU1ypprOaq2
 BTK5zU8/emqmEktxRqKhFnNRcSIAaHvPPg8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnK70oYh0gwtfTSwO9PcyWuy4c5/Z
 4uSbqywW61atYbP4tmUbo8XUSZvZLd7u7WR3YPeY3XCRxWPerBMsHjtn3WX3eHVgFbvHiQmX
 mDzO3tnBGMAWxWWTkpqTWZZapG+XwJXxYl5kwXneiu0dDawNjJe5uhg5OSQETCQ6L29g6WLk
 4hAS2M0oseXsHEaIhJTE56dT2boYOYBsYYnDh4shap4zSkzceZoJpIZNQE/i/6KFzCC2iMB7
 Ront1/RBbGag3qaTu8DmCAlsZpSYvCYDxOYUMJfY8vc7K4gtLBAq0bT9HguIzSKgKjHp7WE2
 EJtXwFLi4venrBA3KEj8fLqMFWK+k8S/U4dZIOaLSMzubGOewCgwC4m7gJFxFaNkakFxbnpu
 sWGBYV5quV5xYm5xaV66XnJ+7iZGcBhrae5g3L7qg94hRiYOxkOMEhzMSiK8HN6h6UK8KYmV
 ValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYsr473b+vt9P+I7vs
 +Qb3Ao5sf5fkxqdC7irXmliEa1ySZxkfcrzavCfobbLQaX130yQJ3gB3kXWOeZvnPHf6eazl
 1sKtn6UWt0e66ecU7b51/96Nq7O2p7h5Hp279G970508bfOpCu8P8frIV9VLH6sWeTk5Kelv
 7cl5NfZ6iTe1dJN/P990992i8A3SFgvmsB/e7nvvSsnapRxFU2PDQry1V99aMqX3gvL6WUv2
 P4sImipTffpmyNLNfzo/Rm6rsWVUTHLzT2L0i3x99Pl2wzhhmwiXZW5mnxXaNYRZnu1Veq/b
 N3vBjEuTpTQZed462z272Ns1e3phs6fUpnjn0ot/6i+xX5OxbtRlc5FSYinOSDTUYi4qTgQA
 cXBD1tICAAA=
X-CMS-MailID: 20241210223507epcas1p290e1be041168db1a6054ea76369eb193
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209161505epcas1p1feee75aea225bac7ae6bd67385ce4771
References: <20241209161434.6563-1-clamor95@gmail.com>
 <CGME20241209161505epcas1p1feee75aea225bac7ae6bd67385ce4771@epcas1p1.samsung.com>
 <20241209161434.6563-2-clamor95@gmail.com>
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
> Requesting of PMIC's GPIO child should be done by binding
> GPIO driver to PMIC's node is GPIO driver does not have
> its own node.
>
> This reverts commit c03cd98d1a163666b4addcdd9a34fc0c77dfd0a5.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,

> ---
>  drivers/gpio/gpio-uclass.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 0213271e3a6..67fc776cada 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1142,29 +1142,9 @@ static int gpio_request_tail(int ret, const char *nodename,
>  		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
>  						  &desc->dev);
>  		if (ret) {
> -#if CONFIG_IS_ENABLED(MAX77663_GPIO) || CONFIG_IS_ENABLED(PALMAS_GPIO)
> -			struct udevice *pmic;
> -			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
> -							  &pmic);
> -			if (ret) {
> -				log_debug("%s: PMIC device get failed, err %d\n",
> -					  __func__, ret);
> -				goto err;
> -			}
> -
> -			device_foreach_child(desc->dev, pmic) {
> -				if (device_get_uclass_id(desc->dev) == UCLASS_GPIO)
> -					break;
> -			}
> -
> -			/* if loop exits without GPIO device return error */
> -			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
> -				goto err;
> -#else
>  			debug("%s: uclass_get_device_by_ofnode failed\n",
>  			      __func__);
>  			goto err;
> -#endif
>  		}
>  	}
>  	ret = gpio_find_and_xlate(desc, args);
> --
> 2.43.0



