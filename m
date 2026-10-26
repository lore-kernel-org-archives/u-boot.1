Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MxUCMPN3;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GTAm/4Ks
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41BAD407D9;
	Mon, 26 Oct 2026 16:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySJZEFl2X-yU; Mon, 26 Oct 2026 16:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F4A4407D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033528;
	b=mSD/v6xYt64WXVJf87uac81QT1/y9hf8SUWQMXNJBhB4VVp/FAtGgqMXLTn1K/cxiLB5
	 y0tqpYgDA/Lk7XhhARg03Kt0GZiUuJ3/u5tQSOH+u68fgV0d4k7wb5lWR4jRlopp31v92
	 mxBYUECBCOV878e6XPpDJEC0Q0IuQvC8MTyM0aRL8J+7LaKFFKcVGxqCE4bCO2vs4JNyY
	 rmhISfCbI6kFNvkgAdDBuX0YrIILXucuL7YKRHk+CKAbiNFdus2+q5zchVVFF/IuOrD8r
	 pzFN/aoX0n5+ESA7GEHP25D3d0Sob/G5RPh9qXyNsnm+1pDqYXOAkmKCnPtXzjzk2zw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
	b=qYMD8MvJ8hdBH+fDgZFL+D/lXg8yy/IyjD2usxNS/5plz+KIGl1yo/fx6T48+lo6XENU
	 vV/NlJKrG2ApcfK+bHoaeuK69cvxYFCj2++T/MUPVmHuwjBPMqcbvFqLEYiMXY0sudgTC
	 Y7VFMr/jcvkKfJ/n0P8XqLckeeBjbzl3jgHEctXIH/rANAqGfxW7oqID/LynQB0+27IDo
	 NK3kgVEUn/1PWeEz9hquFaahBSqw2u4YEoKrsXZiLN+kYpypXJFr+ACvJjUynmBTWRP/p
	 74kZdw1m6NskkowN1X5Hcx1+LVH2NxECsfBBKp5rhNhJJ/AfYXY8nJXc06fw7IGZkTQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033528;
	bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MxUCMPN3rBi7uGlldxF0mGbUls7T9buPDX0nDUqd1fI3aWPaQVNi8kXt3ECre5Mfu
	 MnaBr7Q1m/7PegFZm/5/n8BX4LtURAmageSh5mj/yDEcLt8tM8RC+TmHVjs1qpx5T3
	 RZRHxCc8qVxhKHgrzdgEJx/euGYlxoLjD35caPMbm9mp+JK+X7wcyKKcQLeFpn6CTC
	 S7/t9chYGk8lPrPeXQAAN5WGOT9Tmev0okKWl6P9+b/3qj6lwnqrJbTYEWYrVQMlW1
	 RULKN5btVUylmbVjNK9+eG2mVHjhPX92FbWzET34WgwndW59Z3cvyNplPO/uK25k+X
	 W9RUXPTEQdbmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F4A4407D4;
	Mon, 26 Oct 2026 16:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2658D380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1821C4016B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYWnLuTYvvBI for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:52:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 25A1740062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033526;
 b=imi8Yw+o7Aik676mRrrVqW2ScSwr60ePru/StKcWe4sKgSqcxt7ILj/eDsHLnGAlOBho
 ZqrsPFQvp+7RyoVK0ULzQO1AWKTeBmR4Li5ErF0Rpc0PQ5+SR63S/hsyxlytv/1cv7S56
 fQMYLu36uNINLuoCX3vQqmHWj4pbW4nvOo/V2jXHxPRS5FFtWG4gMJkIcBxiojZWB57uH
 Tbe7NvYdBmDQRNk7PwaJRysTcDQWykDGcYTPnfy95S1PxhfM58jKIVy0k3Ek6ey/SB6kQ
 o67i1j7ZX4AKqO1bKqvZJJa7EBMrLBKUq2MjP34RPqtBvHlAcnKsqgNZzQsXDG/BEOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
 b=kd2rOBG7Z8fwah8fc2v1ySqZ03NMAkhKNRM/+wDL6y1tUjv/J0CoheOdBPH1vaNiGosI
 k0tj1pmEn5uw2OKfNiQ6gQpBMfmI2ZmcIQHA2GztDNIWz6MNDyT18FE2UYrCM44dIZnlK
 lbJ8bj0wEjfk/mfJdWNpvNFxS6gLWq2LtluckvdEi6UTcxc+rIbPNnfhT/GzVxWAtY722
 ffgos8VMiwFyqagRN0UNdAuiGqsi1v+evuC0vmC27if4Mng2XYVRpJHB0doZ8CT+qSKLI
 BsfjrLc9juvrirbF/waqIl6KpiRk/2C6jnY21ebX3BvGJsn7PfVEr5kQ7LksPGyEDxQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="GTAm/4Ks"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GTAm/4Ks
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25A1740062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:52:04 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so5104992a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033523; cv=none;
 d=google.com; s=arc-20260327;
 b=mKvaEdCSBFQQ9hwRJuF67ndx7zLXmce15n+5v3ql5VDrobtBPEYVpt8lWlFdhld2W7
 wjaq3ZqTSAlBrYKpY8f1T9bw7mhsTtCGDfhlwIkcrtpiahOzaWZPyuwJvRtkLDzLeUh7
 boQDPW2p5NTDhnajoXq48gi78Rnb2+LZK+60Mq4YJIX4lJSlVHoTIWseqU2Yx283jgx8
 XjBO0ilF/myxtXPVp4Z9RrtVahgzhvMTOonzj+5Qa1XEUvxTlkNxlQI5DzREDAkw73Cv
 WD9q3Xf1Ir6XTBQIem+RyVEGjIZ25YH0Ty0QQcHhvwOWlvISgflMtOaBKfTly2LGS+g1
 3fpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
 fh=Oq6rsPrLJfE7ei7W09wMA/D6SszTXZdLPHr1VsLRODc=;
 b=RMFopFwG6q5jTL2X6dKzxRKZog5jaDJAsaW3wcZHbuk+o0sf4ne1zxNyqlItHO7aFs
 pmLp+yJdMbOh3UKFasSH4HtFtgoaWfD3wwP13UYHBRG62fNDkKpwLJu/lhOC1S/PXkLN
 OVGQOuRRphjSLsJlysqobzS8YbU1YeI9iC/XKCqdw3RpRyObImuVrwzv15SEnQreQRM1
 oH+J7Zb6jBLNMgLGVNNBCvukPGSZYvU0nWeQk1OvxgrF1EH1IH9dUzmkzPnd4VubBD+w
 7XxgXUJGvhx39QStw7o+9b958JyoPWOjEGCeGgsac0lxkszWMA1YmfnjOxhOJmNZI7oz
 QZrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033522; x=1793638322;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
 b=GTAm/4KsbKjXMmgm42e2jkQICl7DJGWgxdg7mUrakf9KyRz4ugjyDSpHPW1V5W06uP
 vzDVIQfC8FR9Ae/6MuIrYRAA7BJM5U8PM5+1Kd7RULRhYjYCqYQF6QfngjEHBH+3axk1
 BzK+2tsKLQTIaLw+al6DliTFn4pt0atXQCjQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033522; x=1793638322;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jlJWDqerWiC3C+8369lwEx2XcH/zO1AwHK3DqMTYGFo=;
 b=h5wWTthJ5/GSVbpepTdPtym6zCL39lctXYfAMQswRgfLaun9K6OR3Fuuhj4VQ9o8uj
 Hd4DqtRH9ngwP9vIU8hF23IE8L3VHGEKKBUr8dPtiQybx50ufRUKfspEJz5JyWAl7DZ7
 M+w26/ZjgSQ/zjNli86bi2qpS9ofqO8KMUzqTZNGKeAKmSiQuz0mhtDemzlvv9iWlvc2
 lrQQACDY5hVraPEJIhJZBG7DnEWZTH3/R4KV3DUWSrqP6aju6P4IE2/kpn49WmjstEkt
 q16JrG0ilulbDGfJH9rm+gn2RKR7x161kQrsd2B3iar6hZ+Jwdjiv+8o4jITYOruacyw
 Fu2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgwzt87sGq7l0GVekKJXCxU42cARaCkKJQrcivISo6zVrFEPC0+S8Tydj8m8IgWR/K6pUi2B8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKozNI8yf7r3tpVYQAEOkPv/OyTIieo88nUiG786/hr6LoTIiCV
 aLlGimUkYFcUDohsRt3DSD8scFqd583tS4fODYQxGbg3arhfxp8BaNrgYALmnAW3WePFb4eKTsa
 mPC5G4WYnS4vAKh2iQXGqfxpfGaYyy9fnLMjtm3jZ
