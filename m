Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190A2C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D1382C55;
	Mon,  7 Apr 2025 09:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TInVyhOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249DC82C87; Mon,  7 Apr 2025 09:55:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59E882BCD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744012502; x=1744617302; i=xypron.glpk@gmx.de;
 bh=L1EBCwR4sK0ESWqC74K7wFNnfR75r2z6PMlJNO6gTCQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TInVyhOzKjZfx/PKqWG9rOV3mZQVvvk1RWOyMX7ABGbUmLSzlupMbvMTIxI82ZcN
 BAw2UpeWQf3W7i7Ns5b4CT1o9PqLX1U9wGOBVVK54cfZf72ZAwfvmSxa1ocSmBppc
 T+EfZYmod/vKWxpgZM7uwXGGA2Bk7kE+DiSKCdE+4pO4SGuerHnSXBzFdzFwe4A0B
 qLYQNfWNk55MoifGHQ+KqgPPYp/bVU/eI84Nrm/mXTD/asN+h/9p/zinNPPWlDVvU
 YFl/7oVOxziJ9CZTjzxI2k8NuIZOCVZSJv3QgAFQBzplFqPRc8bMUhnk+NaJP0UEM
 2v3UcFgqCY0C3Q9ElQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1tUIRj0E5R-00ihjN; Mon, 07
 Apr 2025 09:55:02 +0200
Message-ID: <e2cca54d-188f-450d-ba70-a8a778263a72@gmx.de>
Date: Mon, 7 Apr 2025 09:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] efi_loader: Move device-removal later in
 exit-boot-services
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Janne Grunau <j@jannau.net>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250407013513.638110-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ml+w3JYvK4a1PLKbmfiePv6UQl8gVbln7GeCpnz9m1Uk56GEQu2
 KEhbskmcmWQ7BH6AN4Fta19qQSRZS6e37ThJjte1twrcYxFkSij9ElhFrbPj/ImkNlHs5Yz
 aQTGNfIJhKBVEnMmzPO6PAC+0YfokvQLSjPhOmZXUm0+/yMIfCsVEj8xvouYi1yO5r8jpU2
 jigg57dc+IIo32OITpN+w==
UI-OutboundReport: notjunk:1;M01:P0:q2/6KVm1UqA=;o7gLFDbDCTRK0cOEdWFbSPybYsz
 +uAMpw3kbMTC8Egu8G5AfioRo/N4heN2mavLXKQQxq7iGRannpB9t1tOzHdBOJWB6Nok2QAu4
 YRrGOlhfOHF6RLOnmtTFTHfVFvlyAjfPRnEBvn4jOMP/05uhVyD98APnb8607lC/2hj3WeAF4
 +moWp09jEijiDCjILnaA+K1LpFbo1jbpM6V6dNYlb/UckSSLSN77ymJgrrd310TJjDXYwj8iz
 V5boalXtXR7vuVxpVxHfYfjX1R5IgUcGfTSsf6W0H9IFzcnhXh0VpnkqH2MSngXAS5beWMlop
 1u64eElYPVi30X5NrAQWk4RDosNIMfBoTSFWxnNwHmujL0gwS2fNPXF4lKzGc9aEk9UYZZ2PS
 Un5uROgu73X77Mo6uLrXb9mkynCzFbH52O8JLL16G4pIsKaHUZiH39PbIdgM9KHLapH0/b9K/
 qGk5uJC5mNKFsieXZzpzWqA5hviB6y/Wk3giVGPvmdzt5MiMsglRFFpPEQ3C/kzuU1RHkUold
 VE4+gvHkvylvO/rOB5vEdCEhwr2JrKdrnVorvR4Jau4bj5KYQ2ah1WqI10Xcce2VuhqPcBUrk
 54JlRATQaTnU7T7Gcn481uTIAx1APRrT/Jk9ehMcD+Sq4czSdgZnQO+1ymjGPC69rJBb04/FY
 NWbqm5UVnw8eT/0/LqiFi0GC8WUkFBg36rK7kyzNSgQZlVikEB6Z3wD8wxKicbfg1flrrAEpL
 4Ki5pB7p58zaibH7nZHlKYU/ozmJkC1icd2BjM+BewcndzZ8nLnhFeFI40hIPvkS14wSV2diW
 p22xUvf57JVGz6NdIrt9wQG1jKGhbBsL0LTTo8j0AjLt5n+c2po7RFskzNSEVo8SL6iGmLv3M
 KTKKM/qeGq5N470J/ph1hmKfe2aeWlocaZRCv4BnjA7T96gq9wSuyK3LHN0Dem5MxXz9pW0WY
 LFcrpQoUtb5cBtNCE14W60r6x+Lac52IZd5UG6riawyyvshCUZkvY/Y/CYhT9yLoN7Q9EDXLL
 Z2Vl7unpas9bwtOgBXyww1LoRorQQCW2Q6jUGwPvxnLzXjrS+9z1ULGqZVlXgDYiG60HajCYx
 Haa8bg4J8Lh2Y8UquCjcNFI15txVAvMHo1GIoziiVwnsQZr44WyDwIlwzduKocxzpZ1ZVuxsm
 VT3EPlVbML7y+JxQlganyf1hpgweb6h+hNfKVmXQxJUp8lyTFNBK7pjEW6fn0jx7xTmtnowWp
 jK1XxRuud8MLPSPqmhhLt37U/tov4MJNJ5sVKKzszgrvKHQ8Uug7QkVz/TyY8T6xAcsQ8Ti+O
 Gr2mUljbx76Bl36aKage7swZO+CAPTVJbg/xQQV2bmBdAmmrvAvM84DKpKY1w5iBTzPg3Gqrf
 ugbQl8YrevcAi+xnBU11f9kh3wgVkilkT7+JD/+5+qPQVJ42He8KUZquAkf4GeFbubTU5cKa+
 4KkMDjjxICj5Bc9MBDGNRpesACQM=
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

