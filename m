Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43408D3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C587289682;
	Tue, 26 Nov 2024 10:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aTMjsEqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 067D289A7C; Tue, 26 Nov 2024 10:24:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BCE8932F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732613075; x=1733217875; i=xypron.glpk@gmx.de;
 bh=yqhMVkOLMEQ/Yt3Y6XNP445Q83ltDWO5lavSJMICErY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aTMjsEqdXprcko0UKS+okLEjQVDfvyTFjDKIkjQxEDg4ub5Sd+DA2M8iRUbAGMZs
 vAt9W+11mx8vjvypIF+ZBJKq5K6YT8tyA/Gg5pSsSuEeYhvy1LSqvsps4lDHxwzlr
 3YArf2sGFYmyCEVCSuh1wof3QOQozA0EdvhqkyHB4SsCylEuZ55JIfwAkGxEUziy5
 QBXndehb9Ws27obVtUCuyamLjiRZ1z0rBxgYANpqZZufwYwM1kAMBHfbPJGeyDMym
 5/sCcmJDx/NxfGANuNS4Sl7I1wz2JJ0NDC/BAH4aWwD3H6z037Gm+vguN2U9ycCcn
 Aq5RoZqFrMPEVhFpWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1tOyMS1IKB-001yjf; Tue, 26
 Nov 2024 10:24:35 +0100
Message-ID: <b0c5a55c-bb35-4034-97c0-914eece1da48@gmx.de>
Date: Tue, 26 Nov 2024 10:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] efi_loader: Show the resulting memory address from
 an alloc
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z6LumdFDuiG45iBa4/rp0IFPYV3wh6GEkmeMz4XbwEMssOFkZgH
 zBAjiRXux4bSKTxSpPhvY6ZeHdvcO/ioAIU5QhD0v6ecVXPxwFYp6hkYQsnMMKeQ/genEo0
 cNE9Lsma8gwXepx/m8f/0PmNz43x6OdmAejTZTsR1kQvpeIQ4XlgRVWCfysBDNDdlmcZVIa
 3KD+OUrAUeaFmIopnnZug==
UI-OutboundReport: notjunk:1;M01:P0:iSNY3D//qy0=;srF46T6+Vz9VQtvhcorxn5k3ELV
 KFXDrhGmPfgzCBX/H1H0vZdt97CaUObPAX/v9qMmzyb+aaHtRnhE8VWYS8+h4jYnirhKLjy1m
 XLt2pfXMIg9wlKUXFvUulvZHUR38evTaFGJYqfPzSzHKQcWFSgUmeEJUSJY96Gk/ydd+2VAJj
 838szCbJ/6YcTGchAvGGXv2ce7bxhrjk+wALobiSGpxh+M0bdbWtXimT6XoswgJs8uAfccXtA
 UwcydTTV3g0l2HNM4L03er+cjjxkt1JGBgEr4pDdNbqS3gSteTxFwr1ZqxIgo7ldqHljbObBx
 5CrtjXzD9M053cveIfkXVoWGgSFXiS3zjfyPpf/PCdT8ISq+IAG963jnpibxPYBIqDGI1R7YW
 C3FncJrj28TYf2q7k/cy/wHS6WMVDwMW1JrjUgMkLNZSn3LW67dGlzWRJtowXjpW/UdT8S0L4
 25suaIRSBdV5v/iy/gkRRkAuIAThJ3R0Gl6VriQGqgBXRzII3L90G5q6W4oNgl/b4fwprz3AC
 Udm908hqT/Jurlwy4jsUcg4lbOLW0fx54UJn2+ozN++fu/+8ZUgG1tikWFHYESz1Q1GJb4Tic
 wabWcJhCs/UBAUjKNvug7+x1RERNO/E8up/haXA0pLUnEqNtaXI/VQ0REGjRAEQGLakmqnneV
 FJMSDG3Ws5xoa16n1c23Bk84ysi5ogAPZAX0cCJA0DN/RaXHptsTyBwRIx9ygCtLXtFihJ0n7
 JQI1l3h7g+C7hqjqow/nseAA3WsI5l75s4PEDcLbE1HNclfLi7Hqn8Hu8EUIGULUSRiOEyrWA
 TY1MvboiLNsy4yvW21gBzVbMSGm3ffOeda0P6maZQAZoepTUqRioO1NBsFQDig0rruOWwnjmU
 25OjxceuN/SDx9/2GQq8qRPv8mvDQJhozxt0V0v7KBBAkBXl821nHQ7Wj
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

On 25.11.24 21:44, Simon Glass wrote:
> Update efi_allocate_pool_ext() to log the pointer returned from this
> call, which can be helpful when debugging.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_boottime.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 080e7f78ae3..90437e3e401 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -511,6 +511,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int=
 pool_type,
>
>   	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
>   	r =3D efi_allocate_pool(pool_type, size, buffer);
> +	if (r =3D=3D EFI_SUCCESS)
> +		log_debug("*buffer =3D %p\n", *buffer);

Please, use EFI_PRINT() which will provide indentation.

Best regards

Heinrich

> +
>   	return EFI_EXIT(r);
>   }
>

