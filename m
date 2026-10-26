Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7D606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tI9H0k//;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=C5JsAAbX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D456E405BF;
	Mon, 26 Oct 2026 16:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Je0uuKCU9aS; Mon, 26 Oct 2026 16:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BCA8405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031844;
	b=ApuOi2If7oQhc63RC63EoOjFSxYmjmyS/RxeTYAqrHezTkp07QZHuh0363ZJDld3cwdi
	 02G77TDsmmnVIko2AFjHPvUK1pS4VaV9CFMs/pE1DWNOYVe3+Trm3+ED1J2tweA+1tAWT
	 I1Q2YYXk3KSaZ23o7nsZFf0y7haZZ5ji9wo4O3+47iMo8iW+ZaXBLW5K5fDRSfKwIf1km
	 AcVgWd/zu+Nvio8jBQNROVmhQExyRfzIfvMmvhdpfKH+/d7/YxjLJlWTHS3f5KcQgWXwd
	 AQDjfJhYcZ8Lv1DkN56rtjPHx6qPqfdSyK1lvMjUBkWTUWAPDCWAO5YGRAXK0aMfK3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lk2DBWN8fnZ9rPqp0GkoXikzpE+2iBPLQjeR84F2bS8=;
	b=SrnklUZmLEeoUCel+cPueQbzw3/4CPom6DQhII7+uP0hQeh3FGuwdqxoorl2OjkeAf7B
	 FELDcSckv2zBGKhGO9FAENrO2bCZhZ8N7qHarq+RmevaNFKEMoAIH2HiIjlKPdw161K2W
	 8K0deAKP/yFMX+FsoeDR3D7ViUDJ3ZcjcHBUtD6R2wukO5EVaLMePMwanwn95RLneNliB
	 x70j/MZ14K0C4jFKEb7B2BykzljK49QI6BWMpm2Rq7CJNd8tMT1gdBLc7QGAs7v4NbI0O
	 AcyeEeRK3QdE8eMQhjSOC7lkZKnC58b8xnvhjLXv8WyeIWfmTlhisKHc9ICimH9RqGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=C5JsAAbX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031844;
	bh=lk2DBWN8fnZ9rPqp0GkoXikzpE+2iBPLQjeR84F2bS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tI9H0k//CLQRmT45dW+BX8xCGjndxbrYZ9emsdXitx3rxS0ab/Rbm32eJizk58M4X
	 IrJFG4UZaMRH3433XSdhrafoxgQlqCa6GkOJR4nwPkfaskkcKLN5+vMR4Pf3erXB03
	 r7sJTY9kCsSJrPmvM+86GyhcLltkBgw6JmkP31r53XLWGP7IUkdE/437IB4wKHw1IJ
	 l2elxjawXxwyybCcHp0B+m74lV9M23EFKVft8s5Ypk0xCJ18utlKeez3G7J4m5Mu5W
	 lADhjAmRgoFXm7nK5lP5XNDWYvPYGF3RQUaCirrTZH+1toV/F34CFVYXPUX0VzMqFZ
	 nxtkLHZJkJwjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BCA8405C9;
	Mon, 26 Oct 2026 16:24:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54ED5235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B1F3405C9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlA-iDeWVORL for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:24:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC4DA405BF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793031841;
 b=bdlbeCwr/yoDcd01VChOsYRkFJmeCbkH8mI0k9neRr67A98cEQN/8cdFNvU5m+4ocNOC
 INpQS7ywimFpEC77N01oHRirkz7NggVNB7w9k8qQ7aIk5DrgjXNbrMgmiBxRvyBzS+uAZ
 Phx/xi9ngEa8IA5fHBdNp3JGrPVIG36RLQPMohlAq7igGJDyGzhECBqmq9uKqx3gXhw5C
 fq3tJtcEtBNZMqqat5JaMKm1srVuFIT29rvO14tTKSkda1nJUvrupp/YHjcL5ZwULt1cZ
 JDUnqU/B3KzvpXgLxeMgtDDdEPAKqU3rIAkVD2zXmhPfaJF2/Nd1oGLbmLYit8fKYAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031841;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=lk2DBWN8fnZ9rPqp0GkoXikzpE+2iBPLQjeR84F2bS8=;
 b=ovDVzVH/+uY3HJV6DZKTtKidzvUXVVGx9RxqG239f9OHr50BzCR5I323EI7XGSjqOLUd
 66Zk51d8u0GQoe+Y0DB7BdUMGEF88Dw7ct3lIiCOZwo2QQ3KapOTyyGHFoXu1pFiUI7Cd
 KgVIdO8hg97jybhaaTObcTGfRiSKuIDkiBEGhkg2vf/4gLFxLxPSlc2y3quzj4sJIQz7E
 p1X6q+SqobcmkHB93Q6zjntH6gTun0kkUlPdo8S+O8mdfmPERSpM8h29Z+cNseuZH/Mtb
 /hDfj5oNEBLLtaQimWJ7GJxWiuzhmxqz8HV//URTmcNE2tcfkxaOYe3FzVhFEybXT4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=C5JsAAbX; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=C5JsAAbX
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC4DA405BF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793031836; x=1793636636; i=xypron.glpk@gmx.de;
 bh=lk2DBWN8fnZ9rPqp0GkoXikzpE+2iBPLQjeR84F2bS8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C5JsAAbXkWnPSr0on3VvjClfvtFhZxhv8LESMufsScSKuDzZ2gMlBA21jEiJl3ub
 VPmG1w5PCoNJhPwzqfRMHUIDHtG/H3gp4jNVrfI8zeNNEkIVRrRjzgGF5Lf4TCqVm
 Y2OzJU4WNOS+gOX6OzGncKt+6A2Pei10Qe/3IREWTfLGWP7rehaLZB/u0ZebxmbpX
 +g6xrE1ljpdFwgC5+kojgQFLZ49bxEIyNBZewH8NJlK0UIrV8s+Htepwsj3WSRUYh
 Ak0CAjvJ3uoXF3abUs8etiJvsxqH/MQLayml6gphwkyHylZlwl6EDat1xnJFxjvoq
 y5FXcQgTPbvjohh2tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1wPPHE437r-0142tc; Mon, 26
 Oct 2026 17:23:56 +0100
