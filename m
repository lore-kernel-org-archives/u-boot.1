Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E9C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8066A81FEE;
	Fri,  6 Jun 2025 21:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afxz4a0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0966882977; Fri,  6 Jun 2025 21:54:58 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 996C181F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso1615496f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749239695; x=1749844495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FCQKDFaEtVrHJkIrhvKUGtKIqxehI1I6I838fAbY+fw=;
 b=afxz4a0umK9s/wmwRybBKieldmb8/FQxed9nBkk//EjTAO1Vnq/TmvCY8OkwI9E/Ft
 a64CTP17XVeknp4jEhHM/PGifbVecvwkrPsWrg0srBOyGk7cIZ3vYoybnqcETGUOF1Zt
 tq+93GsTi8BsbqHffhXkE3/eiLfRkE2HYctlrZCEs+ddjE2HI+2pbX7XFtOA4LfmAfbG
 l1i9Kxr4Yn7Cq0L0oem0CDyZBs+yJn9v489oviwW1eGp40cP/imRSyoY6ULTnIg0sVk4
 54yzcTwmcOdqrOxhviu6OnPbTVnxO/N2OP3GicGlDEvFC0GBnOiiliwlG8IDVJaMm30O
 iirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749239695; x=1749844495;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCQKDFaEtVrHJkIrhvKUGtKIqxehI1I6I838fAbY+fw=;
 b=cvvhBuGL9cxCn8lan92LjX9pVL2w1eYkfOg45VTFpTG6nrmJX4JDIXGQadY/9SAJgo
 aWe3+Z1ubYnl5vzDv41UymMBaZTU6gfX8VY0vBR3QOPyCFDVcxudelgiznuq/M+aePJH
 KRE4QXyyL9Lf2y5TwWAaeLN25TkEjSXJEk6i3QCK0m2qMTkbDOEemzF4fSS0Frc9Xtqx
 YdjnqfVUTLbhfYChaoO0IkLDID4WF9E2YNjoQB7Eh+VmRX2elEax4XNZq7mHxXIR8SUw
 n8GDiRY2+YZti00eD9wJNhxDKzHlHdYBFQJoiWgz0kJsxqcuLS8WiNKCCSrT0HzfMMsS
 DAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX25KfmO5EBgoAe49H5AjniOHqejvvHB86fiL8cM755t2B6CEJaAJhSk9qI16NQpkcX0TP5cxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxufMDsiPFN1y4bG0mzaSydbQ2Y6Mcn78zsC9eo4rqk/OWpD7qy
 qGzjYP+rY7XlhcSdxfT+mmpKIdezRYJSvtG/ASUt+VXmaliTwQg321Kd
X-Gm-Gg: ASbGnctztRKOp5Ph4kn09RSLuT+GXjX3EMCp6vMgcShcZNXBEYxQTwtuUmzKMAVKQ8f
 c48qBA8CNvknC53MBABW8PqtefOJoIUXXAP7nPod8to9poalLvQVZkzQ9LJpjCIjxYgY5OWF+XO
 1U72AK+J/2nJqz6XkxSMty1WNiiygOKKLZs1Fg2k2YTsh5SbfQt/1eLSYNJV6pWDv/HJxdD2CBm
 RVEtxN+ZJMS+wt6fpqZGULK3m/8E0QfQ/2LQxgKQu2Pjk9I7d9IyUs9kkAHboPKA5/4A85SDXEO
 Ot9RIB7ScvE//ndqYOiTLk9enBS/d+mNlpDQ8pi1cfekgsQUo53OAgtlufPVvF3VuoCms8K2S/V
 6wS5u7AoedP633HHN9w==
X-Google-Smtp-Source: AGHT+IEageFfnYfynxm9P4U9m+trdv/hYTyqPze7Oh5CMsrw+yMdhgPpjKZitMyRu0iM0W1Vr1XZzQ==
X-Received: by 2002:a05:6000:40c7:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3a531cbed5fmr4495355f8f.35.1749239694939; 
 Fri, 06 Jun 2025 12:54:54 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f8275640sm53644225e9.0.2025.06.06.12.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:54:53 -0700 (PDT)
Message-ID: <6843478d.050a0220.6e23a.5ec5@mx.google.com>
X-Google-Original-Message-ID: <aENHi9IM7auojfqE@Ansuel-XPS.>
Date: Fri, 6 Jun 2025 21:54:51 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] drivers/net/airoha_eth: add missed terminator for
 compatible devices list
References: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606194903.459732-2-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606194903.459732-2-mikhail.kshevetskiy@iopsys.eu>
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

On Fri, Jun 06, 2025 at 10:49:01PM +0300, Mikhail Kshevetskiy wrote:
> list must be terminated
>

Nitpick, please write a more detailed description. Also title use
"missing".

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/net/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
> index 7e35e1fd41d..86fd1616da2 100644
> --- a/drivers/net/airoha_eth.c
> +++ b/drivers/net/airoha_eth.c
> @@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
>  
>  static const struct udevice_id airoha_eth_ids[] = {
>  	{ .compatible = "airoha,en7581-eth" },
> +	{}

personal taste since you have to fix for the commit description
"{ }" (with space)

>  };
>  
>  static const struct eth_ops airoha_eth_ops = {
> -- 
> 2.47.2
> 

-- 
	Ansuel
