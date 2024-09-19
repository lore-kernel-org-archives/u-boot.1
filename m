Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565B9CF395C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC508924C;
	Thu, 19 Sep 2024 17:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AUKxeFeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189EA89254; Thu, 19 Sep 2024 17:19:47 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5ACE8924B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c582ca168fso6546436d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726759184; x=1727363984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1TVk2sOjVo02E9kCdqKoSZGGGU0Hj5Ma1yiewASXFg=;
 b=AUKxeFeTDCSm3I6jzXQGhsTB6hDxfjXf8d8rW7oGJJiVhsZNHIAHcJ71ORobi5vsQV
 OxhkDPKdPsWHxn66UgxnVMOLElRQJWY2kVonR20r5HVtTgqtGA6TVfZg4oW0wMS8E/+s
 VmiQ891Wa56u8lIbI5+Qsxn1CIjXNe04Uz+8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726759184; x=1727363984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1TVk2sOjVo02E9kCdqKoSZGGGU0Hj5Ma1yiewASXFg=;
 b=nE6sfkb7F8mkDncMZkWJmrBrXUVtAW8HoVp0eXkOyrLxLlkTM+IvdQivU05m8YRzCC
 ILhfHGxbzQ0PcBpzgSJITBR+mTuPS21R6nr7jlDNQDsMuQQ9FMFT9aH2BnqrLcNURzLc
 O4KmIaYi07SPbT0anhzT+m+tpP8COJ2d1SF09KuwOTBofOY+IeRPSuOGDSIt+2fmxN4Y
 Yy7uM6riJJ+xI7/aM7o4em5Q+0+EE39imaLVgxblmwY3RoUH9H+hlHMcqxETKPRshWY3
 eUuFE8HSCwc9PJgA2nQv9/Ovlx72Ndq2D8qZkfla5ymOmS6P0A6k67lfNtYgiA2QXRT/
 95ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNoI+uFCw2Vy8ZzBfYTSlS981o1Bo3HyZ+m8sdtsepyEvhv1wDNqnYATMKsjY1U5i7drHjuCU=@lists.denx.de
X-Gm-Message-State: AOJu0YxQhYTXG7vfRzZ7a9/sD/DuPHX7MKRvL6mtMNtORTsgSlmAh7bw
 VEXrszLL7wvwkIoGLkFdZfCg39AOiRYJpCA2Z6KqLIllwfzD0gAJ0+7akFBXbx3knMpwCLlxelX
 Rv6m0OWEjKviVwHNCxCsBPr9cwMESAuCQggxJ
X-Google-Smtp-Source: AGHT+IH7imCsFTDpbXL7Z+IeIidedRKHeWm0mfM44N8BoKE8/BQhyJmVU1VTG0dV5Rb4bP87N0Os46p5qiui832Y/PQ=
X-Received: by 2002:a05:6214:5c44:b0:6c5:aab1:4f04 with SMTP id
 6a1803df08f44-6c5aab15581mr189605096d6.28.1726759183799; Thu, 19 Sep 2024
 08:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
In-Reply-To: <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 17:19:32 +0200
Message-ID: <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
>
>
> On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 19.09.24 17:00, Simon Glass wrote:
>> > Hi,
>> >
>> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
>> > <ilias.apalodimas@linaro.org> wrote:
>> >>
>> >> Hi all,
>> >>
>> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
>> >> <heinrich.schuchardt@canonical.com> wrote:
>> >>>
>> >>> On 19.09.24 16:10, Simon Glass wrote:
>> >>>> Hi Heinrich,
>> >>>>
>> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
>> >>>> <heinrich.schuchardt@canonical.com> wrote:
>> >>>>>
>> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
>> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>> >>>>
>> >>>> Could you explain a bit why this is, and where this is checked?
>> >>>>>
>> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>> >>>
>> >>> Measured boot relies on creating hashes of artifacts and writing these
>> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
>> >>> boot. The device-tree is one of the artifacts that are measured.
>> >>>
>> >>> If we have random values in /chosen, measured boot will fail.
>> >>>
>> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
>> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
>> >>
>> >> There's a comment on top of that function that explains what happens as well.
>> >> In short the EFI stub does not even look at the KASLR seed and never
>> >> randomizes the physical placement of the kernel. It only does that
>> >> when the EFI_RNG protocol is there.
>> >
>> > OK thank you. I suppose I am more just wondering why it got added in
>> > the first place?
>>
>> For booting via the legacy Linux entry point adding kaslr-seed allows to
>> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
>
>
> Not the kernel physical placement. It randomizes only the virtual placement

So, are you saying that U-Boot adds this field into the FDT and then removes it?

Regards,
Simon
