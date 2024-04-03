Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8789C6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39ABE88199;
	Wed,  3 Apr 2024 02:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="V2vj5Gfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8B0881A7; Wed,  3 Apr 2024 02:42:03 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F0288141
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240403004157epoutp0495045bb3dd37a558ef1a808c403e7e80~CnloFVS9Q0598305983epoutp04d
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:41:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240403004157epoutp0495045bb3dd37a558ef1a808c403e7e80~CnloFVS9Q0598305983epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712104917;
 bh=iJBH36mEjNgT3Dp4dmSiyqPclaeOzWhFpGjWkpcH8mQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=V2vj5Gfwt0RSBBn6DxMfmdFriIT7qYJKODsJ9qwz0j+V4s8bRluLugTyKcBruGGlr
 Z3mzfQVDsCXtb9S4Hbe3wEs95Ha4I4IHbEpskTSuc0P0OhMlkV33qs+3ShKuVNQhia
 1kwGMYg/yFs6HLmbCHrTI3bbTaQTo6mg1NkXt4VE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240403004157epcas1p2d4d5781566a97e15a44d558d8db96170~Cnln7_vMX3264132641epcas1p2-;
 Wed,  3 Apr 2024 00:41:57 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8QtX5Brhz4x9Pr; Wed,  3 Apr
 2024 00:41:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 64.38.08627.4D5AC066; Wed,  3 Apr 2024 09:41:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a~CnlmT_emK2746227462epcas1p1Q;
 Wed,  3 Apr 2024 00:41:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403004155epsmtrp20832fca57e0802ce0ceb4dd3ebec9518~CnlmTclOT2832928329epsmtrp2M;
 Wed,  3 Apr 2024 00:41:55 +0000 (GMT)
X-AuditID: b6c32a33-af9ff700000021b3-11-660ca5d4ba59
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 16.D0.08924.3D5AC066; Wed,  3 Apr 2024 09:41:55 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240403004155epsmtip24cc749aebd56e62a789259e01e8236c3~CnlmAfZ8o0085100851epsmtip2I;
 Wed,  3 Apr 2024 00:41:55 +0000 (GMT)
Message-ID: <908bd8cb-b7a3-4701-b636-6d96cd2d2472@samsung.com>
Date: Wed, 3 Apr 2024 09:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: dw_mmc: Don't return error if data busy
 timeout
