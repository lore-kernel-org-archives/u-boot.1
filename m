Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991E8CCFA03
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 13:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0458783A2B;
	Sat,  1 Nov 2025 14:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B+hCEYcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E57B83A3B; Sat,  1 Nov 2025 14:48:09 +0100 (CET)
Received: from mail-m3283.qiye.163.com (mail-m3283.qiye.163.com
 [220.197.32.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6762B83A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 14:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 280324b6a;
 Sat, 1 Nov 2025 21:47:59 +0800 (GMT+08:00)
Message-ID: <d0744cb8-be81-4fe7-9416-0af3e51e2db2@rock-chips.com>
Date: Sat, 1 Nov 2025 21:47:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: btool: mkimage: fix Bintoolmkimage.run() method
 docstring
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251029-btool-mkimage-docstring-v1-1-9905a95018cc@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251029-btool-mkimage-docstring-v1-1-9905a95018cc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3facc6f703afkunm182d80b39866c6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE8fVh9KS01ITx9DTB4eSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=B+hCEYcLmp6IOc1DHZBS1dUjDvAQfRCXWt8FWGDk8zARR7oGjIqZ3QVSD13uYtomL4cTloLT5tCWb9vVlCJSD7r7CZD1/f6Wmgk878YJ4uJZTeF2yPRwKaikZdJSWxMxCtyO4nXkDsQ8S9Tu/LV3rduyay9XoAYCfjMiGdgo0Qg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=L0tZKTbG0MMduq0h0J+u6p+2AmgpdDEfmmTDsL0vNtQ=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/10/29 19:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Commit 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
> removed the version argument from the run method but forgot to remove it
> from the method docstring, so let's fix this oversight.
>
> Fixes: 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   tools/binman/btool/mkimage.py | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
> index 3f84220fb1a..23c0a8e490d 100644
> --- a/tools/binman/btool/mkimage.py
> +++ b/tools/binman/btool/mkimage.py
> @@ -35,7 +35,6 @@ class Bintoolmkimage(bintool.Bintool):
>                   signatures
>               align: Bytes to use for alignment of the FIT and its external data
>               keys_dir: Path to directory containing private and encryption keys
> -            version: True to get the mkimage version
>           """
>           args = []
>           if external:
>
> ---
> base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
> change-id: 20251029-btool-mkimage-docstring-998b6322e5a6
>
> Best regards,
