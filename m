Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC85606A329
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jm8LUDBu;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OuVWIn06
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7ED3810D2;
	Thu, 26 Nov 2026 11:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ghJJBrzGaaI; Thu, 26 Nov 2026 11:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 867E781108
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795691155;
	b=CBeOuCMo711FdzPm+jVfkHTYRSeHlRejp18OI31RX6eNUq/29/yeJ+pGYSiApZIvLQHx
	 mxWNKsX3r36tJ5/7ZRo6bYarpBiBwW2sfhuij0o0bqAMgNa+yekH1gl2o2o3Yb6IgQWwj
	 GH3mj/8PLnn0faPIg8q3uEmC+bttW//TDD5RWKyP38eXnOSqEVaMv7NYori/0ceI9pUTA
	 D3QaOpY9TYpLjkkQNTAGRX17ZgXWoiSPyzi3nOLigJLoc/DSuD2hBkEessj0tj6X5cRaJ
	 qLjD9hzYPCcXKVdmvPdREBuv+6RmWlP2/rhiUInnVl0yJofL6DZd+djjwYYshFJhRmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=706vJqwRDTC+S3GdV/1zZT/60yLndkys/KF50969+08=;
	b=ZDiKjbuQ4oT4wko7/LxVctPtblR9BOl/ZCeIDq7rYs3e9+rMkHjIau+Qi+yra/oJtHti
	 Rk24nVcLp9B/eyrH3b7G5mXmY2mCz0NUA7/st6XpsaGEgQMwDVxSy+ua1fGGtz1upw4qI
	 DuenN6wwIcg9qkEgku50rG1j2VtNqej+Rv6RNQ9qivgRa9CinGDHvtBXfQV/5wW9KaX0E
	 TdfysSu4ZSErZrxs2CE9K7E5BPjuSFs2Sy15JDgs7mF3QwwS6jaXPEuC+1k8kvCUn7OLI
	 PMwbEHriuvmJhoe9TvYUTu3hqKaSYE+gHRXqf1pd1+88lnmKyKGChLZ7cn62itlgirg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795691155;
	bh=706vJqwRDTC+S3GdV/1zZT/60yLndkys/KF50969+08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jm8LUDBuiAN6tp/uJD4llLlb4gZ7FLxL4nZGaekzLQu8wDY9ev/wfph096OY6EaVY
	 vfQdHtb5B41u0sClrlpvxv9Y+/o451N9/kvqbCudCGvs0ZWA36mxHA0FQbUyGCoYFL
	 GZJ5HmPbq56uAeJtfeloCGyPJaMPlDmBsMUiegb7ke27zAbzELrnnTc23ZHYBKNMMW
	 gkXssBp2iIW7GFhRSCrx6gYj61QmaGyegyn2cJCv82SItbL1M0Elh75cTrJtBD/pvg
	 daDnZ/yl4cjeWyg3vAVYG+GfHL4u3eFzQIN12MYDh2UHiav9Mr1WWC4dOheSU2usqQ
	 Qbd7z7fC4VO8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 867E781108;
	Thu, 26 Nov 2026 11:05:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15DB543
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 078944080A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LsQ9-DUnJ-Si for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 11:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98A0440801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OuVWIn06
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98A0440801
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:05:51 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b4e2fcc300so60271907b3.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 03:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795691150; x=1796295950;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=706vJqwRDTC+S3GdV/1zZT/60yLndkys/KF50969+08=;
 b=OuVWIn06gPinx2LDG6HLud4xButvuYtoP6VnPM+ahdHclKtm9tuyXDBcCbqyOlEd9p
 WpmixWBNeZVxIhi7vYl0lvGMt3KuculKH+nuvMuSrusUiH3SSu5XjmqX9ID5rjeByWph
 N0zqw3zpaOhs5eiFbzZYvO14FkmtiOcCteKoVP0pMg69CaGnb32GwfOBQDZ/m4jTOagX
 ibjD7CNPEj0aKBrJ+CLbqUaXOHmFsifYYnex/whS+EckUw2HuFnWtEbRzYxSxgmmN9+8
 nmm7yb6ybgABSxt/pMLDAZSZbNItP5W3uDQy5+gbfHgZr125getuJSlo9iKM/I9rsEr1
 I03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795691150; x=1796295950;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=706vJqwRDTC+S3GdV/1zZT/60yLndkys/KF50969+08=;
 b=qhxr2fY5km4NubUa73lqcJF2iER0qXeEoEpaonHeFw0udJXQLpUQrNFfgNcT2b3mEg
 oQjJfSC7PzfmJCzEt9OBpr81LBec93pG/AS96LeQ5apQkx0YzAKwr6D4bEP0HenQVxn+
 rJ4VEefb3VDEizg/6AztRhaZEZ6gfzuwRPG67BpSfhdAhbMb6FupjQniK+5Ag7bZvUOw
 CRZeYkck5Bh6KpEPWalCj6vfQfXl2iVYic0hCtsecsYZkTXanyBZ6XHlgJzAiHtp7f9p
 72ZjTdCi/rheYsjTYwO6lF0FA5ifMgu2/HOz5onjJrDOEZLgIpPtHobN4ZLSiB/5HBMr
 VOeQ==
