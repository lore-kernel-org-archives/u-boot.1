Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD82FC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B956881F8;
	Mon, 15 Apr 2024 10:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="F9A3l+sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA09D881FB; Mon, 15 Apr 2024 10:01:30 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD494881D7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240415080123epoutp04243252483075c2d24c63c469e01fccb0~GZUuRcI862788427884epoutp04i
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240415080123epoutp04243252483075c2d24c63c469e01fccb0~GZUuRcI862788427884epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713168083;
 bh=9r3YNlSIif/sCVRmiGrNSbu0K+lOP85l1FLlKNjgpiw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=F9A3l+sUmquB3E5jp+mZ8DteHnCd5IetcVSBlhdCKarP3N/p6+88F2qbAUCisCb37
 ouhyKCK9b5qjeXrHTRw/+eYav/9Mub/KUYj2D0bcM1fqlhH7wIsZX6m07Oe4FNyjQr
 1HyRkbC5wfsMkm4KL0WlJJ6nca5aWIoO7rgZyYa8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240415080123epcas1p3d634587b2a42bb378837bffde4b28e89~GZUuDbcus3111331113epcas1p3Y;
 Mon, 15 Apr 2024 08:01:23 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VJ0422Z5nz4x9Pv; Mon, 15 Apr
 2024 08:01:22 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 61.6D.08627.0DEDC166; Mon, 15 Apr 2024 17:01:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240415080119epcas1p1640e1e4e2e30fdb48a5ef066a31d42de~GZUq5fuwe1604716047epcas1p1F;
 Mon, 15 Apr 2024 08:01:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240415080119epsmtrp2c81c133514c503dc25d3ddbd5c8912f0~GZUq0aVSM1844218442epsmtrp2f;
 Mon, 15 Apr 2024 08:01:19 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-7f-661cded009d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B5.D4.08390.FCEDC166; Mon, 15 Apr 2024 17:01:19 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415080119epsmtip2c880a95123cf6542271ba9d3545b0e86~GZUqrf_T51278212782epsmtip2E;
 Mon, 15 Apr 2024 08:01:19 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>, <ycliang@andestech.com>
