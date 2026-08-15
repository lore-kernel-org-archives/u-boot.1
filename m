Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB1C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19A2940838;
	Sat, 15 Aug 2026 18:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrIEDLoe8TZz; Sat, 15 Aug 2026 18:44:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48EDB4082F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786819498;
	bh=dKnBM2CenBhATeov4YapUkEFMkETGra//v8DWWdQOhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bLnm5Aek53RQIpXwF2bXUbcuaps0MDFQLnOa1hYHk0qjXKd3I/9qo6uzf1SuCpMWS
	 obhvwYyFJL9cC6mnzBnsdDd//ngIOf2WfWZfV5+NAllPTHZOCKQWNdLElXRAVzbZk3
	 YmjQxYTX6VkD9KzeaLA5ewEY6UaeQXQ/ZshNi9kwmA3cjXpWeF3p7SC8qzmv/BuLP0
	 zrA9xR0hAgPo2CtDI2We9FOwhPefs9CmtVpJ9une34eWLDx1Z/1lb6NZ0DfXjVgYjj
	 opgmm+FCQhZxBfHua0F1jPSIB4+e5ro3enaCB3UQJs1OenL9FehbmaSDYIeILETjhr
	 9q7ii8qkmhOMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48EDB4082F;
	Sat, 15 Aug 2026 18:44:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B8F1109
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D5B880E4F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNzLAt3IFdw8 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:44:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0AD8980E4A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AD8980E4A
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K1Pqa7O/
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD8980E4A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:44:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so3262083a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819494; cv=none;
 d=google.com; s=arc-20260327;
 b=oAAdRlJy0udQS/tCxp11ZDKTJRYBRupDwQASbUs29HQsMsRB+2FQycIQYn6HDSj2aj
 OKdfceVGGyPidHkcAF6TBtnW70W60uAPS61FEHRXd2ugvKbZuwfBjtVTI9TvjvO0qpa1
 P+nAeNKSR+v8hJsC9CinoNM5ur4hzWpZSJhW00Q6nBkn8zw2KXsT7hHSd1MP0g6z9DKw
 CfnyJAhRUg7aO3fVJjzqM5BgLLueyzi1fDJfSil5NVBUUqrgQyYMtZHAjcA+ZvovULIn
 dJst4hxE5qOILYSfe1hPbMMdfgXD9bi1TRtT2LFqHXULz5yeO2O+0TN6jfMxGEmAk7IX
 kzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dKnBM2CenBhATeov4YapUkEFMkETGra//v8DWWdQOhQ=;
 fh=lMu/IoIlTfGI1wvkQqdTjRQJTv1loZZGdihE0p1XJi0=;
 b=hY3Y0+k9G5x8djGN0nFIDtNZ/acmHcyy/iq9PmHbuU67Cv01YWqp9mQqJlQpIQByxv
 ahta3kdms87cES7Wcv4UMjImNhVgC26pI0qaNkS36yuMxpICpJxd0dhj6vGxMSvYHxTW
 bnMapVH/v524u4iWi93uuPppezuclgJh2LelfOa88K7XN0zMifvvTsYT+Fp14AgGYI7m
 Mvlb7o0YuzXMoWb9H1C4Pj+GN4apJxwC0Qi8WcrQD/03DZ3rMcLFjPkA/t6p7HWzL4LT
 W+oLRmlHj6kVBT8TtXHIveEBTXxrL4qOvuRAN2iwbJBq1Yelwnql34MhlfXCs/OTx9Kp
 lrzA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786819494; x=1787424294;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dKnBM2CenBhATeov4YapUkEFMkETGra//v8DWWdQOhQ=;
 b=K1Pqa7O/pLmpp84xzJ7h93VyjUVKjNh4T4GTO2KCNEQcBQpnzqpB8jfBD8BFPH/wqu
 5aisW8hQwLT7/9c2w4GtHC5j/KeUQTSBHvql8b+tHasjNU/UiMhGa7sWzzGlNEmfZiCG
 D7M2cMsLXg8O2Qc8yEHX6FAOqZg4ndafjFqMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786819494; x=1787424294;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dKnBM2CenBhATeov4YapUkEFMkETGra//v8DWWdQOhQ=;
 b=cpmUVzptXFt7HRQggLTKP12P/UgAGMVmscUrHUED/4ih8dT/B47j7xPN/FaKrhXKlt
 uhEU5ei/S9UrEcTVzYw6X5VwTvkYuYxMF7am4Hlu60ZLoXvBiH8K0C+nPm1ZLgcwVW0d
 C5fDrlNwlpQhrCuj1zb2NKUc41mMpHychF9CAu3OUryGDVC1upIIvcTwOMuQyJpbiQGw
 fXhZtXEqWWASyRkJ7tJKeRDgNS6yJx53XUyE/Wi2/sy8K6F+HOWQTJ2V33dEm89JquOO
 su3ecxYkSTSlbTueacEuYH1nvgRDT4BP6XGCb7DimXPyKRtrvq1huRM6qbYC1flWO6BR
 ml8Q==
