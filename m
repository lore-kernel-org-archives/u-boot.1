Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCA606A336
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=capWyjoL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KX8pbmvU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EC7B80C68;
	Tue, 17 Nov 2026 04:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrloG_0FaF2p; Tue, 17 Nov 2026 04:34:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C60680C70
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794890086;
	b=a/JEawxC7ZYtgVLubJfiupjzkADauWg0JJVcyDz1tFS+yJbIWcH7b6lgNWqKTQura/N/
	 UMw7dDdnLriWuF6ab0AeGDp5WQe1HsnrK3EldNvQ0io0A/oFGXCflTuXVq6eCFE93GN+C
	 AjcnPtWL8xlT6VbghkHjSoPryZnzh25U/Jvvgt4vmDaqjqk21fo9WlTxQWy808N+aAci8
	 jS0MY42bDmNz2NsCLDJ/PMWoEiz6ULJ5XYDylI1DD2ihrAu77pctEkxTPmEGRyjaCGNir
	 EN0ycb/AgFbWhW5+OmYx7N8Y47XSfGS5jvs1NCo402XJQ67RmYn9j0xWblrkM/yuRBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794890086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TfJWhBKLqtQaTV+U+oNrEqm/fWZauyQPEV2DgIt6c0s=;
	b=eaapAalTjuks4ZrQiZa48pQ6FQR9xYd4t8LvET89lrZCKhsBamij26WMTbDAhPeBAPdW
	 5FDiI/YfMliAZXoO4eXrkF9yNk7EnVCEMAXzbAHu6tTLesAClWjMClvxEVOx9QKGR6qRT
	 E0qUCUAEXOPapwD4cbsy5qYc0d82qsI3sqGyWvWyCkOcfBuvvUrVQUzKAM8wXZ7SmaEzH
	 NDnN4cbckw6g0D7FzAXdJaeEt+5GiDBOm3wrB7Mo1Baf38hVKoZSLgBBeFiF4oKArLP9g
	 X8J/dgzd3tOgKqMreCB7mQ/lBEsWHRBfdZe52x6bcAw3FlC6WDXyFFqnecs6Rj7N6Zg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KX8pbmvU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794890086;
	bh=TfJWhBKLqtQaTV+U+oNrEqm/fWZauyQPEV2DgIt6c0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=capWyjoLUcr7Tg1FoL8PvmYfKLB6KZqY3ohQzNG45NUCyub/j6CpU9uzu1hJtEEQ8
	 eQ9VYCZ4dBf+t1+KCnxz0tFeKGHpAuw4CZWN5w0UFyaeJLrniEAelU3CzpF0V9p9M+
	 y2uWQLGlpccOFZqSOEQbh32+psT9jSkqnPHTR+NM3attq/w+5dobiGCjgujHMIV9D3
	 NdLpK/E4zM7Pelo0HXirBvrZYATr+9faeMjPnqCS1+ILgcB+w6bbdZnWs/fC5r/mxk
	 /5AspsbEqKEesOBS5H4sLbG5SiwqBLpDxoRC6uzG/KdZcUjn+DLJBtXpytck+92xUN
	 A29aWD8+FnV7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C60680C70;
	Tue, 17 Nov 2026 04:34:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ACDD94DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C98881046
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8ZkFhtxZMkQ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35FE980B97
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=dilipchowdary21@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KX8pbmvU
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35FE980B97
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:00:36 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c50604721c8so634474866b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794862835; x=1795467635;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TfJWhBKLqtQaTV+U+oNrEqm/fWZauyQPEV2DgIt6c0s=;
 b=KX8pbmvU3jmVmpEV8JJCGiGMv+u3x+ifl8+4bEr1JmQcUZY+jkn/htPXxd5jPirA1Z
 SEXpCge6VWyrUDFY/yHnvqjNwHivZnPDDhQccY/xZZvl3/M8CeKUO+ue9q7AUTnRbgnB
 ySOI/puDRLDCI2zFW7KlQik4ODNvSyJRjeKmJsIshP3ZFbICMGwh8kUftDWLP3UOeVWy
 WnGEoBNO2MCHN5iC57c7feWfn4EfwxHpfIGArjvA7wsDQG4ycAYH9P5kxTyftSYjZVja
 Fm9uwoYjaCxN6dwUvsE6XSC4qFezNmSA+Nr/81SA6yrwjCdb+XBIS1IvSI0Nf3n4UOac
 e7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862835; x=1795467635;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TfJWhBKLqtQaTV+U+oNrEqm/fWZauyQPEV2DgIt6c0s=;
 b=S31tQNrV5B0YbWvYcpFDTDhIE1+J95s9EBX+TZgOMroTnLa6Uqza5eF49aRLxnakUy
 /JKyt6fh8Ac7OBkFmsRDdvAYfod2EScF2h7VaPqbGk2Dric84203U38+HEGjsCzwyXji
 1tNL4Z6rgg7745deMQWVNTEdMiJ0LPaj9MpcBWwwd/HZCnDbja3y3p4XkB0ROXypx+wG
 eWdIbY30cbVh8IsLRdloZ4s9M9aW/EIuOaB40ktt6L0fZZvQuJQgDFgoLT+EEfCB8RiD
 Yz2cXSjZhrNLH/kH6d/BlMeL3lfpSqWzTI8rSdVxUEeX4H+mG3JtOHAfGeU5leyjhnmx
 5/Kg==
