Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419A5D10BE8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2EC88D13;
	Sat, 26 Oct 2024 09:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lkHABJVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FD3889ED; Sat, 26 Oct 2024 09:44:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCD388D13
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729928663; x=1730533463; i=xypron.glpk@gmx.de;
 bh=Rgyk32792afllHJsl8Gs+E9Iroro0n4VDOuAc1x1c88=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lkHABJVpDNnuOpJ+np+YNfgQkWzYYYTWdgRXE5I5zQnMH/A8dXzTuihTZolcVDhM
 xNIjbWTfOuqNnrTrXtsNhI/t1FtYBcs+ggN0BsvlvVKF7f0N0kNZQvddVSVsj6dKl
 cTCNaRwoQ+rcz2rNCBYecG7OzukW4Wxvb2QVk+2UOyaJKElAKkf5xkZb79bINlMG9
 YHnk+M6ts/LQebuJipkALXkXFnP0SxQc/y7J2mUw+MMfMw0SJmA10K8IydR0J6IZ8
 e13O9EENM/3SkYRjbseGysKfnWOfmpat2FBVZSYm9SrCValqoQ48oAzREywaUHUga
 W63XryHQ2epWYT3gag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1tHIlF0nlm-00SK5q; Sat, 26
 Oct 2024 09:44:23 +0200
Message-ID: <4f6fa7d8-b2cb-451f-add0-ac38c9b984e5@gmx.de>
Date: Sat, 26 Oct 2024 09:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Mark efi_bootmgr_release_uridp as static
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
References: <20241026073734.102723-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241026073734.102723-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPYCTClgi+eO/sUaLERA+OjHyZ7T9AkoT8osDxvV96xFRZTminp
 FTzodofRuXZ/A2v80o+vcN7mwI04/8u0u+n8fpguZVgUReT0YluhuTcPtessaJjAuLWUQBo
 KGomoPa60eX7xaQfaEDYu33ZeDWhFQYVskKLbqRh7+wOKv0FdJm6n6kdywBkurfCgIOnbnw
 pJaqauKcqz4h/WkYISQRQ==
UI-OutboundReport: notjunk:1;M01:P0:pV3vkJ61MKI=;RyJ2dszfRKUCIVaXX2lRvgKpjWg
 YWz8RXcMUxv+OCgy7hznEIRBXVHWHLqz4q8ppu5qkxkhN6jhQla7VUGTfX2E4kGk2wPDFVFwd
 dVgxbMn96fbMqzqPnUObkzuAoWRYYJ+Ik5zC0ORmUJNnzJQf7V2SK9x4RPMArA5+ix4Ft/rpu
 8F57NClocaPNSjiAR8jw2KRQNpN06WIXCfmdAcqBec6R/FDzrDwCdGX0VtymwmN2MebJID94+
 druF6SVBT/KtgBoimTUGplE6CkKfcWQxoQg0c5yOLmkRW0X0OWtns47gSMN/Y6MIm9rniQujf
 RqLlKYlNqp8UqgcS3gvzNgHLb9B9rRUttcCoibF1xKNtWN9OAb/wQ/WeAYZ0+oO6U6TlTrRZk
 OkR6ACPMuVvsENRQ1FM1Q0TcxfQM4fbnB3QPVxKzxN6XZBwzI+QJ24rzFMKslYZ0kp/qLFoR6
 Q+tzFad/xNL6JHCbRFzTK0g14Ma4yzVCYw/TGyIZ389RhxsFeRnjGuRlOXnJAdJmmOzI6j+1D
 kBStCzZudheaSx47ZTxHNcVG9fL3TGLd+Hn5q+1PVUc4dkdttHfGSzzP8c33v4rUlzAy1quLo
 KvoF71k8pDW8iNnXZCgta1db8CpDIgVvD4VYva2m7JjCOHj+WbQO2s7zPCn9NrneO+83djeL8
 1iljPcZ3hxS+1S6eDaeNgdZYUuqvd4cn84d5qWI1mIXjpl9nT5ucRWmL38j+kwIhyBToMVv8w
 S2g4krY3PKLAkce+KTFWH1SPgmTlXrxE6RLxrdY4HjMR4bCfzejOVqSEHmzLQ3dKLIy57xI4m
 tY5lpGPhJsmfeuuGfrzQ3JFA==
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

On 10/26/24 09:37, Ilias Apalodimas wrote:
> This is only used locally so make it static
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a3aa2b8d1b92..f9b5988a06ea 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -385,7 +385,7 @@ err:
>    * @ctx:	event context
>    * Return:	status code
>    */
> -efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
> +static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx=
)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	efi_status_t ret2 =3D EFI_SUCCESS;

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
