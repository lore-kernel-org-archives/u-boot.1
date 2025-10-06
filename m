Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D636CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 07:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7748D82FC7;
	Mon,  6 Oct 2025 09:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I2UFj4wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7369831D6; Mon,  6 Oct 2025 09:47:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B91807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 09:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759736866; x=1760341666; i=xypron.glpk@gmx.de;
 bh=W7Zx7bRgtqcAGk+GdkutVnPUATRQxdt3tCLvgexClYY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=I2UFj4wNfd3i6Ue5Iz1c5mQaI2Ym0WYf0bSkYeMaAlBoLJrWBQ6K40VbqVe9OC4w
 Nysu06ylIv/2ZaLl61yXUa9JTYGsR87q2V+cbl7huPo5wg6lxpgJO4OsHvTEyCNZI
 +6zJg3gbk4R9AS8hRR+pyFKm7TNZX7ZkgWrFxVo8Sl/NjMVcV7THQ73SKxKXvb20S
 Yg3JxzMHdj41TQ0GDL17dMC4FC7ZXpK6ivxyK0KV53PhqdHYFehfuOoV/PdSyAypp
 FYRVAAhOJ0VZ+BZVB44pXhJJJFaR+b6ldovaeX1PdDFwyAwdSfVBo1usNjBi9H+Zk
 SHlIcKpaIEDWALuANQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([46.114.108.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1ugGnO1Rzw-00Q6pr; Mon, 06
 Oct 2025 09:47:46 +0200
Message-ID: <49d2c974-a2f1-44be-8d80-285154cf52d0@gmx.de>
Date: Mon, 6 Oct 2025 09:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Prevent leak of memory from tmp_files
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20251003-efi_capsule-v1-1-07d5fd09b97f@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251003-efi_capsule-v1-1-07d5fd09b97f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sZoD+F/tErn1huMNnIZxrQJYXQzOqe3lJFKI9uqom1pol3kIOZb
 aLwheFXJpWc/Vbj3CP7hauvgidQ6YVI+4WfOR1ay+oJVu1bU+DPYEtOqzXgMZLzvw0ropQ3
 NwzHXSIhVR5zTw6CPD2p/1qlPFJUdDv4gVDM+ipDKA9QzyczwRrvLYfaBpgNS2MLz+m8xmb
 5FpB3vznmLuchWZyPDkcQ==
UI-OutboundReport: notjunk:1;M01:P0:YBuYdrXT93I=;b7OIShkXn9snBmUe1iCuv8vhaBB
 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
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

On 10/3/25 16:54, Andrew Goodbody wrote:
> After the malloc of tmp_files and before its value is recorded an early
> exit will need to free tmp_files to prevent leaking that memory.
>=20
> This issue was found by Smatch.

Thank you for following up through all those issues indicated by static=20
code analysis.

Tom could grant you access to Coverity to look at what is reported there=
=20
(https://scan.coverity.com/projects/das-u-boot).

>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   lib/efi_loader/efi_capsule.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index f19e78ae9d1e250f7bf8362f043877c6d10a9675..31b47a20186e036f6852c6ba=
a4f353a5d7b97632 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -1096,8 +1096,10 @@ static efi_status_t efi_capsule_scan_dir(u16 ***f=
iles, unsigned int *num)
>   	while (1) {
>   		tmp_size =3D dirent_size;
>   		ret =3D EFI_CALL((*dirh->read)(dirh, &tmp_size, dirent));
> -		if (ret !=3D EFI_SUCCESS)
> +		if (ret !=3D EFI_SUCCESS) {
> +			free(tmp_files);
>   			goto err;
> +		}
>   		if (!tmp_size)
>   			break;
>  =20

LGTM

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
