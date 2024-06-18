Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B8C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539A988366;
	Tue, 18 Jun 2024 17:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TGWmv8gS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABED88366; Tue, 18 Jun 2024 17:35:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72620884BF
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718724913; x=1719329713; i=xypron.glpk@gmx.de;
 bh=FwqM7UEoIxbF5nq2uy/gukoTJYGJupmAI9IWJh15haE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TGWmv8gSTi1zpOEH1lXtC1eqCpvswpvTPhs/2n3OMPFZieh3zg6H99U9C0WtyUtf
 Ioxj5f8yi7HBA8UF5S4xvJCYZSC5K3XEuEkT8RmYkreeVM6i0JUcO3x63FjBs+Jrm
 dyQ8XgOFlOT0CKVgZN8movwqRIkU0+pNb8pg0TpYaIWpFTDAVf2KMKFtx+FvEtRpv
 tmLVKSenOjNkgLNkDAwXM9fpBvAHB7TObnH9ba315ly4Xr9i7e5R6Evi1t+WZZkbe
 +0j8zFfhcRV8+bbvkhobTMLF/fC6qVDIbRAK5c15xFS9hU5GoZaHlgsyaf6mpXGLL
 wm21C7uMWAkkLvOKFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1ru3ee0mm5-00UQOa; Tue, 18
 Jun 2024 17:35:13 +0200
Message-ID: <c1c66103-9d68-48ca-a542-1d0abbfdb634@gmx.de>
Date: Tue, 18 Jun 2024 17:35:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: describe UEFI measured boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>, u-boot@lists.denx.de
References: <20240618152314.10140-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240618152314.10140-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsGZxMfq24SeiuGKIPp1r7qiMWyRsKBbt97Dz9xA8v3nl9BBH8e
 pK8LOOogshjRiQc7sbcoCmMiKCc3R2crNp6zUt+plRdkGwaS5iQO/Sz3Lk97tnsSnYcshjF
 Pq6Tebg8S11za59v0IwE5T8uChKuZiJY12/+SDEUoNLkU2+EauFnTee/uAGLuzkJGKON8Un
 WdP1DfczUZfhw12fOtrnQ==
UI-OutboundReport: notjunk:1;M01:P0:26BYGgGhYG8=;q/Qauyby8EcVpWk/oYD+04yR3pT
 HkL18+R9rt1AcWYtCpPEG7ov1F8VSYmH5d2vlv1L7b3cnHLLs4xkNfYTn6FhrUhcoC1m9Vc+q
 GmsqlQdbtqO1iYpghIMajsvBUkCx2NdjcE9D8WLPHeu6iZuxIneka/7pOVnfA7ZGGwKrdwCDn
 TYm5tk0UMpeDtstb9RXO7cSKf64NycASydEcDPAb6NawEb09QLr3kd3Gj/MaQEKkXSyMqQO9b
 jnuqzULq7oK8kVGI+Y27QgI496yFeGT7b/U/sQmE4v2bbw3+lQR6MAMjriSUTpYzIgrB7W1Nk
 mnV48GWGlQSqkhfGx8IigTaX8K4XKucLPPZSxuDFMYRic84xwqFXw61ciptmx4oCLrEhTLhUL
 ql2o+rPJai+3shfBrNxUUN1Wst+Qm8PANcx1qyiQotozgvIXuG5ydKvo9l2BKUr397F6e2TGx
 HxfGLSuhgwelVrO2WB8BT5nJDOIlxUfsrG7wS/CzD6aqf0g89Dv8J8IvlLNlf7uvUd7DwG8Cm
 btYN0lzC21GkJ/eKujh+wKkpjQevsri7ay5TTRgpKAau2genxAsZEO2Ky5zcppJZG07KgRIu0
 H/vbjY9rf9y5uHZe0lOVeb11zwWY5qsys8bq3LXOHRS+my4v60bA+ND8s6//d+luWOi6ARZ4n
 uQRtQZ8nOHFzXeyCvMTLCxgKVmD11EuraEHzDXYkx2s1kvq7zr2HO6t/MD5noi1Y+nh0vKXvI
 Tld6dZNZmUkxaB2WaSa2bRpRnLb4maRWtTJqVbyP9xRLRTm14dDbD+bLTTZ7IHdumEO31b8m5
 CTDkSMROo/WtgC0wSPWeox1RCSCHcmCNn+p/0rvztJJR4=
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

On 18.06.24 17:23, Ilias Apalodimas wrote:
> We currently only describe the process to enable measured boot using
> bootm. Describe the UEFI requirements as well which predate bootm.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Please, rebase on 00cac7456125 ("doc: describe UEFI measured boot")

Best regards

Heinrich

> ---
> Changes since v2:
> - add all bootX commands in the description instead of just bootm
> - Remove and extra _ from the header
> Changes since v1:
> - fixed remarks from Heinrich on titling and DTB measured PCR
>   doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 9691904a9d8a..d31cb05226cd 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -7,19 +7,42 @@ U-Boot can perform a measured boot, the process of has=
hing various components
>   of the boot process, extending the results in the TPM and logging the
>   component's measurement in memory for the operating system to consume.
>
> +The functionality is available when booting via the EFI subsystem or 'b=
ootm'
> +command.
> +
> +UEFI measured boot
> +------------------
> +The EFI subsystem implements the `EFI TCG protocol
> +<https://trustedcomputinggroup.org/resource/tcg-efi-protocol-specificat=
ion/>`_
> +and the `TCG PC Client Specific Platform Firmware Profile Specification
> +<https://trustedcomputinggroup.org/resource/pc-client-specific-platform=
-firmware-profile-specification/>`_
> +which defines the binaries to be measured and the corresponding PCRs to=
 be used.
> +
> +Requirements
> +~~~~~~~~~~~~
> +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> +* CONFIG_EFI_TCG2_PROTOCOL=3Dy
> +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=3Dy
> +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=3Dy will measure the lo=
aded DTB in PCR 1
> +
> +Measured legacy boot with bootX command
> +---------------------------------------
> +The commands booti, bootm, and bootz can be used for measured boot
> +using the legacy entry point of the Linux kernel.
> +
>   By default, U-Boot will measure the operating system (linux) image, th=
e
>   initrd image, and the "bootargs" environment variable. By enabling
> -CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree imag=
e.
> +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree imag=
e in PCR1.
>
>   The operating system typically would verify that the hashes found in t=
he
>   TPM PCRs match the contents of the event log. This can further be chec=
ked
>   against the hash results of previous boots.
>
>   Requirements
> -------------
> +~~~~~~~~~~~~
>
> -* A hardware TPM 2.0 supported by the U-Boot drivers
> -* CONFIG_TPM=3Dy
> +* A hardware TPM 2.0 supported by an enabled U-Boot driver
> +* CONFIG_TPMv2=3Dy
>   * CONFIG_MEASURED_BOOT=3Dy
>   * Device-tree configuration of the TPM device to specify the memory ar=
ea
>     for event logging. The TPM device node must either contain a phandle=
 to
> --
> 2.45.2
>

