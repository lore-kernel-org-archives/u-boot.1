Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B005FC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71FC3409FF;
	Tue, 28 Jul 2026 11:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id la0vh4IehPyd; Tue, 28 Jul 2026 11:40:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC292409AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238801;
	bh=ldipKhM+Z5eRsAu7HPZaAIc/vE9WlQgVRUp+/wfwS3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgcnqfWqypgxQA4K7v2WgPI9BG9NP+gGkXMzXm6eJm83e4SL+s/Dbg96dGSwzGLcx
	 0+Jme+sXvWky/UDl8QTql+wnOFteMLsnqb/Kjn4ZLbtebv2QW1LyfZETpAvNAdRoRd
	 2Iv2HeH2oZ65eo6OZb3RCfZu0+RM0LAJ/2IdQ8sJRIn31+2sDQRK3RHu/h7nZgqb/A
	 XrMXdhZBOZg2RuaeMJCMqbZ6qtLrlUq8+FX+37N1QME8bqRt7nY6xcJlQPB/O1uxD/
	 p0WTS1EUt5cwtZrxxAsqdbrB2OY+fNrV0HmcGxXz1X5CaPkJ5ExnVYCTo3xqs6F2uT
	 7w1pRRi8Dw5KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC292409AB;
	Tue, 28 Jul 2026 11:40:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA8A7350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7C39409AB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cao5drZoDSTB for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:39:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6E8924099C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E8924099C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E8924099C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:39:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95A68493F; Tue, 28 Jul 2026 13:39:56 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C975882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:39:54 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so2954675a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238794; cv=none;
 d=google.com; s=arc-20260327;
 b=AZluAVGF5kEuswTCcXtVJgEihEjlAtmnC8ZXV1dsRYmxRdo064AwHXC60odlUld8Ro
 tFkSZB0UhKbnepFQ8byYaFVW/NqHpNxO/ApWz+BlQBUtKhNC8foQn8qb1FV4GlQ6iMe2
 m2GcSeUCPW2SAzbe6GG4jJVBPBdivt8xOItCafbbaomrZOrL/MXqlVhIVMQOcoAwQztp
 Te/8cCP6YE9bhUWkLco4Cg4hsCN6++fgNMeUTBHxN6yqSlzYWQFppef7mBfrj9LjFgjZ
 Geqomh981IDQZN714v11B2qGgjZhrMdLRR1zMedJtK9LBN0J7wPfPs4FxWNIfvuG5Ipc
 oxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ldipKhM+Z5eRsAu7HPZaAIc/vE9WlQgVRUp+/wfwS3M=;
 fh=85skzak5ieIz/MEHSXQ/VBD92QvS8Ot3YiJMkNfZD/M=;
 b=fxPtpZ1OUQh3Hmh4/Ev01V5U3waAK/tv+8sdBqttmG4XVlglX3r83YypCdIt1AEdqD
 81Awpq2m6qybkNP2ZUK6ds7P9ZhQu7DZsewbySRV5Kz2CAu2GwJjlgFfnPh6Qqb0Z1Yg
 u2fjaSwhZyJ+su2KNb1ib77eJm/+LVqAlnricINUma5wCB7ufOpxBybIVF6MBj/r1lzh
 ZiGIi7IoEXAu67sfJn9MyBdWpRyVAgRiC0ob5Aq/yEKlMQeS2vNDMll79p7EEuUzSgR9
 xOi2J/DnaK0CHOTiWaSqaZE+IYBunBg5sMKhnbh9VuFlDdfrps6HwlIU9Lo900xuMB8U
 vplw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238794; x=1785843594;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ldipKhM+Z5eRsAu7HPZaAIc/vE9WlQgVRUp+/wfwS3M=;
 b=Dhg5WPv4LhR1SH34EIB1QTWQVXrj1n/Vuf7OGfGyORDtuPy/1ay9CkNDpj8n8GtvlY
 eFc1p1n9x/X0XAhyp687R4j9EcsVgM8p/ZOpnB1v3XBpw7alNNoq/lLagx2cQaWGqRTJ
 YZ1rNbYEspmo6r5XF9cHV+s9FzKbtWB7nfyzZ/REZb/1uVfM0QqcVweTzkS2my1HGz/G
 okYp1tZnU0rY1KFYxnNTgPY+9nWQfZ3YZB7dU8VbGf29y6C4L6tmmHwrL5u7BmfqBRIV
 SX9BczQkez6rbRRVAta0qpfUzSB6OuqjUIxqpobv/ehH5WcDLqFTTe8WBFAOHLxDrGYb
 mDug==
