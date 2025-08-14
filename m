Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4CFCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193A283835;
	Thu, 14 Aug 2025 06:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gmgIZiSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4377083844; Thu, 14 Aug 2025 05:21:38 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F638382F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D54321050E9; Thu, 14 Aug 2025 05:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1755141695;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2m18hFTZrJj0mBdaUqzkn4iR2TzEbZ83yCqvU4xbBvg=;
 b=gmgIZiSU63KcEQEkfDuCuhXuf2Okm5TA+3HCtXWBJeTOeefW/12mvDfq3pilwoHUDbz3Si
 RsYzLcwCoOq7wMDBsw5KU3HfPzyY01+sZz5wdKmyycWXSx7wNVcmQnNaHpZkQWVI23Cq3n
 GiMwulDvFjh2OS3MGi3qDVexCMafamOVFEcRSUKynB0FIXUo89VwOu12vt2UG7weNKgJIo
 cqJxiNK7Oz7bvefjO1GEwBI12+j/kbiSzJ2dnSszw7tuvtDlKazvnfsQe06ri10eIS49c6
 8kbUhKMAdXvZSFy/AkFCQO0Ygsqohm1VFbd4mhygcmUe5EmimF0d8dzXD/9wSQ==
Message-ID: <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
Date: Thu, 14 Aug 2025 05:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:34:20 +0200
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

On 8/13/25 6:30 PM, Andrew Goodbody wrote:
> The call to cdns3_gadget_ep_free_request will free priv_req so do the
> call to list_del_init which accesses the memory pointed to by priv_req
> before the free.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/usb/cdns3/gadget.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index a30c40ef80e..9eaf7e40ab6 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -557,10 +557,10 @@ static void cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
>   
>   		trace_cdns3_wa2(priv_ep, "removes eldest request");
>   
> +		list_del_init(&priv_req->list);
>   		kfree(priv_req->request.buf);
>   		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>   					     &priv_req->request);
> -		list_del_init(&priv_req->list);

Shouldn't the kfree() be moved here instead ? 
cdns3_gadget_ep_free_request() also accesses priv_req->request .

>   		--priv_ep->wa2_counter;
>   
>   		if (!chain)
> @@ -1959,10 +1959,10 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>   	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
>   		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
>   
> +		list_del_init(&priv_req->list);
>   		kfree(priv_req->request.buf);
>   		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>   					     &priv_req->request);
> -		list_del_init(&priv_req->list);

DTTO ?
