Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2616C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FABE879D3;
	Tue, 31 Oct 2023 07:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Hpj+7DjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A0187AF1; Tue, 31 Oct 2023 07:44:37 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F9E86F92
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031064431epoutp028ac62dcf7240cf5babb2502c0ab8de67~THi7ZwtZW2296522965epoutp02R
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:44:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031064431epoutp028ac62dcf7240cf5babb2502c0ab8de67~THi7ZwtZW2296522965epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698734671;
 bh=LbUHomerFAXy0pywkLI+OcXHuzx/fsrBWuFl/j3nOOY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Hpj+7DjZ12yMdiuf5fu2MmRL9J/BFmDIIm293UW2mpBJ0dMbvmDojXGct5Aj34SzV
 bIcB0J5cCqRJykfjXBNZBeuwiB9tIeFoVAWo+v4wi7FkmYBRNbiR7sg/bVJeZ1/Zx4
 nqINgNKBJbveeLVCyXfs1jyQAqpIbdWqsu6CSgWM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231031064430epcas1p2264c00191ca6f063f50ddacd14604564~THi7Ovfae1826118261epcas1p2N;
 Tue, 31 Oct 2023 06:44:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKLGP233Rz4x9Pv; Tue, 31 Oct
 2023 06:44:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 6E.CD.10211.C42A0456; Tue, 31 Oct 2023 15:44:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031064427epcas1p38d1b6644b69ec2cbb28670d7cd0358c4~THi4jn5RC1580015800epcas1p3M;
 Tue, 31 Oct 2023 06:44:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031064427epsmtrp195afe01e056586fd44ba1bc909ba3071~THi4i9PMu1667916679epsmtrp1e;
 Tue, 31 Oct 2023 06:44:27 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-b5-6540a24ce85b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3A.42.07368.B42A0456; Tue, 31 Oct 2023 15:44:27 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031064427epsmtip2360cf2e1b583a8a4f0eda63ba634bcf0~THi4Wm8Vt1995819958epsmtip2E;
 Tue, 31 Oct 2023 06:44:27 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20231027082615.306943-2-clamor95@gmail.com>
