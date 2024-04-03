Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9FC6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BBD8818F;
	Wed,  3 Apr 2024 02:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="IMCm6zgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A1F88199; Wed,  3 Apr 2024 02:00:48 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9530F879DC
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240403000041epoutp01d5fa5f4c653c3cb27425b4e6361a52c9~CnBl3SmSe0947209472epoutp01Y
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240403000041epoutp01d5fa5f4c653c3cb27425b4e6361a52c9~CnBl3SmSe0947209472epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712102441;
 bh=TsIlZxueGEA+iyGp8AqRac/SpsrMM7tZNtg6ZoMQxTI=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=IMCm6zgk3eWKSOIaqyLJEkasiJXHjB37l0mZSMl+jbNrSN6KW9S9zeECVYm/1NRMr
 aoHgxThAgY1pjLzcUZ4opbprlAvH/jM9XX2PRpxdHk2iZbjihv1Ny1EIP63k0lH258
 +I5D6w7i47K+zPCwaPBMv2ncWiwXPKMojZ1zjzGk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240403000041epcas1p1fffea7091c31995cf01075f30b87dae3~CnBlky6Jv0257102571epcas1p1S;
 Wed,  3 Apr 2024 00:00:41 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.233]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4V8Pyw0x2fz4x9Q7; Wed,  3 Apr
 2024 00:00:40 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FC.FD.09696.72C9C066; Wed,  3 Apr 2024 09:00:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240403000039epcas1p46afc0540b893679113e0683d87227ca8~CnBkOhDWM0332403324epcas1p4x;
 Wed,  3 Apr 2024 00:00:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240403000039epsmtrp18e0578a24c0becce325c1100acef8d43~CnBkN2cot0530505305epsmtrp1N;
 Wed,  3 Apr 2024 00:00:39 +0000 (GMT)
X-AuditID: b6c32a36-7a9f9700000025e0-b2-660c9c277654
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 96.9D.08924.72C9C066; Wed,  3 Apr 2024 09:00:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403000039epsmtip158338a85535286f0c4e0ce3e509dde5d~CnBkBPU1X1158711587epsmtip1d;
 Wed,  3 Apr 2024 00:00:39 +0000 (GMT)
