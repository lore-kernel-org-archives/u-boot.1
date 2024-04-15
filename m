Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E7AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2858F881E7;
	Mon, 15 Apr 2024 09:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VpUezhQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B8688188; Mon, 15 Apr 2024 09:00:11 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E686881E7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240415070005epoutp03f1f1b40db174f5f408a660b1167c1fbc~GYfMwB7Ia0186001860epoutp03e
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:00:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240415070005epoutp03f1f1b40db174f5f408a660b1167c1fbc~GYfMwB7Ia0186001860epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713164405;
 bh=6QpkdFAv3Wss8B0kg4VEq+Veyd0546AJdTSWS7L1kRM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=VpUezhQczmOeIkv48rdo8y25HuYTqJBa3ZKvlduSkx78tNwAxMpCLseK6mv3n1RFT
 c+fFGG3K8QA08393yThQL2SXuZvutTwR4Gn53tMWYqrIJkCq7/Ofxc8nC4zpAxW1We
 9LH5esEZWAVpZ3cjdTI6uhRqsA2LeU3PZx1lFGMg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240415070005epcas1p229ae4e1449bea18cf2862e9659f13b27~GYfMkBpEZ3156431564epcas1p2R;
 Mon, 15 Apr 2024 07:00:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VHyjJ1vqlz4x9QW; Mon, 15 Apr
 2024 07:00:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 96.1E.09662.470DC166; Mon, 15 Apr 2024 16:00:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240415070003epcas1p3e4ff0bdb0f31dbf47adf71dd738d34ae~GYfLXPs452619526195epcas1p3f;
 Mon, 15 Apr 2024 07:00:03 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240415070003epsmtrp1b53ad1a902973c6ab10fb3950417255c~GYfLWLPcW1256112561epsmtrp1r;
 Mon, 15 Apr 2024 07:00:03 +0000 (GMT)
X-AuditID: b6c32a35-8da83a80000025be-89-661cd0742b80
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 08.58.07541.370DC166; Mon, 15 Apr 2024 16:00:03 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415070003epsmtip12a83b370c9ebc61412ce27ab40925951~GYfLIJaFQ3166331663epsmtip1R;
 Mon, 15 Apr 2024 07:00:03 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Yang Xiwen'" <forbidden405@outlook.com>, "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <SEZPR06MB6959CC3A9319816B2DFA8AA7963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v2 3/3] mmc: hi6220_dw_mmc: add fifoth_val to private
 data and set it in .probe
Date: Mon, 15 Apr 2024 16:00:03 +0900
Message-ID: <008701da8f02$8a73ea90$9f5bbfb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG10PZhwJPp9GmYju4dCS4VuJkgUQD+pn9xAug65FQCw9e32gJoGQiRsWnMUyA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvm7JBZk0g1kdvBb/bu5ht/ix6gur
 xdu9newOzB5n7+xg9Nj4bgeTx+bXL5gDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjNmzF7IXnBZvGJX82HmBsbTQl2MnBwSAiYSM/s3
 sHcxcnEICexglLi3aiGU84lR4vKVB4wQzjdGiQWTVrB2MXKAtTRMDIWI72WUWPnqKwuE85JR
 ovvGBkaQuWwCehL/Fy1kBmkQEQiQeHJRASTMLCAl0XRyF1gJp0CsxKaWBhaQEmGBVImO7WBh
 FgFViZVTrzKB2LwClhIn1i9lgbAFJU7OfMICMUZeYvvbOcwQHyhI/Hy6jBVik5/Emz/iECUi
 ErM725hBLpMQeMkusa5hNwtEvYvExE+dTBC2sMSr41vYIWwpiZf9bewQDc2MEkuXHGSFcHoY
 Jf41XGeDqDKW2L90MhPINmYBTYn1u/QhtvFJvPvaAw0fXomONmjoqkhcev2SCWb+3Sf/WSFs
 D4mGL7dYJjAqzkLy2iwkr81C8sMshGULGFlWMYqlFhTnpqcWGxYYwuM6OT93EyM4DWqZ7mCc
 +PaD3iFGJg7GQ4wSHMxKIrzX5CTThHhTEiurUovy44tKc1KLDzGaAgN7IrOUaHI+MBHnlcQb
 mlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXAVPrg2JfHKSuYPF8K7c+1
 7rpQe43v6bKeTR1rC38r129b4/KlTuXFpuRkV70HLjtY+BumrebNaVCwLTzwr5w75uRxVl3P
 lLCkKM/WT4xb41RO/2c9clpEq7j9saiUe1qL/beE+CnsXz1uiGZe4Hfafv7++SiemZ9Cl/dp
 8ZzcnB66v8mRr/9N44tPi2ZcWpGw7r+o0MTFzH8mzH3AfLg7davly50SE/3qpba6cTixvf5d
 c0Mmb7IUm5XGWdsfAbY7VgTt5V5w/9Wb4h3996b7rTyhIXmGuzSlfJvCy2SHKTmNUcttf2x1
 nnKhacW0JOY+pj5BLhWVSRZN2gfazh79tDin88pTR/uu6zdyl+ZvVWIpzkg01GIuKk4EAGy4
 BGEMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG7xBZk0g/5fuhb/bu5ht/ix6gur
 xdu9newOzB5n7+xg9Nj4bgeTx+bXL5gDmKO4bFJSczLLUov07RK4MmbMXshecFm8YlfzYeYG
 xtNCXYwcHBICJhINE0O7GLk4hAR2M0r8/HubvYuREyguJfH56VQ2iBphicOHiyFqnjNKXO/f
 wAxSwyagJ/F/0UIwW0QgQGLhzjZGEJsZqLfp5C5GqKFMEutuzWUCSXAKxEpsamlgAbGFBZIl
 FlybBdbMIqAqsXLqVbAaXgFLiRPrl7JA2IISJ2c+YYEYqi3x9OZTKFteYvvbOcwQhypI/Hy6
 jBXkUBEBP4k3f8QhSkQkZne2MU9gFJ6FZNIsJJNmIZk0C0nLAkaWVYySqQXFuem5yYYFhnmp
 5XrFibnFpXnpesn5uZsYwRGhpbGD8d78f3qHGJk4GA8xSnAwK4nwXpOTTBPiTUmsrEotyo8v
 Ks1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qByWBFbVPYhcTnXNqafn8P3lDx
 aJUXebRlvd/KiusJCjPVn1adMy+b5ezUwP5tYfK1hFc7Lpgef8a878fRQ2nqfL+sns/lORA/
 R9r60ObyM7u2+D351Jf/yfZ5nta5DVdnb/0s6te/5rhxFKvtPe0ZMu6aMZmLDVafWsTz7crT
 eaXBfwTzVh6UrvzwtVlDVHh1qqf9nrmVymfW7GV0evSNI8Mw9YHQrhLxqBkVHznP7FueecTq
 550A7i0cHhnJy7e8nKfJnxDy/Ki2hUxt6H5HeQ+tu6WHSxT7Mw6mtPIsq5mRsyDgUWvzzLxT
 7go8Xl/CjBa/uXXwyo+01uhviXJaTleYTqh7Shx2uG1j7D9LVImlOCPRUIu5qDgRAIHrUO33
 AgAA
