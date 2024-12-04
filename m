Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1254CE77160
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 00:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E49E8966C;
	Wed,  4 Dec 2024 01:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tf0i6o/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70468966C; Wed,  4 Dec 2024 01:27:36 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03F98967D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 01:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241204002731epoutp048856ffe5bb580e008a35d19c342c257c~N0b9t0PHB0686506865epoutp045
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:27:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241204002731epoutp048856ffe5bb580e008a35d19c342c257c~N0b9t0PHB0686506865epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733272051;
 bh=ZBbfdhStwAWwhO92mq4DXjhbCjZAHkaqZt92zOxiL0U=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=tf0i6o/hXJakQS/ja1mjgtAwczxhnlDSYtVbx0I62k/J3UnklfNrTLfGKJevzTHZn
 zSBAg3fZsW+7LA0r6Se5s+oPkkAvOHPSYY8/uDR5ITqK8XHeIQM+kKh/ieJ97/bQPu
 K5UQJMTjcEuwoaUBqxo2V2nzPJV54xKZCdWwpsZc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241204002731epcas1p30c4bbb9a18b7617316ae1e7ef440a0ed~N0b9TxsL21087610876epcas1p3U;
 Wed,  4 Dec 2024 00:27:31 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.235]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y2yyn6ZSCz4x9Px; Wed,  4 Dec
 2024 00:27:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 7C.79.24218.1F1AF476; Wed,  4 Dec 2024 09:27:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241204002729epcas1p472713382b5db7147a43183b299c5121d~N0b7rMCk61999819998epcas1p4j;
 Wed,  4 Dec 2024 00:27:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241204002729epsmtrp14a9f7a63b24099cfc82f6f01a345c44f~N0b7qa6J20865508655epsmtrp1G;
 Wed,  4 Dec 2024 00:27:29 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-90-674fa1f17c87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 80.FA.33707.1F1AF476; Wed,  4 Dec 2024 09:27:29 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241204002728epsmtip2c12787d545db2552dd8a2d4c3ed2c30b~N0b6xuacq0126301263epsmtip2T;
 Wed,  4 Dec 2024 00:27:28 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Hal Feng'" <hal.feng@starfivetech.com>, "'Leo'"
 <ycliang@andestech.com>, "'Tom Rini'" <trini@konsulko.com>, "'Sumit Garg'"
 <sumit.garg@linaro.org>, "'Rick Chen'" <rick@andestech.com>, "'Heinrich
 Schuchardt'" <xypron.glpk@gmx.de>, "'H Bell'" <dmoo_dv@protonmail.com>, "'E
 Shattow'" <lucent@gmail.com>, "'Conor Dooley'" <conor.dooley@microchip.com>,
 "'Nam Cao'" <namcao@linutronix.de>, "'Bo Gan'" <ganboing@gmail.com>
Cc: "'Emil Renner Berthing'" <emil.renner.berthing@canonical.com>, "'Minda
 Chen'" <minda.chen@starfivetech.com>, <u-boot@lists.denx.de>
In-Reply-To: <20241203030430.26089-4-hal.feng@starfivetech.com>
Subject: RE: [PATCH v7 03/12] mmc: dw_mmc: Add "starfive, jh7110-mmc"
 compatible to match upstream DT
