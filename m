Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB7ED65C50
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 06:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A33895C4;
	Thu, 14 Nov 2024 07:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XOcPh55p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6E8895D0; Thu, 14 Nov 2024 07:54:41 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF1F895C7
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241114065432epoutp041a6326554b130b798147249afaaa2621~Hw0Ki1UPB2196921969epoutp04-
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241114065432epoutp041a6326554b130b798147249afaaa2621~Hw0Ki1UPB2196921969epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1731567272;
 bh=HjTEcm1VedwRGZ4AOLZyyoerBg0EzpU88GiYgaEerWE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=XOcPh55p2o/AjDFkArdBqyx3m92ViCVOVo4r1Ys6bzVWInlvlLNvWF3nsKZjP5ey6
 hZdOlCsbKAWqfnswo72nnC6wSa3nkw/pmyrCvW7aLICnqUwXJIkcV6KpLT28QTG3GD
 AFMtNHj7XJOmjkTE6Tjor2lZFcXYlvMMxOzJqU9o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241114065432epcas1p4efc4b9676b6a015d87bfaf8124eb8f8f~Hw0KTOn340796207962epcas1p4u;
 Thu, 14 Nov 2024 06:54:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.145]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4XprVb3P3Wz4x9QG; Thu, 14 Nov
 2024 06:54:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 AC.9F.09398.7AE95376; Thu, 14 Nov 2024 15:54:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241114065431epcas1p399b3f5c9fd30fe0b4e985fd07ad2fb81~Hw0I9NhE90571205712epcas1p3y;
 Thu, 14 Nov 2024 06:54:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241114065430epsmtrp2d858d1e452c80b8364d7db34468a864a~Hw0I7YX9p0801408014epsmtrp2E;
 Thu, 14 Nov 2024 06:54:30 +0000 (GMT)
X-AuditID: b6c32a39-5f9f8700000024b6-97-67359ea70638
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.6B.18937.6AE95376; Thu, 14 Nov 2024 15:54:30 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241114065430epsmtip2549692182668ca5b49f7baeb09dcf003~Hw0Il_5Je2629126291epsmtip2h;
 Thu, 14 Nov 2024 06:54:30 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Caleb Connolly'" <caleb.connolly@linaro.org>, "'Christian Marangi'"
 <ansuelsmth@gmail.com>, "'Dragan Simic'" <dsimic@manjaro.org>, "'Ilias
 Apalodimas'" <ilias.apalodimas@linaro.org>, "'Jerome Forissier'"
 <jerome.forissier@linaro.org>, "'Jonas Karlman'" <jonas@kwiboo.se>, "'Marek
 Vasut'" <marek.vasut+renesas@mailbox.org>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Peter Robinson'" <pbrobinson@gmail.com>, "'Rasmus Villemoes'"
 <rasmus.villemoes@prevas.dk>, "'Simon Glass'" <sjg@chromium.org>, "'Sughosh
 Ganu'" <sughosh.ganu@linaro.org>, "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20241113053023.1870736-1-caleb.connolly@linaro.org>
