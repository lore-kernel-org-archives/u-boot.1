Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9362E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1AF8960E;
	Fri,  6 Dec 2024 15:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GdKHPnnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0040089615; Fri,  6 Dec 2024 15:37:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACA58960D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733495847; x=1734100647; i=xypron.glpk@gmx.de;
 bh=V6cvehP5HAGAssABIdrheIYczdTKpgn3/4GnNbx1n+w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GdKHPnnOgi0uZqnb4UhW8UdxFWKww676QGgAEyRA4IVuOoVkekTAbJAEtdxnT8en
 6xWviz6DBNiGBeuP/9ZIVm0hAM+hqrgh3+IgbfWEm0HKZ9Vshh6IDuRbVvl6+PGj8
 IvaseyrYlSlGTy7H6HSymND34gbpeC0/6mZSTvLRb5AlGxyyAuh9V+S6d8PtEzbGu
 mW76tldeCfISPpg4I9T1oeT8R4z9Wxn4HRFnsNVwV2UyOOhXiorW2GjycS9jSdziZ
 aQsE7/J4jRV42nSCjoYIoBty2J8dshaBI5szjIaoIL6vVYu8JObsEKfpSN+EpZ038
 Di88gCuEpOkb3Jw4Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1tDL8S33xn-00Kkk7; Fri, 06
 Dec 2024 15:37:27 +0100
Message-ID: <de3b7e8c-9029-4d56-a272-41ca9e4de929@gmx.de>
Date: Fri, 6 Dec 2024 15:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: Expose efi_reinstall_protocol_interface
 in efi_loader.h
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
 <20241206122714.2365114-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206122714.2365114-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GNDgV/mHth3pxrXBjvQ7i+dz1ex9hHH19B8YzI98E3/7EN2sRey
 AhDy//gH9Q4i0lJK4CTmPUbmH1uhVTJPcW88mdnaHf12Rq4234S3aitwGdoCt8VKk0MRabv
 24sE3SrHUw/3YSFSEmvwwCdcl9j9Uw/RkSuVWj4cVfIg3FYNeUOBa2GCVD0sheJo6mnm0WL
 r/0Cp1wPf69pzBrnlebXg==
UI-OutboundReport: notjunk:1;M01:P0:VfKtdlu/Pd4=;bMdMRAiH6oFWTGdp0hAoqU6eZk4
 EfZP28fWtpXS13K8TdPJl1DI2g8Nbnpj/Sp8YmQScdAJ1gWZe3Lte44T1iTLfTCsEahFNealh
 N0i+iXXnB4e9+yKj8O9SoDR+GgwL61cnuNz7Udrml5X9bt4ea2T30YmeDYiWmZM/IGBznLBAp
 6ewTt90V7eB3BUqjmNDTN9xQydfKvaUioxXk03Ij4SlM18B5Ra6cxlRklo1L6nieu0AAtpfq4
 JXlHvyLQigeF9FwTWFMIOjMUgz1NiByoDtyOH2JwnIB/BBs3ksbCiqh5us8kzQIPn6Nibhp5l
 qBwH2Uiu3/mqL8RVg9RnWr+zoGeNAdCBC+t9XjlsgNv+taEP5vZ8DB6p/fLrCmJ99jKcWvHVr
 GegkhHgFKpOvDT/XUV4ehE7B9WwAafFoSYQozAH8hnreCNyNYNYBA4lIvsxy+OXEuaws4ozoO
 fZ9AV9a/LUhyMoCxgy/0mizbz6HrtOmaBkcF/B5Sf753Ag7dosZJj0sEHDcx/48n2ipH83q6X
 ve772ypxpHGbwa60PUgwFOzdvmkoRQ09Pv6wguMPkdJCmSaK600uTDfJedYfyl++Hk/+uIIOQ
 MMNeWIJSV3oUxoNeYrv+nnwb5Ik4GFM4H85Hvbb6TgCYTnN6eESkzXbUFaQBBGU5c5suVhdg2
 /remcR+ZPG/p7JtBK/8J5Ngec3spdQRRxXgwRDd5u/R1YuH59FEh5OXOd/HZoSLTBhovUbYud
 UeVKvCYTVQ+m3OZgei58xmWWyk32rkA8MfccQ92venOuY5mwjpKjmN/wg1aS3PRW1ZgaUJoTD
 nfNdpUEgbIp0Yj3d4NItq/4MGHWGbDsONG1iSshIjmPCaz3n6frzIhkylZ/rWicpLD9vjdR0P
 ObE02+JahpWjN/EHHnYTXCo0f0XKmf4AOxcd2/8GDrBzVewI8OfUENRnp/UfTGJWYHk6bviB5
 ZHycfN2nbUboE3E28ontIaNOB24dHGDaAocCy4IPeGzH50ZYPogylYRhSbRv4GVxrqE7xOt7P
 XiXqt35QxsLln/jLRkAiJUNQWnF1Fbgrnk0M8GRffyqdRQPtyHW37xdpTsbX2sEeRx7cb/sSc
 wo1alHR4ZBpCu1Qfz2YVWU0DGRx6uP
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

On 12/6/24 13:27, Adriano Cordova wrote:

It is preferable to have a commit message explaining why this change is
made.

> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/efi_loader.h          | 5 +++++
>   lib/efi_loader/efi_boottime.c | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9afbec35eb..0d858c1e12 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -711,6 +711,11 @@ efi_status_t efi_search_protocol(const efi_handle_t=
 handle,
>   efi_status_t efi_add_protocol(const efi_handle_t handle,
>   			      const efi_guid_t *protocol,
>   			      void *protocol_interface);
> +/* Reinstall a protocol on a handle */
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +			efi_handle_t handle,
> +			const efi_guid_t *protocol,
> +			void *old_interface, void *new_interface);
>   /* Open protocol */
>   efi_status_t efi_protocol_open(struct efi_handler *handler,
>   			       void **protocol_interface, void *agent_handle,
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 080e7f78ae..58716fa795 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3733,7 +3733,7 @@ out:
>    *
>    * Return: status code
>    */
> -static efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
>   			efi_handle_t handle, const efi_guid_t *protocol,
>   			void *old_interface, void *new_interface)
>   {

