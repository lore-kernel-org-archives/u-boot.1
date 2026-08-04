Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B04DC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECC2E80C5C;
	Tue,  4 Aug 2026 13:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3JqVQplDCBIt; Tue,  4 Aug 2026 13:05:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AD31805B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848749;
	bh=KwdgLlydSDDOzPDivOyexGr7m75HlDkow/iIIcHm3SE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PA0x9XUzmqfuGxUi8c3klbQNwuYatYWUjudqoBYgghBlJ1t4IF673nAofOWah1qvc
	 IGrbZywEuMA0uTq0M9xV+MO36u260H/3uMgWcHW9IOOzlNZA5LhZr3/ZYa05wt3L/C
	 onC949Wv1tPm3zyd/WFoKQa8TcdI+scpjZc/znEWqgtoIo4+BAlMqL6TuA3DpJ/XY6
	 chJpwDYhFMMcwhSTNHb/ZczgQ2mO2+5zxuMcFtoOOf6EAoQMITylxoebAahl5IVWKg
	 WIjWDoYlnFzLnY3KlCUW8tGzQMf7LQZ2dujZXIvQdPnj3yzW+4tvNcVMY26FqZToh8
	 /yXSW/wi3kNrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AD31805B2;
	Tue,  4 Aug 2026 13:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8623626C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77E6A405AD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XB5z2UVaq4Ub for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:05:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8FDE34053E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FDE34053E
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FDE34053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:46 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0cb6e96dcso4474954a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848744; cv=none;
 d=google.com; s=arc-20260327;
 b=Jayhf4YGuc3Q3mz3BCVoji2LGL7SZwljSYMvw1w8K8bexicZwCzQ7Uu3E1xH/kRZPF
 TyNQKqfEXJsACHczRUw91281wSLs66yOi0RWQG4ejbST/1yCXQbvwiPUmDqhOFR83f5d
 USj+tGFdh0QB1Sx8MnzpzU4sWpDHED1KijIPlulSeye0KR+aOCex7JCXQ4XItIba2KlW
 AGJ2vHwm2p2T5ricpIuAkzBmeF55tAq7JCalRhVMhWKRahECFh9j0Qc9i/TxAMPk0aEi
 7/RedzmWAXej1hx6L6HJd6dH4xxncceiD+3G66E2HzdPFs6DMAnBLSEu5HfiaK+uiZL8
 +oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KwdgLlydSDDOzPDivOyexGr7m75HlDkow/iIIcHm3SE=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=OWnO/GN2PuGdpFEtminGX3Tqp0DmgH4UwmI0Q1T/5X3ZDMPEW+25j3LVWP1il9SLmV
 srTfsgmc4PCpSXFYab+7TYKzEeCAjj8WRBPf0siOOz19QOHZHw2ixclN2+i0QD5MSECy
 7MNHYCP+oY/BywCuXvFeXQS4UydCjtJbVEvb0ZbtKAr+UsziT9skOhfuDWQKhMiZ/Dib
 RxdgCMcXTT+Te2YO6eRFyh2BwxsJq34VsIfdhx+DDfyxSHBTLT5CrCxEGDl/WaRuiK3Z
 nCoJ5OVm9gWYVdeGvXSgudKiBoOPswuhWOePHZW6G+LKfLdixik0d46OC3PF91z67AQ8
 nhcg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848744; x=1786453544;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KwdgLlydSDDOzPDivOyexGr7m75HlDkow/iIIcHm3SE=;
 b=rTbiBm4ym1GIB0X4MJ9fty6GM/zSFXNMCnbewjn+CB0uxaB2H8qz4PlQ7z2/PB1vEK
 tJ5jbKxBEdSFEx5CgjIf72cRDbJVm25HtRIUD+owWKugiu5LNuX45eBN8+yQ3DBJqjan
 X8uxbUVge6tJStM+sBcGIi9VArb9LUx9m1cF0FkqUI31oiuB37mDYYdsCPFjPX6p4pi4
 mYSS99+gFJrmangBEkz111T01+syrCNPmLAPTSO66GRvISoPBbSXHVE9fnsG1S62VC84
 goLdCmEDQLWdZlgBDrH3MLe83WAo7qDgOoFl2SMP/++CEA7FXDCmxG8FYXu1O5ExgZeO
 WiYQ==
X-Gm-Message-State: AOJu0YzdiIH6hfdYA7bFFqpdf3Vt4ZRWWAaBw0SDTkVaIwxhXJ8Qfk0p
 QFVsciohX+qVQfCyXEiJT81a66JPYs6EzArtFXcySBNcJJ4b5GIGzMuaYfpv9hoxIPZUffR6H8u
 q9twHgeaStAa/l0A2d4ys84Oj9QtOcY5WOt+cLYGY
