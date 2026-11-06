Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C7606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f08TK0jr;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gyTvw9qE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DBB440953;
	Fri,  6 Nov 2026 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-qQ2uj0gFn3; Fri,  6 Nov 2026 14:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A0F794092A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793976451;
	b=Vmh83b3rNzHmFJMFpIqdLrIlP0ojaFhFgXEHGXxz8hA10iW+n35uBr2ZOMPwiJV+Es6b
	 L34ncSy4RFwmr5l3wWo61i5Xh2/xZ8xiVNpXy14qEMcXvENNZRPmjlghaDaz0aZk+fmZp
	 SuLJdAjMJTfbQFNg4g0oa6sfjoddbcuTrtfWmgatPASgDwuWFh9oN4hr6N7f1oH/fHV50
	 P1mQZIYf03AxN2jn3YxXvq1hDO5CU2dnYbeO7u/vAq5itnQ7SKCV1H9rRvjSliToSe9tU
	 gIbMZdbwt0SHRGKGyFFs6orojNNiao++g1nxDj4UBup+NaH6BhA+dKyA6061SzaZZQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793976451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5lCjXRANohidio+AGCW8YyvNOT62V2I3ZZuAT5Q2TMw=;
	b=rbvfYn/+7TbFxUPNsYueSKEX4cXI30DAs7yLajbfyoqyP5ilQ9TlXaqyy9Iosafwqdxt
	 rbN6J/RaFmOcNeSK7VgfuUKlGOXTSDHLfdLKUT3gbcPT7NbLi2oHZB/3BjsOY36Vs1w4y
	 8YzL9h62USvviZXNCbNzY/M5PSNlOMy3d+FT66CFyVM64dIeMNKmnwdWdJSK9t4PRu2i0
	 xMK3GwXcKqbcksF8WE/ltxfLi7rBnfUDIhP7t/ecmmMgg3Kfpp9lSn/jLIRH99kDV209f
	 Fj1A3EoOmQkPQxkGTAVXNTTtMGmuiD64YsYFpHSGILtJ8j+cWQcOJ4Q0h3oNakPsitg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793976451;
	bh=5lCjXRANohidio+AGCW8YyvNOT62V2I3ZZuAT5Q2TMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f08TK0jr31z3fWlbeL+Z+rqqBG8GaIx2FwGK6g0R/C0ri4C6+ZNI+p4mk5C2wy9Ih
	 yVKn+b2UNxl2p6y6b7HJ+mb88tAoLb8IAROwuJosEzo+iHQ8nFOeK9rytWIEjprzkH
	 ojxKOTMCCXuTAiOzum/eOLsw/mgtv/c/QqLMajXCyaJvBnqXLibZkgIzrdkJurxlB2
	 BA/lqyeSvFdUIJFV/oelnslMgk8sUHXZWgSM0Z3lc8jQSZo471z/VXURmq+qTF6V7F
	 oAvagQv64WkmhZWrRkn3P8vR+n868KmHajbw7CE6QowNroaN3ggalWSX+7li67NZEX
	 Z5ldBpIHUyMGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0F794092A;
	Fri,  6 Nov 2026 14:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 424002E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33EC8400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5_C0DOC7nIW for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68824400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gyTvw9qE
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68824400CD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:47:27 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8439fe796ebso517916a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793976447; x=1794581247;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5lCjXRANohidio+AGCW8YyvNOT62V2I3ZZuAT5Q2TMw=;
 b=gyTvw9qEFNZZrngYFIPyMKEO5/Z9dlDxzFjmlpFYjsa4ke40yVGG9XHSqnksGv7GnA
 t/xINraAAA1LoLB2Ap7fXSVkPw17rdgTmxfvIOirO9eyzyUHgWxKfuExlqnGXPt+QgSk
 TEYOGrs/mkUc7qtLAW16lPbj1zkZw3vIobosc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793976447; x=1794581247;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5lCjXRANohidio+AGCW8YyvNOT62V2I3ZZuAT5Q2TMw=;
 b=FCT1w48J2CJ+xsTcUmWOrawpS8HFnx2sOt8cIZXjYjw36yoaq+fQgVyzHmVrDI/4ZB
 EIAWP3xMmxtYubCztEA/uGO7xOPf50SHV7x9L5oKN4pNkHs8VEt1GBh3sR8RtIYTnei4
 YsJL1XZlZbP7jN2RzvInXtkguncNZSCRfw6J212oph3Hp2FtLjAnC6ICXse8KoTBD7MG
 5du9qmq+wBpGwQCcsarmyA7T0f/l6jxYv2HlInQyDoIckN/u/yYrsPn2W58o0c0sly/U
 F7v/BBcbbb/o63jIckfqPn1ki2BvV8ESi8sAcBlkqK9XrLne/WdcmCIih2SlEsrQDP+2
 nIlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSXMgpbgnpVHw36jRjP59hsP2/6wbRE6sbEj4x1hkX38NkjE0lovWj9YoFi2a9BLH/Eju+QmM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9900WRwNKLFdf4NxEiqSwoNPODRaXZvO5kGHZRmawYH9P6ayED
 VZqklNSuv+IIO6MBRmPcixlByBGrTlk1niirD3n0gS2HgzR6ogNYvRAkUNSK7EC6OmA=
