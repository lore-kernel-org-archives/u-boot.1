Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B159C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B265487C38;
	Thu, 25 Jul 2024 18:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iujikneG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DA3880D1; Thu, 25 Jul 2024 18:13:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B552A87C7E
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721924017; x=1722528817; i=xypron.glpk@gmx.de;
 bh=Ki8NHq3G563Fb7IWbfb5W2glFY0fG1VieSugPvLeP+A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iujikneGwqkXE7MCgcF+3NH4LD+YL9G5f+lYoiktBJnZNz725l6LnbdfEXlx9TEy
 nY1UctWGfT04/IJOgxn0nFv08OeIEgTUlpkPgedZGkWAlKyvOQU8cMBUvhdI0nTg9
 WzeKil4wYw/O+BFz1cwTGxFsY8CUmYUlgIwWRBRWAHxOyOZk2DEsZceQbyoAX2WuG
 Km74YmQA/PLfKtq592sluDxzqsNZClgaYp/aYT1TzCdcsuYcTMit3Tey7UaXHfpSL
 LEJna8WAmKEUrrpqfaOGGtqoZi0dyqTGZGPWbg5ky8tFmStf5oBw9sdxHpkDHKhf/
 E+Z6H7/YcqfjUSiuUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1sHP5e2XHv-00wS7t; Thu, 25
 Jul 2024 18:13:37 +0200
Message-ID: <79d645ae-03d4-40a0-b685-fb6e7189b53b@gmx.de>
Date: Thu, 25 Jul 2024 18:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] efi: Convert device_path allocation to use malloc()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M0w5wkUCcKYc19o9uCp6wq2BXe+MGwZ+1ObracPyfrzx3RVeprd
 KREe+SP3RY8YfrYj4gNvFjZDb4dZEFxqs4Y862gSqZYy/17xpiD+EaxF3s0ESepSPjMZtXA
 tQ0/RGvsRSw2cGVgV1b4iaztyb4RBoldtbdOvVZg2xNZrvy8D82QAnerMnaPH23MSBf6oFz
 j58B6msTcxtoGRryfSRIg==
UI-OutboundReport: notjunk:1;M01:P0:kaViDG3DR24=;zGK3p1aQHI7Sd6CIkPHsEgFInQo
 HTOj1ja8crsOlc8KCF2nAbdPX9hq2wpt365cXBBkBuzk4TJSPRgCUQVEs4txLY1UClNEP2nFt
 IiMxsBSpy7W/R4Rr2Nx9kCADwykHN3GP2KuPXS6GLFL/4UmYSMbX1pGziVHJpkP1ZQkOaCu1F
 AaAL5RVeld/OAuPt32X7kwhijKWh8S+PXBTbwFz2psfpUce/cVbSnFV5Bxu4gSKD5alztZSEu
 mMhIOSe+GHnmTQbAoTc7tUr+lwst6OaXVau8kV34n+3kzQCesEcC/l55dIWvAzpu5nmg61VBt
 fRzmZMwRYzvr72XfcDQegcduGPO9ad9Z/ezjmRauonuU2kPF5ZHtoSOIfW3oD7Icb0viC+g9Z
 IexTi4jrgwmMYfP09fA30t0DVPF1f1z0eoMu/EHkp24p3ILt8wGcLFHZBPcJeoybKT6ZmbhtG
 AzgmSHzfPpdXFB9zfLnIA8Efw4GUbpi++CTAnfrbZwO/s6i9qKAWiCfTqqIHk9p+TrHJYTinF
 W0xDqUAZRtP9RxzSJpX1EO2VFOYiL71gMe4TlYAo8eeg6NNnmmuh7Am9CWsWt5e8cP981fwVZ
 EQ4/27xD9nznxKJhdV8frbzU04ospCpGyXErItzb5mN82rxgbqGu+HIWqyptHO7EmqjZSHZtP
 3zW5y671V6ob+K9MZ77l9sahdWjJZ/NSFR6y/ODAwTE6BMKeSXK+tYYuO3t+qGgq0+zOdTkHE
 q0Yu92wWFXScq9C1MGMosnNxBFEhIrtS3tlFSRaWmKJcsebv402a25/nI5eIbtjKr/waPgiuO
 B/43AedpzLPTZjQJj3QfZrpQ==
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

