Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355CDC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 16:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B2E81703;
	Mon, 10 Mar 2025 17:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="LKBZ4Z4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC4D8168B; Mon, 10 Mar 2025 17:22:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60838168B
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 17:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741623751; x=1742228551; i=fiona.klute@gmx.de;
 bh=2Tigppzpl6Rbn3XNnKZNV6s0qYXGRasVzqBNvIaNdvs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LKBZ4Z4ezZDAJxU2wm65K/w1wLdxxfKS3eRGEwytg+YsEcTnad7Ef6eZA4K1Qjy4
 YW3xs8BQ6snAf8vASGgjpA1eXT484hQxehWq1RxES/iHNXg4WatmG6N/0YEVeBmFr
 7ScZiR4vBsHYXxsmTYoyP4PUrRWC16c+4ZdZLdTaNZ2+nTdU+Ih5ddBvDLRs3CGyC
 l+G6MAKQhII9tYrGVa4fOoTKmahx68W2E9OVbdQ0boHRVqkbxA26K9czC9ck/sTgH
 c+aqlkEYFlLH/v81WbMWRptaf2VIdsTV1kU9A4wpSoE6a3NZXruNzAmue3hUmT4qJ
 zjiOGMQ8lEPYXiH3Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.124.30]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1tw3cN1Vho-00BBNn; Mon, 10
 Mar 2025 17:22:31 +0100
Message-ID: <044bdce4-9844-41a4-8060-3e67ad33451f@gmx.de>
Date: Mon, 10 Mar 2025 17:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Raspberry Pi: copy /system/linux,{serial,revision} from
 firmware
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <20250211135829.3467088-1-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8iGppHectPmhFCwkB2AxP5eilBG5j7s9BXuHv7+F2v5c4IVuMSy
 7Jr/Od+lca4nB0wkigzP2KBkUAYisWW+4SXQhPeWz8uKuWC+rXWTbzGWnSjJAKgV4a+1L2k
 2CBr2McsnY1ZtlDlO9AyGMRKDmxIRgfG4PTU8ap1POqYv8NPAHznfA5H8sCKb++fIcOmDER
 wArMutr/hzTlYH2CpsQOg==
UI-OutboundReport: notjunk:1;M01:P0:jbNh7dLE0rU=;EcereHpNp6luYP+bFP3hJLK4qaL
 Ht0QKC6W15+fEB7k0t+8msG7FX7WcecMxoeelalIlr2C2slQHbG2+YwKk6PsL+bkLJdYKPM6g
 iNY5vvbtZxUAXx6y+t/A+vKnwkVV2UsSXY2q0Qq3pOZqv7YWD+bd+llogh7zWyiTvvM+2LwLA
 GqNOUAWAYqcUui96yM+W7OATjDGMyk2DtTIB+1ebW6wPNuMazMu4H5cim27Xvao0rH7uePlUc
 Ye4MJCVk2rgbzWAZuALCdJM1C30VvYWUoKBnMBQM19BoPlci+FBu6IxxfNE8FzWf48v//g8bt
 1AuoqKph2V49ybRy1inT5QrvSTVTUnVpk3/d4FFTgADXOqRBsOWG6TvNU6WNwYjJFCiauaum3
 TXg4TImgjrzbPRa023Pg8PYsQZSdfI2v66nVH3C3nSg5aKKoKsg2BiXxIZL4OsAZLThZrr1mB
 mkUVV+mPeod6bWV/89+nfOzdLywgtSrQvj+CNteToGUyGuqvsrkbC9XSjD9p1v3qFW9HqfgU/
 sWI8rn7GUD9QiDl6/dkfzhTdPR8o7XXjTZMSx55ZlT0ftDzBeUK17bARheJShrBVPOFhXR0aM
 tNSETSuTZ94t6iU2e8eUChhpV49uC3A+Xqg1akOv4h7ZIes/ohhnrbPLudWgINuy+YGmCR8Bd
 7qggQ5H2Io510uYCV371Rcbt2GtRK3+Qdq7pemlIkUaf+DJh+jKuRzYmjKqR5m/eZuYqYbwup
 SqNScB2qgGEi6UgVNI+rrvX1LfVuObqVdJFYvXea3/UdgbAEyOgDfogQFTuvGUpUFfkQPLlpb
 hjTKCVmzOIUTqo1FrRdIfI4/4jWhCIZ/IrbTjljyYlxiLJIxigWM6227Tu7lgem1I+8do7Nmd
 OLJugmSHCeLIIjEh0BWW7sAXx0c8uoSGQAspys7EFtsqdVjmqF5puMmt18n4iSKANqipMQhzI
 Wz5kT03mfhfdjueh2bkkPillwQ4GbSYe93tadgetdPBuHEmMgikC8/OTIziQBV3WDM9H+wzEL
 9RebTvFiaIWQ2/Z6du6oorQEWj9LNDS/Rfm3cOeEe5By6SfIuEVA4X74Vrvd9Em+TXZd5PlhP
 WLrH4QXSyZ4Yvv2gISN5Z2lq/Ef+LSDPFpqujzE55mzphJEr2ZnTubhuj2xstTMtipIzuOrp8
 RUBFRfHfHj4fbXE/gJOMqyilPix5LlSfqscc1MJ7AEQ1CEO1/yu7p7j7gRXJ+plG3t6dkLkxJ
 s+Zp2lP3+tuniBNXCG/QibjSFXNWaGM2h+rQ18wbCnjixCr629fbSs7Dg5mc3I92L6MsJECs+
 FESGi9z13hufWFk4HWHDAA+wUXPI8mAVmHos28d6TvYq8qY8udmEMHo8K+x/7Ar2sWRlmHAA/
 ZtPEKxOZiKzn6DJ0zZfW+sKrhFCp/Avs3Uq2SM25RHS74tEnRt4Z83/yk41MFNa1ZXD8lVX2C
 AMm4+sTLbZvYyys3WER92RezpBjeaNC3zyEDdlRvc7kF+5whu
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

