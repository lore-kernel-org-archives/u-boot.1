Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E68CD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E3108063E;
	Fri, 12 Jun 2026 20:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CbD1cLBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F438056B; Fri, 12 Jun 2026 20:18:23 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8B88056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so1846862a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288300; cv=none;
 d=google.com; s=arc-20240605;
 b=I0MytwF1J3eoCQ220K4JrBC3/n9DxTW5MVhq6QCS+su+MABt5mOrx9TSz4nF4jez3w
 ui9a4LDW2Ybw3+gtUX+Q3+EQenGw5fVVwfxUWnrQOXEbzFm5uDOnFBVxTXmwzDKYcK0J
 FuMW9LkCjWalADMWBxHOqiG+VhsaX2E225d09woBjRWWxYQy/ZnMhWDQCv9gJVWJ8k2M
 oB7A4ToIUHY4IdNKzPjT87iGFvCpSR1Ch8UibHZahhjkTxdxwVVu4GP5IUwji9dC9V2t
 KmnpyLCITe13RQZY5ugKYI4QX6SKCcUgkFoqsvMAkxA+xfULRVsqZDPEQZOMKgNYi8IJ
 qMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M8/3Dko3rSmkFppwR6B8RE1cDZRtticM2ZOiB+z4zuI=;
 fh=VOyRK6/Ei9rDcbOkP9oYGTavTkmft/F0P0S/YTZY1lc=;
 b=LhstFnTW11RwadNGA0ewy7PWK62TIrVm1Xs95tmkD/hKyFIFngs+MpCi1J2j43mF6Z
 w5sIbPQ4B2DvtbQCkYG9IrZ6g6dlXEIUF4/C2w5M7cmowbJX2WZ0efrsbF+5E4SbvXj+
 htFRoRdjNptCTFUZTITcDTZ7B9xLvA5E2CAMonRWaONzRGFz7XJ6QAHNG7dymUvm8HRC
 GU66s68urIX3yDFBPRYcYd1fzjxEe5Zb+gW5wn7JcKpCPB+1yXQWaNKSMvesS9kfLVts
 4RmW2XrKNLfIRyCHetbYFrgkyKPg6XOlnGRNQZBAtMNhEB/5zuqQaNMrCZ6ezQWJgVQe
 tkSA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288300; x=1781893100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M8/3Dko3rSmkFppwR6B8RE1cDZRtticM2ZOiB+z4zuI=;
 b=CbD1cLBSRq/VfdG+hA69O6Cx8r97FKuWIQveMGYgMDpNNgWopo8jca0la64Wr1xiRg
 7++RVV+3GFgUWTsbrrVBayaaCZqLdqvl1x1x1OABp8Jpv2jWGFdR8Hgior/D7ypa0NVD
 WoY3OGK9/HJ/GzVky98jVMkVW3d1DnivVL2Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288300; x=1781893100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8/3Dko3rSmkFppwR6B8RE1cDZRtticM2ZOiB+z4zuI=;
 b=aFcY2yqE++zuN9hkPfOTa+SZyrkxnOstdAyYuMkDvjnOnaCYaFX667qF3fVt8qhEMw
 LCcMcjDz0vTX5ZkOEPgcWq2sYcyCqvFk7cW306GonZqckl3x4ByCRAupt5YTPpPkn89C
 LfY7A6C/as/hAmIV7Fu/ugH6gLNTU48APuGRl8/tAtNRO+EzCmDDj2FD1wbS6wL3AQMI
 rGVy13XSW3RXPE1d3glaqmHxSJvZ8cgSuMwMlYcwvFryUy88JeGJjT6A1RPwXhy8Jxe7
 B9cQ28eKQ0z/stjfSYn5Luw52hiHiW3/Xmn3po7Ovz3TyDq+N7KukvMhfZH51IQ6V33e
 TcCA==
X-Gm-Message-State: AOJu0YydP2MlnVwtzq3VhfqzIkM8kPeUWCLpdrlo37uNsYDdOy0ut4hL
 HA6NXGUtL0Npp4/Ot+S/vYTJMc3gt+pVf4m2n6U+YalNMB94C1EDhhod5YyesN241zNqCFiN1oP
 3v+MUcBPDKbnf1woud07P5zIjhNPrAOKmM6EzBe9o
X-Gm-Gg: Acq92OHGbj1lZqfEGKPD4IOp/73cupLu+vJ509pR9cmSEZCbFuLFK8MZHPhTj/kGaKb
 GDVIKUx49wlJocENB6DXoY0XkcR5sNBNiWxn07y+xjUjlXurwPTUJYqZesiltBzpYyczsvkGo30
 k6xOIoK2S/Htc/5faRX7y/uWhI02z/bT4655Aqz5Lk/KYOS57U85/SAQq1iS8QPFfTJfB0Mg0Rw
 YN/EbMGvFhVAYriWpWfSh2M2i9Bg8ABOuA7Tr/UOua8ZR3jpte/idL+/4SAj6d823NNqe1GChXP
 ScYkow==
X-Received: by 2002:a05:6402:e08:b0:691:b5aa:5a66 with SMTP id
 4fb4d7f45d1cf-69378a32937mr1848801a12.16.1781288300439; Fri, 12 Jun 2026
 11:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260601131311.1163914-2-vjardin@free.fr>
In-Reply-To: <20260601131311.1163914-2-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:18:08 -0600
X-Gm-Features: AVVi8CdRSmoT9Q9XzM4JNbDeq8qZcbCLo0MO0pQ0y501x48OIN82p9xVAeK_4ZM
Message-ID: <CAFLszTi=CH95prLLDkB_oWyZBowLfO6KFoPt4AueQdedBUYu4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: dispatch null_dev_desc_ok filesystems before
 lookup
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <simon.glass@canonical.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Tom Rini <trini@konsulko.com>
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

Hi Vincent,

On 2026-06-01T13:12:01, Vincent Jardin <vjardin@free.fr> wrote:
> fs: dispatch null_dev_desc_ok filesystems before lookup
>
> Filesystems that are null_dev_desc_ok (semihosting, ubifs) have
> no UCLASS_BLK device under their ifname, so on real hardware
> fs_set_blk_dev() always fails at the partition lookup.
> The workaround was to add a per-filesystem
> command (example cmd/ubifs.c), which duplicates the plumbing of
> fstype_info.
>
> Probe such entries with block_desc=NULL up front, so
>   load semihosting <addr> <file>
> works without a new command.
>
> Sandbox boards that exercise the existing fallback through "host
> bind" stay unchanged.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>
> fs/fs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

The example in the commit body needs the <dev[:part]> placeholder - it
should read 'load semihosting - <addr> <file>' to match the actual
command syntax.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