X-Forwarded-Encrypted: i=1;
 AL+hErEL38wbqFrx7j3iRS8OSydcUiLvovqjjTDiAKK6jwWALeul/QSLZlq+k4cbcEfPbJsQ075aAIA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Ov4kpEBK4+WToVXbgukNVzNQ/7mIs0iuhXKu6JrKIK529RzPH
 nlnRN4BJqiQ1q/Fw3ynZVjdlS+LOVG08sKiz3J+A6H03HObrK4NCaP8bP1PYC9CWWKAHhmM4lwf
 BuUhV9YKd32dHmyWqDwA/qKvB2sDp9+A=
X-Gm-Gg: AYBFou0OcuBfAI9FUJIIxWyhAedbyebJblEy4gfcJWAtsYwuVPGrLtIwFP+3+f6pMtW
 fyvjKud4hksHgL8haNXh6CdxfGBMWZ0zVIpHwHHt1qEyw1e+zkmdyzyOrbnk27ZvNmCrbfreMvE
 KfK2eOfv5zXU4d01bXYN9lT4lh5SAFR7r9oIxpL4Hu10kh60eNpWmhRQiY2G6J2f9L4DRVvi+EU
 QWszm0zcOUCuDvfbSQvB88IU/oqmpU9vOUWm611dvgMVvw7TqhAqjKfrSxAhnSSSMmg26u9oCMg
 cTJM9zyc3l+EpHcy2A8udo0p2MuCFPiA5ZfDabove4bUAXiUhrnoRG2vAc9psTdBSkhl6GHlRc4
 7UKLoaRmn+W6hDCgkzPsDgh0GDXfMuwRPxgTqzwjp27VVjLxUfz/x9tv/MgTNm3I3c+A/grChnK
 gSSjtPQNU+y3Njphzy/qmyW6M=
X-Received: by 2002:a17:907:9605:b0:c4d:31c5:cda with SMTP id
 a640c23a62f3a-c50963afc72mr969167566b.21.1794862834932; Mon, 16 Nov 2026
 13:00:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
 <deff7930-1571-43fe-8f05-0c576e115c5f@suse.com>
 <20261116201914.GK554944@bill-the-cat>
In-Reply-To: <20261116201914.GK554944@bill-the-cat>
From: Dilip <dilipchowdary21@gmail.com>
Date: Mon, 16 Nov 2026 15:00:21 -0600
X-Gm-Features: AclHuK8oqX2NqTbt-KC7k4nt8w5Yy7ETtdC1dUlv90ZLSIufESitj6Msx6ejX3o
Message-ID: <CAPmzV5kihm867vB4Tt8uyL_ozJA-dHXRcGrpszLw4QzdaWUPBw@mail.gmail.com>
Subject: Re: Five memory-safety issues in U-Boot filesystem/partition parsing
 (coordinated disclosure)
To: Tom Rini <trini@konsulko.com>
Cc: Qu Wenruo <wqu@suse.com>, u-boot@lists.u-boot-project.org, 
 joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com, alchark@flipper.net, 
 kabel@kernel.org
Content-Type: multipart/alternative; boundary="000000000000b25e7b06606b11df"
X-Mailman-Approved-At: Tue, 17 Nov 2026 04:34:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b25e7b06606b11df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tom, Qu,