Hi everyone,

could I get some feedback on this patch, in particular if creating a
temporary overlay is the right way to create the /system node if
necessary? If yes, I intend to add error checks and minimize the buffer
size, otherwise rework it for whatever is the better approach.

Best regards,
Fiona

Am 11.02.25 um 14:58 schrieb Fiona Klute:
> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> [2] use the revision property to identify the board, and the latter
> fails if it is absent. The firmware creates the /system node, so we
> need to do the same.
>
> [1] https://github.com/raspberrypi/linux/blob/0f292fbb6346b0576615290207=
6895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> [2] https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852e=
de5aaa388180da/rpihw.c#L579
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> I'm sending this as RFC because I'm not sure if creating a temporary
> overlay is the best approach here, advice on a better way to create the
> /system node if needed is very much welcome. I know I'll need to add
> more error checks, I'll do that after I know I have the right approach.
>
>   board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index aa39afa338a..647716127c7 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *path,=
 char *property)
>   	return fdt_setprop(dst, dst_offset, property, prop, len);
>   }
>
> +int copy_system_node(void *fdt, void *fw_fdt)
> +{
> +	const fdt32_t *prop;
> +	char fdto[2048];
> +	int src_offset;
> +	int len;
> +
> +	src_offset =3D fdt_path_offset(fw_fdt, "/system");
> +	if (src_offset < 0)
> +		return -1;
> +
> +	fdt_create(fdto, sizeof(fdto));
> +	fdt_finish_reservemap(fdto);
> +	fdt_begin_node(fdto, "");
> +	fdt_begin_node(fdto, "fragment");
> +	fdt_property_string(fdto, "target-path", "/");
> +	fdt_begin_node(fdto, "__overlay__");
> +	fdt_begin_node(fdto, "system");
> +
> +	prop =3D fdt_getprop(fw_fdt, src_offset, "linux,serial", &len);
> +	if (prop)
> +		fdt_property(fdto, "linux,serial", prop, len);
> +	prop =3D fdt_getprop(fw_fdt, src_offset, "linux,revision", &len);
> +	if (prop)
> +		fdt_property(fdto, "linux,revision", prop, len);
> +
> +	fdt_end_node(fdto);
> +	fdt_end_node(fdto);
> +	fdt_end_node(fdto);
> +	fdt_end_node(fdto);
> +	fdt_finish(fdto);
> +
> +	fdt_overlay_apply_verbose(fdt, fdto);
> +}
> +
>   /* Copy tweaks from the firmware dtb to the loaded dtb */
>   void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   {
> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   	/* The firmware provides a more precise model; so copy that */
>   	copy_property(fdt, fw_fdt, "/", "model");
>
> +	copy_system_node(fdt, fw_fdt);
> +
>   	/* memory reserve as suggested by the firmware */
>   	copy_property(fdt, fw_fdt, "/", "memreserve");
>