X-Gm-Gg: AR+sD11dn220vdgTrtJ9+sXQs92zn08M96yRIC/MySK4QrGaNdT+Xp82JgM9CgUKL+q
 ARDSnARXvRZDCVBTXbHMNfFy541TK+4o37dRxtb+LgNcAlbhrJrYk3DxpBBdVyc3wEJuHOfAkEB
 yT/Fn7/XxUFLLKUP4+4Qv9wF0zGLSZCIK9cG2B3uBRUCWouXVAotQlhbPbOqDerdgoYx1iyR0KW
 CiZWyfITPf4f9qCw5gkOujnVnxVtRPKEeALXhsyqiacInD4m9iE1KE9Bt2tr1gBy+Ymo6qkDs1H
 IkRoeqbnJ3Ws4finutci8NhymEuDT29rer0kBiiQLao=
X-Received: by 2002:a05:6402:a6c6:10b0:6a1:1be7:c416 with SMTP id
 4fb4d7f45d1cf-6a11be7c4d6mr3433025a12.4.1785848744576; Tue, 04 Aug 2026
 06:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:30 -0600
X-Gm-Features: AUfX_mxYAoW0B6LuXkqNi875l77famZObmoBUqqzw_-K-M56xX5vtj7HllBhoUU
Message-ID: <CAFLszTi3gEBx331wH2bNLh+8rZ7vVip0BQ0rnQXUPyoyiF0CrQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] disk: part_efi: Size the partition entry array from
 the block size
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848744; x=1786453544;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KwdgLlydSDDOzPDivOyexGr7m75HlDkow/iIIcHm3SE=;
 b=MSK38pGJW9BEJD1ZHYn5PQFrBrcp3OSxL1cTN/92GF81trDZG9r+bVVLH8luWMySDg
 AtNw8kDUEIqTlcmMYrfphcTgPEftFQvwKsXHMYCU3aJ0u+wkLHW+LNmZDhfRJfnUagd+
 /gzufFjdD5uSKcuUYybtkxsg4OWsAsHDxfe8k=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MSK38pGJ
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

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> disk: part_efi: Size the partition entry array from the block size
>
> gpt_fill_header() computes last_usable_lba and first_usable_lba from
> hardcoded block counts that silently assumes 512-byte sectors and the
> default number of partition entries.
>
> The partition entry array holds GPT_ENTRY_NUMBERS entries of 128 bytes
> each, so the number of blocks it needs depends on both the entry count
> and the block size. write_gpt_table() derives that count correctly and
> writes the backup array at last_usable_lba + 1, so whenever the two
> disagree the backup array no longer immediately precedes the backup GPT
> header. Furthermore, on a device with 4096-byte native sectors, such as
> UFS flash, and the default 128 entries, the array is 4 blocks rather than
> 32. Current code reserves 34 blocks at each end of the disk for any block
> size and wastes about 114 KiB at each end.
>
> Add a new helper gpt_pte_blocks() and use it in all four places which
> currently calculate the number of blocks each in its own way, so the
> layout written by gpt_fill_header() and the extent written by
> write_gpt_table() cannot drift apart again. With this, first_usable_lba
> on 4096-byte sectors is 6, last_usable_lba is lba - 6, and the backup
> array occupies lba - 5 .. lba - 2, immediately preceding the backup
> header, as the UEFI specification describes.
>
> Note that this changes the 512-byte layout too for boards that do not use
> the default entry count. CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is
> "default 56 if ARCH_SUNXI" and is set to 64 by a number of Rockchip
> defconfigs:
>
>   entries  array blocks  first_usable_lba  last_usable_lba
>        56            14        34 -> 16    lba - 34 -> lba - 16
>        64            16        34 -> 18    lba - 34 -> lba - 18
>       128            32        34 -> 34    lba - 34 -> lba - 34
>
> Existing partition tables stay readable either way, since is_gpt_valid()
> locates the entry array from the on-disk partition_entry_lba. Only newly
> written tables change. Partitions given without an explicit start= will
> now be placed lower on those boards; on sunxi first_usable_lba lands on
> the 8 KiB SPL offset, so such boards should keep specifying start=
> explicitly.
>
> While here, report both LBAs when the requested layout does not fit, since
> the existing "Partitions layout exceeds disk size" debug message gives no
> clue as to by how much, making it less helpful in debugging.
>
> Co-developed-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> disk/part_efi.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
