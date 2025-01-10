Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB42E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 11:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14DBF801F5;
	Fri, 10 Jan 2025 12:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fQVlagnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A388036B; Fri, 10 Jan 2025 12:55:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D0B800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 12:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736510116; x=1737114916; i=xypron.glpk@gmx.de;
 bh=QNU9MXVT8ACXDZ26Fr4STB+pDewxi1nCDv7TAoAPXkw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fQVlagnUJctLQZE+RbqWl3x6yN68IeW8SUNxtK8sUVLboIAcCdn1E3kt3YisF1p8
 oMMMxiUrJ2DEyLgLlQUatHOvI8UiaVI9yEAfCtJlLUaGA2L4xbsKhQNN0hjjZxuCp
 pZIsXYSpBc5sgIKNUDeTFWg2zcg9XA2cd7tV6TRe6cgqYGTQ6fflzlr6uqnGBX2sC
 JdRCp2kqEmq1fxdhk02X9E53/+6Y07hTQeBVgS5z4Ly9ihbVsAJpCQuj5lPhsqwv8
 SxETpKPo5trxXiF6GnWC4AEfpbKTd9Wh/AZgrEIuTI4UYP4khy53iABB0qooQbx9S
 62wvYvjP+LWm/D+3BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1tAgMR0kWx-00ZXIC; Fri, 10
 Jan 2025 12:55:16 +0100
Message-ID: <977fc27a-3a5f-4e11-b81c-4e18569b083a@gmx.de>
Date: Fri, 10 Jan 2025 12:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: Add a default cache line size for RISC-V
To: Yu-Chien Peter Lin <peter.lin@sifive.com>
References: <20250110085308.20760-1-peter.lin@sifive.com>
Content-Language: en-US
Cc: zong.li@sifive.com, greentime.hu@sifive.com, ycliang@andestech.com,
 trini@konsulko.com, sjg@chromium.org, jiaxun.yang@flygoat.com,
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250110085308.20760-1-peter.lin@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIhftMb4Yoa1Igd7V2DUUyeCjX836Xbic7HYSsK9irazblpCB8M
 upZjvabbAy/83rfDL0NjZBT7rH/cidI7weJFV/7Rd5IZQCGil6FFbVDcPZDapBrnkz8sPfb
 P3Qym052EihTwgWCH0/kB8QcOe9mNVxwRxpjPttL1CWDKDcTNnCa5cvZtKwVLAOIXj9ihdV
 gHxskXJwBXn/rZLr2kO1g==
UI-OutboundReport: notjunk:1;M01:P0:y4aMBcBIO+Q=;F3aQb6ji6M4SfDcsTGRrBWiBP7v
 MDlolZCdKmuBor7NODVoXFnK/wKT59gVHubUZ/pDCogCQOvAKpjmuuVUw/NOwbV3YrRbz/VXR
 O5b/kaxJ4aLo9d3eVeAPmhZFeuVaTztMYgwD5PKEa1weJLM7576hrRyND041um6VtTHyU9Crg
 c8jLJ+IP9x8fEQQ8YSo8d/qUdUKttfSQLQi4cAFivjpKHinwZ6jauzLuo3RG3rCM5f8SOrNnh
 rH/I0vHoSVFRPdU2Ja+CAQwkJlMPU5kg4U3xNQxbbNlKnaEkrUElpRYTQG4rH1jw66i3+RAHA
 wCy/z8NmaJ6Tlv3fEiqaB741sxNGGl1M8bYokrr3hYJ9hHeQ4eGLDkXEy9joKhjxp/S8uQhpH
 nEMTcjAkpPE0HDg0xOvlBqKlEHTrvmq81CvgxVRvFXPR6hz4zkvBO48nXSQiEZl/rKpI+QhQr
 iVxW9er6N+xo58n/WFjgMsp5JF/TDoXDpNhO5OaxVQiVYUMuuaHJOx80GPRK6EUUAxtDZm4zO
 Z8P+kSgE6uxRYRLRmcbBFwaKbPupbhKWKbTkYqY//XHPVXl+aesb9769v2SeZDdF1QE02ETuo
 qICDUyVPJ5jGnC792O3ROWF69qF4m3vpB1UPWgCPMiKt8XegU/MWOvZXAkTieaV78SsRMLdXc
 8WFyUETeb3oel2dN9tHjI+5d/FIFTtgvCyB5mv9Salm7u1LpWLLpv5C+chRmPHqubALFRvRGB
 9WXXVFr+AsmFWFxHBGSd+LLhlHashclQToN8cyDlcUhGHXLfYhQrT7nt3pDJvGY7w/VQzYfb9
 MhGDARjF9i5uzLkWfsq1azGXxPlHbqnkWmOrkwr5ccDo9HDYGtJt7zJSk3JxiyLKvimqv3ESO
 Lx7n4qM8m613NoZsWVYNNoOg71NevPtqkSQyDQV7LK88N1CiHQunD/+3gdcpUZwfQ8/mFuLL2
 k3gnGFdPbfaMFHJbwPuS4Pvad1ECvQzLGkAX8re5VnYnZisB/f5Ptu4W3xEiGBOKw9xYsTWrc
 OiznFPqF5U2IDmIID9LNwWO0KD47tqPtbhwJJdl3SUd/kY1i9GqCkIFvONec21MNuV+tL9Itr
 l1HGEEv2h0bXoKviAj9H/Z/qM5UCPO
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

On 10.01.25 09:53, Yu-Chien Peter Lin wrote:
> Some RISC-V platforms do not define the d-cache line size
> through SYS_CACHE_SHIFT_n. Set a default value of 64 bytes
> for such cases.
>
> Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>

You might want to add the following sentence to the commit message to
make it clear from where you took the 64 byte default value:

The RISC-V ISA profile RVA23U64 requires extension Zic64b (Cache blocks
must be 64 bytes in size, naturally aligned in the address space).

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

CCing Rick as co-maintainer of RISC-V.

> ---
> This patch resolves compilation errors that occurs when
> the TEE driver is enabled:
>
>    drivers/tee/tee-uclass.c:247:41: error: 'CONFIG_SYS_CACHELINE_SIZE' u=
ndeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
>      247 |                                         CONFIG_SYS_CACHELINE_=
SIZE);
>          |                                         ^~~~~~~~~~~~~~~~~~~~~=
~~~~
>    drivers/tee/optee/core.c: In function 'flush_shm_dcache':
>    drivers/tee/optee/core.c:505:50: error: 'CONFIG_SYS_CACHELINE_SIZE' u=
ndeclared (first use in this function); did you mean 'CONFIG_SYS_CBSIZE'?
>      505 |         flush_dcache_range(rounddown((ulong)arg, CONFIG_SYS_C=
ACHELINE_SIZE),
>          |                                                  ^~~~~~~~~~~~=
~~~~~~~~~~~~~
> ---
>   arch/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index bb2e7bedd10..b0190b1f415 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,7 +52,8 @@ config SYS_CACHELINE_SIZE
>   	default 64 if SYS_CACHE_SHIFT_6
>   	default 32 if SYS_CACHE_SHIFT_5
>   	default 16 if SYS_CACHE_SHIFT_4
> -	# Fall-back for MIPS
> +	# Fall-back for MIPS and RISC-V
> +	default 64 if RISCV
>   	default 32 if MIPS
>
>   config LINKER_LIST_ALIGN

