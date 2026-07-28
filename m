Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A00EC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EF6940879;
	Tue, 28 Jul 2026 06:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0ZgwwZ9YSyr; Tue, 28 Jul 2026 06:10:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62E0E40868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785219018;
	bh=IU+iNim9676PleeJf/8Udf9kNRvhuzKj4SXgf8DwPwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njyluvI7s6q6UtQH9Kwkg6/W2hLad+MM1qR2bddyHRaeJC87dLR/T1o2KOPyU9aA+
	 39cn7kQHfH22Do06ndmRkWUUUTx7ADWHkO99yPWOj4uvifD22Qf4/JekE4uY3SCXiz
	 y7FU7yxdcBbYLZX1UGnVVxtCPYLer5TWQLCX4Hil2nognRqWHDiEUtqikO0KgQ/hX/
	 hK1riiaKHlj6Wb5LPD/PvRi47mQucXokYyKF/CT5H38Pcr/MFO+ORnvyJ0u43UDJ4N
	 dIKtVEaQRB+Zhy31MtEDzjMwsOkBOrbNINJNrd363rlxGIyOuOuoSIMnaeKgiLffGx
	 7iikBuPFixzRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E0E40868;
	Tue, 28 Jul 2026 06:10:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 222D526C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13D5B60812
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbxXXaX_2_TV for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:10:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 090CD6076C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 090CD6076C
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 090CD6076C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:10:15 +0000 (UTC)
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6681e7911b0so4796702d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785219014; cv=none;
 d=google.com; s=arc-20260327;
 b=ZkzKIvnfJWQOolMkTXPUvrx13DAMcf+rNIVTBtO89Zuya0NWlBnPhjS4/0Mmj6vDga
 r5uEgmoR3eskRbk265YhhDwbQhYhjCiw3U8SyHy/icYkyrRtd+vfl1FFc2mTCsgpdcam
 uGWaVayJesS/mrC8Qvn6y3YNkCs3qGdXFL/ekmmfG0yit2WtkDj8xYHJwkrKFzgvnVQ1
 CZiChcMi0UxkwsO2eGu2XLg3G3H66vQ1w9UPI30GXxjMxyQgilyETc9Mp4BuNg4gTy8Z
 Yx0x+u7AT63JHLwOzAd7xmtsYJvvAXC1rWKp+cD824Hn0KYgPQG/5xeJXMAY8fe+2W+f
 t9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IU+iNim9676PleeJf/8Udf9kNRvhuzKj4SXgf8DwPwI=;
 fh=7bv2MtHA9CDDlcYT25uoj8mcwXsBZIhZ+Z19o/MHMNE=;
 b=VdPzHabhxIFCkjV9Nn+iwqFtmg2wiRJ1LWlbrdv1BRuUkJA4GXpw/OE5/F/003vlYE
 uBjqXbw5BDgFhPYt8X0dKtG7enmJESc+cgm+3C6WmRivkAV5Ly1MWorsIcjsQbbZohph
 b31lFb31J/hKa9jHqAZEQJvur0aE/QSEMyk2er8uyRb+KQAreRltqlr1qOIoKhi2xcC+
 lGCQwWlwMJAiFvZlcNXR1PVu1DJaZNE+4oIIihk2H+5tcEYisD8qRvDFF7Xilcm3joDG
 qeCWMyYwx6lWtkfZ6b0RSzscesmEgBxyQOG43HwF99lF8Eohbqx68HVvJRtkiI+jLh2H
 vToA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785219014; x=1785823814;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IU+iNim9676PleeJf/8Udf9kNRvhuzKj4SXgf8DwPwI=;
 b=mMcMGmAtSxVWtSNDD1RcF7WcQ77aY7ONcJuv3JjXGPikmiItzzwjWptkVmqPafY16G
 mXvRzeIAUDUkx3d7Ctpeb6ecAcZ1+d/Sdlrnab+TWkolFmlmCppEDqFeg7TJtrTCSpLw
 3/U1hieoeymIGW+ltwar3q9764NJnB9zfs0f1AwnHsAzv69FICWTkXqsysOX5WvfZsi+
 +HHLSfX14bfiqoQoE2ndd98au0dlfPdAUJHQPLF/skIoyMbMaj32mHJXOmmnL4w56qa7
 Difz5tMdJOnbeNEMVsLoFxi493rF+kEQS/ghlgP8Va85+dup2FIJxIN6t8ySpPPo/55A
 tO5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTARSk4nISsDApt5rlDvazHINCz5Tsd3ehRLusaD+LE7fUgqi4HQoTtPSJEg0gTzI1q5yG3Fk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwTbbmVe4N+fL9o/FcAabaNG2fcSzr+TbvO2P0dfdMh0NtIGKaG
 30zi/E7eniLqn7Ajbcyldx8EQJbTrYxyX1CAstQ/HwWSQxs22u4REYvMjwOOp/Nl1TYr3/rirBO
 WuTcb5dtHt3FXryGUxczAFQU5Y1L1LPtTw3CE9NE0ps3e208KSgvr66+Vvw==
