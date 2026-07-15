Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A949C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 22:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84BD844F6;
	Thu, 16 Jul 2026 00:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SETWjJ2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA308467B; Thu, 16 Jul 2026 00:39:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DE180087
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 00:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784155190; x=1784759990; i=xypron.glpk@gmx.de;
 bh=Pl4ZwX+Id/vZLYjrEHxaQpirNbFaBBxXHSYK0ZTxXhI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SETWjJ2SubX90eUNQM8tLZsh1wLwduXcQ7LKEHZE2S7TkbtVTCRzCmc5DUFzotf0
 33BLEO68ySW9gKfSBYlEPdc0cSNpJz4OWaSNCPvKSK+oIvTexOkujm6wPCNsH14eL
 wDh9YYjMM7jS4Q+6CHMkc4oqMPTson4+pd20Go70qIhA38kMRmI4zcY8bUp3P/j8k
 LHRTEw9zLZDRt5SO5OwXS72I/ZKPl3eX82DRPz8Soj1j93OBQ/tiv1S+sfOKPpNHr
 o9IoE206PA13hRN10kW6UVmEfL5riAUk8fO3ZVBH1VMzEKBfsMMhZkKtzSwVTyssj
 ++TvVAsZ+WLygHUUQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1wzjJO2lGy-017mPN; Thu, 16
 Jul 2026 00:39:50 +0200
Message-ID: <09f1a7a6-d921-4993-a8d0-d2f50fb6753d@gmx.de>
Date: Thu, 16 Jul 2026 00:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
To: Hem Parekh <hemparekh1596@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260617053114.66650-1-hemparekh1596@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260617053114.66650-1-hemparekh1596@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6d7OjxVAvxKuuAqSec36fgb00RDBcks08lrtKOmy0m1HrHuLhba
 iMlwMlPrqD/7O6eihje1OIHurnhUb3ESbg+4MoymA2TK7tuwJ4VNDmgch+eN+U6v1tTuJ2I
 M4M+wEkSsiXeZ41vNrv7yGV3/qFRoMR2Y30Bx2lTPkx4J9QccAGhqJY/hHnshEJ/TYQIzd+
 wRrPJFwq5l1S9zGcwKKEw==
UI-OutboundReport: notjunk:1;M01:P0:yPHX6ZwPhwM=;96VQKT4lwkWu4rg9ANgYMX30ySy
 +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
 zfX10LHX/ugupGyBKxsrH
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

On 6/17/26 07:31, Hem Parekh wrote:
> From: Hem Parekh <your.real@email.com>
>=20
> get_dp_device() reads a Boot#### variable and passes its contents to
> efi_deserialize_load_option() but ignores the return value. On failure
> efi_deserialize_load_option() may return without having initialised the
> caller's struct efi_load_option, and even on a malformed device path it
> sets lo.file_path before validating it with efi_dp_check_length().
>=20
> As a result get_dp_device() can proceed to walk lo.file_path with
> efi_dp_split_file_path() (via efi_dp_dup()/efi_dp_size()) on a device
> path that was never validated, or on an uninitialised pointer when the
> variable is too short to be parsed. A device-path node with a length of
> zero makes the walk loop forever, and a length below the 4-byte node
> header leads to an out-of-bounds read. The Boot#### variable is
> attacker-controlled in threat models where writing EFI variables does
> not imply the ability to execute firmware code, so this is reachable
> during capsule-on-disk processing at boot.
>=20
> Check the return value and bail out, as every other caller of
> efi_deserialize_load_option() already does.
>=20
> Signed-off-by: Hem Parekh <your.real@email.com>

Thank you for addressing the missing error handling.

Unfortunately we cannot merge this with an invalid email address in the=20
Signed-off-by line. Please, use your true email address when resending=20
the patch.

> ---
>   lib/efi_loader/efi_capsule.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 52887f7c..01c86bc4 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -860,7 +860,12 @@ static efi_status_t get_dp_device(u16 *boot_var,
>   	if (!buf)
>   		return EFI_NOT_FOUND;
>  =20
> -	efi_deserialize_load_option(&lo, buf, &size);
> +	ret =3D efi_deserialize_load_option(&lo, buf, &size);
> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("Invalid load option for %ls\n", boot_var);

I would drop the word 'for' here.

This looks correct. Yet, typically we just use a `goto out;` and have a=20
label out: where the cleanup starts.

Best regards

Heinrich

> +		free(buf);
> +		return ret;
> +	}
>  =20
>   	if (lo.attributes & LOAD_OPTION_ACTIVE) {
>   		efi_dp_split_file_path(lo.file_path, device_dp, &file_dp);

