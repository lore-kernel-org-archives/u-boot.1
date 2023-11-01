Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0EEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 10:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F330B87B7A;
	Wed,  1 Nov 2023 11:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uB/NZBID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE22987B7C; Wed,  1 Nov 2023 11:08:35 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F5287B79
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231101100825epoutp02d654e24df98aea98232113e05694cfb0~Td_P7hsSA1931419314epoutp02d
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 10:08:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231101100825epoutp02d654e24df98aea98232113e05694cfb0~Td_P7hsSA1931419314epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698833305;
 bh=unlLh61MtnRfZvWiHO5vmgi/yrVKhOd2WXEqrzKp2cU=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=uB/NZBIDVaA47/BhVTmW8eBoMok4Y009WE4JIgBIJrv3YY/LeOtJP0C2AOYlc0Ek7
 /J31p6VutxrxOkNDyXlCo5hFATITn83zf7M32hZv3LdylURIwoWfZvfk7e89FYNZoI
 DmhU0OkRHvBOnAZkCtteELOIrj4jYYmnw4+0y+R8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231101100825epcas1p17fee83c6ee4372e645ac407d069dfc9c~Td_PrNla41374713747epcas1p1p;
 Wed,  1 Nov 2023 10:08:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SL2lD2FF3z4x9Pv; Wed,  1 Nov
 2023 10:08:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 1B.F4.09739.89322456; Wed,  1 Nov 2023 19:08:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101100823epcas1p107fa8eac968ff759ef36503908ec7688~Td_OGBxIe1124811248epcas1p1x;
 Wed,  1 Nov 2023 10:08:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101100823epsmtrp14893908e34e20a11a12eb32ad410895a~Td_OFRVsQ0781607816epsmtrp1Z;
 Wed,  1 Nov 2023 10:08:23 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-e2-65422398865f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 89.92.07368.79322456; Wed,  1 Nov 2023 19:08:23 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101100823epsmtip1efff92c57e1aa934f60ba101d33d58d8~Td_N3eKU41080810808epsmtip1_;
 Wed,  1 Nov 2023 10:08:23 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Jonas Karlman'" <jonas@kwiboo.se>
Cc: <sjg@chromium.org>, <patrice.chotard@foss.st.com>,
 <eugen.hristev@collabora.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <9e7015ae-8a1a-41dc-a960-01525ecec913@kwiboo.se>
Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
Date: Wed, 1 Nov 2023 19:08:23 +0900
Message-ID: <02ca01da0cab$58fa23a0$0aee6ae0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGNlC1FaWtC5Axzkm5yITVXfLyFOgHb/8w7Ak3hn1kCZYBUyQHzQtFKAo7GnFwC0s2DhrCPC6fg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmvu4MZadUg/6fvBati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3
 KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyB
 ChOyM758mMZWcFm14sDsjewNjE/luhg5OSQETCTO9vWxgNhCAjsYJRbNy+ti5AKyPzFKzJ69
 kxXC+cYoMbP1AVsXIwdYx4yTThDxvYwSJw7+gSp6yShx6c9qsFFsAnoS/xctZAaxRQTUJV7/
 ncIIUsQs0MIo0XC3A6yIU8BWYsXjl2C2sIC3xItvP5hAbBYBFYnv/XNYQLbxClhK/NnjCBLm
 FRCUODnzCVg5s4C8xPa3c5ghXlCQ+Pl0GSvEriiJi/N+M0HUiEjM7mxjBtkrITCTQ+Lnh43s
 EB+4SMyYlAPRKyzx6vgWdghbSuJlfxs7RH0zo8TSJQdZIZweRol/DdfZIKqMJfYvncwEMohZ
 QFNi/S59iLCixM7fcxkhFvNJvPvawwqxi1eio00IokRF4tLrl0wwu+4++c86gVFpFpLXZiF5
 bRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAYHtnJ+bmbGMFJVMt8B+O0tx/0DjEycTAeYpTgYFYS
 4T1s6pAqxJuSWFmVWpQfX1Sak1p8iNEUGNYTmaVEk/OBaTyvJN7QxNLAxMzI2MTC0MxQSZz3
 1rPeFCGB9MSS1OzU1ILUIpg+Jg5OqQamS1v4Dp7Me8oRoHqzJvY0b9HHzSXlfellRbqh0w5E
 2W6Ju372pGUu36Lbu09M3vWlQvzLBLfMMn3dYNd/UffO8d87oBuVtWZixOYJno/mnq0P39p+
 duK+uUxO342M+zznMrO+K1LK31/+pd85TulrEpOfM9/qPZ9XBLfOmBWs1nIDmIN2tLL+vlQ+
 afbzA2+7Wh2Smn/HGk+y9wjPrX5cYnCmRHWC4n6ZoKsuU7tcbQTa9jnfzHvt9DU36Fd0VJWi
 ++4H79clfNfZkqgx7a7RQ+Up36dElCcqf5IP+vJneVtiw4adHvev3Rbb+//k9lP1dfMW/Zbc
 4WQQb/tH/LJNQLfAljwPHpllj/udAwWUWIozEg21mIuKEwG+enDyKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTne6slOqwb7Nkhati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUVw2Kak5mWWpRfp2CVwZXz5MYyu4rFpxYPZG9gbGp3JdjBwcEgImEjNOOnUxcnEICexm
 lJiz+BZbFyMnUFxK4vPTqWwQNcIShw8XQ9Q8Z5RYtKsJrIZNQE/i/6KFzCC2iIC6xOu/UxhB
 bGaBLkaJP0cKIRp+MUn0fOkAa+AUsJVY8fglC4gtLOAt8eLbDyYQm0VAReJ7/xwWkGW8ApYS
 f/Y4goR5BQQlTs58wgIxU1vi6c2nULa8xPa3c5gh7lSQ+Pl0GSvEDVESF+f9ZoKoEZGY3dnG
 PIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIER5OW
 xg7Ge/P/6R1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC
 6YklqdmpqQWpRTBZJg5OqQamhC6XiWuEPrZwLUoz6yjUnrw7bKaOh9j/M00TfSdOLHBrUoqL
 OPNrhSJ/9YqQTrF5M36LtlmsSZ92/vfF05smabuXnRI+H/U/IFMtrHobY4D4zKiKQqll4leO
 z9531PeD0fXdHL+n1NreV3aZ/dIuLlT6E5MDS6mIstYDzqU/NJvLP5i5XLvC73Rk8ZNgV3bl
 o4Vqit4douJb7B3/Bt3d/V/q8mmLkoeCq/LmnDl3nunT2ZeajLeTynii5nHYOamFb+hQXVvG
 H8f/cuUZTi07ncW/xF4mp8uuM+o9pXn2k2pUV9iEBdyvOUIeyW+zyFK4p97nPdPX7kyXDEeN
 RLtPzfx31dN8reefU2N/cliJpTgj0VCLuag4EQCNhUa6FQMAAA==