X-Gm-Gg: AR+sD11LfIJa/mw5FPZCQpmsNk8cxl4pv239Z30m+X3GU9afQ6S3JAoO5aSNgoAVhX3
 xS9GEdbVIQT8uyMMB6Cl064VSbyPX1uw70UXgsJ3q5dea+PYD09CGwYmyxtbHIyoVZTP0sN5Kbm
 kfSLHMk16S12rAQlT8YwbQ6A822XDAmRHC7Mk0tuU5Zxq+lSUiSgnC0LXIgUnfN5/HaWb1A1SO/
 uAOCB9oMt1Aeq+d2pVI0pCNWmIDy12rtQJeTXglSyJdXhRII7QwJCXGigm4Dq9UISTheXASglwX
 PvQ83mx864KwIOuw7v9gAUp2rIoFk11Vqn6hgGF6YMmLQNS9EoEjtmKdkD9AWCmCDQxraJu177o
 r9/VS1Bht9UPEwAcuVIj55knNlsqWMQPz93/Gx/s+4Z+tzgk3LTxMl1mlWveTeDOTKTo2izwZNZ
 PfLIR9w1h93IVu4zhflSKl2I/OLByxcyPzfu4e2gJnwYYQj2uuZWwpGnn/E8CcL0ioFVQ8QJebH
 dlxRNiKWhHQ5P3B7mC7J7Mu/8CpA93K1iZd3tqFUyz0lhDNhW4Zw088cAiFIK79gGbHoQs+tTud
 GXfs5hKoH1/PNC5SM0COrGzYtWc+V2k0wUlYxhTO7o6TOmlLBOuZP/GN4sIYXDr9/U+FQu8=
X-Received: by 2002:a05:690e:1586:10b0:668:7f26:df65 with SMTP id
 956f58d0204a3-6690582200emr262755d50.89.1785219014399; Mon, 27 Jul 2026
 23:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260727114507.225710-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260727114507.225710-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Jul 2026 09:09:37 +0300
X-Gm-Features: AUfX_mxrfMLXwOfSidh4kcUFndBHe0XP6Ar0OjbnkSYoc9Nt_usIntWSgJ1S_-8
Message-ID: <CAC_iWjKRcmLZyCCy2ruYWXWv4v0yQ51ea8gecHkmZ77fJ=65oQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: fix memory leak in
 efi_sigstore_parse_siglist
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785219014; x=1785823814;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IU+iNim9676PleeJf/8Udf9kNRvhuzKj4SXgf8DwPwI=;
 b=ZYNBQvN2ncC4tVav9UaTC7/5X1cK7DKqSv79gRrHotWFy/0Dtd6YrQLLi3ecl24cUJ
 Ylt8eV9b+vJVJjHOXOIUNMZSsa21hTfr1+ryiOzDo4SsvxpNwq0dkC6ytN+r4xUGqqH/
 rbDEzsxb4HPxgGOLeft1sXyJuJyrYER7pLUCIzDq89Mo5rPTIc03+ZS9Ir4iboflRiUG
 nHLntjGzfW1KfkCmFfpRZOjNFjGRYyK+g8uoQNuedPoj/zK25/kvfi2l4rrMGOnpMDBM
 GOj3eVrIDEtBeE4SvxlK5Ig5kirkusgF2+htDzRgvDsoLOi7H4g76jn7YhGJfiMv+WbG
 THNQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZYNBQvN2
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

On Mon, 27 Jul 2026 at 14:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In case of an error in efi_sigstore_parse_siglist() function
> efi_sigstore_free() is called. Currently it fails to free allocated data
> because siglist->sig_data_list is not set on the error path.
>
> Always update siglist->sig_data_list when a struct efi_sig_data is
> allocated.
>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Update siglist->sig_data_list inside loop.
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_signature.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
> index f99a0c29d2b..c2be5cb61b3 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -647,7 +647,7 @@ static struct efi_signature_store *
>  efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>  {
>         struct efi_signature_store *siglist = NULL;
> -       struct efi_sig_data *sig_data, *sig_data_next;
> +       struct efi_sig_data *sig_data;
>         struct efi_signature_data *esd;
>         size_t left;
>
> @@ -690,7 +690,6 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>         memcpy(&siglist->sig_type, &esl->signature_type, sizeof(efi_guid_t));
>
>         /* Go through the list */
> -       sig_data_next = NULL;
>         left = esl->signature_list_size
>                         - (sizeof(*esl) + esl->signature_header_size);
>         esd = (struct efi_signature_data *)
> @@ -709,6 +708,9 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>                         goto err;
>                 }
>
> +               sig_data->next = siglist->sig_data_list;
> +               siglist->sig_data_list = sig_data;
> +
>                 /* Append signature data */
>                 memcpy(&sig_data->owner, &esd->signature_owner,
>                        sizeof(efi_guid_t));
> @@ -721,15 +723,11 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
>                 }
>                 memcpy(sig_data->data, esd->signature_data, sig_data->size);
>
> -               sig_data->next = sig_data_next;
> -               sig_data_next = sig_data;
> -
>                 /* Next */
>                 esd = (struct efi_signature_data *)
>                                 ((u8 *)esd + esl->signature_size);
>                 left -= esl->signature_size;
>         }
> -       siglist->sig_data_list = sig_data_next;
>
>         return siglist;
>
> --
> 2.53.0
>
