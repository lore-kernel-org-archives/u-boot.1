Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0FBC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A0E8844A;
	Wed, 17 Apr 2024 02:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XumAUnuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0F18844A; Wed, 17 Apr 2024 02:26:13 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDA088449
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240417002554epoutp029a076a2e5208a230eac93a54dc485c29~G6ZmkY7Kt1102511025epoutp02K
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 00:25:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240417002554epoutp029a076a2e5208a230eac93a54dc485c29~G6ZmkY7Kt1102511025epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713313554;
 bh=G55B0zfmRXWciJvZNHCjrqkYOK5PiqwNpac8Dous+Ms=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=XumAUnuAcps8XDgEyu/JPSoM6NwIWIX+PokPdOtc0mQrlkUJ8LIgp7QE49rPwWeWx
 n9RaaoF/m8YRIBfYfqucoA6flqYrpj/X6ofYq5s7zsxx08MbbSH7ZjIHkVpAsgGTz0
 5u7eAp2MeS9fgnKBfqBvlmMJGYwto2sFor4IZkv4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240417002554epcas1p3350dc51fd3bbf6fa03db869c44b5142a~G6Zmaz-Bj0801308013epcas1p3c;
 Wed, 17 Apr 2024 00:25:54 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.233]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VK1sY28tqz4x9Py; Wed, 17 Apr
 2024 00:25:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 54.83.19431.1171F166; Wed, 17 Apr 2024 09:25:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240417002552epcas1p2df4cadc8e7b8a5afbec526c9b30b18c3~G6ZlHRvxu0435804358epcas1p2b;
 Wed, 17 Apr 2024 00:25:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417002552epsmtrp20e12b493a93407943366de5197699001~G6ZlGL25F1767517675epsmtrp2Z;
 Wed, 17 Apr 2024 00:25:52 +0000 (GMT)
X-AuditID: b6c32a4c-485ff70000004be7-1b-661f1711e3f6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.E0.08390.0171F166; Wed, 17 Apr 2024 09:25:52 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417002552epsmtip1046e620085561c442e1147d988064975~G6Zk3ZvVX0323403234epsmtip1I;
 Wed, 17 Apr 2024 00:25:52 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Greg Malysa'" <greg.malysa@timesys.com>, <u-boot@lists.denx.de>,
 "'Peng Fan'" <peng.fan@nxp.com>
Cc: "'Ian Roberts'" <ian.roberts@timesys.com>, "'Nathan Barrett-Morrison'"
 <nathan.morrison@timesys.com>, "'Sean	Anderson'" <sean.anderson@seco.com>,
 "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20240326022325.1785-1-greg.malysa@timesys.com>
Subject: RE: [PATCH] mmc: sdhci: Fix potential ADMA descriptor table overflow
Date: Wed, 17 Apr 2024 09:25:52 +0900
Message-ID: <002e01da905d$ce2524f0$6a6f6ed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK1uEmWrv183pCs0WVm4HOoplvhjAGIlfWSr6kGUNA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnq6guHyawdQ9vBanP91gsXh5/x6T
 xeWFlxktfqz6wmox734Lk8XUSZvZLd7u7WR3YPd4dWAVu8fZOzsYPTa+28Hk8ezfN3aPvdt/
 MAWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
 oaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIF
 KkzIzniy7j1TwQnRihkL8hsY/wt2MXJySAiYSNw4N4+li5GLQ0hgD6PE4W2XmCGcT4wSx5om
 s0I43xglnu7fzNTFyAHWsrmrDiK+l1Fi792HUB0vGSUePz7BBDKXTUBP4v+ihcwgDSICGRIb
 3rCB1DAL7GaUuP2pkxmkhlPARmLPw29g9cIC/hLvb+0Hs1kEVCWu7nnLDmLzClhK3L99H8oW
 lDg58wkLiM0sIC+x/e0cZogfFCR+Pl3GCmKLCFhJ9L2/zwRRIyIxu7MNqmYmh0TDlWQI20Xi
 x5F+FghbWOLV8S3sELaUxOd3e8EOlRBoZpRYuuQgK4TTwyjxr+E6G0SVscT+pZPBQcEsoCmx
 fpc+xDI+iXdfe1ghIcQr0dEmBFGtInHp9UsmmPl3n/xnhbA9JNYe3M0ygVFxFpLXZiF5bRaS
 F2YhLFvAyLKKUSq1oDg3PTXZsMBQNy+1HB7hyfm5mxjByVTLZwfj9/V/9Q4xMnEwHmKU4GBW
 EuFtEZZNE+JNSaysSi3Kjy8qzUktPsRoCgzwicxSosn5wHSeVxJvaGJpYGJmZGxiYWhmqCTO
 e+ZKWaqQQHpiSWp2ampBahFMHxMHp1QDU75/1NSM+d93/GxadPQAw/dzm6a4zNH9+v5lt9Z9
 pu/+ajcszTn2Kocdk5P6PjX4lFeLxns9DoZZL47b878OCl/l0M7x/PSizaL1N2Jq3vomX+MX
 +7RSjO36/RXvd3pPE5zAWNV+dzqz+De9gz8XdcuFm0y9+Y3rziMLBmbntVklYpktGbOCPyrO
 ChEMOppxLGNSUesZ+91P2HKbmOW03q16cvDKdOdzEvYKNa5T12ad8my/9p/d88D6BrOnjkqn
 Zm5w258ot2PDr1R7Zf11ShaJGgL9N9Ikzv/cs25NTa/Pmbx7tua6+etND722Y2mWX+VmWtXH
 s5Z5hki3m0nHaalDeQE/ah7Ncvtb+vsXpxJLcUaioRZzUXEiAIkmsisvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJTldAXD7N4FyLhsXpTzdYLF7ev8dk
 cXnhZUaLH6u+sFrMu9/CZDF10mZ2i7d7O9kd2D1eHVjF7nH2zg5Gj43vdjB5PPv3jd1j7/Yf
 TAGsUVw2Kak5mWWpRfp2CVwZT9a9Zyo4IVoxY0F+A+N/wS5GDg4JAROJzV11XYxcHEICuxkl
 Xq5fyt7FyAkUl5L4/HQqG0SNsMThw8UQNc8ZJd6e+8kGUsMmoCfxf9FCZhBbRCBLovvrH2aQ
 ImaBvYwSVy60MkN09DJKbDlzAKyKU8BGYs/Db0wgtrCAr8TkbRPBJrEIqEpc3fMWbDOvgKXE
 /dv3oWxBiZMzn7CA2MwC2hJPbz6FsuUltr+dwwxxqYLEz6fLWCGusJLoe3+fCaJGRGJ2Zxvz
 BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcT1pa
 Oxj3rPqgd4iRiYPxEKMEB7OSCG+LsGyaEG9KYmVValF+fFFpTmrxIUZpDhYlcd5vr3tThATS
 E0tSs1NTC1KLYLJMHJxSDUwpIvdPMbiG8Zu+rLRnkvG+0y5y9XvVpJ/2NyXPu/roLWfNSI9Y
 9fnPud+xwmJXIlu7Wa+/YfK4Wnt8utHN9ToVNjHlYUDntWt8NEidNL9mezfbF33bG+4zdt14
 /W9B8JFfUklLpFNTHc9O+uKyrvid+0fBv6uMdWZfVYhou2vxf87vBYVe6bU73xlqN34+bB89
 5x7P/yt1C2LPLngzr6/6csqNS5u4MzW+9M2/fdr6+qZvU04KTzs1/eHuuPeqOp3PFVaxdag/
 6xWe1PNv9/6YxXNnlTi/DJ2dJ8THZnfoQv1CIdNfrxJSnzft2X9R6VBNb63xinf170xPML7u
 4jnwKlQj6Po+kZMGovezL6opsRRnJBpqMRcVJwIAE7Qz9xYDAAA=
