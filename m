Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27824E7B5FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 11:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F2D87504;
	Wed,  4 Oct 2023 13:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="W0MdeA9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA324874FF; Wed,  4 Oct 2023 13:57:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FBC87507
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 13:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8641a2a2c4=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3949ecHA012636; Wed, 4 Oct 2023 13:57:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=n308pKGexYEgpAX+JEIb1cAHzsac5DAEz4tHxwCNQQY=; b=W0
 MdeA9Aj6wHphppmIczMlJWQkEtMR84LOCPZEzoOCUZneAu1j9GnFAcVnN4rXBxP6
 Ga2bmQ5qPalGXU5/T8mGzxrzlV6Vu+kkD69kOFwQkgKscGwNnxp/L7A+nTKxrPfS
 TL9/nXZwwwFeVfaN59AX9uKwHIPEvtOaacVSbOpd1ZBaGcZAbQw1WIzAa+wWEKdM
 TEEkOOEbAbUNv8hQgBM7V/AxZjNzqYL+Q4oYueiqcyzgo5ZDppPZBebZkWg2l9sm
 4/yw7PDa2rtWYZK7ZnVJC5nb71xuqfRqrBAw8HCRBae2e4IyCf7Eu18J1sPkEN83
 q/3oeMdj0uFZ4tcynZAw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te93g0ygg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:57:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E33F100053;
 Wed,  4 Oct 2023 13:57:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BBF9235F29;
 Wed,  4 Oct 2023 13:57:40 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 13:57:39 +0200
Message-ID: <f9c7637d-aaf8-716b-7e4d-3091f2ccc296@foss.st.com>
Date: Wed, 4 Oct 2023 13:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Revert "fs: ext4: check the minimal partition size to
 mount"
Content-Language: en-US
To: Sean Anderson <seanga2@gmail.com>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Mikhail Ilin <ilin.mikhail.ol@gmail.com>
References: <20230930204246.515254-1-seanga2@gmail.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230930204246.515254-1-seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
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

On 9/30/23 22:42, Sean Anderson wrote:
> This check breaks small partitions (under 1024 blocks) because part_length
> is in units of part.blksz and not bytes. Given the purpose of this
> function, we really want to make sure the partition is SUPERBLOCK_START +
> SUPERBLOCK_SIZE (2048) bytes so we can call ext4_read_superblock without
> error.
>
> The obvious solution is to convert callers from things like
>
> 	ext4fs_mount(part_info.size)
>
> to
>
> 	ext4fs_mount(part_info.size * part_info.blksz);
>
> However, I'm not really a fan of the bloat that would cause, especially
> since the error is now suppressed. I think the best course of action here
> is to just revert the patch.
>
> This reverts commit 9905cae65e03335aefcb1ebfab5b7ee62d89f64e.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   fs/ext4/ext4_common.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 9a9c520e22c..f50de7c089e 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2373,10 +2373,6 @@ int ext4fs_mount(unsigned part_length)
>   	struct ext2_data *data;
>   	int status;
>   	struct ext_filesystem *fs = get_fs();
> -
> -	if (part_length < SUPERBLOCK_SIZE)
> -		return 0;
> -
>   	data = zalloc(SUPERBLOCK_SIZE);
>   	if (!data)
>   		return 0;


Agreed, I introduced error for part size in parameter

(in blk multiple even if after dev read if done after with bytes size)

And with caller change (part_info.size * part_info.blksz) we have risk 
of overflow for large ex4 partition.



minor remark: "part_length" is no more used....

it can be removed to avoid warining ?

include/ext4fs.h:149:int ext4fs_mount(void);

or use the tag  "__always_unused":

int ext4fs_mount(unsigned __always_unused part_length)
{


With the remarks:

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


