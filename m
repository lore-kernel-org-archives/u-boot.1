Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE2BC0219F
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 15:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8DF488C0F;
	Sat, 14 Sep 2024 17:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KsukxcXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D03B88C39; Sat, 14 Sep 2024 17:11:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9D7889E2
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 17:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726326690; x=1726931490; i=xypron.glpk@gmx.de;
 bh=8w2fh38WaSPq+WZtTram5l59X0Td/H17Ho0Y5r6boiE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KsukxcXL3NsegwIHnhtJg7p25PSE2fwUJu5cULM/TGci/wX2K8IxqsUyfmao0M16
 PHqpceXLY7QyBxI2RENMXJKAuIo+d1I+L6nQATs6mJbRgC6izUkOlGl5XfFjJgyF4
 VcPYk/ScqsLP1cWt6R9tUrQFIT7ZO1HVSoYFdS4i2N/moikR+SfGXNUO+opAz7p+m
 cvTYmVVRHEIdkD8XR13A1HWsncigz3c5/5Dsz5zYPO8sD+WPX69+2HKpbuMhMx1oR
 8oR9vbYY/XUMtqtve+K4FlwQwGMqxT2WwwU1+YhS9RMESOoQCD2f+0IaCNEvRn/Rb
 tMN+6dYtqsli77Im4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1sgejC2nMO-002azV; Sat, 14
 Sep 2024 17:11:30 +0200
Message-ID: <096933ed-72c2-480e-94a2-5f33b907f427@gmx.de>
Date: Sat, 14 Sep 2024 17:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] lib: Kconfig: add a config symbol for getting lmb
 memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-6-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240905082811.1585467-6-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r+JhBovqZb95fKpBk08cylE5QFPkw3r5FmjfzrcbK8ih/hwsGL6
 vq1eyC3uuV3xMB9+1dMjlYUIuK61X1pEwq57uoHIakQkqCEDA9Y0KmmvXM/piDsc/C+Ktti
 /cBN/dwV6KDeKfo4JXKKteUztS5Eru+mMAU9/rwGZso8X52oV14rkJ7/Wn3GtSuTp4ow0Ji
 l4SlXFbcOBa92EnTEZrRQ==
UI-OutboundReport: notjunk:1;M01:P0:m1bx5FBjJL4=;NMeqRb96wkYZO0kZV5LcdiaIU23
 jzmZBd6okg4cbzShQxfvz60Is8htIp0CRyOZ+HseDd2BCgtQT6z+RUHiGQVVivDwC5zbaPZK3
 CgKPfwIM12CV9cEa2FS1CpDjh4xjyNGu5munPb00FM7VuzG1o3JqhkonyeHqRbbmmsqg8ngca
 Yg+/RYVz1UEaTWyQ3EEdLeBbNk9Wu3Fm81/WHpNi+6Bl3I9WE7DSCh3qIC2dcnfwGal/vbhz9
 idCtl9gSo7PAJeTj6wg5fhMLfiK2vN1drjnoM+nQ3fggtslZS7G9xqwRB40l+EVt3+8k1xejF
 E7mDfOBbV+cdSdSsRy+mOL//4ZMtPFY2FqPLpKd6EwhyWgEp3fyektyxzLyNbnZDG0MWF+Qkn
 rfXS33qSc963P9yYByV+7jpbtzlKJxw2SHsvNBWZ1rxM4bWSn2O42nXAXkmnt/WZHA9euQHCT
 87o5KDFprNT+cfDNzv1p8mIYu6FwaRjZ2qFRlkpDGxIZgfY59cxiwZFPEnH6RkIT4TXQiMqrt
 wxmrtEEGoKzdVovTMNMoBWN9gUd51bQ1HQ0ZW2Z7TEl52TrE7By4g6mQmkkQsPMQW9E915wCY
 8otK5XAFZvIfT4I6k7uF5B4FZJOrEjRluggmkcoAwhYldOWV4zMmAEBTwqaW1DcXI9suhsJ5g
 FIbz9ZEq6fooZP5GMDkMZ1scNhXA1jsJMQvKrzHtbsxubbj5epOaoMlkwWofj6wLo315ovpOu
 H20ER2i+uUVOY69tlUA8BN0Pwremlc2VPUtFEYQypYwC6Zn/gG3hy4SU2sTSD2A24ac4wwQY+
 0Rjs/Dxal9/vRtejgrf0af6Q==
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

On 9/5/24 10:28, Sughosh Ganu wrote:
> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by the LMB module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/Kconfig | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5f282ecb54..2e73cda580 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -74,6 +74,17 @@ config HAVE_PRIVATE_LIBGCC
>   config LIB_UUID
>   	bool
>
> +config MEM_MAP_UPDATE_NOTIFY
> +	bool "Get notified of any changes to the LMB memory map"
> +	depends on LMB && EFI_LOADER
> +	select EVENT
> +	default y
> +	help
> +	  Enable this option to get notification on any changes to the
> +	  memory that is allocated or freed by the LMB module. This will
> +	  allow different modules that allocate memory or maintain a memory
> +	  map to have a synchronous view of available and allocated memory.

We should have only one store for all LMB allocations. They should not
be duplicated in the EFI sub-system.

The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.

Best regards

Heinrich


> +
>   config RANDOM_UUID
>   	bool "GPT Random UUID generation"
>   	select LIB_UUID

