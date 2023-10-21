Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8ECC004C0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 15:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5417D875B2;
	Sat, 21 Oct 2023 17:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RseAqgRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A813875CA; Sat, 21 Oct 2023 17:43:35 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61278759D
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 17:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso2732163a12.2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697903011; x=1698507811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JVPONAYICxyZC1PUPxgzw5YqiU0KrbCujp7xeCC9gYo=;
 b=RseAqgRNCmfJH3OxaLFiJ9qvdsHKZNq+SSXhIm9E9fEtsKMtk8yjNtJq8/Q4x2GI/Y
 D8DUwJ7N6OSJgjSBkZ2Rbmed3HTZ50issjwB5w7QJiH+GCgExx0acVrJ0xK65PsFHG3z
 OD6Zyxg/g+wIiea2s/ftA9Txi2zW+fYzqQtNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697903011; x=1698507811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVPONAYICxyZC1PUPxgzw5YqiU0KrbCujp7xeCC9gYo=;
 b=v3QQraWF6bswNqaCMrfz5Vnwg1z1+h3HjXHe7+nQxzx1EVVUqUo6cREY51ICO0KSQF
 lgIKUUneZGKd8E+1gaIguzG2iWFZUJC27qzBtYipQSkUnPcnTodrU8qgGphptnExLJ6m
 j3MriAO48uS3exggxtvMmHc+2yoZk8I8J71DGGX59kwfF3+hC5Az4vuiy+Z3sOw0ynJ4
 +KK0+RpbpFuSi1qXlSXyLMGivsrx6lf9vP60tYlF50tfLaNdsJFvA4UKbTajYN+CrSNO
 AM8E+sRa2HZYIWLZ6IrBgK9YN5cn7ZxgPTXUd2mPfmrwYSn1GAUYoH8Qylq5AbUlGLW+
 prAg==
X-Gm-Message-State: AOJu0Yxr6yoY4+tb3+lYHyRaAGmPHgsvNry2SJu6sDK3rn5nzhcoxa71
 cHaTLXFieWSu1SkENidEPZnGVQNxvXv4BnxSCxG6DA==
X-Google-Smtp-Source: AGHT+IEjqRfpSUErCmRYL135tbiftAJGfx6tQaUnEM8NVou+062Sz8Uw5zB1/FXpzoKeqEDLZB6KMTJKRPRxXn9LBLk=
X-Received: by 2002:a50:9b0a:0:b0:53e:7781:2279 with SMTP id
 o10-20020a509b0a000000b0053e77812279mr4025184edi.36.1697903011152; Sat, 21
 Oct 2023 08:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEfUkUJ31KTLc6mvGj741ZthSQdyXyS0r6cv2XUDycTq24yjRQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJ31KTLc6mvGj741ZthSQdyXyS0r6cv2XUDycTq24yjRQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Oct 2023 08:43:15 -0700
Message-ID: <CAPnjgZ3oCPLVjp1bwi16hYhY-TX5-7qDvy7xkWaYnHj9aZv3mw@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Raymond,

On Fri, 20 Oct 2023 at 15:15, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 21 Sept 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - No changes as it still seems unclear what should be done
> >
> [...]
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 080cc46a1266..e16d122f4fb1 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -103,6 +103,11 @@ enum bloblist_tag_t {
> >   BLOBLISTT_ACPI_TABLES = 0x104, /* ACPI tables for x86 */
> >   BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> >   BLOBLISTT_VBOOT_CTX = 0x106, /* Chromium OS verified boot context */
> > + /*
> > + * Devicetree for use by firmware. On some platforms this is passed to
> > + * the OS also
> > + */
> > + BLOBLISTT_CONTROL_FDT = 0x107,
> Shall we re-define all the `BLOBLISTT_` tags according to the firmware handoff
> spec v0.9?
> According to the latest discussion (in https://github.com/FirmwareHandoff/firmware_handoff/pull/19)
> It is preferred that generic ones to start from `0`, and Arm specific ones starts
> from `0x100`.
> In this case, the FDT should be re-defined as `1` and other existing non-arm
> ones (e.g. for x86 or Chromium OS) should have their placeholder before
> `0xff_f000`,
> while generic ones (e.g. for TPM) should be placed somewhere between `0`
> and `0x100`.
>
> [...]
>

Sure, if you like. I'm a little unclear when that stuff will land. We
can always update the tag numbering along with the format changes.

Regards,
Simon