Short answer: there isn't a strncat_s()-style helper in mainline to borrow.
The kernel's bounded helper is strscpy() (copy-only, returns -E2BIG on
truncation), and the kernel has moved away from the strcat family entirely,
VFS never forward-concatenates paths, d_path() builds the path backward
from the end of the buffer.
 I don't think we need a new helper for the fix, though: U-Boot already
carries strlcat() in lib/string.c (BSD semantics, ~19 callers today). It
bounds the destination and returns the length it would have produced, so
the check is just:

 if (strlcat(path_ret, tmp, PATH_MAX) >=3D PATH_MAX) {
     ret =3D -ENAMETOOLONG;
     goto out;
 }

That gives the "bound both sides, reject on overflow" behavior Qu
described, and since a cyclic ref chain keeps growing the accumulated path,
it crosses PATH_MAX and gets rejected too, which also breaks the cycle. The
direct path_ret[name_len] writes are already bounded by the existing
name_len > BTRFS_NAME_LEN check.
 I've just posted the btrfs fix as a standalone patch ("fs/btrfs: fix path
buffer overflow in subvolume listing").

If you'd prefer a strscpy()-style API that returns -E2BIG rather than
relying on the strlcat return value, I'm happy to port strscpy() from the
kernel as a separate prerequisite patch, but I'd keep that independent of
the fix, since strlcat() already closes the hole with what's in tree.

Thanks,
Dilip

