Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5B9D70DE6
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 16:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9278789D27;
	Thu, 28 Nov 2024 17:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r2aOU23h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB10089D34; Thu, 28 Nov 2024 17:50:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971EC89D08
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 17:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732812634; x=1733417434; i=xypron.glpk@gmx.de;
 bh=zEdzj+enp68DHm8b+5S9M8d1RC9M1L5o3zF5LgL2+mE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r2aOU23hzfV4WbRv+ygXLZGPf3JeRfQYgdyMiwbuqVI45K6PqCxFCF+R2gALpZmT
 zfiFhaTMX+YhZ+j/o2phE/Vur6pE0nWt42sXcC2goiJrECgo1LU4W8bIeTBL4Cds+
 XCVzBLq9wZsiIYpAHz24wSrZhWoL2Fklt75N19QRpR6M6Yzvlb8ZTs19Mafyl38YW
 bOFOGXBj+ZPP7FhDq2YfC2FluWc2eInpeym9LipChC8hNuRbtcpNmB2kXH6Yy22tl
 h1MmnK5N1UO3mXZElDga+/+MW+ZE2EbWs4guxmn6afbv0iOx7G6VgpyCscJ7I6PSR
 VN+s/ifzjRzfcxGuiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1sxEtX1Lrd-00SFiW; Thu, 28
 Nov 2024 17:50:34 +0100
Message-ID: <f97773e8-e734-45b4-a5ac-074856dc6acf@gmx.de>
Date: Thu, 28 Nov 2024 17:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/28] efi_loader: Drop extra brackets in
 efi_mem_carve_out()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128154727.771871-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:msRXfSBotQrUtxJ5BG35mxop1QgVTtd9OSCyFQhMtjmPrB9QMI2
 h2D9xrxfCmLO1k62vyFjfA06r7EDt3UrCaRy80IxGMFHO73axNkEG7mbZmBNQWpEc44/C8v
 a9s0hOx6GrU3sRWekSndOptI2Twc4+VUkm++KQUmfPWw8lbh/Qbetn5XynHWpVKM6FpMkQv
 OJG2r4V3H4wJSR1lrt9Xw==
UI-OutboundReport: notjunk:1;M01:P0:EkD8eodAruE=;uDJNZxNrUmvfB7wu1ciwyPdw8m4
 Tsoo+bczrMLuw9aavq8SVkrv1PQRfOp27eKC+6TisnoptDDao2GRFBxnpYSrpqjlnduXHQEcN
 ec89VPvDNSoPMRy8dJLkhl79rqJxhgWaJVWoxH8bRngkyfwOIekl7VQZYJdMEl9MN0E3r82Yw
 Or+RGoWLoZcXToqAYy6dIfKI5KPPvbhDN/+UTn/bPyhgM/UQ/vBgr2u3BKOpf1d7U5UYCdvoo
 pYrSJUE4QacMH8nlpXAGA62ZpSzDBxGBUVCj9CPV6f7dmgpSZ3jLsQUJhtI+8SpNf/OpgPDZk
 NKnzKP8WYASP8donbLNg5B/BJ3DBLtwb30sdiXKCoY5pPNXnQcwZdoChfBpx4GX0gJuvRBFaG
 OgvBuVRdMmO6y8Y4k0bvWc7Ua43dXjcP5D6vJPbrhJHu9CoswZGX9nRULh86K8gv8duBAkn0z
 6gWotKqP/S8QtVMeWmrJ5kfpd2NL0iwJq8s/J8dmdNVM+3M2NZlvBBDFZx+Dv32kg9ypyBATT
 j6MuIPePOkatnbdB5jT7QK0wdO3nNHiKQl37pfhUPe7Sx3BpWLsA8WwJsP7IQIBjkMmwiSO9M
 NmpRJis2mjetzp70cO3aWrW+dvnFSNnh3uL0AxgP2mCnlJQwQRJeh5BPlTMn2wHr7SnYoLrLs
 eIIWJ/GVfqhVb71neWwf0ttq3NOhLGhuE+81TDwU7oOwA1exj2KsE3yajICSozBD9eqMZMBPi
 rkeYt3rL25R8p33XX0CnaOlfdR8LjXEMVE8+ka+BSLdmgN09vl0MmGGO9WfLE3vn+6JUqH5M7
 QV17Gqhc2VZDcxBpbkRPRKKI4cbjwzJP0PtBtQ4WRt8T/twuoiC3lfYHi4cevZh9sJY5TIx57
 rtg0gQjQYlOUbuNpdT8yjylYxc4ijIxEZPY+jv/j8t2tB5HQuVSbfUbZiVW5zgIS6hcyq99Y1
 s/AXgdO4TTm0TGXKAZW3wypigUwJ4iuBb4Aw+dNJ4kel4a+a4quJkXALMl2xN9wlYJud/giNw
 1oSWu9iZAnEpRJ0ExcW/DvhWFJoPGPQYznpg3hSlAfa7vUDL7RKzvp129n+Prwg4j37W7ZmIo
 5MSRUvqaw9WoeQwrsTMU2UfUAnUmDi
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

On 28.11.24 16:47, Simon Glass wrote:
> Simplify a few expressions in this function.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/efi_memory.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index f1154f73e05..3b1c7528e92 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -206,11 +206,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *=
map,
>   			     (carve_desc->num_pages << EFI_PAGE_SHIFT);
>
>   	/* check whether we're overlapping */
> -	if ((carve_end <=3D map_start) || (carve_start >=3D map_end))
> +	if (carve_end <=3D map_start || carve_start >=3D map_end)

As operator precedence is not always easy to remember, some people like
Alex and some static code analysis tools prefer parentheses.

>   		return EFI_CARVE_NO_OVERLAP;
>
>   	/* We're overlapping with non-RAM, warn the caller if desired */
> -	if (overlap_conventional && (map_desc->type !=3D EFI_CONVENTIONAL_MEMO=
RY))
> +	if (overlap_conventional && map_desc->type !=3D EFI_CONVENTIONAL_MEMOR=
Y)

ditto

We should get rid of this code as it duplicates what we already have in
LMB and generate the UEFI memory map from from LMB.

Best regards

Heinrich

>   		return EFI_CARVE_OVERLAPS_NONRAM;
>
>   	/* Sanitize carve_start and carve_end to lie within our bounds */