X-Gm-Gg: AYBFou3G3h+JEUm2/LxD4pRpT7iIVBvdjfxQWBdRBwQJezquvUMM5p6pk07ZpOCaBE5
 RUrvsEccZbEhjaFqkU/0Tuka6zVZ+WcwaNB+pAVPkBjZfUSoJZcfdaSsiSL2Y1QFsPUApgeeRMb
 GIAJES+K5U1wdwLairh5ocdrSyj8FrHULCy8QTJLWQYkIDQqKL3AvXR+Omtxdo4zvj963sHAfPr
 T9Tyxd1lPPkN12wi46xLL5rwTHZ88HmyWftMebHAKXXqPwTMVuU13wIKKiqI3rehukH3b2kYzq3
 AEVpWTTQzaWuWo1qZHU0TEwnV7yxKut92Qmk6IItJTXr/HUujdVvhLlHqTO6+2eVVgxn2o3qTVQ
 f+sndzvey+C7HAC8FMURaZsnDDfQgZwFuuSQ=
X-Received: by 2002:aa7:c9d4:0:b0:6b1:c355:c7c0 with SMTP id
 4fb4d7f45d1cf-6b442fde26emr5783976a12.26.1793033522544; Mon, 26 Oct 2026
 09:52:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:52:00 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 15:55:45 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <74259e58-8ddd-4343-83f3-b25d792d754c@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <74259e58-8ddd-4343-83f3-b25d792d754c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:52:00 -0700
