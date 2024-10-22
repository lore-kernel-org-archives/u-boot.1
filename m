Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994CBCDD0FB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 22:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A4C8904B;
	Wed, 23 Oct 2024 00:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="qy9A6V+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E1789081; Wed, 23 Oct 2024 00:50:43 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C282F88FBD
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 00:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241022225031epoutp034a46163720f5113a1615420ab5f473d3~A6BRzNwSi1675416754epoutp03U
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:50:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241022225031epoutp034a46163720f5113a1615420ab5f473d3~A6BRzNwSi1675416754epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729637431;
 bh=Y4fxPr4fkCYmR3nuEO2/gkInt4vbe2IMTZuoZL62NFA=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=qy9A6V+1c74StiJg2/htEqoApWMH3KMcG+8geSYxW1w/m07NSbZcGzsn0bCjhOIcU
 m5okSMzGJ5bo65OD6ghZHhDNLfCEdPO7g7VTQWZT9fVz/gkMetizomgmgj2TX36X+1
 MrqEsuRp4IlMGgPgJPOrteH9a15vCyqf4z9Pn3qw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241022225031epcas1p20c25ce8ac6c7f8bcbbda7f37afce9dc2~A6BRep-_Z2596825968epcas1p2Z;
 Tue, 22 Oct 2024 22:50:31 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4XY6pF612vz4x9Q0; Tue, 22 Oct
 2024 22:50:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E4.BB.09435.53C28176; Wed, 23 Oct 2024 07:50:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241022225029epcas1p35ee0aaf96b8e66f4f6aabeadee8ac27c~A6BP7Pa7s3014830148epcas1p3h;
 Tue, 22 Oct 2024 22:50:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241022225029epsmtrp1fcc45fe0f09865210210510a54bf20db~A6BP6qjaA3195231952epsmtrp1j;
 Tue, 22 Oct 2024 22:50:29 +0000 (GMT)
X-AuditID: b6c32a36-d2dfa700000024db-63-67182c35898d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9F.55.07371.53C28176; Wed, 23 Oct 2024 07:50:29 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241022225029epsmtip15dc74f5fbe902f4327a7b6900994b71f~A6BPtURU_2397323973epsmtip1i;
 Tue, 22 Oct 2024 22:50:29 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Paul Barker'" <paul.barker.ct@bp.renesas.com>, "'Nobuhiro Iwamatsu'"
 <iwamatsu@nigauri.org>, "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>,
 "'Peng Fan'" <peng.fan@nxp.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20241018075148.2783-1-paul.barker.ct@bp.renesas.com>
