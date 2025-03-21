Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11455C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 11:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619CC808A2;
	Fri, 21 Mar 2025 12:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EOPOoUvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E479081219; Fri, 21 Mar 2025 12:47:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F184E807D7
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 12:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742557657; x=1743162457; i=xypron.glpk@gmx.de;
 bh=d/4ua8Bk/jvZR8JBQ3NRqpySk1JdIHbkpKiHde/lPI8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EOPOoUvC62Ujv8ZHJI1pNbuLg4VitgwXdrd242pZLvZwRqXp8RGFQGJ/UlOoH/ig
 Nk5DH3gvUwF0Yz2ARHHqozoFCbQpzLwNRmyvUcwbPcHp5U908OHJcLq/kzsytJ9vp
 tnfgGeCwTmozdyqZMtUNq4xHYg4FFiKimMXjiRBI8xoR+zgBKGSIF1RU0RdAjGFh3
 GC/5PigVm0dW586BkouxwGqPd1jUNickA7MylqJkG2ZKCjftud9uKmhtPWL8x9fGM
 GhPcNRehyg6YnrS0y9KcYwh2iIFzEMP8vLKpRTwxvMpkwt0/ZcBAEKhG+qyVb9i8O
 rCCousm/AyWsr9sI6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1t75f62cQa-00uRVO; Fri, 21
 Mar 2025 12:47:36 +0100
Message-ID: <d308b128-5a3c-4d77-ad04-0aa5c8e87006@gmx.de>
Date: Fri, 21 Mar 2025 12:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 43/46] acpi: Add a checksum to the DMAR table
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-44-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250315142643.2600605-44-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nc31ig0KDDEj3wpvgV0ISHKOvrfjprlNgbD7rMwWMDGGGMWf5+Y
 pv4TeddEGe8ga/oLsFWF0Q/MiQ950bj3aRB+QtOufWFWPPbc1TZfhY7BAxbz251PpFKhZ1k
 wNks8er48fq6OIoToe9Tv2YDoYqbNZ9Pn/vODx6GLsfv7aeEbJM9Il90FAfa9P75Ob+NK/y
 /Hrk4G3kNPQL7bG09jtiA==
UI-OutboundReport: notjunk:1;M01:P0:umg4Vy/TE8M=;+Kvij/51RUHFTKhp70JW6yEyKTQ
 kIKC/O0a6jgSHqCqoWUauk9naM1WMvAq9tS21iPOmue6MZJrBxe9yhuFWJdhLpeVH43VYP0tm
 gDd/mni+EChuzfgMWCZ1k7uSYegXehfTr9miKZwzkqAWk80G7RrUfzI2MbIWdxec97Jf51hK6
 6ut8KWwhUk+bawhP10FRcksHOE+9ibiNzyBrrxnuWk4J7DVc4oS4YSYYDVEAKefVQcUrFoZt0
 S2Y61qB0+5y7RCpMhyQodTt7oSKjlqvyjseZ1H7Qv8u6pSBWTkjBwbpPxy/TuEzQmeIjnbEkb
 t0acQVxiYOin00xmVw7zpwtp1zMtbXaqE+3KFNnLIQgsKffUQFrkSg5HOOK2YY4y9tp6i96Ed
 UOVQlj3HFdIobtipDLmNUfv+AdT1SOuQV09IpOgp2gERacj/MHW+zftAruAj6yUsp4EPgWQtF
 hY1LT2/RmBSxgOZUEkdY817Mtkk3gBJi2YpZyiz30GyVD/loIVugyhZEzm/zyUh1eocgPgKgA
 nJON5c+736ZvktKD3GTXc9S1jAs6i03XyRRoyKgCqQjVxDY9Mdc+j5UXs9ODKqodYvMcaswPB
 w1AIU10qDLUIah5rkg/gPn+b934f4jB1ZwdajLAup+1cysQI0eVO4mB/7RgI6/Cb8WGCGap1o
 16GzEZy5krkxOsqpxLMmXAzxYOJQ749tyTgGxEx9mnZ0+Mw77A9NZPfzzwBhs5uIOd76CLQ3Z
 70+PqrZ0xi87Uu0QG1Y3QsjZmXKaxZvPl01ZUevNOxfm2zbhGhnZ7tY/W7Bcylv2sSS+chWws
 HPNaW1Trpc6rMGqjvGHB/yi7OCoymHGm630AoCEWa5a37M83PhEPrR/gJwS3VMSNyrDQfpQ++
 xdulQtdQfgWsYZZqjEpSQsswDtpFNSKNY9Y9cFHD+8kdrw40zVTfUXaDik90UBwmcKFduLnRt
 vzmzDVJnITRliqEb1q57jEeIsyhlsn1NBYpgG3+PE1xFz88etnO8WVYaU4jwZDST6WFYll/XY
 iJScPlHjGjDggyzDZ9tK0vUm5+7wlBhrfHi4tU8/JPxMrMkm7q7N60sFMFZFQwZNI7bR1ClFn
 RYrx92JRcL9AzX21I+NBml0XoZtptCoAjqv4GXXcDje9OCMihiYiU/a/zBf6AbQiaVOKDzjdM
 58LmLtppv/Q/hNLtkJCzEPEkvAyFf8UVNK8Bu3ksTgpGRUCt7jxw1cWT1p/ZbEqsS1K8RngyC
 oNac1YlamS5+zX8/A4uqjVEJMjQnpOPVPUUcjoiKlMQDgtZI0jLzedN7HcIS9NXJloLOThX/2
 3pRhhDBctYgNCbpY5CS0MhypEGdAHw21uXJNenIQiEEZAgty55Z3rXhwFByGd15aHx3brC1Rb
 L5sbR7/u9PD81+i/9oFls53HOUFD8cg0mlEN4g4pUW9ETv+MJFn6BICUMieMPP6VlMFQPjtXF
 lmIqvdRmO/ObDPnI3TqK+Iu2dMrk=
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

On 15.03.25 15:26, Simon Glass wrote:
> This table lacks a correct checksum at present, so fix it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to add a checksum to the DMAR table
>
>   lib/acpi/acpi_table.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index 3805b61159e..4044a64d688 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -66,6 +66,7 @@ int acpi_create_dmar(struct acpi_dmar *dmar, enum dmar=
_flags flags)
>
>   	dmar->host_address_width =3D info.address_width - 1;
>   	dmar->flags =3D flags;
> +	header->checksum =3D table_compute_checksum(dmar, header->length);

table_compute_checksum is used for ACPI and SMBIOS.

In the ACPI case header->length and header->checksum are always at the
same offset to the table start. Shouldn't we introduce a new function to
avoid repeating ourselves:

/**
  * acpi_update_checksum() - update ACPI table checksum
  *
  * @header - header of an ACPI table
  */
void acpi_update_checksum(struct acpi_table_header *header)
{
	header->checksum =3D table_compute_checksum(header, header->length);
}

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>   	return 0;
>   }

