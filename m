Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94AEE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 20:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D28802EF;
	Fri,  3 Jan 2025 21:41:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gQxx89JH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704A48035E; Fri,  3 Jan 2025 21:41:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9CB80295
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 21:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735936859; x=1736541659; i=xypron.glpk@gmx.de;
 bh=kIsHyK3LY8uOELRjPK+3y85/HiXNVFdYrU7roDgJI4w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gQxx89JH0xJQyo1Ov2sGvSLQbh5qFifpHPJdb+s+rT3qBCJj/zgKcdkPmJ+B+jRq
 QHRjzO/91IdzoKLYOobJpOm2gbzKugt/+mzcr0dV5YvAh5dI6xrEI4fy6punlnlkt
 C2D0JUQbHkaPuKwB8EdqSf2hWVyw+LDQGbuJ67i/3IMuKkVWh84QP8EVdq74C1eo4
 HzJKFbQYmdXxC9FZ23Y9X59UpS2DP3cJG6fsga4mJdJgyZlTtGLvttPUFgeuh73vU
 xoAmZ2rJklvQaehIWy6LD7mvj7WxXjkPbwLBe8+tdpr+sbsoFefuFjhJ1fMoZ+ozu
 wHPOD+p2ZczPsY8GCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1syRQD0U8M-00YSHi; Fri, 03
 Jan 2025 21:40:59 +0100
Message-ID: <8ac0dda5-5bf8-4fe0-9ac6-e86b62f8ffb2@gmx.de>
Date: Fri, 3 Jan 2025 21:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: enable support for file renaming
To: Burak Gerz <burak@gerz.io>
Cc: Daniel.Venzin@mt.com, eballetb@redhat.com, manut@mecka.net,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241212220635.25971-1-burak@gerz.io>
 <20241212220635.25971-2-burak@gerz.io>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241212220635.25971-2-burak@gerz.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:idSsYziyHwC0M9lQuCy3QTtCNYgaVe+lYWsDGZezhcNaDJUo6Zb
 emMP8jH3SkkzQKFlArFkbH3lBuTS5i24Q3k5C0jGOz2Cavf+fEyZZwFUYLT0uQW+tzSk7/P
 BGZvXBV8oAbm1Es0tj5IstjFkBN6djvCUFbTXC4gX3tnwT8X58ImjYag/1lRQyXUJ92LSq0
 N8F4CVluDbOC7WFfmBMag==
UI-OutboundReport: notjunk:1;M01:P0:3CUIEML6efo=;F/2bspDHuY9Y18Eu+XvCpTtdBNY
 +YtA/aiQV1D7K131w90CfTdlWFBoU1QGwtB2ENYlp0IpJkiwuKjtBp2pidCA3e1tQGuCxkAiM
 4B31fJ9/r8AIKivAHBYb1dwb8QBCOVx4wpmV8HE6ja1FT/3KVvK9xpr/G/9bitv3q6X8+h2/i
 lEz2AzX7s27kDBLLYMjmQw7yCd2IFCFi5OTE2ySpI41psQTrWTPShUQV4WM+K+NbPIIM9PCeL
 cEMKxQSnO9S4sEdyLw6BhKne+o8aTazswtdK/Hr28hO85+GJaKSiYiqITeube9IfHLq6b9XJ7
 kpqj27SPi4Mx9ew+KeLf6zTC7P4tfs4rFeFfMef39gCPDpL9tgX2nFgN53iGimSlUHWLGzWBf
 swCzgR7haeJWjmCbmBnMppUjGrEVg+1i+gYeX4RyjBMbtiNNk4rEVPHp86Twfl9Vj4vgN5qaD
 g3nix6xNYDMKNuFrYpXo/HAaaGJlY1mI5TFBr8BGhYIl+W+MG0BMKO38eYppfpuSS3XyilgEf
 cwjm4eGRkGqGXLusIyjEX70qoJAWXcM668nbCCbQfS8LOVn90aDuTkzuvcTYe5gMoy0O2BSUN
 ZN/C6f3GYmfKvPdTGam5NKLdXvPvUWy6W5nAO8Q7cv68Ls4//dN6mGiP0+290IxbI9wM1G3F/
 sbIQCpoNpRrjIKouU4PCq9XvGVBlJqc/HMyHIw9tRiHGC+T+rog92d7nsyeEw4s8tjHlwG4zD
 Y64jqmc99HHVp3pawcuP5wzfWFQLjH79RhG/CrvPJiviMbjrZsCOgrdAmcU6h8iapxaB7+LuP
 bIWVVg4y/EMnd6eXQTXPGVEe970ygmB1+FQmfUH+j1QyJ+5Ee72YBPnT19k4/CGKOdSBqhyl1
 13I9ABoCSG1MjAIYr1OgyRJYdGNBR2EW1DLS9a4bPA6CuasZGjKhsPekvtXpmm6z6rkrddbbY
 QN/Z3xyTy36C5qdTxlqDhVocqn+xIXgfwOijodWPeHk4Ws8iNVfSySBOUtgo1Nn4kN0P+3Kox
 Cc63E4s86nIfYvxib5KXnLhGNqd1cRUJTnAb6u8w+iRTxNO5CUxhoS2Q+fhojecWAt5HrNgfZ
 qADxzvJjhbfm/sumriY2ZtKu7RBK1q
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

On 12.12.24 23:06, Burak Gerz wrote:
> EFI applications can issue a file rename to U-boot - add support for
> this

Thank you for the patch series. This is a valuable addition.

We want to be able to bisect our code git repository. This requires that
the code builds after each individual patch.

So this patch must be last.

>
> Signed-off-by: Burak Gerz <burak@gerz.io>
> ---
>
>   lib/efi_loader/efi_file.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 95b3c890ee..b4d1a9dad5 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -975,14 +975,15 @@ static efi_status_t EFIAPI efi_file_setinfo(struct=
 efi_file_handle *file,
>   		}
>   		pos =3D new_file_name;
>   		utf16_utf8_strcpy(&pos, info->file_name);
> +
>   		if (strcmp(new_file_name, filename)) {
> -			/* TODO: we do not support renaming */
> -			EFI_PRINT("Renaming not supported\n");
> +			if (set_blk_dev(fh) =3D=3D 0 && fs_rename(fh->path, new_file_name) =
=3D=3D 0)

We tend to avoid "=3D=3D 0" in the U-Boot code.

     if (!set_blk_dev(fh) && !fs_rename(fh->path, new_file_name))

> +				ret =3D EFI_SUCCESS;
> +			else
> +				ret =3D EFI_DEVICE_ERROR;

What is wrong about EFI_ACCESS_DENIED?

Best regards

Heinrich

>   			free(new_file_name);
> -			ret =3D EFI_ACCESS_DENIED;
>   			goto out;
>   		}
> -		free(new_file_name);
>   		/* Check for truncation */
>   		if (!fh->isdir) {
>   			ret =3D efi_get_file_size(fh, &file_size);