Subject: RE: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Date: Thu, 14 Nov 2024 15:54:30 +0900
Message-ID: <12cb01db3662$0df6e1e0$29e4a5a0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0CNXr2uE3B/dXATBqetSdIy0i+gHaT+sCsXXe9IA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmnu7yeabpBpc7JSymnvzGYnGqZRuT
 xYUtyha9Lb+ZLc63Lma3OPnmKotF68o7bBbrVq1hs/ix6gurxc3XDhbftmxjtLh3Tc5i6qTN
 7BZv93ayO/B5zG64yOKxc9Zddo9XB1axe5yYcInJ4861PWweZ+/sYPTYOXsfk0fD4TWMHhvf
 7WDymDH7DWMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotP
 gK5bZg7QA0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQS
 K0MDAyNToMKE7IwnS4+zFTyUqJi3pZmlgfG1cBcjB4eEgInEje15XYxcHEICOxgl3rctYYZw
 PjFKtCzfyQLnPLkyi62LkROsY8+nGWwQiZ2MEu03YKpeMko83XmZCaSKTUBP4v+ihWCzRASO
 s0isbJrGCpJgFpCSaDq5ixHE5hRwlDjRcglsrLCAh8S69rdgcRYBVYlD65sYQQ7kFbCU2NWh
 BbFZQeLn02VgY0QErCQ2LHzJDDFSRGJ2ZxvYLgmBHRwSj6+0MkM0uEicefmBEcIWlnh1fAs7
 hC0l8fndXjaIhmZGiaVLDrJCOD2MEv8arkM9aiyxf+lkJpArmAU0Jdbv0ofYxifx7msPKyT0
 eCU62oQgqlUkLr1+yQQz/+6T/6wQtodEx527TJAQmsIocbDzJesERvlZSA6fhbBhASPTKkax
 1ILi3PTUYsMCU3hcJufnbmIEJ10tyx2M099+0DvEyMTBeIhRgoNZSYT3lLNxuhBvSmJlVWpR
 fnxRaU5q8SFGU2BITmSWEk3OB6b9vJJ4QxNLAxMzI2MTC0MzQyVx3jNXylKFBNITS1KzU1ML
 Uotg+pg4OKUamIw5n18V29rSvCffYfMVXvUwh8oE687J6iyOW/kf/ue8x6OYfN75+GL5TRmK
 rzzWt8g89jqZ+33XlzaGLwVLi74sEv/0JKTQ9YLv+nTpywWcYe0WlgwqgQ5z2r2Mk8s+e8v8
 N3iyd4/c9DV198Pn6nF59FdJv06p2v3CPEe6smU365M7L59XT9p5v0y/4nRl0u0NG6MefYmS
 v7L/lh+LwiWbCq0m1+Yjdu8/7sxr809YoftQXsvC57q99c3YGv94rZ12HBU2t/pLag/37HF2
 +6Ox99PTGR8+KL+6/CS6qdP+lrjp/apPh1pyc8u5davTP7uXRy5btjBP3+nO/crcxq+H1J2W
 2jmz/8o17XuvxFKckWioxVxUnAgA1PHWakMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO6yeabpBm+eGFlMPfmNxeJUyzYm
 iwtblC16W34zW5xvXcxucfLNVRaL1pV32CzWrVrDZvFj1RdWi5uvHSy+bdnGaHHvmpzF1Emb
 2S3e7u1kd+DzmN1wkcVj56y77B6vDqxi9zgx4RKTx51re9g8zt7Zweixc/Y+Jo+Gw2sYPTa+
 28HkMWP2G8YArigum5TUnMyy1CJ9uwSujCdLj7MVPJSomLelmaWB8bVwFyMnh4SAicSeTzPY
 uhi5OIQEtjNKHHn/mx0iISXx+elUoAQHkC0scfhwMUTNc0aJa+/2sYDUsAnoSfxftJAZxBYR
 uMgicXI3J4jNDNTbdHIXI0TDJEaJLfcvgjVwCjhKnGi5xAZiCwt4SKxrf8sIYrMIqEocWt/E
 CLKMV8BSYleHFsQNChI/ny5jhZhvJbFh4UtmiPkiErM725gnMArMQuIuYGRcxSiaWlCcm56b
 XGCoV5yYW1yal66XnJ+7iREcKVpBOxiXrf+rd4iRiYPxEKMEB7OSCO8pZ+N0Id6UxMqq1KL8
 +KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqaFPvxP++a+MX2ZvzrLcknY
 Q7+UG7zejn9tmFXWxUw6teWX9PLPTZ6XnWL826Web0+MDtmy/bxgcA5P8a0nb1Qqn3C5HS19
 /Mlt5nbpzWrnHfacYOR0P/qFsbJN1NfKIj/98tOb2wt7HL/P3FpyIu132oe5mvsTzp3a+vdf
 8SGTGdUWMoHHJrTW5i84vuSN6r2Kzc3zqwJ9xO0PSLZ92DPXjcu0dM05Lb55JxNenTxpIVKV
 aPlIgkPsrdRODY1t055G+3Z8O2Sq4vJQNExBwuDq9D12SivD5vcV9sy0WBX178HsdrYvyzYf
 C82dxbwhd7fpj5oOw3UOhU/WyW5xDs65qJxW+aWq/sDGJK6W/N9KLMUZiYZazEXFiQBQm/ri
 AwMAAA==
