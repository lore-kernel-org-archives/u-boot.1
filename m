Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B948C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F69E80820;
	Sat,  8 Feb 2025 21:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="guOKXARM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCD28082A; Sat,  8 Feb 2025 21:32:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726D280805
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 21:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739046749; x=1739651549; i=xypron.glpk@gmx.de;
 bh=yvezcRuUBnNhVGMWSYtceuc8ScYsjPmKHwlI+RP6kpA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=guOKXARMYIP3f8enfml+Cug+1Ngmx4Lxz1O/Z/gStQV1pi9ikjeyovjJ3IpO53pD
 wXfCAcfO/pwqNay8J05Tm/vSZwQrO63lbshJa8LqnOmjTVJNLDtjJJAkaKOjEDWpg
 iqkgd+t+Q8IkbE+54dkjoprKtIrkLa4vXJPMiv39PK9w2TGoEQYF9N4Fqto9h+glv
 0Vl9IWzulYQ3SLg/mdYM62CtRmcWKERqF4vnJ8yv9mrUfDwknF5h002w2MGaZKy7y
 HM+AO4Ph+zVFU62tFGaK9inNMd38ycuLWoR4jinAjCwQxMcgO26KFCp9525niPaKh
 6LSWexV0OU5RguapDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1taDfZ0lMO-00DoVl; Sat, 08
 Feb 2025 21:32:29 +0100
Message-ID: <ac433f36-26d9-4fa4-b5aa-c820a58fa637@gmx.de>
Date: Sat, 8 Feb 2025 21:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] fs: fat: Refactor delete_dentry_long interface
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-4-Daniel.Venzin@mt.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250207124523.85026-4-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DeawcYNBgFDXQcChwZPdNRVmPwSHM3RlMxYc1k1P172azvGNS+s
 Crehbms/eM+a5IuJ5FP3wbzBu0Uc3qe1AMVqhKgp8RPpLoqVRTZiKi/yBA28qZO17hm4sDr
 w3OZg8jd0uRQi53hpueJQjT7STlQZYL1s0ePdywbzvNVnSRxmg1v4fwaIIOcEQhnBAlSKbP
 s0fGxiXB7zRTnUxBnpXJw==
UI-OutboundReport: notjunk:1;M01:P0:0NkGLoyIZx4=;yvucHZWfHfQv6BGD17LdUAihKNt
 6QAIS8Jw1Z9ail/GO0sy8VluvUCTcib+P72CcaZBKorsWaZ4WXygqggIVWEVoeC6rYlc8Vlt5
 YbuUbMFkQIkC2P6/SPKBpMPbxofF6ezLbzoxPZ57dRKujm+YmUdVbZvVRcjO5hrdwFrpS5Lvj
 yRPQ3CauSsVtFQs1le2zb/XWsibl/kD8H38oPQuDCOG7PUYM5WnxJ0ciGL9njuS192huut03t
 zFlqqvOtIomRkm5FoqxZIssxVADDgUJ2MAy6jM/kTJpiSEcTc/+RvcVbCq68qULPfpc2PT52B
 +MSdXfKlxPiHhtlzmVaPtcJ5ncVPbDmRKIB0zpvePSacAbn1z0Ivh5iI3wPvoKcGL0ATRI/GO
 DhUc1/WbyxNkm7hgn+fTSnCR2rRy8/UIB2u7zZ6YNFqtpa3tO5NmSLyieKaLfuiJyJMIhyAJN
 ayBTtM05sDUjge6FnWylgJ+bK5F7rszaf8TYcqufG2mApwowim43MvkssBJiRJE+h0JAf8iqJ
 99Cw6TchL/icP9iUF7SC/m/Z1OiwuI0Q3OO3IrRJIUTGSFRg8S6Ktj6sSbb02F7p67I+nsJmC
 Q30TQYDVk1zEPY2et9sJrdNrzzt3bByY7BqA9LczNJqdZyUmxkzXpw8lTnxeloGr54BcHcxuU
 7RgLrsexJQGufBdFMKM3uMGr/AKz+aVQ6xTUYTejKiJxntiRzDhOcpoFnfjrEW2Gp4OFXLoaD
 WLpJtM2SErUoSSL/H1ytv2OIxA5aN+o2DqMiVVUCmKIo0ZaxO8By2tGuAJZWuhfjIQB4gWwJL
 ObTW88Q5FK1woK99rfGIjszrbFxUfg8cUcSbIHvpQe+tri8WkLAaAW2e9Htv1+tc2wzvd+npt
 iCJqtSdF+npH1tVo8qZCG13rcMJHAR/h/wA+Ipq7UKuWywxwiQjfp7i/xS1Uj+wLWyW8U38zi
 5S9nzrhYRMqbWO8rV7YrviARKFApTg/CeMpTNNqljMnIzfd6Eb8TIVUoJDt4z88KR9nCZ5Myc
 fGwH9IDYKSNVZEXU940rv8EMxp6PA1ozBxgsSoPHaxbns9wdAMIMLTDPzyI/1dHfwyMo/6pBK
 wGKHxi7nW2zT6GEnqN55J7VJkV/4BvWjV++As6smb/pqEkUdRGqSzim94Sb9KhYATf/PZYMWa
 v86bGs6cV13yPVZwFVTW1jCTA1SM+AtjaTRRIwe+R3zz+T9JUJh3C9DT5dCzBHqm4EfJjXOuX
 8DmevnNqqfgFw1Li6meAkiic8BX1xF4BmWT9DQgfqfw6h63noMN/05LMHUargfzP7F26irjsQ
 ioxEx4i+m2d8Z1BwOROEYdOV4ELzWlAteob2/ZJ9vmhFvZHQa6tLtryGUnNVk78ltKJUe9SlQ
 0EwKYjcm/JpStK2kxfNqLtz+/J18DGLRzFjlIN9yGNjqNo+qUJf5lptK2k
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

