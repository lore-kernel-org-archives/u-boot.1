Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF23EED611
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C2088FDD;
	Thu, 12 Sep 2024 17:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FwXYi+bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FA688FEB; Thu, 12 Sep 2024 17:00:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9225588F95
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726153204; x=1726758004; i=xypron.glpk@gmx.de;
 bh=XPknT/XOgzjWdBTmqW7ozF12Nk936bUoy1kstwi4QpA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FwXYi+bmj4MajvLySMoSwz6ML9qWdP1jkO2kv2zQhwkY69XQgJZeDt/r2K6WCHkX
 04ZP5aYe96K51DTY8Dqd1bGYivKMuyAGsGOM/g8+KhQL8hUZMHQJNEjFw+x7paxrc
 aIv62GnGwaIuwPs8fAk97bEJU9XH9IYsOPfqgxoY6MN63u6jJv56sSTkeCOxrJ7SR
 uyB7Vp3vVAB6bxFFnZU/h2H0afGj4QOr2xUqwYmU25RXpcwteePCCYiYJCkwhvcNm
 ErUZDEa2Ya1QlPTtCemQmyCwbOoT0uPmf3fkSsGUhfbETkGDKQ3CH7lbMYSDqzXDh
 1sUlsGVoaHlkkFxZWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1s3yKu3YIF-014hjA; Thu, 12
 Sep 2024 17:00:03 +0200
Message-ID: <95edb150-f53d-415a-8176-56e0fc66c822@gmx.de>
Date: Thu, 12 Sep 2024 17:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] efi_loader: Avoid using sandbox virtio devices
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-13-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XKoIzro6hAswZfNLtw/PV0RHv4X2bsEiPqgu843AwfzQCUBnU9r
 IjYCjt/ztcGk46Q4A4YQHngmVCG/LfmmQjlYvwf+9j1gMUkdbfsyGUjSuD1eymDg2TPvgCT
 EqYUJjX9LkuvYhB8+AddjBtYuy/Slhe4+Q6Ya1q7HAyxzfs02VjtPirqFl7qOGM/QHb8p48
 xDcSnAgBqbeLOFYfixiTg==
UI-OutboundReport: notjunk:1;M01:P0:f6fSSdUWm0o=;PBSnjpGoAWFy7JdjHebOAO97ZK6
 CyaZ05btzszShx+skVDFIvaf7GWosgdf4eabkdkCmk4XiWIoNXQ8gFWtzugjcjdMSX6tOIxiF
 rhGCbDWebEOUJvS9Tt6HOFwD7pkwV5wufZWaGdHzWQ1FE/wnxsVq+HtiYnzgLhD59LotdDzpo
 48NymPRebQntr/w+NQX7rqpFY9mCpv80KiG5dNuUBLn5txX80T9ALIwfX804+aii5i1QgQyOr
 v9hwmW/F2IwOlyNt4WXoKdjyO9HLsqJV2G4Xm+AAmg1WTqTISc8Lnw0yedhpeF8cSiiHIqJ6z
 LciAEEB0FzIzqtFsPGYBftPy8UWN6A1/j8a5e8jBFT5XjkMzr7GiKHyzRHOwDu4qAT8ki/IQK
 hjqnfs9AyTl9vzkzqy2b0Zxhc+/fIY8OBZwBRmAWyJ5mNj6QMNTBzywNrErwgX/2U2w2Wwhcm
 Ms4Of2T5HXE1taqHGyDJPKrH2RvM1xIQF1uNp550/PSurnjVVGBY8fYkWKVQBvBou0khQikVI
 5r5YNFMPcJUbXEDYrQrs2KxA8irdoKQ2tU0AOzljIp1Hj2S3F3SxiqegLrfJAew3W/nV3HC0k
 4bT1YJD94v6/AVzCIcHQZaPispn4IR1t9WXlgST98aY6dD+mnJ1Av4xn7t8SyDKISHEQit0PH
 baWd+8iDMS3oSw8GW2NdZ9fWSVUOvWK/mGskTpMZyW2yaKAc8w6Pl2RzoO7lIl5h4PBxrMnjF
 LpNl5HbEsGD00k11S/jNOdTLy8t02IC0p1KMJ2xvVz+lVog6EI+35ITPQCussqiXsGrYJeev2
 OS6rp/QK/xw2I1n0ghaKFWjg==
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
> While sandbox supports virtio it cannot support actually using the block
> devices to read files, since there is nothing on the other end of the
> 'virtqueue'.
>
> A recent change makes EFI probe all block devices, whether used or not.
> This is apparently required by EFI, although it violates U-Boot's
> lazy-init principle.

We always did this.

What problem do you want to fix? I have not seen any issues in our CI.

>
> We cannot just drop the virtio devices as they are used in sandbox tests=
.
>
> So for now just add a special case to work around this.
>
> The eventual fix is likely adding an implementation of
> virtio_sandbox_notify() to actually do the block read. That is tracked
> in [1].
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add a Fixes tag
> - Mention the issue created for this problem
>
>   lib/efi_loader/efi_disk.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 93a9a5ac025..2e1d37848fc 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_han=
dle_t handle, char *buf, int
>   efi_status_t efi_disks_register(void)
>   {
>   	struct udevice *dev;
> +	struct uclass *uc;
>
> -	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +	uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> +		/*
> +		 * The virtio block-device hangs on sandbox when accessed since
> +		 * there is nothing listening to the mailbox
> +		 */
> +		if (IS_ENABLED(CONFIG_SANDBOX)) {
> +			struct blk_desc *desc =3D dev_get_uclass_plat(dev);
> +
> +			if (desc->uclass_id =3D=3D UCLASS_VIRTIO)
> +				continue;
> +		}
> +		device_probe(dev);
>   	}
>
>   	return EFI_SUCCESS;

Please, do not spray sandbox tweaks all over the place.

Can't you just return an error from the sandbox-virtio driver when an
attempt to read a queue is made?

We are using virtio on QEMU. Why do we need sandbox virtio devices? Just
run the relevant tests on the real thing.

Best regards

Heinrich

