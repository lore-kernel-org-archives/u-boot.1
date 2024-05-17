Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0505DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 09:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BA588489;
	Fri, 17 May 2024 11:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YJ5+/sB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BE888494; Fri, 17 May 2024 11:09:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3E18847C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 11:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715936986; x=1716541786; i=xypron.glpk@gmx.de;
 bh=a3A9mGmgTgWF752cJIqZ3EQCLGSfqaAyQZewGfhpuwc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YJ5+/sB3ptyXetRu9ZKSE18dlR7SWhmidX7T6iKwn6hEE5LpRVAq0vQXC0JSlecV
 QPOEDswszJmZfNw6gnGRPxVCP0NZopL5qrrMaSNc9WkcVuJcs3jmTtEexhJm5VJES
 LTB+V1nb/OEyMcJ5zj8Q/jPCjtekTh589pSZa/eQ2U/ya0JmWkKRoXm2u6/j2519Q
 O8aWCJxDbrNMsR79g6XnlPZzNVNtz5feideok0OC8V6FvDxIDFVp2PAKtX/VaCbKp
 g1pDqaxn01ikLfqVdDXEx9StfWoU6RAvYuIRzNnRf8VdwUS2WXC1Ga+X4UZ/m+t85
 AAenOTipuQsKPwPQ0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1sLeB22Lb4-00E2GZ; Fri, 17
 May 2024 11:09:46 +0200
Message-ID: <9414d718-2363-442b-88b3-b3890e619422@gmx.de>
Date: Fri, 17 May 2024 11:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: Update netconsole examples
To: Fiona Klute <fiona.klute@gmx.de>
References: <20240514202041.386027-1-fiona.klute@gmx.de>
 <20240514202041.386027-2-fiona.klute@gmx.de>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240514202041.386027-2-fiona.klute@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yKe1ZWxUG9+HqpWreYmZ+JW7SRztjsewqK2lAblVsScUzOUMwAa
 ol2ujxpaZMcOhY2Rv+BNy0I5m50UmTqx/ZzPnkbx65xhHoBUaEPXuGvS66vHA2KSr6hv2nw
 zJaHJP4h6s2Xk16QlmDTg4bAOsxOyMxT/ZU+KMfgUZq576Ap1vjQkJkvHgSmqZMM8iqa1Kg
 8xE2aUaIZeeQYPYAmk8qQ==
UI-OutboundReport: notjunk:1;M01:P0:UBinEavmn8M=;Qt8f8PfKCJvZwaADn4TOBJ8vxAB
 CJHCIO9udk84uvY0q+XjVn3RBnc5qsO2sH6YOjENBxRZqF8Xxf8nZVvZoMXD2fp2b9ihXg0zK
 gYsFf5EBTvf85MR0+qHc0SO4wRyI2Idn8+AMb5i8Co9SGTxhm/GvFtOVRBlLnJ+vJW9jFQ301
 eR7FPonMV4Dd0NeAxAiR5nEkSLDJbyq7s06JvZhTMQ6ef/ZxcRN9L0k2Qrx80jlMI10nheBMW
 0hWzHfFCCLIpMKRBj4grnDI48ep2MPvyBr5suRUPupA6na4sIsgOaMRVKkhb4DW4YAVX0Pu6y
 qon1f60ER/1JE7OWgAGnvq44oNLhkWPXtj+1un9jZ+YLe3gZrnuW4yf63NkdWWApGcQoSA/JQ
 UTYbtY3TY1O5Wi9JvpgptL5vpm0IcosAcJJT1zSg40xR42Rxz96/OPyQ/v282dg4k3dOn6t3C
 3zSJHK3OxxRI1pAueawEezuMJKOOghidIzOcUiojBrNdzOGZ16adHhivCOx/5MYZzLhDSA3Wo
 e4rVRnK1PWs1kqUJEEIyvjUkCUf9agCSoIo9538QOyY4+HYlAtqksqoUheyksck60Q1QWePH8
 TWf2wBv49l+pZ3RL6w++DAMOmikqILLysCYy7KrfZBFlJnicmhHntwkTW//hI8KtTUSHXCO8Q
 p84+VKOc0CS0Gnsiz7fjhRo/sdihhr8wYCwYX7jSYNP07lvKcYcCXW1xs2XKK1ecq/500VMdZ
 dNaj4RWcfv9w9R6l8auDulhJO1wRedVimOVUaSw2dmAMH0oxkeIvHJQZ2GXPJMIkVDOk5Q7Ej
 whljZHOoXZajIRygaKWRY8icZWiCVXFCQTAtpeDTgo6So=
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

On 5/14/24 22:20, Fiona Klute wrote:
> As I understand the env command documentation the subcommand style is
> preferred, though the old format is still fully supported.
>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/usage/netconsole.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> index 0c983e6970..b5832843f3 100644
> --- a/doc/usage/netconsole.rst
> +++ b/doc/usage/netconsole.rst
> @@ -24,9 +24,9 @@ can be used for network console.
>
>   For example, if your server IP is 192.168.1.1, you could use::
>
> -	=3D> setenv nc 'setenv stdout nc;setenv stdin nc'
> -	=3D> setenv ncip 192.168.1.1
> -	=3D> saveenv
> +	=3D> env set nc 'env set stdout nc; env set stdin nc'
> +	=3D> env set ncip 192.168.1.1
> +	=3D> env save
>   	=3D> run nc
>
>   On the host side, please use this script to access the console
> --
> 2.43.0
>