Subject: RE: [PATCH v9 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Date: Tue, 31 Oct 2023 15:44:27 +0900
Message-ID: <005201da0bc5$b19f9760$14dec620$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLxkJu7998OOQM6zGAUNVB6NFUBswHvqM9/APAq7MauHWtY0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTX9dnkUOqwcVtPBYH+nsZLb5t2cZo
 MXXSZnaLt3s72R1YPGY3XGTx2DnrLrvHqwOr2D3O3tnBGMASlW2TkZqYklqkkJqXnJ+SmZdu
 q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
 kJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd0bHwJVPBPu6KpfO2szcwbuPs
 YuTkkBAwkbj7aR0ziC0ksINRYtcb3y5GLiD7E6PEt0tnWCCcb4wShyd8YIPpuNhxkg0isZdR
 YvbC7cwQzktGiTWTXrKDVLEJ6En8X7QQbK6IQJnE0q61TCA2s4CURNPJXYwgNqeApcT2TfvB
 6oUFPCWunH0BVs8ioCrx9/wWsHpeoJq/U9azQNiCEidnPmGBmCMvsf3tHGaIixQkfj5dxgqx
 y0ni+sbzjBA1IhKzO9vAjpMQ+Mou0Xr8ASNEg4vEpwknWSBsYYlXx7ewQ9hSEi/729ghGpoZ
 JZYuOcgK4fQwSvxruA4NAGOJ/UsnA53HAbRCU2L9Ln2IsKLEzt9zoTbzSbz72sMKUiIhwCvR
 0SYEUaIicen1SyaYXXef/GedwKg0C8lvs5D8NgvJD7MQli1gZFnFKJZaUJybnlpsWGACj+7k
 /NxNjOAEqWWxg3Hu2w96hxiZOBgPMUpwMCuJ8B42dUgV4k1JrKxKLcqPLyrNSS0+xGgKDO2J
 zFKiyfnAFJ1XEm9oYmlgYmZkbGJhaGaoJM577FVvipBAemJJanZqakFqEUwfEwenVANTOI/9
 TLdvWw9c/vp67if51QtmRT988ypEdeEb5S/GL/fzzY6afG+OEX+wYJXIkmlhGa/2nXHy4u7w
 ytz/rkqHO0jsV7iD0+X+9g0znKoOqXCb6fqsbn3XFH9tyczXDat3h9z/XcQdahb8gvvqY/NL
 7DNnvz3P5HVbKeTb+Qf2HqIdped2LdiwdctChX35UZKSXnvPZE2ZdbpqQ8TqwiJpB94XP4MM
 RX5p3j937fYhFtO2Mo55Jed3/Z3++W5J7MGI11rXHe4s2FVwoeLuJH8n544ttpVim5d92b+m
 4NaORzu3Blfy3anqs0mc4VPdXRXIet8oT2P27u1lEz/m/Qr13FB410nhyPcfq5a+TT77YocS
 S3FGoqEWc1FxIgAKg9+FGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvK73IodUgym9JhYH+nsZLb5t2cZo
 MXXSZnaLt3s72R1YPGY3XGTx2DnrLrvHqwOr2D3O3tnBGMASxWWTkpqTWZZapG+XwJXRsfAl
 U8E+7oql87azNzBu4+xi5OSQEDCRuNhxkq2LkYtDSGA3o8S7vlnsEAkpic9PpwIlOIBsYYnD
 h4shap4zSnxdfZANpIZNQE/i/6KFzCC2iECFxJz+j2BxZqDeppO7GCEatjNKTH5xBizBKWAp
 sX3TfrAFwgKeElfOvgBrZhFQlfh7fgsTiM0LVPN3ynoWCFtQ4uTMJywgRzADLWvbyAgxX15i
 +9s5zBB3Kkj8fLqMFeIGJ4nrG89D1YhIzO5sY57AKDwLyaRZCJNmIZk0C0nHAkaWVYySqQXF
 uem5yYYFhnmp5XrFibnFpXnpesn5uZsYwVGipbGD8d78f3qHGJk4GA8xSnAwK4nwHjZ1SBXi
 TUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qBaXnqyY/O8Rb2
 sTeZJX/3cf8P73srWtl0ar7y+nbeKZvYVxyoDiqM/nXOll9U+afZ17O3Kwz4lNvC359L21K9
 w+u2smsdS1Z1ScD/jpzoRx0hOfbGRkeWC7+6FCgkNOPQnMe/5hlI+bdLmU6wM6zbeuv6a7e9
 j6Tfe0X800+5ZqffkpS6OMVGWW6J2oGAjk8VNzNVZea9uurUvmh+4OYXAblrT842VNs3wYWf
 d0WVcNLWI1rPq2U+9Byem1DtLPov9QTHxYrurWsyj1W2e6lZ1/CteJZ6fqfLPpELae8ymqbK
 VSzN65x+xXXGOocwt9BPNpKLAh6emflF+PTZrKh44UnpKl80hfsjZXlZd01RYinOSDTUYi4q
 TgQAVkpc9AEDAAA=
X-CMS-MailID: 20231031064427epcas1p38d1b6644b69ec2cbb28670d7cd0358c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231027082631epcas1p39f39d354e33b0b971d9760337b240f4a
References: <20231027082615.306943-1-clamor95@gmail.com>
 <CGME20231027082631epcas1p39f39d354e33b0b971d9760337b240f4a@epcas1p3.samsung.com>
 <20231027082615.306943-2-clamor95@gmail.com>
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
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Friday, October 27, 2023 5:26 PM
> To: Tom Rini <trini@konsulko.com>; Jaehoon Chung <jh80.chung@samsung.com>; Simon Glass
> <sjg@chromium.org>; Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: u-boot@lists.denx.de
> Subject: [PATCH v9 1/8] power: pmic: palmas: support TI TPS65913 PMIC
> 
> Existing PALMAS PMIC driver is fully compatible with TI TPS65913
> PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
> TF701T. TPS65913 shares same structure of regulators like TPS659038
> so data can be reused.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/palmas.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index eb83c88d56..b2e8a2930c 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -88,6 +88,7 @@ static struct dm_pmic_ops palmas_ops = {
> 
>  static const struct udevice_id palmas_ids[] = {
>  	{ .compatible = "ti,tps659038", .data = TPS659038 },
> +	{ .compatible = "ti,tps65913" , .data = TPS659038 },
>  	{ .compatible = "ti,tps65917" , .data = TPS65917 },
>  	{ }
>  };
> --
> 2.39.2


