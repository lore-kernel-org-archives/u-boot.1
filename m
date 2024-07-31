Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C67C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 12:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F39A889D2;
	Wed, 31 Jul 2024 14:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xccc3qhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F148D889D2; Wed, 31 Jul 2024 14:02:30 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC29889D5
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 14:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so3487303a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722427347; x=1723032147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BqKfJotq3eDHD985aYmU+sXieZCcmtqP3LZXmxqaCg4=;
 b=Xccc3qhKkgby4z+odoyX2SmZ1svTV3+949okrKXlSDjRYUNBEWGP4ImtD4lzxzvK5B
 q4Yp0Y3ow+lwMHFlVA35A7ib5oYQJySzCXGDJ8IfkhOADZBODHkqv1MffYDFivKERID+
 jEjkeR/D08GVQo8VSK39We75sSc/W9bZLpZWwbjD4ZHK1a5EXWNqQtvBEDFm5aRY3sDx
 XkxvRMErVM38NfsP+9XfnsVQW/Jh6dkbbXlfJvNMzdai9oUOUObaXxrbm1wStYHZprGX
 o0iFbwinzLK88ch0NC5chMIXI4Z9NiKbMjEtCJKt6ROX61cnN2oA+9XXGuqr9MUBgJ0E
 MuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722427347; x=1723032147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqKfJotq3eDHD985aYmU+sXieZCcmtqP3LZXmxqaCg4=;
 b=AWSpbD+dmp84yMm3TIwlvutuAn7bRQod0+oCJvvmrVdktS0qVA3IV4GFkUeEzUB1+s
 v9+snizu1svHkEYKsds0DA7dwiZTC9Y5ZMIU97RS6M6BnrfzornrgbuTWvZ+LfX2n/7z
 mNYWhsP0eJxP1z+m2QUbS8QkEw+BvcoKZdOfny7i/aaaUm37fuTQltsxUwcf2bNJ7scP
 Y4ZVNK80JCYXMtJ/owHILgGq2L9Ml9q9XNItTJkmHqKV2mdj0myNt3csS/UzhqFzGkwO
 O3Jh/Vsr3qTvpf1TE7C+tFKLxO4FHiKTEf515vU4mA0iLhEfsqSECOcL8nnSgGhbaZDZ
 dZ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJHqYRY+zgMXQ1B75xb9xqzP9H53DZ6aOP+YlBK89AQxHpYO257gdoQgiGsyyk7bef/q3eGLF+8TcVn3vMpKpdxSkddQ==
X-Gm-Message-State: AOJu0Yw+ahZWfdBcRG+m7CwOqqxCiAYt6dIUZRl6wQ4WiosCAYtSmZR1
 GmBhB67eeXW9zcGtFUNI1424QShgYuFcjL5+xNoHP5qetstM2LR/vEDhAAVqomK3/XULKIYz7VN
 GRD0YdyVPJOGWZPgZPuErRZ/fXb5gKacCmYDYPg==
X-Google-Smtp-Source: AGHT+IH9uVCUsrJ3+OYmV/6eW39uaqY8UDLfqgOR9iPSIUATWevoV5+n3o6Y0NLuliNUhs5CFefi1/aERlAj02a4PAE=
X-Received: by 2002:a17:90a:fd87:b0:2cf:2ab6:a157 with SMTP id
 98e67ed59e1d1-2cf7e1c1ac9mr12052884a91.12.1722427346565; Wed, 31 Jul 2024
 05:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-2-8a83de3fe3dc@linaro.org>
 <CAC_iWjK1j0hG7jurTEPLKoYLPCL5JuUhRUoBwohUr=U93rb6dQ@mail.gmail.com>
 <23b45a9e-d2e6-40c9-beca-6de58c7f67e2@linaro.org>
In-Reply-To: <23b45a9e-d2e6-40c9-beca-6de58c7f67e2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 15:01:50 +0300
Message-ID: <CAC_iWjLRsTEYUbnSqkmR09bZMu+fkwA-7oixXN7SZ+zB5xxTsg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

Hi Caleb,

On Wed, 31 Jul 2024 at 13:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
> >> +       /* Make little endian */
> >> +       tmp32 = (uint32_t *)&guid->b[0];
> >> +       *tmp32 = be32_to_cpu(*tmp32);
> >> +       tmp16 = (uint16_t *)&guid->b[4];
> >> +       *tmp16 = be16_to_cpu(*tmp16);
> >> +       tmp16 = (uint16_t *)&guid->b[6];
> >> +       *tmp16 = be16_to_cpu(*tmp16);
> >
> > you need to explicitly convert those to LE, instead of relying to the
> > native cpu endianess here
>
> The EFI spec iirc is not explicit on the binary format for GUIDs on big
> endian systems (and currently doesn't support them at all??). Is LE
> always correct??

Appendix A on GUIDs and formats says
"It should also be noted that TimeLow, TimeMid, TimeHighAndVersion
fields in the EFI are encoded as little endian".  So, the native
endianness shouldn't matter

Cheers
/Ilias

> >
> > cheers
> > /Ilias
> >> +}
> >> +
> >>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
> >>   void gen_rand_uuid(unsigned char *uuid_bin)
> >>   {
> >>          u32 ptr[4];
> >> @@ -394,15 +444,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
> >>          /* Set all fields randomly */
> >>          for (i = 0; i < 4; i++)
> >>                  ptr[i] = rand();
> >>
> >> -       clrsetbits_be16(&uuid->time_hi_and_version,
> >> -                       UUID_VERSION_MASK,
> >> -                       UUID_VERSION << UUID_VERSION_SHIFT);
> >> -
> >> -       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
> >> -                    UUID_VARIANT_MASK,
> >> -                    UUID_VARIANT << UUID_VARIANT_SHIFT);
> >> +       configure_uuid(uuid, UUID_VERSION);
> >>
> >>          memcpy(uuid_bin, uuid, 16);
> >>   }
> >>
> >>
> >> --
> >> 2.45.2
> >>
>
> --
> // Caleb (they/them)
