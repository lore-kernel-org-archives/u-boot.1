Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC188606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dXt75jSc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=n7mEw1aj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D10040A5C;
	Sat, 24 Oct 2026 06:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHRFOGUgOKl1; Sat, 24 Oct 2026 06:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA1D840AB3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823614;
	b=hwmgm2Qblz64hN2uiPBpLn5N/iU78wTdfHJQT3sdYApjKOl8pAnRqwIXN4n+1hOZufMM
	 cggli2vEO/TYWHTp3xfq7dqjs9O5QX+Zhnpj0H8/vA4AG+DvOJMSi4XfxE/pTwAIyU3Ry
	 tnF0bDIbd0OeIZLXUtYE308L3bugHAenvnFa2Czi0CyZ6n7XIwWq1iQ9iTDETkyU/skCF
	 LXP13tRZeEQHOC4Wkdy0iMGAFyySppx+rTFSozuMFlHkXL7licnWQhJpNPfxuX2YGo4Jm
	 6DAfoN4oueUVSzdrvsFyFRCoe1wzxZwtdlV9lSb90yLIPkutfZekYgJ2u+3bQEHgF2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
	b=mReh0XtRgQ7nAVRT9dWxTbmkQBPdrGafM2QMXtgo/Q/fBUZdyOW8N0OK/z2BZVbNRcEg
	 EtsvfT6LwhEDqASQdO7UkOGkgE1gJ9d2tnkdD5S3o0E0ELWdGMIWXvfH1v9oc0rmdukup
	 cGEZkrxNlb1hawGv/HIhLAodE+Qtyj7UYBu8ZX66P7tuxjyoSiaNa7v3xbxlVRKggbwxl
	 hXcHOII8eTG8zQXtvxDMnyQhvloKF/9rJNH1hNu24yKYIr8nsDzic1yC4eTomDt8y9qU3
	 lYib/dSxDsDYqfv66FwdyHWNXOb31xW2f1KUhnBAzE0vcyCmEOMvpnJG2H7BIrvPXfg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823614;
	bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXt75jScA0zGiu6dqWCmnQxSUixKEI5GDMRfoEIgWMZhFrNVKb1z1B5n8wFZsBUqH
	 Yko8FzhZFQntzZwuQQZzDDFWVGu+UsDFuY8xngnDE2etOl9Wi9uwW5jjCEkz8kt7Jq
	 BvO3PnGOQdQDHrewxsfz8mxkyWelH/XKyk3yw7ph2bYcWVJyQqwPPlij5TOR9Ss9gv
	 yafomEKcwBwep5Rmt3sTcf00zjqseB3sk1GVIitsBllT4bXSilkrYemBfxKh29UkBL
	 ctKUbsvyclopUhjaxIpSZjp9Yp5XZ65fetiMIWwTP0Ibb/1CVXWaQNq3VP4PDnmH0d
	 +m7L2zjh2QPjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA1D840AB3;
	Sat, 24 Oct 2026 06:33:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2463235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8176060680
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYg2QXSKZsrg for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7FF960A48
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823609;
 b=eroa3LexdpnYDUZIpPYyCE6GGYfVqZSzk2GXcaHMPan8vyZoxslqv1axfzeoZZYfzU9+
 NCaMhTH4R7meP3TMy2wzonpPfdYO5Zqzm11/1qvmqM9AlwyUygWw2OMR4eLQmFsOgCy4V
 UjuBajwTlnIZBB1KY5BiZ1nrIr/6jWqmyUXOB65soZt6qVRiFsMpIbknxDrSybFeg7PJY
 8xK8TYkiJ2drLhPQiINjlin64veOM5JbqGpJidD0zuYZ3fKV4u0OM4Bk2bBV3L8zsTdFu
 9b0Ij0aYianOzFmQ3QAkmmm/t1jas1y86KmdMLeiLU1K7INiGDd0fNEsEoujXsXbLXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823609;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
 b=hZMz1Hf73NBY1EronoZYYmamt9xXA1ficfgt9YP8K1rUhIeOSInj/DcpXWMQK2KwuRq4
 qXGIklMUdiUkFOL+41wGngF4zuij0M1i8JJTxmu7U7MpLOYHZP4PLImmYB/0tkzLOvta3
 ennkwPFU+3cR27kqDBRepUOtwSH3Q0VfjcLkUR3hnxM6c6aO0XpIjaHa0wDpeIMPKINEM
 r9M3YfPIwV09CWTdLNGDmq08Hc/KNoxBuU6iZg9KaMtFJIKbc3e6rauuQzDse9VcfV3C9
 7B3J5Fq1ZO7weKa4zj1MNQaWsx0CZrStPgGHApGg0GFF44hL9sfpgM7QJOZSy+3vVnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n7mEw1aj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n7mEw1aj
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7FF960A48
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:33:29 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ade49a7ebdso437648a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823609; cv=none;
 d=google.com; s=arc-20260327;
 b=ORinDm07JraOsYC7VFcDs8llGJaPunaa1xyI0XKtMtac1d8UY6nLe91LjeCZ0vHXhT
 vFQ5TQs3HkhCFl4Mp46I66RBPElCQd6yPTTu+Zk9ExLHUNyo3Rq28XlEaG/gk9GBn8iT
 qJgYPouXCNjn8G30mVAtYwoKDtHf2IK/8HwzgPJt29GvULQJvtegU+W2DO8uwqbjePP4
 ZtoI7JC2VfAhu5pn6aOvP5J4MiZEEYDULx6y4tK7GqJmBKi2iYSZFLq42q8NSn2qq1Rm
 WhJuOXIZWJ70IHU/e7i3FSO9H1gWjUoW+pWYZvJxilNutUyxHKxMPttT2opvR8qtP274
 l/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
 fh=uz5BTkXeDIRCEU/NBLkCw3wU4RiSilGwXsUPs/Mmf30=;
 b=gyLS9s5VtydLhJz88q6eIaRaKy2z9N60SZREjRfJIflzAODmfJy2UVHBzo8NDo40+P
 mkbDnBw+TYvrK3l94pvXYFTpyWn7eJoj34bxnD+sXohh1M/9Lg8FY587uH+c+0iClEVU
 RP5RT1sieb5l1bkjd9EBKQfNi1TmsH3F/VzPK68JhkVKIiMJc7fa86Lq4sOc5OKg+bR+
 NbHfKgKiJXhDLjJ+6E2Evx25B78vfGJ4LLNvVxOG6M3B7dLnJP2XmRCOX1Std3ZDeKGb
 SZM344OJPbDc16s/Z8Rykz2QF9D1AhS3OgIKTj0sYx34lnFWCR5dgufESC6xCzTxbZnE
 mOAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823609; x=1793428409;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
 b=n7mEw1ajwPKK67xrkQNoJ5M2mBgZgRtIRzWPYOefBmL0TKsQnpk+qWOdNcyn/4ecd7
 tGsB5jZMyZFYn6tnJktQfPiOuN2QNufCPvpyvSKpQU178nx7WdSqkXi8ati5PfvpzMHJ
 OTCtlnzQCvXzbVtQfm7aGh/M7+fmw08abdQVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823609; x=1793428409;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=acezz/FgXgjxKQqtQTwVphtednBoBq6NjPkUx8OJAcA=;
 b=A6BKhoEpQEMp1IJvomVSPPnh/213LQ7Fk3LD03zVYYKTr+nk3hLFqLVwW99wY0LCPz
 XxYBDQyoeAKKgBNeVFHeTODRCxEUxybm9nEyvJZjUJSwzyn6SGz8mfjQZm+AYyqXFmqp
 78bWWG0yzf59viKsgfptUuV6XPbqwiCy51u6npS0FXfJgnURzCSMf6T2hcJCPt/SD5Wj
 NsrNyMrCDU9NGiPplkGCqR5N8PRW+raMesc27GswMks5wvbZ+UgqtN7nI9hyF0Vjd15H
 UPOlkxgEryosn1M9ZUMj9RIwB38AUxrKauvDpozzRA4tCZNNc9HaPQ++hFWL/zpiGl14
 y4ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCuLnoxisEbDLxcMfmYbfBap0Sbzd19BrDpQbpe32Y0/P0Jafe9n8VAhZwdf8K4n2dImSkXok=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKw7XdSOx3Z5p4/9wj94yamAVjH07FgCBnZEouhTIIpbsice9Kr
 0oYGTxdUrOkmq2ubWymHOQ9bUBPQJYQNkzIyH1zP0bqPqCgJvTWuTvsnZxWh/bnNCGQYEvMFx47
 rtvInSI3cCIc9jk0xpdoxYN0h1TD2SrD6CM0zswz2
