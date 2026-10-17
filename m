Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F441CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 229F880D1C;
	Sat, 17 Oct 2026 10:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YoMbOwDUkUvi; Sat, 17 Oct 2026 10:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF73B80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233823;
	b=E8nUMloAX10pK2WinzRNYB0U3yAjIN8DlAJr86tqeDnzuIdAyNh0RqT2YOGzGX7P/8G+
	 o6JdJCh1o6wUeNgbcdKcT9FFpKjIiC3/rBx0htq3Pkpzdjq9pLrwgArJrvrBSnVdg20x5
	 LUB5TzKByr/o0G84s4D1naX38M7FKcxUzZRk17Dj+UG+W0L2paSv4PAV1eh8D+nwHL37y
	 x/r/PPNgmA8cj6IFhn/4I+62EPiVswJsyVRBfgZtMupqlmHs4FAcFbpZStmr97YUcVJ46
	 Zd7+7S9FCp4cclA5bG1RvytteGtB0vLlDsV1k/1HfxMkJOeKxWITAIMZEoLHb6qOi9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
	b=kj8Nv8wLVrngDfTHIURkkivbaY1qqWRtLo1xf2iNaXfqtUrqRjxJuRlrNPPyzu00Zwbf
	 Aanz9MtZC8OUs1TIV/HQgQTOLuI1E6QHTSy5juWfzRhoFGBnhGzm+1SK5m8KvoPk3Ymok
	 3lLwr6ZYdiGMk8phLyLEPrt7WmJcrY670UMrvHgDce8KKCDp5r05jb3K9pLSx8iqCVZWB
	 97U39Ek20DmTSyLssLPA43wGaHwBmoSnNi18JWmKR/OjhyPe00ZVTLeeKwa5tG7oLkTNo
	 8WzHVmBJy7Xq9VUcZ4kc5ZDH2zsXc8DpjtBYNPxNRceoqGmurhEVpz5r9RRJcCVT7gg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233823;
	bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWd/iq4zYA9N9GtMoC3HvCSlJWsdeJtTuVeCjSJ+NIc5UE5Z0LCO0/DMsva44XZbn
	 LwsP3NP5mtsBcu1vZT8nPWwaz/1nycXOaq0Tp+Tgq4awaOqoeYa6ZbFgnhsYa46lWA
	 sx5kV5Kbz7vvh67gxEZvLRHUYQp8KmXlWgduy6xQEjKiBklXPzNChuFtq+Fj1ehe1w
	 n75CbUpJl4V3Q5MqpzEhtHwfeQMFzEEFXLrZqscGD+y8tIzswVCRYIIrzTSo+he5p3
	 snV0vKDBaJJu1VoTwTiT0dMLJibOIKvRAydxaxKUXtDoDFi9aB+jE0neL/6VriB0lS
	 tDGcWpIEcZ4bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF73B80D6F;
	Sat, 17 Oct 2026 10:43:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8767D1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DAB9409CF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2TeGpqo9Ddb for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC8CE408EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233820;
 b=NK07R9cKU/z3KX/jGk1KNu+ic5X5TSEp/Ja2vV3zLcSUSeJ5DOhDlK9iz4N8l6N89m3C
 69FRPaYmR2N+ANjz+xXgpd2zhke9PKyoUOos1julTbMfDbiHqk7DNuO57/KfD6fks9tOK
 rKodXPfXgXgNRLOVdPsud15QNg8qklCWp7fdD751tvnzeONvvtSALN6FblKUc01LLlC6k
 DPKPN77SEVHRnSx2YCBSO6mPwsvoM9yzjC/6uVrkAm4e2u53So2UWEfyojbVu3aP9Chcb
 3rSI5xm/k/h3BLlaS+L39iy67Lxo8+48k58WpN7dqc4gc+/w3BwA9q6/7ktszQYywgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233820;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
 b=Fun2+nKkvWnhZ9TzFdtmVHPJ8R96xOnkVyQoV6+Nl+6zdfTCUlxq6/AQm8Bz0bkSXedR
 vN3Gqwr/XyYV8cIR/ZUKnwm+ppmVOkUVGkohS/i5GPWrXpW1PgxKwJBHMixV14aPOTHYB
 lYZE6I2neGyxQQcUtIdKqxK1i2z5c9o+I13ZOblMqGzxaNSZ6sMJj6xZS6v7hHiaWmJcN
 PYyNgdHNx9fBzpvCEHHtxA6JJ3fWgKlY9qZYkWzV9+K4vked0dohcH0tnOTG0ANZ8EyOV
 61zn+7MXXV1uSBkaQR37k9iDyh6qL1PYjhGqYldY48lQRiBuZaLupQOzleu/UsKhlDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dUwJ1qHT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dUwJ1qHT
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC8CE408EB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:40 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab3260b2cdso384558a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233820; cv=none;
 d=google.com; s=arc-20260327;
 b=VWLzDAuh00MpYitG5Pnfqi9vpxAp762lm8nuE6XX4kW82X1xBSyMHo6EcQUYZo02TK
 llw77MwvZYp+WHrKjKxpvWn7ut2J50uTG97VjDHJ7oAj2UiLdmm0rXBNjYnlWhxC1hR/
 9yMYILksOloNeokGUWlUHYoPuDVzxmk88NBc8kZ+15aZ+ILeQm90WbeyglHxj5SR1D9K
 avy9HDRGCE7hkJeJ8socOEUhPh9uGlI8xXrY+XjIWgB6X1R+WwcBYkNsCfXI7VRcq04a
 vXv041+NE3NXUPPG003vrW1Shmdu9GUPkIyz93OXiCnHONEtIxHIelsBZPL0IXGVQlFM
 fuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
 fh=rk8KlJTuFSKrve7wsBf2kRMMEhyIKJX17fwDKpOyK38=;
 b=pzERRnxtdVrUf1esOD02LL+epz5a3ZcIKbXeMA3VbLovKcZm1MVJbX8/3IiUqgHo4b
 FF+VUIQ7HNYSvq+C/VOaLCK6AzqETT7f4fWPT6/SpNeFZerChhK972LTRWzhnms4pqSh
 awS33SooZR1IHAXTpP86A3FjY0xNuC7btuXY79E4lV9xnhsuaiq/lnMJ7w6UnK2spasK
 ilh+Tlk1JbPXWqX70ktTy0KZUSzYkL1jsenpAk9OoVyWAtWgI5CMl5q1sAamY0d8jjAB
 RBNFxxZ48qDc4fQwzqpDS6tOj+EitChLZlpF02RbqcObAYr6h/1y8auodsFaL7WhLVnS
 7pkw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233820; x=1792838620;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
 b=dUwJ1qHT4H40+2gIVhvf90/mkli5ZqT8WlPsXMlrooJtMe+nwry9UgbOZ2RaT5CJ9S
 WL2U8hBjKGXqZUQ07B6jAgJ6We2OT4T2rZeZ+5Wr4UrhUYoBfw/6zpaYl0ydKQL5Zi73
 b15Muu20+58TLMy8feaV7h5e1C59U2uensp+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233820; x=1792838620;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FJ/oCFy1/Z2PE7OnEfO66uQ9MwwzjSUZZUZDeghR9Qw=;
 b=rt5K7qL8UCPYof3+lN2ehDJRs4cLk1p7KFd5zVj5ui+94H3YCA+ihiNeDvpK1eFCur
 S58vn9tQReeLpsmVelm7oFdy2mb8hjQ+DiDVasp8ecbVEdUI0bNrkkMOmOwA+dwoaKbu
 779wm+MXRSMDFhEHWp4LxG6Dq/8BbWW4xHsrefRNdtkmfOrMHJJGONTCQqleV4zpuafE
 5RDM5wG0SgxIHsuJq37cIOJ1r7dXuotGU0ZlrmFyGKtmZrrr5yom2PcOlJDTLO1bsn9y
 Xgf2WUiRsr/UvyoQL3WwHE9heFYhu1GpvHN2Z+CLTuIzFlOplyEdyUOGOL9IDAyd79TY
 sTsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKIoUE359Q4UnisLt4aZFW6s0f+44Fu4keg5fZiulbwePR/szvE7HujBw0KKV2Tpl9X0zqaVU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKWNnkel+Pyv5lvnCMEPgAfCmDkwk8afno+m1I8uc3KeLLrw3Im
 +rhQ6MlgZC77pUBoLUoYLaMbvnK2eAgr5zN1UCEAugeZ6GTpn+nsojQyhrS1593i/uR4a8kOJ06
 mLohtUa0ZTs4XEEkd1MfcFXTO+UiFU+KlLC4eOXzq
