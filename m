Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47536C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 08:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A12487A52;
	Wed,  1 Nov 2023 09:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Ym3jHMR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBAF879E2; Wed,  1 Nov 2023 09:10:49 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0038870C9
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 09:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101081038epoutp046a66253f442f0f5f3b72d7ceaa87543f~TcXahdeUX3129031290epoutp04B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101081038epoutp046a66253f442f0f5f3b72d7ceaa87543f~TcXahdeUX3129031290epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698826238;
 bh=QBcXKL+H6I004PSXyaYexa2XSwK845l2Ik5HTUmDi1Q=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Ym3jHMR3PJqdyzg1Q9Zs5Ui/+UY0LrxoYfEsLBLOoi1hMPUBJD8SYhmPdYR27/ZMh
 01bwtaRRT7AVeKauWAUpNmMoAlQJk+hOSy6We19kwl3pUUCVkFu419kuRPplHP36NA
 v2mpcAeNDk1yEORiFAZtsmPNiIwsW8574TrvZ9l8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231101081038epcas1p3877462054c19d9eae38471a670b00b5b~TcXaGdtn30337703377epcas1p3_;
 Wed,  1 Nov 2023 08:10:38 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.132]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SL07K313sz4x9QB; Wed,  1 Nov
 2023 08:10:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 56.12.09739.CF702456; Wed,  1 Nov 2023 17:10:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101081036epcas1p47304474e39e405deab24746a25e1e292~TcXYnTCBx2892428924epcas1p4u;
 Wed,  1 Nov 2023 08:10:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101081036epsmtrp29c4794cb88fbb168b56850cc76e7ae7f~TcXYmkQlP2881128811epsmtrp2j;
 Wed,  1 Nov 2023 08:10:36 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-90-654207fc28aa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F0.1A.07368.CF702456; Wed,  1 Nov 2023 17:10:36 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101081036epsmtip2482707ba595348d2baef4a3ebbeb60a9~TcXYaHMdI0982609826epsmtip2W;
 Wed,  1 Nov 2023 08:10:36 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Jonas Karlman'" <jonas@kwiboo.se>
