Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379FCC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD9218751F;
	Tue, 31 Oct 2023 06:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Jl5fYLsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C8387AB6; Tue, 31 Oct 2023 06:03:03 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D848709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231031050256epoutp012f8eb5119c13d38eef016e3be2087da1~TGKPYJr9a2081220812epoutp01L
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:02:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231031050256epoutp012f8eb5119c13d38eef016e3be2087da1~TGKPYJr9a2081220812epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728576;
 bh=0hlwRjg0aqoX/cS5rRCdeYaBTEXk3tnqQsII4KKeF70=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Jl5fYLsd1sP8eo0/2YLyGVyiKkcUR0znWveA2hKKGLzOxSvniaxI2AUoS1SUnQgGI
 gYCUlUnC2TBmmtLA/KtAvt/rnBqCZ7d2BL7riNC3z/Fd+TdJSrtoMldRT+whwBAQzL
 Ak1i8JhlHWyOExDcmC98R9vHRXnswiuquvQpHu4A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231031050256epcas1p104a15f18030b7ec0dc72aeff5b892e4f~TGKPLGjKl2470624706epcas1p1D;
 Tue, 31 Oct 2023 05:02:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKJ1C0Bb1z4x9Py; Tue, 31 Oct
 2023 05:02:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 58.AD.10025.E7A80456; Tue, 31 Oct 2023 14:02:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031050254epcas1p4ed27bc59086fa0854df068deb7d13101~TGKNyK4oX1200812008epcas1p4l;
 Tue, 31 Oct 2023 05:02:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031050254epsmtrp1ce2cc02bb579b67389a255cb513cb52d~TGKNxlm4b2391023910epsmtrp1g;
 Tue, 31 Oct 2023 05:02:54 +0000 (GMT)
X-AuditID: b6c32a39-24b00a8000002729-12-65408a7e71c8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.78.08817.E7A80456; Tue, 31 Oct 2023 14:02:54 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050254epsmtip134d35306d2b237ff231eb0c768c4e0fb~TGKNXNzMK1617516175epsmtip1E;
 Tue, 31 Oct 2023 05:02:54 +0000 (GMT)
