Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F70ECCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 09:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1F183A94;
	Tue, 11 Nov 2025 10:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OfSqElO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4FF83A79; Tue, 11 Nov 2025 10:39:13 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F6883A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78665368a5cso37760107b3.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762853949; x=1763458749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lOvlCQzuRUUg056LdJi7+55UTjFRlcTzJ55vHX26pcE=;
 b=OfSqElO7BLH+DxsZxsNo5T+elIZJH5oZ6AFumdM5DxJEOgonpR50bOKDrABG1UaMny
 YAHKYBef19hkhjDJBXurIJLzKvPu5SVCCK60u46GYmZP0AWErOK4eTcGZvW4hZaIrCF7
 BMndl2voL8DpB4pbWXh4SyT9y/u8xnvrHRJrmjH7zZYSsiHlNCUTi5GdzOGhjNJjLQRC
 UFDc35Dx9JKQK9nl41TF7RH3MmCGZtP1J3VhP+JzCANcNXXuYDrum4dUcgKXXDNdNNiB
 1VRJ3BK6U706q26VnrsXtSNHzydO1BFbFiilyx04r8G6utfjWs7FCqvmgPnBlnOQn37e
 jOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762853949; x=1763458749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOvlCQzuRUUg056LdJi7+55UTjFRlcTzJ55vHX26pcE=;
 b=JjN4coUT8U1iX4/kHajYEoxStBh84D7PqS0FxNR64d8CuS+SB9qB7ADQRFqJFiVTZb
 DJv6IIa4ffiT/qyKE7RFkj3kCMwgvEn+kY67Hd1BW/5s2Wq28exW0zs916e3vBojhUmW
 LS3QXdln7PHNtEE0PoGfXCQ14SYpEcioPOgCNW+VhupXBxG/XNeRGTaFDmXKiASjzfhz
 qSBj58lFmVpw4CI/M/NCxVNbppiwThYWa80u+DLVu1bGb5pkafRbiYgwcqDfu0nw7aBF
 QmjSxdySU+Oz/NojXvWGr6qi3mHjtjk8ENJ3npf46mSYHPCyz648JE7YtrnAx5AZwIiN
 Vvnw==
X-Gm-Message-State: AOJu0YxeFEQyA2wrL+D9UtLyjr72hr/52xrC1Nf8zZuNCs3qxhcZnafn
 SP9DHSocWWj3qUzH9S5bnFdhgXp4hGpv1KA0FAumvgNYcKZTI6hTyvOK9d/k+l4LZVcAzlRrW1n
 VnQvlgOooS9Tj5BdHOoCaS2ojS1zvyH/aOJxqcrlDtbYw/qJK/PF1
X-Gm-Gg: ASbGncuYsKgybcLT+M5wMKpgWrxCUIfeWuNtCgQ6YL8boTzuaww/3tpH6OfIznqtHrG
 tGTE6g0T6+oh1iA1hwITrkoxTDHteeOMdFJUHf2LzDEKX7g/9BNLlXfiG4n1U2v2bfgQ9KtSkG5
 EQd3YQXvNLDaHEsRD4Q8YPxr2xee9xT1IjLjJjbSz8jMFsShEFs8xKXSbbIumEoPx1b8JlgCSn5
 lTn8quPwoolphuai9fLzPV/G+iXOosGeG5p1vnKbcAVv6ShqBY6S7TkyfdiA+a0XSYEBMu3yPSc
 amNB4Ox9O0RZqQPNYOPVYuGQ9IcV9tetp/uP2E96
X-Google-Smtp-Source: AGHT+IET3fxKrJD9pSxr9lvuY7qzQkKRBeUkJlsx+d42tclgUl9XOSkSqMcqJhaDJUo5Y7LLFLJ7g0RmeJdDcMSkGxo=
X-Received: by 2002:a05:690e:244c:b0:63f:af79:e4d0 with SMTP id
 956f58d0204a3-640d4542809mr8042917d50.3.1762853949209; Tue, 11 Nov 2025
 01:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-5-hs@nabladev.com>
 <CAC_iWjLjxtPV0SF0XHmB3WJ_4EOzPRLC-YvLXt0QpUUrZDnmtg@mail.gmail.com>
In-Reply-To: <CAC_iWjLjxtPV0SF0XHmB3WJ_4EOzPRLC-YvLXt0QpUUrZDnmtg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 11:38:32 +0200
X-Gm-Features: AWmQ_bkOr5WkndQ1fWg9Ankx3qeJPrYHejEDEMzHXUODoZ0-6Ejl6e8Fncj9LgM
Message-ID: <CAC_iWjK0nwo3bwKbEhjrKCNUz2PLXzhEtWdgBDgHcotek-8e8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tpm2: add sm3 256 hash support
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

[...]

> > @@ -143,6 +144,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
> >                         sha512_finish(&ctx_512, final);
> >                         len = TPM2_SHA512_DIGEST_SIZE;
> >                         break;
> > +#endif
> > +#if IS_ENABLED(CONFIG_SM3)
> > +               case TPM2_ALG_SM3_256:
> > +                       sm3_hash(input, length, final);

I haven't looked at the sm3 implementation yet, but it doesn't have the usual
start
update
finish
?

Thanks
/Ilias
> > +                       len = TPM2_SM3_256_DIGEST_SIZE;
> > +                       break;
> >  #endif
> >                 default:
> >                         printf("%s: unsupported algorithm %x\n", __func__,
> > @@ -319,6 +326,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
> >                         case TPM2_ALG_SHA256:
> >                         case TPM2_ALG_SHA384:
> >                         case TPM2_ALG_SHA512:
> > +                       case TPM2_ALG_SM3_256:
> >                                 len = tpm2_algorithm_to_len(algo);
> >                                 break;
> >                         default:
> > @@ -431,6 +439,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog,
> >                 case TPM2_ALG_SHA256:
> >                 case TPM2_ALG_SHA384:
> >                 case TPM2_ALG_SHA512:
> > +               case TPM2_ALG_SM3_256:
> >                         len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
> >                         if (tpm2_algorithm_to_len(algo) != len) {
> >                                 log_err("EventLog invalid algorithm length\n");
> > --
> > 2.20.1
> >
