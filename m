Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94494D70DE5
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145CF894F2;
	Thu, 28 Nov 2024 17:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mkcHnDv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7886E895E2; Thu, 28 Nov 2024 17:19:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2FD893AB
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732810770; x=1733415570; i=xypron.glpk@gmx.de;
 bh=GQtCYtAr4ugb+PuG+ProqPnhA+1szGxA2WZRMtnRnaY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mkcHnDv8Sd76B/MGUKFcScIruMoq2z4uAWlrshShRaQNcA9A7xIT3LZqt9iH500q
 7OnkscUNT2H8ClOwvIyDts0AIOVkniPdtTDXSKns3WWSvt9dK+N8vfJAeCaFYNocy
 U0dmf7yWa7EzMNU+medepJCP1rZ85RheITYdV1K01kkjAmf3anNBZbBgwGjdStrWc
 AQuyWag6NonTa3eqKhGfXXGSmMY5Ds4skS9KD4JwDp/JCxNwI+TyHKzzpCU98YX6S
 LEhDpmyVAKhjn9iVbHVyQRjuuN25hsfA4Pkuc26HZBjTTqO5BD5QZzrLfKEOeDf0t
 QcjKl5WHrbPTu1HOZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1tgVdH3Upq-00r6H2; Thu, 28
 Nov 2024 17:19:29 +0100
Message-ID: <fb055f90-daed-4c5a-a5a6-6fc35e6375a9@gmx.de>
Date: Thu, 28 Nov 2024 17:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/28] doc: efi: Add the EFI-loader API documentation
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UWOU/RDpw5xwVoqhP09jdFo39MhJ1rwz7rlRtUyWQkqkiROhGe1
 hWsFxPaFuJhskAfbfe6rwm2m/yWIhlzayy0tKau/z0GGe2KkTatz8ATAop1XRAHKiyUSxoP
 1m3sNK51JIM0RSDX67bKwXbbQqVwatAG2XsaHULLpyhwK8krQwtRIZhJSL86SpI3uTnYRUu
 fu+R+NFseT78zOzYk3Kgg==
UI-OutboundReport: notjunk:1;M01:P0:ZMEc/NWOWSM=;IjQpXhngQrS1UQb32VQOJns4eoe
 PVwDpEaejDQlY3534gZLJ6YhVTxyfPq8jZU8Hfrh7PW3CrTBXrF6kOLuXzFb0a/DX6mt3+GhN
 hdiPx4/uObe1LIlYHAX+Ja4J72sOZgkC1dciSAOu2dURqeVz1yGhZW4VgWMK1Wh4wXEPp0SrQ
 H3BzT0FghDY0JQjFUgHwy4T5RlmmhDZBfzNSWCxrCndL95uj75vu9w4AahypupboyHr4S3DRw
 z0W5fBYlr17Nd23ikFZjFFX3JD0dq0oqOClwgiUADQnApG+lj4DLYSF1jsfgGZoWiChE3pyHc
 ywpDF7BalVApZMp0Wfiw+po3En/i6hr/2ADnKYXQVS2cA5LGH8y2WlcKyXmDFfR2++IQco13s
 7M6l/MXMynsdjA3PpoP7pP7AVAl/GX84A1zcgx2RZJXlllZlOOMFrv4xEkjX5N+xx7iarHSze
 FzVxR5TcuARe+xL9Q5KcNpwECANQwvdvPt7uLFaAQLQofBNlQDfrEg+fzDH/RAFZVqnJRId2D
 EPts3rt6yfiK+gdP7QyRwqFz15sEd/v2wfIw7M0bP1u3vikxPho0mLuBNNWe0MR31g6UMvtZ5
 s5q+OSlgqn17ko58L+lb80JVr17iD1rx89qzRGaxboNrKhF9rRTPEYQl1weXhzcCHFXeAwq2o
 Ey10VSSK5dIpbxy1OAQG3pA4kL4bOmyM2paYwzrEwPEUKQxYu0fZsd8xtjb12bzTqE04TO9lM
 F+Nzw1R1yDt3kB8ookG7b0ZOHk8ba1+dBLWlgYazy9hDi7qB9RGTOWSG3sJoIG+1OFdK57LEy
 YPjHnvVBLiLZiSoEz35hBabblJHpTXwdkXRbqaeoO/4uEMtqMxKRSeqF47g39IZASYgTyejXP
 Rm2INlN4e1wIFiWcSB5LYbp4qswRyFzts8rTgjlygq2nLUXUSqQxfZm0SM6c5+IPmtHd8adJP
 Yiz//qwAmGMXqCHJbihZMphZDRU8Da7fh85Qnnbf+7lc3MrOUYak1iDYDmsf8YghcWxM8S91P
 n1P09cPAXSoZ43H9+2Gey4KJInyRxv0XQZ0RFsNwoZdqtsIIKBGiW1LDe2e47fsdCs/bzcpBx
 /BTmnjuFCDNKBUyvvz1sK7ts2S4yZo
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
> Bring in the documentation from the efi_loader.h header file, so we can
> see the API defined there.
>
> Fix efi_alloc() to avoid a warning.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> Changes in v2:
> - Add new patch to add the EFI-loader API documentation
>
>   doc/api/efi.rst      | 3 +++
>   include/efi_loader.h | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/doc/api/efi.rst b/doc/api/efi.rst
> index 43d6f936fb0..57da7f615a6 100644
> --- a/doc/api/efi.rst
> +++ b/doc/api/efi.rst
> @@ -75,6 +75,9 @@ Image relocation
>   Memory services
>   ~~~~~~~~~~~~~~~
>
> +.. kernel-doc:: include/efi_loader.h
> +   :internal:
> +

Look at the section title above. Adding efi_loader.h here makes no sense.

Best regards

Heinrich

>   .. kernel-doc:: lib/efi_loader/efi_memory.c
>      :internal:
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 00a1259c006..3f75f2efcb6 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -764,7 +764,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *siz=
e, u16 **buf,
>    *
>    * Allocate memory from pool and zero it out.
>    *
> - * @size:	number of bytes to allocate
> + * @len:	number of bytes to allocate
>    * Return:	pointer to allocated memory or NULL
>    */
>   void *efi_alloc(size_t len);


