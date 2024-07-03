Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95CC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDA688585;
	Wed,  3 Jul 2024 11:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24618875D; Wed,  3 Jul 2024 11:09:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AB474881C1
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CB1367;
 Wed,  3 Jul 2024 02:09:47 -0700 (PDT)
Received: from debian (X72Y076X74.nice.arm.com [10.34.125.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 552633F762;
 Wed,  3 Jul 2024 02:09:22 -0700 (PDT)
Date: Wed, 3 Jul 2024 11:09:19 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: cros: store partition type in an efi_guid_t
Message-ID: <ZoUVP_CQK_Or28bg@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
 <13D2D563-69DD-4BD3-8A97-37B39A0B5D52@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13D2D563-69DD-4BD3-8A97-37B39A0B5D52@gmx.de>
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

On Thu, Jun 27, 2024 at 09:28:04PM +0200, Heinrich Schuchardt wrote:
> 

Hi Heinrich,

Thanks for your review.
My comments below.

Best regards,
Vincent.

> 
> Am 27. Juni 2024 19:06:29 MESZ schrieb "Vincent Stehlé" <vincent.stehle@arm.com>:
> >The scan_part() function uses a struct uuid to store the little-endian
> >partition type GUID, but this structure should be used only to contain a
> >big-endian UUID. Use an efi_guid_t instead.
> >
> >Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> >Cc: Simon Glass <sjg@chromium.org>
> >Cc: Tom Rini <trini@konsulko.com>
> >---
> > boot/bootmeth_cros.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
> >index f015f2e1c75..1f83c14aeab 100644
> >--- a/boot/bootmeth_cros.c
> >+++ b/boot/bootmeth_cros.c
> >@@ -148,7 +148,7 @@ static int scan_part(struct udevice *blk, int partnum,
> > {
> > 	struct blk_desc *desc = dev_get_uclass_plat(blk);
> > 	struct vb2_keyblock *hdr;
> >-	struct uuid type;
> >+	efi_guid_t type;
> 
> Does Chrome OS only support GPT partitioning?
> 
> > 	ulong num_blks;
> > 	int ret;
> > 
> >@@ -161,7 +161,7 @@ static int scan_part(struct udevice *blk, int partnum,
> > 
> > 	/* Check for kernel partition type */
> > 	log_debug("part %x: type=%s\n", partnum, info->type_guid);
> >-	if (uuid_str_to_bin(info->type_guid, (u8 *)&type, UUID_STR_FORMAT_GUID))
> >+	if (uuid_str_to_bin(info->type_guid, type.b, UUID_STR_FORMAT_GUID))
> > 		return log_msg_ret("typ", -EINVAL);
> 
> struct disk_partition containing a string which is only needed in the CLI instead of the 16 byte GUID was a bad idea to start with. Shouldn't we replace it or add least add a GUID field instead of first converting to string and than back to GUID?

I had a quick look and it seems that converting all those UUIDs from strings to
binary would indeed impact many places; let's separate this longer-term effort
from this change if you agree.

> 
> > 
> > 	if (memcmp(&cros_kern_type, &type, sizeof(type)))
> 
> You could use the guidcmp() macro here.

Thanks for the tip; I will send a v2 series.

> 
> Best regards
> 
> Heinrich
> 
