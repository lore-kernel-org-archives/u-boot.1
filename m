Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED36C5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 18:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4078800D;
	Wed, 28 Feb 2024 19:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nnuij5Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C721987B2D; Wed, 28 Feb 2024 19:14:25 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE4A88070
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 19:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so162324a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709144062; x=1709748862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B28EfhWEBrecXbsiGZj96wCBs5uZ4lYNKM0WeiQxcok=;
 b=Nnuij5FvR7YEJ9hYYDqDld13AuF4ajsW1PCboiNRyvd2Br0n720cAiCZxhglLkZ3e9
 Co0qm86QBMQunQC0wE3QtkeDn87PKAptzIZhpHZdgLZEJe2/R0VpmkEcwIUVNCizYw0Y
 OpgL8NTBnX8Oy0k3QhZUfiefB3EH4xpVJstCbRHJj2SI2t2Pj6uhkY+1OBttAVh78rsa
 4STiOvQkC+s6GC50SDl4Bws6xutXIRH+XL3mk5Xzh0QZ2qzR0ULejFEnoNclmivMaBI6
 7GbyUVzFqjweW55GNA7fSnxhX/AeNvdvOW9QrOW0IwJD08fnug639X12JxNLXDZMyv1U
 gaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709144062; x=1709748862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B28EfhWEBrecXbsiGZj96wCBs5uZ4lYNKM0WeiQxcok=;
 b=UIt4YRrAJ3u07ywHsLgPFJVgJKG59rv73f4Kd0t1oZJhrt3Erzw5UQ+ITpaxAIgCex
 gORBq17oLuyAR+UQ0YYo1HUspVp/9fSl0cmR5QYi3j4HCI67jM2GxYDsMFukwS8lEzOH
 8D3vnwGFZggmHajbQ15GkDyEnJ30ttSnAiInr0YKkR/oxoWdT8P94V0RbZT4dm5V8PHh
 8ud+iFMsOiKRIN33T6L2QMVeNJpw9oZt2kBtOoVJh4ukYDLzYAaTHq2rBzhoLKvgt10d
 OC4zJC9kuYWwVWw0AE6/kXzz2kQxgrbqtBCIYdysSRPMSw06UEdIVWvhUmURHm0eA0r5
 TwCg==
X-Gm-Message-State: AOJu0YwkVuBuD9jSvchQNidnB9Bp9FZnM+IaH6rte53r45XF1k3yPPJ8
 LAsh1+PZFzwiCniKIg3GWsw6u18WXalFqTW7h+zLHkMWjhJytRnMnC44C2b/ChqgTzrw1BnIc+k
 gxNPyeD2/70wduR0wspBIpyc03QN3oehsxng=
X-Google-Smtp-Source: AGHT+IEa1UBVjJGU+zVM8tvz0b4UM9tuD/WnDWWTrdAEdsR8StyTEu3422tfC+DzWqklZ4bro68l1NoaN4w0EOnTaSc=
X-Received: by 2002:a17:906:2c1b:b0:a44:b4e:307a with SMTP id
 e27-20020a1709062c1b00b00a440b4e307amr290443ejh.56.1709144062355; Wed, 28 Feb
 2024 10:14:22 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
 <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
In-Reply-To: <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Wed, 28 Feb 2024 10:14:11 -0800
Message-ID: <CAF1iuRr5CfOuKJk_SDUwurKb74vpsb_N8Ke_Gw+TLFE2E5kNmA@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
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

Any thoughts on how to proceed with the issue mentioned about tinycrypt
warnings/checks?

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


On Thu, Feb 22, 2024 at 3:07=E2=80=AFPM Bob Wolff <bob.wolff68@gmail.com> w=
rote:

> Peter,
> Thanks for helping lead me down the right path here.
>
> WRT tinycrypt, the license is quite permissive.
> https://github.com/intel/tinycrypt
>
> Also, I'd like your advice - I was thinking for the larger patch that I'd
> do it in two commits. The first would be the addition of the tinycrypt
> files and the second is the actual changes and additions to support ecdsa
> verification. I doubt that's controversial. However when I run a trial
> `patman` against the tinycrypt commit, I geta huge number of issues:
>     *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
> warning(s), 481 checks(s)*
>
> What's your advice on this? I would tend to think we'd want to /not/
> change the source files directly for such purposes so that updates could =
be
> brought in with greater ease.
>
> Let me know your thoughts.
>
> Thanks,
> Bob Wolff
>
>
>
> On Wed, Feb 21, 2024 at 6:03=E2=80=AFAM Peter Robinson <pbrobinson@gmail.=
com>
> wrote:
>
>>
>>
>> On Wed, 21 Feb 2024, 11:30 Bob Wolff, <bob.wolff68@gmail.com> wrote:
>>
>>> Hi there,
>>> I have two separate but related pull requests I'd like to contribute.
>>> They
>>> both have to do with ECDSA support.
>>> - The simple one is a lack of null-pointer check that can cause a crash
>>> in
>>> certain situations. Easy peasy.
>>>
>>
>> Just send that one on it's own
>>
>> - The less simple one (and hopefully not too controversial) adds an ecds=
a
>>> verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypto
>>> work.
>>>
>>
>> Do we already use tiny crypt in the project, if not things like license
>> need to be taken into account in the context of the GPLv2
>>
>> Please advise on how best to proceed. Happy to work within the confines =
of
>>> what works best for the larger group.
>>>
>>> Thanks,
>>> Bob Wolff
>>>
>>