Message-ID: <9940bfe9-dbbc-4f35-bc5d-425f68adc5f5@samsung.com>
Date: Tue, 31 Oct 2023 14:02:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] power: pmic: support TI TPS65913 PMIC
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230715183431.5318-2-clamor95@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQLeuyyHVoPWUlcWB/l5Gi0nrr7Fb
 fNuyjdHi7d5OdgcWj9kNF1k8nvZvZffYOesuu8fZOzsYA1iism0yUhNTUosUUvOS81My89Jt
 lbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYqKZQl5pQChQISi4uV9O1sivJLS1IV
 MvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izut7uYy7YxFHR0bCduYHxBVsX
 IyeHhICJRMf3p0A2F4eQwA5GiYb29ewQzidGiQV757NAON8YJbZt+M0I07Jlxyyoqr2MEud/
 rGSFcN4zShy99oMdpIpXwE7i+usVQO0cHCwCqhL/r3hChAUlTs58wgJiiwrIS9y/NYMdpERY
 wFFi6/JSkDCzgLjErSfzmUBsEYEaie0zLrNAxCUklhy6zwpiswnoSGz/dhyshlPAXGLCtm/s
 EDXyEtvfzmEGOUdC4CO7ROveHkaQ+RICLhL3PjtB3C8s8er4FnYIW0riZX8bO0R9M6PE0iUH
 WSGcHkaJfw3XoYFkLLF/6WQmkEHMApoS63fpQ4QVJXb+nssIsZhP4t3XHlaIXbwSHW1CECUq
 Epdev2SC2XX3yX9WCNtD4v2D+YwTGBVnIYXKLCTvz0LyziyExQsYWVYxiqUWFOempxYbFpjC
 Izs5P3cTIzg5alnuYJz+9oPeIUYmDsZDjBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosPMZoC
 o2Yis5Rocj4wPeeVxBuaWBqYmBkZm1gYmhkqifOee9ubIiSQnliSmp2aWpBaBNPHxMEp1cDE
 83nyvb4JTw8GlYf/c1VKkhQ2dd8XePrSp3gbpVs9731e/nLkXirN2uGpnim9qz4vUsB1bRdz
 5qbX6dX/Xnxld7y4p/Q+a6RLDm/Ombjza+7p2/EVX/q0I0u+klNhx/R7qVWzLEr6j17b+tn2
 9f60xLuic53d5U5tua2/1PtaaY6Iy5PjEwqWLm92+Mwz/eoTKdVDYjUZpzaV+xw4bnDiRfQO
 +2UzXF4kTjojw2W4Y9q6Xue9MZrB8v+ftZ1+1yybn3fPxUq++9/nFd7dVtnTDZ6v5rbmtDxr
 FLi2vePnPrVA+9kH3izLmdt71CXQ2LR6kRvfihufmHSklNZ+a3wlIrnr9ZrlkuW//vNt3b9a
 iaU4I9FQi7moOBEAPaaCCxcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnG5dl0OqwaTXGhYH+nsZLSatv8Zu
 8W3LNkaLt3s72R1YPGY3XGTxeNq/ld1j56y77B5n7+xgDGCJ4rJJSc3JLEst0rdL4MroeruP
 uWATR0VHw3bmBsYXbF2MnBwSAiYSW3bMYu9i5OIQEtjNKHF/1152iISUxOenU4GKOIBsYYnD
 h4shat4ySmy78pIZpIZXwE7i+usVLCA1LAKqEv+veEKEBSVOznzCAmKLCshL3L81gx2kRFjA
 UWLr8lKQMLOAuMStJ/OZQGwRgRqJxrndbBBxCYklh+6zgpQLCSRLTHoDtohNQEdi+7fjYOWc
 AuYSE7Z9A5vILKAusX6eEESnvMT2t3OYJzAKzUJywywky2YhdMxC0rGAkWUVo2RqQXFuem6x
 YYFRXmq5XnFibnFpXrpecn7uJkZwFGhp7WDcs+qD3iFGJg7GQ4wSHMxKIryHTR1ShXhTEiur
 Uovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamCyiNpcckpz6sc7mg+L
 BF5ZKcUrfzq7d+V8OeWF82NtmjZxzv91+aDLZ2dNL19XzWOr7bcEGa32kphtvC/09herWc0b
 usK0CjUT3Jz27lYNuv74+iK95j0FGwtvb69WeNfyjWPvtQXMlrcmRU2cZqukLrOkKpuxtJ0x
 UdXIeuWlDz6qq+cxsvy7nbd3dd2TxVITzhfsd09Nfvt/9y3P6seTrZby9nraL1iol3n3CUtf
 V+KX5q9m9RO1tmwNXsE252DqAt2JwivWd9+ZP/fHxSm2qr5fDQ6//MroOLeafdI0eybt461Z
 JlKXv3bo35WbfNIguLrypGCX9Sqx4H+NgTOOGQm62z58s3OrFdO1T5PDlViKMxINtZiLihMB
 LJx18vECAAA=
X-CMS-MailID: 20231031050254epcas1p4ed27bc59086fa0854df068deb7d13101
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050254epcas1p4ed27bc59086fa0854df068deb7d13101
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-2-clamor95@gmail.com>
 <CGME20231031050254epcas1p4ed27bc59086fa0854df068deb7d13101@epcas1p4.samsung.com>
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

On 7/16/23 03:34, Svyatoslav Ryhel wrote:
> Existing PALMAS PMIC driver is fully compatible with TI TPS65913
> PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
> TF701T. TPS65913 shares same structure of regulators like TPS659038
> so data can be reused.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/palmas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index 6080cbff0b..d6eb9cb433 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -87,6 +87,7 @@ static struct dm_pmic_ops palmas_ops = {
>  
>  static const struct udevice_id palmas_ids[] = {
>  	{ .compatible = "ti,tps659038", .data = TPS659038 },
> +	{ .compatible = "ti,tps65913" , .data = TPS659038 },
>  	{ .compatible = "ti,tps65917" , .data = TPS65917 },
>  	{ }
>  };

