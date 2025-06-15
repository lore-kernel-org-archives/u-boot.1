Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5680C71135
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 18:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC1082CD2;
	Sun, 15 Jun 2025 20:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RBSZZQuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBED282C87; Sun, 15 Jun 2025 20:02:25 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C2081E06
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 20:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73a01a7bee7so1085225a34.1
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750010542; x=1750615342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NAf+pWHD/907Q5yjrQ53KJP0aEuXui5DUMo4ykwRbb8=;
 b=RBSZZQuMRtAhXSbJ9A1i/TzkayL/WDYcVe390+rNSzALtsfzaSxJfrLQQf8xuEnse5
 TVJ0ilo9R91VzljMuwNRxpQvk8V1WSqD4i+wAq0FuhINI0KCtmVYSjRSn1IdJX2z1/d4
 sV5szaWnDcLoKZqFKhP+5j3zLCrbsQfdKEnK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750010542; x=1750615342;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAf+pWHD/907Q5yjrQ53KJP0aEuXui5DUMo4ykwRbb8=;
 b=V9MdT0wM1Vngd5bso+ot/+L1W7RnLfpC5GqJVh+cSlSSPYs5E62isuEItGTXBhslYF
 icBZDfMWOJ3i+zHGPKZL2E2OQfQzS7ps85e/Ud3l9rJDEamm3f6rD22J2HNCtMBbAtcN
 rVV5mEJi+jR2jt3cHtyzxxLslwZdkxA3zY6KtvzXBWx4kdIQP7/tazP9HlycO7rwM6CT
 XYiXLPamBC6e4+1MGeU553KI8Ynx1SZTZMiYf89YgqxeDC3lAo3DuEJQCSJL5AI12R1N
 ydAyRYMhR2ibPR9ZM7oxLQ8xexDkHBAWzuXxVpnvOeC2q/biGi/gp0yVWgWEQDpYIRW8
 KwZg==
X-Gm-Message-State: AOJu0YxBNZRqrlI6NFh7cU1fQ7PHkbzow+qNT4hUIsq5KAVJ+PB9Utrm
 3mHCcuah5ZEb88u8eR/UJYoMThFohzuZRrAB6DIsklJGRUj7MUNhHilydB9YLP/wpj0=
X-Gm-Gg: ASbGnctzcWB1Wq6cP0Pps51tyYfLxJPHJ0fuC9W/T5GtoF6VtrqYmUHXFB6kg2VtGYd
 mENd/TVI5xfiXmEbAX7K7df4lQfj/mlw4YIvAKLQ2HEzrjYoxHAArQBfJqdBpVgm3a0dC+1/Akz
 hv+NL9bp5zLGi8ru8nNs/W+0xGQXyW2xOIdTEGnyfBTcnbpJhMx02LdV34yQqn79I22e3cz/1LZ
 Yprxtz2EHmaqU6hGGu/38asHDdCjEiXXMpvHjK1h9P0PF6l2xLujZm8+rhB0t2BhpeAU1TtehrO
 xN4tBJ1d65DkQyFm6mGsds9iWVmdkH0keFpd2iCP3+BxxDBW72aD1MCgmXL4bIIp6N3lZlHWr1k
 dJts2tKAy3j3srw09AB7vyg==
X-Google-Smtp-Source: AGHT+IHJwKifshShp9A9A4b6roWPcpYN3jKCYUxs1c1SuvlFGSry75YsalaQgT9k85qX/VSgOOjS1w==
X-Received: by 2002:a05:6830:3818:b0:735:22:7cad with SMTP id
 46e09a7af769-73a3628b22dmr4684954a34.11.1750010542286; 
 Sun, 15 Jun 2025 11:02:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d785a6sm728761eaf.1.2025.06.15.11.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 11:02:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9M_g9JSqZLbOv3Zh-HrDnnvOw1pA8Ky7opOBbL8DTZNiw@mail.gmail.com>
References: <CALeDE9M_g9JSqZLbOv3Zh-HrDnnvOw1pA8Ky7opOBbL8DTZNiw@mail.gmail.com>
Subject: Re: [GIT PULL] rpi: updates for v2025.07-rc5
Message-Id: <175001054128.1130810.1862848163082063866.b4-ty@konsulko.com>
Date: Sun, 15 Jun 2025 12:02:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 15 Jun 2025 13:24:44 +0100, Peter Robinson wrote:

> The following changes since commit:
> d7c449c3d83a986d61e38d1762433c0607caf5c5
> 
>    Prepare v2025.07-rc4
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2025.07-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


