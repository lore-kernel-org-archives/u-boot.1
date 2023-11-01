Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AA4C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 08:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC46F879E2;
	Wed,  1 Nov 2023 09:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Ec3uYtV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E51C87A52; Wed,  1 Nov 2023 09:19:36 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C942B876AC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 09:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231101081927epoutp02b16a69a0bcb2dcd4eabd0135b13b8c76~TcfHV31_b1659716597epoutp02L
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:19:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231101081927epoutp02b16a69a0bcb2dcd4eabd0135b13b8c76~TcfHV31_b1659716597epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698826767;
 bh=uAgGotd3yUSZ/xF8W6OAsdhyVn7Hm1dzWFF3oNKPUFw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Ec3uYtV54d5HARNmdH52kFYWtO8a7vm3KjfqFMLXsbYjs8ONoIqy613CttAnJyft9
 ZX15pH1N7hUzpvR1FyRucI/4fugQHflbV1Al3aADAhLdk3ajrK2uuCaPn4sRccylC1
 dTLUTUaLQ9gjZkMHnY7D7MnR8r9+iEMDxL3e0rs0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101081927epcas1p2bc443c932e1f0a18fd40991b45217e8b~TcfHAEk542696726967epcas1p2Y;
 Wed,  1 Nov 2023 08:19:27 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.234]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SL0KV3fblz4x9QD; Wed,  1 Nov
 2023 08:19:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 D6.C3.09739.E0A02456; Wed,  1 Nov 2023 17:19:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101081925epcas1p36817fe939add9e6e282235ae5fae09fd~TcfFFdIPK0794807948epcas1p3_;
 Wed,  1 Nov 2023 08:19:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101081925epsmtrp1fed0638a0e6bef52e085a73172667b7c~TcfFEsEHd1090910909epsmtrp1Y;
 Wed,  1 Nov 2023 08:19:25 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-a0-65420a0e3fb3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DC.B9.08817.D0A02456; Wed,  1 Nov 2023 17:19:25 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101081925epsmtip194f44ae0276ba4dee6b6cc988e6b5766~TcfE3DyPu1220712207epsmtip11;
 Wed,  1 Nov 2023 08:19:25 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Jonas Karlman'" <jonas@kwiboo.se>
Cc: <sjg@chromium.org>, <patrice.chotard@foss.st.com>,
 <eugen.hristev@collabora.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <025f01da0c9a$e4da4e60$ae8eeb20$@samsung.com>
Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
Date: Wed, 1 Nov 2023 17:19:25 +0900
Message-ID: <026001da0c9c$20059840$6010c8c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGNlC1FaWtC5Axzkm5yITVXfLyFOgHb/8w7Ak3hn1kCZYBUyQHzQtFKsLn6EQA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmvi4fl1OqwbOlEhati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3
 KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyB
 ChOyM94+u8VSsEGyYk7jGqYGxukiXYycHBICJhJz96xm7mLk4hAS2MEo8efPDCYI5xOjxJnW
 1SwQzjdGiUf757PBtLRsWQBVtZdRomvBGSjnJaPEohunWECq2AT0JP4vWsgMYosIqEu8/juF
 EaSIWaCFUaLhbgdYEaeAlcSt61eZQGxhAW+JF99+gNksAioSrbN/MYLYvAKWEt/nvGCHsAUl
 Ts58AtbLLCAvsf3tHGaIkxQkfj5dxgqxzE/i89Rd7BA1IhKzO9vAvpMQmMohsbXpPdQPLhLd
 q/eyQNjCEq+Ob2GHsKUkXva3sUM0NDNKLF1ykBXC6WGU+NdwHarbWGL/0slAp3IArdCUWL9L
 HyKsKLHz91xGiM18Eu++9rCClEgI8Ep0tAlBlKhIXHr9kglm190n/1knMCrNQvLbLCS/zULy
 wyyEZQsYWVYxiqUWFOempxYbFhjDIzw5P3cTIziZapnvYJz29oPeIUYmDsZDjBIczEoivIdN
 HVKFeFMSK6tSi/Lji0pzUosPMZoCQ3sis5Rocj4wneeVxBuaWBqYmBkZm1gYmhkqifPeetab
 IiSQnliSmp2aWpBaBNPHxMEp1cDEb/v8VXy48uKa2r0zuc12vHulMi//ZX7+5/Y+/l8+qUlz
 K5asnH1v37S/H0Lj7J6ct4h8c8QxZptz94W0xKuhIlqL3imb8xYVVCvueB3LNkPJzXqa9oJj
 13Scb2ZmnvwSppWkPtt0y8LAt7FcN6N+bYjcxPbyHbMig+izM8l/z4m+LalX4dN24D0fOSu5
 zKLbW2+17+45KS+MFaaJJS6a4CEYlux/80/wrSeJLXeKJ3Mu4Y9fw5WtmHvluzFjp8m5XUlf
 1/MwTJVxVzD/9+ty154GK9dDXlbG7EkfVPfIvq5eViZXv/jE4/pTaSUrZVyFd8/deiHSTf2z
 3nx74Up55tPh95/tPL4pw9tkxm0lluKMREMt5qLiRADp1exDLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTpeXyynV4MwBCYvWRbcZLU6+ucpi
 8fPke3aLb1u2MVpMnbSZ3eLt3k52BzaP2Q0XWTx23F3C6PG0fyu7x6sDq9g9Tky4xORx9s4O
 xgC2KC6blNSczLLUIn27BK6Mt89usRRskKyY07iGqYFxukgXIyeHhICJRMuWBUxdjFwcQgK7
 GSX2vepgh0hISXx+OpWti5EDyBaWOHy4GKLmOaPE1l8nmEFq2AT0JP4vWghmiwioS7z+O4UR
 xGYW6GKU+HOkEKJhNpPEw1eHmUASnAJWEreuXwWzhQW8JV58+wFmswioSLTO/gXWzCtgKfF9
 zgt2CFtQ4uTMJywQQ7Ulnt58CmXLS2x/O4cZ4lAFiZ9Pl7FCHOEn8XnqLnaIGhGJ2Z1tzBMY
 hWchGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcERpae1g
 3LPqg94hRiYOxkOMEhzMSiK8h00dUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5Y
 kpqdmlqQWgSTZeLglGpgMiheUnghYVvp4UUq/FwTa4//TVyh02Ow+rja+sYrsRUnvvIrnyld
 WuxvkiR97PCc1M4e6z+p1xK+uesKsX1b73Ve3uQ2u4DgF8YFs97IvV8t3T4/P9nDI7irsjLt
 Oeur/WqHQ6auMFz1dY7QliRx95m6up4nz+V9fNnAZZWlZf+I52TB5JL7TGsyqrznXQgq39yx
 g69wNuOOSRty7gd8VT9fLRE95UBmWFhIYEM+Y+hu25ztKcKV8VWZxy9eaT2jX8Zu/nrSjpfP
 dv/9ZfUiKPuY6iOl2pV/Dm+4rP3ZPqmXc8uW3NrHtTNO67AfDzgb6y3sYOK6eZ1hxU3PTa7F
 E2rLH52JvN6pYFCp4vJBiaU4I9FQi7moOBEA0zg7mxcDAAA=
