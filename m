Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CB606A333
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eVbdgeKW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKz/IbLD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CDE960755;
	Fri, 27 Nov 2026 16:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 924JT9A0DEkZ; Fri, 27 Nov 2026 16:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68D6260AAA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795797744;
	b=NPZRgAzLYzF4l0ozlP+7Tu5e94vVYQYOnAXCwooBZf5ZSi0Y7URRGZ1aj9n6KvWBdOe3
	 nnmIha3n2f1rz0g9+9t3hhSC0GJLp3JjXEMt5/3OpItlwlMfW13AUxFYv5Rt2kwYnjxKs
	 U6r2iLgTlTNuJp+OowIW3bNVU7Ib0DfgVAZjZAwrm4xPVSN+QLIrOcgWC9N6lXYStifxj
	 XckFGu4K4F5DQGEGgKKilHVeMmsyi7/m7HzFnXxIH/Xbzi+KSxCBpu8Nqu0fco1+k7wlW
	 OicEFmNL55Ld7oYeqCMb3lDcHn00nMlx01Jl8QpI4MFEdT+B7/CXb8LGzJkGf2QqX8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795797744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+J+voVoTmpimGJe6dsA7twsGEq4GShkAWRUB3gSmH/o=;
	b=CuebvhT0xcpYMguYt4baUVt24xL7/MMCJtxfTcndU29Zzm9p0+jhly1ZO9/gMFoDqjVU
	 TyiUxmsPVKnNjOYTSs53wb6BkIk+2nmIS5U1NAzHh9wUka4tz/QCDYMf/ynP3Owl3ME6H
	 RdfVTHtnBmbWuf1sHoVmhRFJrR4GmQwZOUVmdg/RDNKgWSJbpcJyht4E5z3zdJLBek59I
	 cXEDut5R9Q9AMKK5kgIaND4cXapwKwrSll30+Az/1eeosYtH9ZlXEufKXviFh4sshVcS9
	 m5WttFOQoQxIAH/IYAOwaVtspkpYmsb73wtk6Br4PXQOquAcHIxNTYjOhgmiAg5jj4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lKz/IbLD";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795797744;
	bh=+J+voVoTmpimGJe6dsA7twsGEq4GShkAWRUB3gSmH/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eVbdgeKWGpKSEgm1fpP35+BxjwVTOHSYF9aHyEJ7bDdktNsqSL9li48HcEUYi3F+Z
	 uHwKpkdp5yokYNd/Pihznd2Av+jTYA9TXfX3OPeoOEPEk26JjDI6Yd2Rb103IGb7d5
	 8j8mnctkw6emYte4MA0hoyn6TEc6XLKzPUJnAtiK+MM1zNW3NOwYs8SvxrNaRifL/0
	 WQeiuC2bm6s0MUbZhdZ5OTyCqdj5ZSJr1c9iqksAObLQVjBKvCNbHwgRx+xcR8pwMo
	 4Ghzh7TJhHiw17yBR/9/7/nkagoxCwxHwnt6DvTX+7kOzikstsVDGnin8ajVP+jtWW
	 c8QHaiyq4Us1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68D6260AAA;
	Fri, 27 Nov 2026 16:42:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F101526D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE53E60755
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:42:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OlPkXu21l9t for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:42:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C38DF60AAA
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=chleroy@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lKz/IbLD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C38DF60AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:42:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8558B42E05;
 Fri, 27 Nov 2026 16:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0E81F0089C;
 Fri, 27 Nov 2026 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795797740;
 bh=+J+voVoTmpimGJe6dsA7twsGEq4GShkAWRUB3gSmH/o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lKz/IbLDbsFk6mD4aJKs+GlffJokEZYqDemjC5VYH70V+Kkjb8mrCH1FoY3/4l67r
 Dsh+nkkeLure9EDaThZsmdRNRdojIS2vGxZ2joGYryUar1FNWOnFbgleMAEa5KMkbF
 BM7FCRgGrVd5bFRUmI23RkoichJWJWOLGm0/OuJbJ3oCZyUtYH0YxftEa2U939llwt
 3ytnTdbmV5qBj06a7kj6Mm5KRhQY0mcyUCsyGjY8a4wCr28JRcMiCbJKsssKzoW+5p
 yaN5o7CeirC+1olGHRvnaW6S4Ib+Hh1iSEKA8bL/hxY2LlygUpLgDQFzaIrnEwaJaL
 pvZV1eHDfCKQA==
