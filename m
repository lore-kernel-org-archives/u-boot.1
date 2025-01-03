Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C0E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 14:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3797801A0;
	Fri,  3 Jan 2025 15:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gFpx/KK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E65880295; Fri,  3 Jan 2025 15:51:26 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA0080196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 15:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735915879; x=1736520679; i=xypron.glpk@gmx.de;
 bh=Cjh8k/x6Wuhf5aHL49gptRAjbOrwOn40rSVFgTINubw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gFpx/KK91o08S7ARJ4TAjXlgGMatlejOePRvKIHwl9Cg4STPE3UeQQLLmipjxdSl
 RVhkDHsz2O+fGKivxYOjKckghDYeNdDbuZ54/UyZSRfbpk8TXVsEciPpRyO+zRqqL
 HEIppfH8SEVpRCIXUoRrr3W5cseC005ha7Dd/99AOEwWcOe5oR2jUl1y1ZIiJj8rc
 jCNGT3NQZOwUm/dcHleKRI1YUeEx0LCcq0W9Ubfh9IhmIhFqzPzQJHGvtMHWxCqwX
 hWFxbAY9wDzKy13ccFqLZeErQB3JLAqAlztiCyKQ6NUzj/vvF8HZWfMxxJ3TUm+zw
 H8yJzzkEE7ECYlHagg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1t27yV1jRk-00Ntz0; Fri, 03
 Jan 2025 15:51:19 +0100
Message-ID: <923dbaf9-47e0-4e48-a0ce-f0afbe32d1b7@gmx.de>
Date: Fri, 3 Jan 2025 15:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/67] x86: Emable meminfo command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250101221003.1944600-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250101221003.1944600-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:glv/0KH450gM/WwYTd4pROqKFPPNWwSYQXyy0CyG5Kf59zx7aHc
 vjHgCysQ8MqbsxCh88eOWaPOtsu/ZFLFL6jEAy3EkIfkGBX+LEvJHGZF9p+Ux6h/+1c3qZb
 tWDPqnqRwuMFzhlxfIza4iejhe2Va9E8F9fsAm3NgvIm974mflpeFhn5SF/ysdFsm/7gj7V
 YWvCRumGyVhPPiv/Vhl5Q==
UI-OutboundReport: notjunk:1;M01:P0:U9g0UbKFYfY=;a95NLDtcwkhi3lR8t24qAnqzbii
 GDEHD2nQ2a/6RqpuIDH4CLvBXzK+6yWaoDrYDIJ+VbqOeCEi0UajMTNXuiSCcD1QyH+p0VU3N
 ovB12MDdslC/5Nbi9qObd+vJBXa7Nrkvt5Bo1em4oIJC3Zw6mAVqlnID7gD5OlxYmf2LIBd0i
 z9Yw8k820sDI4raifKkbd37g3w8tybwSsDlhotnNgh7NwywnEOtWtdEi2pyfGAUWCXzNKc7sp
 2EO6Cq1aSJ2aTmfctfgNXIHtIR5HiUzLY/hCYaq4XKvQ9B+lp9YD+YLT43em8JGlMZyIEfyCi
 GeCk7UVxFHoWp77zpOMPVP8W5bJsuhcA+3+2er1ss89jhV2amDWevAScDnPhfp6KADUn2gnFI
 hxXHR4YFP5NRl86pi5Q7yzNKAoLsabtPrfvI7aBBMTIx9Wqz1x0kO4To4I+hsUoXtVozybUQ1
 p/lC8W5lC9SqxK6k0iI4ALDooH6wfAhWgX+xzLJnlySUAiaOGJG3vCcRAI6zRdixjApdUmqb8
 QAu/DZj4V26oidgnq+/Va15D6jlyHtCr7bSz/DbKd6bxf5S9kABU4+Bj9xBYFybv8zXvMHHK6
 OhKhojgBRdcWsNVWb7nnKXEtEp09dzCbEkQKpOrm2s4zQ1QKDqUkCY/Sb1Yy6w58qA83igRBB
 c6YidnmRqw41zFxZ1x2voDwp7+jvBn0YVYpKY24WZYrIl3iQoiHV4tX9nHJrmX/ODIq7B0SD+
 YAFcCpJI/YS05GJ+nsUwEH72jbEzpb952zCReSXic9jY5hQDF3MmBtnwJnpVa6ErSu7WkW6xD
 nla3PkXLjfrHcllw6GlzIbZp0tYLDroyJqujiti4myZHBJb7j11Zgs+VzY+qWB9Gh0q4QRmUk
 KNbjAsdQT5KdxrNEZGONYoD77ybSS3tmEpCFx+M+WlfK4/NUF3W86TmlQZWoSZogMDWry1nRO
 tOlOvwXPxiTHqkSwO/MBXlBcUk4CrR22FpE215ePAOBrx/+09faXBLprty1fVlNZk+CDrJim0
 JzQAHcgY+buz6VGKUAn3xkS0YlLOTZQgM3YJrlLuYaTqXhRuixtdIOOAoK1aaS7dI7fLtDNep
 xSG/q62Uy7vqFYfD4GwfmRREzaaWZf
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

Nits:
%s/Emable/Enable/

On 01.01.25 23:08, Simon Glass wrote:
> Enable this command for x86 boards as it is quite useful for seeing
> where memory is.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Enabling the option by default for the sandbox in cmd/Kconfig and for
x86 in arch/Kconfig is confusing. Please, use the same approach for all
concerned architectures.

Why do we need symbol CMD_MEMINFO_MAP? The meminfo command is worthless
without it. Both the greeting header and bdinfo already show the memory
size. Can we remove that over-engineering?

Sending standalone patches separately from a bulky patch series would
avoid hesitation to review and merge (see Tom's mail).

Best regards

Heinrich

> ---
>
>   arch/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6258788f53f..2fb247d04b3 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -310,6 +310,8 @@ config X86
>   	imply SYSINFO if GENERATE_SMBIOS_TABLE
>   	imply SYSINFO_SMBIOS if GENERATE_SMBIOS_TABLE
>   	imply TIMESTAMP
> +	imply CMD_MEMINFO
> +	imply CMD_MEMINFO_MAP
>
>   	# Thing to enable for when SPL/TPL are enabled: SPL
>   	imply SPL_DM