To: forbidden405@outlook.com, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240201-mmc-v2-2-9f09dc1335fd@outlook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru6VpTxpBrteSVv8u7mH3eLHqi+s
 Fm/3drI7MHucvbOD0WPjux1MHptfv2AOYI7KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
 1DW0tDBXUshLzE21VXLxCdB1y8wB2qSkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
 KTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Yv3gVe8FmzoruOYsYGxhPsncxcnJICJhIdNw6
 w9bFyMUhJLCDUaLx7S5WCOcTo8T9CbNZIJxvjBIPFjxg7GLkAGuZCdINEt/LKLHi5lGwUUIC
 7xklbr+yAanhFbCTWP+RESTMIqAiMfl5GyuIzSsgKHFy5hMWEFtUQF7i/q0ZYK3CAkESje8/
 M4PYIgKWErOWn2YCsZkFJCSWHLrPCmGLS9x6Mh8sziagI7H923EwmxOo/sa3NcwQNfIS29/O
 YQa5TULgEbvE21k7WSDedJFYtWEF1MvCEq+Ob4GypSQ+v9vLBtHQzCixdMlBVginh1HiX8N1
 NogqY4n9SyczgXzGLKApsX6XPsQ2Pol3X3tYIYHCK9HRJgRRrSJx6fVLJpj5d5/8Z4WwPSQ6
 vx2EhtVuRoldHxQmMCrMQgqXWUj+nIXkn1kIixcwsqxiFEstKM5NT002LDCER3Zyfu4mRnAi
 1DLewXh5/j+9Q4xMHIyHGCU4mJVEeH96c6YJ8aYkVlalFuXHF5XmpBYfYjQFxs5EZinR5Hxg
 Ks4riTc0sTQwMTMyNrEwNDNUEuc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoHJYuUMoVOrU5L2
 3D8UMIcj9dnGo6/aeh/JJPNWLNsbs2/ySd4lM5Nsyg+38jamTE7IeSAkWrjrxb6WH14P7hm3
 bW8xyZT7uKir0vNl1NkrdRxRb5RO7ji0L3Ln6/zZux/9lszeOTPYxvAXz2uW1BNuzl5Fu7ss
 PvhM/NHey66vxZP8rbTAuVXt6j7Fq43iQuefvWznrZD/5OwSYCIbtDfE8479wX3TVsxeFRi0
 8MmTvXZfdA/vW9+5PrzxR6XG9Rkdi1eu3SqbopP6vUR9oUj7Jq07fJf3dR1q/sK+fPW/38ff
 7XAK2z95uT2fmuTnPz8X3nzceq/SVbtpDhPf6+qc41tFpFIveGh4mLI/yjTeo8RSnJFoqMVc
 VJwIAJ+b7poNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvO7lpTxpBgvmGVj8u7mH3eLHqi+s
 Fm/3drI7MHucvbOD0WPjux1MHptfv2AOYI7isklJzcksSy3St0vgyli/eBV7wWbOiu45ixgb
 GE+ydzFycEgImEjMBDG5OIQEdjNKfF94kqWLkRMoLiXx+elUNogaYYnDh4shat4ySuzbvIsR
 JM4rYCex/iMjSDmLgIrE5OdtrCA2r4CgxMmZT8DGiArIS9y/NYMdxBYWCJJofP+ZGcQWEbCU
 mLX8NBOIzSwgIbHk0H2wXiGBdIkjS1YyQsTFJW49mQ9WwyagI7H923EwmxOo98a3NcwgJzAL
 qEusnycEUS4vsf3tHOYJjEKzkFwxC8mkWQgds5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhb
 XJqXrpecn7uJERzyWpo7GLev+qB3iJGJg/EQowQHs5II709vzjQh3pTEyqrUovz4otKc1OJD
 jNIcLErivOIvelOA3kksSc1OTS1ILYLJMnFwSjUwefcb1lg4Ba4PWr3yoTrTr6K1KeIfqm+8
 PKZx7GqPWnBiipbat2Vf/gY8XbzX00S/5ju743nxD/uYnyy7PmHHeZbYN3Zusy7lRzRetdq5
 2Ex4Svjy0lQlz+WzV8xQWuDPX7i/Z6kxIzOD/iKJqMxAuZkHZPkWlt97rOG9+9yNyKunwpc3
 HQqd6yKav/hSxAuzhkoTk8VSITssnpzdkiE97+yD1tMvUs2ZxPzNEhfFVnw+Lh3PtEbp5JuF
 zI+W/ODz2uS4/D3bgo0bT/0Pa/z87viCW07TXI7NOhF/4cbjuvWZnxjubWyW2zSjx7u1bP+e
 RVyXrb7ebQx7z5o1tZ7xXL/FBXf3OZPfnmRsPJX4UEiJpTgj0VCLuag4EQBjl9PJ6AIAAA==
X-CMS-MailID: 20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-2-9f09dc1335fd@outlook.com>
 <CGME20240403004155epcas1p1fdb3680cde2a4dee4325e22b9b076e6a@epcas1p1.samsung.com>
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

On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> As described in [1], some poor hardware or cards would fail to release
> the bus and keep driving data lines low. Ignore it and send the next cmd
> directly seems okay for most cases.
This patch seems to be same with previous patch, right?

Best Regards,
Jaehoon Chung

> 
> [1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-dianders@chromium.org/
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 400066fa99..e103664145 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
>  
>  	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
>  		if (get_timer(start) > timeout) {
> -			debug("%s: Timeout on data busy\n", __func__);
> -			return -ETIMEDOUT;
> +			debug("%s: Timeout on data busy, continue anyway\n", __func__);
> +			break;
>  		}
>  	}
>  