X-CMS-MailID: 20231101100823epcas1p107fa8eac968ff759ef36503908ec7688
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
 <026001da0c9c$20059840$6010c8c0$@samsung.com>
 <9e7015ae-8a1a-41dc-a960-01525ecec913@kwiboo.se>
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

Hi,

> -----Original Message-----
> From: Jonas Karlman <jonas@kwiboo.se>
> Sent: Wednesday, November 1, 2023 6:33 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com; u-
> boot@lists.denx.de
> Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
> 
> On 2023-11-01 09:19, Jaehoon Chung wrote:
> >
> >
> >> -----Original Message-----
> >> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> >> Sent: Wednesday, November 1, 2023 5:11 PM
> >> To: 'Jonas Karlman' <jonas@kwiboo.se>
> >> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
> u-
> >> boot@lists.denx.de
> >> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> >>> Sent: Wednesday, November 1, 2023 5:07 PM
> >>> To: 'Jonas Karlman' <jonas@kwiboo.se>
> >>> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
> >> u-
> >>> boot@lists.denx.de
> >>> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Jonas Karlman <jonas@kwiboo.se>
> >>>> Sent: Wednesday, November 1, 2023 4:47 PM
> >>>> To: Jaehoon Chung <jh80.chung@samsung.com>
> >>>> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com;
> trini@konsulko.com;
> >>> u-
> >>>> boot@lists.denx.de
> >>>> Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
> >>>>
> >>>> On 2023-11-01 08:23, Jaehoon Chung wrote:
> >>>>> If reegulator is already enabled, it will be return to EALREADY.
> >>>>> But driver that its function is called can notice as error, even though
> >>>>> it's working fine.
> >>>>>
> >>>>> Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> >>>>>
> >>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>>>> ---
> >>>>>  drivers/power/regulator/regulator-uclass.c | 4 ++++
> >>>>>  1 file changed, 4 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-
> >>> uclass.c
> >>>>> index 3a6ba69f6d5f..fc1c3eb93c9d 100644
> >>>>> --- a/drivers/power/regulator/regulator-uclass.c
> >>>>> +++ b/drivers/power/regulator/regulator-uclass.c
> >>>>> @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
> >>>>>  		}
> >>>>>  	}
> >>>>>
> >>>>> +	/* Regulator is already enabled */
> >>>>> +	if (ret == -EALREADY)
> >>>>> +		return 0;
> >>>>> +
> >>>>
> >>>> Use of regulator_set_enable_if_allowed() will cover this error,
> >>>> and regulator_set_enable() should continue to return this error.
> >
> > regulator_set_enable_if_allowed() can be covered. But regulator_set_enable is called in some drivers.
> > You means that it needs to replace to regulator_set_enable_if_allowed() from regulator_set_enable()
> about all driver?
> 
> I think that was the consensus when basic reference counter was
> implemented for gpio/fixed regulators. It should return -EALREADY when
> a regulator is already enabled, and if a caller need a more relaxed
> enable/disable regulator_set_enable_if_allowed() could be used.

Ok. I understood.

> 
> Tried to fix a few commons callers in following series, but did not
> cover hw I could not test. Can see that I missed the meson usb driver
> and was something I could have tested.
> 
> Keep fixed/gpio regulator enable count in balance
> https://protect2.fireeye.com/v1/url?k=d568c889-b4136201-d56943c6-74fe4860018a-
> 0f3e262ba2f98d29&q=1&e=fab7227e-c990-4824-b601-
> b8ba154d2255&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fcover%2F1810049%2F

Thanks for informing this.
Then discard this patch. It seems that make sense to fix meson usb. How about?
I will send the patch about meson-usb.


Best Regards,
Jaehoon Chung

> 
> Regards,
> Jonas
> 
> >
> > Best Regards,
> > Jaehoon Chung
> >
> >>
> >> Well.. I will recheck about your comment.
> >>
> >> Best Regards,
> >> Jaehoon Chung
> >>
> >>>
> >>> When I have checked on my target, It seems that it can't cover all cases.
> >>>
> >>> On odroid-c4, USB doesn't work, even though its regulator is enabled.
> >>>
> >>> => ums 0 mmc 0
> >>> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
> >>> No USB device found
> >>> Couldn't init USB controller.
> >>>
> >>>
> >>> Best Regards,
> >>> Jaehoon Chung
> >>>
> >>>>
> >>>> Regards,
> >>>> Jonas
> >>>>
> >>>>>  	return ret;
> >>>>>  }
> >>>>>
> >>>
> >>
> >
> >


