Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D6C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 08:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8174280079;
	Mon, 24 Feb 2025 09:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="T3zrGq/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6881F805C3; Mon, 24 Feb 2025 09:55:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5570280017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740387298; x=1740992098; i=xypron.glpk@gmx.de;
 bh=7ekGPhYxWJ9NBCWS1P9U200q491AlHCmCiPZub03JnM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T3zrGq/TU1ZxdE+RPNF3jO6nG5hr8fLS1Y3ykHC+plUglxy0GCS08aCuCajq4si+
 t2r9m6PZ/yps8M6IZhBS5z8sbVfJYSIeZ0BC6DQp+32a1Jv8zCNn1/+pHg7i95aBB
 oYDSApP+bXBcIZmWoD/IbBZIzaoxYLlp1UyH3PPZmGsgQrdmkaiWSZEPcqYtj4hNa
 ISUTUe+3qz0gN1Nc2waAzppQkY56Ag7QUK3nnhY6KKgSl1LR9N428a0yLtaxujUar
 6fqaTBEuLzU85jemUpZPWGpy5o3dq31GsuIx1MTpblUH0oupdhLgQwcluS02x9rlP
 P4nPC+wO+TRWniGqoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1twRzC2hW0-00TwCh; Mon, 24
 Feb 2025 09:54:58 +0100
Message-ID: <3382d476-c1b3-461a-b8f0-c47cccb6899d@gmx.de>
Date: Mon, 24 Feb 2025 09:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] spl: riscv: opensbi: Error on misaligned FDT
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-10-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-10-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O2kl+oCwllF+6T+KvZGCaeDI4laDYal4tTyW9lpjWXIraLD9t1R
 It+VouSsm4L/9snw138352Tn5Q1yGPEDvhJa0eaqb4GWQxAfYeXxakWQuXaTbYHvOOPC+sm
 FM4RXpQW+zm7ZSejhImd7K1e/wubVUXYGhytCkjYUkxFyLynWC3GQKASsiLEY05CuC2BPGd
 /JJBhd6q6r4MCalT5Y7Bg==
UI-OutboundReport: notjunk:1;M01:P0:XfQMf55iW9Q=;Eu/xfKgZpmB1wHDZtzuTeZlw3gx
 bpAkf/EwHo41zvZtTS3uNASgWWTjsILup2xFeJNXJEM86UVSF7J0IR9ect2my0X8NEeKUIq4H
 +FZSifvKZznYBsrDqelZesZMGzMchZ8jW1Ftser+Vya2A2gNgmZrGD0SFMYFCGkeX4U7R4fnz
 F0r5cq0ZSI2BEpGxkTSms8EB6foUs76NfxtD4wl7L72eEyG93VYTVcOY1jHMm6XvIveVnrhn5
 YQ65cPbF5Zp8EFMbBCk179jDPGE8w+vEDOo4gliNtI78QSLrRxQqtvMvYW6xvSFYHndTD/tZo
 BWcoDsW58y3pCAxQWFRIPZmJf6z2L1QJe1Pp4gzUeBD7BYFQID83psaGRZEaI7vQa2TBz+IVY
 lEAze5UBPe6yoTg8+1XbJVOZkH/G44fiTNEPJ5xnsVlDB8PwjPCn4Xov9MSFvT36QyAfoCYfz
 vD++1GJLtW9b70Khe0VdKxVyepAmMRItl31USkVD4FPzWUdxyN5OhJaEWZgTmlr9MixBcIJEJ
 OsiyDFhlgWZlHu3dIeuhfoYfVMGKlbOljuK0OKImfHcgoLW9sRDOMFXQvQXkYvABMxN1gKs8b
 bNgpxYO7eWpWuyV7Lr96XNppa6S7NyAcWy7sfcxaar61G0gwgoHOoCUGxEBgICHB/w3aJN0Di
 HNS90EEjeE9PzRcBG30wSWe2CP7JvennhyKvmY5EdoMi7Z6VfgMctRvVDg0RJopZYaR1jZjAo
 jIgnyIHgAq682cKlIPF1hyznhbtC/8UYRZ/R5XMTmAtnULBf9e0OfH3QJyEGx1J7EWBgyQ2q2
 ErgkvhcZY0xOP5DAIqrQYxNpaybNVIZu2zsCfiY5NyS2lsb0tindyNk0PDVJD/tDsBXoObwwd
 nyb592sDO5x+wcgQ4Go89hMSn6BKV3sceyrsI+5K/SRc+NCXsYlzCRqiJV5QForJISKL+o0IR
 qTG0FMh6G3Ii9dXkhwE0YJiN5js68f7HV79JuiHT6zkKMHNZ2Q4W1eKYE+8e/4sgMqV64A9Na
 4/wI4AKaPOYxUxb2V4CmrhZmA7I8GBDeRpIU5O/d18v1TYn1MqF1vd6VPzDJZoL8eCMGBps0C
 uc5vKcVBv+D4Cr7nVX+jvohwLQga4wFedILr6/OzNjbgvaNfsR3DaF4kDV7MvTc9CN+8X/oFL
 DFxa+l7pRJtkmlMxkhybNqCFlVmjPSzDlc4wYqwsK0uWCboTKtwI2qW8+HnrgpUXx+e2Sd/KC
 KcQGdeKeAIwcf172eGbt/mpUKIp3FCO/W62WoQpCBDzrrL1xhLSK2R9X6UVpU84ggGlwkC7U+
 exVthN66zvHKByXoy6yYwwps6ftcow/miBdb6WbfxacVlDbiOugUMkhosZzgvI6C9TMtxTqxg
 7xgGRE9ixMVEnGk3uXk9LZlYZj3yAPEQkeQgUk/y9wRWeAhTViC35/2vsE
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

On 2/24/25 06:55, Sam Edwards wrote:
> libfdt 1.6.1+ requires the FDT to be 8-byte aligned and returns an error
> if not. OpenSBI 1.0+ includes this version of libfdt and will also
> reject misaligned FDTs.
>
> However, OpenSBI cannot indicate the error to the user: since it cannot
> access the serial console, it can only silently hang. This can be very
> difficult to diagnose without proper debugging facilities. Therefore,
> give the U-Boot SPL, which *can* print error messages, an additional
> check for proper FDT alignment.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   common/spl/spl_opensbi.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
> index 5a26d7c31a4..0ed6afeacc6 100644
> --- a/common/spl/spl_opensbi.c
> +++ b/common/spl/spl_opensbi.c
> @@ -57,6 +57,11 @@ void __noreturn spl_invoke_opensbi(struct spl_image_i=
nfo *spl_image)
>   		hang();
>   	}
>
> +	if (!IS_ALIGNED((uintptr_t)spl_image->fdt_addr, 8)) {
> +		pr_err("SPL image loaded an improperly-aligned device tree\n");

We only use pr_err() in drivers when we copy code from Linux. Otherwise
use log_err().

As this code is for RISC-V, this patch should have been sent to the
RISC-V maintainers.

cc: Leo, Rick

SPL size is very restricted on boards where it is responsible for
initializing DRAM and therefore has to fit into cache. We should only
add code that is strictly needed to SPL.

What makes you think that this problem can realistically occur?

Best regards

Heinrich

> +		hang();
> +	}
> +
>   	/*
>   	 * Originally, u-boot-spl will place DTB directly after the kernel,
>   	 * but the size of the kernel did not include the BSS section, which

