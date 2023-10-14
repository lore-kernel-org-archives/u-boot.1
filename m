Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E6CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF9186F3E;
	Sun, 15 Oct 2023 08:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lLSOa+5+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Zm3eIvec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A2F86F40; Sun, 15 Oct 2023 08:36:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C51086F22
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7Dgk5pC2z9skN;
 Sat, 14 Oct 2023 21:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7iBQDtbv9B+/06GeIsorS2UAxK+IVr7/bT9NIq0IGk=;
 b=lLSOa+5+N+1+mnsxk3aBaQkGUPWZ1GxwTLqSa2qJcykcIb34KSUsrxgPGk3jO0tNtHMgFc
 SjhLSNlnDuUEa6ekiLMeHsN4fsffKRv0sB+Bd47By+DM+yddRCyQteiVwCixq27eEYUNMX
 +KcsIQnPxPnBjmTjEjNFg1uTL6WcQvYks3qXvkmF6f1DonHeMQtipCHS2SV+RVmzAHGlKl
 w/VThQY4QzDrZ5h6nrCt3utfHOCNpVRZb1i5G/znsLodajT4UIHxeeBKOfLBtwRpUgfax/
 PCZnNzDYpOKEtAjKHGHxkKU1JknQeqtQ1Rs3EGpXoxEP1LWI+cH1dcFjy6U7pg==
Message-ID: <297d3521-6590-49e3-8191-0c473d39febb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+7iBQDtbv9B+/06GeIsorS2UAxK+IVr7/bT9NIq0IGk=;
 b=Zm3eIvecxdlJzlUqftS8fTUTChX5VXSIxW4UJ4M/1D8F1RJDx0ShTrqUgeijGC23JK6GA8
 +qkNxt1K27FKrJkpucVy4Uq8dkgMVsYKevcUN/Tzb7CiSFFCgAeJdquihLllfXhUQVLKjd
 iv9w9hpfR+WDbPBjgUmOtlF8Z8A+gJfN4z6IYjUY0IdmF0dahQvhmorMM+8x0YzCqsBuX9
 R6IyM4y07J/LR/orTGqmnJUZkkXwMRTZCg591neZqbCrFy5ll83ATEp7ru4RKIUAXXsvFM
 XcOlx+AcMxxFfGezvWGaq0QLDbpVcwoFM/38/n2lR5Yxg2BH6hJHq5EbXmkT2Q==
Date: Sat, 14 Oct 2023 21:57:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 17/19] arm: rmobile: Support RZ/G2L memory map
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-18-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-18-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 61d0bbe164a90eda5b6
X-MBO-RS-META: mtqi9k5ssq9ta671moapspybi8r8m76x
X-Rspamd-Queue-Id: 4S7Dgk5pC2z9skN
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

On 10/9/23 18:46, Paul Barker wrote:
> The memory map for the RZ/G2L family differs from that of previous R-Car
> Gen3/Gen4 SoCs.
> 
> A high level memory map can be seen in figure 5.2 (section 5.2.1) of the
> RZ/G2L data sheet rev 1.30 published May 12, 2023. A summary is included
> here (note that this is a 34-bit address space):
>    * 0x0_0000_0000 - 0x0_0002_FFFF SRAM area
>    * 0x0_0003_0000 - 0x0_0FFF_FFFF Reserved area
>    * 0x0_1000_0000 - 0x0_1FFF_FFFF I/O register area
>    * 0x0_2000_0000 - 0x0_2FFF_FFFF SPI Multi area
>    * 0x0_3000_0000 - 0x0_3FFF_FFFF Reserved area
>    * 0x0_4000_0000 - 0x1_3FFF_FFFF DDR area (4 GiB)
>    * 0x1_4000_0000 - 0x3_FFFF_FFFF Reserved area
> 
> Within the DDR area, the first 128 MiB are reserved by TrustedFirmware.
> The region from 0x43F00000 to 0x47DFFFFF inclusive is protected for use
> in TrustedFirmware/OP-TEE, but all other memory is included in the
> memory map. This reservation is the same as used in R-Car
> Gen3/Gen4 and RZ/G2{H,M,N,E} SoCs.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
