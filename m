Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B3E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 01:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8892380196;
	Fri, 13 Dec 2024 02:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="klp4Jfbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72A4801A0; Fri, 13 Dec 2024 02:44:47 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519C280192
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 02:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241213014440epoutp047cf6b59007a6a7a9e7b9c6cb68aabf9c~QmS4_eJFV2739527395epoutp044
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 01:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241213014440epoutp047cf6b59007a6a7a9e7b9c6cb68aabf9c~QmS4_eJFV2739527395epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734054280;
 bh=6MnEaEWCLXWPydILtAlgBfTbV5MQkQFFZBeYRkKUZ7w=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=klp4JfbqFOA5TQyhZn3E4SqouT9F9wFyeONyMDwp+ISw0IMylVVWYnYj9QaFspKZn
 B0Fnickg9D9h9l29UIOkU09LPsRc3AFmWFj0MpGQ6oN9EOpX2IKJFsLrxDU59PRPld
 vHB+tPudaPmQq9wxea9dbbuvpq8A+GMSZ9Z89AGA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241213014440epcas1p4d6f0ce012a580b92bfcbd113a34b53ac~QmS4rWq7u1681116811epcas1p4p;
 Fri, 13 Dec 2024 01:44:40 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y8XFg1NY3z4x9Px; Fri, 13 Dec
 2024 01:44:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 61.BF.31735.7819B576; Fri, 13 Dec 2024 10:44:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241213014438epcas1p212becd190804a79526e9dc6a307bc0f0~QmS3RXIac0517805178epcas1p2x;
 Fri, 13 Dec 2024 01:44:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241213014438epsmtrp27dd18af4180395bc3e44d957c117249c~QmS3QisVs2913629136epsmtrp2v;
 Fri, 13 Dec 2024 01:44:38 +0000 (GMT)
X-AuditID: b6c32a4c-ad1fe70000007bf7-2e-675b91870b93
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2A.6F.18729.6819B576; Fri, 13 Dec 2024 10:44:38 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241213014438epsmtip230e9f9eb1aee58b02e0d6e151cf5b13d~QmS3ILXCN0307603076epsmtip2L;
 Fri, 13 Dec 2024 01:44:38 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Ronald Wahl'" <rwahl@gmx.de>, <u-boot@lists.denx.de>
