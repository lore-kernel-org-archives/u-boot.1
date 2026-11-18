Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FF606A334
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nQcgHbQp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=bZy7DIUK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61ED781196;
	Wed, 18 Nov 2026 15:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2PyjjuCSpa6c; Wed, 18 Nov 2026 15:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C580D8119E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016140;
	b=D4QcqFz4/BsWCc5fsxKmDLLMaAQVmh2a91SegQtGWx0naClRk0QoqTOn4WXb2UCVzKTf
	 5DNhCXqwUy+oYD657g1+LkBVJV1VbaC9f93EYeXpnikw+/oaeCt5ybM+wOl+etcwFEo5u
	 epbujKZqtcKDptyGzq4dvLgtGNQxy3wMvagI0idOue2J2liJxkor62Se9miSJ/FveQw5d
	 bFQJLu9FVyUu0zV0RMRucya5EVZUMAFwt/hGdBESXm15Xk7LPnHt22Jc7wVJXo8/l1BZX
	 RTiZMob2pfaseWTeP2ZkVNfIH/mJ8abkjGw9DBf8CPGDDmMzZKsGzk3DIy0OXJtVIHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mVjGApybbPTvC1hldAGbDmvuw+lFp5qhOx6coOSpeeY=;
	b=iQABBzHJW+PVlEg2Y4/7rGzP+jDG1+oN0wVUJkCp9ZD16d8luSB1LzJ+w2Pr0wxdUL2i
	 ryNqUJmVx2sSGzBuFks+VDS20DwtAcyV9al32w69bB+wG/5lcdQ2fXGxxml02UGnKDVvr
	 bG/detZm5X+CfvLvIDP3mKe/lPgEabAumD5M/Nkh/l8i93i+APVWxxD9lIUaso2qQWvPw
	 zlU0S1etyy91jet7dwahhiNivl8KeweIVX8JSh4P8cqRtz4kJ2M6pdkY2MspL/uNnSDEh
	 lzrlR/r9lGmV8JPtgdNIXer1xDpzZDsTbyBXmXTt7iuhmq5V3FS+RyfW5T41DZhSA4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016139;
	bh=mVjGApybbPTvC1hldAGbDmvuw+lFp5qhOx6coOSpeeY=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQcgHbQpHcZ9K3RWace4p9Of8sQmoKm88+wDyjTEuXNqj4NixBoLK0uHUexbwJuUe
	 j1gyyqsnAGjgFd6JhlAnsj6yqDEmCmKBIqXTAe2hlDQ1/ngxwKRvlNqB5QV5AiMncn
	 SzwY9Ed6YLxXlIOdjoRCn6v+LTtS7+JbvTyuYHejusqXbZhEmTC9ti/EDrFoBKKPVS
	 YkXdJ+aGYWOtrkO/5rKBwOa/KaPf6JJjLIbKG5PB3Bo05yEG/qpFwSETASWfgbtz/C
	 tcwxoUXj1qH5kIYs3VjA64e6WHOuHjbLNoo5vSbIxcXPx5aT8xZ24wT8msvnUIqJ42
	 5k38nJvTNuPbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C580D8119E;
	Wed, 18 Nov 2026 15:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 527D428C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 381FA40895
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rl8vkYuWEERo for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 31CD440812
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=bZy7DIUK
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31CD440812
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:35:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=bZy7DIUK+QT+c+yfpxc4UJyQauG8xr38PtTVU9CmWV9DZJF1s3jTgMBfvA0Zd63pvk6WZheLBRDy+h3MrY55XDQSCN4yxRKtBfkNH30t2tB4oIRov+ta5JtKVjxYEeaFg1JHIYh1HLrTH0nwsyiBLKBmIi1LWUzNyc3RZx/9H78=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=mVjGApybbPTvC1hldAGbDmvuw+lFp5qhOx6coOSpeeY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795016107479663.1964997984178;
 Wed, 18 Nov 2026 07:35:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 23:35:02 +0800
