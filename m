Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A22C0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176D982106;
	Thu, 30 Jan 2025 17:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4068080207; Thu, 30 Jan 2025 14:56:02 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3787D80087
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 14:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primalgamer@gmail.com
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso5867945e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 05:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738245358; x=1738850158;
 h=mime-version:user-agent:content-transfer-encoding:date:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuU3qYFfEqe5bmb8XL19AG5TUjSP3vlTgrxkfIjaqS4=;
 b=RemORcQ2kpKzN6tL5R7A1kfUQBFNsxIQ3qiIDYhsuYPSz8+nBl7AOcr+81o6CQglBT
 lC+bCC8UQexHB0PrwcZGFnWWt93tER24cFsRdJNtxqszGGdUbg4w1UsJCl+kVJe7UCtN
 ZjsbFjkteB7bT+ZJX3JOQLMxC6nf+6l7lt/IPlhh94oSBl4yN5iaKoAhsBFvSVJTHLrK
 ChXyuBB6buvJd2CAnJgVukseP4RNv2B6JVpfnJd6vbi0maShLcjf+MXKucJ8z/HKbr/Y
 z/g1FEOfxnObiTL//x3dOa+5sn7gkLq/lc0+nxwsOz3nqRDukJbcPWbBM78vQjvpEiAN
 koow==
X-Gm-Message-State: AOJu0YzHZxuv5Qio3KH3Ao4bzgPimtHH2Yj3/Ign7i2lSdD7A9MpQj2Q
 3E99frxPZdHRGefUId6QH6g3MgyATA7xfwsGAhvrj4SJduvhSHXcvpSj0g2u0ew=
X-Gm-Gg: ASbGnctttKG0qynZGWaMWi3fanUmmiaHPWCocAXeQjnMNbhDd3gMHctvfvCIqSGdm/r
 rAQ1y6mqTEutlpOHtQ9Upvr1jLGg4EeH0dbEgE37ufxZNwckRG2LqUpLD1b69Q69WPieeeXKNx3
 8K1PvxrbFOyjLfFuK41lUPLxb8/oaCk7qi7ZCwSlMGn1BqwujU+On0Jcqlr3w4nqe+ifulSUaM6
 86jXUwkP32KmzBmYylHIBfBRMKO12tbi+aGibIEQ6cZ0jQh1nQIYfqOuyJUyz9FJCsTTB3aK82s
 2GEZfE/NuhiVhfS7UkeXuImCtRL8+cMcomo=
X-Google-Smtp-Source: AGHT+IH+GiVka/h9IKgPb5riSSEL1OLFMmH7kBomB/+OOQQwhjUlH11giru0eglqdcKP3WFxYsAaMQ==
X-Received: by 2002:a05:600c:1e1b:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-438dc40ffcfmr62106295e9.23.1738245355980; 
 Thu, 30 Jan 2025 05:55:55 -0800 (PST)
Received: from [127.0.0.1] (login04.caesar.elte.hu. [157.181.151.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26b15sm59792595e9.11.2025.01.30.05.55.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 05:55:54 -0800 (PST)
Message-ID: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
Subject: u-boot in restricted environment: networking over serial
From: Ferenc Fejes <fejes@inf.elte.hu>
To: u-boot@lists.denx.de
Date: Thu, 30 Jan 2025 14:55:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1-1+b1 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 30 Jan 2025 17:06:58 +0100
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

Hi,

Is it possible to use the serial port for u-boot networking? For example, g=
iven
a restricted environment where the FIT image is available with ethernet fir=
mware
and drivers, so it is not possible to boot it with DHCP boot since there is=
 no
networking. Or simply the ethernet NIC has no u-boot driver at all. For suc=
h
cases, I assume ymodem is recommended to download and boot the FIT image.

However, experimenting with different images and debugging, it would be mor=
e
convenient if serial could be used as both data and console channel. Is thi=
s
possible?

A simple example:
1. ppp on the host machine, with IP forward, NAT, etc.
2. u-boot establish a ppp connection over serial to the host
3. u-boot starts a netconsole session to the host
4. user can use netconsole and wget to download images

I was thinking of PPP, but that's probably not supported by u-boot. Anythin=
g
similar with RNDIS and USB CDC ACM?

Thanks in advance for any hint!

Best,
Ferenc