On Mon, Nov 16, 2026 at 2:19=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Tue, Nov 17, 2026 at 06:44:56AM +1030, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2026/11/16 17:24, Dilip =E5=86=99=E9=81=93:
> > > Hi U-Boot Team,
> > >
> > > Thanks for all the work you've put into hardening U-Boot's image
> > > parsing, the 2026 squashfs/disk crafted-image series was great to see=
,
> > > and it's what prompted me to take a closer look in the same spirit.
> > >
> > > I'd like to report five independent memory-safety issues, all in the
> > > same threat model as that series: U-Boot parsing an attacker-controll=
ed
> > > filesystem image or partition table from untrusted media (USB/SD/eMMC=
/
> > > partition, and for some, a netboot-fetched image). I found them by
> > > source review of master v2027.01-rc2 (commit ff8a9bc4), and each come=
s
> > > with a minimal, self-contained proof-of-concept.
> > >
> > > Reachability for all five is an everyday operation on attached media,
> > > `ls`, `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boot
> > > scanning,  with no signature verification anywhere in the path.
> > >
> > > Here's the short version of each:
> > >
> > > 1. squashfs: out-of-bounds free() in symlink path resolution (CWE-590=
)
> > >     fs/squashfs/sqfs.c : sqfs_clean_base_path()
> > >     A symlink whose target has more ".." components than its path dep=
th
> > > drives
> > >     free(base[i]) with i negative,  a wild free of heap pointers
> before the
> > >     base_tokens[] array. The `if (bc < 0)` guard only runs after the
> frees.
> > >     PoC: ASAN heap-buffer-overflow at free(base[-1]). Trigger: /s ->
> ../x
> > >
> > > 2. GPT:  integer overflow in partition-entry-array allocation (CWE-19=
0
> =E2=86=92
> > > 125)
> > >     disk/part_efi.c : alloc_read_gpt_entries() / part_print_efi()
> > >     count =3D num_partition_entries * sizeof_partition_entry is compu=
ted
> > > in 32-bit
> > >     and wraps (even on 64-bit), under-allocating the PTE buffer, whil=
e
> > >     part_print_efi() iterates the full unbounded num_partition_entrie=
s,
> > > heap OOB
> > >     read + partition-name info leak. PoC: ASAN, 512-byte buffer vs
> > > 33.5M-entry loop.
> > >
> > > 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)
> > >     disk/part_efi.c : validate_gpt_header()
> > >     efi_crc32(gpt_h, header_size) runs on a one-block buffer, but
> > > header_size is an
> > >     attacker-controlled le32 with no bound (Linux rejects header_size=
 >
> > > block_size),
> > >   a multi-GB OOB read before the CRC check. PoC: ASAN read past the
> 512-
> > > byte block.
> > >
> > > 4. cramfs:  heap overflow in symlink/data decompression (CWE-787)
> > >     fs/cramfs/uncompress.c : cramfs_uncompress_block() (+
> > > cramfs_uncompress_link)
> > >     avail_out is a fixed 8192, unrelated to the malloc(size+1)
> > > destination sized from
> > >     the inode's declared size; a crafted block inflating beyond `size=
`
> > > overflows the
> > >     heap buffer with attacker-controlled content. Present since 2003.
> > >     PoC: guard-page SIGSEGV at the allocation boundary. Trigger:
> > > cramfsls over a
> > >     directory with a symlink.
> > >
> > > 5. btrfs:  heap overflow in subvolume path resolution (CWE-787 / 120)
> > >     fs/btrfs/subvolume.c : get_path_in_subvol() / list_one_subvol()
> > >     strncat(path_ret, tmp, PATH_MAX) accumulates the path across the
> on-
> > > disk ref
> > >     chain with no total-length bound (strncat's size arg bounds the
> > > source, not the
> > >     dest)
> >
> > That's the biggest problem here, unlike kernel which has VFS layer
> handling
> > such overly long path, here we don't have anything that limits both the
> > source and destination length.
> >
> > What we need is strncat_s(), but it's not provided in the current code
> base,
> > so you may need to create a dedicated helper.
>
> Is there some helper function currently in the kernel we can borrow?
>
> --
> Tom
>

--000000000000b25e7b06606b11df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Tom, Qu,<br><br>Short answer: there isn&#39;t a strncat=
_s()-style helper in mainline to borrow. The kernel&#39;s bounded helper is=
 strscpy() (copy-only, returns -E2BIG on truncation), and the kernel has mo=
ved away from the strcat family entirely, VFS never forward-concatenates pa=
ths, d_path() builds the path backward from the end of the buffer.<br>=C2=
=A0I don&#39;t think we need a new helper for the fix, though: U-Boot alrea=
dy carries strlcat() in lib/string.c (BSD semantics, ~19 callers today). It=
 bounds the destination and returns the length it would have produced, so t=
he check is just:<div><br></div><div>=C2=A0if (strlcat(path_ret, tmp, PATH_=
MAX) &gt;=3D PATH_MAX) {<br>=C2=A0 =C2=A0 =C2=A0ret =3D -ENAMETOOLONG;<br>=
=C2=A0 =C2=A0 =C2=A0goto out;<br>=C2=A0}<br><br>That gives the &quot;bound =
both sides, reject on overflow&quot; behavior Qu described, and since a cyc=
lic ref chain keeps growing the accumulated path, it crosses PATH_MAX and g=
ets rejected too, which also breaks the cycle. The direct path_ret[name_len=
] writes are already bounded by the existing name_len &gt; BTRFS_NAME_LEN c=
heck.<br>=C2=A0I&#39;ve just posted the btrfs fix as a standalone patch (&q=
uot;fs/btrfs: fix path buffer overflow in subvolume listing&quot;).<br><br>=
If you&#39;d prefer a strscpy()-style API that returns -E2BIG rather than r=
elying on the strlcat return value, I&#39;m happy to port strscpy() from th=
e kernel as a separate prerequisite patch, but I&#39;d keep that independen=
t of the fix, since strlcat() already closes the hole with what&#39;s in tr=
ee.<br><br>Thanks,</div><div><span style=3D"background-color:transparent">D=
ilip</span></div></div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 16, 2026 at 2:19=E2=80=
=AFPM Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@konsulko.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Tue, Nov 17, 2026 at 06:44:56AM +1030, Qu Wenruo wrote:<br>
&gt; <br>
&gt; <br>
&gt; =E5=9C=A8 2026/11/16 17:24, Dilip =E5=86=99=E9=81=93:<br>
&gt; &gt; Hi U-Boot Team,<br>
&gt; &gt; <br>
&gt; &gt; Thanks for all the work you&#39;ve put into hardening U-Boot&#39;=
s image<br>
&gt; &gt; parsing, the 2026 squashfs/disk crafted-image series was great to=
 see,<br>
&gt; &gt; and it&#39;s what prompted me to take a closer look in the same s=
pirit.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;d like to report five independent memory-safety issues, all=
 in the<br>
&gt; &gt; same threat model as that series: U-Boot parsing an attacker-cont=
rolled<br>
&gt; &gt; filesystem image or partition table from untrusted media (USB/SD/=
eMMC/<br>
&gt; &gt; partition, and for some, a netboot-fetched image). I found them b=
y<br>
&gt; &gt; source review of master v2027.01-rc2 (commit ff8a9bc4), and each =
comes<br>
&gt; &gt; with a minimal, self-contained proof-of-concept.<br>
&gt; &gt; <br>
&gt; &gt; Reachability for all five is an everyday operation on attached me=
dia,<br>
&gt; &gt; `ls`, `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boo=
t<br>
&gt; &gt; scanning,=C2=A0 with no signature verification anywhere in the pa=
th.<br>
&gt; &gt; <br>
&gt; &gt; Here&#39;s the short version of each:<br>
&gt; &gt; <br>
&gt; &gt; 1. squashfs: out-of-bounds free() in symlink path resolution (CWE=
-590)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0fs/squashfs/sqfs.c : sqfs_clean_base_path()<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0A symlink whose target has more &quot;..&quot;=
 components than its path depth<br>
