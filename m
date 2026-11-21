Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FF606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pIyu71Jb;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=dBEGRiVb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FEE1606B1;
	Sat, 21 Nov 2026 22:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVJtr_Ssvuh6; Sat, 21 Nov 2026 22:14:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB0E360619
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795299274;
	b=Y2qfMbO771ELdLzdG4fYvHzYn8Lyuqb6HYtUmlEvBHHzCcxS5gnpiQ8H5GNGapjTUpeo
	 5fNj7xfuU4+Xu/P+KKrKRFPb/dYv1QQ6MV+38Uy2TaANc0uWaoHr4OLMV4TkukpdoEtDy
	 H6mGQGw7bNuyFOItjEmpGhd8WRSHrRHa4y3qnhmF7SxTKMt9Szk9YprpVQ08uQpnQZVgR
	 Mq6cPG+3WNAitnYwti/hwsRbmy35ngDMFRs+fsh2DOrL5p9QDqEHYTHUQiQKGs8f20uU6
	 /mClGcoDFXoMVOssOqwLnUp0GztPbz1WFtiUqtobbeMsjt7rslRIX8DDV/Ba4sSVXrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795299274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hdAZgDSY3eckzqTVtYejIAoD4lAQFJSRLN1f6eg76tA=;
	b=YvbUxOB+9QSdbnyUTzol+iIis9ekoyE1QXS+8dy8LlZ4dU9P8+puYS8z74577uYvdXG8
	 rt0rAda2T9feSAE39pG8iGUQGZ5qyHpX6J7vVRTkNqsBSbDiqAfKa+91KgH8O+ZoS4F/L
	 ES1WwI+SsmXqyc4AjbC4w0tI9iV4V5+s+E+W/qSZ3ywun6r3gAu/Wlybm03arm7Yu3b+j
	 0wgcAWCywOjsfTHCiNxWpoyHewGYkBAvxs58Qr7UJuHYQDU2LlWmBzR4J8UBRzA8yaR4H
	 Mhi52Z045YSIvRC0Wkyg/pRCp9Qrjnli5Rl7bhsdSrhoKPmfdAGvnmpjQkA5F04ec6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795299274;
	bh=hdAZgDSY3eckzqTVtYejIAoD4lAQFJSRLN1f6eg76tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pIyu71JbYwM+LpAujGIUu3Al5Q5g0542sMPZoROd8+sNUoEiY1TPutXMJpWtjlyM4
	 AMLSxbMrPXavdVWf91gak99CSEPZW9ZDuGi5+M0YfHOYYwIIJXmNQFYp4BdzN/FH5U
	 eb3MZaHndWg1gkmakpYZTtBZLCWjgzrW9AxIbwfq6Hu5iaz4tKV7AWcO+d3DMFRfQV
	 XAOzt1QAAEMeYrssj0nhnYYKdnBYl65t837qf2Ii21RmCu692UGSluTF/NvGaTq8QB
	 D+3cE8BdEclNCcPi/simmgDTFe/OPfusVGOSgzM5CZ1/AGhAH3PgFDDjsddk5M1Oci
	 LsEcz7BxUpNfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB0E360619;
	Sat, 21 Nov 2026 22:14:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D031310
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AE784010C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ziLGRs26D9z for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 22:14:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2639400F5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dBEGRiVb
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2639400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795299256;
 bh=hdAZgDSY3eckzqTVtYejIAoD4lAQFJSRLN1f6eg76tA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dBEGRiVbiYO4fBaGcSNif3gDUfln/rwzsTVAwU7toX14BrdNvzUHZUoubbmnIMRDI
 nw9+hQmTe8onGZlhQ7puF7KvkzdSMLz5/nZ3vx55hjhlooQkdPCNpX0Duv+7ZWK+00
 mPKfxds90OgPyYwnYINRppmwovEbUCH45NQBVtc8QkBT9TxL5TSU/ZyGQoRxGYaaOD
 qJvi2thUC+XunUD2j+puqNlfTI49VJ9lNqzhgbbnu/fwc7lSWBs7dKs4UMrj5MKTID
 DDoF/kwqpNS6Wj88BJXHVlv9Gc2hJHArfF5fqTq6G5EmX340vew4SZ9xYR0jNncPnW
 JggrEeXhFpaJg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EDD73B2201E9;
 Sat, 21 Nov 2026 23:14:15 +0100 (CET)
Message-ID: <03d87c74-de4b-4335-85d2-869ad8d83a31@freeshell.de>
Date: Sat, 21 Nov 2026 14:14:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: fsl_qspi: Add optional clock support
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>
References: <20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On 11/20/26 06:43, Yixun Lan wrote:
> The clock required by QSPI controller may not be enabled by default,
> So explicitly get and enable the clocks described by the DT node, due
> to keep compatibility reason, keep the clock optional for platforms if
> there is no clock framework support or no clocks property provided.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> While testing in SpacemiT K3 Platform, we found the QSPI clock need to
> be explicitly enabled if boot from USB fastboot mode. While there is no

