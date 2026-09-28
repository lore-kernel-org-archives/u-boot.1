Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD9CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09421606E3;
	Mon, 28 Sep 2026 17:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSq4JsjLM33L; Mon, 28 Sep 2026 17:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C82C606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615603;
	b=YBRC13HrqzIxt8iyKnjILTB9XYkuEd9bdeDlGbjNYLWzY1IcIF+IboN+xYOmXdp393CG
	 YE+GP0ra+cgUjpj9J2NTh546tuZ1kt9oPVs6WOr1UNo8YoMkXNcdAes2WrjUPP9lnS708
	 hQeGFnpzt4TNx/z94z7MWB8nZMGI0ioeoI5w2uoH5D01yRDT3e4RAWW0bLx41ugjsRUNE
	 qDhpPnPaSgMYa45VIaDJmW9rzuUNrJzd6a6iJFiRHbHYvytRUDFM5UUJyRWHN2tocfjlo
	 TNZPf6hwvliNSERtglRTNftjk4tQmFYZTbJkHAB6kRJnH+U23tDBWQ0iALc8dwrLxqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
	b=ia4ZecsWBfhqdJNWWFxi+pbbrgAAFFUmB/rO/stPpWEFGmG5W8rIsCJy34EFv3NuAqYw
	 wrhl3Mr/i6XnsyaK1wcJn13rqEEUpxxgUvGqZhf/l7spQes440g833va7Uw7Bs1lOoCI5
	 EW6InWN2oOsWjwhhE+hmdEnvLZmqr2EStc25qcCYY54Mh3Jqoqi2JAbOvMIbo/W1Y3kIz
	 qXOgk81xc9ody0SbBZ35XsemFwt3kpQdS2gK+Na+QmHhc02RZBvL02veZ7Qdw//+cDym1
	 6J5dg6UQCG3ZXUIcNclh0biJb4wMdq4BByiD47igE6BrhtO+uAMUnSfqc+UcQJwiqWw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615603;
	bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U2R4qIIvcV83aiYJTkg+0OmvLfkSITWqlUsQC5J62xJt9zSrMDUgBVvgoalDP+Onc
	 ciEonaAsaT1Z6T5R0ymw4FbgJ7TCR/xYi+ZeI59VSIUAJ7PKaKV2xJy0Hz1rzUNPvf
	 ikfDQe7+5lD+59oXohUiMHoLaHHc3oGAksjDP42Ybocu6Y9SKL8FF1QmRu194Gktx0
	 /RX00ThcOeXMyYtFKaJKc6BaAfaGTFgE/obPqRz23WvP2OcRrRggNhwGRRZj3pzWtK
	 Z9UQOwFVGH2B/Bvlh0NObJI9nkhd18qmbRiJFwFrfPagGgpp/7Up7L7/rLNKFcoS4/
	 2yQSuGVFmSrEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C82C606B0;
	Mon, 28 Sep 2026 17:13:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 103092B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB466400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvDZSCOcks3Y for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 54CF2400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615596;
 b=hBYBPnI/rAImsj4uKRJ6G51yBvHjj6CQyMlNE9uI5PVb1r1vksXMMPjLAi+XXlSZs1Rx
 qBWEmGH5tJEGbmfTZNgMqd0QQlp+yWSS9NggT3nr1nSEj+e2J57GlX0adBaOP/ZQAsCJD
 2+lH01sIoKTr7CbE11uOBpr9SVc3Qyy/r64J4nd6ZzLmQEEDXjSvYn91dyf7cQbfECAGQ
 YIyuNhArwUAOpwWBS/4FDcTatm1e9shWL7g38IB1Olz701nmBZi+T7yJLJDyChot632Vj
 7X0dV3zSRB04I6QTeukJz12A1pD0btf/yNFBKSXQp0kI7xBBwhRUmrTThz55LWNufnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
 b=D0rPRSduNnRfxNGkTbA7kIque+Sow3XDKfEhaUbdFRMXZbxTmWB+8J0GHwzRkxhvGMrr
 ObLOvsD0XjdE4lVvljfMVtxzQ0Odv9I0uoXGYLdFOY6HssZ/PFODvfHFQei0pgdcHYYaa
 UCVnO5h4s8c0WgD+iZWo8/a1jfF7upPp0V3iVce4GWVapCLlu1ypJhpv2JQkg8Ep+JGEV
 tFJ3mLWatpnBMt4lRc2O+D7MDtBat9ltGja6QwfGBtfpspF4zM966h9Y+9i3jjpoTnmKK
 tOSKxdmaTk+90TLcvf81kTN0JFiE+qcOlP5GRF8aKVBj8XG/Nj1X2NHfLO/W8ulIuHg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SGR6QTa0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SGR6QTa0
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54CF2400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:13:15 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ec6185so14228835ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615595; cv=none;
 d=google.com; s=arc-20260327;
 b=DpXZK2nREvKU5W4Mmclf5ku+WcBY17ChUULhry12pEX2SdGSZbTOeboaA86b9TdVxZ
 lUnMRt+46wRs0HGzAH2BxfbPwlFD+wjWCeLRneop/eDfoBjmwT22wBn4CKTbmPiSYP1B
 Fs559Eo08Bf+e71OZ+x3qxRbcmAGG4JCDJ/e5QUqQD1EZw9P44KnykvTfXcKIGdpXpU/
 Gr/wz++JSXJp1FzPSNbmCdR+e0E3idk9/oab+TKlG1GmyjrN84NvI7O6Nuswk2MCAeRQ
 KKmAwL6OR1c6/gcSkD1nfVcLBL0VMEw3eSW809n9ItfodiiwgJKYq7Zn6f9pGzRTiBIA
 esEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
 fh=durgfX1b4/1SnC3pJJVYM3Gc1F35eR4yNe+Lv0h5pxA=;
 b=kMDiKv8CnXislHgGPER8qgsW3Jfg2uJRpUj+MytMGNc+cXpZ0Ds+pUKpj5YSdSXgQA
 dsjF+/tqt3qgC91eJZyu8hC4v4l4QsXJ6xYa7LEkKQwOdB/I+6NeP02JBAi14h4DDs5z
 Yz46MYNbLCOlf5GaMKR7jSTJ45S3GG6o97jftfdnASVwNh2rIj5at3wLbXtKMset7xl/
 +xSmPu7fKG0zJwwzeKP/LqUFUagqbnHBDymId0kkkUHu+069jVGvrwsak77ogSvWtySC
 687HGGp5Xls4K09AZgexJdoqtfAEYmv+T9+6eWRSu5u6sBc+7QyIJGdCQ6/gzQW48Rqo
 iLhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615595; x=1791220395;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
 b=SGR6QTa09bgBFqZ+i3zkuoTII5MnBu6znEQkUfd8ihqZfixwanWO74qxXVxCfqtDGJ
 2Fpb6kGtEmuk1fKAh9bMa8Se1hPxC+o2uXO5+m666eECxnc1OBXm6/1wyujTYaGxwWxW
 zQgjiVC3CQdsmEyOx+0CL5zl5l4BiTErqlaTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615595; x=1791220395;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yoeABNMVBWJM/1ANmOzNvvuBHNg8DD3vbWTLNwTmMt4=;
 b=LzhhL1mMCDzWNkJ8UKefO+oo3VP1QSO3vapf1e67q4tq2Lkt9xRREDKFqbv8824gF3
 3I4lC1Pa9zs29PSHt7TY1e55FMp8scXFw867q8zHdpjyvjyxRr9dORkr4gVp1Y3RAICl
 38d9pLe/wZI6zrEdXlP4TviSTEhLYyGISVunvuEqxqEaMzNgoL3OttccS3aPuQLiEy/5
 1S5lkl1AS/z6xI5+rlutEqVBDF7VW7YUk0gXT54tv2bkjWttvFpM8vah3+Ql9NKy3mWz
 BZNHCanYjxxwk1UecY2K08k0XPcnfJCsqVeGKXBG5XZbAW0st208BbLwDqeqC6wME/tS
 kbJQ==
