Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC5CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F6D87499;
	Mon,  4 Dec 2023 12:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBE787535; Mon,  4 Dec 2023 12:06:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9EF0286DEE
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C22152B;
 Mon,  4 Dec 2023 03:07:15 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD4F3F6C4;
 Mon,  4 Dec 2023 03:06:27 -0800 (PST)
Date: Mon, 4 Dec 2023 11:06:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: robert.catherall@arm.com
Cc: u-boot@lists.denx.de, liviu.dudau@foss.arm.com
Subject: Re: [PATCH] arm: vexpress64: juno: Allow boot from VirtIO
Message-ID: <20231204110619.78f86481@donnerap.manchester.arm.com>
In-Reply-To: <20231123182258.15928-1-robert.catherall@foss.arm.com>
References: <20231123182258.15928-1-robert.catherall@foss.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 23 Nov 2023 18:22:58 +0000
robert.catherall@foss.arm.com wrote:

Hi Robert,

> From: Robert Catherall <robert.catherall@arm.com>
> 
> The AEM and Juno FVPs (Fixed Virtual Platforms) support a VirtIO

I find it odd that the Juno FVP *adds* something on top of the Juno
hardware devices, as this kind of defeats the purpose of having an
as-close-as-possible software model, but well...
Are there more differences than this one?

> disc interface. Adding VIRTIO to the list of boot devices allows
> these FastModel platforms to boot from 'disc' in the same way
> the hardware counterpart can boot from SATA or USB.
> 
> This is a NOP if CONFIG_CMD_VIRTIO is not enabled, so no impact
> on Juno hardware (which is built with vexpress_aemv8a_juno_defconfig)

So indeed I can confirm that with the vexpress_aemv8a_juno_defconfig there
is no difference in the environment, so if that patch helps you:

> Signed-off-by: Robert Catherall <robert.catherall@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  include/configs/vexpress_aemv8.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
> index 24d8ca0866..8020689e39 100644
> --- a/include/configs/vexpress_aemv8.h
> +++ b/include/configs/vexpress_aemv8.h
> @@ -187,6 +187,7 @@
>  	func(USB, usb, 0)		\
>  	func(SATA, sata, 0)		\
>  	func(SATA, sata, 1)		\
> +	FUNC_VIRTIO(func)		\
>  	func(PXE, pxe, na)		\
>  	func(DHCP, dhcp, na)		\
>  	func(AFS, afs, na)

