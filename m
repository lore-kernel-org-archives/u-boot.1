Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA42D2A52F
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 16:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7A287D1A;
	Wed, 16 Oct 2024 18:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RNf9BQhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ECCC881E7; Wed, 16 Oct 2024 18:52:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68D382BA7
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 18:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729097518; x=1729702318; i=xypron.glpk@gmx.de;
 bh=hj9KSTDs6gAmfNlorDAhhxJAeyDbsdZLPIpu11fblSs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RNf9BQhqMEQXbQfxz1VbiXhv23Cow2aOobQXSGRvjPGVm5TAnmMwpw0wBgPuwUc0
 7Lvj4pZIdw3bpgCPjWMiosw+oQH6/gx9skUWp7OYWeeiVwFZ0EK38DSgEvV+diL9L
 jQPxAd+3DUzDpcCdXEi2aTDZVJmhoSBzfGBNCrtoU8JChVfW4X5D9UR5oKT9sJyJ0
 yDZaC+3aE+vqGU5fJR7+3M77JXBkWg1z9JZu0Q1IudJRh/yJVldY89iJcochjhRR3
 tX7QLMgB5mDNpLFYrtDTTAbyRqHOwSAyqbAewYp6NPKeaFnlh5P+L6pnwApLgW84x
 w91MVyjOfsnrjdzeYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1tGzRQ3SC6-00JMop; Wed, 16
 Oct 2024 18:51:58 +0200
Message-ID: <c0be587c-af2c-4e23-b0a0-a7196b607442@gmx.de>
Date: Wed, 16 Oct 2024 18:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Don't allocate from Special purpose memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M9NbHwq7OC8kaC9GxcLIRXJ82jWi5zyR0rO9LD6hEQ35B+letGk
 26MAoKF0LKLEeGNsVCGNC+jIwlezk5KicpngRgwfdyimlBXCeiDcm3//SM4fVdF2D4FlKCc
 FZlZvACxZa3nu5S6PmoSdeXY6IcuK8HfVInYykNP7PRJM8iLZrmLyz+VSHJoT2uxszF/5YU
 WYfsSWwp+30whlp3PTBzA==
UI-OutboundReport: notjunk:1;M01:P0:Op0JQA52Z+I=;efl8gcQwzFkF6aRVwCoc0/huTbQ
 WUn2FkOKqa7feoGie+jismtvzjIoZwgyTgRk9V/zkiBPoVzZ2etflQk0sfHd8MfnTYEjwfuwG
 Kbm7NdPzx+/cznXvMEIgqyetkTSyaFDnJDVlxD09GvJGkyzfG3oFAqDbYfpLPOEko6mH1xn3+
 Ctr+h4KhY0ZNl19HXBC2nQ4zPGrAr258OJQWVi/zPK+iDQVwpfPe26ZraFzSjSqNG/60EFvqv
 YpoWDgiRQQdol1rUjQ2jmSza9SWOZAOa7HpgKYm7qmeW6ddInHSAv1dJGP+YKjvcsfgDorYrp
 SDn8VZHllvmATxdBGcbLe08Ed9Q2lfmZdnlzOJNeORhYPs0jobddL3OPgTaawbKFaLUD9Ttd3
 mN317bBEy36zvEhAc1yfRRqgEgH7AYMWlyfFRint8eUgI24+OYOYHbHgJbggLRvZcvyYGOLpC
 7bRnv2a+HcTjbkJ+dJ9ZoPdzKRQMa+bFhMYsB8iPS6bfRHUomUjnA+vMV2ohcWquY5NfA0UMC
 loCzdKB7lqRWsts29+uzPGWWzANnhvojC6U00xLV+2SGw3Z5HDlQ907PsiT1Qov3atldT2/9k
 c+DTuVLDuKa574R5dAIoCDufyDh/zYvOyAPpluLWffe++LaYEoS76kx1xvJacL2PSibllb+XG
 6dod+w4o7mCt6y57vJvyZlLTYM48UrUTGg7fNsUg82IF8FX9TK0sPYArpRLbCcAPbtXiA1I6m
 j8tu8xZbaocQZLddmoBPDxcfiCcQlIDvovV6w2z90zN/0GKqVgVQX7uEx1rguCIZ9mVnKSa6k
 qiiSxvVGJN4fbyiQRcWOP3HA==
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

On 17.09.24 11:02, Ilias Apalodimas wrote:
> The EFI spec defines special-purpose memory in =C2=A77.2. That memory
> serves as a hint to the OS to avoid allocating this memory for core
> OS data or code that can not be relocated. So let's ignore it when
> allocating from conventional memory.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_memory.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index c6f1dd09456e..74732e37f8aa 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr, bo=
ol must_be_allocated)
>
>   		if (addr >=3D start && addr < end) {
>   			if (must_be_allocated ^
> -			    (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMORY))
> +			    (item->desc.type =3D=3D EFI_CONVENTIONAL_MEMORY) &&
> +			    !(item->desc.attribute & EFI_MEMORY_SP))
>   				return EFI_SUCCESS;
>   			else
>   				return EFI_NOT_FOUND;
> @@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len, u=
int64_t max_addr)

Now that Sushosh's LMB patches are merged this function does not exist
anymore.

I think we should next move the EFI memory map to LMB to avoid double
book keeping.

Best regards

Heinrich

>   		if (desc->type !=3D EFI_CONVENTIONAL_MEMORY)
>   			continue;
>
> +		if (desc->attribute & EFI_MEMORY_SP)
> +			continue;
> +
>   		/* Out of bounds for max_addr */
>   		if ((ret + len) > max_addr)
>   			continue;

