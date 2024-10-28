Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED2AD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5296A88FE8;
	Mon, 28 Oct 2024 07:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uB4T3Hlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3928901D; Mon, 28 Oct 2024 07:13:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2700C88360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730096015; x=1730700815; i=xypron.glpk@gmx.de;
 bh=2cT3JPqVaJVuSmSFQQAgwG2md+ZwC3lgMf//QxzQmkI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uB4T3Hlm6DQyHaW7jhSt1UICPSe/hpXs9WtGE9CGsObHrwz7BMvI+bV6FfOsHLPD
 Obm+kqH1Of1Sj8p1Pu1uxGLUiG1KecwFcqAo+pZ3TTI/4UVZEHkCdZ6B1MTIY1aBw
 8UguTu/n4pS0u2+zDSY7lVZjO838cj0BaDZZnkXiTw1YWcZZiB8wAS9sw494uoaB5
 r2LK9MVBdE4iPY/Q/ew7X+DwxVsWlwDjneArLEwPaANEtmZfizKZxJE+eRuhxmaoJ
 2qnmKduq2J5HuhiWd8M+c1H5fstIRl63tcw0/STZwYBzoNoEBf19mrltvmV9Aeuhp
 3ahUn0bpo2ccdJq1Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1tj1UF2JlI-00jdOO; Mon, 28
 Oct 2024 07:13:35 +0100
Message-ID: <c5e8f5db-eb1b-4ce3-8b83-df853c348f18@gmx.de>
Date: Mon, 28 Oct 2024 07:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Mark static functions in smbiosdump
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20241026075745.117832-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241026075745.117832-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nSb9KycM2NAsr+ExLwgQ8Z5jcTrR6htdE+od7SkJxd/AeDpfzSH
 6nc/db4Hn88w/ky5yfloxZMYhxSgmtRFdvz/V4kkoV7SDLyZF33/B/AtqAsiAa4zkRu202a
 LKjsucfr0vswdBPV2pA+TRhGNR9efKCHMy9sZDR9Ynsy+KUTCsHg9YIsUb53sUyXYrGK3dy
 HTKq8vU+9rJWxdQgFFHvw==
UI-OutboundReport: notjunk:1;M01:P0:9h4ghj41hrM=;CC4cjM7KCCEk5rriUfsgyQcRkte
 UlL7ZyBNPuEoyKk0Ss6C6asx5+HJNSSTcTJsjc7SmT/VIBud1DBTMR10fXdeRmDR0tGHVa4t+
 EmhZTReATcD7Inj6A8G9d3c2Lrp2g5RyOKq9Kh5n0mOHMAae3+THWzTX1xXrA8qvsKFoOf35u
 P2EV7oXL0EWitkc2lKMGwJ4T2VzwFmUbg1DqV+zc9IUegkT9YS8x4Be0lpE9sL6N38pdxnQn7
 SKvDVJmahcwPy9pubTnWuIUcEXXsW6bNiW8xDyEf6EQwYQdEA2NXmTnqi68O9SmUUZmhZiW15
 OlfuAyLdrWKApUo81cURXz4RYmmKnG4z++S8r4BQ/tsAJKLsYCNs1a4kTZbXBIvUaEjjZAvrK
 NdcrC6RdjW7UTgXuuM6GTez/z9Ln6g+vvqhB39u+LOIABX7MpcRlw9pX0r1lvgU/AxNL4eUBI
 ioTjCHp/MMysSPD2ZyCJ0AghijQ4db0yc03RNwwLp2WrknWLdk2KdgB64dqSCekyZuqGk9GxY
 Rv0mCd3V1ShAAZAu2R2qk+Gs5fXsOA3AbqPUTJKNo2uHFhstZ4Rl6suqgslcr3dvu/0fF7UvQ
 GoC0VXe/MgNMipyK6Nnxkj1TzFfnR7xT5PIXDSwuuGhDkaDq5aH5T9Ps/62GoDdpdr5uKFiwa
 l/KdhS3thPUSNxFAsu3rk8KbAnI2CmCnlgejx9NBvmh+v4MVXvpLMd4QHdmiqMYd210MDVQUU
 o98jh4Nvm2tyExO/lZgJF/jLRRdNdBiIQNKFJMzHRZc4eoIMlHquJI68TH+HciDwkDhpqErRy
 EIFEswfY/ymn10kKxVenPzJQ==
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

On 10/26/24 09:57, Ilias Apalodimas wrote:
> Mark functions that are only used locally as static and
> quiesce W=3D1 warnings
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/smbiosdump.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index 2f0b91a353d1..d7f2ba30a954 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -289,7 +289,7 @@ static void *get_config_table(const efi_guid_t *guid=
)
>    * @len:	length of buffer
>    * Return:	checksum
>    */
> -u8 checksum(void *buf, int len)
> +static u8 checksum(void *buf, int len)
>   {
>   	u8 ret =3D 0;
>
> @@ -304,7 +304,7 @@ u8 checksum(void *buf, int len)
>    *
>    * Return:	status code
>    */
> -efi_status_t do_check(void)
> +static efi_status_t do_check(void)
>   {
>   	struct smbios3_entry *smbios3_anchor;
>   	void *table, *table_end;
> @@ -401,7 +401,7 @@ efi_status_t do_check(void)
>    * @buf:	buffer to write
>    * @size:	size of the buffer
>    */
> -efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> +static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t siz=
e)
>   {
>   	efi_uintn_t ret;
>   	struct efi_simple_file_system_protocol *file_system;

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
