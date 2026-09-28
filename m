Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C40CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5235980A96;
	Mon, 28 Sep 2026 18:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbOWJpY3PtZq; Mon, 28 Sep 2026 18:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7B3288099D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790621174;
	b=NU7LUlQ9lZ3Odgl4N0vnUcJVTONmpddldkDFnnj7kdHi2VyBz7+oYF+vpvCUxsKcfc6L
	 Tfij/lByThgsY2WjWsP30JCnLv+va6dIl1aRBAmNs8odKn21w2HWvCXWzrv1O56hbzqu7
	 J8x9G77NzZm4kQxTiJROBb/QxqlSjo29Ymgg5MbCBl9TRi+dJl2HpozyEP0LdjQUDCTSJ
	 tYaDem9LXRChhUJiU30u7VNCv7Xmen4uul30qfosNdQY6abbUW3hGshHXm23XALutg9Mr
	 xqN8ZqZ3rqy03SDNVuUxh/C2d9MniQCnaZINW0UGrWt15/JiCZKP88DgoFUtX+sls4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790621174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vQ6tdAisaqC8k4/H62pi8Xuvf+lC/uw6XM7Q8YPpSsY=;
	b=jevGIwNSINqo8Grg253Ci3TDs0uqKr+muWJwGPt+LZKjoULgAs/tkfgO4jsOHATRBys9
	 UrZRXwuePevytFhxx0DrvlQCZW7hDplospuH33BBR+Y/XZRriNIUwVJAztNc3YR09KA4h
	 E29cwCJ78gZgHs8QnJKnoI486FKCFyPedWaVwm3EIRGIIvRTt02qp3Ze1jAZrsQYnfzz8
	 Hth/BWW9coYayufz5FnUO7RyyUUg9a9f1ecLe/e6oNBWm9Rnp8pVrPei5u6zhjwEYG7OP
	 8xja2ZQOmk95es5XdQwu3/MNQyev3vOe+/zP3j/snS+Jqg9++rFNoZKcJ8pfIUz2DOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790621174;
	bh=vQ6tdAisaqC8k4/H62pi8Xuvf+lC/uw6XM7Q8YPpSsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2cT7mhQyWhT+DuKgBZRXP/y60yS/HjJyEXxAo3mXaaLBULuzg1icFwDSml/Y72Qj
	 vOrtwjlg156859Mh1v8t3EKlb6hyS9NbL1NN3eAWZJ12cm81B9zpN1B3flvSP+dRJf
	 J8fHomvGzJ5qJUTZ/Z2vBS5OCIKhI650ZNGXaO9hbtujaUK9wAJQ+0RVuTyRjes43W
	 d5izhsB6wL9IQ/pnb81fQFR5Zp2sAgAVH54PncN5Xo3cneKVyhSqh1TPj1SHX7CA9N
	 UfAefOd/WhbQJ5hiNFNlnpXvs1slNhTmS1bGQdtO0BiFDxnCRIauUGIEUGMMNdaqtf
	 GDKsA0FuL6FMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B3288099D;
	Mon, 28 Sep 2026 18:46:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F25CD1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 310CC401E1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bXEdT_SFWUTX for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:46:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E106D400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790621172;
 b=dY0RkyeZUt2RQrb+MswVAcpiTIRw6pMzGebcKmZPzU/COmlBXccvcskfA5QqPQhdai9q
 l1lDtbT4CQtHs3+oEGWS79sx5OKW1ToO8Q3BOXniUPcJa74REXgFrJysJps4cU/CgwwLG
 u0m1aRCb8V4rzcK5cBFtewUJYK6CtJ/yruwk4sUOqd6sLs1l8KyndJnomAZCp2dvvfEHb
 fdRK2egefCAnxr7H4ru0GjHfS01tidpum7jjlmD3olea2oD1MMytGzkr6JVYlwcL/mdtG
 SSRCmNhN063xDBEhBAHqMb7SWpdE3ex5Yn+K/RfHR2MDwXqySHNSy1BZqTVz78c4dYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790621172;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=vQ6tdAisaqC8k4/H62pi8Xuvf+lC/uw6XM7Q8YPpSsY=;
 b=bqBUpHXElkhe91/MhKP9JmguK/VsJLuqc9hX2x8Bls70lUcik8DpAZ9NIjErLMU9tOIr
 BW2602uq3jB5llcv24gOJ/XbLIaKi0o2NMNqk9rhBN7VfB/HP7SBOm/t55dc44ChmlMXd
 m5AZR09aHClyhyfCYYd9g/Z6veD3JIfI306fHJY30NFRRcn0RyBaPg1i6pZB0irkbm0cP
 6khTWsCGnM375vJEgznpDd4KKKtPBQiUIPmZXmGnIahR6Lhv92YvNG4A1xGcBRk2Ako/t
 /brsUOSaprZ3lHvmy5d1PaMebuR5EfEulOWp6Tx2fX9VcuDYAUCc3aB3XTT+yzPtJfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=qEysTZFM; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=qEysTZFM
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E106D400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790621143; x=1791225943; i=xypron.glpk@gmx.de;
 bh=vQ6tdAisaqC8k4/H62pi8Xuvf+lC/uw6XM7Q8YPpSsY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qEysTZFMvgyLHHexKH3TaS+UB0wVfrdR7FpU4Bri4IxA1A3pSS4DuW9H95bIwOTU
 NZR+tc0vNsy1OjGV0If4fvmxftOGlZBPJMPwXN9gixWP9iy8BkJdv//K/VjF7e43J
 2LoQjjP/mwO9/kRVjhdreGMX8vG4eXIH/IAyXf72AnsRsfWaQRE6gm7KCh2HGjUcv
 vWo1jrB90oNMoWqQE+XCdjKRVVKeqVjGCwumczwoMVs4nInWyVsPFycu/TxHARDt3
 f1Axabhp0tWtMhEcDi5ozh9wQQG2BSaCaKsIjGQodfbUnrdgZEzmpoSc+mxfH+79u
 0uRR/82Gd6gIACOWsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1wXmfW2dKj-00epxe; Mon, 28
 Sep 2026 20:45:43 +0200
