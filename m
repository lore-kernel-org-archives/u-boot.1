Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9BC4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 08:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0D3870C9;
	Wed,  1 Nov 2023 09:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ANE0Awr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB9A87272; Wed,  1 Nov 2023 09:06:49 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E636786FE7
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 09:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231101080641epoutp03b957964f857b1542a3bd89bf4caea9ff~TcT9Ysm6M0957109571epoutp03B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:06:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231101080641epoutp03b957964f857b1542a3bd89bf4caea9ff~TcT9Ysm6M0957109571epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698826001;
 bh=mqVjscWpyqyATYaYqqMM5NpuI3FCsCCj8C+1cWFlDTg=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ANE0Awr6gnLDXQogLLXexwy6fFU2ixFqoNrTSrHEZzSz/3S7xHVCaEtO9A908Jg+7
 bhqP4yPpUF6DCrZddWmeb3/9oVtJ2QoFmrFi5Xfl7/EKJCFABhFNjDkwWlhYnKRhLt
 xNpSck7JN7SqvXYTaQa1cpFWNcBohCQPYXXes6pU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231101080640epcas1p433584b3098449340f8edcdfa9054566e~TcT8_oKuP0070900709epcas1p4O;
 Wed,  1 Nov 2023 08:06:40 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.135]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SL02l5rTqz4x9QB; Wed,  1 Nov
 2023 08:06:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D6.9D.08572.F0702456; Wed,  1 Nov 2023 17:06:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101080639epcas1p4977bedc007a4791bca46208d987c22b4~TcT7T3agp0344503445epcas1p4C;
 Wed,  1 Nov 2023 08:06:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101080639epsmtrp2deb689e733b7980d6f8b7559e1a2bc7e~TcT7TIdoD2670826708epsmtrp2s;
 Wed,  1 Nov 2023 08:06:39 +0000 (GMT)
X-AuditID: b6c32a33-f5ffd7000000217c-a5-6542070f5a90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 45.56.18939.E0702456; Wed,  1 Nov 2023 17:06:39 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101080638epsmtip2d7e0cd84961413d6b6d5fc6f4a9afdaf~TcT7Hn1zW0729907299epsmtip28;
 Wed,  1 Nov 2023 08:06:38 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Jonas Karlman'" <jonas@kwiboo.se>
