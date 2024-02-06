Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB2C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 13:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BD087CAE;
	Tue,  6 Feb 2024 14:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="EPhjj4C/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF55787C78; Tue,  6 Feb 2024 13:21:08 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by phobos.denx.de (Postfix) with ESMTP id D44BB87C68
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jhb_ee@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=CjIwduATYcg5drMpZPGeJgC5vjLS24UZL0hwWzqcnUo=;
 b=EPhjj4C/6LYmQk+a/uDvzb82WZFcPJaOT6m29vB9aeZFvSJ2uvwL665eqR5mO3
 KgKJ35UkRADZWMM3oXXbP1cDdxFOrTfMaB4Bn4VZQnlFmnkoUtG3v8gfbgVLnjnz
 kgnfBrcCLc1YOIdF/zUviZY7MKwzOcKvSqoOYMN0f2yY4=
Received: from [172.20.10.7] (unknown [36.102.133.29])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDn79wTJMJlUf1IBA--.9792S2; 
 Tue, 06 Feb 2024 20:20:36 +0800 (CST)
Message-ID: <93dab8b5-52dc-42b2-a370-8071ef28e697@163.com>
Date: Tue, 6 Feb 2024 20:20:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xyzModem: Correct xmodem blk verification conditions
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20240206024925.16325-1-jhb_ee@163.com>
From: jihongbin <jhb_ee@163.com>
In-Reply-To: <20240206024925.16325-1-jhb_ee@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn79wTJMJlUf1IBA--.9792S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDtrWxWFyxtr48XF43Wrg_yoW3CrXEgF
 y8ur17tw4I9Fsakw4xZr4fZrW8J34kGr18Gw1DAry5KryUZFsxJwn5Jrn5WF40g3W7ZrW3
 Wan8tws5Cr1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_PEf5UUUUU==
X-Originating-IP: [36.102.133.29]
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiYQ58fGV4G7OJ6QACs4
X-Mailman-Approved-At: Tue, 06 Feb 2024 14:56:52 +0100
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

This is a duplicate, please ignore

在 2024/2/6 10:49, Hongbin Ji 写道:
> When the blk sequence number is 255 and cblk is 0, the original XOR condition
> produces a result of 0,and the judgment condition will be unsuccessful.
>
> Signed-off-by: Hongbin Ji <jhb_ee@163.com>
> ---
>   common/xyzModem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/xyzModem.c b/common/xyzModem.c
> index fb319f7119..0bc1a87067 100644
> --- a/common/xyzModem.c
> +++ b/common/xyzModem.c
> @@ -373,7 +373,7 @@ xyzModem_get_hdr (void)
>       }
>     ZM_DEBUG (zm_dump (__LINE__));
>     /* Validate the message */
> -  if ((xyz.blk ^ xyz.cblk) != (unsigned char) 0xFF)
> +  if (~xyz.blk != xyz.cblk)
>       {
>         ZM_DEBUG (zm_dprintf
>   		("Framing error - blk: %x/%x/%x\n", xyz.blk, xyz.cblk,