Cc: <sjg@chromium.org>, <patrice.chotard@foss.st.com>,
 <eugen.hristev@collabora.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <025e01da0c9a$573ccbf0$05b663d0$@samsung.com>
Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
Date: Wed, 1 Nov 2023 17:10:36 +0900
Message-ID: <025f01da0c9a$e4da4e60$ae8eeb20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGNlC1FaWtC5Axzkm5yITVXfLyFOgHb/8w7Ak3hn1kCZYBUybDJkhTQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvu5fdqdUg5apTBati24zWpx8c5XF
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nJhwicnj7J0d
 jAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3
 KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyB
 ChOyM56vvcxc0CRccb39OGMD4xT+LkZODgkBE4kXE26zdjFycQgJ7GCUmH/kGROE84lR4lvb
 GmYI5xujxO89R9lhWm71T4eq2ssosen/bKj+l4wSu9qvMIFUsQnoSfxftJAZxBYRUJd4/XcK
 I0gRs0ALo0TD3Q4WkASngJXEooX/wWxhAW+JF99+gDWzCKhIbPuxlBHE5hWwlHi0tIcFwhaU
 ODnzCZjNLCAvsf3tHGaIkxQkfj5dxgqxzE3i2ov7zBA1IhKzO9ugaqZySNy64AVhu0gc725l
 gbCFJV4d3wL1mpTE53d72UAOlRBoZpRYuuQgK4TTwyjxr+E6G0SVscT+pZOBLuUA2qApsX6X
 PkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGRuPT6JRPMrrtP/rNOYFSaheS1WUhem4Xk
 hVkIyxYwsqxiFEstKM5NTy02LDCGx3dyfu4mRnAq1TLfwTjt7Qe9Q4xMHIyHGCU4mJVEeA+b
 OqQK8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgMs8riTc0sTQwMTMyNrEwNDNUEue99aw3
 RUggPbEkNTs1tSC1CKaPiYNTqoEpNDDHn9eS0ST3uHQG6zK1H/PN7zn6PDWR+rZPcf6hTmmz
 j201f8IcGmfEr2M+/f305nt9L2+v2OZ4bmLmtKJd2iGck75XCxXJn3kn1RR/cJkk44rczfJX
 57tb83Z7cl680bVu2u66iKIbAa+jcw6/uds/6V+9+P/Ei9rrTzMblFXIFcinOOlffJkgkCTw
 8WhCyNYjO+tMMowWthgJit6PlG69Mnv38+sL7U8lKHUXbJDeMEP12RW7h29THp+7X6InMlOg
 yni/QoTVjKOr41fGL+S6frj53hc+N5ar/D03J/+ckXb1f/Cb1Uqc16M8i6f7HxdWnih1+ffO
 SyfU/r6OLPSJSP/PaXV8YpAG6/szSizFGYmGWsxFxYkAkRlviC4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvcPu1OqQdt2NYvWRbcZLU6+ucpi
 8fPke3aLb1u2MVpMnbSZ3eLt3k52BzaP2Q0XWTx23F3C6PG0fyu7x6sDq9g9Tky4xORx9s4O
 xgC2KC6blNSczLLUIn27BK6M52svMxc0CVdcbz/O2MA4hb+LkZNDQsBE4lb/dKYuRi4OIYHd
 jBLNB34yQySkJD4/ncrWxcgBZAtLHD5cDFHznFHidM8NdpAaNgE9if+LFoLViwioS7z+O4UR
 xGYW6GKU+HOkEKLhLaPE/3VrwBo4BawkFi38zwJiCwt4S7z49oMJxGYRUJHY9mMpWDOvgKXE
 o6U9LBC2oMTJmU9YIIZqSzy9+RTKlpfY/nYO1KEKEj+fLmOFOMJN4tqL+8wQNSISszvbmCcw
 Cs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4IjS0tjB
 eG/+P71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2x
 JDU7NbUgtQgmy8TBKdXApHHCZrtP6e7JT9bn7Sw/KaN6krvMctGWk2EfjJplfmREnDqT+FXv
 99ed649Fv53wtfC1u+1P1i1Vk9luS1teO+77smWXSKXO78UsZfIbzT50KO86lPpk60ltgb5w
 MRdZWbU9/wKS20rPLp25LNWMdardWfuCaYVX8g2fbAgv7l/lfmm3jzzDFN1jtmaGn3lWZUvc
 MmFXiZAx7+01DLz4c0dmv3pJQRV/5deVjPWia+bddvC4vEmvLSxN7ovJhrvGWkkfd/x8Wm8l
 +Klw1+225CXn/qyzzJPLC3SRO10qujVi5uvkeNuk1fd2zE39yme1ZIvHv+6E1t8m8qktnwN/
 x306vOb1ap+TKXbnXj7nVGIpzkg01GIuKk4EAPT6GzwXAwAA
X-CMS-MailID: 20231101081036epcas1p47304474e39e405deab24746a25e1e292
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
> Sent: Wednesday, November 1, 2023 5:07 PM
> To: 'Jonas Karlman' <jonas@kwiboo.se>
> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com; u-
> boot@lists.denx.de
> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
> 
> 
> 
> > -----Original Message-----
> > From: Jonas Karlman <jonas@kwiboo.se>
> > Sent: Wednesday, November 1, 2023 4:47 PM
> > To: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
> u-
> > boot@lists.denx.de
> > Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
> >
> > On 2023-11-01 08:23, Jaehoon Chung wrote:
> > > If reegulator is already enabled, it will be return to EALREADY.
> > > But driver that its function is called can notice as error, even though
> > > it's working fine.
> > >
> > > Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
> > >
> > > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > > ---
> > >  drivers/power/regulator/regulator-uclass.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-
> uclass.c
> > > index 3a6ba69f6d5f..fc1c3eb93c9d 100644
> > > --- a/drivers/power/regulator/regulator-uclass.c
> > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
> > >  		}
> > >  	}
> > >
> > > +	/* Regulator is already enabled */
> > > +	if (ret == -EALREADY)
> > > +		return 0;
> > > +
> >
> > Use of regulator_set_enable_if_allowed() will cover this error,
> > and regulator_set_enable() should continue to return this error.

Well.. I will recheck about your comment.

Best Regards,
Jaehoon Chung

> 
> When I have checked on my target, It seems that it can't cover all cases.
> 
> On odroid-c4, USB doesn't work, even though its regulator is enabled.
> 
> => ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
> No USB device found
> Couldn't init USB controller.
> 
> 
> Best Regards,
> Jaehoon Chung
> 
> >
> > Regards,
> > Jonas
> >
> > >  	return ret;
> > >  }
> > >
> 