Message-ID: <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
Date: Fri, 27 Nov 2026 17:42:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: mpc8xx: prevent DPRAM overlap with SPI descriptors
To: Jaeyeong Lee <lee@jaeyeong.cc>, Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
References: <179024275173.70674.16356876476594066413@proton.me>
 <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jaeyeong,

Le 27/11/2026 à 16:08, Jaeyeong Lee a écrit :
> [Vous ne recevez pas souvent de courriers de lee@jaeyeong.cc. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The MPC8xx serial object starts at DPRAM offset 0x800 while the SPI
> receive descriptor starts at 0x840. The serial receive buffer begins at
> offset 0x14 and is followed by the one-byte transmit buffer.
> 
> Limit SYS_SMC_RXBUFLEN to 43 when MPC8XX_SPI is enabled. A value of 44
> would put the transmit byte at 0x840, and larger values also overlap the
> SPI descriptor with the receive buffer. Add a static assertion to keep
> future layout changes from reintroducing the overlap.

Not sure we need something so sophisticated. No defconfig redefines it 
so everyone uses it likely with the default value of 1.

Just limit it to 32 regardless of whether SPI is active or not, that 
should be enough. I don't like the idea of a dependency between the two 
drivers.

We don't need that assert, it should be enough to put a comment close to 
the definition of CPM_SPI_BASE.

Christophe

> 
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F179024275173.70674.16356876476594066413%40proton.me%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdff89d20fc924d5d92df08df4c98563f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639313889303482082%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BX3U4TMa8vSsaduwcMtKmvbp9U8ghNs1OgNAws11K1k%3D&reserved=0
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
> ---
>   drivers/serial/Kconfig         | 4 ++++
>   drivers/serial/serial_mpc8xx.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ebc251d891..73c36ea79b0 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1201,6 +1201,7 @@ config SYS_SMC_RXBUFLEN
>          int "Console Rx buffer length"
>          depends on MPC8XX_CONS
>          default 1
> +       range 1 43 if MPC8XX_SPI
>          help
>            With CONFIG_SYS_SMC_RXBUFLEN it is possible to define
>            the maximum receive buffer length for the SMC.
> @@ -1208,6 +1209,9 @@ config SYS_SMC_RXBUFLEN
>            If using CONFIG_SYS_SMC_RXBUFLEN also CONFIG_SYS_MAXIDLE
>            must be defined, to setup the maximum idle timeout for
>            the SMC.
> +         When the MPC8XX SPI driver is enabled, the receive buffer is
> +         limited so that it and the transmit byte do not overlap the
> +         SPI buffer descriptors in dual-port RAM.
> 
>   config SYS_MAXIDLE
>          int "maximum idle timeout"
> diff --git a/drivers/serial/serial_mpc8xx.c b/drivers/serial/serial_mpc8xx.c
> index 9ce3fc3d9ec..feb0c905594 100644
> --- a/drivers/serial/serial_mpc8xx.c
> +++ b/drivers/serial/serial_mpc8xx.c
> @@ -36,6 +36,10 @@ struct serialbuffer {
>          uchar   txbuf;  /* tx buffers */
>   };
> 
> +static_assert(!IS_ENABLED(CONFIG_MPC8XX_SPI) ||
> +             sizeof(struct serialbuffer) <= CPM_SPI_BASE - CPM_SERIAL_BASE,
> +             "MPC8xx serial buffers overlap the SPI descriptors");
> +
>   static void serial_setdivisor(cpm8xx_t __iomem *cp, int baudrate)
>   {
>          int divisor = (gd->cpu_clk + 8 * baudrate) / 16 / baudrate;
> --
> 2.43.0
> 
> 

