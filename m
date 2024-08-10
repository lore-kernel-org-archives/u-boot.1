Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69062C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 11:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9527E88802;
	Sat, 10 Aug 2024 13:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723288308;
	bh=17TiA0tpAOLt2ielQiufvTEJESUIBlcXo5cQRWX6r8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZhY3qSj4aB2VmJ/AqO8yQz0CMS6a0+fMc1Oum3EM7oIeBSNc1WOpleUJXg/6PYpIK
	 Q9OwVBr0keQe0ndsH/iEaJRok/Ko/C93Eigs3lVy8xQp7+ffT88eHdMdHYseJIkjIi
	 nq0Der2HyvaaeXmvIyaPeeiBaXek2irin66+4Q1SjSWhTVUms8vaelg0gWB4U5kQVA
	 DhpYVBpJrPPumTAvj6awaNOVwazuO/NHgV8SoxWKIDgioQZXb8gKz+wS3xVeQydcZE
	 YgX1VQAkhW28BzzU6TiTCseBpMsPs1mDsDxeDtx2RHE5ctGJA7xLo5BCvbJDEuTfnA
	 c/Bbyzo6G2W8Q==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 57A3A80805;
 Sat, 10 Aug 2024 13:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723288307;
 bh=17TiA0tpAOLt2ielQiufvTEJESUIBlcXo5cQRWX6r8s=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=UtSToZwmkJ9gWnBSzRR9MLgOFDgFIKmxOljhh+hnx9KC2AmaPHUFvxx8qFnky9XoM
 sJwoJCa9/VZ+wXVMXX6lfe6nxK4NP/KgmECvCWMsrG2tDNpo+ao4a+sphsDq/6m8JF
 ewAEA2tFMUHW4kjB6OuzWVF060oDAH+QRXn+6lNJL2azhLCoqscXwo9armDrsva392
 mHR4nczawRTbpU5DDse3xl239iOoZ7drg+Ya//Q9gFO6Q1I+IWtERH/z/Kt4qYCefM
 pijWjmBW4IV1q6xt471JsqUYgfOPBYxO6wwTLlVW+6ztzuk0AgXAVnt0Nj8EzRYfEJ
 JmO9dzieOU0Nw==
Message-ID: <f35969d7-4677-1c7f-e70b-1b3245720009@denx.de>
Date: Sat, 10 Aug 2024 13:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Content-Language: en-US
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Dahl <ada@thorsis.com>
References: <20240807154210.1224130-1-michael@amarulasolutions.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240807154210.1224130-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michael,

On 07.08.24 17:42, Michael Trimarchi wrote:
> The inode should be freed after a reference is get to avoid
> memory leak
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>
> Link: https://lore.kernel.org/u-boot/b698ec3e-d857-6512-8cc9-4edcab0a41b9@denx.de/T/#t
> Link: https://lore.kernel.org/all/8f3a7059-6330-f332-8e9f-729b853e001e@denx.de/T/
> Co-Developed-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> RFC=>V1:
> 	- Heiko gives more points to address on the patch and review it
> 	- Alexander Dahl test on top of his own series reported in the
> 	  commit message
> 	- add leak on super.c file too from Heiko
> ---
>   fs/ubifs/super.c | 1 +
>   fs/ubifs/ubifs.c | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index d8d78a2d3d..7721e168fb 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2321,6 +2321,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
>   		goto out_umount;
>   	}
>   #else
> +	ubifs_iput(inode);
>   	sb->s_root = NULL;
>   #endif

This breaks build:

https://dev.azure.com/hs0298/hs/_build/results?buildId=120&view=logs&j=4f2a9147-48ab-50e3-8e13-2f207368f205&t=617c682e-fe32-5637-a697-bfafa314b3b3&l=271

obviously it must be

ubifs_iput(root);

Sorry... can you send a v2 please?

bye,
Heiko

>   
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 048730db7f..6acd6c3776 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -319,9 +319,7 @@ static int filldir(struct ubifs_info *c, const char *name, int namlen,
>   	}
>   	ctime_r((time_t *)&inode->i_mtime, filetime);
>   	printf("%9lld  %24.24s  ", inode->i_size, filetime);
> -#ifndef __UBOOT__
>   	ubifs_iput(inode);
> -#endif
>   
>   	printf("%s\n", name);
>   
> @@ -557,6 +555,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>   
>   			/* We have some sort of symlink recursion, bail out */
>   			if (symlink_count++ > 8) {
> +				ubifs_iput(inode);
>   				printf("Symlink recursion, aborting\n");
>   				return 0;
>   			}
> @@ -568,6 +567,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>   				 * the leading slash */
>   				next = name = link_name + 1;
>   				root_inum = 1;
> +				ubifs_iput(inode);
>   				continue;
>   			}
>   			/* Relative to cur dir */
> @@ -575,6 +575,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>   					link_name, next == NULL ? "" : next);
>   			memcpy(symlinkpath, buf, sizeof(buf));
>   			next = name = symlinkpath;
> +			ubifs_iput(inode);
>   			continue;
>   		}
>   
> @@ -583,8 +584,10 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>   		 */
>   
>   		/* Found the node!  */
> -		if (!next || *next == '\0')
> +		if (!next || *next == '\0') {
> +			ubifs_iput(inode);
>   			return inum;
> +		}
>   
>   		root_inum = inum;
>   		name = next;
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