Cc: <sjg@chromium.org>, <patrice.chotard@foss.st.com>,
 <eugen.hristev@collabora.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <ea09f0bc-738c-4585-bc2a-eab3cd7e59ec@kwiboo.se>
Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
Date: Wed, 1 Nov 2023 17:06:38 +0900
Message-ID: <025e01da0c9a$573ccbf0$05b663d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGNlC1FaWtC5Axzkm5yITVXfLyFOgHb/8w7Ak3hn1mw3LwacA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmni4/u1OqwcKnehati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3
 KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyB
 ChOyM64uuclUsJiv4sGyTSwNjIe5uxg5OCQETCRudEd0MXJxCAnsYJS4N3URO4TziVFi0sLv
 jHDO8nkzmLoYOcE6/szcxQyR2MkosWT5G3aQhJDAS0aJb8cKQGw2AT2J/4sWMoPYIgLqEq//
 TgGbxCzQwijRcLeDBWQ3p4CtxKH+TJAaYQFviRfffoAtYBFQkbh7cz0biM0rYClxa9tdZghb
 UOLkzCcsIDazgLzE9rdzmCEOUpD4+XQZK8QuJ4lTE7rYIGpEJGZ3tkHVTOSQaF8oDWG7SMza
 dQXqGWGJV8e3sEPYUhKf3+1lA7lTQqCZUWLpkoOsEE4Po8S/hutsEFXGEvuXTmYCeYBZQFNi
 /S59iLCixM7fcxkhFvNJvPvawwoJX16JjjYhiBIViUuvXzLB7Lr75D/rBEalWUhem4XktVlI
 XpiFsGwBI8sqRrHUguLc9NRkwwJDeGQn5+duYgQnUS3jHYyX5//TO8TIxMF4iFGCg1lJhPew
 qUOqEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4HpvG8knhDE0sDEzMjYxMLQzNDJXFexQmz
 U4QE0hNLUrNTUwtSi2D6mDg4pRqYlrcKlhz/5FwXEtVuvdJ2TYjzcqbWCdY6zje+r6temahV
 uOdevLXWFO65Jjf3zHvcM2vWA4GfuckH7mzverorZ+Xakg0dmS03ejKSkyJmv38tdkPqqEdj
 UNK6BLMHhbcOW7RLXWI536J2g9fJ54HlKcUI/gVOcVkMqxdrKE97xm45ZU9Dwh/ztLMidc12
 y98u/Oom9b0/UDPyZcvzo6kf+hn8DZqm3MoRyrd8tNvjw5PsztqYnPtuu1+yXN21vjRvq/5x
 xxaHlzt3mXoFGfGf3/24Na37t8uX8gsr5s5eGNhYXXXlq7Ttq9/vn7JcPn4/YAvT0+ydaUpV
 d51Y8tkEfjBoWEwrPTRh/5O9Ok9WKbEUZyQaajEXFScCAMWIBTcrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvC4/u1OqwZnlTBati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUVw2Kak5mWWpRfp2CVwZV5fcZCpYzFfxYNkmlgbGw9xdjJwcEgImEn9m7mLuYuTiEBLY
 ziix/1kHI0RCSuLz06lsXYwcQLawxOHDxRA1zxklevqOgdWwCehJ/F+0kBnEFhFQl3j9dwpY
 nFmgi1Hiz5FCiIb9jBIbPt0GG8QpYCtxqD8TpEZYwFvixbcfTCA2i4CKxN2b69lAbF4BS4lb
 2+4yQ9iCEidnPmGBmKkt8fTmUyhbXmL72znMEHcqSPx8uowV4gYniVMTutggakQkZne2MU9g
 FJ6FZNQsJKNmIRk1C0nLAkaWVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBcaQVtINx2fq/
 eocYmTgYDzFKcDArifAeNnVIFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2a
 WpBaBJNl4uCUamBaHjk/oDZ0gZJhirrLXpV/Sl+ci3hXnxR0rrZh+nVHZkeQ3lc+232/Ako2
 XkueIa3+8LJa7NQvD16eWPl1Qcq/31e1chb6msgcWLPTPzh49Y5zq+9t+r9Zi+Wo+s7MDR/a
 PujKrSna0SF34/hK91/Plr6ZUjPZsacqhDdwmares71njXYVXLKzMV53QmMNF2vYpFUC3sqR
 f/5qcxz5Uv/hR3PF6pI2M1fukGYhVWUHW+sle27tvbXm6mHbo8fPN1c7PFji3R8g+mDCSYPj
 a6OLuNl31GyNe2wpvHnilsyqGj7j/Ju5Si9KM5JvG8fpnLxw2K/e5GzrhuCzvdYPJOceXLN/
 3t7X/CF5GixrF7U+UmIpzkg01GIuKk4EACqpOJ8SAwAA
X-CMS-MailID: 20231101080639epcas1p4977bedc007a4791bca46208d987c22b4
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
> From: Jonas Karlman <jonas@kwiboo.se>
> Sent: Wednesday, November 1, 2023 4:47 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com; u-
> boot@lists.denx.de
> Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
> 
> On 2023-11-01 08:23, Jaehoon Chung wrote:
> > If reegulator is already enabled, it will be return to EALREADY.
> > But driver that its function is called can notice as error, even though
> > it's working fine.
> >
> > Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  drivers/power/regulator/regulator-uclass.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> > index 3a6ba69f6d5f..fc1c3eb93c9d 100644
> > --- a/drivers/power/regulator/regulator-uclass.c
> > +++ b/drivers/power/regulator/regulator-uclass.c
> > @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
> >  		}
> >  	}
> >
> > +	/* Regulator is already enabled */
> > +	if (ret == -EALREADY)
> > +		return 0;
> > +
> 
> Use of regulator_set_enable_if_allowed() will cover this error,
> and regulator_set_enable() should continue to return this error.

When I have checked on my target, It seems that it can't cover all cases.

On odroid-c4, USB doesn't work, even though its regulator is enabled.

=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
No USB device found
Couldn't init USB controller.


Best Regards,
Jaehoon Chung

> 
> Regards,
> Jonas
> 
> >  	return ret;
> >  }
> >