X-Gm-Gg: AYBFou30GXPZjsCN8sp1faMYOfNL3t0LeFROwTJDD8ZcyGvIXYOod4nN0InEY4cXEl0
 J9/0RKXnZ+7lg/1egoYEISf7x90JCOldM53WDZUvxmU/GTmPJCRx/G8ibE5ee+7bdodhs1ZS9t6
 uTgbbE55z+eOoWoUQrLFmKNR20s2SxOV98lOsA2mACzxe+497CKh0srwG3TsqXg6VCdmcVbwnc1
 M8MjM1DrsiAR8qMu/Y0WQMz12611+ozXPk8AU7+E6kaYUCB74DOgwHOo6FMl5FGAfZgT5hPDUAS
 NI97VHL8V66E7i5PXaxiNM+RoqJsvOFUtBT0xnq7rplEv6AtCD4MOjqJqZk84xEn/Wa1LK/Aphs
 WGpJjmCI5DwGF+7vm0KhBaP+Im9QLkQ0El0sLndvzBOmVcIYrpY3L6ZvO
X-Received: by 2002:a17:90b:2252:b0:3ac:80de:44e8 with SMTP id
 98e67ed59e1d1-3adeaea178fmr1305331a91.43.1792823608672; Fri, 23 Oct 2026
 23:33:28 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:33:26 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:59:18 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023090611.778581-4-yan.wang@softathome.com>
