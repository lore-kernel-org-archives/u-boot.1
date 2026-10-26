Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5C606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LgeFdPXl;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Q6oM2t2m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A96F605EC;
	Tue, 27 Oct 2026 01:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLzkbfxoFXLp; Tue, 27 Oct 2026 01:09:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D10F60611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793063385;
	b=fLUyma0fcYXIh+LlhDBKJlSjxkPNg4r7oIMEV4WtByeUbXBheZbfT+MGwrln66qLIvcv
	 7LDCuug30ZPqiV9Ke/oOA7JaxgHp9oe1jL3HCzAyylApC4p+1JDnWsYCMIlTLrhVe3CGF
	 K5FddrCkN0JvUgbdwG6s8nc6vK400F6D2540+n22KMxJGrZntbmhEIdmrtilsPTWPw5b6
	 XngzaEfTS8fkJrA1oxhLfmeo5VJPhstnwa3zZeNjqYB7FxNihzOhs/VSzklo+EefXyimK
	 5RB55O/msKOZn3DYwtZZB8DUwcFAgbwDIHspyNJDM0jtoAdR+qgbegGjnJpeVFbPfEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793063385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jTLidikniNkdoLeLBUYSAlWZJkf9GPoP9EFOKM0DALE=;
	b=WGWCeyIIRDAn5V/E2OBr1Z8EkxNXOFbB1rppI17XGbAtqv+0dIVZiakNUmiyKNMYOkwZ
	 UW+BShCqc4cF/Vv9EogDuGFMebNDXNPfeDCqSCF7l5TmcRzJuk+RUNTYVY5K5PwX+SMWS
	 lUkLmJTGg0J0z6kz42hpHuU0Oets11b4hVTGuGEm9WW5fFOoiQ+khSVsCPKGGQeGFAOyJ
	 rJKDZcuC6lPN6Ju9zvztgWWpLJEJWqB5PYm31tV20QySqSBV/gYCFAYvFSOlutMqxh7gB
	 L+0P+0jxaaK2V8MsS11QAP2RMIbHEaBBg3HE42TWUdAdI9/uC5ZL37Qa33YGfXmrQVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793063385;
	bh=jTLidikniNkdoLeLBUYSAlWZJkf9GPoP9EFOKM0DALE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LgeFdPXlE/aWPZ/qRo3dRRoHoKgTK+WVjWczmmTEj9GHUadPITKVzOI6Mhw/qGKB1
	 CirArIsbotKjeCbxMd1C3uKQBxMfDEGZ53zWv21AvSg55J8KiyULcSyMHPQc4xX29f
	 1V0QdFlVJhELin2Kf4gqeVqJ9ybcNdS1ThvlPEFB5aL/3YT8Lifoc0g8GbqODgSrVm
	 K5OrxzWLncDIAapaTKm0eko9ebjdjKTnxDCuxupz8YGe3wtzlx6NE6WwiGXbg6qiBv
	 IsmaYBzsDKccE7BLkIAQljJ1RdnDmd6lcQZeO8RoFdepitFE3RLV4NQRl2nzUOibbq
	 OYfKepkkE0C8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D10F60611;
	Tue, 27 Oct 2026 01:09:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E2D7356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13B9A80960
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dh0JTUV4afQS for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 01:09:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8042808BB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793063383;
 b=NjTDmceQIOZsd9nZ3Co/3MXvfg6ztnvOyyschzlHVVgogU77ZoWPzEW1Utx+UcZknOhi
 g+N8i1K6KVITmytpy7HnukEtOyQyrQssajfVd8a3pcYVwfslYf/i6XXTUvxR6JQqxjwij
 N3+RUndMTC5cLGs4ffoUmNvgg3sAdRLamJrfsg04SXBqPwyTFmYC5pDrRYTCIPX/UDlHM
 yqqqu7/cevBr1d5H3TEA3qMYLW/Ht7P69qgcD9dYETD8gCD2FcyVvAkyhdf8Cu2+wVl4u
 yMOZ82t281KIjhP2onBRPldmjm9q1LhKpCy1DnZEAh2E/tcZtnGOF+613myDfNbQmLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793063383;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=jTLidikniNkdoLeLBUYSAlWZJkf9GPoP9EFOKM0DALE=;
 b=oOjqY48xfNCT9YfjL7UhBL7dV+nGHNsIPKa8iHU1Us0Ujm86wTA3v5CC/OMCzyrG6KQy
 ZdH9Gc0fmvBWyVJPGe7gUf+r8cVqrS9Y+i0dm3Dwg0xICcUsMo3YFYfa4U36oe8FAc8o7
 dx6UI3tZGH1hOr+Mov3MC48AMjDDZn4F289A7wlv0xNDuVrGvSsI0psd61EFdPVVE+Drc
 oBUT0baJ8U+Tb+hr2bUbcGmgcX7KGxdo8Iamcf0gvh2nkaDBxIkH9KPvy8Jssj3nLQwvq
 pCkVJpmT4q+vQSPAAOF4ycPV4qYvPl4U30uQS+IFySKM8fNT+PbbfjtpGgoBM/oA7sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Q6oM2t2m; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Q6oM2t2m
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8042808BB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:09:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jDC811XmQzKnTs;
 Tue, 27 Oct 2026 02:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793063377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTLidikniNkdoLeLBUYSAlWZJkf9GPoP9EFOKM0DALE=;
 b=Q6oM2t2ms2mjGrCYY5QnNJ0vY7mdNO+xFjjpEpRVk6Hy1B3/10zpF8BdVYpsbXu/aawK7W
 os11yYWuurFMoGCpQ378C0YA8UpgaWUQxnZeDexiABTVDzyshZEvLBn4kixyNiyqLmsec1
 jwaqoOrp2ivRYgK9V248hUcNVxey3WT/yhLDiR8zG1a9pTkkImzIj6Q4IVIwi81zuUeUk8
 FV5w0sR8oVSV4mncAscX3q26m3Am9daF5ogFDcSeFcAi1Cs6ms4WeA7O1w0JLdQxp0AVId
 ykLvb9DYJah+gbd7/4OlyOJCkP/kZ4k7b3m2U+bnNlgx0dR4OQJF9L4RbQuV6w==
