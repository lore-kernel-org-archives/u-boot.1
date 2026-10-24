Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jab0iRCR;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IjAWgTEN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABAE060A7B;
	Sat, 24 Oct 2026 06:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJSJP9gM9Oes; Sat, 24 Oct 2026 06:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E36D260A48
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822998;
	b=OBrkwhjYAH+8gCXgsX1H3yD+By8LU4RmdWxOnjxRUd44FKDzZq+ohf2AU+RJjsHTXHT3
	 TpgkjiZbTyMNuRDIlHgZuA16CRrTX+CQku1yt4qpSWeUpDOV7qmRCVMFUAnZsTxvqaQjd
	 xGxFxVlzBJcr8XPFxkcEP80X3pT/jBhQtOkwB8FsHBEQb8CmrGCBLldK/w+MlkRXxOCWF
	 yqWS7kpt538tpjWVwtsF13UKxr06r0QcMEG4wUfa9sN2JSFO9GUBgUSLp+bRimYZNQr2c
	 zJ0tYUkCIMwVm6EPIuRFEzU2IQWzZb2hl9TG99Iek7U8k+2Gn55G0wMhmViJz4SfqQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
	b=bRgmyf5ASTIWNMX/EjGEDmRjL+S/9q50qCujqP9NGEJ6kGPOpjulxyP64DTN/6A5NBmF
	 9NLDH5VnyIbbaZuu1ITIz77FQcePWQsoQPobisBvfPHRpzmZkr++oGQQ7p1FIP7UyTJfj
	 GOsXW0mRwLdOig82TO27+RlDQz7oe7gazV0p4i7lIOjsBN5OdBIjqswIF4TAs8Li5JEUa
	 qHS4/FvN+u8vwcnmeN4xvPrJuRt1Ms60mKFQRcsebmt/Uo7YTm0bCCtE3m7p1ZoaONbSG
	 unz5aIYJAjxurtCjMVvW6Q+LY7eA8cI85ao3ORC7QbsLJURoqU4Lb9KRiHRA5kCTHVA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822998;
	bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jab0iRCR7Sao28EzyExF+BK4x0I86G0f6KByQbOIXYnbYm/gWsCagasIrqX9DdN09
	 tx3vf54CFyyZb2v7Gt4FFvbkAUJLCqJfVjLsLcPCAajPcAmK5LAb5mHP5scra+Xdxl
	 /IjKw+d+/0YFz6uN1TSmWu1DJPFNGUFznKvH8se5ThiIfGaedlkSHugbFeSR/Ub6oL
	 UAC9CMCynkTta6tuoeEuDYgXU8JRtsofjSU3Q8LIk+sJgJGWNxyb82O/Vg5utrnSMF
	 ptSj3In/432kYwDefEzhTdPwkdl5Q42AFBu2+YzmthnTa+6U9naBDsQ5uzd38sdpoJ
	 rOfJRhSW4W8xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E36D260A48;
	Sat, 24 Oct 2026 06:23:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D26D2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8311F40ACD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGx1Bp9XXe95 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:23:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF38840ADA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822995;
 b=bDVDy6bydooJ4sKtdA4QClU6EQMENiQfnL516IVorlz1NS9wpHhC9kL4FvOkja0fAY7K
 XZIOmq9P+7Z1LcsBparGv9wVgwBJI6d18a+aRzhFkWm+Kcb8uD6wYoUo2bBVur9SMb4Us
 iLd14Yem7ZCRWRYG7n9I/7CQtKolBLuXuZcgUCjgJoa7bvX/bjYGGHJWKZLl/4wEm6IL1
 rNGCnDI3TvQS9otn7xWIUpXG986uWm6bvH1u6civkXx1sqS+vPp7RXUpQ7ocyomZj8PuT
 eTUBb+4ZVk0Hiogk8pqjso1eM3sMFjO8froVbLBcDBhbxIZKDog8K5FrZTSrE7eR53g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822995;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
 b=KTvOxQ6eooP7wtHC+mjwiPxnpMDNMB4ojH6ManQKzrYPVciZt+D+k2d1YMuj+5ghdWfP
 szmC+Iv2Y3thynXZMDFMa367hLgfgTB/Ymzpqni9aETmME+MujZhlvqR8EBU1sJLVFnVb
 dIM63/LKclhrOQKer0NrPppp4JSNn5KtswPuh5nutN4EMgc/mxXsSZ6tFpB0dMv8iNS7u
 qtjo2D8H0EBSjnB0fbza1s3bjoNhllfTy/ILN4VwKNfWCQY7R8ZRsJxTl9KsNZe+j1a5x
 DmgYMIJ8cwKeHfPCKQjT/mJr7xyJ94KTV5XCU26sKj/RYE4MoDqsj185qky+o1GqGFQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IjAWgTEN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IjAWgTEN
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF38840ADA
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:15 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so1125999a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822995; cv=none;
 d=google.com; s=arc-20260327;
 b=RW0eL6MyY22aOYEJyUnih1WZhEIzXB85AgZ30UAlKCYqmHc7XHHn8lbbssUjCB7ol2
 pg6QzLuCIvoOAInGHiS5WWtbZi8H8WkGmlureBhie9DAef6vDWu6MVysfcHtGEzGMM/M
 RumLmAEcQqVA9kfPBw8D3p3SlBf3nIGXpRdeq/VbSEH82taUW8RRsi/VL88PI3wN2WKy
 5kNch9YGPdP7N192GAqyWhOv4pwazJmD2w9Cz7p8hqDn1gheVvL59JwMz8KxQrs22Cob
 6sJ1iRwP9UThH009JpXbGhmjUVsdVAjjTBjCJeBroQF3KTfneJOLJowdQnM431uQn47i
 e0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=AUWdl8qR/l+RLPlnaRSRSwukgFqftrR+J9qGCI2tGhcIQTd4pwqGlaJ+PGAp+ORGIa
 P/6FQjDQg15wcFlCFifAwoLCopctmqlLVd3fHQWvhCYdvldsVljms+nhTOjaS4Q+kVwj
 lIbZ/4ufhBIBHzpmcu4I6oMVA6PderoCLPEwXIrLGSSwuWo7rfHmILExAih0DuLu+gap
 5G4SshJajditfZ1xPhNdcfESjYbkrVrnEJpxSPAsCGCbySNIHHs7If1ShL3vdVx7rYEB
 xrFJLyy0ywfiGWMsh4TjsKrQYGMcO0ewUxLOGBsI5Uxsh+bliOqIeJoQgvlhB0V3wmpg
 ZqZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822995; x=1793427795;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
 b=IjAWgTEN3xxcaKcMQvv4ggR1+Yu6xLc5bh1QtlkyNckF6htyCJKqJ6NRGzCWrZeO/V
 vdB49W/9IMVnRfLOypR8TZyfvmjMrm3DDLZUNiNFeZNpP5MtwHN+cmGPOWKVfwQeNE7i
 y1Yeaqk20mCulEy7kiFGaYH4f88+OsNlrINMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822995; x=1793427795;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j9KIdiuMfo++NnUq+tO4CTJW9S/TX5mlgSxTo85keYY=;
 b=mJfnUq6e2LQKW8s1rV/ej9WbKiCwBKRFlD4LpXg+wz2VawR/vZYAthtT4x10mNWTB/
 nEhxEeUaGm+p8g+k25tZ7x7VXDvRUGPqTTuXSOAiyypQba0h4pG5wO4h8QQqo7U4ZpPN
 ODpxqdxrq1M6uPnGDL1ZsuGdxzcfNvQCIuryEDm1+D6gBMHsb/w2Ol7rEc9fjYiPQm5M
 hIE1bvcIXfmlSDuOOOzNdLT6LPEs0R7tr3o9gbrnMqjMQf7GEN0q/UkDkC6FO2zLvjoD
 T95JmpIatKUVSGUPPCZkN2vfkYLr07c3JBUt/rGZW6KIuiNWS+mnlw/95QWPCA9jMtAD
 6FXg==