X-Gm-Message-State: AOJu0YzS9lxYR6n1LShp3EhDouNCJOW9svnkR4nl7Njg7mgOa07X2vvq
 s3HGCDcoM/Odxk+u9jkmOqvyN3hqfvF18uFXFtFGVSLgUvpNNEykvMrJ26f1sc9fe9V4iwVw8xI
 YG6fetqmGTT3IAKrjqsn32i6Kzd/W/qqxtHrnTH+U
X-Gm-Gg: AR+sD13ywTOZGd6cUTGzLUBPbMZMkz4aMU6hCwf+tUnfBmMAlgmZjBgYxgDjTy1IUHc
 WTE5I26Eqm0vgPm2mra4c43GHdXkZEtrUTU/6hofosOnp7qrmiiG2Q9oacFrRzUqEOyuafAlTA5
 p568tiTLvnloyqf+ZItuMZ4Zx0GKjv+QvgnUDGe8tU0nzOKKe73y3Mzy+JXExX7RW09S83ZcU4e
 FTvV991IQTVSk/hvPI5Wys/VSYqfYZXra8rWUBbxKiPtSvFwYJLYAEG5myP
X-Received: by 2002:a05:6402:5018:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a0349ec697mr1129274a12.16.1785238794227; Tue, 28 Jul 2026
 04:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260711091559.1842381-1-aristo.chen@canonical.com>
 <20260724092720.3533-1-aristo.chen@canonical.com>
 <20260724092720.3533-2-aristo.chen@canonical.com>
In-Reply-To: <20260724092720.3533-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:39:42 -0600
X-Gm-Features: AUfX_mwDljGDD_ZgE3s6dics_2GtTTGhGz-slFfJpRVCNbFHU98oNDaKNfqWSpY
Message-ID: <CAFLszTge=HbSCca1u0dUwjYEAurp-W=eHez15KT=mr+s9pQMFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi: Unify the memory map output of 'efi mem' and
 'efidebug memmap'
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238794; x=1785843594; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ldipKhM+Z5eRsAu7HPZaAIc/vE9WlQgVRUp+/wfwS3M=;
 b=FHS5pR+dfj73evFn12zhVNwve6VVfZA9pwk0BvC4J1X3+JPvwAuyQ+qAY6DQ74kjc/
 qEeRTVaCSs3fJAiH+FyZW4ArLJG4S0qVflaQSgakksARlE3Bzl1UXeSdMPFW0Rdzuf3y
 LnGd6ZcfonfJXJLNNGtu0Wa5DU63/GV4o87yg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FHS5pR+d
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="FHS5pR+d";
 dkim-atps=neutral
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

Hi Aristo,

On Fri, 24 Jul 2026 at 03:40, Aristo Chen <aristo.chen@canonical.com> wrote:
>
> The efi and efidebug commands each carried their own code for printing
> the EFI memory map, with separate tables of memory type and attribute
> names. The copies had drifted: efidebug knew EFI_PERSISTENT_MEMORY_TYPE
> while 'efi mem' printed it as '<invalid>', neither table knew
> EFI_UNACCEPTED_MEMORY_TYPE, and the 'efi mem' printer had misaligned
> column headers, a broken '<gap>' line and a superfluous Virtual column:
> the map is identity mapped before SetVirtualAddressMap() is called, so
> the field carries no information at the time the command can run.
>
> Move the printing loop of 'efidebug memmap' into efi_common.c as
> efi_show_memmap(), which is linked into both commands, and use it from
> both. The second copy in 'efi mem' is deleted together with
> efi_print_mem_table() and the private sorting and merging code,
> including the 'all' argument.
>
> The memory type names follow the UEFI specification with the leading
> 'Efi' and the trailing 'Type' stripped, for example ConventionalMemory
> for EfiConventionalMemory, and the missing name for unaccepted memory
> is added. The type column is widened to fit the longest name,
> MemoryMappedIOPortSpace.
>
> The shared function iterates the map with the descriptor size reported
> by the firmware instead of assuming sizeof(struct efi_mem_desc). This
> matters for 'efi mem' under EDK II based firmware, which reports a
> descriptor size of 0x30. The memory map key, which was printed
> uninitialized on the payload path, is now initialized. The command
> documentation is updated with output captured from the app running
> under OVMF, and documents why virtual addresses are not shown.
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
> Changes in v2:
> - Supersedes v1's table-only unification: the whole printer is now
>   shared, the type names follow the UEFI specification, the Virtual
>   column is dropped and the map is iterated with the firmware-reported
>   descriptor size
>
>  cmd/efi.c             | 221 +-----------------------------
>  cmd/efi_common.c      | 121 +++++++++++++++++
>  cmd/efidebug.c        |  96 +------------
>  doc/usage/cmd/efi.rst | 306 ++++++++++++++++++++----------------------
>  include/efi.h         |  18 +++
>  5 files changed, 292 insertions(+), 470 deletions(-)

I'm not seeing this one in patchwork - could you please check and send
a link if I am missing it?

Regards,
SImon
