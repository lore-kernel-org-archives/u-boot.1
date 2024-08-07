Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8BAC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 00:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C50A88AFA;
	Wed,  7 Aug 2024 02:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SHh5kac2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC4588B12; Wed,  7 Aug 2024 02:37:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA75C87DEA
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 02:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722991027; x=1723595827; i=xypron.glpk@gmx.de;
 bh=KpGjGAc6LB0cofLSyturrANSeZQPb6xOZLcrpqjwb0Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SHh5kac2NJkFcffkxMMbnQoQswuJbcrvpJ9Nay35MZuvvS3jXuoR5HENNDkKje68
 0ulMLB0lX2TU366RU/IKOqc74k2KSzDwD1rdEZc+b0gboB1XXaBnQaIJ0Mq8/F5dh
 BAAHDV9mG7hE/KBMeayZvhdts2YZdE+MaGyW92Q0G9s+X0L9Oevhh70A++1nh7w1C
 5oeSaYxIOHJ70ZJwmKnjJY7us6HUHnnJl/Y/c5T65SdlU4cXZVGQ2hqr0JtmgGi9x
 8j7zIzBBVXzHlYwWLpuzCOr5fGY77+quSu2Fxv0m043ei9c33TLocYoBOGwxdskRk
 3EOImmcmuiqEpFe87w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1sw3xt3jRf-00M1WG; Wed, 07
 Aug 2024 02:37:06 +0200
Message-ID: <665ee6b6-9ae7-4d71-8c01-2a5109e7b910@gmx.de>
Date: Wed, 7 Aug 2024 02:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/39] efi: Use puts() in cout so that console
 recording works
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-26-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-26-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dI9ZdEfVoirsg8DfNOUnh3qXCEIrrVLiibhDGjHiLwlpdRBvM3K
 IUSfkrqMKfgPL2einEOdC1Sn99WcyEJ0Z44uaH1sa9JPLIDCH6kBmmmjUWHl9ECSeOMZx93
 1djIikdmuPxs6KDi62eoUDaxNuBwsS3HqsJSEppVk/mdGbZOYljXcin5nscQs7nQXnhTSzW
 3pnhhdZiCXk3tw3YNZ5fw==
UI-OutboundReport: notjunk:1;M01:P0:vKiuh/lJTug=;uPEGFmAKA48/BA1G0AMY39Wf4GE
 VXhxZ7gOXqyTT2ssbTHHA7EnYVy/EjYhdLgk/GzSdReGC1UUt0O/cTAD+2EZ2MgL0cVQGWp6J
 qkf5lhZ5Z6k3AJ7N0TklmI1jBCjx1P7XNbT3xW9JJaF6C3PwDJEXSdpF3+NAxkb7aBzqgcp4u
 qatEiU+XDsj+QuUgCdWO3FZ9MCT+wLz+AOhMRM135rCMfZCib4zBJWkBn7cWp5bJwVDwbiSZO
 59sxppWqXJUMGzGCrKbVvhTK2MYK5TNQESN3a7F06lNc1PjwZy/+lhPSFV5Esm+rI6Q7f6ukx
 nLFzR8wZl3hnQElmDV/Qw8r+wyeU3zr9+JsPw4VIvymBgq9bVKicwUPXrx4RMVhLpBD/tGOYb
 YEkBolU4PpZ6aIrpgmZVbXg55sYeUO7tqyU89D2ZXydSaU/HDa3dCcICCZbFbOP6cBZMqMg6K
 umHhwoN4lbzK9I6VPqIkmaFk/7z0W39a5wT7WByTNwzjQeRSp03p7VyZyZ3z7eo/S6FEVgdN7
 Wp34W91YNPC66YFSquMACs670V1chIDf19CEwJo4rEBpNvB89evANpwRN2q2rDN0MdDDRfH1G
 HblX8WkeF/PIpmN42vGXO0ZPE+1hg12Hy3nG3/QTIzku2VxYTQwzcFTv7+qFoNpPw9CEUOfjD
 YJA/6rMTsat/9bePO6GrPTG6a0IR9rU92W8T2eQSfynIxJJayX0VHEzpHu8xfBX8jHWX6aSU9
 qUy/SBcYLSI+MyqTQnPBePvzBfLvw7mrIhHKkgXIJxJZoUdaB6j4x+KHXhHhqR9aJDfpVvFRs
 2MPhvCZBHe0VV+xCwLeStatw==
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

On 06.08.24 14:58, Simon Glass wrote:
> At present EFI output to the console uses fputs() which bypasses the
> console-recording feature. This makes it impossible for tests to check
> the output of an EFI app.
>
> There doesn't seem to be any need to do this bypass, so adjust it to
> simply use the puts() function.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v2:
> - Fix 'use' typo
>
>   lib/efi_loader/efi_console.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index c944c10b216..cea50c748aa 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -181,7 +181,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
>   	}
>   	pos =3D buf;
>   	utf16_utf8_strcpy(&pos, string);
> -	fputs(stdout, buf);
> +	puts(buf);
>   	free(buf);
>
>   	/*

