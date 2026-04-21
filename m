Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CFEF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D097184353;
	Wed, 22 Apr 2026 00:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X8VoJsym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F0D84353; Wed, 22 Apr 2026 00:51:50 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9124084366
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba92146cc86so277197366b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811908; cv=none;
 d=google.com; s=arc-20240605;
 b=DWUH27xdZ2YbpwKr3Jc0QOI1Ij3twBRdi0pP0LPgTUQImKM6QFE8SpjeI+rQgVLcM9
 EdwoBAIQMUqCuqz6lPTGMQGGEgYodErknevnCoBT5PPO4FNBypTl0H5msnmq539EDnNs
 MTKWv6pFO0bgP1iRVbfojyy0mxf9+Z6b/0ZZWraviiyLRjYFZqhE7BsK03YqEDSf+7fG
 oZEQKMXsB2o74vWcMNf5tVwAmvHJ809aAzmjH1PD8pw/RYcjM7xasWcvOgiJNXOgo/Vm
 vVslYTgavvcqldonyJGz86CEhcLi+QLeJE1LEtKd2J1qsb3qANdvHPuGkHiL4p6EiJ0A
 zZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9bQeLSBqiC8K+iV+sxzTWTy6pJvAJZJSfIj0IDL1Qvw=;
 fh=T79q7iQaKgdBLSTuhvl3jRYD2v6g+8MB8Joags6q2NI=;
 b=T+3ZNXAJy5MrL/waDgYTy6Y0gqFYgScLnpUDmYvl83i+Ic58PqsJ/7p2uXQlf/Ofnm
 KW/h+hFlTszb2Gfiw6JMuiaVUE5ALKlF0f4aqifG30A5EeIpcfF3eRzAY9O2WzSXoIrc
 KNKO7OKEiq9QsHleaC1KXalel5jymDHgxM44q6PbHcKo7HviKpYeeaK8GDi7SahWTqaC
 BhttanmxGvg0HchRNn6rtji3gpDjHL3R4Qtttl9ilE1nkkt0A7wsGFgolaZrlsNu54NA
 4nTgk+W5yzwJ+pTnJR5PlX+6+gcl/EC/Yq5ElmhKZzty8OpivL8xrlouP1XireCnwWLA
 wy6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811908; x=1777416708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9bQeLSBqiC8K+iV+sxzTWTy6pJvAJZJSfIj0IDL1Qvw=;
 b=X8VoJsymtexUf0pwPQKU6tI3lmzwlvsqUZ4exQTbviZMek+Xl+lQ13ZA+E9/9bSDWw
 WEkaVmyZ8ZVWuAaKKw1elz6aON+PHLHUlDBcQPnJlORTh2hHqg3IH3WF8rrnIyNDhBwS
 0+h0O2yEXVYgQD+0hr0X6rnWhh3tgLHAZCdw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811908; x=1777416708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bQeLSBqiC8K+iV+sxzTWTy6pJvAJZJSfIj0IDL1Qvw=;
 b=PjdZniIruVmu/BRyG4GcvsNpmWhEQZm7a8E+ZTuDzvrunRcKxm5cJ/xB1dB+2T7UGU
 yHGpNpuQNVpk8tSrss80RQCMhvDitts0EfuKFY4humxzAdGIa6KMM5wwh9egrO2VzYS6
 ZMQGAa9zRzB7ia5MyTgD16E5Zdtoey/IiYcjUoW7mJe94TSvS8t84CqdycbGHNTPYVqt
 InXOyKAIp9Lamp3l3UmJ3MmDkWp5E+4u6Gu10Y6GBQOvPY8mORCYgH53RZIuj4Nd1g/o
 FF4js8sFROi3vJiURIlLGBnMVIfo7kJvJZ/6gsgkd9kJCTD1g7RDXFGQIBFmLu80gSjU
 OSVw==
X-Gm-Message-State: AOJu0YzttJYl/xUwagewjSzP6to0Q+W+DiuN4cMW6atmjO7cMULCtyML
 BIY74jZfq8VvlNjrmQknYe19TxNyGUtCGY3RtPBq43QZ92r39WPWxxFgevv+e/ueqzR3ZyUeQHt
 Os3iKRGoJtIv1ixjVjdZJs8PA31tusdkCw5CjE2cD
X-Gm-Gg: AeBDieshWH+czOd1/ZpfAekGLdKWV/IP3LwLVA0sJCK8Mp+QGnIgSptf6odVQqsZP+R
 d52/pgIahUSb6vL+1wS+9JxBvA224IDnMNWgQOy5OfnYzI3i2gL4PU6Dt/YY5zCpKuUJA4y1uY4
 pgKgSpt9ZNGdyJIGF0gjLrXwsMiju56nNxh2bnui7dOEPpYgX0NjOkw1/0MYEU5SyPPSUzYLacs
 42WBlxFCCVSo6skNfrUwVkpXgadimTFvHNJqBAze7hUKaW/g5da0yjLRGyhotwbwBLeuWIXYCrh
 YzQGdh9cZAwpU4snHoZc
X-Received: by 2002:a17:907:7ba7:b0:b98:5648:e68a with SMTP id
 a640c23a62f3a-ba41adfb426mr969459166b.36.1776811908014; Tue, 21 Apr 2026
 15:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-5-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-5-eaa81288e393@traverse.com.au>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:51:31 +1200
X-Gm-Features: AQROBzB4V0pmVb07npKC7fTuO5wM30cbPxnzrHtNlkEkgTmkWTojU_y5uRUF00E
Message-ID: <CAFLszTgfrx-7AdHLGAfP5WjUDYwMmLr3htYZ8kOSCPCfPW48pQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] configs: ten64: enable USB_ONBOARD_HUB (USB5744)
 option
To: matt@traverse.com.au
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
>
> Ten64 board revs A through C have a Microchip USB5744
> hub on the board, which must be configured over I2C
> at boot time to become usable.
>
> This function has not been part of the mainline
> U-Boot for this board until now, as a mainline driver
> and device-tree binding is now available for the USB5744.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
>
> configs/ten64_tfa_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
