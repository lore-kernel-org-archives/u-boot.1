Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F79C54798
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 23:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0FE87CF8;
	Fri, 23 Feb 2024 00:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7SH8x3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D677A87C48; Fri, 23 Feb 2024 00:07:17 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5244C87A00
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 00:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3122b70439so32157266b.3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708643234; x=1709248034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2bTeXRY1H+aSRFwdurSfQr+87d8NntVpwxtR/tyUL+c=;
 b=h7SH8x3Q5YIxRkFoETxUEdVUqbw0Nn5PkMIcF4z7DGMyDOVN3SxkDcPE7qi2Rb8IfA
 R+1I2fu0ZmU5E6eYamsyci2m7fk9sQLiFs35Svn2gLb2enGyzokV7uM/d54l4wleZMJD
 AIIKqFyjMEyPUNMy4Ip0d2tOtQ+RwJx8fScQw9BVmKv0odWiU0Ys4UnfUXCJDAGBDHpU
 68/v/GveIMTCC+6MVE+Wd5YhVOExP+kJawfqRJGIsoW9gsZXqbDBdscNymr+8EiOBYDQ
 OC39zUdogJwNvhDKxK23olshS9Tzkd9Tj99UN+YKj3FHrZ5ar1LWVmRPkzTj2MxQSPtr
 HEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708643234; x=1709248034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bTeXRY1H+aSRFwdurSfQr+87d8NntVpwxtR/tyUL+c=;
 b=o6dUXzqLlBSlWWNYsrlttLZxyqMdG0pO0DKXAcZu0EukJ9Qm2eIACDqzgx29nJqyFY
 WV+xhUkTEGYpDiVgHgR8+dliag6uW8RvBiII6a/9gnCfPjHAdgx/TTqqNRVep54XEft9
 Y8K7ANMaNLAntDSWFtqzm/C7hZWf8W9lscOXRa9+6Dj53NITtO6MGas332aUxGTnI817
 fvXH8nnfjuRl4Qs+PianMDN7BCKZ5i3eWZ2fpyFmTXiCwxuEskRURjIOKHGDPXVq/nl/
 xR7aNQadOk6O33sJw0YD5mqwUe6nlSN5jaq3AX2U3+wCYLvsf0gvh8w2cMCm8DBVCaAS
 wyHQ==
X-Gm-Message-State: AOJu0Yzi48AgbV5ZNp/HitoaNzTlLkD6nG3IR5xttCfZDoF+Zee09Vc0
 1wspDCI0eYxQkZgJIoP0vkR/vT8c8aIJayVTNacEy46dA453tVuucjYrIDK1tDEkjUcftS1sXrz
 nQcnPUlOcER4aiCi2z5H3zzBk8FfcpDzHo3I=
X-Google-Smtp-Source: AGHT+IGqx24roH1i1oaltWuJSat+jpLwGYhtrgxeWfrWOakDc2ozPC/lyYTN5k3j/0c3paRP+c3wj4BVwD1rXM6gxAc=
X-Received: by 2002:a17:906:54d:b0:a3e:c738:8f82 with SMTP id
 k13-20020a170906054d00b00a3ec7388f82mr136514eja.36.1708643233518; Thu, 22 Feb
 2024 15:07:13 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
In-Reply-To: <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Thu, 22 Feb 2024 15:07:01 -0800
Message-ID: <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 23 Feb 2024 00:34:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Peter,
Thanks for helping lead me down the right path here.

WRT tinycrypt, the license is quite permissive.
https://github.com/intel/tinycrypt

Also, I'd like your advice - I was thinking for the larger patch that I'd
do it in two commits. The first would be the addition of the tinycrypt
files and the second is the actual changes and additions to support ecdsa
verification. I doubt that's controversial. However when I run a trial
`patman` against the tinycrypt commit, I geta huge number of issues:
    *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
warning(s), 481 checks(s)*

What's your advice on this? I would tend to think we'd want to /not/ change
the source files directly for such purposes so that updates could be
brought in with greater ease.

Let me know your thoughts.

Thanks,
Bob Wolff



On Wed, Feb 21, 2024 at 6:03=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:

>
>
> On Wed, 21 Feb 2024, 11:30 Bob Wolff, <bob.wolff68@gmail.com> wrote:
>
>> Hi there,
>> I have two separate but related pull requests I'd like to contribute. Th=
ey
>> both have to do with ECDSA support.
>> - The simple one is a lack of null-pointer check that can cause a crash =
in
>> certain situations. Easy peasy.
>>
>
> Just send that one on it's own
>
> - The less simple one (and hopefully not too controversial) adds an ecdsa
>> verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypto
>> work.
>>
>
> Do we already use tiny crypt in the project, if not things like license
> need to be taken into account in the context of the GPLv2
>
> Please advise on how best to proceed. Happy to work within the confines o=
f
>> what works best for the larger group.
>>
>> Thanks,
>> Bob Wolff
>>
>
