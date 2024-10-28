Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FBD13597
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9C388F0A;
	Mon, 28 Oct 2024 07:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tPTH3RY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB87089038; Mon, 28 Oct 2024 07:23:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3FA88360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730096628; x=1730701428; i=xypron.glpk@gmx.de;
 bh=C7SZBs0zMrIeYe4/8evLMwYoIv7glEcrGUJhJSfFiFY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tPTH3RY+NVRvI59NbTAPtRRGQOlS79CW2e0UAIy31jbx/urmW4faxWlxgYojaO9Q
 iH9veIrKy/whQV7MNZ1Nptb5R4auwLkiYra1LoWzLMN6zE+IlA8UOxYejpkzH5TRg
 zeJxlEvBv3wt1MbCGvD8ioCl2O/tGoi5kbv3mC4IXF+m6e0xCLKGdCsjWRPn6nbq3
 6H/ss86TXs53x9Ak3aemYz3uINBb/ibWNj7fMU8SgAjOtzfznBhx/t+A1Exk/FXZ+
 CZQusP7Fb+15WTA1SOUbiNhWxrvdnr3OAkEqMcQyRUWnNfD7HKauttrw5jyGcZWm1
 qplQqNDcrA2pnOJYQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1sxc3k2etw-000G9i; Mon, 28
 Oct 2024 07:23:48 +0100
Message-ID: <f79ca2f6-f591-416b-8fa2-54a665b2cfb9@gmx.de>
Date: Mon, 28 Oct 2024 07:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Simplify efi_free_pages()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241024110156.1353756-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241024110156.1353756-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+aPouyk6/C4IoVwOBCbXMm1ZVvincfnmNf+miKzDYJhOW8we7A
 h4za1DebOvwfl3lgUCE9CAOv1WzeWMbw1i5bzMTo1cTLkvEjoEduFmY4SlaB9M3Pv8kV5nV
 kU9+E5A+Zj/ci1x1Yr98EbIr+Ovh8L7Zu05lrlWuckNUxJyXRqhdRXuM4l7O6Ssz7GCBuve
 Y/lfeXuPO8qCrET8q4B7w==
UI-OutboundReport: notjunk:1;M01:P0:g60+tNoXHc4=;1oNhvkqq6VwhOIcQSgtqr5sr5Vf
 1fTJ414ikUW3f7vrGCGvqsjVC6TEwnFGtkrUvomABM0rifwrEL8H6i6BdOyROi99HA7ORAEXG
 tsW/9lli9FOhUIyb+k0WOnt7/py4fK3YlUSoS+vttXsNEZBPFdY6Fr/KK9x0CyCpQr4PQ3RwN
 MKUwwDlL4YR0rE+MKTpWyVYDx40xVv6ToleJOSuuC6mWr3CbR6RfMDhEUh5Y3Dg5ElXRii5rg
 QR2CGOxfU00k671lWJJuW+xuWUKfHVmJdaLjtLrHZ7nWxzS4dksAt9vpKYK71lx81EReMwfm+
 Yxs8MdV6DXaMjpWceL4QUZwtA1s27kbDMscfrLk9uPe3VzJhASdSP99FfT9hxrI4wxbgAa408
 /QBa7fVIoknSaeyxzgnipN68dTKz3ewuh+mhGuoij5hD7TaLEKKz0VHdYfr+JlzdRsaXQO96o
 p2ZL2ZH6ZNG+4VERQruFyu7j0cyWAGiVBc5vWb2ANhIvhIVmThY50OeAbolOOwZEgDNFRURpI
 3h474W8XXO0c31VhRcTHQvvc1ux3PBENbhMR/S23iLT9fVWNUvyIC4gw8rpUYDh/kYAzNKX4Q
 ZIfbufArosCgm5v674Gw1sTdvKISoGYqYk/G+iTyk7MObYPfgstP1Vp5980WBHktlTi2fm9Gu
 jqufc8HHXSNRebCi+TfjZ02HOzz0e4oNBNWyQPfIIGksgsmVhb+tZ9srf8t3WbMTSeRT9Xr13
 EpfcXxUOqfXpPTugL58MUZqT7NBvyyf+wfE6BUtD3Hco2gYXNHyNH8Z3DFxIM0nGbGuUlSSl6
 eBjoeZQnpaNUR9SBuK6ZNePg==
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

On 10/24/24 13:01, Ilias Apalodimas wrote:
> We currently call efi_free_pages() with a notify flag and explicitly
> update the efi memory map. That's not needed as lmb_free_flags() will do
> that for us if the LMB_NONOTIFY flag is removed
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_memory.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 84be5532a655..e493934c7131 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -524,7 +524,6 @@ efi_status_t efi_allocate_pages(enum efi_allocate_ty=
pe type,
>   efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
>   {
>   	u64 len;
> -	uint flags;
>   	long status;
>   	efi_status_t ret;
>
> @@ -539,18 +538,17 @@ efi_status_t efi_free_pages(uint64_t memory, efi_u=
intn_t pages)
>   		return EFI_INVALID_PARAMETER;
>   	}
>
> -	flags =3D LMB_NOOVERWRITE | LMB_NONOTIFY;
>   	len =3D (u64)pages << EFI_PAGE_SHIFT;
> +	/*
> +	 * The 'memory' variable for sandbox holds a pointer which has already
> +	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
> +	 * it back to an address LMB understands
> +	 */
>   	status =3D lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), l=
en,
> -				flags);
> +				LMB_NOOVERWRITE);
>   	if (status)
>   		return EFI_NOT_FOUND;
>
> -	ret =3D efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
> -				    false);
> -	if (ret !=3D EFI_SUCCESS)
> -		return EFI_NOT_FOUND;
> -
>   	unmap_sysmem((void *)(uintptr_t)memory);
>
>   	return ret;