In-Reply-To: <20240415075650.22442-1-jh80.chung@samsung.com>
Subject: RE: [PATCH] mmc: cv1800b_sdhci: Remove the unused argument
Date: Mon, 15 Apr 2024 17:01:19 +0900
Message-ID: <004201da8f0b$19874a80$4c95df80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGDPg9KrP8dteI1QJakciBGvJyHTwEtnStVsg4s9eA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmge6FezJpBs2H2CymTtrMbvF2bye7
 xeNDr5kcmD32nJ7F7PHqwCp2j7N3djAGMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGes33iKveAOZ8Xyzu2MDYzf2bsYOTkkBEwk3n0/
 zdzFyMUhJLCDUWLO/vdMEM4nRomHd+axQDjfGCUONbazwLScONAOldjLKPHp+TVGCOclo8Tv
 RfeZQKrYBPQk/i9ayAxiiwhISbzs3AhmMwsYSqz995ERxOYUsJF4uOAcWL2wgLPEnGPnwI5i
 EVCVmDlpHlgNr4ClxJn27cwQtqDEyZlPWCDmyEtsfzuHGeIiBYmfT5exQsRFJGZ3tkHttZK4
 dv8D2HMSAm/ZJe52gzRwADkuErebQiF6hSVeHd8CDQwpic/v9rJB1DczSixdcpAVwulhlPjX
 cJ0NospYYv/SyUwgg5gFNCXW79KHWMwn8e5rDyvEfF6JjjYhiGoViUuvXzLBzL/75D8rhO0h
 seLBCqYJjIqzkLw2C8lrs5C8Mwth2QJGllWMYqkFxbnpqcmGBYbw6E7Oz93ECE6GWsY7GC/P
 /6d3iJGJg/EQowQHs5II7zU5yTQh3pTEyqrUovz4otKc1OJDjKbAwJ7ILCWanA9Mx3kl8YYm
 lgYmZkbGJhaGZoZK4rxnrpSlCgmkJ5akZqemFqQWwfQxcXBKNTBNWTlPXzZXWjVJSFmBb+PO
 uaZTKi7fvTA9yfJIQkHKU/cOp+oihTKVSctUuV2f5QhH8QuEHf54x9xv09Rrgbr9H+5/Td+m
 UGN2ff61REfF5V6/9DI7hf/dY/FPFzpxLuZSyMKke4FdHJuPKrUKdu7bsUrFZUJOz8W/M6Ln
 zC/sFC2UYl5cZ33dtap/bf0lzWNNrblGC34uMHy+7tC7a5JPtsqXvG5fuIEtW1asQV1Q6Npt
 Zl0z/8iE9fzRtw9eCVt4d9nptkkixmK3TQPStIvW9LzdYP1F2OfM2qCg1LnKr603h/ckZi36
 5hPyq/kmk4+d6o/KIyuPWSuL+O7bsHXtYdVjB7vlUhvVm18H+CqxFGckGmoxFxUnAgBQDhKt
 DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO75ezJpBvdO61hMnbSZ3eLt3k52
 i8eHXjM5MHvsOT2L2ePVgVXsHmfv7GAMYI7isklJzcksSy3St0vgyli/8RR7wR3OiuWd2xkb
 GL+zdzFyckgImEicONDO0sXIxSEksJtRYsWmNUwQCSmJz0+nsnUxcgDZwhKHDxdD1DxnlNhw
 aSYbSA2bgJ7E/0ULmUFsEaD6l50bwWxmAWOJN5fuMEE09DJKnD/wkhUkwSlgI/FwwTmwBcIC
 zhJzjp0Du4JFQFVi5qR5jCA2r4ClxJn27cwQtqDEyZlPWCCGakv0PmxlhLDlJba/ncMMcaiC
 xM+ny1gh4iISszvboA6ykrh2/wPzBEbhWUhGzUIyahaSUbOQtC9gZFnFKJlaUJybnltsWGCU
 l1quV5yYW1yal66XnJ+7iREcFVpaOxj3rPqgd4iRiYPxEKMEB7OSCO81Ock0Id6UxMqq1KL8
 +KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGphk7c6c+yWw+yHD7Suuz+47
 23k0qUt9sWN0SGHhX1JsVi1QmJsU+DxDaXGPzw6O7yuur/z9L+RqlIP3z/lcj+7/SjR90Fo5
 9WJkr/17AXHp+VvSg17zmXyIFdmR0b7OTciZ//rSF1tFpyo95nCZplrA4Prv76ryR2dXL7q9
 YzNH9qLya1/Cr+/a+PXHg2Ktz6cCUw+utNphv+9ZotWirqex7KfdpXep79f6JaZhtXFKWo86
 x++dX5UCeg9f3Ji0uFRM3lZx+TYPz5OiP+Qe6Z7/ry9T/PGyV5pEotFjo7V9i6+pSvzMTvE8
 v/gU58SJu64J8U5cUPfB9MYck2/MCUl3oyrlfjDfP3NOJxDo0pVKLMUZiYZazEXFiQCSzwLS
 +QIAAA==
X-CMS-MailID: 20240415080119epcas1p1640e1e4e2e30fdb48a5ef066a31d42de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197
References: <CGME20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197@epcas1p2.samsung.com>
 <20240415075650.22442-1-jh80.chung@samsung.com>
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
> From: Jaehoon Chung <jh80.chung@samsung.com>
> Sent: Monday, April 15, 2024 4:57 PM
> To: u-boot@lists.denx.de
> Cc: trini@konsulko.com; ycliang@andestech.com; Jaehoon Chung <jh80.chung@samsung.com>
> Subject: [PATCH] mmc: cv1800b_sdhci: Remove the unused argument
> 
> Remove the unused argument about cmd_error.
> 
> Fixes: a3b2786651c7 ("mmc: Drop unused mmc_send_tuning() cmd_error parameter")
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

This patch is based on u-boot-mmc/master.

Best Regards,
Jaehoon Chung

> 
> ---
>  drivers/mmc/cv1800b_sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> index 2275c5377723..9af6b9719844 100644
> --- a/drivers/mmc/cv1800b_sdhci.c
> +++ b/drivers/mmc/cv1800b_sdhci.c
> @@ -42,7 +42,7 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
>  	for (tap = 0; tap < TUNE_MAX_PHCODE; tap++) {
>  		cv1800b_set_tap_delay(host, tap);
> 
> -		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +		if (mmc_send_tuning(host->mmc, opcode)) {
>  			current_size = 0;
>  		} else {
>  			current_size++;
> --
> 2.25.1