References: <20261023090611.778581-1-yan.wang@softathome.com>
 <20261023090611.778581-4-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:33:26 -0700
X-Gm-Features: AclHuK9XZwtnOJp8CAybc-y99mD9lKeSXUPDBIOI60T_RaFWP00DJKqaCEII5MA
Message-ID: <CAFLszThYLvoUzxdhBLyJgAjy4DnAFxsyMVgrmFp=7zhNP792og@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] binman: pre_load: Add HSM signing support to
 pre-load entry type
To: yan.wang@softathome.com
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yan,

On 2026-10-23T09:06:06, yan wang <yan.wang@softathome.com> wrote:
> binman: pre_load: Add HSM signing support to pre-load entry type
>
> Extend the pre-load entry type to support signing via hardware
> security modules (HSM) using PKCS#11. The implementation integrates
> with the pkcs11_tool btool to perform signing operations.

The commit message is the same as in v1. Please can you describe the
hsm-key property, the pre-load-hsm-library / pre-load-hsm-pin entry
arguments and PKCS11_SIGN_PIN, and give the reason for the change,
i.e. so the private key never has to leave the token? Your cover
letter already says this well.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -53,6 +82,37 @@ class Entry_pre_load(Entry_collection):
> +    This entry creates a pre-load header that contains a global image
> +    signature. The signature can be created using either a traditional RSA
> +    key file (key-name) or a Hardware Security Module (HSM) via PKCS#11
> +    (hsm-key), enabling production keys to remain on the HSM and never touch
> +    the build machine's filesystem.
> +
>
>      This entry creates a pre-load header that contains a global
>      image signature.

The old paragraph is still there, so the docs now say this twice, with
two blank lines in between. Please merge them. Also, a key file can be
ECDSA as well, so 'RSA' is not right here.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -87,6 +169,18 @@ class Entry_pre_load(Entry_collection):
> +        self.hsm_library = fdt_util.GetString(self._node, 'hsm-library')

The cover letter says the library is not stored in the devicetree, but
the DT can provide it in three ways: this hsm-library property, a
'pre-load-hsm-library' property (see below) and module-path= in the
URI. Please can you drop the hsm-library property? The entry argument
and module-path= cover it.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -94,6 +188,50 @@ class Entry_pre_load(Entry_collection):
> +        # PIN from entry arg or environment variable, NOT from the DT.
> +        pin_arg, = self.GetEntryArgsOrProps([EntryArg('pre-load-hsm-pin', str)])
> +        self.hsm_pin = pin_arg or os.environ.get('PKCS11_SIGN_PIN')

One thing I'd like to check here: GetEntryArgsOrProps() calls
GetArg(), which falls back to fdt_util.GetDatatype() on the node when
no -a argument is given. So 'pre-load-hsm-pin = '1234';' in the DT is
still used, despite the comment. Please can you use
state.GetEntryArg('pre-load-hsm-pin') directly so the DT is never read
for the PIN? A test that puts the PIN in the DT and checks it is
ignored would be good.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -94,6 +188,50 @@ class Entry_pre_load(Entry_collection):
> +            hash_name, sign_name = self.algo_name.split(',')
> +            if hash_name not in SHAS:
> +                self.Raise(f'{hash_name} is not supported')
> +            if sign_name not in RSAS and sign_name not in ECDSAS:
> +                self.Raise(f'{sign_name} is not supported')
> +            padding_name = self.padding_name or 'pkcs-1.5'
> +            if padding_name not in ('pss', 'pkcs-1.5'):
> +                self.Raise(f'Unsupported padding scheme: {padding_name}')

_SignHsmData() repeats these checks. Since ReadNode() always runs
first, please keep them here and work out the values once, e.g. in
instance variables.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -197,8 +335,90 @@ class Entry_pre_load(Entry_collection):
> +        When HSM signing is active the pkcs11-tool btool is called twice per
> +        _CreateHeader() invocation (once for the image signature and once for
> +        the header signature). Binman may call ProcessContents() several times
> +        as entries settle, so consider caching the slot and mechanism results
> +        in a real deployment against a rate-limited HSM.

Someone running binman can't act on this. Please either do the caching
or drop the paragraph (perhaps leave a short TODO instead).

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -197,8 +335,90 @@ class Entry_pre_load(Entry_collection):
> +            hash_sig = SHA256.new(img_sig)
> +
> +            version = self.version
> +            header_size = self.header_size
> +            image_size = len(self.image)
> +            ofs_img_sig = 64 + len(img_sig)
> +            flags = 0
> +            reserved0 = 0
> +            reserved1 = 0
> +
> +            first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
> +                                       version, header_size, image_size,
> +                                       ofs_img_sig, flags, reserved0,
> +                                       reserved1, hash_sig.digest())

This is the third copy of the header-building code, after
_CreateHeaderRsa() and _CreateHeaderEcdsa(). It would be worth a
preparatory patch with a helper that takes a signing function and
builds the header, so the HSM path only has to provide _SignHsmData().
What do you think?

>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
>  tools/binman/etype/pre_load.py | 222 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 221 insertions(+), 1 deletion(-)

Regards,
Simon