X-Gm-Message-State: AFq9FYJ5vqn2UPxMDbtafxyuiGEulEt4TOcyjd1QCsITZFeqhV9yii27
 5J2SHSpRw6laQG3ZG7HvFEbhIid2fVuxLnZZJtZcRAl5kWD0wbAu26Uwx/HXYUr/Trrr08JegPn
 RKUnrIcgAo3/4s1mz2KshsMiTFpiWX6w7AroHSvqY0yrK7kgoinw=
X-Gm-Gg: AYBFou0cMv3nsZXd6DZnhZVXDkI08P4bEuQB3npKalvjxht1HjOmZnxpGB5TbgrDmii
 uMIjNVO+I1aIBo7BtmtnWK7j36KwWuhBeW1LtC16JxoloH2Ams+g7VxOPnfJJPwnFYkxA33jiPI
 bxh7v6+mnTDTqGg/CXj0uIzv/Xo6mjox0VGGlp08Sa2hi3F/wimPTgL+Bu7AcKN3graZJaXGorf
 Mejs1AQAvPrLtdOGXmET8hUQoF7F1jj5a4W748Xx3fysIzuToUl0zacce+PuzSnZt45/F8AVGta
 32MsrPJkx8BiFOJIq/nP1syIFjLbJmfLrI6drTwqdgnV6+MSFoJXfOAZ+ePkndGRfFzTsHbrkp9
 P1fHQUkUbcxyXPCsPRI/Ojr9KyboxcAszOJE=
X-Received: by 2002:a17:90b:3d2:b0:3ad:eb34:4c6c with SMTP id
 98e67ed59e1d1-3adeb344cd8mr906355a91.13.1792822994780; Fri, 23 Oct 2026
 23:23:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:23:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 07:48:55 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-6-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
 <20261021102626.264091-6-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:23:11 -0700
X-Gm-Features: AclHuK_NJhC0cI_K2m1nXabwX03AISczx25FhaHOvNdTFJlbK6xVGnpev9VxvM0
Message-ID: <CAFLszTgoRxwtu5A3RdvtYXn5XOAsS8BtpoDF0Ytvx857mCep-w@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: fit: Document private key filename fallbacks
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
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

Hi Ayoub,

On 2026-10-21T10:26:22, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> doc: fit: Document private key filename fallbacks
>
> Document RSA and ECDSA private key filename preferences and fallback
> behavior in the FIT guide and mkimage manual.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  doc/mkimage.1               | 3 +++
>  doc/usage/fit/signature.rst | 7 ++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)

> diff --git a/doc/mkimage.1 b/doc/mkimage.1
> @@ -392,6 +392,9 @@ necessary when embedding it into another device tree using
>  .BR \-K .
>  .I name
>  is the value of the signature node's \(oqkey-name-hint\(cq property.
> +RSA prefers the .key extension and ECDSA prefers .pem. If the preferred
> +private key file does not exist, mkimage tries the other extension.
> +Both files contain PEM-encoded private keys.

A few lines up, the existing text says the directory 'should contain a
private key file name.key', which is now wrong for ECDSA, so the new
text contradicts it. Please can you reword that sentence (e.g. 'a
private key file name.key or name.pem') rather than adding a
qualification at the end?

'Both files contain PEM-encoded private keys' sounds like both files
must exist. Something like 'Either file must contain a PEM-encoded
private key' would be clearer. The same applies to the signature.rst
change.

Regards,
Simon
