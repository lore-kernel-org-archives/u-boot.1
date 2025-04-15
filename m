Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC84C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C9782A27;
	Tue, 15 Apr 2025 15:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NQcwTSEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2406D82A39; Tue, 15 Apr 2025 15:27:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E84829CF
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744723643; x=1745328443; i=xypron.glpk@gmx.de;
 bh=60K9EHieg0BwFQ0rrd59kb+C8cLvVG5Hx7J2PoQBuLc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NQcwTSEzqw9BREA36ibjpVCqEMhAHoITw7TXoN7AMabzW5Ogdd9cybygNo27UdDe
 bdNXBHGiM74pxBCGzae0ioz3WOMN/niBoSHR570C4xjruO82lr6e/HV2VcXTj16fu
 TMpPXHwRga/8gYCDtDgADBlysf5eRwf4RN3PpDClQTkHAy8JaGsVYQG9jVVNY6qTX
 ipp/hIGAPczJBfA98EoDaRF1UCeK9iLPLRRSho2NnV3Dxl9x7+BFqWVao93l8hY3k
 Z26vgNMIrDJPfGQaJuOvHSjCWykYfiC8Ql4DHVDa5zmrqmWwhgKiwhNE9O901T2iS
 sA8kjuc92JbfomtySQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1tT8Vc0oW3-00nEBC; Tue, 15
 Apr 2025 15:27:23 +0200
Message-ID: <aae0bdb0-eceb-4534-9afe-27b1a332dfbd@gmx.de>
Date: Tue, 15 Apr 2025 15:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] qemu-arm64: enable UNIT_TEST
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
 <20250415125345.427420-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250415125345.427420-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/VDXrzKMdTdvAX+sL5oBuM5IhAmdvDW6dVC4m2BvM8yJ6sAzhD
 heHMkdWaFDxnLSHjxXq3Tx47O637BBtt27eAqt69oL27d0ejzkcJnRFD6JDiAHpZ6CfmBVo
 B0rjXfJp9u4qaunJO4wDcrTThZx/SRWSPkOEYM/hTL2jg49ZqXcJuuCKHJ639s4tlNjpRnH
 yNa13VFo0WUyIgi9fK1YA==
UI-OutboundReport: notjunk:1;M01:P0:tUsWoNPocpQ=;Bh9pSHXgRJkgxukSz6oIStHc4JW
 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
 w==
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

On 15.04.25 14:53, Jerome Forissier wrote:
> Enable CONFIG_UNIT_TEST in configs/qemu_arm64_defconfig so that the unit
> tests are run in CI.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
>   configs/qemu_arm64_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 6c9d2505a69..cd9a4f2ae26 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=3Dy
>   CONFIG_TPM=3Dy
>   CONFIG_TPM_PCR_ALLOCATE=3Dy
>   CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=3Dy
> +CONFIG_UNIT_TEST=3Dy