X-CMS-MailID: 20241114065431epcas1p399b3f5c9fd30fe0b4e985fd07ad2fb81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241113053033epcas1p2f8d1ef98103f17f5442279ac21a898fc
References: <CGME20241113053033epcas1p2f8d1ef98103f17f5442279ac21a898fc@epcas1p2.samsung.com>
 <20241113053023.1870736-1-caleb.connolly@linaro.org>
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
> From: Caleb Connolly <caleb.connolly@linaro.org>
> Sent: Wednesday, November 13, 2024 2:30 PM
> To: Caleb Connolly <caleb.connolly@linaro.org>; Christian Marangi <ansuelsmth@gmail.com>; Dragan Simic
> <dsimic@manjaro.org>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; Jaehoon Chung
> <jh80.chung@samsung.com>; Jerome Forissier <jerome.forissier@linaro.org>; Jonas Karlman
> <jonas@kwiboo.se>; Marek Vasut <marek.vasut+renesas@mailbox.org>; Peng Fan <peng.fan@nxp.com>; Peter
> Robinson <pbrobinson@gmail.com>; Rasmus Villemoes <rasmus.villemoes@prevas.dk>; Simon Glass
> <sjg@chromium.org>; Sughosh Ganu <sughosh.ganu@linaro.org>; Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Subject: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
>
> It may be the case that MMC support is enabled even though the board
> we're booting on doesn't have any MMC devices. Move the print over to
> the print_mmc_devices() function where we can only print it if we
> actually have MMC devices.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_r.c         | 1 -
>  drivers/mmc/mmc-uclass.c | 4 +++-
>  drivers/mmc/mmc_legacy.c | 5 +++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e12..232a8fd19f03 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -384,9 +384,8 @@ static int initr_onenand(void)
>
>  #ifdef CONFIG_MMC
>  static int initr_mmc(void)
>  {
> -	puts("MMC:   ");
>  	mmc_initialize(gd->bd);
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index c8db4f811c2f..56fe29249c36 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
>  	     dev;
>  	     uclass_next_device(&dev), first = false) {
>  		struct mmc *m = mmc_get_mmc_dev(dev);
>
> -		if (!first) {
> +		if (first) {
> +			printf("MMC:  ");
> +		} else {

Frankly, I don't know if it needs to print "MMC; " at here.
It's already knowing mmc with mmc command. In board_r, To clarify which device is showing "MMC", but not here.

Best Regards,
Jaehoon Chung

>  			printf("%c", separator);
>  			if (separator != '\n')
>  				puts(" ");
>  		}
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be717..f4a049a4a4d4 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
>  {
>  	struct mmc *m;
>  	struct list_head *entry;
>  	char *mmc_type;
> +	bool first = true;
>
>  	list_for_each(entry, &mmc_devices) {
>  		m = list_entry(entry, struct mmc, link);
>
> @@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
>  			mmc_type = IS_SD(m) ? "SD" : "eMMC";
>  		else
>  			mmc_type = NULL;
>
> +		if (first) {
> +			printf("MMC:  ");
> +			first = false;
> +		}
>  		printf("%s: %d", m->cfg->name, m->block_dev.devnum);
>  		if (mmc_type)
>  			printf(" (%s)", mmc_type);
>
> --
> 2.47.0



