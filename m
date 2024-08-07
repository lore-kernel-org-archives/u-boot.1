Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3355C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422DD88B21;
	Wed,  7 Aug 2024 03:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xzk0yNMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAFDF88B21; Wed,  7 Aug 2024 03:47:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68FD88ACE
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722995242; x=1723600042; i=xypron.glpk@gmx.de;
 bh=lLpsWEKl+QffOLXde6smbBoI70AmDSwJA9fI6HXyWSw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xzk0yNMnXmQnFsPumNCXqqHEXA2SeARPJudsPXXnMR4G83u/Yxm18mC/3kugrdg+
 j/BWfGgjAgm/GsM/DoWnXgGfUneo8zGChlPjTLSffNrI9JMHyKZIuyvbcQPfIcjYg
 DgLMQua11Y0uPeMQVmG2Qx7U0CMlS3loDscRmUOYZEdHSvqxzVSVVCZ1LUqG5m9eg
 WwmzcMVeOnqV55asg/9LyQ4PbkfaS4ZPq+pvfrdvq5RPAEuiNBilF6efW6qW91230
 fPgkxjfcri8ElI+CqZyJu4mTnpGn7XqKC52y52XaeS5AnY7rDP/JQP59ulcuSRqXJ
 Bp8wGBZ2SU1TQQv0yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1shnAw40uB-00RXDV; Wed, 07
 Aug 2024 03:47:22 +0200
Message-ID: <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
Date: Wed, 7 Aug 2024 03:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-38-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y5+G3mK50DDssMiicv/SMrpmRdgl37M7IuD94KA8xv3DHxGzPNM
 8GRWpOaacP1qr5Bi5GuYOb38tLDnzp6GHnHoTd9Dq0WAzJdiCRr8yem5poiRUloq9y2ainB
 yYop/jY3IRiCCGsU1gUm7KZT2l4326zEUkthxIX+yz3dHPNuYQcqEUf4EzkHleUoSdfTeC6
 uQjYVYS4xYQk+Ph7NLIDw==
UI-OutboundReport: notjunk:1;M01:P0:qa55KnzPwGA=;iLiSDOfLeU8UuaLFqp3iMuZHGsS
 V5s1SEgYTqTbnfjbDh6wt3KS3Lx0JwiCiqZmLYCDuo4xTDqizKAfhCmz5454LWWO7t+3FBqu8
 ByITr4hiARPypH3a8a18XbRLCqVfC/GfIABVHg/TjoRbHW2YmRmONQifYBsxhOF5DasA75P0s
 RoxCbny3MFeXFXqP6GzCw6CM5/ZrM4KPNlHmSlO1+F4SGFp9wkewIJfUtPJEaWG9y2tpfoCm0
 2c1LcTOOgZMMAvsmgmaRPKLF8w/duQkaSS0ZhVSt+r2hfkmV4yrXetDBhf3t4H++G/Cf/91zB
 C0jMl6rGl56GdrtyTMLhTsV6OIXUGNEH09JzXcurc2xiUmj28fEjktfhUdQGUFOsaFsRnuUJi
 YIFxdoRICMH6nfi8hgLXexSz7hGm72V0DvWbGRi3WLQb+bi9qzeNuu/lCcbfDgIDK1246nrfk
 tYZrIwOza1g1+u0NjF8W7T5517j7k6k/0zebacUwbfxECC7VqYbAl6TZHrp9yussQcppO9r6n
 4Q3OTPSqBACfjZaQ/2TNxgJQxRmjgSZH22yVU4eM9pD2F6kwR3ejVKadBvhmgblXSSu+QvLSx
 NZ8sBAsigBmb/hDdywb7eq5fkV2G05u4TOewcbUhqr5LQmj/mltgas53fKrMjSj5IEbrHeSDr
 9iE3fmZU02/fjn4xfTSKJRgUIFoXxK9P1lf4VdFsvPZu+6BTRIS0MXwwGetZ1wru9VW1cgvMH
 4QB/HKft3eTULvNFiZRp4zHWBL+BdMI9Rx80so3rgUlFlrjN9rqhNenzHqOrHXTzQSwIL5j83
 T9bpOy8Zog0uEieJUNhNczkA==
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

On 06.08.24 14:58, Simon Glass wrote:
> While sandbox supports virtio it cannot support actually using the block
> devices to read files, since there is nothing on the other end of the
> 'virtqueue'.
>
> A recent change makes EFI probe all block devices, whether used or not.
> This is apparently required by EFI, although it violates U-Boot's
> lazy-init principle.
>
> We cannot just drop the virtio devices as they are used in sandbox tests=
.
>
> So for now just add a special case to work around this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
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

We should avoid depending on the sandbox everywhere.

Please, fix the problem in the sandbox driver.

If you cannot fix it, run the tests involving virtio on QEMU instead of
the sandbox.

Best regards

Heinrich

> +		}
> +		device_probe(dev);
>   	}
>
>   	return EFI_SUCCESS;