On 2/7/25 13:45, Daniel Venzin wrote:
> Directory entries cannot be deleted without also removing their
> corresponding FAT entries. This refactor allows for individual
> selection of deleting the directory entry and the FAT entry,
> facilitating better reuse of existing functionality.
>
> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Refactor delete_dentry_long for improved reusability
>
>   fs/fat/fat_write.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index ea877ee9171..c78b80e0b7a 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -31,6 +31,10 @@ static const char LONG_ONLY_CHARS[] =3D "+,;=3D[]";
>   /* Combined size of the name and ext fields in the directory entry */
>   #define SHORT_NAME_SIZE 11
>
> +/* Flags to control the behavior of the delete_dentry_long(..) */
> +#define FATENT_CLEAR_SKIP	0
> +#define FATENT_CLEAR	1
> +
>   /**
>    * str2fat() - convert string to valid FAT name characters
>    *
> @@ -1568,19 +1572,23 @@ static int delete_long_name(fat_itr *itr)
>    * delete_dentry_long() - remove directory entry
>    *
>    * @itr:	directory iterator
> + * @fatent:	flag indicating whether to delete the FAT entry
>    * Return:	0 for success
>    */
> -static int delete_dentry_long(fat_itr *itr)
> +static int delete_dentry_long(fat_itr *itr, int fatent)
>   {
> -	fsdata *mydata =3D itr->fsdata;
>   	dir_entry *dent =3D itr->dent;
>
> -	/* free cluster blocks */
> -	clear_fatent(mydata, START(dent));
> -	if (flush_dirty_fat_buffer(mydata) < 0) {
> -		printf("Error: flush fat buffer\n");
> -		return -EIO;
> +	if (fatent) {

Why do we define a constant, if we don't compare with FATENT_CLEAR here?

> +		fsdata *mydata =3D itr->fsdata;
> +		/* free cluster blocks */
> +		clear_fatent(mydata, START(dent));
> +		if (flush_dirty_fat_buffer(mydata) < 0) {
> +			printf("Error: flush fat buffer\n");

Please, do not print in file system functions. This may mess up EFI
application screen output.

log_debug() is fine.

Best regards

Heinrich

> +			return -EIO;
> +		}
>   	}
> +
>   	/* Position to first directory entry for long name */
>   	if (itr->clust !=3D itr->dent_clust) {
>   		int ret;
> @@ -1661,7 +1669,7 @@ int fat_unlink(const char *filename)
>   		}
>   	}
>
> -	ret =3D delete_dentry_long(itr);
> +	ret =3D delete_dentry_long(itr, FATENT_CLEAR);
>
>   exit:
>   	free(fsdata.fatbuf);