Message-Id: <DMYG3PDX1XU2.1CEBB4VRVJHNC@pigmoral.tech>
To: "Tim Surber" <me@timsurber.de>, "Aswin Murugan"
 <aswin.murugan@oss.qualcomm.com>, "Jerome Forissier"
 <jerome.forissier@arm.com>, "Tom Rini" <trini@konsulko.com>
Cc: "Sumit Singh Dhami" <sumit.dhami@oss.qualcomm.com>, "Simon Glass"
 <sjg@chromium.org>, "Alexey Charkov" <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] boot: pxe: pass the initrd to EFI applications
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <2113981400.38169.1794275897389@app.mailbox.org>
In-Reply-To: <2113981400.38169.1794275897389@app.mailbox.org>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tim,

Thanks for your work.

On Tue Nov 10, 2026 at 9:58 AM CST, Tim Surber wrote:
> Since commit 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI
> applications") label_boot() runs every image with a PE/COFF header via
> efi_binary_run(). That includes regular arm64 distro kernels, which
> carry both the "MZ" PE header and the ARM64 Image magic and were booted
> with booti before.
>
> The initrd named in the label is still loaded to ramdisk_addr_r, but it
> is not handed to efi_binary_run(), so the EFI stub starts the kernel
> without an initramfs. With a stock Debian arm64 kernel (storage drivers
> and ext4 as modules, root=3DUUID=3D) this ends in
>
>   VFS: Cannot open root device "UUID=3D..." or unknown-block(0,0): error =
-6
>   Kernel panic - not syncing: VFS: Unable to mount root fs
>
> Pass the loaded initrd to efi_binary_run(), which installs it with
> efi_install_initrd() so the EFI stub can fetch it through the
> LoadFile2 initrd protocol.
>
> Tested on FriendlyElec CM3588 NAS (RK3588) with Debian linux-image-arm64
> Fixes: 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI applications=
")
> Signed-off-by: Tim Surber <me@timsurber.de>
> ---
>  boot/pxe_utils.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index c60429a5e1..21b05ff9da 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -807,13 +807,22 @@ int label_boot(struct pxe_context *ctx, struct pxe_=
label *label)
>         if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
>             efi_check_pe(buf, kernel_size, NULL) =3D=3D EFI_SUCCESS) {
>                 void *fdt =3D EFI_FDT_USE_INTERNAL;
> +               void *initrd =3D NULL;
> +               size_t initrd_sz =3D 0;
>                 efi_status_t efi_ret;
> =20
>                 log_debug("using bootefi\n");
>                 if (bootm_argv[3])
>                         fdt =3D map_sysmem(hextoul(bootm_argv[3], NULL), =
0);
> =20
> -               efi_ret =3D efi_binary_run(buf, kernel_size, fdt, NULL, 0=
);
> +               /* hand the initrd to the EFI stub via LoadFile2 */
> +               if (initrd_addr_str && initrd_addr_str !=3D kernel_addr) =
{
> +                       initrd =3D map_sysmem(hextoul(initrd_addr_str, NU=
LL), 0);
> +                       initrd_sz =3D hextoul(initrd_filesize, NULL);
> +               }
> +
> +               efi_ret =3D efi_binary_run(buf, kernel_size, fdt, initrd,
> +                                        initrd_sz);
>                 if (efi_ret !=3D EFI_SUCCESS)
>                         log_err("efi_binary_run failed (ret=3D%lu)\n", ef=
i_ret);
>         /* Try bootm for legacy and FIT format image */

Your patch fixes the missing initramfs in my PXE boot setup on my
several RISC-V boards.

However, the tabs in this patch seem to have been replaced with spaces.
This also affects the context lines, so b4 shazam fails to apply it:

  Applying: boot: pxe: pass the initrd to EFI applications
  Using index info to reconstruct a base tree...
  Patch failed at 0001 boot: pxe: pass the initrd to EFI applications
  error: patch failed: boot/pxe_utils.c:807
  error: boot/pxe_utils.c: patch does not apply
  error: Did you hand edit your patch?

I had to apply it with git apply --ignore-whitespace. Could you please
check and resend it with the tabs preserved?

--=20
Best regards,
Junhui Liu