X-CMS-MailID: 20240415070003epcas1p3e4ff0bdb0f31dbf47adf71dd738d34ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-3-9f09dc1335fd@outlook.com>
 <CGME20240403004345epcas1p3f668ec6887b8e74350e9840682a875c5@epcas1p3.samsung.com>
 <56685eac-34ff-4ad9-9128-1ba83a9a48c6@samsung.com>
 <SEZPR06MB6959CC3A9319816B2DFA8AA7963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
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
> From: Yang Xiwen <forbidden405@outlook.com>
> Sent: Wednesday, April 3, 2024 10:22 AM
> To: Jaehoon Chung <jh80.chung@samsung.com>; Peng Fan <peng.fan@nxp.com>
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH v2 3/3] mmc: hi6220_dw_mmc: add fifoth_val to private data and set it in .probe
> 
> On 4/3/2024 8:43 AM, Jaehoon Chung wrote:
> > Hi
> >
> > On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> >> From: Yang Xiwen <forbidden405@outlook.com>
> >>
> >> The value defaults to 0 and is ignored by dw_mmc code, so the other
> >> users are not affected.
> >>
> >> Setting this explicitly fixes some weird reading error found on Hi3798MV200.
> >>
> >> Fixes: 8a5dc8140e62 ("mmc: hi6220_dw_mmc: add compatible for HC2910 support")
> >>
> >> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> >> ---
> >>   drivers/mmc/hi6220_dw_mmc.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> >> index a4b8072976..dc0210402b 100644
> >> --- a/drivers/mmc/hi6220_dw_mmc.c
> >> +++ b/drivers/mmc/hi6220_dw_mmc.c
> >> @@ -37,6 +37,7 @@ struct hi6220_dwmmc_priv_data {
> >>   struct hisi_mmc_data {
> >>   	unsigned int clock;
> >>   	bool use_fifo;
> >> +	u32 fifoth_val;
> >>   };
> >>
> >>   static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
> >> @@ -125,6 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
> >>   	host->mmc = &plat->mmc;
> >>
> >>   	host->fifo_mode = mmc_data->use_fifo;
> >> +	host->fifoth_val = mmc_data->fifoth_val;
> >>   	host->mmc->priv = &priv->host;
> >>   	upriv->mmc = host->mmc;
> >>   	host->mmc->dev = dev;
> >> @@ -154,13 +156,20 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
> >>   	.use_fifo = false,
> >>   };
> >>
> >> +static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
> >> +	.clock = 50000000,
> >> +	.use_fifo = false,
> >> +	// FIFO depth is 256
> > Removed unnecessary comment.
> 
> 
> Will do. It seems that this should also apply to hi3798cv200-dw-mshc.
> tests are needed from cv200 users.

In future, It can be removed. Others looks good to me.

Best Regards,
Jaehoon Chung

> 
> 
> >
> > Best Regards,
> > Jaehoon Chung
> >
> >> +	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
> >> +};
> >> +
> >>   static const struct udevice_id hi6220_dwmmc_ids[] = {
> >>   	{ .compatible = "hisilicon,hi6220-dw-mshc",
> >>   	  .data = (ulong)&hi6220_mmc_data },
> >>   	{ .compatible = "hisilicon,hi3798cv200-dw-mshc",
> >>   	  .data = (ulong)&hi6220_mmc_data },
> >>   	{ .compatible = "hisilicon,hi3798mv200-dw-mshc",
> >> -	  .data = (ulong)&hi6220_mmc_data },
> >> +	  .data = (ulong)&hi3798mv2x_mmc_data },
> >>   	{ .compatible = "hisilicon,hi3660-dw-mshc",
> >>   	  .data = (ulong)&hi3660_mmc_data },
> >>   	{ }
> 
> 
> --
> Regards,
> Yang Xiwen


