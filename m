Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA37C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 12:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E9B82DB7;
	Mon, 26 May 2025 14:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VKQVUJI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3DF82DBC; Mon, 26 May 2025 14:17:14 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B1582DA1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 14:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so1419127f8f.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748261831; x=1748866631; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bVe/DM0Dwy5AyWmcxdvlamXI8hes7Y4KgIVZine4BQw=;
 b=VKQVUJI5i5ffGGV63ZvibHKbZLfrYLmqEGepaWfa7EI77/0O2MglAcB2noy/wiI3H7
 hyortpeCQeYm/dQuz9vpzfaamCr0QxF1jK2++RPUeYJnZP12Qxzn//d32WpufjzdMbu0
 QeV5S62lxsT2WF/9hE+ZGpFuPz/zlNBwItmb9ddfPjHDlSRi6ZtkBtkTai1n9Gy6nDag
 9pxtjeqPu67xpttpf3PgzoSRU+GhjwMR0B0BYGjQz1ea5055M4qc92r5KuxEanou9dUY
 eios785ywkxyPMsodRpd+ye68BcRAhgLQZI0wpi1mBYtUWSDuhPQWL9WsEwvbp6uIdwY
 fzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748261831; x=1748866631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVe/DM0Dwy5AyWmcxdvlamXI8hes7Y4KgIVZine4BQw=;
 b=WsCi0MCNXMFppHJlZBolw4FwqtbPNjimFUBkThXIsdBjSOvT9V+6aLCk2kTxc+AdU4
 V1u0NPzWXqEgIYR6YczJXj9LyqHA97fJ00bJjq9r4fABJ8c6Fy78OD9FoI8EbXRrZRY6
 4hR9OdjFJ9/BowwT3gy3FvZccFHqh9wUViDwP2ORErmArJFcVWMp5idIRORa/XElUneW
 23OvkyP2cQm440vmxAjC8TCGZrddve4Ghogg4tUmV/Z7vKLqd1U1N8zoTYKL1n9GvnTK
 cRJ85N8eWzwXWkt6ytczp1zTEtOWfNVZ6T5PMi+0i6RrCaLUyoQdr2sh/1aWFwcpQH7f
 HOwA==
X-Gm-Message-State: AOJu0YzA6HSha8cLeJJiUKbyacUNW0M+/wiqiTzaZeqAJWCbUVRGCkrc
 iDmyTU7qJ+xqaMFT2d4rDQtbPgkwfZQI6nPM/qJ+fUIOHbUTUxWuOeegGwPlhf3FubY=
X-Gm-Gg: ASbGncumbO2Su3Hzm2XasvTNRn9wY2/X5YkC5Vpjj+W8/mMDL+wKR4SVi6CYjNDnzrR
 uJrUPC+5gUAVp2JSqvU7G87snoPOGyrT0g+Y/XUmOg6Y8KWBn7UrCmASmRXvOkWLNWqKHD8vNqv
 2Y6N+zXKN97Xbu3ZtrXfyiVpG+Txa+4iZPa2H3ckEK6suTCHmfR4P+NOAsSy//lUJEze01AHQLq
 mnanJ61IhOHFxgxKVCy8YxQmmknW49aSpqG8vM8SqYot+z6OkIIqrw9CuIhj8T3223EkOpbYg/B
 16j7A7YNB7cxTLPtWry2L+6CyjpKcyBuI2tY8MyZgPWYxznEjCXofYsLmyeBqPQ5xTXniS5NjJO
 l9hBzt+y8cFOtIUgbRbZe/MntIsB2vgU=
X-Google-Smtp-Source: AGHT+IF1+mb1Rw0lK8OTpNo6XoVV73I04IdXeAvV4cErPl3Ay1LhVVwqoNW7XaoIC/r52MBSXTv9Pw==
X-Received: by 2002:a05:6000:2309:b0:3a3:6991:dcbb with SMTP id
 ffacd0b85a97d-3a4cb46149amr7139510f8f.12.1748261831120; 
 Mon, 26 May 2025 05:17:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f0fe:e84f:8d1b:9cf6?
 ([2a01:e0a:3cb:7bb0:f0fe:e84f:8d1b:9cf6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4de9c9853sm678064f8f.27.2025.05.26.05.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:17:10 -0700 (PDT)
Message-ID: <6e667ef9-9fa0-441b-8520-46e7bdbc344a@linaro.org>
Date: Mon, 26 May 2025 14:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lwip tftp not working on imx8mm
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
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

Hi Tim,

On 5/23/25 20:31, Tim Harvey wrote:
> Hi Jerome,
> 
> I've enabled LWIP on imx8mm_venice to see how it's doing and while
> dhcp/dns/ping/wget appear to work great, tftp is broken.
> 
> Enabling LWIP_DEBUG shows the following:
> ip4_input: packet accepted on interface et
> IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY == 0).

Hmmmmm IP_REASSEMBLY should probably default to 1.
> 
> I tried enabling IP_REASSEMBLY in lwip but that seems to change the issue to:
> ip4_input: packet accepted on interface et
> ip4_input:
> IP header:
> +-------------------------------+
> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> +-------------------------------+
> |    10568      |000|       0   | (id, flags, offset)
> +-------------------------------+
> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> +-------------------------------+
> |  172  |   24  |    0  |    2  | (src)
> +-------------------------------+
> |  172  |   24  |   21  |  251  | (dest)
> +-------------------------------+
> ip4_input: p->len 108 p->tot_len 108
> Unsupported transport protocol 1
> 
> Any ideas what the issue is here?

Not really :-/ Does the transfer work with a smaller block size?
(CONFIG_TFTP_BLOCKSIZE, default 1468, try 500 for instance). You could
also enable CONFIG_LWIP_DEBUG_RXTX in order to get a full hex dump of
the messages going into/out of the lwIP stack.

Regards,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