&gt; &gt; drives<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0free(base[i]) with i negative,=C2=A0 a wild fr=
ee of heap pointers before the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0base_tokens[] array. The `if (bc &lt; 0)` guar=
d only runs after the frees.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0PoC: ASAN heap-buffer-overflow at free(base[-1=
]). Trigger: /s -&gt; ../x<br>
&gt; &gt; <br>
&gt; &gt; 2. GPT:=C2=A0 integer overflow in partition-entry-array allocatio=
n (CWE-190 =E2=86=92<br>
&gt; &gt; 125)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0disk/part_efi.c : alloc_read_gpt_entries() / p=
art_print_efi()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0count =3D num_partition_entries * sizeof_parti=
tion_entry is computed<br>
&gt; &gt; in 32-bit<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0and wraps (even on 64-bit), under-allocating t=
he PTE buffer, while<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0part_print_efi() iterates the full unbounded n=
um_partition_entries,<br>
&gt; &gt; heap OOB<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0read + partition-name info leak. PoC: ASAN, 51=
2-byte buffer vs<br>
&gt; &gt; 33.5M-entry loop.<br>
&gt; &gt; <br>
&gt; &gt; 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0disk/part_efi.c : validate_gpt_header()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0efi_crc32(gpt_h, header_size) runs on a one-bl=
ock buffer, but<br>
&gt; &gt; header_size is an<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0attacker-controlled le32 with no bound (Linux =
rejects header_size &gt;<br>
&gt; &gt; block_size),<br>
&gt; &gt;=C2=A0 =C2=A0a multi-GB OOB read before the CRC check. PoC: ASAN r=
ead past the 512-<br>
&gt; &gt; byte block.<br>
&gt; &gt; <br>
&gt; &gt; 4. cramfs:=C2=A0 heap overflow in symlink/data decompression (CWE=
-787)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0fs/cramfs/uncompress.c : cramfs_uncompress_blo=
ck() (+<br>
&gt; &gt; cramfs_uncompress_link)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0avail_out is a fixed 8192, unrelated to the ma=
lloc(size+1)<br>
&gt; &gt; destination sized from<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0the inode&#39;s declared size; a crafted block=
 inflating beyond `size`<br>
&gt; &gt; overflows the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0heap buffer with attacker-controlled content. =
Present since 2003.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0PoC: guard-page SIGSEGV at the allocation boun=
dary. Trigger:<br>
&gt; &gt; cramfsls over a<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0directory with a symlink.<br>
&gt; &gt; <br>
&gt; &gt; 5. btrfs:=C2=A0 heap overflow in subvolume path resolution (CWE-7=
87 / 120)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0fs/btrfs/subvolume.c : get_path_in_subvol() / =
list_one_subvol()<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0strncat(path_ret, tmp, PATH_MAX) accumulates t=
he path across the on-<br>
&gt; &gt; disk ref<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0chain with no total-length bound (strncat&#39;=
s size arg bounds the<br>
&gt; &gt; source, not the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0dest)<br>
&gt; <br>
&gt; That&#39;s the biggest problem here, unlike kernel which has VFS layer=
 handling<br>
&gt; such overly long path, here we don&#39;t have anything that limits bot=
h the<br>
&gt; source and destination length.<br>
&gt; <br>
&gt; What we need is strncat_s(), but it&#39;s not provided in the current =
code base,<br>
&gt; so you may need to create a dedicated helper.<br>
<br>
Is there some helper function currently in the kernel we can borrow?<br>
<br>
-- <br>
Tom<br>
</blockquote></div>

--000000000000b25e7b06606b11df--