X-CMS-MailID: 20240417002552epcas1p2df4cadc8e7b8a5afbec526c9b30b18c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240326022534epcas1p45ccb2dc37d0b6955f2abad4e39bdf825
References: <CGME20240326022534epcas1p45ccb2dc37d0b6955f2abad4e39bdf825@epcas1p4.samsung.com>
 <20240326022325.1785-1-greg.malysa@timesys.com>
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
> From: Greg Malysa <greg.malysa@timesys.com>
> Sent: Tuesday, March 26, 2024 11:23 AM
> To: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>; Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg
> Malysa <greg.malysa@timesys.com>; Sean Anderson <sean.anderson@seco.com>; Tom Rini
> <trini@konsulko.com>
> Subject: [PATCH] mmc: sdhci: Fix potential ADMA descriptor table overflow
> 
> From: Ian Roberts <ian.roberts@timesys.com>
> 
> Change ADMA_TABLE_NO_ENTRIES to round the division up to fully
> contain CONFIG_SYS_MMC_MAX_BLK_COUNT, fixing potential buffer overflow
> of the ADMA descriptor table.
> 
> sdhci_prepare_adma_table() expecitily states it does _not_ check for
> overflow as the descriptor table size is dependent on
> CONFIG_SYS_MMC_MAX_BLK_COUNT. However, the ADMA_TABLE_NO_ENTRIES
> calculation does not round up the divison, so with the current u-boot
>  defaults:
> max_mmc_transfer = (CONFIG_SYS_MMC_MAX_BLK_COUNT * MMC_MAX_BLOCK_LEN) =
> 65535 * 512 = 33553920 bytes.
> ADMA_TABLE_NO_ENTRIES = max_mmc_transfer / ADMA_MAX_LEN =
> 33553920 / 65532, which does not divide cleanly.
> actual_max_transfer = ADMA_TABLE_NO_ENTRIES * ADMA_MAX_LEN = 512 *
> 65532 = 33552384, which is smaller than max_mmc_transfer.
> This can cause sdhci_prepare_adma_table() to write one extra
> descriptor, overflowing the table when a transaction larger than
> actual_max_transfer is issued.
> 
> Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com> 

Best Regards,
Jaehoon Chung

> 
> ---
> 
> 
> ---
>  include/sdhci.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sdhci.h b/include/sdhci.h
> index a1b74e3bd7..fbc0f0391c 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -11,6 +11,7 @@
> 
>  #include <linux/bitops.h>
>  #include <linux/types.h>
> +#include <linux/kernel.h>
>  #include <asm/io.h>
>  #include <mmc.h>
>  #include <asm/gpio.h>
> @@ -299,8 +300,8 @@ struct sdhci_ops {
>  #else
>  #define ADMA_DESC_LEN	8
>  #endif
> -#define ADMA_TABLE_NO_ENTRIES (CONFIG_SYS_MMC_MAX_BLK_COUNT * \
> -			       MMC_MAX_BLOCK_LEN) / ADMA_MAX_LEN
> +#define ADMA_TABLE_NO_ENTRIES DIV_ROUND_UP(CONFIG_SYS_MMC_MAX_BLK_COUNT * \
> +			      MMC_MAX_BLOCK_LEN, ADMA_MAX_LEN)
> 
>  #define ADMA_TABLE_SZ (ADMA_TABLE_NO_ENTRIES * ADMA_DESC_LEN)
> 
> --
> 2.43.2