Message-ID: <42290a47-959c-4ac3-8e5f-35cfab8441ca@gmx.de>
Date: Mon, 26 Oct 2026 17:23:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/6] efi_loader: capsule: check the FMP capsule
 against its size
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
 <475a43be-9eb7-416a-a501-77f39f9d94fc@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <475a43be-9eb7-416a-a501-77f39f9d94fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hv22qEMXD4jE1tvcX9PPalbWAuzog8WzF1b3DzWbOxV7sb7leo4
 /v6313A0ZU7av8oWYNkqbo8UMG+jXEzUVep2HDwRXTLQKe3lZoh+K+ThPpeQgXWxIZG0LKz
 yP7ftvfZnbnJP9Bs2BaahN4+HoDNAyczoYbgbN4oOOO0aCQY99qB1yhe2J7rmnLQxOwM79V
 2D3gPHQsdhYVjHjzjryYg==
UI-OutboundReport: notjunk:1;M01:P0:oP4YfFQmwlg=;kJqPyB8lJ8ZHTrJMeTXtkA4TL0k
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 14:19, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_capsule_update_firmware() reads the FMP capsule header, its item
> offset list and each image header without checking them against the
> size of the capsule:
>=20
> - the capsule may end before the end of the FMP capsule header;
> - the item offset list is indexed up to embedded_driver_count +
>    payload_item_count - 1, which may run past the end of the capsule;
> - the check of an item offset adds the image header size to a 64-bit
>    offset and can wrap around, letting an offset close to U64_MAX
>    through;
> - update_image_size is passed on to the FMP driver without checking
>    that the image fits in the capsule.
>=20
> On the capsule on disk path all of this happens before the FMP driver
> authenticates the image: a capsule file in \EFI\UpdateCapsule on the
> ESP makes U-Boot read outside the capsule buffer the next time capsule
> on disk runs.
>=20
> Check each of them against the capsule size, and check that the vendor
> code fits after the image too, along the lines of EDK2's
> ValidateFmpCapsule().
>=20
> Fixes: 8d99026f0697 ("efi_loader: capsule: support firmware update")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_capsule.c | 45 ++++++++++++++++++++++++++----------
>   1 file changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index e8835315e86..a8d57630a6f 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -538,11 +538,13 @@ static efi_status_t efi_capsule_update_firmware(
>   {
>   	struct efi_firmware_management_capsule_header *capsule;
>   	struct efi_firmware_management_capsule_image_header *image;
> -	size_t capsule_size, image_binary_size;
> +	size_t capsule_size, image_binary_size, remaining;
>   	void *image_binary, *vendor_code;
>   	efi_handle_t *handles;
>   	efi_uintn_t no_handles;
>   	int item;
> +	uint item_count;
> +	u64 item_offset;

Nits:

item and item_count should have the same signedness as you are comparing=
=20
the two below. I think both can be unsigned.

Generally I would use size_t for indexes.

Best regards

Heinrich

>   	struct efi_firmware_management_protocol *fmp;
>   	u16 *abort_reason;
>   	efi_guid_t *image_type_id;
> @@ -588,18 +590,27 @@ static efi_status_t efi_capsule_update_firmware(
>   		return EFI_UNSUPPORTED;
>   	}
>  =20
> -	/* sanity check */
> -	if (capsule_data->header_size < sizeof(*capsule) ||
> -	    capsule_data->header_size >=3D capsule_data->capsule_image_size)
> -		return EFI_INVALID_PARAMETER;
> -
>   	capsule =3D (void *)capsule_data + capsule_data->header_size;
>   	capsule_size =3D capsule_data->capsule_image_size
>   			- capsule_data->header_size;
>  =20
> +	/* sanity check */
> +	if (capsule_size < sizeof(*capsule)) {
> +		log_err("Capsule does not have enough data\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
>   	if (capsule->version !=3D 0x00000001)
>   		return EFI_UNSUPPORTED;
>  =20
> +	item_count =3D capsule->embedded_driver_count +
> +		     capsule->payload_item_count;
> +	if (item_count > (capsule_size - sizeof(*capsule)) /
> +			 sizeof(*capsule->item_offset_list)) {
> +		log_err("Capsule does not have enough data\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
>   	handles =3D NULL;
>   	ret =3D EFI_CALL(efi_locate_handle_buffer(
>   			BY_PROTOCOL,
> @@ -609,24 +620,34 @@ static efi_status_t efi_capsule_update_firmware(
>   		return EFI_UNSUPPORTED;
>  =20
>   	/* Payload */
> -	for (item =3D capsule->embedded_driver_count;
> -	     item < capsule->embedded_driver_count
> -		    + capsule->payload_item_count; item++) {
> +	for (item =3D capsule->embedded_driver_count; item < item_count;
> +	     item++) {
>   		/* sanity check */
> -		if ((capsule->item_offset_list[item] + sizeof(*image)
> -				 >=3D capsule_size)) {
> +		item_offset =3D capsule->item_offset_list[item];
> +		if (item_offset >=3D capsule_size ||
> +		    capsule_size - item_offset <=3D sizeof(*image)) {
>   			log_err("Capsule does not have enough data\n");
>   			ret =3D EFI_INVALID_PARAMETER;
>   			goto out;
>   		}
>  =20
> -		image =3D (void *)capsule + capsule->item_offset_list[item];
> +		image =3D (void *)capsule + item_offset;
>  =20
>   		if (image->version !=3D 0x00000003) {
>   			ret =3D EFI_UNSUPPORTED;
>   			goto out;
>   		}
>  =20
> +		/* the image and the vendor code must fit in the capsule */
> +		remaining =3D capsule_size - item_offset - sizeof(*image);
> +		if (image->update_image_size > remaining ||
> +		    image->update_vendor_code_size >
> +				remaining - image->update_image_size) {
> +			log_err("Capsule does not have enough data\n");
> +			ret =3D EFI_INVALID_PARAMETER;
> +			goto out;
> +		}
> +
>   		/* find a device for update firmware */
>   		fmp =3D efi_fmp_find(&image->update_image_type_id,
>   				   image->update_image_index,