X-Gm-Features: AclHuK_NA4RBHD74kxRXWJ9539wgL7sAOD9NqAj4w3MQkXLt6695Sc6E_Z6IYSQ
Message-ID: <CAFLszTjKiCzHaZ0a-uN_RkuEadQTJCcLtLcQiQZ1nRVa3JbD8g@mail.gmail.com>
Subject: Re: [PATCH RESEND 6/6] test: fs: ext4: add tests for corrupt on-disk
 indices
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
> test: fs: ext4: add tests for corrupt on-disk indices
>
> Add tests that make a small ext4 image with mkfs.ext4, corrupt one
> on-disk field and check that U-Boot rejects the image and is still
> responsive afterwards:
>
> - test_fs_ext_oob_extent_header: an extent header with more entries
>   than the inode can hold must give "invalid extent block"
> - test_fs_ext_oob_delete_block: replacing a file whose indirect block
>   lies past the end of the filesystem must fail with "Invalid block
>   number"
> - test_fs_ext_oob_group_layout: writing to a filesystem with
>   s_blocks_per_group of zero must be refused
> - test_fs_ext_oob_delete_inode: replacing a file whose directory entry
>   names an inode past the last block group must fail
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  scripts/pylint.base                   |   1 +
>  test/py/tests/test_fs/test_ext_oob.py | 147 ++++++++++++++++++++++++++++++++++
>  2 files changed, 148 insertions(+)

> diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
> @@ -0,0 +1,147 @@
> +Each test makes a small ext4 image with mkfs.ext4, corrupts one on-disk
> +field with debugfs and checks that U-Boot rejects the image and is still

Two of the tests patch the image with struct rather than debugfs, so
please can you adjust this.

> diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
> @@ -0,0 +1,147 @@
> +def victim_field(img, field):
> +    """Read back an inode field of /victim with debugfs"""
> +    out = check_output(['debugfs', '-R', 'stat victim', img],
> +                       stderr=open(os.devnull, 'w')).decode()
> +    return out if field in out else ''

This leaks the file handle, as does test_fs_ext_oob_delete_inode().
Please can you use stderr=DEVNULL from subprocess instead? Also, since
the callers only want a truth value, it would be clearer to return
'field in out' and call it something like victim_has() instead.

> diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
> @@ -0,0 +1,147 @@
> +    ubman.run_command('host bind 0 %s' % img)
> +    out = ubman.run_command('ext4load host 0:0 %x /victim' % ADDR)
> +    assert 'invalid extent block' in out
> +    assert 'alive' in ubman.run_command('echo alive')
> +    os.remove(img)

If an assert fails, the image stays in the persistent-data directory
and host 0 stays bound to it. This applies to all four tests. Please
can you use try/finally (or a small fixture) so the image is always
removed and the device unbound?

> diff --git a/scripts/pylint.base b/scripts/pylint.base
> @@ -50,6 +50,7 @@ test_tests_test_fs_fstest_helpers.py 4.29
>  test_tests_test_fs_test_basic.py 1.90
>  test_tests_test_fs_test_erofs.py 8.97
>  test_tests_test_fs_test_ext.py 1.48
> +test_tests_test_fs_test_ext_oob.py 8.00

It would be better for a new file to be close to 10 than to record a
low baseline. Nearly all the warnings I see are about % formatting
where an f-string would do, plus the two open(os.devnull) calls above,
so it should be easy to fix.

BTW nothing here covers the depth checks in patch 1. A test for those
would be good, perhaps as a follow-up.

Regards,
Simon
