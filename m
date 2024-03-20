Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E83EC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 17:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797FA87F88;
	Wed, 20 Mar 2024 18:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LyoZtESC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB01F880A5; Wed, 20 Mar 2024 18:37:52 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F1387D8F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 18:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3809a22167=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KHDXx0010576; Wed, 20 Mar 2024 18:37:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=BoLd0Gu75WOO3g63LHURPSLTBXjyOn4haPqMqXNMqCI=; b=Ly
 oZtESC6isN6vXaOyjGdyqzAG1o8l9tQ0BHLZYcTXES+T4sTVWXz1/V+OZne8SXrz
 AV3T9v8dSUEKToA7HwnqrvQFHN/LMI2sejuGUvh3Z7f0AlVJU+9dFHcDU5ZHYtln
 PIdnJpjDQZX4CEUX5+uM8RcfNDNpIMDoQ+Pnp892b8STLNdsTgZcYFQFd7xovi6O
 AVVV2JrM4fsiHi0h/CC6IicVkp/dgtOO/GyMT4ei5WBYiMJ0rvjiMCjxQujfAuLh
 cmKi4tuUTdEZIIzHmtM/1Jy9KvLbYRAZuZDKbYOx8PHLRdoyysSu9UXQOBm7jVI5
 qCiU1H2YR3CBDfGc4GAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ww36htp7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 18:37:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AECF340046;
 Wed, 20 Mar 2024 18:37:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09813273633;
 Wed, 20 Mar 2024 18:37:21 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Mar
 2024 18:37:20 +0100
Message-ID: <c9378344-4e3d-4ed7-843b-18abfd369fa8@foss.st.com>
Date: Wed, 20 Mar 2024 18:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs: ext4: all file paths are absolute
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Sean Anderson <seanga2@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240320132525.46259-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
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



On 3/20/24 14:25, Heinrich Schuchardt wrote:
> U-Boot only knows absolute file paths. It is inconsistent to require that
> saving to an ext4 file system should use a leading '/' wile reading does
> not. Remove the superfluous check.
> 
> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index ea9b92298ba..9eac6beef3b 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -765,11 +765,6 @@ int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags)
>  	struct ext2_inode *first_inode = NULL;
>  	struct ext2_inode temp_inode;
>  
> -	if (*dirname != '/') {
> -		printf("Please supply Absolute path\n");
> -		return -1;
> -	}
> -
>  	/* TODO: input validation make equivalent to linux */
>  	depth_dirname = zalloc(strlen(dirname) + 1);
>  	if (!depth_dirname)


Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