X-Gm-Message-State: AFq9FYINz7uwJjX1fPYFfy9jtZrNs17w4dMsncSVyxoqNrA+oUikkb/J
 H9xhvMh3/jE5BEEM9uuMTqa0qj09RLfRaH/GTmPOZhQAo7bpnUMjEV7aWmCDaYmCVDrZs1QZbVh
 yRm2qybgiHZxGIBOAEfVfrah52c/YM1t3MzS74CW4
X-Gm-Gg: AYBFou1Vx5W1V3ulrb2lgYjR88x5HZJvVvHN8nAF4Pi0b1qarHY2aUcUyvTWLqmtDCy
 Rey5UwnbTWT1yq1X4SdgnQ5Fy3ZxBfzL1Vll8VgbVmKOrdtQ7xS5QsV5XYC3a9xS2dcfPX92CwZ
 F90efnCQBN6uXxScl6iafH7pHo291vTHJo90Kbg2RR1Q5Fe5RiwHX83Xed3WpSmxSMXKRJspXCz
 9+yFLERfk+M0eYBOFnwDGTlKlFSbRbFzJD3y4zk3XTHjdhLxmBRhL/Kvbc5jizQtFmExenV4Fdp
 Zk8wUG9WzES/bEHgR6tBWYEeUhkbhRPIN9rSErJJDLYeHEbbgE641o2JRVySdPUA
