Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3CEC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 14:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1619B60667;
	Mon,  7 Sep 2026 14:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id USX4bKH4YYKw; Mon,  7 Sep 2026 14:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43C8960639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788790563;
	b=gOHgCyo2CRzKviB4n1F5qC5sPWfjs9SvNr4LqiYqjSRGaD/mCVwkSswK6jFWYvKSGFV+
	 YjpOyK3EJQVWSryRGAg9z3l30auJNt2Md0fyHOt+F7kd9YaUwfuasf6ehfCum8g955n3W
	 nbd8sXCa7/8inTcnEVtKy9sd0qYbOcAPYT4QGQA4r5ZedAVA2dwtiuhCw3bhZGhoxayrf
	 9doj4IOEd4PRAzK5K6+GB+FPlkza4WeoaS0abp+E87v3jshkir4JiKpl8VtNWxr9zgU+N
	 dnF+SUr7BDXkmkiTbVNrGXC9B5iRnm6XwgWjNwJdr24uVJAnY8J8yPL0uCjpw622YZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788790563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=n6oduqIgObB5Fx2IfATV7AxsoETggt/mcCBwB4B7w1M=;
	b=q3kEBS6ypZk8PDgnBjTE01ANX2Yl8gtamBGlm6LxED1wVcqZObMQAHCDKOCd3qdTy+VW
	 8GRgWHMHzx5z72lHItf4boDOWwVhBrN2DyFVwrqnOjV/DMfAmw+xfEw/rbq7T4P42tflr
	 37CiIOPRWADtOFCS21dW/Tb6W5dbQO2CWD8mz4Y3RDmIneGer8edeNMYFlkjxpKpCBIhn
	 maV39BlW8NDGL/hLrJ08B8xJ+Lc34anmauXFXtAgqaGAcKcvJn+mH2mtuCUKDuPxhYdf5
	 SNtQy2Uud3Zz4RgnbZUowj92jZFvG8CTt3uiU2hRvTdE8X0HRse0DI8JrfSZoq5ECow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788790563;
	bh=n6oduqIgObB5Fx2IfATV7AxsoETggt/mcCBwB4B7w1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdbSBmIMCqIj/PdGe0beBULPfGWW1jSpDzaB6MD75DilvNPAhzUdL6zzMpZ7lKu+y
	 I5uhjoJzlCPje5sUVgvNBg7dQoLWPnx6/KZc6XFQAoeJGLcSCCEHSOsnoH3kfA0YKi
	 4guAQTkgragJkm2AHkvtVVsO9kbd1j+YVGZ+aVAyyFde3BSu1aQkgNHfn0tcPkklQm
	 OWtDLDKEmEPWIV8+iv0aYC4nQjOTyjcl8jEF2JlcQi4+X5Xzt+bURKyaln1spNj4Cp
	 ypnyhHJVn5G0rUxrvsXngsXv4vIoCdA6TTB4WfcjMCUTiSDvRPSah/wqkxIvibs7l9
	 v1qFwApGEd+CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43C8960639;
	Mon,  7 Sep 2026 14:16:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDA3629B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB35740067
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:16:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E16WOrF5yIx3 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 14:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AB4934005A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788790561;
 b=E1ga5PeiOzaPoFPG4Q1ByqpTYHipD4DenMAOZqY+Nx9ZUGF6IbpIt64bb82454e7JLKy
 EIzbvIR1JaASu+WhbPHk2DqkX6Hti2kbS+S+XJ2WUWq75RKLL0TSFc/kRlXM/qx7RFnYM
 xIPeCB2f8Fqkz+DonQtzTKWDCm08g3HoEJSuvEaJHJHwzUgjyJrBf42lr5HThJs0Ce/7H
 b28QXROQNIx1TfGrFR1luOaGew13JzJylVlyv5qkz8N5OtmmHApBR2B1v1aORMVY4WRko
 D9KInfglVoXTtY+cuegcwEKizZpWuOQErqtZ3IPQcCkRPwlyXb2Dp0E3rBUNz13L3/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788790561;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=n6oduqIgObB5Fx2IfATV7AxsoETggt/mcCBwB4B7w1M=;
 b=PkeEXDmYDHW1nzEH/9b/Ur3KpZnqxovZWr7cbgKNwwLeiyDjecHK50J3eonSyVIhYXva
 Wp51AJJTpikwGpQPL1EpDK/x7t7lYJEKUSouEFQACqu1tNSnIVTXvYPznUcZ0ZbUkeZPX
 rQ3BTuVC8haaoAnv5TESck5DmR2s7btAx5xzaV1qhc8fet/eOTUDQJPZQ+T9kwwEKX4rO
 +HVMR0WU147EGIYp8ghk0/NtLw+2uHfEoddtBrp2WaL+9LJH3aHoi/bGOsaNiStCF80gh
 hkw2HNv8o6KlMkzIV1tC6J5j6zVqCW0RKd5Z/YiO+93iBkhhIMVxk6u0uLsj9tzoMuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=RtllRpfA; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=RtllRpfA
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB4934005A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788790558; x=1789395358; i=xypron.glpk@gmx.de;
 bh=n6oduqIgObB5Fx2IfATV7AxsoETggt/mcCBwB4B7w1M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RtllRpfAuZV71hc0ynOHS7Qe9IX08sMxYNfndk/oA4+QLZcK8e7LgJ6rQCcmfS15
 4Eh2jGRYe1btdAz6KrZE/cfAaY62WRqWFa8r4/M2L4GQodehipPfGxJuoJ6sVIGMI
 Xo3boxjaRlZn4ocoi6/gWLhyXJKe0iYHzDtOBB8Enyv0WUk2RLipF5P0RsasqfkC6
 nC/lrhFswzIwqFt14QvuMHLn+I9Is+FrbQUVN0BG9HakuZ6i2BFd8iQN7Wfm4Tqbo
 42q9aqRhg2yIX/QJEy71hC3WqWCoCwnffjdUZB9+sZ/L6uvIbDAX1XzKghhcas2oP
 qhjAo2z7+Ln0DKn7Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1xCgpA4C8X-00BPEK; Mon, 07
 Sep 2026 16:15:58 +0200