Cc: "'Ronald Wahl'" <ronald.wahl@legrand.com>, "'Peng Fan'" <peng.fan@nxp.com>
In-Reply-To: <20241211205200.16207-1-rwahl@gmx.de>
Subject: RE: [PATCH] mmc: Fix potential timer value truncation
Date: Fri, 13 Dec 2024 10:44:38 +0900
Message-ID: <000001db4d00$92207120$b6615360$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK2Zkc5VxGzAh7FmcPHAG/2q3QizwE6u6VRsSNcxEA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmnm77xOh0g2XrOCx+rPrCatHb+5jZ
 4th2RYu3ezvZHVg8PnyM83jQtYDZ4+ydHYweG9/tYApgicq2yUhNTEktUkjNS85PycxLt1Xy
 Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
 Ly6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIznj4vp+p4DlPxdmdDSwNjFO4uhg5
 OSQETCTOfZ3P1MXIxSEksIdRYtHUiewQzidGiW1rl7JAON8YJVY9PcwC03Ll1Fo2iMReoMSp
 r0wgCSGBl4wSbzYHgdhsAnoS/xctZAaxRQSsJObunMcGYjMLBEh0LNkBFOfg4BQwkti/WR4k
 LCxgJzHry0Kw+SwCqhJHflwAK+cVsJR4uvgiM8ReBYmfT5exwoz8+LaBCWKkiMTszjZmkHsk
 BI6xSyzb+IgdosFFYv/BBawQtrDEq+NboOJSEp/f7WWDaGhmlFi65CArhNPDKPGv4TobRJWx
 xP6lk5lALmUW0JRYv0sfYhufxLuvPawgYQkBXomONiGIahWJS69fMsHMv/vkP9ReD4n5Lcuh
 QdrKKHH1+nqWCYzys5AcPgthwwJGplWMUqkFxbnpqcmGBYa6eanl8OhMzs/dxAhOblo+Oxi/
 r/+rd4iRiYPxEKMEB7OSCO8N+8h0Id6UxMqq1KL8+KLSnNTiQ4ymwOCcyCwlmpwPTK95JfGG
 JpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwyXxKP2Vz9yVn3n4v9YkB
 gryfyuZumPo6Y2ef6FruyPLEFW0z5JPCopJmrelMfbui4dpnD+ngXd+EnzMV37+d2n+3gOXa
 83WR77LmHWS6oWIZECmRrl/UufvKuqUlbos3zZW+caLMyz37gVfea5HVln/PpYX3Ck2ebs58
 uP/qW/9HBaVprelHJZT1d5oH8IZt0BTdKvDuYajkh6+8JYZ399+8cDqTy/LCk7QNNkE3wqaW
 cFv/YYjdZs55/nk3T45pVvvSzBxbdfGZs4wyH240Wmycs8s7scrd00wr/7xSxO1sFmbJPfUX
 2iIDTT8u4l1e8r3srGnlgtefd734kLvpjo5ZvcOsUpGuwy91PTyUWIozEg21mIuKEwGfd3Kh
 9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvG7bxOh0g2cfFS1+rPrCatHb+5jZ
 4th2RYu3ezvZHVg8PnyM83jQtYDZ4+ydHYweG9/tYApgieKySUnNySxLLdK3S+DKePi+n6ng
 OU/F2Z0NLA2MU7i6GDk5JARMJK6cWsvWxcjFISSwm1Hi6dnZzBAJKYnPT6cCJTiAbGGJw4eL
 IWqeM0p87vvGBlLDJqAn8X/RQmaQGhEBG4nHh/hAwswCARLdtw6ClQgJNDNKHD+lBVLCKWAk
 sX+zPEhYWMBOYtaXhSwgNouAqsSRHxfAynkFLCWeLr4IdYGCxM+ny1hBbBEBK4mPbxuYIMaL
 SMzubGOewCgwC4m7gJFxFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcDhqae5g3L7q
 g94hRiYOxkOMEhzMSiK8N+wj04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1O
 TS1ILYLJMnFwSjUwtb5fcekHa2gZ/z7r+9LeAT+NLwcZ6ubo7l591C1w+eUFXkFzqmJXXGP/
 tPivoNys06npToHOW69vqOp9uX//z2I9u4XuCsvvp9mHdm1QXim8bv3Rews5axd8OdIZKlaY
 Fcxh3zr3zxGlpdvEgqUalHN7vItt1RUjtKSEj69PkVjTLqp3LvrnFydtlZbdKeFivxVex2xv
 0n1yUHz2H5mDKb37ttddN5xu+jbb71r210WPPFbcuK+pt15Od6nZ7PAdfza7daZ91+TbL1N3
 Pm7twotpPdKl112mhFz6xD57FZNMwn0DV4Nj2h8eTnDp5LvGacwaI3fYi6nu133ThEsn3XSq
 dW+90Nzo2JhwhrFciaU4I9FQi7moOBEA3kLgxbYCAAA=
X-CMS-MailID: 20241213014438epcas1p212becd190804a79526e9dc6a307bc0f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211205220epcas1p245fe464c26b8d3b51a8400a571d8d3a1
References: <CGME20241211205220epcas1p245fe464c26b8d3b51a8400a571d8d3a1@epcas1p2.samsung.com>
 <20241211205200.16207-1-rwahl@gmx.de>
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
> From: Ronald Wahl <rwahl@gmx.de>
> Sent: Thursday, December 12, 2024 5:52 AM
> From: Ronald Wahl <ronald.wahl@legrand.com>
>
> On 64bit systems the timer value might be truncated to a 32bit value
> causing malfunctions. For example on ARM the timer might start from 0
> again only after a cold reset. The 32bit overflow occurs after a bit
> more than 49 days (1000 Hz counter) so booting after that time may lead
> to a surprise because the board might become stuck requiring a cold
> reset.
>
> Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index efe98354a0..799586891a 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -750,7 +750,7 @@ static int mmc_send_op_cond(struct mmc *mmc)
>  {
>  	int err, i;
>  	int timeout = 1000;
> -	uint start;
> +	ulong start;
>
>  	/* Some cards seem to need this */
>  	mmc_go_idle(mmc);
> @@ -844,7 +844,8 @@ int mmc_send_ext_csd(struct mmc *mmc, u8 *ext_csd)
>  static int __mmc_switch(struct mmc *mmc, u8 set, u8 index, u8 value,
>  			bool send_status)
>  {
> -	unsigned int status, start;
> +	ulong start;
> +	unsigned int status;
>  	struct mmc_cmd cmd;
>  	int timeout_ms = DEFAULT_CMD6_TIMEOUT_MS;
>  	bool is_part_switch = (set == EXT_CSD_CMD_SET_NORMAL) &&
> --
> 2.47.1



