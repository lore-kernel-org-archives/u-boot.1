Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1D8E7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACD2896BA;
	Wed,  4 Dec 2024 13:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="prEJZ3A0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5EC0896DC; Wed,  4 Dec 2024 13:47:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFE3C893DB
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733316469; x=1733921269; i=xypron.glpk@gmx.de;
 bh=/Y0zhX2wObs1OS+bVNcgFeVk1v7l7nIOBSsVO7vjKfE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=prEJZ3A08IZ/0cbx2VyCm5XCZhMoT6h43p2qr9oWMGoHHXh9mW01ovs8SsI4cch2
 HRDqrax2EHZB+PDr1qScghMVtsfMPUCb5bLVF2GQ8jxv/pOv4Omg37e7eFGKcNhgx
 U+FGqfb/Zkp//ut97ihQVSnYkYEAJYbR1yDo/dl+s4OP5r2XTlHEe6L4CEWyJ/H5S
 /w4obpce0RZHS2eMIGxrKTjMErivcxcC332EXB1ufGTmHeuEnNZrOAPzwR+aL9JaG
 n5t0HkFhw9Fl9LhqbgINWiuJMciH3nHALUhq+b9o/qgIdyvtQ13SQ1opw2qL4nvS0
 wN24h6GNzPJvDqtuwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1tIonF2zbc-001RCW; Wed, 04
 Dec 2024 13:47:49 +0100
Message-ID: <c65feed8-a92d-4ea2-8e59-61a3460616f1@gmx.de>
Date: Wed, 4 Dec 2024 13:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Check for a valid fw_name before auto
 generating GUIDs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20241203161338.1814537-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241203161338.1814537-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r05K8lsJo5RmPqjq/MHSjnEoQCl/faY25ptnXs3hOiiBPnIyPnL
 jRZL01anpuhSsILB7sCuvLIUHtwwPGNz1OfoGrpkIe2gzBcFHfhM0nEHO1P6izh+8maSYWn
 4vZ2O4IMhosAMvlXk2bsM2H5fxm5CF7U+QGy5zgo1aAXIP5KTfGIklc5wyScrheOBv/kn5m
 BV57STuj0lYc2MP9lrSJg==
UI-OutboundReport: notjunk:1;M01:P0:yWL44QAIQCU=;P2e0f4Og7YYPyar2ZxLWBhqhz+f
 kPScsq//TxRxCaMTGyQK9dqx2GBETIXxmQa3eBpFNX0afq7+QYxRwVtWYUQmxqgp2Lf3Dulqf
 m57x1OuH8N3fZWUrvFBVKobArtkIr17iG7P4wJQXQ4rZsI++B0vn/iqnUchcVP8QasigyGhJe
 5buH4S887iVbkCXBH/Np/4Z5H3CqL2TkNMRLBVBaLp7zKsD/z5bIxHbT52zwt2JoiwVV27ihx
 rWcoEKAczrliafT/aHWEuEoL23pt1ukfGRnRZBj+wSYCx7KtXhYTCUxkelx8ewfEXIb4OTbFe
 orSRhMeYK6gKuhGyopA+bQJZDZSRQnK7bzODF6ZpZzN4El4lI1S2TsBtyW3FTio6+5XG7dFvP
 lqXf6Uy6MBaIeXSrEg847pwNemso6DbNhNgiERdbRz/zB68sN6+2Z9Nj0/Iw8rFgY5e1BHs6q
 nTWACZ5fFb9T+9ewk2ukOY3/O9RB993P4zNwpy8U5dNkBMedHXKjCcP4SV/qisel5lQWVTys1
 IghGWQnqi76zlzXnAcjwc0OSjrqcFD69fAfaCG5zjR0GeMrx+oQt2+eOcq+tNF5FP/ykXSFwX
 MqfkWuMM7lpMJyv7QHOv24Ar/jnDNRu/w/iKCqkgitTaMEjBulOIK1o8WaoNRmQPSQDAHUXUp
 e55SgfNGS3v0T0tj3dWYA7iU989iAG35T75kvRAODfPbbGWD28I72FF0U7EQ3AtoBWFWuCwrd
 w8yA1+IIlL2rzzruF71IeNQCP11rb4yZBaA0dZuYCvClQP7sqLm4hauYGjGWkO5wGVCR23mfz
 vOeYQ4crCbyvOE0FVay09M3Fx1EbGOf3/DUCxEV4Sg/zwZnZ+fcLpLZ7LJQ/S9kR79XVs1KtY
 BXkzPsnP8MggQGTdasFdM50yHG26vs/1b13kTtediqkhX8e+xnwwrUrLC1aybejiLzg8NVzsd
 RmqNS814dpgVFsF5cYjBoZkQzWEf0RMMjDYEsLag6hLv6MPQNlym9nmT8sjdkbctmlQwLQt7V
 JQdv9TtSsZgu03+Lc5nUdncJ9bw+cXYuiXMY5EGWNeQ0jk1xlC7Se7F+68NqVpnIOaCbYvZJM
 9vyqlhRcPMd06iTCDgCaIpwsaVjRvI
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

On 12/3/24 17:13, Ilias Apalodimas wrote:
> The gen_v5_guid() is a void and does no error checking with pointers
> being available etc. Instead it expects all things to be in place to
> generate GUIDs. If a board capsule definition is buggy and does not
> define the firmware names when enabling capsule updates, the board will
> crash trying to bring up the EFI subsystem.
>
> Check for a valid firmware name before generating GUIDs.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_firmware.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index 6650c2b8071d..112775daf4c3 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -281,6 +281,10 @@ static efi_status_t efi_gen_capsule_guids(void)
>   	}
>
>   	for (i =3D 0; i < update_info.num_images; i++) {
> +		if (!fw_array[i].fw_name) {
> +			log_err("fw_name is not defined. Not generating capsule GUIDs\n");
> +			return EFI_INVALID_PARAMETER;
> +		}
>   		gen_v5_guid(&namespace,
>   			    &fw_array[i].image_type_id,
>   			    compatible, strlen(compatible),
> -
> 2.45.2
>

