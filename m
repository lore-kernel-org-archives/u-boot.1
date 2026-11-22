Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64A606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D1gcdtYH;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dCI5saK/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 603E860626;
	Sun, 22 Nov 2026 10:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPcWcxZCKWZF; Sun, 22 Nov 2026 10:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 859866061B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795344383;
	b=fMGenl6TIUJhIM3WmqQvnDiCFOnfxoUn/mCruQck/BGNeAVf1JMuGuNYrl+UkFcBrG6c
	 6IHrsb2oBGZWUeLew9qomPAJOnadlE+VbdHKqGmZifhDk7essT3btZt9v3zctCXFBuaC8
	 62L1k/dL+AV3p7HrJhK5wF4esDn4bovMqO9dIDniUzAu9LgrKm8ERmcaT6JqSTeFfStup
	 Cs42gETy3NBJsR4hLmfwXj+/NDG4Lo8TEtpCC3fzo/f/qdnQq9AmgTv/+fJtwXbs2KAkp
	 kad6r+Lolwz1dHsVEpw/POeLfGsfYTSzVkhbiYZhBzVwcxYpcXY+hyU0SsdS0By+mog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795344383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DXWjE4qsNaoe6PZWZ8W4oy2A4fYehzVHetbD+ZML454=;
	b=ASdxSijtb3gzhCM+3H9YC5tBvMTummLjVlhoPRMu9W/+5ZZgUue16SQrewOdh4LqXmP9
	 mKbG5xM6/VWDgGWwePPbbGlqujcP+JWSPCKQkO7h1nYa8IialQTZkyJrOy7UBWYFgznDQ
	 ix/iCxgDwK0qDOaXFO0oiVCMsWu8Imp8J2HkGA93citHbIH4i0PZ1oP++aj71XeeLQ+6F
	 rjdEGtGTtqaV2tF57iTlzYumj1ZA3DZkcD/rUOsTSq0mVj3gRAMm/zEB9D6lVVOvf8tBG
	 hjEcEdynLsKqoHkIy8e7uMr8GDjIv5Q2LKd8P0rCUYZ+e+Xwrv58SDUbVZUE3jSYHsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795344383;
	bh=DXWjE4qsNaoe6PZWZ8W4oy2A4fYehzVHetbD+ZML454=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1gcdtYHGIQwNOLiENLDzg5wHSspxjWom5M8qBfF0ytCJ69jFWPNJlGdVyamScFkK
	 NDWMNGg8GbimEmH9mZ1qknaVcuymxoyqWUUEGDmNb9XDnEtKmQj16/e1zfPRDayf0A
	 EzGyQqbxZvzrW5sxUL5Q7Tqf2Xwn17ipWeZ0ja8bWUeAQR20JB2KaSAsZnGw0qSao2
	 Ykfa1tAv3W9mB5m7C1ZlifYBFcHpX2vTnKQrYSWANtjWVR32awgKoBsoIQo0wXGFY4
	 SKzimGe2/yX8O4g4867t3F8GTfkQIyKITwrGHwXd0jCE24s2WkbptvVXVpz6asltDY
	 RNRxD9ywt4iLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 859866061B;
	Sun, 22 Nov 2026 10:46:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 90B9822B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76518400D2
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id baXNTOOHKB_l for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 10:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A51DD400BC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=dCI5saK/
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A51DD400BC
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:46:19 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795344377; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:ZKPIle6LrQJXy7kBXy1EUKBm3240
 ftS+9EM0v7mWv9dj04mepCVYqSboNjjFBHWi2v5iOtFzTc0PbknkrRT0t8+GuCa8w82187Jx8yt
 2jM/Zxdkrlhr31g5Ci44aei2NCWlHf2Z0Peh2/dLBa56haeMOdjr5JI4Ez+Ypi5MWKSXIZTledu
 J5Pq2Bub/O6prlvRDBwc/v2DcLRITX9mhAWjR35zrZSISgborpw4bQJhMTE9G+EjdJBxPkzOtH4
 6RsSofoB69gINS0JrlIiDUboH3LWCwEVUuCCRGrtcJdcu6bQAUZdSQ1hVLtj1tqZL6WHmlinkty
 9CKtzqt/NNEPbA==;