X-Gm-Gg: AYBFou0cKVShg/Hv9Pg79fpYB0+W1LzbnfnP9eqenL2stV/VEG5+2arutDCLVTY4PGd
 Xj+57kHoRXiH061UZTLTp8cloJzL+vJ1z/UKfX1Gsd2jHjlSHBU7aULhY5PrwLMb1y4M/dNtR/g
 1XtK78vZ2zAUdkQ3lWZGkxk4MV1vVmeFAxLicpHCu20EKa7FS0C7yigGyJ6mmkyphyKEk+1erJR
 fa5xfbr1zoHP+TtiRf/p2D2OjfuPi3BTg9bhs4dTyEnT30TWG64GNXbcbdhXGQ8oj/FgXzwQ7N2
 1zHNzegw3wRtBDPU7lp4Yxx6GYtbBe5dhdz5dDv+XqsslF2WlIoIivrIhT1wrmvP08mm26Fhfkb
 ya827tNauNquD1QNBMPz7hxsngHBgltyNzRNC0xbvDIppPFxPli2eaEiF6H10qQRaAilH0bI6Y1
 ipQAATeQMlNw/vdTo329yD2UwMFzkjDjI5KUsCZtOWw39TlNgyvfCSBgs5UxzWl2VtkP/NTiMMH
 /CjoWTjyFgpBxmJiVn6hg7Y+C6/UiIX/wYedYOIXd1Iz8vMcjmL0mssH0HO1UQWApbmxHEUrd45
 ocWhdny4fbDr+ig45yfn5Tkiev5tIwyS7BdSqJlgk6wlKABsHs7qL1/eGl+HjTV0FASjRRTggvK
 VZc3RYdmklKZwsL9+0IaMGPQa4fM6AWqzS6YGpbx7DLSBoGgDxQRQNfJE1flkN7Jmhat+qNqStN
 xND9B/FVS4j1CFoXUCU2cEgR8r6RtXdA==
X-Received: by 2002:a05:6830:410e:b0:816:a9dc:6d05 with SMTP id
 46e09a7af769-85f1cd8b3b9mr2701332a34.4.1793976447004; 
 Fri, 06 Nov 2026 06:47:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1d951a8csm2071771a34.3.2026.11.06.06.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:47:26 -0800 (PST)
Date: Fri, 6 Nov 2026 08:47:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v9 3/3] configs: Add defconfig for ipq9650 RDP488
Message-ID: <20261106144723.GA3669968@bill-the-cat>
References: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
 <20261106-ipq9650-v8-v9-3-23d8919e881f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QAdZEkZJaktSi11w"
Content-Disposition: inline
In-Reply-To: <20261106-ipq9650-v8-v9-3-23d8919e881f@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--QAdZEkZJaktSi11w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 12:32:00PM +0530, Badhrinath S wrote:

> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
> support.
>=20
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.co=
m>
> ---
>  configs/qcom_ipq.config            | 36 ++++++++++++++++++++++++++++++++=
++++
>  configs/qcom_ipq9650_mmc_defconfig | 18 ++++++++++++++++++
>  2 files changed, 54 insertions(+)
>=20
> diff --git a/configs/qcom_ipq.config b/configs/qcom_ipq.config
> new file mode 100644
> index 000000000000..e649b07cdb2b
> --- /dev/null
> +++ b/configs/qcom_ipq.config
> @@ -0,0 +1,36 @@
> +CONFIG_ARM=3Dy
> +CONFIG_SKIP_LOWLEVEL_INIT=3Dy
> +CONFIG_POSITION_INDEPENDENT=3Dy
> +CONFIG_ARCH_SNAPDRAGON=3Dy
> +CONFIG_REMAKE_ELF=3Dy
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_FIT=3Dy
> +CONFIG_FIT_VERBOSE=3Dy
> +# CONFIG_BOOTSTD is not set
> +CONFIG_USE_PREBOOT=3Dy
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_CMD_PART=3Dy
> +CONFIG_OF_LIVE=3Dy
> +CONFIG_CLK=3Dy
> +CONFIG_MSM_GPIO=3Dy

> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +CONFIG_MISC=3Dy
> +CONFIG_QCOM_GENI=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MDIO=3Dy
> +CONFIG_DM_ETH_PHY=3Dy
> +CONFIG_DWC_ETH_QOS=3Dy
> +CONFIG_DWC_ETH_QOS_QCOM=3Dy
> +CONFIG_RGMII=3Dy
> +CONFIG_PHY=3Dy
> +CONFIG_PHY_QCOM_QMP_UFS=3Dy
> +CONFIG_PHY_QCOM_QUSB2=3Dy
> +CONFIG_PINCTRL=3Dy
> +CONFIG_PINCONF=3Dy
> +CONFIG_MSM_SERIAL=3Dy
> +CONFIG_MSM_GENI_SERIAL=3Dy
> +CONFIG_SOC_QCOM=3Dy
> +
> diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mm=
c_defconfig
> new file mode 100644
> index 000000000000..624d10e83c5b
> --- /dev/null
> +++ b/configs/qcom_ipq9650_mmc_defconfig
> @@ -0,0 +1,18 @@
> +#include "qcom_ipq.config"
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=3D0x180000
> +CONFIG_TEXT_BASE=3D0x80280000
> +CONFIG_NR_DRAM_BANKS=3D24
> +CONFIG_ENV_SIZE=3D0x40000
> +CONFIG_ENV_OFFSET=3D0
> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/ipq9650-rdp488"
> +CONFIG_SYS_LOAD_ADDR=3D0x90000000
> +CONFIG_SYS_PBSIZE=3D1024
> +CONFIG_CLK_QCOM_IPQ9650=3Dy
> +CONFIG_CMD_MMC=3Dy
> +CONFIG_ENV_IS_IN_MMC=3Dy
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_ADMA=3Dy
> +CONFIG_MMC_SDHCI_MSM=3Dy
> +CONFIG_PINCTRL_QCOM_IPQ9650=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0xC0000
> +

Both of these add newlines, which they shouldn't. And the _defconfig
uses #include but doesn't do what the others do so that buildman, and
thus CI, will build them correctly. So this is a reminder that the
Qualcomm team should be running CI on patches before posting them. Next,
I'm unsure why there's a config fragment and then a defconfig, instead
of just one (it's not *wrong* but it's lacking in explanation) and you
aren't re-using any of the other qualcomm config fragments. And this
might be better served as a board/.../name.config instead of adding a
new defconfig, as we're going through with another qualcomm platform
right now. Please take this back internally, fix what I've noted and
also work on a better and more consistent with other qualcomm platforms
submission, thanks.

--=20
Tom

--QAdZEkZJaktSi11w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau3odwAKCRAr4qD1Cr/k
Cqs0AQCEa7cCmu8LEUflMica5X3Y1TuEf91Lp8w0mf+bghDEQAD/aDTz1CYcKglR
8rzWuq6T6aCxerhqcpkUR658uqpphAw=
=q0YK
-----END PGP SIGNATURE-----

--QAdZEkZJaktSi11w--