X-Received: by 2002:a17:903:a90:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2df7dd748a5mr104654695ad.8.1790615594864; Mon, 28 Sep 2026
 10:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:12:40 -0600
X-Gm-Features: AclHuK97VqBN2dJ4Li62Ajlo7nuMBBzI8xngnPDh7Vnuc6NFc-65SImZH1Ao1cU
Message-ID: <CAFLszThEj-wvVWDUGAtCmYPnWfZJC3ik+suOqcWU0WyWq75qTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Carlo,

On 2026-09-03T13:09:47, Carlo Caione <ccaione@baylibre.com> wrote:
> efi_loader: bootmgr: install the firmware-owned devicetree
>
> SystemReady DeviceTree can boot through the UEFI boot manager without
> going through the per-device EFI bootmeth. Use firmware_fdt_stage() here
> as well so both EFI launch paths install the same firmware-owned
> devicetree.
>
> Keep the firmware-FDT size in an ulong separate from the EFI allocation
> size and retain the FIT filename for diagnostics. The precedence is an
> explicitly passed FDT, firmware-owned FDT, Boot#### load-option FDT, then
> distro/ESP FDT. A configured source fails closed, and assembly failures
> are reported as EFI_DEVICE_ERROR.
>
> Route load-option errors through the common cleanup path while adding it.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> lib/efi_loader/efi_bootmgr.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1320,13 +1325,30 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +                             log_err("Failed to load firmware devicetree '%s' (err %d)\n",
> +                                     fw_fdt_fname ? fw_fdt_fname : "fdt.itb", err);

This duplicates FW_FDT_FILENAME from firmware_fdt.c, which the cover
letter says v3 set out to avoid. It can also be wrong: fw_fdt_fname is
only NULL here when the source's probe fails (or on -ENOMEM), i.e.
before firmware_fdt_stage() has read the 'filename' property, so a
node with a non-default filename is reported as fdt.itb. I suspect it
is better to report the error without a name in that case, or have
firmware_fdt_stage() fill in @namep before probing the device so it is
always available when a source exists.

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1339,11 +1361,14 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +out:
>       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +             /* efi_install_fdt() has copied the devicetree */

This comment is now above a label also reached from the two error
paths, where efi_install_fdt() has not run. Perhaps 'the devicetree is
no longer needed' or similar, or move the comment next to the
efi_install_fdt() call.

Regards,
Simon
