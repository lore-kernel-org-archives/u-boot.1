Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5002DD1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE90F885F5;
	Mon, 28 Oct 2024 07:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hP+SbXph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C734B8887A; Mon, 28 Oct 2024 07:13:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AA488360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730095979; x=1730700779; i=xypron.glpk@gmx.de;
 bh=4//VagqbcbQeIDLFpW7+HW/1nWyfeiOD6+mV67GMLYo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hP+SbXphs8y5GZ9hpntM2JU9A2oSjCArvM1XYucmviBe6LJePvp8jpRT0T/T0ArQ
 0zoMlUKm7hTmgEnlTldihbu8fx6eb47vo43T+xIBK9dyn+KSKu8Ev+ssd4YIGU5kn
 /ZdqtNwnVH6rKMSenTt0PU0pG1x+Go2eJr8KM2zsY7NOieDocp2Y7rbOh2sW11e/X
 DnWyYa7Obgw+qEZR2S7mgBC+ILnbK5DgXAEbwGl4DxEamh454h7GBkE7K1dsHLcWU
 z0vY8Bv/meVxbegVv85OQSxa1D7bi2mEnS09N/1hAKZV6PtARqJfBU34ukEB6GClR
 9ZdqmoKOIcGHdw0XqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1tIaex0eFE-00Izi2; Mon, 28
 Oct 2024 07:12:59 +0100
Message-ID: <ae853e4b-d6f3-4472-9559-2e0981849867@gmx.de>
Date: Mon, 28 Oct 2024 07:12:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Remove unused diskid
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
References: <20241026080050.125214-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241026080050.125214-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5JGHdzc1sdL5sskKoiEfwmADmPo+/JGdX6xRoeM1yIQidD9RfC6
 9BFtikGckUFGmUCw8UKmfXVCmY3yuGbSqulVamHNwzCUKqHltjx44LmsGRmwMtssZbwmE/7
 YQgEaqrCNJTG3TqqrVKBbf39cJCa4wekrp6CdhJSgAVEAlQoThuFqm7geyP47NpYzVwdexF
 MbjV+loPeKJy3lIARO77A==
UI-OutboundReport: notjunk:1;M01:P0:H7WIKODWFB0=;JUNhDYZFocZWqEUGzBwimrXNzhI
 0pNXWpYTpru8ROyyb0L11ejnYwybUdv239r77JnIOVlvi7bTgd+XBcTA095i3Vzfd74NGMVRJ
 rf2o+lErhgTsyOLKmiC/ASrPPxDuiNLT/htl9pmzgkVejhYTCzfNTdVaweOXw45LlsqGqsbQi
 ppd1t6/QmMjpKVqx5842TKURpAvFPQ2/fQLjbdnSiWrGnT/du1C8NjtB/EgqvUA4NrVz01tQ9
 SJ1CXgW6D6vtwBsXM2lsG97RczELWBjmhBm/52NiNkXyvKV1OBAatrBwkuSRL4o+Hl1BfkoXb
 VzNt9tV4QGGhAkmFtpFhPLqBKvqBF530U0sKYV1Z/yZdprulKVucX2yl3OFOT/tzo/xcO608A
 aq6LswquxkC0Vs2g6C1LgXL8mK4XM1hfDZxOp3sifx56Lk57ItpP0uY524ujsQDQHKnQA1EZ2
 hZGK7MzRCBBY22ojK+r5Y3VWRkhWQg4dH/XyaT4Cv65GwH0LxvyYSbuMpMi4tXbyYH307f9XF
 SQ7LZLi2dTHOa1qslOWwkytwcvgYj9Xt5bXfmeAu1WARr8CSe/B+94tkJiyLhW3929K19V9uA
 znwzy8Uodw8RuIXHc3xBBLLypZ3xQ/F82BFF2aCO/7udv/z5rHEKipq3tcUxEErj5SGU4G70H
 4YhKtim8xrfVzv+ln0Y2nbz78EWzPxK1us9VMaMmH/2ej0b96iXXwWJgMuPEwEXUN3yIoncFs
 DV+L8+u9nYS4zq3TNmNLYTvKQL9KHF206MPx6rvvwfpV9iTfJD57hjknWFk2whstdBYQGgRj7
 JZS8yQNjQbmnzlOvVrrcZhaA==
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

On 10/26/24 10:00, Ilias Apalodimas wrote:
> That variable is defined and assigned a value in two functions
> but it's never used.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_disk.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 93a9a5ac0250..1f3de0a23399 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -561,11 +561,9 @@ static int efi_disk_create_raw(struct udevice *dev,=
 efi_handle_t agent_handle)
>   {
>   	struct efi_disk_obj *disk;
>   	struct blk_desc *desc;
> -	int diskid;
>   	efi_status_t ret;
>
>   	desc =3D dev_get_uclass_plat(dev);
> -	diskid =3D desc->devnum;
>
>   	ret =3D efi_disk_add_dev(NULL, NULL, desc,
>   			       NULL, 0, &disk, agent_handle);
> @@ -608,7 +606,6 @@ static int efi_disk_create_part(struct udevice *dev,=
 efi_handle_t agent_handle)
>   	struct disk_part *part_data;
>   	struct disk_partition *info;
>   	unsigned int part;
> -	int diskid;
>   	struct efi_handler *handler;
>   	struct efi_device_path *dp_parent;
>   	struct efi_disk_obj *disk;
> @@ -618,7 +615,6 @@ static int efi_disk_create_part(struct udevice *dev,=
 efi_handle_t agent_handle)
>   		return -1;
>
>   	desc =3D dev_get_uclass_plat(dev_get_parent(dev));
> -	diskid =3D desc->devnum;
>
>   	part_data =3D dev_get_uclass_plat(dev);
>   	part =3D part_data->partnum;