X-Gm-Gg: AYBFou2DeURMlOnLbaZDUfykVWD5Ve7feGAM3QoyUCIcLLVkmawoqOuR3Nhi/PJWCAP
 z3yFUsLvWYFtbeaglTvZ4euNqNkkkOZtbTw+4ec0QgNL9XWO5m+BBNncJukeYUqkVWvc9O2hi7s
 604EpfwoxlWD2wDZGiUXH1vY/ox+OxT0Iw5y3oJHBYVS0ZdyXjP/gA6jJ3EZx301iVBT2xwzacg
 fcOvbJ0/9wEPGkSAEG93UR7x3qGt1KKB5LxwToHvaLBL/v6AD46xqAkUkFN6FqlrZUV0IBIElIt
 pzMDvQLt1daUHdwg72D4O/6gM7HbIb/g2CERkMuneqBuLEJcSQA7yUXl43Dal3Xv
X-Received: by 2002:a17:90b:3b46:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3aceebc55e4mr1948683a91.18.1792233819845; Sat, 17 Oct 2026
 03:43:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 21:23:28 -0700
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-5-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <20261012104805.17297-5-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:34 -0700
X-Gm-Features: AclHuK8u54FAiNudKnO71-u5Peixcuc6yKFU7mneIKemD8mECLt0di__BhWLNEU
Message-ID: <CAFLszTh5UVkpuP5RHadFGqnKEY1yoY3W+cW1=rQcUB_hZm_SoQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] binman: test: Add SoftHSM functional test for
 pre-load HSM signing
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
> binman: test: Add SoftHSM functional test for pre-load HSM signing