Message-ID: <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
Date: Mon, 28 Sep 2026 20:45:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
To: Carlo Caione <ccaione@baylibre.com>
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, David Lechner
 <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CKLPFQkQycsmb7RkjHBI5RgxdmlcXnA5Ed0/uKLasWjNSN/rKw/
 6AIVZz0e5pRGXp7VeqOHfxL5VKyTUPY+PieuJL+FyMU6kQYMQBAHVPUJR/0H5KP0VRgw3YQ
 YglfaEnFck9jde4p4hrgsweKCpwsABl/CduMaIKQJarugLDiNVxH1145ExhSOiSM1oabC52
 T6+cKU2uZH3RSzzomipAw==
UI-OutboundReport: notjunk:1;M01:P0:SYWz0B6sLR4=;h2zygcEBvvJlNchZff0B//YYRBY
 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
 H+FK
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

On 9/3/26 15:09, Carlo Caione wrote:
> An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
> the FDT referenced by the selected Boot#### load option. This makes an
> operator-supplied devicetree ineffective whenever the boot option carrie=
s
> one.

Hello Carlo,

I do not understand what you mean by the term "operator".
Do you mean the end user owning the device?

What makes you think a device-tree entry in Boot#### set by the user=20
owning the device should not take precedence?

I cannot see any justification for the change in the commit message.

The series lacks documentation which describes how device-trees are=20
selected.

Best regards

Heinrich

>=20
> Only consult the load-option FDT when no FDT was passed. Document the
> resulting precedence so the explicit call argument remains the
> highest-priority source.
>=20
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 8938b214ceb..6b5dad21b06 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1294,9 +1294,9 @@ out:
>    * efi_bootmgr_run() - execute EFI boot manager
>    * @fdt:	Flat device tree
>    *
> - * Invoke EFI boot manager and execute a binary depending on
> - * boot options. If @fdt is not NULL, it will be passed to
> - * the executed binary.
> + * Invoke the EFI boot manager and execute a binary according to its bo=
ot
> + * options. The devicetree precedence, from highest to lowest, is an FD=
T
> + * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FD=
T.
>    *
>    * Return:	status code
>    */
> @@ -1305,7 +1305,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>   	efi_handle_t handle;
>   	void *load_options;
>   	efi_status_t ret;
> -	void *fdt_lo, *fdt_distro =3D NULL;
> +	void *fdt_lo =3D NULL, *fdt_distro =3D NULL;
>   	efi_uintn_t fdt_size;
>  =20
>   	/* Initialize EFI drivers */
> @@ -1320,11 +1320,13 @@ efi_status_t efi_bootmgr_run(void *fdt)
>   	}
>  =20
>   	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> -		ret =3D load_fdt_from_load_option(&fdt_lo);
> -		if (ret !=3D EFI_SUCCESS)
> -			return ret;
> -		if (fdt_lo)
> -			fdt =3D fdt_lo;
> +		if (!fdt) {
> +			ret =3D load_fdt_from_load_option(&fdt_lo);
> +			if (ret !=3D EFI_SUCCESS)
> +				return ret;
> +			if (fdt_lo)
> +				fdt =3D fdt_lo;
> +		}
>   		if (!fdt) {
>   			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
>   			fdt =3D fdt_distro;
>=20

