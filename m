Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AB4E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 23:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A24180655;
	Mon, 23 Dec 2024 00:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="V1DOI7PI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA208069A; Mon, 23 Dec 2024 00:47:40 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91FA980654
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 00:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241222234731epoutp03d412a1cf3707c7c7761adc6cd663a4b9~TpJdBVsuT2804128041epoutp03t
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:47:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241222234731epoutp03d412a1cf3707c7c7761adc6cd663a4b9~TpJdBVsuT2804128041epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734911251;
 bh=OE670r61Hm+HNt0TVe0ijTXPAC88ga429OzlxbOC6ww=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=V1DOI7PIBG8S4Xf2M1oLatTbbjorj2u7965rcvfUomVjFJdWrJqik89Gs1W48SCrC
 jMUvl9+Jn2guyf9pu7EdNn83nfdkxkcXnHJ+DmVCjSMFT3c38cnU34tneU07gpyspr
 m50sbxMHyhwpFakORmicQ1EJFz781p3IMbnGbWcI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241222234730epcas1p2759565ca2a7cee8b3a8c8ba4e595d596~TpJcqLwZo2140221402epcas1p2L;
 Sun, 22 Dec 2024 23:47:30 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.233]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4YGd9s1zbRz4x9Q3; Sun, 22 Dec
 2024 23:47:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.E8.23869.C05A8676; Mon, 23 Dec 2024 08:47:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241222234724epcas1p1d611673332203f4dc9dadd6f2597bb24~TpJW5ukOz0179601796epcas1p1c;
 Sun, 22 Dec 2024 23:47:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241222234724epsmtrp217951de7ad1752bd492a1a8fb56e281c~TpJW4_oli0286402864epsmtrp2L;
 Sun, 22 Dec 2024 23:47:24 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-e4-6768a50ca92b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.10.33707.C05A8676; Mon, 23 Dec 2024 08:47:24 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241222234724epsmtip2f6a9994024f224564b973260b04f96ac~TpJWp3C602795027950epsmtip2R;
 Sun, 22 Dec 2024 23:47:24 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Peng Fan'" <peng.fan@nxp.com>, "'Quentin Schulz'"
 <quentin.schulz@cherry.de>, "'Sean	Anderson'" <seanga2@gmail.com>, "'Tim
 Harvey'" <tharvey@gateworks.com>, "'Tom Rini'" <trini@konsulko.com>
In-Reply-To: <20241219182907.2609704-2-sjg@chromium.org>
Subject: RE: [PATCH v4 01/19] spl: mmc: Avoid size growth in
 spl_mmc_find_device() debug