X-Gm-Message-State: APuU4Z8G4mTVgQqwaxmycY9ykyGGgjgiyl/78GpBKNPu59g3/vw+yQba
 L3iijKb8m0MqbG0nRj6Hvb3Ml35Um5TcHM1O4SK1zxnf0YxwAJ6YRw+tVRapbdYLzcLigk/O6DB
 /DUdBrkzrpfwj/whhBtgrJE6Rl5xflOCNVMsz+uYvnA==
X-Gm-Gg: AZFdTZdXdQiIuSSYadKisOG0YCAHEhsXm6NvjpgNbxN4+Pizv6mU3gvYxVJ2PlCxXXt
 sLqQTHT8niL8OG3K9C/ojtIKiQZi2z+a8ClkW9zpXeojNjMtnKgPOM4cIMOZc/wb3qaJRSluF3A
 +PuEGyic7W1mpN+F95JFMwXTRnKq4TyyOE+ygiNDPzlkETx/R0ZmFS96JBSkINkqu6+a7V4rhjb
 ggNtxAM/VLu0hLgg20u4K2nrcRh15gKQxQLUXnqEUw2+GXLNLbfBadrTHgf4FYirj11ZaGqZp48
 3AgzmxFeTfKUw6u9eMj7Rsjw0dZ7TBU8zbfl5W/KZoVpcQqfvhsCyjYvGGZRWLneTJYwMiBcgxI
 xA4lmhlYWpc9FUrWAvBDSq+iBHV3B9AE2WfGwJtJ9FRdP7h+WIgMcBpK/5ZLI5aXgg0Zwd5F1dg
 hl3oXcHaLF05dgih0PJ8Sb4ELF5lL+1/4gSr6N5KEh2xDKCxdyVWxDq9fyOZDO1HvP5+0RDvPCZ
 PtEJi3aumjYhkkbb5Ndk8BP6UR1Ia9bzsYQaV2XZ0S/5Ucspv6KRbce8rJHr3dHsHVWBJgzXNmZ
 GRaOH+7Qo9eyC4p07tzTeRFY5577Bjj9g131Q+64/8aBr/is6W5pnmWcD/KXnB6tZNTXF4gN34u
 cnr7y831YNxBdttkTbfGFBbeEK5ku/Ed/nnXCbawqatubyvfkpj9gVEs4jUy02+EIKaIyxp15XC
 U2smqd14PuSX/1On8RYp8Z1GmoIatPw9CcyeEqtxQxbrgcB7E8KwqmzjiA1UQqt/PcJLVVlE9Bd
 73B08BG67rhPZIpMBPI
X-Received: by 2002:a05:690c:734a:b0:8b3:2c71:b338 with SMTP id
 00721157ae682-8b5204ecc9cmr76398767b3.82.1795691150068; Thu, 26 Nov 2026
 03:05:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126-fix_tools_fwumdata-v3-1-e321d2a62390@foss.st.com>
In-Reply-To: <20261126-fix_tools_fwumdata-v3-1-e321d2a62390@foss.st.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 13:05:13 +0200
X-Gm-Features: Aa3M54qq25n3Uv8zTdZoTBZZwGmRX8o_dR4y6E8P0fKqbTBtkn4Qmj-DBPUgf0M
Message-ID: <CAC_iWjKcsJWy_jQkAA=HxcZyKtzQorGczktEE7P41OSjPd9azA@mail.gmail.com>
Subject: Re: [PATCH v3] tools: fwumdata: fix redundant metadata buffer overlap
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Patrice.