X-CMS-MailID: 20231101081925epcas1p36817fe939add9e6e282235ae5fae09fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d
References: <CGME20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d@epcas1p2.samsung.com>
 <20231101072316.190541-1-jh80.chung@samsung.com>
 <ea09f0bc-738c-4585-bc2a-eab3cd7e59ec@kwiboo.se>
 <025e01da0c9a$573ccbf0$05b663d0$@samsung.com>
 <025f01da0c9a$e4da4e60$ae8eeb20$@samsung.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Wednesday, November 1, 2023 5:11 PM
> To: 'Jonas Karlman' <jonas@kwiboo.se>
> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com; u-
> boot@lists.denx.de
> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
> 
> 
> 
> > -----Original Message-----
> > From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> > Sent: Wednesday, November 1, 2023 5:07 PM
> > To: 'Jonas Karlman' <jonas@kwiboo.se>
> > Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
> u-
> > boot@lists.denx.de
> > Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
> >
> >
> >
> > > -----Original Message-----
> > > From: Jonas Karlman <jonas@kwiboo.se>
> > > Sent: Wednesday, November 1, 2023 4:47 PM
> > > To: Jaehoon Chung <jh80.chung@samsung.com>
> > > Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
> > u-
> > > boot@lists.denx.de
> > > Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
> > >
> > > On 2023-11-01 08:23, Jaehoon Chung wrote:
> > > > If reegulator is already enabled, it will be return to EALREADY.
> > > > But driver that its function is called can notice as error, even though
> > > > it's working fine.
> > > >
> > > > Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> > > >
> > > > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > > > ---
> > > >  drivers/power/regulator/regulator-uclass.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-
> > uclass.c
> > > > index 3a6ba69f6d5f..fc1c3eb93c9d 100644
> > > > --- a/drivers/power/regulator/regulator-uclass.c
> > > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > > @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
> > > >  		}
> > > >  	}
> > > >
> > > > +	/* Regulator is already enabled */
> > > > +	if (ret == -EALREADY)
> > > > +		return 0;
> > > > +
> > >
> > > Use of regulator_set_enable_if_allowed() will cover this error,
> > > and regulator_set_enable() should continue to return this error.

regulator_set_enable_if_allowed() can be covered. But regulator_set_enable is called in some drivers.
You means that it needs to replace to regulator_set_enable_if_allowed() from regulator_set_enable() about all driver?

Best Regards,
Jaehoon Chung

> 
> Well.. I will recheck about your comment.
> 
> Best Regards,
> Jaehoon Chung
> 
> >
> > When I have checked on my target, It seems that it can't cover all cases.
> >
> > On odroid-c4, USB doesn't work, even though its regulator is enabled.
> >
> > => ums 0 mmc 0
> > UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
> > No USB device found
> > Couldn't init USB controller.
> >
> >
> > Best Regards,
> > Jaehoon Chung
> >
> > >
> > > Regards,
> > > Jonas
> > >
> > > >  	return ret;
> > > >  }
> > > >
> >
> 


