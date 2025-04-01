Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C3C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0277880FDA;
	Tue,  1 Apr 2025 17:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eGB0gZ2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290348171B; Tue,  1 Apr 2025 17:52:40 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEC481E6C
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so9736050a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522756; x=1744127556; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39Fkpcf1/cUbIAIsPZ5wxWbVDufaH/A911W2c+RYgr4=;
 b=eGB0gZ2RP+k/w0b/odtyVpSr09pBrKy7BgJrXpfetqTSKN1hJQh4k3iIT8NXe0M/OG
 tBgKoCXfbFZuu+Pn3nFdyWoUtmFZeLMSUwq7Z+mtthyiiBJ2kSs6TByUxglH4X0J6lJ0
 Nv9x0JmpgIi9k3VlQo08cgUX8HeNOg4A1Ax+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522756; x=1744127556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39Fkpcf1/cUbIAIsPZ5wxWbVDufaH/A911W2c+RYgr4=;
 b=oqcKqatgqkrc60aTNLHTG3un+jSI2mobVxdVcbfy1BjYlDqd+hnD0XvgtecOjVwDI4
 k+ZmnFWT5NJrC/b365tEev1VexoJ25/3bowKdAMOymVVQvMR6F6V7O8MiVKJTn2QRCj/
 SfNxR++mVnVKHGgLQzooNNGlm627uWadcr64lUiEmCTtwspCAnOobtWALLPbXUz5LOYr
 0GvWhI93Xdig4SeEp/kZBn3G0gCRpyxp3+hJZk/N4FSJmiDchB1wnOVtxX/6JgwM/Mtq
 qPm+5ZXC9ARj0T5nEFT+hLsgCEYs4vO657P6ndUhoiM0NMcYNvOwEL0HTWdP/ML7DIg2
 aSWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLJ0pj8jylKQ42FKhfyy7Uqi869sNskhV6l3RBl7pHozhAgWi8saw+76fntAofLD9IVNA/LVA=@lists.denx.de
X-Gm-Message-State: AOJu0YxpEmo090UnjhVNKOgxCVq5DewJNh1U6g7tI3RspALvpjl+Ylqy
 rDAaWC7d+LdTFsj+NNuxYoEZqQ9fEL8WO0CaAjJ23MaZLTf4FfZ+qrkb+JDgPuTtgXo3GVj9U4e
 q5Bztfr5G0A8TNkqefR89KS+J8fJJWtGRupY9
X-Gm-Gg: ASbGncuHXQerB8SJ8CfIXdYIz4sRMfIGqxhtSVRO9e70qdfAdV6eznKNKSk7PvtovWS
 f58npJFzCCe7ZtAhUJPxkDfOg0xNlPSVeXjS4ixXSzfzhztlIeE0JCbOshyx9XTyCBNfSwWTqCo
 Lk58gwS3+2paMW9koqn1TvI8WmFVsNg4IhcceEd6k=
X-Google-Smtp-Source: AGHT+IG2BqxSUM6O/IsO74+b/Xlntev7juz4LrOev6Yc+nL83Zc2eJwHrBnQ69G0SGByEG0ASzvh4Bq20tSwNPPqxuk=
X-Received: by 2002:a17:90b:3a4b:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-305320ae1edmr22711634a91.17.1743522755882; Tue, 01 Apr 2025
 08:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:51:51 +1300
X-Gm-Features: AQ5f1Jq1Lz5Lbhkgpmmjf092UYu-1lAIOjMntPvuJ-ukwn192u3h8P4LryMubEQ
Message-ID: <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_U=2DBoot_interferes_with_initrd_binary_=E2=80=94_Revert_?=
 =?UTF-8?Q?=22efi=3A_Correct_smbios=2Dtable_installation=22_=3F?=
To: Michael Brown <mcb30@ipxe.org>
Cc: =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On Tue, 1 Apr 2025 at 23:22, Michael Brown <mcb30@ipxe.org> wrote:
>
> On 31/03/2025 18:31, Christian Kohlsch=C3=BCtter wrote:
> > Whoa! Good eyes, Michael!
> >
> > What is my Fritzbox doing to my initrd, and why does reverting the comm=
it fix it?
> >
> > FWIW, I also have a capture with an ethernet frame from another device =
on my network (ARP, ethertype 0x0806), so this is probably the content of s=
ome ethernet receive buffer...
>
> I've taken a quick look through the U-Boot codebase, and I can't
> immediately see where the Ethernet device gets disabled as a result of
> calling ExitBootServices().  It's possibly worth noting that U-Boot may
> have relied upon iPXE's behavior prior to commit
> https://github.com/ipxe/ipxe/commit/562c74e1e:
>
>    [efi] Run ExitBootServices shutdown hook at TPL_NOTIFY
>
>    ... <snip lengthy explanation as to why we need to do this> ...
>
>    Avoid calling into an underlying SNP protocol instance from within our
>    shutdown hook at TPL_NOTIFY, since the underlying SNP driver may
>    attempt to raise the TPL to TPL_CALLBACK (which would cause a fatal
>    error).  Failing to shut down the underlying SNP device is safe to do
>    since the underlying device must, in any case, have installed its own
>    ExitBootServices hook if any shutdown actions are required.
>
> So, older versions of iPXE would have called Snp->Stop(), which in
> U-Boot's efi_net_stop() will call eth_halt().  Current versions of iPXE
> will not call Snp->Stop(), and will rely on the underlying SNP driver to
> have dealt with its own ExitBootServices() requirements.
>
> I can't find any evidence of U-Boot installing an
> EVT_SIGNAL_EXIT_BOOT_SERVICES event to call eth_halt() when
> ExitBootServices() is called.
>
> The closest I can find is a block of code in U-Boot's
> efi_exit_boot_services():
>
>    bootm_disable_interrupts();
>    if (IS_ENABLED(CONFIG_USB_DEVICE))
>       udc_disconnect();
>    board_quiesce_devices();
>    dm_remove_devices_active();

We have discussed combining this code with the similar code in boot/bootm.c

>
> but I don't know precisely what these various functions are supposed to
> do, and I can't find any path that leads from any of these to eth_halt().
>
> Is it possible that U-Boot is failing to call eth_halt() in response to
> ExitBootServices(), and is therefore leaving the network device active
> and performing DMA while the kernel starts up?

The dm_remove_devices_active() is supposed to handle this, but it is
possible that one of the drivers lacks a remove() method.

Regards,
Simon
