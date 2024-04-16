Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91431C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB2A88422;
	Wed, 17 Apr 2024 01:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="YGnpM+pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BD88840D; Wed, 17 Apr 2024 01:37:56 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438368843C
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240416233751epoutp019658998b6a695dbe2b3c0f8e95225058~G5vp6qurM2028220282epoutp01L
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 23:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240416233751epoutp019658998b6a695dbe2b3c0f8e95225058~G5vp6qurM2028220282epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713310671;
 bh=AwwFKlNxuy7VYMGKHFn0DKd6YqVuvGSnYxITPfmJyDQ=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=YGnpM+pNu6+IymN4/AFYek7VO8HOzKYQ0yi/8ZRO/S6O+S8SoRXDCLZrdlFNyxkm0
 aZRcTL5UvcQrHChyH6jaBdfCSGApYjiqZ4N8GuIRpuzRfS6+8vheq0372TQtKNYxUF
 78i9VY5Rwq3nFpVcQI9S+nzwVilOO38XiB1jbBVU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240416233751epcas1p2d064ffb3525e5b32ff6f986d505289ae~G5vpspxb_2364823648epcas1p2x;
 Tue, 16 Apr 2024 23:37:51 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.236]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VK0p62cq9z4x9Px; Tue, 16 Apr
 2024 23:37:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.A8.19431.ECB0F166; Wed, 17 Apr 2024 08:37:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240416233749epcas1p2f9d7995ac9cd275ad831ba1402772dd0~G5voMH_pK2873528735epcas1p2Q;
 Tue, 16 Apr 2024 23:37:49 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240416233749epsmtrp1094d131912256e4176e17fdd05b5c9f7~G5voLeOBc2023420234epsmtrp1l;
 Tue, 16 Apr 2024 23:37:49 +0000 (GMT)
X-AuditID: b6c32a4c-485ff70000004be7-a7-661f0bce14be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B6.C8.07541.DCB0F166; Wed, 17 Apr 2024 08:37:49 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240416233749epsmtip1b09187b62d90c88dab84f3b11042808b~G5vn8t2gt0138201382epsmtip1j;
 Tue, 16 Apr 2024 23:37:49 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Kongyang Liu'" <seashell11234455@gmail.com>, <u-boot@lists.denx.de>
Cc: "'Leo Yu-Chi Liang'" <ycliang@andestech.com>, "'Peng Fan'"
 <peng.fan@nxp.com>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20240416073131.8527-1-seashell11234455@gmail.com>
Subject: RE: [PATCH] mmc: cv1800b: Add transmit tap delay config to fix
 write error