Message-Instance: m=1; h=sha256: PB9AWsDEnElGuJ6kOuWqKfZT1XwznzOj/HOTK4tV8FA=:
 axvN6mhxmaC2CmFOlT4/kuQ+rmWGqmZY7aRsRDoaxlM=, sha512:
 SYupGN3wAW8fH4emDLBOdPgUi++bUsuWjIBkTd2hVGaTOkg7C9BevZ3kjRbRgSRSD1snbKUxtkehETyFf3w12w==:
 RwzSUduRIyRXDmuC8AAwJw3kOONy289pZyBGYxeFqA/NDfbuOd47hakEL2c6eI5Fe5UrmMKSsW0Csts7XteShw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795344376; x=1795949176; i=xypron.glpk@gmx.de;
 bh=DXWjE4qsNaoe6PZWZ8W4oy2A4fYehzVHetbD+ZML454=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dCI5saK/BmB5yRr0S+pbTwekyiuWSMIt+Gt4Pk5rS2mND7ntOs4WoIcBXHPW35DF
 Gz04gAeWJDDjxlRTuupvJDSlP9qBIUcXCby123Xy6+MUFFcaDPHOd5oz6+E4ZcOeS
 aFl6gh7Y5sQmBxikNqlBHlgRI1vs/yIEA0qqOlQKUq4dj4HGkvgifNnVw2+j9Woc6
 sl+pZuUoPdSyLayt21x7cd8LFy1OudhYeW5ldDWLgIySlgAwou6X0v5GJVJRUkJzP
 hTfPEwkdk5taNuilVL1YjZR1CUhWMNxnDp/pVJ52+/2EdaYgFv0PrAFHgnRxgfE+2
 OQG+aWMTkt1hdBf7rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1yPoEd0i4h-00vBgb; Sun, 22
 Nov 2026 11:46:16 +0100
Message-ID: <b87f8ce6-457d-44a4-bb27-0c38dee79a88@gmx.de>
Date: Sun, 22 Nov 2026 11:46:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: unload image if efi_run_image() fails
 before starting it
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261106051357.265179-1-oss.patchbox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261106051357.265179-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b99xyVhXH6beb9k/JvQ+5U/IxK+YkBz/oF8XNi43DI2Sm7yJOlN
 JxYwhDoocBFHYwQ1M/63C2cvK7E3IC5Rbs6jZb0qCM0TWcNXg1rUoxhvx1MjiKvoH2Jz9E/
 J+ZQ73brwHLsIIljqZ6SltWEC995DwOgcr6WD8ojyTIzm1+Absypu2nzdqPmZNGrjBkVCoK
 pgCLMH0CTpyC6Qx0CpOHA==
UI-OutboundReport: notjunk:1;M01:P0:uP+tKs7J80w=;msJ7OMaDhYAmDC4Wvaeo8Un5hZh
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 06:13, Yuho Choi wrote:
> efi_run_image() returns without unloading the image in two cases where
> the image has been loaded:
>=20
> - efi_load_image() returns EFI_SECURITY_VIOLATION when an image fails
>    Secure Boot authentication. The image has still been loaded and a
>    valid image handle is returned, and it is up to the caller to unload
>    it.
> - efi_env_set_load_options() fails after the image has been loaded.
>=20
> Each such attempt to run an image through 'bootefi', 'bootm' or an EFI
> bootflow leaves the relocated image pages, the image handle and its
> loaded image protocol behind.
>=20
> Unload the image on any error before do_bootefi_exec() is called. For
> its other errors efi_load_image() either sets the handle to NULL or
> fails before it creates one, so initialize the handle to NULL and only
> unload when it is set.
>=20
> Fixes: 6b95b38c41a6 ("efi_loader: rework bootmgr/bootefi using load_imag=
e API")
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentica=
tion")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Unload the image on any error before it is started, not only on
>    EFI_SECURITY_VIOLATION (Heinrich)
> - Add a Fixes tag for the efi_env_set_load_options() path
> - Reword the subject and the commit message accordingly
>=20
> Tested on sandbox only (LTO disabled, gdb). Forcing either a Secure
> Boot authentication failure (efi_secure_boot set to true in
> efi_load_image()) or an efi_set_load_options() failure for three
> 'bootefi hello' runs left 8 handles in 'efidebug dh' without this
> patch, 3 of them with a Loaded Image protocol; with it the count stays
> at 5. A normal 'bootefi hello' still runs and gets its load options.
> Not tested with enrolled keys or on hardware.
>=20
> do_bootefi_exec() also leaves the image loaded when efi_set_watchdog()
> fails before efi_start_image(). That affects all of its callers, so I
> will look at it separately.
>=20
>   lib/efi_loader/efi_bootbin.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 12db8f517c7..5bcb8c2540f 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -170,7 +170,7 @@ static efi_status_t efi_run_image(void *source_buffe=
r, efi_uintn_t source_size,
>   				  struct efi_device_path *dp_dev,
>   				  struct efi_device_path *dp_img)
>   {
> -	efi_handle_t handle;
> +	efi_handle_t handle =3D NULL;
>   	struct efi_device_path *msg_path, *file_path;
>   	efi_status_t ret;
>   	u16 *load_options;
> @@ -192,9 +192,15 @@ static efi_status_t efi_run_image(void *source_buff=
er, efi_uintn_t source_size,
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>  =20
> -	ret =3D do_bootefi_exec(handle, load_options);
> +	return do_bootefi_exec(handle, load_options);
>  =20
>   out:
> +	/*
> +	 * The image has not been started. efi_load_image() also returns a
> +	 * handle for an image that fails authentication.
> +	 */
> +	if (handle && EFI_CALL(efi_unload_image(handle)) !=3D EFI_SUCCESS)
> +		log_err("Unloading image failed\n");

Thank you for the fix.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>  =20
>   	return ret;
>   }

