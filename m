Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1BDE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 08:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E530089420;
	Tue, 10 Dec 2024 09:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IUE/4Aqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5D689421; Tue, 10 Dec 2024 09:10:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F25D89412
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733818216; x=1734423016; i=xypron.glpk@gmx.de;
 bh=5owrMGSUNU2h6+7BaL5Vh70GC2DdZbP4Y3hv/ilAgYc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IUE/4Aqj6Zjhaar+nsxbtg+JmfIRiQi54Ig4+/oj8ozcJYWkPVnZ/CaZp/6t1hj3
 0WPqYlhVsG8Rk2MgqcMsCXG8VWGWqgrAA8QYJRdb+7/kvgp3qosGDK+ap4fAUzIFc
 Z+xh59Js2zZ4LZ53c5uFSZYZ74FuE9NVRbOEEoK+PZCy3yRoSj38ZCZBbPtk1EvHL
 BVMslNaJXllaVS0xMCUwIJSY7KFP5nqph9gjVmYXwNnr1nvaXpxmmy2lmJZ5k16Nf
 n3HQFD86lxuuKPDlhFPkD3+LmsCupHu9FR0BhaMA6/r5pJERrJyqJaK2/v7Q/bfLU
 yGP2J4t+ntQYa+oaiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1u0GTh1i4P-00pps7; Tue, 10
 Dec 2024 09:10:16 +0100
Message-ID: <c95a1f38-43e7-4198-8763-4856defbc9ba@gmx.de>
Date: Tue, 10 Dec 2024 09:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] efi: Avoid a memory leak in efi_bind_block() on error
 path
To: Simon Glass <sjg@chromium.org>
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-9-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241209162801.288363-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YC37FojBo256F7sIYvhkF3ws3Wyb5fDa8hLGonVBmSczqsKnLiE
 f/78+iQ7hI8TFQxJaPiLsBWij72y/TAXHOYvmyrku3cpttI7oCxnYbTLhKE95TJ2aNfZtZ1
 MUU2BajCttBRB7gKlXgVLjLKrUnHfiY4bFJ8Uwsi7Er2XZTcHjiSbr+p/EasTSo2BZwnA5F
 GspPFIpaDIAT1SmBXroTQ==
UI-OutboundReport: notjunk:1;M01:P0:Nycog5WP5+w=;ZsD0z9xNH9zSPkzvMwaaKq1tqC2
 nmt5lUZY4amR79v17SHbEdGLOcZO1F9EKKSPNtLsHZEpkoyxMsVYaKMr7rHNkhkb7A5p2ysAr
 MNugxR1TqOf6DKlJ8iTozmjSXK7e5F0T5zmyGw1xtXmeWgZKiEnC4kXGqchGzG5Oxrl3Q0Qcz
 hte7nZazqX/y8GohzVbZcluDP4dqWWvba5+yWD43E3LmGvaAJlXWT64R97pM9JhyuZAdyG+5Y
 IQGiFvk+2amNjPOkzElLOJb5qEHqmhJCnuN40z4QeQgc0kAY+OFIGYCZM6uRRGfKFW+jYLgHj
 7KkcsIC+D8qk3nxHI2ouHrpFogzV8+yl5M/zACgXaQcyZy2vQToRRCRQBwLhPR8qb7dZqtYQ6
 sM8MNAhI+pC8zfvPCVCFQTYoqp1gU/4ITte9QDi7t1bleAwjsmaFH2Uq6VCbMpK9FqQjKDqA2
 fvWX1K1B16LwduyXwHcdUZFnPenw3p1t1ykrEPVK9NS2sIJeVRdvqm4u3L11itjn8vWz2+s6B
 fIq+0Ab/SXiK7+wHMQkybvWNjmklIgONJATf6OdMAzZ2WKh1hGMVmMo/UE0ueqJs9PD9RGxxG
 Q6mFEPVETgiqZebJfTC2/sjtpdtvrxQND0L7Kid7zf5y72mf6E5zcfXJmQATMgmIEyfg2BTwe
 ZWmIm7PDwEKQeWFKPg97ZsD0WKjG1R6ZMXpNVzAGGMwEESPOccqciorOxDgX+FMccUpsgmE6i
 q1z3ljIMqNoV+G3XRd8FbEnJqywC5l9D/2SePYnmWPItWVcrKfAu5BWh8gxsdDAvlWZX/TsAy
 6O9vL/D/hvWKc0to1w8Noa4yP4NMk3cD6q/Mi3Ql8BoxZU/x8vkICs7MQulWVYiRStCENUIck
 yjJ7kAX4AjETWhvOK8WcaG1hpzZjuVLBQ+n6jCCSAH240jUv7q0ulz8wgq+M8mOkJhUHdY44j
 1Df9aZaF2Z5ng46ePyT0i3Y5Zxq/rqoltB/QyHcJbugJH8HnQ/FSkuwsH/NL8TuzNGQ6Zn1vN
 SYAnfmaSqyq/TFmvP1A5u6DwePlR5we6CFmNFmsXzNKgwXBansqmzYKSqtMgfjHtY3QgfcgfS
 B5vpGrXe+Rwhf2dqzkYH7mrG+tCvkJ
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

On 09.12.24 17:28, Simon Glass wrote:
> Free the memory used if an error occurs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
>   lib/efi/efi_app_init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> index cc91e1d74b8..fec3f348cfb 100644
> --- a/lib/efi/efi_app_init.c
> +++ b/lib/efi/efi_app_init.c
> @@ -60,8 +60,10 @@ int efi_bind_block(efi_handle_t handle, struct efi_bl=
ock_io *blkio,
>   	plat->handle =3D handle;
>   	plat->blkio =3D blkio;
>   	plat->device_path =3D malloc(device_path_len);
> -	if (!plat->device_path)
> +	if (!plat->device_path) {
> +		free(plat);

As of origin master origin/next (9dd0a9ecaa539ad) plat is a local
variable and not a pointer. You cannot free it.

If there is some prerequisite patch that is making plat a pointer, you
should add this correction to that patch.

Best regards

Heinrich

>   		return log_msg_ret("path", -ENOMEM);
> +	}
>   	memcpy(plat->device_path, device_path, device_path_len);
>   	ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
>   			  plat, ofnode_null(), &dev);

