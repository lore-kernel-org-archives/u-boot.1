Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E4C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B7E875BC;
	Tue, 21 Nov 2023 19:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="A3ZQRoLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6A8875E4; Tue, 21 Nov 2023 19:13:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059A78759B
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700590382; x=1701195182; i=xypron.glpk@gmx.de;
 bh=TOl1+7KweHhXiZkHZHSMkpkwn8+1xXWwTTvBwmDdSnM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=A3ZQRoLEe5zZyP35zPccdu1OQo8MTdtuHgJlR2I98Cs2XrFNtgJykiPWhqwki16i
 twQfEPmhhMD8E9nFTRvAUuFrhno0uoOvys0fGXy/pF9+q2j3V9CEFG41IQNuJ0ELz
 zI63v9rr+DGP0fp8+b3f7W2PpwZQPTxiP4DXAcxALy+8BjVwEVRcRlpg7WQhURVt8
 Dk+FbHeOfwnx6dE5AdnqyabWBquWB71htqfMj03Bqi7E/XkQicOgyfLrJUTxkYWXO
 BMH2pLdpOPE5JjuCVmViomJXtwGbGlDmNY9LQ/haKrirBFMvScHuZPhq7eClRA3wg
 b/wFf7ZBTvzn6lhIUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1qsBRu0I8u-00UoBW; Tue, 21
 Nov 2023 19:13:02 +0100
Message-ID: <5ee4719a-a45e-404e-89df-0a6740277f21@gmx.de>
Date: Tue, 21 Nov 2023 19:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] efi: Use puts() in cout so that console recording
 works
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-2-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hFXRPYtFGCh9uYp+ANvf+ZnEdiLZ01QGFvhSjpjPKhBX/hqrNLZ
 bz3nb8SC0sUvNmDusz7NUTEyJ4bFvEoDctaop+Cv/yEQPRfdJL30e5cdkU9OJjL81scug29
 dPulh+6BoK7EqoGVWIDdPFRrpA8QxC2PXbn59AOPrAyDVwvz2sZOmhWds/mzwDGeWUi4U2y
 lzQiIUZSNgntm+KSHVFIQ==
UI-OutboundReport: notjunk:1;M01:P0:p+un5no23IQ=;mQ3tpULyf0VKBlJKbflX4XHIvZ/
 Y2uC2IEKfC8h3jaHmeZnqNyzNmDZQk3vR2FbpmDbSP9mOppScJdUgyEg4PTMXlcP+XXIcl1XB
 BveZj+KDwzvO8LK5Il04A52bt5nDdbdiiHEIDXVuEpzezs9Ie0hltq/iVXYgk1HpFYxU8ZnJN
 twlmJB8iJXP7Qeb0lrAgihyzUCB1bMMuQzPqLtyfyp77RBRsCJQ5NeNr9FfofIxgEr/amov3E
 ZvmNMFtlTtUhTQ8TO5xET+wdOsHnIOZYhlVu9K5gposX7SjGrV0iP36PHsPqj8qcoq0Y3qeIm
 O9/u9YHdJYsrqOFq3zkP5dlIEM3SvaZh1Kk4QZqu2JuaeVb/DGKYKpPnigXALpREdg3uv1fIo
 zqn60QKzUkuSqpiMsme6f9DNKEWJ2AkAWoGAU0u5gZD6U2tYkfO7f849C2gVE9my2wgQkAODD
 fjCUTnsnQSj7GtKwS8lcH15ZQBZ0iBwDw9bF3mlQvoPJo5/bCAQJc9MZlFBBTwm+H4G0qCAiC
 FDYzUijREHqgXQ3l5hizeJRRcABmk7hTaD60i36knXS3EQ5df/kHUxqx3/HmlTub08wQ0vLpv
 3bUbM8qYd6f2/aW1CwRyT+nwWPQBd+mpH4dcoDP/MKnskt3+xv9fx9TDX1tf2xR8fkf1cyzQf
 hS8YyavL3mb0lw13T/paqf9CDQIJItt9iH7gcP8vQmqIt2q/Om6jzB6ePv2AALIzBk4Sv12rN
 OJN9d92RI4HI/2FcbpEWE7H+tb2jhx9FrDrCpQPxM5HclB+eYEUnW2bT2Df+hIHxGTBGt3aOq
 bhjCe2m2d7mGjOnekbKQ1F31g6y8o31T9dOKefkYaGXTos+JAfOSupQwNbVhCNdyZ9dMKNK33
 t2qp47t3ggBW8maOy0pn4kicdn2asSkDc2YbRMFxQink6Ax9Q0lDu9+2JjhlrcYj07nWD+LP+
 pJPqvkgOa136dbBYNoapSsDn+zo=
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

On 11/21/23 12:35, Simon Glass wrote:
> At present EFI output to the console use fputs() which bypasses the
> console-recording feature. This makes it impossible for tests to check
> the output of an EFI app.
>
> There doesn't seem to be any need to do this bypass, so adjust it to
> simply use the puts() function.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
>   lib/efi_loader/efi_console.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index a2d137d7a9e1..28087582e8d6 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -182,7 +182,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
>   	}
>   	pos =3D buf;
>   	utf16_utf8_strcpy(&pos, string);
> -	fputs(stdout, buf);
> +	puts(buf);
>   	free(buf);
>
>   	/*

