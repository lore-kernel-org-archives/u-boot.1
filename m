Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E937BC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA99387FB4;
	Tue, 20 Feb 2024 15:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YDD8sxRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6B587FB3; Tue, 20 Feb 2024 15:46:00 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA1487F9C
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-410e820a4feso37171635e9.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708440357; x=1709045157; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E++qDrM8Go2PvE9/MA41fqHmvd1nz+tQOSnJnQ2GBPc=;
 b=YDD8sxRRIN3jsNTC8W0RURebvQkJndRWcfroZGf8Jqw6IznXQ7vShqn2p6ggmVdogr
 IgbFonKCkple3Wab/IKVl1qo0TqrsJVklNpzfTI1ZOmRPaORi/G26vx9TI8GjARMu8KA
 FGm3WTBP2LCqjiZkeNWVqYpddIV+ZcpPJKrJyKHW8SOt3/HQOnxQZyYoFMhXTaWNDoir
 MxZ9UiIJiA2Ko8Ie4DFe11Pi227KZ6UID6GObIizJc1SafmcDEWBcxeicBZYmFFXXncf
 lhKd6uPj9VWvHmdHQsrI6jtoPI2Ri+dIilu+1SzzjrlcsmeIafpsU/5yJJW8OXH/6J0j
 wwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708440357; x=1709045157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E++qDrM8Go2PvE9/MA41fqHmvd1nz+tQOSnJnQ2GBPc=;
 b=DnCGElxphSHjgka4VTCZGf/IQ2/Eicr2usaJU1mAyeEiBzkrx90B3ZDA/EvKzavPAf
 3y8WYFEoldPSp8uh3xPOjzTljqRqR8MnVEVWUh/XbTIBcgBMwI6shFZBrgO0A+RrtJTV
 FouznzenhVl3uqgP8D/vpvYxWHEIwcrlk6dFFbl8dta9+83efwgFVrOq8mhp/kMspKOU
 V9WM6PqcCixQnfrsw4p7UBunQzfUWZKWAdGGa20LhC9UFpgID5ip20CpBcOg9jPIczsU
 4DYEJkHvhTIwisobpILDsjW6o9HxyGJFFrzGjhBYgMAERqwLIGqD9eH8tS2ahrm7Td/S
 iuEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGMxiJWuC2P0QTJh45J5MbsgSBZmJvrchVfDfonexD8f8k4ZctiLGcWRcEgdRCDXXpKvEH9YqpBOB/GAVlCPdMCXZaFQ==
X-Gm-Message-State: AOJu0Yza6FLDbSc4aK9Nwj5A1MGlWVq3VRPIc2Cb97Yyn3AfrgYwdUQv
 1bzGjeYH8IMWA1fTkuAF/T1tzkd1eE5/I1KpgGVBPPDSLS1UgzA5stto7VV59qQ=
X-Google-Smtp-Source: AGHT+IGxSEToowWitOaKfVaeSHhoj1Y+X53NkG/OqMOA11koTQMQZtXBAsiLrI2H+QJGFqZ4pTxKig==
X-Received: by 2002:a05:600c:154f:b0:411:de5c:8023 with SMTP id
 f15-20020a05600c154f00b00411de5c8023mr13724250wmg.4.1708440357626; 
 Tue, 20 Feb 2024 06:45:57 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 k35-20020a05600c1ca300b00412393ddac2sm15315316wms.6.2024.02.20.06.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 06:45:56 -0800 (PST)
Message-ID: <90eb3142-1596-4e02-a60c-7c61cdf87e12@linaro.org>
Date: Tue, 20 Feb 2024 14:45:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: detect directories in ext4fs_exists()
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Hakgoo Lee <goodguy.lee@samsung.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 Manjunatha C Achar <a.manjunatha@samsung.com>,
 Iqbal Shareef <iqbal.ams@samsung.com>, u-boot@lists.denx.de
References: <20240220115423.61417-1-heinrich.schuchardt@canonical.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240220115423.61417-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 20/02/2024 11:54, Heinrich Schuchardt wrote:
> While fat_exists() reports directories and files as existing
> ext4fs_exists() only recognizes files. This lead to errors
> when using systemd-boot with an ext4 file-system.
> 
> Change ext4fs_exists() to find any type of inode:
> files, directories, symbolic links.
> 
> Fixes: a1596438a689 ("ext4fs ls load support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This doesn't entirely fix systemd-boot, the fs_get_size() call still
winds up in ext4fs_open() which fails because it's a directory...

I poked around to see if I could get this working but it seems like it
won't be simple :/

This is still a valid bugfix though, even if it doesn't totally fix the
issue.

Reviwed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> I still need to figure out a good test. Currently 'xxd' is the only command
> invoking fs_exists().
> ---
>  fs/ext4/ext4_common.c |  5 ++---
>  fs/ext4/ext4_common.h |  2 ++
>  fs/ext4/ext4fs.c      | 11 +++++++----
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index ea9b92298ba..365c5147c4b 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2214,9 +2214,8 @@ static char *ext4fs_read_symlink(struct ext2fs_node *node)
>  	return symlink;
>  }
>  
> -static int ext4fs_find_file1(const char *currpath,
> -			     struct ext2fs_node *currroot,
> -			     struct ext2fs_node **currfound, int *foundtype)
> +int ext4fs_find_file1(const char *currpath, struct ext2fs_node *currroot,
> +		      struct ext2fs_node **currfound, int *foundtype)
>  {
>  	char fpath[strlen(currpath) + 1];
>  	char *name = fpath;
> diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
> index 504c708b064..84500e990aa 100644
> --- a/fs/ext4/ext4_common.h
> +++ b/fs/ext4/ext4_common.h
> @@ -54,6 +54,8 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos, loff_t len,
>  		     char *buf, loff_t *actread);
>  int ext4fs_find_file(const char *path, struct ext2fs_node *rootnode,
>  			struct ext2fs_node **foundnode, int expecttype);
> +int ext4fs_find_file1(const char *currpath, struct ext2fs_node *currroot,
> +		      struct ext2fs_node **currfound, int *foundtype);
>  int ext4fs_iterate_dir(struct ext2fs_node *dir, char *name,
>  			struct ext2fs_node **fnode, int *ftype);
>  
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index 3b12ec54fa2..b1359d14909 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -208,11 +208,14 @@ int ext4fs_ls(const char *dirname)
>  
>  int ext4fs_exists(const char *filename)
>  {
> -	loff_t file_len;
> -	int ret;
> +	struct ext2fs_node *dirnode = NULL;
> +	int filetype;
>  
> -	ret = ext4fs_open(filename, &file_len);
> -	return ret == 0;
> +	if (!filename)
> +		return 0;
> +
> +	return ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
> +				 &filetype);
>  }
>  
>  int ext4fs_size(const char *filename, loff_t *size)

-- 
// Caleb (they/them)
