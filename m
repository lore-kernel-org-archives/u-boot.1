Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A569D70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E71894F2;
	Thu, 28 Nov 2024 17:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j1Ux5SCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B719E89430; Thu, 28 Nov 2024 17:26:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B095789430
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732811173; x=1733415973; i=xypron.glpk@gmx.de;
 bh=VZ/p61zkJQDN5/pU3W3AoUG6ZGoptE7zOQM5fWJVB2c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j1Ux5SCRdpQFbhthgBSXrPgPYIRT2lSe+VOnrsmZSMSIHF2ULqO3MpOG0VENzUO5
 O23xGQX5dpoVQAf+LwcIGH2C4ihJK71cAUw1lmrEf8gbVRDb26tWe+Z4jZt3jvTTL
 SzvXie4GrePQRzkq/X2jajRB+zMKNcVUNMmg6nvvxofA9v+9UG+r2F1GiEeBTbN0i
 niRsvtgw9ADRcOnHmGy1jAiCC0COGs4tkZ9EMtdGkRaBF60dq78JpDieaPp9RfyOq
 GRiYShQb1COhk13hhDcS4UNAUT2MTi7EBPO97eMMbVcpiVHng/aaxCS7ni556MPLC
 X6LM/d0jdhrd2udcfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1tXOiO0RYb-00tFpJ; Thu, 28
 Nov 2024 17:26:13 +0100
Message-ID: <914a746a-bf2d-4415-85b0-2f33d365c956@gmx.de>
Date: Thu, 28 Nov 2024 17:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/28] efi_loader: Show the resulting memory address
 from an alloc
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-6-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LYjFVpNlj3tqLypg9mhqsrPQ3bwlW0VHXgUAoUPbYck6eYjA5DG
 WiILYXLkdt7xuigxizq4jiZgjXnviPmWoBrw7lsuN+HnlNWZQkV9oUtjSy9BRltoSs/hi6c
 YQhNMExVNL/uZ9Z0vmU5WDbvWCBR0ptlPeqnJgGAnjvA4maI3hHeK6gLAYC+OF3Uk7Vf3Nt
 DKp6NEvOl0OdeqxCX200w==
UI-OutboundReport: notjunk:1;M01:P0:BShYYn8dt1w=;bw7GXrHrT9mWDzzbyObkU8r8J6Z
 bJuw6/X4mqbXn9m2VE+3tx/5A7Qvo34DdHgOxsdBbLFg0sEmnlJTdJwi5Qj41wBoIPqfTTXAy
 XZ1j2a6AMdL6BNuZwAYs6DJEwoHPHeTelXuTaA+CfBKroVPqMqQGJJAgekU4ivT6ABqUqxdnq
 yAKdNhuMGL/ESXzhW4bchG2yzhuUobWoYA19T1izbYFf+fEnxWW0+K3HXpcpFhBv7up/1MeJt
 jnQt19CJgD/gcnSuMEzedRrITIkn8pihLVLcQ7p670ti1YJ2RslHyhTabBxIFgHJw4Tur+IDZ
 Ds8/MgMeeeQxkLz27ySjkyV0eecIunMMuleF0snai6AxuJXg8UN56z6/JPzcQp7JYfdN4Us1o
 MQnLobmUEG53QZ9+e9qq+G4CB3ykICI191twLchwvUaU76U+XXz2gQelL64jhFXm0oTF2cpV7
 h9U/rTBgV4z0QFSecRpA6h/cG7HIVc1nA9/eJHulnKhtC1VnSD3eTK85Gl9tclLy3NwUOVROh
 YPcdZgO38rB02Y7F+ahpGibFCr1Adjf6EwYcb86rlE/GmhPy1gZILpjBJDJdogUK9d/qo6LYg
 ivaDnjxBXtPPdZU5ygKfYNtDeWqLtqLEOLwFNOdRaGozn7zN5sLGCbkb8CcpCGtnSEKFJSsJJ
 Rkh/mt/niv0q86Pl8oLwYqHiHPJFoMdrqfuvVrghzBGy9vlPW+4T93oyOYD7UiVED7ftVvNBA
 /d6id2RIDPoXdnKQoxJgK0xLOeYJhus4KJ33ZRqaSkvR9Le7psdNHMFKOPAvnG5X/SP+P8+Je
 d1ruJYP0pvDmGQBXDlu+DPlFYzbKQrfS4rEcUE9TUqvB58g1tgSMNNMdhs+vfzwTbx3xv+74Q
 r/uqipQFrkfddMqwfBLDQENLHleaIcHyHx6kt28r/nV0kgYMOMV5RzNjI1wDyvgdQSGKuRQTn
 AXE1FXSSX4PFdTLPgeEqE7Kn4hywKm358rew/zypWjcwtAnIMaYQLCI8dpibz0n1IiJHUdNRk
 GiSTf35H1ag+4iEPUh5YQlvmjNVuU+KEsyZKxQSwoAVcZEX6d0CZKsVyu+uH1yMKLPqXs3hx+
 2alrYGBhKwaHgH7k/JkVFwCFySsQHo
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

On 28.11.24 16:47, Simon Glass wrote:
> Update efi_allocate_pool_ext() to log the pointer returned from this
> call, which can be helpful when debugging.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Use EFI_PRINT() instead of log_debug()
>
>   lib/efi_loader/efi_boottime.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 080e7f78ae3..be8e4f41ad2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -511,6 +511,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int=
 pool_type,
>
>   	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
>   	r =3D efi_allocate_pool(pool_type, size, buffer);
> +	if (r =3D=3D EFI_SUCCESS)
> +		EFI_PRINT("*buffer =3D %p\n", *buffer);

The UEFI spec provides:

typedef UINT64 EFI_PHYSICAL_ADDRESS;

typedef
EFI_STATUS
(EFIAPI *EFI_ALLOCATE_PAGES) (
IN EFI_ALLOCATE_TYPE Type,
IN EFI_MEMORY_TYPE MemoryType,
IN UINTN Pages,
IN OUT EFI_PHYSICAL_ADDRESS *Memory
);

%p does not match u64.

Best regards

Heinrich

> +
>   	return EFI_EXIT(r);
>   }
>


