Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3DCEED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E0A88E79;
	Thu, 12 Sep 2024 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bp0l0jCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBDF888FC4; Thu, 12 Sep 2024 17:28:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52DA88DAF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726154883; x=1726759683; i=xypron.glpk@gmx.de;
 bh=r1d4HWJxjSE9D+9XkmdHdOKQtX3jtFIxMa5dQZeYR+8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bp0l0jCKwMqOOaMvoGqsQypUQ/hdMLUKEe8L+lMB44K8ykeyK6Pj3h54ofEW7rNh
 ei9XwrxdDYHdtcwiQMCukWsNa8ex4Nn//0myVTLGzpKkPRQlwFcKuyh0JEUHzB/dI
 wxhF7EgHLDeZ5u/gO9J1b0zoalfho1dYzqgC+pzHG4eR1N38YRw1aKcR3yMkpdHjk
 UUhhuYk/g8EvgqeaG9TJBokZg0+JcbvhRy5ERBr8yWYEcitDgzvjC4AS3hcJzMYk/
 uZYjsDSN9Iz5yJ1ZVlxw/o0ORxpGpJLbCU2kMO5H2pWac3FTgGZbq5+PLpd22H9JS
 lS9oSZicXjK0FSI5Bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1soljn0kYC-00BMV9; Thu, 12
 Sep 2024 17:28:03 +0200
Message-ID: <6a90f50f-ab7d-469c-9ebc-104d5e72bb6e@gmx.de>
Date: Thu, 12 Sep 2024 17:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] bootstd: Add debugging for efi bootmeth
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-10-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JG9JSbyoGBIfnjsIWDb2nulgxGmRgfnH12z28KpSJc0HeFDoRNX
 d8CLiWJ834Ni/wHPvjyd+IpAdJA0PuyXjp+XYxi470FmDnfPd3wSD1tMEInsuQdaggvkxz6
 RiFwnP1NGtZoBQpBnNPzpbru1OpRfTGwLpEEbwlCBeV0Ecf/iWSjWRJxa+t/4FZQANUzqD9
 lxENQib6Wvm24XUb/YHNQ==
UI-OutboundReport: notjunk:1;M01:P0:ZYNZGVgKsZY=;cnmtIooDM1y7Ycb5zxfRERAF7zD
 1kRF/UGwjYMrItTweitbqxSpZQKqLotZArJjtbQk1FLycAJTBJD+PQavV3bZpEuDYA4TyCQTB
 tJ1nguc4/my+j9WTSLZY5UWGc4bgjIkY3PW680B1ypn52953xxyoQB0fKe7MjDrODyejhQU+M
 Ytg/o5pNOl5DFAleqJHKkhZCIFhvKPRAozBtU8E/o2239rb4P0QBoMPTn0GLhGo0DFhKtj4ou
 k2P4F9NVL4A8LdAt3y7wVNEivnYggGDP5FLV0MPGlRbD8iZklCMiuIPCKRYSVNagWIUEiub/f
 1yY1TvrNE/KiaLRgxNdYXilPUsVHpWlvCEOrScoTyBGKkt1F9908cVsmWxUOBjaFfINX3x3gb
 EcICQDxBRV/4q9n15MIJKtM6+L3a812GcLX/BNKZjdOUryigjgD4rEsSlSJ4zGDB44LtNblRJ
 B8O6P2dEJmBfVtvgyudW7OCLxG7EVCQsKlXIKQDZU3Zrmtdg1DiH0wG3LtY0mVaZwC0oyB7WF
 Qhy2+Mip8L1nmtC/Om0WaWDgf+eyL/i1+9Lj1ULHWsvVtFxcLiXOCcHrAn95U+04W5BdOccRf
 PgfGMSrZbmKVpmA6/2Tbdi47mbvnc5TUFCPVvzOxLJ1/mPETMWsx8uixlc/kfC1Ss/N+frjI0
 zwXp4+zbGksyMTRSkhETmEt7kjezltp10TrsJ7weo8K3ptA4VR1Bhd5ZtuG6S+8iJiAP47CtX
 NihdRbEN8CdI38a4qGB5kLQmMporzBdSjsDhSkmJr6l7KOP0wzyJ1DXGzSxw65IPv/gR/3p7Z
 on9oTYj5lNpxRvVgtnLrZ3nA==
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

On 02.09.24 03:18, Simon Glass wrote:
> Add a little debugging so we can see what is happening.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> (no changes since v1)
>
>   boot/bootmeth_efi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 6b41c0999f1..4d641d042ec 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -162,8 +162,10 @@ static int distro_efi_try_bootflow_files(struct ude=
vice *dev,
>   	int ret, seq;
>
>   	/* We require a partition table */
> -	if (!bflow->part)
> +	if (!bflow->part) {
> +		log_debug("no partitions\n");
>   		return -ENOENT;
> +	}
>
>   	strcpy(fname, EFI_DIRNAME);
>   	strcat(fname, BOOTEFI_NAME);
> @@ -171,8 +173,10 @@ static int distro_efi_try_bootflow_files(struct ude=
vice *dev,
>   	if (bflow->blk)
>   		 desc =3D dev_get_uclass_plat(bflow->blk);
>   	ret =3D bootmeth_try_file(bflow, desc, NULL, fname);
> -	if (ret)
> +	if (ret) {
> +		log_debug("no file\n");

log_debug("File %s not found\n", fname);

>   		return log_msg_ret("try", ret);
> +	}
>
>   	/* Since we can access the file, let's call it ready */
>   	bflow->state =3D BOOTFLOWST_READY;
> @@ -307,6 +311,8 @@ static int distro_efi_read_bootflow(struct udevice *=
dev, struct bootflow *bflow)
>   {
>   	int ret;
>
> +	log_debug("dev=3D'%s', part=3D%d\n", bflow->dev->name, bflow->part);
> +
>   	/*
>   	 * bootmeth_efi doesn't allocate any buffer neither for blk nor net d=
evice
>   	 * set flag to avoid freeing static buffer.
> @@ -332,6 +338,7 @@ static int distro_efi_boot(struct udevice *dev, stru=
ct bootflow *bflow)
>   	ulong kernel, fdt;
>   	int ret;
>
> +	log_debug("boot\n");

We should provide meaningful messages.

log_debug("distro EFI boot\n");

Best regards

Heinrich

>   	kernel =3D env_get_hex("kernel_addr_r", 0);
>   	if (!bootmeth_uses_network(bflow)) {
>   		ret =3D efiload_read_file(bflow, kernel);