Date: Wed, 17 Apr 2024 08:37:49 +0900
Message-ID: <000b01da9057$17ca4f60$475eee20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJctH8J5r3lGfoF8xnQ9yoVG6ixbQKHQD9TsFMLETA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmvu45bvk0g5Mr+Sx+rPrCanFs3Ud2
 i6mTNrNbvN3byW7x+NBrJgdWjz2nZzF77Jx1l93j1YFV7B5n7+xg9Nj4bgdTAGtUtk1GamJK
 apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0HYlhbLEnFKgUEBi
 cbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGjmkX2Qv+
 81T0des2MJ7h6mLk5JAQMJGYcK2JGcQWEtjDKHF2HX8XIxeQ/YlRYvLznYwQzjdGiXPnjrF2
 MXKAdVyfHg8R38so0XP6MxuE85JRon/5UhaQUWwCehL/Fy0EGysi4CnR8PcHO4jNLFAm0dZ3
 G8zmFLCXmLRnASOILSwQKvHk1BqwOIuAqsSho3vBbF4BS4ltfdNYIWxBiZMzn7BAzJGX2P52
 DjPECwoSP58uY4XYZSXRfOwC1C4Ridmdbcwgx0kIdHJIHHq/mR2iwUVi6/31jBC2sMSr41ug
 4lISL/vb2CEamhklli45yArh9DBK/Gu4zgZRZSyxf+lkJlBYMAtoSqzfpQ+xjU/i3dceaBDx
 SnS0CUFUq0hcev2SCWb+3Sf/WSFsD4ljx2YwT2BUnIXkt1lIfpuF5IdZCMsWMLKsYpRKLSjO
 TU9NNiww1M1LLYdHeHJ+7iZGcOLU8tnB+H39X71DjEwcjIcYJTiYlUR4W4Rl04R4UxIrq1KL
 8uOLSnNSiw8xmgJDfCKzlGhyPjB155XEG5pYGpiYGRmbWBiaGSqJ8565UpYqJJCeWJKanZpa
 kFoE08fEwSnVwJR/6lrplADLjydbdm14V8X+IEl+936m+qyF4mUKTyRWyGXm3mVWPfFGunu9
 SOW8vVd+HFX4OGepkmqvxKNTPYrb7W9JbZQvFGrImzstUsP255q8BXJLpxk776quuqw403aj
 3a/3d+/2+D9svB+05LRHWKRsk/QDhbCQCBU9jjc/P958ytZ+rtk468Ek6egb6hcCXb5vuhfT
 /NCKO/Uk52vtZWz7YnY6PP42tcxN/djLrZ16X460PPvPznWn77XtXd0qNtnDLnZ/Pq/OMNkk
 /zsxNfxmU1Nh7Ar+cC2jq5qHPj2Mc83r745paLz04kaWD++pk16O/vvlHYW2T811rd+7uXfi
 zJxXv7/NMuM6dFSJpTgj0VCLuag4EQD4sl2OJQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO5Zbvk0g+47OhY/Vn1htTi27iO7
 xdRJm9kt3u7tZLd4fOg1kwOrx57Ts5g9ds66y+7x6sAqdo+zd3Ywemx8t4MpgDWKyyYlNSez
 LLVI3y6BK2PHtIvsBf95Kvq6dRsYz3B1MXJwSAiYSFyfHt/FyMUhJLCbUWLz4t/sXYycQHEp
 ic9Pp7JB1AhLHD5cDFHznFHiyfZLzCA1bAJ6Ev8XLQSzRQS8JS4ubmQDsZkFKiQWHjkAZgsJ
 TGCUWLfEHMTmFLCXmLRnASPITGGBYInlp4VAwiwCqhKHju4FW8srYCmxrW8aK4QtKHFy5hMW
 iJHaEk9vPoWy5SW2v53DDHGmgsTPp8tYIU6wkmg+doEdokZEYnZnG/MERuFZSEbNQjJqFpJR
 s5C0LGBkWcUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERw1Who7GO/N/6d3iJGJg/EQ
 owQHs5IIb4uwbJoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwc
 nFINTC864w1L1rXeky1VXfB74txHORM8mGMNhRnWcSdNWcHz52Jg4FGGa5cZ1tjyX9+26pid
 bulWjXcJr+vqZsj8V3n6at79jyqzbjTLPk1s82OQ/fLA7/yM8KKgNe4/m26fuqE512nt1Xfy
 4d7CH+VMn31+wvb09IN9up8MjnI339x5+qnGBNOkipC7Qi8+izy4/Kwr5N0m7lLWzKCoM1Yu
 DF/viPy4GjylSVmgYPaviKBbcgUPY7ftY6/8bfHbxrBoQaZuTlu1fVjBo9vrBKovv/z06fAv
 H4vr8pqrk2/Lxnozx5qaahzOYXh0W1Tt/M2Pt8IzBFW7OoxfaVcnCi+bc/1Yz5Lg6tWTN22O
 Y5wvx6jEUpyRaKjFXFScCAAaxySkCQMAAA==
X-CMS-MailID: 20240416233749epcas1p2f9d7995ac9cd275ad831ba1402772dd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240416073148epcas1p23ad0d7f46660f71578f353a35179790b
References: <CGME20240416073148epcas1p23ad0d7f46660f71578f353a35179790b@epcas1p2.samsung.com>
 <20240416073131.8527-1-seashell11234455@gmail.com>
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
> From: Kongyang Liu <seashell11234455@gmail.com>
> Sent: Tuesday, April 16, 2024 4:31 PM
> To: u-boot@lists.denx.de
> Cc: Jaehoon Chung <jh80.chung@samsung.com>; Leo Yu-Chi Liang <ycliang@andestech.com>; Peng Fan
> <peng.fan@nxp.com>; Tom Rini <trini@konsulko.com>
> Subject: [PATCH] mmc: cv1800b: Add transmit tap delay config to fix write error
> 
> Currently, only the receive delay is configured while the transmit delay
> is not set, which may result in errors when writing to the file. This issue
> can be resolved by setting PHY_TX_SRC_INVERT to SDHCI_PHY_TX_RX_DLY.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/cv1800b_sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
> index 2275c53777..a50f4cff0d 100644
> --- a/drivers/mmc/cv1800b_sdhci.c
> +++ b/drivers/mmc/cv1800b_sdhci.c
> @@ -12,6 +12,8 @@
>  #define MMC_MAX_CLOCK        375000000
>  #define TUNE_MAX_PHCODE      128
> 
> +#define PHY_TX_SRC_INVERT  BIT(8)
> +
>  struct cv1800b_sdhci_plat {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
> @@ -19,7 +21,7 @@ struct cv1800b_sdhci_plat {
> 
>  static void cv1800b_set_tap_delay(struct sdhci_host *host, u16 tap)
>  {
> -	sdhci_writel(host, tap << 16, SDHCI_PHY_TX_RX_DLY);
> +	sdhci_writel(host, PHY_TX_SRC_INVERT | tap << 16, SDHCI_PHY_TX_RX_DLY);
>  }
> 
>  static void cv1800b_sdhci_reset(struct sdhci_host *host, u8 mask)
> --
> 2.41.0