Subject: RE: [PATCH] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
Date: Wed, 23 Oct 2024 07:50:29 +0900
Message-ID: <0a4b01db24d4$cacb9d50$6062d7f0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHbuEUZgfegX5kXSzz57Vs7qh0o0wFAooNwsogz1AA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmvq6pjkS6wbl1OhZvm4stWlfeYbP4
 c/IHq8WPVV9YLd7u7WR3YPVY+WI2u8fZOzsYPXbO3sfkcWDyOVaPje92MAWwRmXbZKQmpqQW
 KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
 K+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZzx+PJG5YCJf
 RffLLYwNjG+4uxg5OCQETCTef3LsYuTiEBLYwSjx/WALC4TziVFiUeMxJgjnG6PEkofPgBxO
 sI7N56ayQiT2Mkos7OxjAUkICbxklLg+UQPEZhPQk/i/aCEzSJGIwE5Gib+z1oN1MwtISTSd
 3MUIYnMKOEm8e97CCmILC/hITLv8jw3EZhFQlejsWcUMch+vgKXEmmPmEIsVJH4+XcYKMUZE
 YnZnGzOILSJgJbGicR0jyC4JgWvsEl8PzWKGaHCR2Nq/hQXCFpZ4dXwLO4QtJfGyv40doqGZ
 UWLpkoOsEE4Po8S/hutsEFXGEvuXTmYCuYJZQFNi/S59iM18Eu++9rBCAo9XoqNNCKJaReLS
 65dMMPPvPvnPCmF7SCxq28kMCaCpjBKPzoVPYJSfheSHWQgLFjAyrWIUSy0ozk1PLTYsMILH
 ZHJ+7iZGcKLTMtvBOOntB71DjEwcjIcYJTiYlUR4lUpE04V4UxIrq1KL8uOLSnNSiw8xmgID
 ciKzlGhyPjDV5pXEG5pYGpiYGRmbWBiaGSqJ8565UpYqJJCeWJKanZpakFoE08fEwSnVwDTx
 mtRrgx6Jv5d5AvJma6Qe4L0hUKu/4uzXGwfuacpc4DGVeXXt0IPbq76wTJNXPrKnlq9KpMzE
 TkBgtZ0bV4Qfu8ruV7vCLpYxzznNrPrUSfki84IaDvOP/mUG/QZLlVnDE26Y9z2021EsyVJU
 zD4vO/vIWYXleYduqa6pNv/M6Ts511Wqv9Uof3Fdnre+jENmuKzhMpeXsndv7lmwrS8zNnjC
 2RkH+NcYJQW6V+3/pevsrF2hEivSclK06la//tlw8RaOQ5sbr314OT8/IOxwQPn+5KoNvlPT
 X4pHaKltajqze/3EG5tmFHbPMNgj72N7bnHVZWv2bztsVNbmfmxnvT3FJVrm/q6k0l5jJZbi
 jERDLeai4kQAeKEziP0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK6pjkS6wZNnQhZvm4stWlfeYbP4
 c/IHq8WPVV9YLd7u7WR3YPVY+WI2u8fZOzsYPXbO3sfkcWDyOVaPje92MAWwRnHZpKTmZJal
 FunbJXBlPH48kblgIl9F98stjA2Mb7i7GDk5JARMJDafm8raxcjFISSwm1Hi6LsljBAJKYnP
 T6eydTFyANnCEocPF0PUPGeUWL6hmwmkhk1AT+L/ooXMIAkRkOaX59+wgSSYgZqbTu5ihOiY
 zCixY88vVpAEp4CTxLvnLWC2sICPxLTL/8AaWARUJTp7VjGDbOMVsJRYc8wc4ggFiZ9Pl7FC
 zBSRmN3ZxgxiiwhYSaxoXMc4gVFgFpLUAkbGVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5
 uZsYwaGqpbGD8d78f3qHGJk4GA8xSnAwK4nwKpWIpgvxpiRWVqUW5ccXleakFh9ilOZgURLn
 NZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAdOO6qJ+GhZ/r7JQHqn8zjVUj/ZxPFDbb6Uxyi3pt
 G5co9DxgzSzWHTV/Dthdn2b/tr1h6i1BCbvL1Xwlvn9D5VctrZhzl2PpisXKC86csFywKG2e
 ya6yfSLvXtrOdTaw5pqgut4nZX9vj+jrFtGz98yKu9RaUsJ8vvPI/r+Qm/o2jfHxvQLbqmXX
 BLw5Aqz1uYWuHe8yZP+5bo5a/q2WS10V+5vi5aLr1h4OuCshtjW9317gdgA7x43C82Gn1S5v
 FPCSPD2nfBlLRk+/Q9Uv9kaN06tuTDxb+Wyz2jvOu1b+tidLuxXmn77yRv5vdKbIac2Cp4++
 +biLbL7Nd+tm7LePXHqO951PMVon8k9RYinOSDTUYi4qTgQAirXTycQCAAA=
X-CMS-MailID: 20241022225029epcas1p35ee0aaf96b8e66f4f6aabeadee8ac27c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241018075201epcas1p20329e5a2c9015122d006fca48bf5dfc7
References: <CGME20241018075201epcas1p20329e5a2c9015122d006fca48bf5dfc7@epcas1p2.samsung.com>
 <20241018075148.2783-1-paul.barker.ct@bp.renesas.com>
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
> From: Paul Barker <paul.barker.ct@bp.renesas.com>
> Sent: Friday, October 18, 2024 4:52 PM
> To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>; Marek Vasut <marek.vasut+renesas@mailbox.org>; Peng Fan
> <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>; u-boot@lists.denx.de
> Subject: [PATCH] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
>
> After the recent dts/upstream subtree merge, the sdhi compatible string
> used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
> not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
> and SD card devices on RZ/G2L boards.
>
> Fix this by adding the new compatible string to the sdhi driver.
>
> Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/renesas-sdhi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 23db2a75c444..916182cdadea 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -863,6 +863,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
>  	{ .compatible = "renesas,sdhi-r8a77970", .data = RENESAS_GEN3_QUIRKS },
>  	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
>  	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
> +	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
>  	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
>  	{ /* sentinel */ }
>  };
> --
> 2.43.0