On 07.04.25 03:35, Simon Glass wrote:
> This removal should be the last thing done, so that U-Boot does no more
> memory allocations afterwards, thus avoiding potentially allocating
> memory which has been freed by a device that fails to de-activate its
> DMA.

The EFI application that is calling ExitBootServices() has been reading
the EFI memory map with GetMemoryMap() before. This is checked by
comparing the MapKey parameter.

Whatever allocations are done or not in ExitBootServices() is not
visible to the EFI application.

DMA has to be stopped in all cases.

I don't understand the virtue of the proposed change.

Best regards

Heinrich

>
> Of course, devices should be marked with DM_FLAG_ACTIVE_DMA or
> DM_FLAG_OS_PREPARE but this change is good practice, in any case.
>
> It also matches the code in announce_and_cleanup(), which we should at
> some point unify with EFI_LOADER
>
> So move the code and add a comment.
>
> Note that the TCG2 log is updated after this call, but I cannot see any
> allocations there.
>
> Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
> Link: https://lore.kernel.org/u-boot/C101B675-EEE6-44CB-8A44-83F72182FBD=
6@kohlschutter.com/
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index ffe43accd1e..e525662f82f 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services=
(efi_handle_t image_handle,
>   			list_del(&evt->link);
>   	}
>
> -	if (!efi_st_keep_devices) {
> -		bootm_disable_interrupts();
> -		if (IS_ENABLED(CONFIG_USB_DEVICE))
> -			udc_disconnect();
> -		board_quiesce_devices();
> -		dm_remove_devices_active();
> -	}
> -
>   	/* Patch out unsupported runtime function */
>   	efi_runtime_detach();
>
> @@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services=
(efi_handle_t image_handle,
>   	/* Give the payload some time to boot */
>   	efi_set_watchdog(0);
>   	schedule();
> +
> +	/*
> +	 * this should be the last thing done, to avoid memory allocations
> +	 * between removing devices and the OS taking over
> +	 */
> +	if (!efi_st_keep_devices) {
> +		bootm_disable_interrupts();
> +		if (IS_ENABLED(CONFIG_USB_DEVICE))
> +			udc_disconnect();
> +		board_quiesce_devices();
> +		dm_remove_devices_active();
> +	}
> +
>   out:
>   	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>   		if (ret !=3D EFI_SUCCESS)

