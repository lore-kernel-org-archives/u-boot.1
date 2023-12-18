Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AC6C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 08:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618A087B92;
	Mon, 18 Dec 2023 09:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gnIC2N6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FBD87CF6; Mon, 18 Dec 2023 09:33:36 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B1B870B5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 09:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2360b9d6d2so25300866b.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 00:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702888413; x=1703493213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VZAth5gi8Ls1ORX9kZG0EWR4LfewdfvxHkja4Gx82Cc=;
 b=gnIC2N6yjNKpkt3hl3JmMa/fc9Ngsw34lz0k9A5TzqEvbL3qG1KDmSC30T+8Ts9/Yq
 4ppr1ug4M4nmoEqw9bQ36i+TjUYjefMiojzdIZFRtudrLb679DIt4reo5RqCbgzwAXds
 JkEVqV27V6bRk377fL43hvcs05whbqzNFiEeNpHp+I5n+BfYX9P755YRRZc2pErkTCHX
 leK+eI2iMTpRdRaYr8UIUj1MxqeR4H+vNrotROPqFR6vDMXGQapQ+UfavWjz5Dx0sfYp
 MsHTxcKDhoc3kUYC5adapi2VrHPYhHgYH4yq4ntHYkfvl4bsxUyeCooRxPvXJ6CreSVJ
 LUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702888413; x=1703493213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZAth5gi8Ls1ORX9kZG0EWR4LfewdfvxHkja4Gx82Cc=;
 b=Ch5HSUbgdxKSjy8YhqsZxhUX0UKlcyux5GFJxCLwGg5N9YzJ9KKjRFNrQeMTBLFkCy
 5SSQulOEbEQvRN/rL322muGFNC01rSoTx0kYIB74wqK96mYhO/+6DfZq4DwnGZJ8WLDX
 u+T7Yj3/BCKmHp+Nj9RuQwoLe6YPRAhRVQbXo9AANXW59OGzsiM7CbCSPv0sQtrWmVxl
 tMsAzioJau5F5Qfc0+8P2cyVdLtidQ/1zb66pxg4S3g4heYxc4GvifwRV3zjIO8115Mb
 r/bfM+Dz6TzkueEPouk1zIGz60BNKDS/UIVzCttUuN7yv3Cey3rmleHaGOBAaQBtG4ki
 qZSA==
X-Gm-Message-State: AOJu0Yy0xK0JCQrcOh5zrdxe4dLiFoyFId56wedEMgHF3IXkZqpHOWfd
 S1VC8nD4/D6Vwmhuk09tk8hlAqimiXRW+9rWTspfLA==
X-Google-Smtp-Source: AGHT+IG380JqcxzOJY/hdVWAnu0lHoyCmoD27p4I0CgBW8VUlG7NFzYnxU8dcej+jP6nTVtXim1i6qaCiKrqvvpp+5k=
X-Received: by 2002:a17:906:1c3:b0:a19:641:66da with SMTP id
 3-20020a17090601c300b00a19064166damr9423351ejj.7.1702888413192; Mon, 18 Dec
 2023 00:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20231213085737.299773-1-masahisa.kojima@linaro.org>
 <dcc6a681-2ede-49ba-ad0d-069933ad32ca@gmx.de>
 <CADQ0-X9cBm4uVyMXNVL++exgoHkgB3RGAH=cPjtPO5JKh+CgHA@mail.gmail.com>
 <DE130DBC-CB76-4F6C-966E-1B3FDC63C0B0@gmx.de>
 <CADQ0-X-PEOJqgA7emrHWBvFiEESfToLtmVk=57D_NrCskXdAWw@mail.gmail.com>
 <e1485c74-9481-4dd6-a405-672173afdd7a@gmx.de>
In-Reply-To: <e1485c74-9481-4dd6-a405-672173afdd7a@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 18 Dec 2023 17:33:22 +0900
Message-ID: <CADQ0-X-wo7GiRBdBqMYB92dejrsMMEC+epNX6Zy=Xj2fJy6RZw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: eliminate efi_disk_obj structure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>
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

Hi Heinrich,

On Sun, 17 Dec 2023 at 19:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/14/23 09:23, Masahisa Kojima wrote:
> >>>> Depending on the number of handles and pointers this will take a
> >>>> considerable time. A private field for the handle appended to struct
> >>>> efi_block_io would allow a fast lookup.
> >>>>
> >>>> EDK II does the same. See the definition of RAM_DISK_PRIVATE_FROM_BLKIO
> >>>> which uses macro BASE_CR() to find the private fields.
> >>> This patch tries to address this issue[0].
> >>>
> >>> If I understand correctly, two options are suggested here.
> >>> 1) a private field for the handle appended to struct efi_block_io
> >>> 2) keep the private struct something like current struct
> >>> efi_disk_obj, same as EDK II does
> >> Edk II uses 1) as I indicated above.
> > Probably I misunderstand your suggestion, let me clarify again.
> >
> > EDK II RamDisk implementation defines the private structure
> > RAM_DISK_PRIVATE_DATA[1].
> > RAM_DISK_PRIVATE_FROM_BLKIO macro returns the pointer to the
> > RAM_DISK_PRIVATE_DATA structure from the BLKIO protocol interface.
> > EFI_BLOCK_IO_PROTOCOL does not have a private field.
> >
> > It is the same as the current U-Boot implementation of efi_disk.c using
> > struct efi_disk_obj and following code.
> >    diskobj = container_of(this, struct efi_disk_obj, ops);
> >
> > Do you suggest modifying struct efi_block_io to add private fields?
>
> efi_block_io currently is what is defined in the UEFI specification.
>
> We could define a new structure that includes efi_block_io and
> additional private fields:
>
> struct efi_block_io_plus_private {
>         struct efi_block_io block_io;
>         efi_handle_t handle;
> }
>
> Or we can change the definition of efi_block_io by adding private fields:
>
> struct efi_block_io {
>          u64 revision;
>          struct efi_block_io_media *media;
> ...
>          efi_status_t (EFIAPI *flush_blocks)(struct efi_block_io *this);
>          # U-Boot private fields start here
>         efi_handle_t handle;
> };
>
> In either case we must not try to access the private fields if the
> structure is not allocated by us.
>
> The second option will require less code changes.
>
> I would try to avoid using container_of() for accessing private fields
> as it static code analysis and reading the code more difficult.

Thank you for the detailed explanation.

Avoiding container_of() means using cast instead?
Probably we define the following struct, cast the pointer of struct efi_block_io
to struct efi_block_io_plus_private pointer and check the signature before use.
struct efi_block_io_plus_private {
        struct efi_block_io block_io;
        u32 signature;
        efi_handle_t handle;
}

I still hesitate to modify struct efi_block_io.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> > [1]https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Disk/RamDiskDxe/RamDiskImpl.h#L95
> >
> > Thanks,
> > Masahisa Kojima
>
