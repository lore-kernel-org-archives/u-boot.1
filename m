Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607D6D73EB2
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568558419D;
	Fri, 30 Jan 2026 03:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GwYIna6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F858418C; Fri, 30 Jan 2026 03:15:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0374840DF
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f2KNw6p14z9tx6;
 Fri, 30 Jan 2026 03:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769739345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJQwXJznmIwmU66tsoqV37aY5nMXJWcIMiieh1jmvy8=;
 b=GwYIna6C9Sn56ogwUyve93zef19h177ng6PJ/24e/7n73JHVjj9ghQ/ZEFQj/smhOS7Oj1
 4+kfjaiaNwuJyu/RtHEJ0WmRxIwSITwMXjLq9Wt0drvBPXvuv7nc6Xck0yjhVo03X98k66
 L5+kL2WpcOKddjhmsrmT60cUjnAzTzvjiJmYG2JKO2JP5P4Vtr0Yiym9V/hgSyiqcpV5LA
 DB8yI4iMPLzepuWlz/5ykG+jiXJMIohrkcCHoxVjsLIxIeOcoTw46IpiBZyn0ewDiKwVQC
 Npl9xPNFyU8Am050UOvpFGIRQ5nuhNlt4sDSm/hevCBtKd4hs+TakjKyDW1Oag==
Message-ID: <5c40feac-3157-4014-b16f-923abd136f33@mailbox.org>
Date: Fri, 30 Jan 2026 02:29:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] usb: eth: asix88179: Refactor asix_send_common() to
 closer match Linux
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
References: <20260130002941.2336252-1-jonas@kwiboo.se>
 <20260130002941.2336252-5-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130002941.2336252-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: c68uux9yc6peuhjx6ngj4uu87w65kpdf
X-MBO-RS-ID: b52ca68ad3f76201dc8
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

On 1/30/26 1:29 AM, Jonas Karlman wrote:
> Refactor asix_send_common() to closer match the Linux variant.
> 
> This change has no intended functional change, it only makes the code
> closer match the Linux ASIX AX88xxx driver.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/usb/eth/asix88179.c | 43 +++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 7d7cdeb60ebf..a9dff23e83bb 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -487,40 +487,31 @@ static int asix_send_common(struct ueth_data *dev,
>   			    struct asix_private *dev_priv,
>   			    void *packet, int length)
>   {
> -	int err;
> -	u32 packet_len, tx_hdr2;
> -	int actual_len, framesize;
> -	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, msg,
> -				 PKTSIZE + (2 * sizeof(packet_len)));
> +	u32 tx_hdr1, tx_hdr2;
> +	int actual_len, ret;
> +	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, msg, PKTSIZE + 8);
Please at least add a code comment about what this 8 means, it was clear 
from the previous sizeof() use, now it is a magic number.