Message-ID: <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
Date: Mon, 26 Oct 2026 23:18:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: whsbhh3y3bp4thmst8g4dtdmf7wgbs38
X-MBO-RS-ID: c944ccfad20364e35bd
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 4:36 PM, Clément Le Goffic wrote:
> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
> starts it before the Cortex-R52 cores are released, so their timers never
> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
> 
> Program the counter frequency and enable it before any other
> initialization, through the RSIP-M alias of the counter frame.

Why is U-Boot on RSIP supposed to be doing this, why is Zephyr on the 
CR52 not doing it when it needs that counter ?

Does anything on the RSIP or CA720 depend on this counter ?

What is the problem you really observe ?

> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
> ---
> Start the generic counter from the RSIP-M U-Boot on R-Car X5H.

What is this ^ sentence doing here below --- ?

> ---
>   board/renesas/common/gen5-cm33.c         | 14 ++++++++++++++
>   configs/r8a78000_ironhide_cm33_defconfig |  2 +-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
> index f532daa16d5d..1837283c2bef 100644
> --- a/board/renesas/common/gen5-cm33.c
> +++ b/board/renesas/common/gen5-cm33.c
> @@ -58,6 +58,10 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define RSIP_CTL_PROT0PS			(RSIP_CTL_BASE + 0x844)
>   #define RSIP_CTL_PROT0PS_ERR			BIT(0)
>   
> +#define CNTCR_BASE				0xbc000000
> +#define CNTCR_EN				BIT(0)
> +#define CNTFID0					(CNTCR_BASE + 0x20)
> +
>   #define SYSSS_BASE				0xc1320000
>   #define SYSSS_MODE1				(SYSSS_BASE + 0x1010)
>   #define SYSSS_MODE1_MASK			GENMASK(11, 0)
> @@ -1280,11 +1284,21 @@ static void gic720ae_init(void)
>   		writel(1, GIC720AE_GICR_VIEWR(i));	/* View 1 */
>   }
>   
> +/**
> + * generic_counter_start() - Start the generic counter shared by all cores
> + */
> +static void generic_counter_start(void)
> +{
> +	writel(CONFIG_SYS_CLK_FREQ, CNTFID0);
> +	setbits_le32(CNTCR_BASE, CNTCR_EN);
> +}
> +
>   /**
>    * mach_cpu_init() - Initialize hardware and start other cores
>    */
>   int mach_cpu_init(void)
>   {
> +	generic_counter_start();
>   	mfis_unprotect();
>   	pfc_set_avs_pinmux();
>   	mdlc_mpg_start();
> diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
> index 3f09a7c25568..37d700096ff3 100644
> --- a/configs/r8a78000_ironhide_cm33_defconfig
> +++ b/configs/r8a78000_ironhide_cm33_defconfig
> @@ -65,7 +65,7 @@ CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
>   CONFIG_SKIP_RELOCATE=y
>   CONFIG_SYS_BARGSIZE=2048
>   CONFIG_SYS_BOOT_GET_CMDLINE=y
> -CONFIG_SYS_CLK_FREQ=16666666
> +CONFIG_SYS_CLK_FREQ=1066666667
Why did the frequency change ? (that really has to be explained in the 
commit message)