On 25.07.24 15:56, Simon Glass wrote:
> Currently this calls efi_alloc() which reserves a page for each
> allocation and this can overwrite memory that will be used for reading
> images.

We already agreed to integrate LMB and UEFI memory management to avoid
this sort of problem.

Please, have a look at chapter 10.5, "Device Path Utilities Protocol" of
the UEFI specification.

EFI_DEVICE_PATH_UTILITIES_PROTOCOL.DuplicateDevicePath() must return
memory that an EFI application can release by calling
EFI_BOOT_SERVICES.FreePool().

Your patch does not comply to the specification.

Best regards

Heinrich

>
> Switch the code to use malloc(), as with other parts of EFI, such as
> efi_add_protocol().
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_device_path.c         | 43 ++++++++++++------------
>   lib/efi_loader/efi_device_path_to_text.c |  2 +-
>   2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index 0f684590f22..47038e8e585 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -262,7 +262,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_=
device_path *dp)
>   	if (!dp)
>   		return NULL;
>
> -	ndp =3D efi_alloc(sz);
> +	ndp =3D malloc(sz);
>   	if (!ndp)
>   		return NULL;
>   	memcpy(ndp, dp, sz);
> @@ -315,7 +315,7 @@ efi_device_path *efi_dp_concat(const struct efi_devi=
ce_path *dp1,
>   			end_size =3D 2 * sizeof(END);
>   		else
>   			end_size =3D sizeof(END);
> -		p =3D efi_alloc(sz1 + sz2 + end_size);
> +		p =3D malloc(sz1 + sz2 + end_size);
>   		if (!p)
>   			return NULL;
>   		ret =3D p;
> @@ -347,7 +347,7 @@ struct efi_device_path *efi_dp_append_node(const str=
uct efi_device_path *dp,
>   		ret =3D efi_dp_dup(dp);
>   	} else if (!dp) {
>   		size_t sz =3D node->length;
> -		void *p =3D efi_alloc(sz + sizeof(END));
> +		void *p =3D malloc(sz + sizeof(END));
>   		if (!p)
>   			return NULL;
>   		memcpy(p, node, sz);
> @@ -356,7 +356,7 @@ struct efi_device_path *efi_dp_append_node(const str=
uct efi_device_path *dp,
>   	} else {
>   		/* both dp and node are non-null */
>   		size_t sz =3D efi_dp_size(dp);
> -		void *p =3D efi_alloc(sz + node->length + sizeof(END));
> +		void *p =3D malloc(sz + node->length + sizeof(END));
>   		if (!p)
>   			return NULL;
>   		memcpy(p, dp, sz);
> @@ -377,7 +377,7 @@ struct efi_device_path *efi_dp_create_device_node(co=
nst u8 type,
>   	if (length < sizeof(struct efi_device_path))
>   		return NULL;
>
> -	ret =3D efi_alloc(length);
> +	ret =3D malloc(length);
>   	if (!ret)
>   		return ret;
>   	ret->type =3D type;
> @@ -399,7 +399,7 @@ struct efi_device_path *efi_dp_append_instance(
>   		return efi_dp_dup(dpi);
>   	sz =3D efi_dp_size(dp);
>   	szi =3D efi_dp_instance_size(dpi);
> -	p =3D efi_alloc(sz + szi + 2 * sizeof(END));
> +	p =3D malloc(sz + szi + 2 * sizeof(END));
>   	if (!p)
>   		return NULL;
>   	ret =3D p;
> @@ -424,7 +424,7 @@ struct efi_device_path *efi_dp_get_next_instance(str=
uct efi_device_path **dp,
>   	if (!dp || !*dp)
>   		return NULL;
>   	sz =3D efi_dp_instance_size(*dp);
> -	p =3D efi_alloc(sz + sizeof(END));
> +	p =3D malloc(sz + sizeof(END));
>   	if (!p)
>   		return NULL;
>   	memcpy(p, *dp, sz + sizeof(END));
> @@ -825,11 +825,11 @@ struct efi_device_path *efi_dp_from_part(struct bl=
k_desc *desc, int part)
>   {
>   	void *buf, *start;
>
> -	start =3D buf =3D efi_alloc(dp_part_size(desc, part) + sizeof(END));
> -	if (!buf)
> +	start =3D malloc(dp_part_size(desc, part) + sizeof(END));
> +	if (!start)
>   		return NULL;
>
> -	buf =3D dp_part_fill(buf, desc, part);
> +	buf =3D dp_part_fill(start, desc, part);
>
>   	*((struct efi_device_path *)buf) =3D END;
>
> @@ -852,7 +852,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_=
desc *desc, int part)
>   		dpsize =3D sizeof(struct efi_device_path_cdrom_path);
>   	else
>   		dpsize =3D sizeof(struct efi_device_path_hard_drive_path);
> -	buf =3D efi_alloc(dpsize);
> +	buf =3D malloc(dpsize);
>
>   	if (buf)
>   		dp_part_node(buf, desc, part);
> @@ -912,7 +912,7 @@ struct efi_device_path *efi_dp_from_file(const struc=
t efi_device_path *dp,
>   	if (fpsize > U16_MAX)
>   		return NULL;
>
> -	buf =3D efi_alloc(dpsize + fpsize + sizeof(END));
> +	buf =3D malloc(dpsize + fpsize + sizeof(END));
>   	if (!buf)
>   		return NULL;
>
> @@ -940,7 +940,7 @@ struct efi_device_path *efi_dp_from_uart(void)
>   	struct efi_device_path_uart *uart;
>   	size_t dpsize =3D dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
>
> -	buf =3D efi_alloc(dpsize);
> +	buf =3D malloc(dpsize);
>   	if (!buf)
>   		return NULL;
>   	pos =3D dp_fill(buf, dm_root());
> @@ -963,11 +963,11 @@ struct efi_device_path __maybe_unused *efi_dp_from=
_eth(void)
>
>   	dpsize +=3D dp_size(eth_get_dev());
>
> -	start =3D buf =3D efi_alloc(dpsize + sizeof(END));
> -	if (!buf)
> +	start =3D malloc(dpsize + sizeof(END));
> +	if (!start)
>   		return NULL;
>
> -	buf =3D dp_fill(buf, eth_get_dev());
> +	buf =3D dp_fill(start, eth_get_dev());
>
>   	*((struct efi_device_path *)buf) =3D END;
>
> @@ -980,22 +980,21 @@ struct efi_device_path *efi_dp_from_mem(uint32_t m=
emory_type,
>   					uint64_t end_address)
>   {
>   	struct efi_device_path_memory *mdp;
> -	void *buf, *start;
> +	void *start;
>
> -	start =3D buf =3D efi_alloc(sizeof(*mdp) + sizeof(END));
> -	if (!buf)
> +	start =3D malloc(sizeof(*mdp) + sizeof(END));
> +	if (!start)
>   		return NULL;
>
> -	mdp =3D buf;
> +	mdp =3D start;
>   	mdp->dp.type =3D DEVICE_PATH_TYPE_HARDWARE_DEVICE;
>   	mdp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MEMORY;
>   	mdp->dp.length =3D sizeof(*mdp);
>   	mdp->memory_type =3D memory_type;
>   	mdp->start_address =3D start_address;
>   	mdp->end_address =3D end_address;
> -	buf =3D &mdp[1];
>
> -	*((struct efi_device_path *)buf) =3D END;
> +	*((struct efi_device_path *)&mdp[1]) =3D END;
>
>   	return start;
>   }
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/e=
fi_device_path_to_text.c
> index 0c7b30a26e7..4192581ac45 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -33,7 +33,7 @@ static u16 *efi_str_to_u16(char *str)
>   	u16 *out, *dst;
>
>   	len =3D sizeof(u16) * (utf8_utf16_strlen(str) + 1);
> -	out =3D efi_alloc(len);
> +	out =3D malloc(len);
>   	if (!out)
>   		return NULL;
>   	dst =3D out;

