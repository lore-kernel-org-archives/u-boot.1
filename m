Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB7E6688E
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 22:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24B989406;
	Sat, 23 Nov 2024 23:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732401265;
	bh=dgmy7ZKWAl8GS26Tqm+diNyHmplacm18GlxI+/InolY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVzza9CRdwgraIMooRRXYXa3rSeHZGRbLot7t0+vR4ozXxeR7Lt7yl+xABqrJ9h/E
	 ujv0IdJg82tT9aw6N8eFK6+9kFUfUGNQcPo2OLtrsiUzs6GtC9lILumDcDAukz++/g
	 CjVJt+4b6MnSSVcIEA9jQN2nNTZn99datV3AZV1QYxFkqZzDjF0O9lWuSJnyPkoe1G
	 s3VM5TfY633M2l4E/FOMjevk7HtLC55Yo1HVREoYn2dffsJrt9JHKkA6fxsyU7UIJL
	 0pl2PtCDXWZV6sETqTjzDLMZZdcbVXlFTkLGgNGreA9r5afX3cOq0Cb1TGNJJ9Lxeg
	 Qv+1UHZy6bsiw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 91E5A8934F;
 Sat, 23 Nov 2024 23:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732401264;
 bh=dgmy7ZKWAl8GS26Tqm+diNyHmplacm18GlxI+/InolY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T8oVWUL8huk0h8zxOrtyZ4n/qUEVyn+brhiBJAH77xruassFZACrIrXEh+V4GU57B
 qUAc5DYKAFG8xJz1UPx7XGwFEdjjnQN6PFc0lK58cwcXygih/6CxOugEQjh3+kYQN1
 bsQq5dvXwU8hcd0LECbcGerIe9f/XTr1YmhUJhyMmQJLhJDFuGJkH7ynSaOk4L6TTT
 cGPIwTYl5UjKSASqj/Seos/8S8ZPXrfrPLDzoNR4OC9jAQ0q16CFvrj0GsY9S3FSKQ
 hc+/HhGmv0ZrAR09ZPuYwYWOgfKTyX7DT0ydCW2dfOqdz4lV9oGLTrwWzDRDPywQuh
 fxkM8r+0zMj5A==
Message-ID: <d1e02e6d-d5e4-4323-835c-d505cbaa6dfa@denx.de>
Date: Sat, 23 Nov 2024 20:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] eth: asix88179: packet drop when receiving large
 fragmented packets
To: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241108055136.50701-1-admin@khoahoang.com>
 <20241108055136.50701-3-admin@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241108055136.50701-3-admin@khoahoang.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/8/24 6:51 AM, Khoa Hoang wrote:
> The ASIX 88179A drops packets when receiving fragmented packets larger
> than the MTU size due to an insufficient URB buffer size. This change
> synchronizes the URB buffer size with the configuration used in the
> Linux kernel, resolving the packet drop issue.
> 
> To reproduce the issue, set the following configuration:
>      CONFIG_IP_DEFRAG=y
>      CONFIG_TFTP_BLOCKSIZE=16352
> 
> Then, run the `tftp` command. It will fail with a timeout error:
> 
>      U-Boot> tftp zero.bin
>      Using ax88179_eth device
>      TFTP from server 10.0.0.196; our IP address is 10.0.0.18
>      Filename 'zero.bin'
>      Load address: 0x10000000
>      Loading: T T T T T T T T T T T
>      Retry count exceeded; starting again
> 
> Signed-off-by: Khoa Hoang <admin@khoahoang.com>
> ---
>   drivers/usb/eth/asix88179.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
