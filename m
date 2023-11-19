Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6571DC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 06:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFF987005;
	Sun, 19 Nov 2023 07:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700375871;
	bh=ylrzZDgPChkdcsP4ip3RxeXTTQi6aUH8BnQxQ6G+3dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+s3ZCc3ZFI5zPavBxZyagrBgfXfYYlgMwRUqjyzWXF68i7yVgp69rOT5AJOB8DOE
	 5zN+44n4MyGgqlmR4IDy/rVaRGGt5AJ9P/BmFSVIizNO93dDK3yXlx/9bu7CKnruKv
	 tCOAxH8G7/uPbtCOb0RjWwlgOcC6ZIuqjungUELIpNd4zH5pHPLOpTt9gH8fG7v4qt
	 wFL+ci9kGgmv2z63Qc59OLdCUBlaHlj5+PDDyxc0DBUjNdQ/0WSB+AQ+vE+mPB8PjB
	 0wGhlCUQ8HVrpTtecUG8HjHqZ9IXmHmiN/QAR4u6za7FUxP2ralVg5V9KCAI/zzhXn
	 iemu/K9EWYSQw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8C8986E65;
 Sun, 19 Nov 2023 07:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700375869;
 bh=ylrzZDgPChkdcsP4ip3RxeXTTQi6aUH8BnQxQ6G+3dw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o/EDlyUDyoNFb0+w11tWG/6eWhHB/C0BQC/RcWw1oQm9FEKHN2Hc8KJsOWVn/5J6h
 ID5n8wasWxNcV3c3E0fXJzdw5JgC0P0fwEaPo5rouWNuLgk7GGtFkVjD37mm1/4IS2
 XQxqAGy7pNLDp+Ux8QOSG8fvRgDQmyxWI/BSLZ5B7O/6wy72jCvvbiRpe1gOjjbqAe
 lCEIA5Ge5rtgI+W80Hkb/vbdcU0oWrfhFb/L2Vi2kgEmMR6LfLSobsW+nQUzs6iMwz
 FEgfTjwBfCSwjnEQ8P/zl+GUnIzXG9ftJoYMkwqc0Rjugrw25+hnrbapPQ3sOJnrDC
 tr3JUpDIkC3rw==
Message-ID: <5ed434eb-3d62-4301-ba50-480f3ebb3f13@denx.de>
Date: Sun, 19 Nov 2023 03:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: fastboot: Add missing newline in pr_err
To: Simon Holesch <simon@holesch.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231119010453.294168-1-simon@holesch.de>
 <20231119010453.294168-2-simon@holesch.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231119010453.294168-2-simon@holesch.de>
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

On 11/19/23 02:04, Simon Holesch wrote:

Please also add missing commit message (can be just the subject copied 
into the body)

> Signed-off-by: Simon Holesch <simon@holesch.de>
> ---
>   drivers/usb/gadget/f_fastboot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 741775a7bc..9f322c9550 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -520,7 +520,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
>   		cmdbuf[req->actual] = '\0';
>   		cmd = fastboot_handle_command(cmdbuf, response);
>   	} else {
> -		pr_err("buffer overflow");
> +		pr_err("buffer overflow\n");
>   		fastboot_fail("buffer overflow", response);
>   	}

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