Date: Mon, 23 Dec 2024 08:47:23 +0900
Message-ID: <058d01db54cb$d9824890$8c86d9b0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQM/3Of0v9OXnTin/mV3TZmQOcoK8QLuKse/AsBEZKOv/GpAEA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmvi7P0ox0gz9TNSx+rPrCarH+8jZ2
 i633JjBZfNuyjdHi4olPzBZTJ21mt3i7t5Pdgd3j7dMpjB6zGy6yeJzrucvmsXPWXXaPVwdW
 sXucvbOD0WPjux1MAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
 tkouPgG6bpk5QBcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS
 9fJSS6wMDQyMTIEKE7Iz/lyfwljwlrNiactMxgbGn+xdjJwcEgImEut29TF3MXJxCAnsYJTo
 +nODBSQhJPCJUaJ3WhVEAsjubN3IDNMxue0eO0RiJ6PErid7oJyXjBITn11mBaliE9CT+L9o
 IVAHB4eIQITE2Rt+IDXMAicYJd4f3wxWwylgIXFk8ykWkBphgSiJTa9yQMIsAqoS7Tc2MYGE
 eQUsJTo/m0LsVZD4+XQZWCezgIjE7M42sHtEBJwkPk5ZzwoyXkLgLbtE4/1tbBANLhIblm9i
 hbCFJV4d3wL1spTE53d72SAamhklli45CNXdwyjxr+E6VLexxP6lk8GuYBbQlFi/Sx9iM5/E
 u689rCBhCQFeiY42IYhqFYlLr18ywcy/++Q/1F4Piea7DUzwwJq06iT7BEb5WUiemIWwYQEj
 0ypGsdSC4tz01GLDAiN4TCbn525iBKdELbMdjJPeftA7xMjEwXiIUYKDWUmEl0cuNV2INyWx
 siq1KD++qDQntfgQoykwJCcyS4km5wOTcl5JvKGJpYGJmZGxiYWhmaGSOO+ZK2WpQgLpiSWp
 2ampBalFMH1MHJxSDUwM/n2sW1YIGrRa3OSP258mHXHYbuKm+5y/N7ec8fmtdvCEn/VW9pK1
 u6bsEX6cHPipQvB1BlfCNsb3/AJ2Oh2TguXWcvxNnqb3vf5zQW5u0vbSoI6mV2Gmd7LuuHje
 3Wu6IX63h1XQpf/zI6M2lhjfmuzU2HL6kpnJle0z5H1/sOU6d2o83NimbdpT2T31psQcvl37
 t3/aafbkJ9ekoIpgR6P7b4U31wX/Wdr92COBLbKuiCX5jEfpJs8bAmcN7/jNaNtxI1/V9bWD
 lzyv4uavngt/qD/zrtq/+lm+5Z3w895KvVFd1dJNv19O/KL9w3myLa9M0pz57u5H+T9ZTLwY
 vUPDWlj1QM4buxUXpZRYijMSDbWYi4oTAVjr15ISBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvC7P0ox0g/0vRSx+rPrCarH+8jZ2
 i633JjBZfNuyjdHi4olPzBZTJ21mt3i7t5Pdgd3j7dMpjB6zGy6yeJzrucvmsXPWXXaPVwdW
 sXucvbOD0WPjux1MAexRXDYpqTmZZalF+nYJXBl/rk9hLHjLWbG0ZSZjA+NP9i5GTg4JAROJ
 yW33gGwuDiGB7YwS1+avZ4NISEl8fjoVyOYAsoUlDh8uhqh5zihx4ukBFpAaNgE9if+LFjKD
 2CICERJzfy1iArGZBc4wSsw8KQPRsJVRYtehQ4wgCU4BC4kjm0+BNQsDNXxbOR/MZhFQlWi/
 sYkJZBmvgKVE52dTiBsUJH4+XcYKMVNEYnZnG9QuJ4mPU9azTmAUmIUktYCRcRWjaGpBcW56
 bnKBoV5xYm5xaV66XnJ+7iZGcChrBe1gXLb+r94hRiYOxkOMEhzMSiK8PHKp6UK8KYmVValF
 +fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1MAvGdvzQvh6lt+P7PfNvJ
 BjHH2Ue2nHu3aJn2UQ932Xj3WgO1CL91fAk7dl947Mrwqfz08ynH9xjtPj3z4Trx4NDeH1/c
 VeuqjkpLha6yPjejZIrm7pBrd3gYfu0zFszzubwm6vpiN1/V1KvuJxd+496wn/Xmhvz4xd9e
 Hvq79F7OxSXMFslTPaaoyMR9SlEpEt0WrrhGfcLTzAv1Qu8tJ1/N3Lntyj++xMUnLV+47XP4
 uq+8qzrd2HSlXOZBi8oPAtE3dvopzM/ZuKuG1TuKdQv/ka+lLz9y5+fHT3u0aNLT+Q1nL+c+
 lPENj3eeUtPfaht5YWb78rxrGvtyJt5JYfcvev9Y6l74cw+LzOAv2UosxRmJhlrMRcWJAJbl
 6GXUAgAA
X-CMS-MailID: 20241222234724epcas1p1d611673332203f4dc9dadd6f2597bb24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241219182919epcas1p3f6a0504418752f06b26251b352d62910
References: <20241219182907.2609704-1-sjg@chromium.org>
 <CGME20241219182919epcas1p3f6a0504418752f06b26251b352d62910@epcas1p3.samsung.com>
 <20241219182907.2609704-2-sjg@chromium.org>
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
> From: Simon Glass <sjg@chromium.org>
> Sent: Friday, December 20, 2024 3:29 AM
>
> The for() loop ends up being in the code even if the log_debug() does
> nothing. Add a condition to fix this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to avoid size growth in spl_mmc_find_device() debug
>
>  common/spl/spl_mmc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 1f696593216..fe4230170a0 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -81,8 +81,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
>  	struct uclass *uc;
>
>  	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> -	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> -		log_debug("%d: %s\n", dev_seq(dev), dev->name);
> +	if (_LOG_DEBUG) {
> +		uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> +			log_debug("%d: %s\n", dev_seq(dev), dev->name);
> +	}
>  	ret = mmc_init_device(mmc_dev);
>  #else
>  	ret = mmc_initialize(NULL);
> --
> 2.34.1