I observe that BootROM SPL Loader "USB" mode allows an vendor SPL with
SPI and clocks support enabled (and otherwise reduced options; as
"bsp-spi"[1]) to then load (via UART) u-boot.itb where mainline u-boot
main app "sf probe" is successful.

This same vendor SPL and mainline u-boot main app "sf probe" action does
fail if it was instead loaded from BootROM SPL Loader "UART" mode. I
regard the "UART" mode as a baseline for testing since it apparently is
doing the least in terms of peripheral setup. The software must do this
setup and not depend on features of any previous peripheral setup by
BootROM SPL Loader.

Either mode "USB" or "UART" results in probe failure from mainline
u-boot main app if the vendor SPL is build without SPI and clocks
support (as "bsp-nospi"[1]). From this I conclude there is a difference
in handling setup between BootROM SPL Loader "UART" and "USB" modes in
this way that can be tested for.

I did not yet test "SPI" mode because I assume if BootROM SPL Loader can
access the peripheral then it will also work for SPL software to access
the same.

1: Guide to build reduced SpacemiT K3 vendor BSP:
https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de/

To be clear my above reply remarks are while *not* applying this "spi:
fls_qspi: Add optional clock support" patch to mainline u-boot. I think
it is interesting that "USB" mode does allow successful "sf probe" in my
testing and that in your description it was not successful.

> problem in booting from SPI nor flash mode which the clock already
> enabled by BROM code.
> 
> In order to not break other platforms, try to set the clock optional,
> so it won't abort if there is no clock framework support, or no clock
> device tree property.

The compatible "spacemit,k1-spi" is in the SpacemiT K3 SoC dtsi include:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/spacemit/k3.dtsi

Matched from driver wrapper:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-spacemit-k1.c

Where it then appears the clock setup is branched to from k1_spi_probe()
function.

In all situations I have tested I do observe that Linux kernel probes
SPI NOR flash on SpacemiT K3 Pico-ITX board properly with FSL SPI driver
and the wrapper driver matching "spacemit,k1-spi" compatible. That seems
to me properly vetted as being correct because it always works even if
no setup was done by SPL or u-boot main app.

There are some updates to the FSL SPI driver itself that should be
sync'd from the Linux FSL SPI driver, and then I observe one improvement
to u-boot FSL SPI driver which should probably be sent upstream to Linux.

I guess that it is preferable to sync with the Linux driver(s) for less
maintenance troubles. Does this patch break the DM model the way it is
now? What do the other maintainers think?

> ---
>  drivers/spi/fsl_qspi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
> index 5692510a558..454dfaf1814 100644
> --- a/drivers/spi/fsl_qspi.c
> +++ b/drivers/spi/fsl_qspi.c
> @@ -23,6 +23,7 @@
>   * Transition to spi-mem in spi-fsl-qspi.c
>   */
>  
> +#include <clk.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
>  #include <log.h>
> @@ -716,6 +717,29 @@ static int fsl_qspi_adjust_op_size(struct spi_slave *slave,
>  	return 0;
>  }
>  
> +static int fsl_qspi_clock_setup(struct fsl_qspi *q)
> +{
> +	struct clk_bulk clks;
> +	int ret;
> +
> +	ret = clk_get_bulk(q->dev, &clks);
> +
> +	/* Ignore if no DT clock property or no clock framework support */
> +	if (ret == -ENOENT || ret == -ENOSYS)
> +		return 0;
> +
> +	if (ret) {
> +		dev_err(q->dev, "Failed to get clocks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable_bulk(&clks);
> +	if (ret)
> +		dev_err(q->dev, "Failed to enable clocks: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  static int fsl_qspi_default_setup(struct fsl_qspi *q)
>  {
>  	void __iomem *base = q->iobase;
> @@ -829,6 +853,7 @@ static int fsl_qspi_probe(struct udevice *bus)
>  	dm_bus->max_hz = fdtdec_get_int(blob, node, "spi-max-frequency",
>  					66000000);
>  
> +	fsl_qspi_clock_setup(q);
>  	fsl_qspi_default_setup(q);
>  
>  	return 0;
> 
> ---
> base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> change-id: 20261120-05-fsl-qspi-clock-e3df6b72ab8a
> 
> Best regards,
> --  
> Yixun Lan <dlan@kernel.org>
> 

With this patch on mainline u-boot main branch from today and the
intermediary "bsp-spi"[1] or "bsp-nospi"[1] reduced vendor SPL
previously mentioned, on Sipeed K3 Pico-ITX 32G board as BootROM SPL
Loader "UART" mode:

=> sf probe
SF:    Detected w25q64dw with page size 256 Bytes, erase size 4 KiB,
total 8 MiB

=> sf erase 0 800000
SF: 8388608 bytes @ 0x0 Erased: OK

It works as-is, but I think it probably should not work unless matching
a compatible. Obviously there are valid concerns for SpacemiT K3 SPL
environment being memory-constrained, but what I'm testing is S-mode
u-boot main app and this does not seem like the correct approach. Do I
not understand correctly the driver model?

-E
