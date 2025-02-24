Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF048C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346F9805C4;
	Mon, 24 Feb 2025 10:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VTDbPM14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0055880079; Mon, 24 Feb 2025 10:21:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F163380017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740388856; x=1740993656; i=xypron.glpk@gmx.de;
 bh=tQ85mImnUNXVCMbCYR/UqoqxOmRs+JPSbrqMfwTWBbs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VTDbPM14h5gpe3v7hrghAVmq3REIibvIg6cT5P/YaS6BkUbQNucmhtORsp109mKH
 FogtC19qgbZLEPI6jeHXfvkhZ+LlfXECGok5mwzHdtdQLjGYevrOfQawDV689OR2x
 pR1hQeuN7IrW/L1kG3pIoXjilLP/5vbXCjEA9HCCV+EJ0gX1hXlWYDBAuDwjJb2zU
 2xeFjOh0i9uPf04cX2MZpwbO8d8W7kEQjvLvWB0wmiomT+wLrwrESbANa1sxmtMTL
 EzRoag8WLFVcZ1pB3sC7O7oWXx1/6l1iKs/a2q66z9X1NsxivcVbxF805kdvTiFCl
 JGt0tvBb3fGLS1BCCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1tZW4P1aAz-000QF0; Mon, 24
 Feb 2025 10:20:56 +0100
Message-ID: <f1b5ee80-1f28-4cdd-a56a-c04873988af2@gmx.de>
Date: Mon, 24 Feb 2025 10:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] makefile: Add READELF command variable
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-15-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-15-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:guyofQPPqBjreedFjjdtvuZ4XMzDAxiKoSMV84kT1vt51jvvDB2
 BVkVWNQ0op8WZcHZYYdFspm83Q2Jc2xxZL73zp7Z9ale9UlxOy5XR+5mI7e/htf9jtC9IVf
 a9Vpo59fhFrpS0WGTePwOHfdCvDleqWjBGpof+1NkowEHHN99Uw0MsJpvs0DR89lLYgbtKF
 17gC+Jpr2LBiB8OOcdmJA==
UI-OutboundReport: notjunk:1;M01:P0:YiFJY3r2rUI=;Z0R4PQg05zn7M6c8otfAzT6yh3v
 a56g6czLMgT0PQBjti7r8ld86rn4dqg1f2X5Ooz7Vy/WXl9oXj7KzKGQNLIVhcrFCk1tQVjAZ
 tXvi49y7wr3yXT6MgWrAUpSl05ewcemgoKzOTzdzh+OHonVGucBwS20fEZRHm8Bzj4/VuHFpN
 rBrF3hJj29IuXi4U0jZUObH8c+D0J6EPztziocAGhn8Wqdqp3Ns1tXllHt8W5ES6lMih4VnjZ
 qC9zeYvdR+kPjY0yuNWEw0uKkOVwi6XZOd+p36W7/6fsoY8MPVo66YCmRGSMRoSZPtoakVFG9
 2l6unECQiTQdewQ7XJGF9tjvp80Sbauv4/0U5ltDE41qCd+ZxU3ENd54m+Nc2yt+6STc1KT4K
 /iH9CoG7i7+EzpLH2224zIelYCq44HZh3GBumCdhijA3y15hZaoLyMqOr7dJ+j782A0KOWb+G
 39um/g9vNnkPBqmHeRGmC+dzQSB3y3sL65UhC3/JKeIEtWMeaiboDIUGu3vcO4qgu1jn+92MQ
 r/6aunldWc0k7/KN37fvgtrxXRIEhHon+wg5Pn9j5zfGSRthOx1PBqtGDkL1lho0gPEy39gOH
 sQ8a88kRaxAt+iseBnK1IzxP76gCKDK3YQiHbLd0qLfJCObkacI5HeMmfqM+NlaJNLBVLOXr1
 tRzKPP7fjF+hOXod/LvxG0M6Sb/sbiVTpvDYVpf7dd6LYpENfl+DYSYx9ackY3w+JHWZMy7Ed
 MYs3Pu+WZ3fKNwV++obPy4tcu39NXg6UZGCfKJ5ti0CxIFfXhTUqu0ZxFpueKgeUyqZ/yu6RK
 C1JplwCLa4Jn5fhhSe9CVwHpjw0krWbpfrU+sDkb/kkHhO1nhDS14N1aN7NEGZ2LQWsbS+ZOV
 Tp6DVD5K4R8BeEDZwtuKh8z2WfKXmKwk6PwD+EptsbyN7o1aowzvXZnP58fccHMAlT+lsf94V
 wi8A6qCrhnKied7CqnLOXd5bspiGuV+obmOAMRv7HTPS7HqdGeUjqeznBSXzqObV/vnkxSHQ1
 e/Ur5zexwYPytn3cAkjWXm/HN3TuDFmwKqwRXgSpmKoatr9oV+poOnYEi8/hA7/iNEJ5VoU91
 hFzhf83qV0/60QBhTq5abPi07zJlCFmw68owbzlSKcbbFa3lY+bsnLMSPocPPCxOmP03We0/Y
 YcI8laXgoZmhBJ01ZUKgri82qBabiE4G12/LRtdSsVWkA1LQ1Gdm+5PnIIhSUlI2Td0IDTKow
 +dhp0uuQ69VwLP71nTu/ybXJEtmTdjjoaYUGy/KLyN+vPUwOp+j+zaTU0HKjxBTI3t38LIOSR
 HGwgHm6FGczb4AUjO815jHt8cpo7AcwoKbD/X3SGj/KysmnBD5W9vatnZLssjgVplcScI90Q/
 Qi2d78iql0iG7bHEqHQWX5tvo4N+Hfqsh0u2kIyiL0b4fc9eqjf0Pdx0R7
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
> This allows setting READELF=3Dllvm-readelf in order to use the LLVM
> version of the readelf utility. It also aligns with the practice of not
> using $(CROSS_COMPILE) in any build recipes directly, reducing the
> number of places where $(CROSS_COMPILE) is used.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c869b5c55fa..c1749e78d6f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -406,6 +406,7 @@ LDR		=3D $(CROSS_COMPILE)ldr
>   STRIP		=3D $(CROSS_COMPILE)strip
>   OBJCOPY		=3D $(CROSS_COMPILE)objcopy
>   OBJDUMP		=3D $(CROSS_COMPILE)objdump
> +READELF		=3D $(CROSS_COMPILE)readelf
>   LEX		=3D flex
>   YACC		=3D bison
>   AWK		=3D awk
> @@ -2177,7 +2178,7 @@ System.map:	u-boot
>   # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>   # R_AARCH64_RELATIVE (64-bit).
>   checkarmreloc: u-boot
> -	@RELOC=3D"`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> +	@RELOC=3D"`$(READELF) -r -W $< | cut -d ' ' -f 4 | \
>   		grep R_A | sort -u`"; \
>   	if test "$$RELOC" !=3D "R_ARM_RELATIVE" -a \
>   		 "$$RELOC" !=3D "R_AARCH64_RELATIVE"; then \