X-Gm-Message-State: AOJu0YzSANj6OjaRNM5pnXPeMahsNsqU25W+/6oKq/8q21+EefFZM7JU
 3+5VupnwzkJShAtH8KOig2Mt/eIc65wjzB5VJdApByjvYN2LEc1rpx+sZ/FnSiqMN839bk9yl6n
 a6DMjXsIObCx26KRVnpAlfLcKci+R8IErDc+8XK2u
X-Gm-Gg: AR+sD13tj38Djewf6hC9HpEo3TOKbHIAOIbCbKtgYtuSlAaRJXm4L9HN3DlByKs9nT6
 tRc7gxiAWcjsqbaY1u0Zu1LXcAZqaurXFzblk03fkKZ2zxktW2klxAoiq6wj7ws3SgohZp/DAhn
 nJJPyf40W2m9hrIexvbhWahDem4IQzbjuLxrdTIEPX9fnA8t+Yi+dC74Q35+qv2qD099aDWJ0uO
 Tx/goxUE8VTc+UTA7va5EaPq2yQnWLoMYK3iBAgEtGqO9352Q+DYKqUx9hBeAfh+qBdukUUYgty
 Z/7YOhpE/ZNbjCoshs2gZI4DOGo7OA+paqSTXxufbr0=
X-Received: by 2002:a05:6402:e03:b0:6a1:7751:64d6 with SMTP id
 4fb4d7f45d1cf-6a38aacf081mr6335127a12.21.1786819494089; Sat, 15 Aug 2026
 11:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <20260728-ccaione-upstream-ebbr-v2-4-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-4-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:44:41 -0600
X-Gm-Features: AcwNN1XJHm7wed7hijjaZTNSmNe7Vgwz5G06jss_2nD7dsz-Lfs5SDb7W-Fcje4
Message-ID: <CAFLszTgoWiMfMGPiwUpgjkjawy2ap5fqePR+igmzi4Qyh8WdVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
> efi_loader: bootmgr: install the firmware-owned devicetree
>
> SystemReady IR can boot through the UEFI boot manager without going
> through the per-device EFI bootmeth. Use the shared staging helper here
> as well so both EFI launch paths install the same firmware-owned
> devicetree.
>
> The precedence is an explicitly passed FDT, firmware-owned FDT, Boot####
> load-option FDT, then distro/ESP FDT. A configured source fails closed,
> and assembly failures are reported as EFI_DEVICE_ERROR.
>
> Route load-option errors through the common cleanup path while adding it.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> lib/efi_loader/efi_bootmgr.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1320,13 +1323,27 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +             if (!fdt) {
> +                     ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
> +                     int err;
> +
> +                     err = efi_stage_firmware_fdt(fdt_addr, &fdt_size, NULL);

fdt_size is efi_uintn_t (size_t) but efi_stage_firmware_fdt() takes
ulong * -- on builds where size_t and unsigned long are distinct this
will warn, and is arguably a strict-aliasing issue. Patch 3 declares a
separate ulong fw_fdt_size in bootmeth_efi.c for exactly this reason -
please do the same here rather than aliasing the distro-FDT size
variable. That also decouples the cleanup at 'out:', where the size
passed to efi_free_pages() only happens to be correct because
fdt_distro is NULL on the firmware-FDT path.

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1320,13 +1323,27 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +                     err = efi_stage_firmware_fdt(fdt_addr, &fdt_size, NULL);

Please pass a non-NULL namep so a failure to stage the firmware-owned
FDT can be logged with the FIT filename, matching what bootmeth_efi
does via bflow->fdt_fname

Regards,
Simon