Tom can you pick this up directly? I am not mainiatining any FWU bits
but this has been assigned to me. I'll mark it as accepted once you do

Thanks
/Ilias

On Thu, 26 Nov 2026 at 11:58, Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> read_metadata() allocates a single buffer holding both metadata copies
> (calloc(2, mdata_size)) but accesses each copy through &mdata[id], where
> mdata is a "struct fwu_mdata *". That stride is sizeof(struct fwu_mdata),
> i.e. the 16-byte common header only, not mdata_size, so reading the
> second copy overwrites the body of the first and the two copies overlap.
>
> When both copies are identical the overlap is harmless, but as soon as
> they differ (e.g. after an interrupted update, the exact case the tool is
> meant to recover) the primary is corrupted: for V2 the metadata_size
> check then reads garbage and the tool aborts with a bogus size mismatch,
> for V1 it silently operates on a mixed view and can write it back to both
> copies.
>
> Index the copies by byte offset (mdata_size) through a small mdata_copy()
> helper instead of struct-typed pointer arithmetic. Both copies are
> guaranteed to share the same size (checked in parse_config()).
>
> Fixes: 02673659e813 ("tools: Add support for fwumdata tool")
>
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v3:
> - Add Fixes tag
> - Rename mdata_copy() to mdata_get_copy()
> - Link to v2: https://patch.msgid.link/20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com
>
> Changes in v2:
> - Rebase on v2027.01-rc2.
> - Remove Assisted-by: Claude:claude-opus-4.8.
> - Gather reviewed-by.
> - Link to v1: https://patch.msgid.link/20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com
>
> To: u-boot@lists.u-boot-project.org
> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Kory Maincent <kory.maincent@bootlin.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Way to reproduce/check the issue is fixed :
>
> cd /tmp
> cat > gen_mdata.py <<'PY'
> import struct, zlib
> def build(active, prev, bank_state, img_guid_byte):
>     version=2; num_banks=2; num_images=1
>     sz_mdata=16; sz_ext=16; sz_desc=8; sz_img_entry=32; sz_bank_info=24
>     per_image=sz_img_entry+sz_bank_info*num_banks
>     total=sz_mdata+sz_ext+sz_desc+per_image*num_images
>     ext=struct.pack('<IHH4BI', total, sz_mdata+sz_ext, 0, *bank_state, 0)
>     img_entry_size=sz_img_entry+sz_bank_info*num_banks
>     desc=struct.pack('<BBHHH', num_banks, 0, num_images, img_entry_size, sz_bank_info)
>     body=bytes([0x11]*16)+bytes([0x22]*16)
>     for b in range(num_banks):
>         body+=bytes([img_guid_byte+b]*16)+struct.pack('<II',1,0)
>     payload=struct.pack('<I',version)+struct.pack('<II',active,prev)+ext+desc+body
>     crc=zlib.crc32(payload)&0xffffffff
>     return struct.pack('<I',crc)+payload
> open('mdA.bin','wb').write(build(0,1,[0xFC,0xFE,0,0],0x30))  # active=0
> open('mdB.bin','wb').write(build(1,0,[0xFE,0xFF,0,0],0x50))  # active=1
> PY
> python3 gen_mdata.py; cp mdA.bin mdA2.bin
> printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdB.bin 0x0 0x78 0x78\n' > cfg_diff.config
> printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdA2.bin 0x0 0x78 0x78\n' > cfg_same.config
> printf '/tmp/mdA.bin 0x0 0x78 0x78\n' > cfg_single.config
>
> echo "===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) ====="
> /tmp/fwumdata_fixed -c cfg_diff.config 2>&1 | head -8; echo "rc=${PIPESTATUS[0]:-$?}"
> echo; echo "===== FIXED: identical redundant copies (regression check) ====="
> /tmp/fwumdata_fixed -c cfg_same.config 2>&1 | head -6; echo "rc=$?"
> echo; echo "===== FIXED: single copy (regression check) ====="
> /tmp/fwumdata_fixed -c cfg_single.config 2>&1 | head -6; echo "rc=$?"
> rm -f /tmp/gen_mdata.py /tmp/md*.bin /tmp/cfg_*.config /tmp/fwumdata_fixed
>
>     ===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) =====
>     Metadatas valid but not equal, use first one as default
>     FWU Metadata:
>             Version:            2
>             Active Index:       0
>             Previous Index:     1
>             CRC32:              0x38e2fed9
>             Metadata Size:      120 bytes
>             Descriptor Offset:  32
>     rc=0
>
>     ===== FIXED: identical redundant copies (regression check) =====
>     FWU Metadata:
>             Version:            2
>             Active Index:       0
>             Previous Index:     1
>             CRC32:              0x38e2fed9
>             Metadata Size:      120 bytes
>     rc=0
>
>     ===== FIXED: single copy (regression check) =====
>     FWU Metadata:
>             Version:            2
>             Active Index:       0
>             Previous Index:     1
>             CRC32:              0x38e2fed9
>             Metadata Size:      120 bytes
>     rc=0
> ---
>  tools/fwumdata_src/fwumdata.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/tools/fwumdata_src/fwumdata.c b/tools/fwumdata_src/fwumdata.c
> index 44195ce2bf2..08eff1bb1b7 100644
> --- a/tools/fwumdata_src/fwumdata.c
> +++ b/tools/fwumdata_src/fwumdata.c
> @@ -246,21 +246,35 @@ static void update_crc(struct fwu_mdata *mdata, size_t size)
>         mdata->crc32 = crc32(0, (const u8 *)&mdata->version, size - sizeof(u32));
>  }
>
> +/*
> + * Return a pointer to metadata copy @id inside the contiguous buffer.
> + * Copies are laid out mdata_size bytes apart, which is not the same as
> + * sizeof(struct fwu_mdata): the latter only covers the common header, so
> + * indexing mdata as an array of struct fwu_mdata would make the copies
> + * overlap. Both copies are guaranteed to share the same size (checked in
> + * parse_config()).
> + */
> +static struct fwu_mdata *mdata_get_copy(int id)
> +{
> +       return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
> +}
> +
>  static int read_one_metadata(int mdata_id, size_t size)
>  {
> +       struct fwu_mdata *md = mdata_get_copy(mdata_id);
>         int ret;
>
>         ret = open_device(&devices[mdata_id]);
>         if (ret)
>                 return ret;
>
> -       ret = read_device(&devices[mdata_id], &mdata[mdata_id], size);
> +       ret = read_device(&devices[mdata_id], md, size);
>         if (ret)
>                 return ret;
>
> -       if (mdata[mdata_id].version != 1 && mdata[mdata_id].version != 2) {
> +       if (md->version != 1 && md->version != 2) {
>                 fprintf(stderr, "Invalid metadata %d version: %u\n",
> -                       mdata_id, mdata[mdata_id].version);
> +                       mdata_id, md->version);
>         }
>
>         return 0;
> @@ -283,12 +297,12 @@ static int read_metadata(bool update)
>         if (ret)
>                 return ret;
>
> -       if (validate_crc(&mdata[0], alloc_size) < 0) {
> +       if (validate_crc(mdata_get_copy(0), alloc_size) < 0) {
>                 fprintf(stderr,
>                         "Warning: Primary metadata CRC validation failed\n");
>                 mdata_mod = update;
>         } else {
> -               valid_mdata = &mdata[0];
> +               valid_mdata = mdata_get_copy(0);
>         }
>
>         if (have_redundant) {
> @@ -296,16 +310,17 @@ static int read_metadata(bool update)
>                 if (ret)
>                         return ret;
>
> -               if (validate_crc(&mdata[1], alloc_size) < 0) {
> +               if (validate_crc(mdata_get_copy(1), alloc_size) < 0) {
>                         fprintf(stderr,
>                                 "Warning: Secondary metadata CRC validation failed\n");
>                         mdata_mod = update;
> -               } else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
> +               } else if (valid_mdata &&
> +                          mdata_get_copy(0)->crc32 != mdata_get_copy(1)->crc32) {
>                         fprintf(stderr,
>                                 "Metadatas valid but not equal, use first one as default\n");
>                         mdata_mod = update;
>                 } else {
> -                       valid_mdata = &mdata[1];
> +                       valid_mdata = mdata_get_copy(1);
>                 }
>         }
>
> @@ -313,7 +328,7 @@ static int read_metadata(bool update)
>                 fprintf(stderr,
>                         "No metadata valid, use first one as default\n");
>                 mdata_mod = update;
> -               valid_mdata = &mdata[0];
> +               valid_mdata = mdata_get_copy(0);
>         }
>
>         if (valid_mdata->version == 2) {
>
> ---
> base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
> change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e
>
> Best regards,
> --
> Patrice Chotard <patrice.chotard@foss.st.com>
>