Message-ID: <f0070fe6-08d3-47c2-be2e-3e5d232e341f@gmx.de>
Date: Mon, 7 Sep 2026 16:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: pass GUID by address
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260907-guidptr-v1-1-5cb72c450436@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260907-guidptr-v1-1-5cb72c450436@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OnqAgJ2aRfryYigET2FVrpCF/DOfED2lE9DewteU5SChWG6AJzu
 hlyZXCUWVBw3hCiKfMAVpbVx1bR51Tk4DBs8iGGW0N3qyKO8ystvGe3kARTzd/HDQHnI0dq
 YxW63H6/ZP7wcfGRy2qP7AZjI3hH3RDo2RwUcUqKmCVAERPukO2SAIaWLLEq1s12TjcS9UA
 IzDa/vS05kp99YFUgtMIw==
UI-OutboundReport: notjunk:1;M01:P0:ES+dMe7+qp8=;yT0H8VQ2e22Du/kDAcf8k0XmFVo
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/7/26 14:16, Vincent Stehl=C3=A9 wrote:
> Instead of passing a GUID by value to the hash_algo_supported()
> function, prefer passing a pointer.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Yes, GUIDs should be passed via pointers.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_signature.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signatu=
re.c
> index c2be5cb61b3..21a96426356 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -166,7 +166,7 @@ bool efi_hash_regions(struct image_region *regs, int=
 count,
>    *
>    * Return: true if supported false otherwise
>    */
> -static bool hash_algo_supported(const efi_guid_t guid)
> +static bool hash_algo_supported(const efi_guid_t *guid)
>   {
>   	int i;
>   	const efi_guid_t unsupported_hashes[] =3D {
> @@ -177,7 +177,7 @@ static bool hash_algo_supported(const efi_guid_t gui=
d)
>   	};
>  =20
>   	for (i =3D 0; i < ARRAY_SIZE(unsupported_hashes); i++) {
> -		if (!guidcmp(&unsupported_hashes[i], &guid))
> +		if (!guidcmp(&unsupported_hashes[i], guid))
>   			return false;
>   	}
>  =20
> @@ -219,7 +219,7 @@ bool efi_signature_lookup_digest(struct efi_image_re=
gions *regs,
>   		 * if the hash algorithm is unsupported and we get an entry in
>   		 * dbx reject the image
>   		 */
> -		if (dbx && !hash_algo_supported(siglist->sig_type)) {
> +		if (dbx && !hash_algo_supported(&siglist->sig_type)) {
>   			found =3D true;
>   			continue;
>   		};
>=20
> ---
> base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
> change-id: 20260907-guidptr-9865d0f0dd1b
>=20
> Best regards,
> --
> Vincent.
>=20