Message-ID: <d7a2b5ef-ceb5-4f8f-b2d0-fcd6f2d6df1c@samsung.com>
Date: Wed, 3 Apr 2024 09:00:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240127162922.284598-1-jonas@kwiboo.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmga7GHJ40g3U/GS1OvrnKYvFtyzZG
 i6mTNrNbvN3byW5x8MlZFgdWj9kNF1k8Xh1Yxe5xYsIlJo+zd3YwevS0bWIKYI3KtslITUxJ
 LVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB2q6kUJaYUwoUCkgs
 LlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y+H8Oc8Ez
 wYqJy7uYGhi38XQxcnJICJhITNu9iBHEFhLYwShx8BoXhP2JUeLpLYsuRi4g+xujxMRf81hg
 Gn4fbWWESOxllFhyaSUThPOeUeLxgpfsIFW8AnYSy95vYQOxWQRUJJqObWKDiAtKnJz5BGyS
 qIC8xP1bM8DqhQUCJc52nwA7Q0QgRWLD/7tMIDazgLfEsquH2CFscYlbT+aDxdkEdCS2fzsO
 ZnMKmElM+fCKBaJGXmL72znMIAdJCDRySCw91coIcbaLRO+sVVC2sMSr41vYIWwpiZf9bewQ
 Dc2MEkuXHGSFcHoYJf41XGeDqDKW2L90MtA6DqAVmhLrd+lDbOOTePe1hxUkLCHAK9HRJgRR
 rSJx6fVLJpj5d5/8Z4WwPSQu7fzOCgmtTkaJl38WM01gVJiFFDCzkDw6C8lDsxA2L2BkWcUo
 llpQnJueWmxYYASP7uT83E2M4KSpZbaDcdLbD3qHGJk4GA8xSnAwK4nw/vTmTBPiTUmsrEot
 yo8vKs1JLT7EaAqMnonMUqLJ+cC0nVcSb2hiaWBiZmRsYmFoZqgkznvmSlmqkEB6Yklqdmpq
 QWoRTB8TB6dUA1OOhF3YgVy/5IdK/XFntsnnNHze+aA49cRVS5OFuUmBIX/ir8xy47655usi
 39jnBlr/K5fOD/qz7cLifdN7dnue8pQ6cmOno8pbxW/b1Tv3/+BzMIqvNamXlf7012GT22XX
 mFd6s3jU+vKipO4vaK46e7C31zKkw3GO8e0VRUcdV399s7ZA4MHqeyHe73o4XLbYHqn7eepZ
 8t5HWiLmutMk2m3aOPgrhO8uP3bTxbtnb3tUw3qj6euOaRYfzpwdvvnk/FlczW27XBoWf34x
 iVcubufzr+9EA7d9sj7vaGVtscBDcv6UWMFTSSKL1nHYFs8/9mE/v1urtqWR3MILLad1K2bu
 3Lj3onnAhUlnX/YosRRnJBpqMRcVJwIAH6sEKiMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnK76HJ40g0m7tS1OvrnKYvFtyzZG
 i6mTNrNbvN3byW5x8MlZFgdWj9kNF1k8Xh1Yxe5xYsIlJo+zd3YwevS0bWIKYI3isklJzcks
 Sy3St0vgylj4fw5zwTPBionLu5gaGLfxdDFyckgImEj8PtrK2MXIxSEksJtRovnjb1aIhJTE
 56dT2boYOYBsYYnDh4shat4ySsx/s5wJpIZXwE5i2fstbCA2i4CKRNOxTWwQcUGJkzOfsIDY
 ogLyEvdvzWAHsYUFAiXOdp9gBLFFBFIkdre8BrOZBbwlll09BFYjJGAqcWfFDDaIuLjErSfz
 wXaxCehIbP92HMzmFDCTmPLhFQvIbcwC6hLr5wlBlMtLbH87h3kCo9AsJFfMQjJpFkLHLCQd
 CxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeHluYOxu2rPugdYmTiYDzEKMHB
 rCTC+9ObM02INyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD
 08V4ya+XdesY+DUEihZ6Xoz4U5lxJcafO8b8Xx77dfUSptU3ZjEJ7Odf3ZTVsvui5rLSFu45
 y1o7uf45VX8RXtkYuE9AcUukP9tztufpTxZsttwrsZ/vUtSs/fZ+mf7z3RUrr9kduWPKnyRe
 k/DmUd0lg4zUu50ZNyqf57pZGDds1Xu+8u7sid4bhaYcXxT2wf/jBkXVKarrIyff3LZG7uHR
 yhWcKvlSh1dt2TetU+bpw48Tu+75sJz18kp//ivQazfj+zf+1zOatLWjy39snOy13a9+7pvg
 5V3CYknCkz4IXCt5pbP/jUDInVM/PzYlSp/ap8QSw51U7XreoDWmdV/eh+QNv9b5/J/Jf/Sz
 oxJLcUaioRZzUXEiAMqZJ/T+AgAA
X-CMS-MailID: 20240403000039epcas1p46afc0540b893679113e0683d87227ca8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403000039epcas1p46afc0540b893679113e0683d87227ca8
References: <20240127162922.284598-1-jonas@kwiboo.se>
 <CGME20240403000039epcas1p46afc0540b893679113e0683d87227ca8@epcas1p4.samsung.com>
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

On 1/28/24 01:29, Jonas Karlman wrote:
> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> issues together with the peephole2 optimization on Amlogic SoCs.
> Following was observed while working on SPL support for Amlogic SoCs.
> 
> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> CMD55 was instead followed by CMD8 (and a few reties) in SPL.

I read your RFC "https://patchwork.ozlabs.org/patch/1841495/".

First, I will retry to reproduce your case with other compiler. 
After that, I will inform again about this patch.

Best Regards,
Jaehoon Chung

> 
> Code from the call site:
> 
>   cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
>   ...
>   data.blocksize = 8;
>   ...
>   err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
> 
> Running the code with MMC_TRACE enabled shows:
> 
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:8
>                 ARG                      0x00000000
>                 RET                      -110
> 
> Removing the alignment hole by changing cmdidx from ushort to uint or
> building with -fno-peephole2 flag seem to resolve this issue.
> 
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:51
>                 ARG                      0x00000000
>                 MMC_RSP_R1,5,6,7         0x00000920
> 
> Same issue was observed building U-Boot with gcc 8 - 13.
> 
> Remove this alignment hole by changing cmdidx from ushort to uint.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Drop use of -fno-peephole2 flag
> 
> Link to RFC: https://patchwork.ozlabs.org/patch/1841495/
> ---
>  include/mmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7c..031ea0fb3545 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -413,7 +413,7 @@ struct mmc_cid {
>  };
>  
>  struct mmc_cmd {
> -	ushort cmdidx;
> +	uint cmdidx;
>  	uint resp_type;
>  	uint cmdarg;
>  	uint response[4];