This subject is almost the same as the one for patch 5, so the two are
hard to tell apart. Binman expects full test coverage for each
feature. Please can you fold this patch and patch 5 into patch 3, so
the HSM support arrives with its tests? If you keep them separate,
please add a short paragraph on what the test sets up: a SoftHSM
token, a key generated on the token, and a signature check with
preload_check_sign.

>
> Add testPreLoadHsmSign, a functional test that exercises end-to-end
> pre-load header signing using SoftHSM as a PKCS#11 token.
>
> Signed-off-by: Yan WANG <yan.wang@softathome.com>
>
> tools/binman/ftest.py                            | 64 ++++++++++++++++++++++
>  tools/binman/test/security/pre_load_hsm_sign.dts | 68 ++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +            # Generate key pair directly in SoftHSM
> +            pkcs11_tool.run_cmd('--module', '/usr/lib/softhsm/libsofthsm2.so',
> +                                '--keypairgen', '--key-type', 'rsa:2048',
> +                                '--label', 'uboot-key', '--login', '--pin', '1234')

The library path is hard-coded here and in pre_load_hsm_sign.dts. That
path is Debian/Ubuntu-specific. Fedora uses
/usr/lib64/pkcs11/libsofthsm2.so, and Arch uses
/usr/lib/softhsm/libsofthsm2.so via a different package. On those
hosts softhsm2-util and pkcs11-tool are present, so the test fails
rather than skipping, because sign() raises 'PKCS#11 module not
found'. testPkcs11SignedCapsuleGen already finds the library with
'p11-kit print-config'. Please can you do the same here and pass the
path into the image rather than putting it in the dts? For example,
hsm-library could come from an entry arg via GetEntryArgsOrProps(), as
pre-load-key-path does. That would also help real users, since the
library location is a host detail that doesn't belong in the board's
devicetree.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        # Place holder of public key file
> +        public_key = self._MakeInputFile("public.key", b"")
> +        pubkey_der = self._MakeInputFile("pubkey.der", b"")

There is no need to create empty files just to get a path:
os.path.join(self._indir, ...) or tools.get_output_filename() is
enough.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +            tools.run('openssl', 'rsa', '-pubin', '-inform', 'DER',
> +                      '-in', pubkey_der, '-out', public_key)

Please use the openssl bintool and call _CheckBintool() on it, as
testPkcs11SignedCapsuleGen does, so the test skips cleanly if openssl
is missing.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        # Create AES key for FIT encryption (required by pre_load_hsm_sign.dts)
> +        # Put it in a subdirectory to avoid polluting the main input directory
> +        data = tools.read_file(self.TestFile("fit/aes256.bin"))
> +        self._MakeInputFile("hsm_keys/aes256.bin", data)

Just to check, why use an encrypted FIT here? It looks copied from
testPreLoadEncryptedFit, but FIT encryption has nothing to do with HSM
signing. With a plain blob or u-boot entry as the content, you could
drop the AES key, the subdirectory and extra_indirs, and the test
would be easier to follow.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        image_fname = tools.get_output_filename('image.bin')
> +        is_signed = self._CheckPreload(image_fname, public_key)

This only covers pkcs-1.5. The HSM path has its own padding mapping,
and with PSS, pkcs11-tool chooses the salt length rather than binman.
Please can you also cover PSS, with padding-name = "pss" in the dts
and padding='pss' passed to _CheckPreload()? A second dts would do, or
a parameterised helper.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5931,6 +5931,70 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        self.assertEqual(is_signed, True)
> +
> +

This leaves two blank lines between methods. Please drop one.

Regards,
Simon