Date: Wed, 4 Dec 2024 09:27:28 +0900
Message-ID: <000901db45e3$4d3519e0$e79f4da0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK19nql/sAKmIJlQ6nel8nVylXDnQI6K5NTAnBk9q+w+oUVcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmvu7Hhf7pBv96jS2mbNrBbvF27yU2
 i0udKxgtJu3by2RxqfUQk0Xnd3aLScsDLfbu38Ns8fbFWUaLdfv62CymTtoMUt/JbnF46gdG
 i8eHXjM58HnsOT2L2WNWQy+bx85Zd9k9PnyM83h1YBW7x51re9g83p07x+5x9s4ORo87P5Yy
 evS0bWLyuH2WN4A7KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
 xSdA1y0zB+gJJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJucWleul5e
 aomVoYGBkSlQYUJ2xsKGNuaCO9wVf488Z2xgfM/ZxcjJISFgIrFn2XyWLkYuDiGBHYwS114+
 ZYRwPjFKzDr1jB3Ouf74GRNMy/GrXWwQiZ2MEtvOv4bqf8kocb73GTNIFZuAnsT/RQuZQRIi
 AuuZJT6cuADmMAt0Mkp8OnEKrIpTwF7i9J4nQLM4OIQF0iW63xiBhFkEVCQWnGhlBLF5BSwl
 7jc/Y4NYrSDx8+kyVhBbRMBJYteezewgNrOAiMTszjaw+RICBzgkFmy6wwjR4CJx/eteZghb
 WOLV8S3sELaUxMv+NnaIhmZGiaVLDrJCOD2MEv8arkOtM5bYv3QyE8h1zAKaEut36UNs45N4
 97WHFSQsIcAr0dEmBFGtInHp9UsmmPl3n/xnhbA9JM4uvQgNr+OMEn0vLjNNYJSfheTwWQgb
 FjAyrWIUSy0ozk1PLTYsMIHHZnJ+7iZGcALWstjBOPftB71DjEwcjIcYJTiYlUR4l6/3Thfi
 TUmsrEotyo8vKs1JLT7EaAoMyonMUqLJ+cAckFcSb2hiaWBiZmRsYmFoZqgkznvmSlmqkEB6
 YklqdmpqQWoRTB8TB6dUAxNbyIT4j/fPc6cYlNu9fmzAbbri07OH/ufsq+xCg1ctuZG++8uU
 hN1hv9wiMy9aJDSkyEh2FxxPLjDMsTr791JkcKWq9rxrH302rChVm+x3f9GXu+dKO01Xtzb2
 dXFMebRaZb70p29X6w5XBHzWSbNIF3wkGTtzicC6vA+aGzN//9l87FPMVgtBq/C7vNdvOX1R
 T3Cr5xQ9oLTr+m/NFj6zrxGHnwTEtrNFmKdVr5y3/ODyqZFaUoF7nx99c6JhqaitzraVFoKT
 23Wsz4gkNp3PS2Fxnj47e158rsRqJvmW5/kSSpqMFzf8lBeb1Ps5fMs/sRkcp/vmtHz/Fu0Q
 I3Jv46UzrIvFloV+NswMYlBiKc5INNRiLipOBACQLtACSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7Hhf7pBtt/S1pM2bSD3eLt3kts
 Fpc6VzBaTNq3l8niUushJovO7+wWk5YHWuzdv4fZ4u2Ls4wW6/b1sVlMnbQZpL6T3eLw1A+M
 Fo8PvWZy4PPYc3oWs8eshl42j52z7rJ7fPgY5/HqwCp2jzvX9rB5vDt3jt3j7J0djB53fixl
 9Ohp28TkcfssbwB3FJdNSmpOZllqkb5dAlfGwoY25oI73BV/jzxnbGB8z9nFyMkhIWAicfxq
 F1sXIxeHkMB2RonZuz4zQiSkJD4/nQqU4ACyhSUOHy4GCQsJPGeU+H6EA8RmE9CT+L9oITNI
 r4jATmaJ5n+H2UASzALdjBJLL9ZBDD3MKDH3+FSwoZwC9hKn9zwBGyoskCpx/EYGSJhFQEVi
 wYlWsBJeAUuJ+83P2CBuUJD4+XQZK4gtIuAksWvPZnaI+SISszvbmCcwCsxC4i5gZFzFKJpa
 UJybnptcYKhXnJhbXJqXrpecn7uJERwxWkE7GJet/6t3iJGJg/EQowQHs5II7/L13ulCvCmJ
 lVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTB11Ohb1dlmLdtvw
 lQpG9NVe2MCx/xrf9gnXVkxomrFk1UW24PPzP7E+0lBZt3f2uh22u0vlU/mOnXpSUuIcfXDm
 qcfzHosemzFRo+bN5tfPGT7NODtlmaCtkuuynQF9Px2VpFe2HK5ak/5AXWuv9HwO499sEU8y
 Z0/501fqWX73aZtq0RrT95a8rR/67nI9eiFQ42t97xe3n6LsXvu9AhmqXz7PeGpsszbqUIHh
 b13n1RurubawHXA5M+voY43+rCmX5H88yPofsWxt9qpuFcG2yRvv7nvquvpWt5SArdU9uyI1
 ecb9Py7tOVK7JSuxs1pEnce6Zo8YmxHz/7zAxC/yzRaHnmc/6vdg2r5J10KJpTgj0VCLuag4
 EQClOWGZBwMAAA==
X-CMS-MailID: 20241204002729epcas1p472713382b5db7147a43183b299c5121d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203031220epcas1p1a373ead319cb06fba86f965cd02c7a0a
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <CGME20241203031220epcas1p1a373ead319cb06fba86f965cd02c7a0a@epcas1p1.samsung.com>
 <20241203030430.26089-4-hal.feng@starfivetech.com>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Hal Feng
> Sent: Tuesday, December 3, 2024 12:04 PM
> To: Leo <ycliang@andestech.com>; Tom Rini <trini@konsulko.com>; Sumit Garg <sumit.garg@linaro.org>;
> Rick Chen <rick@andestech.com>; Heinrich Schuchardt <xypron.glpk@gmx.de>; H Bell
> <dmoo_dv@protonmail.com>; E Shattow <lucent@gmail.com>; Conor Dooley <conor.dooley@microchip.com>; Nam
> Cao <namcao@linutronix.de>; Bo Gan <ganboing@gmail.com>
> Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>; Minda Chen
> <minda.chen@starfivetech.com>; Hal Feng <hal.feng@starfivetech.com>; u-boot@lists.denx.de
> Subject: [PATCH v7 03/12] mmc: dw_mmc: Add "starfive, jh7110-mmc" compatible to match upstream DT
>
> Make the U-Boot JH7110 MMC driver compatible with upstream DT.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/snps_dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
> index 47ab5654bd..92880e0ed8 100644
> --- a/drivers/mmc/snps_dw_mmc.c
> +++ b/drivers/mmc/snps_dw_mmc.c
> @@ -186,6 +186,7 @@ static int snps_dwmmc_bind(struct udevice *dev)
>
>  static const struct udevice_id snps_dwmmc_ids[] = {
>  	{ .compatible = "snps,dw-mshc" },
> +	{ .compatible = "starfive,jh7110-mmc" },
>  	{ }
>  };
>
> --
> 2.43.2



