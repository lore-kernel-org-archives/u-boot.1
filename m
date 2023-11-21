Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B5C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 18:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D062E8759B;
	Tue, 21 Nov 2023 19:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i3aQPfgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B158759B; Tue, 21 Nov 2023 19:18:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF0087448
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700590680; x=1701195480; i=xypron.glpk@gmx.de;
 bh=v0ViEAWv1sJKXK24POYdz49AZXl16bG1GGwhaEsv7qg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=i3aQPfgFYudaYdJgg+MdCosjr7piiXVemSRhKQqjJNWIDJNDCNw2qdJ9RwoyHkM8
 2Tw3bVgb2DSiANND7/dwy/D2bfrE8ilYkqixLuilMd+y53B89HPUw+xO1JbSJ0aSh
 SF5tAVr0sFdCjB0Rt89Ky+B7OnvT+EjrsepgQVqoZ/YHUL+EhbonGt+AAI8mY9R3T
 NPz54S7jLWaNBDl85l6BijGFDOOnp/piQ2rXJ8yXEBY931xBULefQIfNVv5JRsfk5
 zbyslYPHXWU8QbskH5dzDQXJi8vU/QKhZWQzpzqG0vNI9/jptVNuZscXf5o1Pc83c
 1tnPKH0EJPHl6P9U6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1qo71l1iu9-00HwMS; Tue, 21
 Nov 2023 19:18:00 +0100
Message-ID: <75b45f55-9248-4821-b428-11ca3e8943a6@gmx.de>
Date: Tue, 21 Nov 2023 19:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] efi: Show the vendor in helloworld
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUj7aKbEVfecEQI2uc3BGHoNAOA6fTj8IkEZxCUrM4vAqsIBDso
 0XozCt/OgKmGruQAWlsT6jDl1VKhmLcmgXz2Kv4XdYOghzUs9NJcEdqgQ8giYw8xjKrBNdc
 Q1Gd78y+jHsbRnpuzkE4o2lLPxMWkfObSYCtimOwCkksvgMYhZkZmgKzAy/PXv2b+9OdFVT
 hn3cYBwfPCOQt7hZeSi0Q==
UI-OutboundReport: notjunk:1;M01:P0:7PoMh0ybRYU=;dgwgjSOATZABUlUVT6bo8kPCseM
 ceYReJhnzp8c9+gvk9P+6OpvLHIKy32PT0l3G50ZHEdORasE4tJg3xqdaB1y5bOhSINIQcxdo
 EXV+KSdcmOHhAwydLobek7/CEoOOZ/1mmncjY4Ob7IZ2LFRCbLkq3NS/tx6lD9SkGOrOJsSjX
 1oIZ3NFL8DOHMu+JNm4c4DO5JvAD52P7vyKOt3hDxjbMxirlwjzxPxeH9w9e+b35oz1DvLd7w
 7XQKGN5jJOZReGmh8W8DAOgrdb5ZNOO+XmhDqxwUdqOSVRZzAagjVtMRsNJp8GJdp8Tkz6hFW
 +99CIfA3b/K7Rii+5Y/vntR08weUb1/RpnVpD+cwRTwSioDCk59q5SQxyi3pMCLJP5e4g+m5G
 TRhQf3+PgHeUdG3p2JaWdj6Nq74tAkit7ov2wuaU/5XX6/YCNyaCmeXrd4CMV5Of/O5fBYH9Q
 8dubMGu0cjZyd5IzwoPmHWCzqPVqxfTJgqLyQDFw8MKmSspRI/iGZkN+p3ZrNQJ8XIjya5pc8
 vSyLWL3LcA1imw7+R084flAr2kRsNWjO18LmnlXFbIVmLrrxKyt2KX3TXqlIy4ddusCnhyaEa
 I90S1Vdc/2gG+aSMP5Mgnj/G9ISJHIPQ5Ktn9spfMyvE1QY5hkDI6fz2Ae9PYZa6MueLwa2Ba
 T/yB9ncIz75uGqITCZTvdS6zEsDnGFbl8PaAY9c+egTNgsZLhqmfRfoB42OLk3nojzle6vxi/
 1pmJrp8CPyyHqw79PwQRtXJiqJQUXdhAZBsHO4u5zoWEhL5GQ2Nq7jTSqqwJn/VfCCXN5Alwv
 6sJqW/begt3TqzQfo67P0Rd0DwcnF1lUx0KoahJwJLm7twxZoBLKfL33XZ1zO6x5yRZ4c+do/
 jG9hGIjTUeclLscEt+uaRGUaOcqcTTGg8RRJsXjJYi+4LM7ONFkh1t1QtS7AnIN7LcMT4+EEJ
 R0ulBgmFANrXuAxfvQXaZpZyMYw=
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

On 11/21/23 12:35, Simon Glass wrote:
> Show the vendor name since it useful to see that.

With this commit message it remains unclear why displaying the constant
value (u"Das U-Boot") is of any value.

Best regards

Heinrich

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/helloworld.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index bd72822c0b72..1135d3a3c37e 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -234,6 +234,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>   			(con_out, u"Missing device path for device handle\r\n");
>   		goto out;
>   	}
> +	con_out->output_string(con_out, u"Vendor: ");
> +	con_out->output_string(con_out, systab->fw_vendor);
> +	con_out->output_string(con_out, u"\n");
>   	con_out->output_string(con_out, u"Boot device: ");
>   	ret =3D print_device_path(device_path, device_path_to_text);
>   	if (ret !=3D EFI_SUCCESS)

