Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD6D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDDE89067;
	Mon, 28 Oct 2024 07:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="L0f/ifH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252CD89067; Mon, 28 Oct 2024 07:37:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537488906D
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730097446; x=1730702246; i=xypron.glpk@gmx.de;
 bh=Oy75JcNASKoQ22O7b3s9aVpWESNzZvuwq40DbmuDTGs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=L0f/ifH5DECTBC5sUQbnoF6PuJx5uKNpdKbdTrizCVfHyWj9aL4ObZGYfq+5ro0A
 iOHWJzr7cXttkEza2d0WipBPSSMhq5DHU6ariEJo//wT9scO1L9DP7dicQz4jmtgH
 dgb33th7x8R01IkZm0HLtOdkMMWnxfw7eMQZA7E5o4klPgY3Wd4tDGqJIn4Pab6iw
 GgY6/+pl/OK2wu0zvT/W8rObs2YAsYzwxLMIgG/JHMoTaNXuJsyaOIEvmx5tPH4ck
 fqrQvLbWSQwtF9xkoV0IIbmaaDZcr/VVVsnXzsgJGokILMSLBMTf4nzImXJJ4/078
 rjxGmbj6n+z3wetQHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1tKExw2TSU-00NotT; Mon, 28
 Oct 2024 07:37:26 +0100
Message-ID: <06be7096-2e06-44d6-ba00-55ea578121d8@gmx.de>
Date: Mon, 28 Oct 2024 07:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Correctly unmap memory after notifications
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ipdl4/PS+4O6yPEUYn8RMlEwF4vB5RiBoT3dfdGt0kSmW3uvVOZ
 e075hYaBq36BPN+zcc5Ovl1iOzAcWEzQJ0fQsDboyFfF0okn3WdpLnfy6TUOoFrGwFEFYVN
 EH9t0NCl5aBJlnbW6dSBevjHEbCHO7iAtGsNnj76tAmS8z5jo0CqHGGdrefAN+MuGYd8lIl
 w7SP7SwyS8gb+mB1VbKJA==
UI-OutboundReport: notjunk:1;M01:P0:Yf/eo5hhv7M=;wJBSj4/uZApWtE49I7udYBvMdva
 gbC8Wud6LsBP7wkIyYF7WeznEvq7p86tXboQqYbKWNiZpJPfabB2gSPQFgYdxmm5XnJa1q0j5
 t/5kwuGSFoqmgNluAFrIpB4x7hA4UDr6zghts86A8w5hDHYzkV2PbEdznp69ejqjAL8gPLe0Q
 RhsjrpDMhLEOcRM3IY+IktI6CWButLRmrtFVeRWP4Allct1NpmO8/+OzH+ZNot9cEQ16wrASc
 vn5sC1D1UlH4b73I2wzbLXZAX7LNm4KYmPThXFZQ8FE+uNAlvloo3v/p81eycrt8IDrDMlLlq
 iTH5LwWExqzPt4AYleNPdnEIHbjMyxZr5JBs+gtXRnspYPVsP1HGGc84RoGTJSbLkkpih918A
 VTyV8q6hPlDGrrhGfs3UY50JUwOOihY4v4E72nM30O6wfWsu0gy/iGGLr5UdjlzvkCmqq/FIi
 FhD6QsbRbRjvQJgk5CibL4QJZAhLYtniFvEf1KFuvZd1Wq1QHesCEqoXsaTJmTFIFShNWOblf
 RgfZYT9j1yG60uvsgcW3puOt37gK4nbh59IvQcZPO2XzMUuSQwAWEUaj7oBX0O/5JS/bTPjGW
 39i87cGh+mZrYtx0yzbiqasvtVUEmjoc1CQXaBvUorHBjnJAsG/KGNuFjJE+8r7hwUM02CEwd
 CcQZX1vpY9/J+N5icQwgouH1zp2hdm9gdqoMdcwOQpBWRdfyTB78ZG3onLsfBMrRXZ0C5b8jO
 rwR2FD1ou+uaVGgMX20Sv2jkefOJZV1sjMEPcukrRqjb7k9SZFlPdirvB2uoG7Jw2ueuy0FF8
 EvukNN3iCpqRIQ2Zdq6KxrUA==
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

On 10/24/24 12:46, Ilias Apalodimas wrote:
> We never unmap the memory used to update the EFI memory map after
> notifications
>
> Fixes: commit 2f6191526a13 ("lmb: notify of any changes to the LMB memor=
y map")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/lmb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 890e2cbfdf6b..38c6e1d5ba8d 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -65,6 +65,7 @@ static int __maybe_unused lmb_map_update_notify(phys_a=
ddr_t addr,
>   			status & ~EFI_ERROR_MASK);
>   		return -1;
>   	}
> +	unmap_sysmem((void *)(uintptr_t)efi_addr);

If PCI memory was ever mapped via pci_map_physmem(), I don't think that
we want to unmap it here.

Why do we map the memory in this notification function first hand? Can't
we use len =3D 0 when calling map_sysmem()?

I guess we have to critically review all map_sysmem() calls.

Best regards

Heinrich

>
>   	return 0;
>   }

