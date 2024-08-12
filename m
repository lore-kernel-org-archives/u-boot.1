Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67B7C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 12:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F67886A7;
	Mon, 12 Aug 2024 14:56:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ozwcNg+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC73884C3; Mon, 12 Aug 2024 10:32:08 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F1D87E30
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 10:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joakim.bech@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-664b4589b1aso38686737b3.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723451524; x=1724056324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j3rQiVKcuZvKJ3u+TfJN50TD/s+naMvBlNqX4JA1bLM=;
 b=ozwcNg+2axz3daJnah3jpAMLc522DDnvQe9M01fTyUM88tdPAaDtQ4zE3MHjiIgWve
 eBSb5wM5TKv+QD4HCAVqody65F1WuX0KDV49VUIHxLMrvnT6r9ZsoFyP7iMOnpYmJxgG
 rAxRmEHi5WCHBJfklmhZF0rY3SSP+4kdmMImkwkYuAspmdp1Q6ECitzm1Wjn+o06voKD
 7upf4bkFC1P+XTHg+5/obH3LFn5Gbokerz/FNrUSyrictS8Npd6dNnerLB407ZpyGnf4
 d3K69y/Mwhi6MmOl3YFXffqKWbulv4dAg7sm8jNah64VP5WaawAvEUtiwoVDQvPPIiXF
 +CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723451524; x=1724056324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3rQiVKcuZvKJ3u+TfJN50TD/s+naMvBlNqX4JA1bLM=;
 b=izIWqMPpuC6ncE4lsLgrnCoQSFEW9WhUIeNpA6+pEexUIAy0CdKvd3ZAeIpnufoe6O
 LxgKWnzXAwcWfssx72VN3RLFkJ5WS3M8cUQ2skgR2jlc1qJ4VJv+9NfH3GprOq3Tu1rv
 ZrBwqgRE0MB1lKfibZMFgFWbd5imk8SVE9G/4bz1L9u925iyBjyz3ED/ejJkstIiAzcZ
 MciMdqBgyQdkITB2fLfKrpaOk79Cu9Y/mF8YAh10OTeecBbgA35qkUku/Tf1r8kRo/dY
 p4kvOB90VVgt4waBe7gFaSvgLSNzVLb+eWE8z6aKcjvcVE9dOyJqMqTZVIj1jRfYgX7e
 Ji6w==
X-Gm-Message-State: AOJu0Yy2qr3nAxstyXlFzOc/k4lvHde2UUSF58DwXQ+G9BzaDS2c6fsa
 cv6NQJ+BO53l81NCplvs4eWQ9ZU/xQT+Q0zuY72Hfimtcskigt7OjkKwTCJEKkH0LXSK/LQBiDa
 qTeSeBpamYzIAWc0fQhUzmN6FXpiBr0wCaePH2C1tF2MPt3DmBBU=
X-Google-Smtp-Source: AGHT+IGKY2USpcBPt2Y+DPbBDkWdJ11KrC6pAHJNfCPMOpAy0Fvhgu2CdUS0SwEIl0W3g6HHj3/t5MA74JagVFOGtwY=
X-Received: by 2002:a05:690c:6f05:b0:61a:d0d8:75f6 with SMTP id
 00721157ae682-69c122540eemr96742427b3.24.1723451523734; Mon, 12 Aug 2024
 01:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
From: Joakim Bech <joakim.bech@linaro.org>
Date: Mon, 12 Aug 2024 10:31:27 +0200
Message-ID: <CA+Eyddbaq1cXtzrNXc1K2bsWwG3v3G6Zm=7Y0SRGuMDw5Zk0FQ@mail.gmail.com>
Subject: Re: Verified Boot through U-Boot for RPi3 with OP-TEE
To: thomas.gymer@bt.com
Cc: u-boot@lists.denx.de, op-tee@lists.trustedfirmware.org
X-Mailman-Approved-At: Mon, 12 Aug 2024 14:56:11 +0200
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

Hi Thomas and Eden,

On Mon, Aug 12, 2024 at 9:48=E2=80=AFAM thomas.gymer--- via OP-TEE <
op-tee@lists.trustedfirmware.org> wrote:

> Hello all,
>
> We (Eden and I) have been assigned a summer project exploring the
> possibility of verified boot for Linux with a view to experiment with a
> TEE, and would like to share our outcomes from the project so far.
>
> We've been working on condensing all the information and documentation on
> TF-A, OP-TEE, and U-Boot verified boot into a trivially workable form, a
> Makefile, for the Raspberry Pi 3B+. Our aim is a proof of concept pilot
> project to see what parts of the technology outlined in the NIST standard=
s
> for secure boot on IoT is currently available, and thus what needs to be
> developed. This also leads us to an interest in full crypto algorithm
> agility to ensure quick adoption of the quantum safe algorithms as they
> come out.
> I should note that our boot order here is TF-A to OP-TEE, then TF-A to
> U-Boot to Linux.
> This has raised a few areas of note and a couple of issues on our end:
>
> # Areas of note
> - U-Boot and Linux DTB's being incompatible has minimal documentation
> Newer versions of U-Boot do have `CONFIG_OF_UPSTREAM`, but I can't see
> that as a recommended solution. Perhaps a note in the Kconfig entry for
> `CONFIG_OF_CONTROL` would be sufficient
> - U-Boot can fail silently if the DTB used is incompatible
> No idea what the solution here could be; an invalid DTB inevitably means
> that the firmware cannot access any of the hardware correctly.
> - U-Boot unable to find `CONFIG_OF_SEPARATE` DTB's when loaded by TF-A;
> this is a TF-A problem, but maybe check other possible places for a DTB o=
n
> the U-Boot end?
> - U-Boot itself appears to have good crypto agility (or will in the near
> future), with a macro and existing algorithms as examples for the additio=
n
> of new algorithms
> - `mkimage` appears to be lacking these same features for crypto agility,
> which would otherwise set U-Boot up to be ready for the new quantum safe
> algorithms' release
> A similar macro system for `mkimage`, or some other schema for defining
> how to add algorithm keys to the FDT, would provide some amazing
> flexibility, already being able to define more than one signature as
> required. Adding keys to the FDT would need to be standardised in someway
> for this, I would imagine.
>
As a general comment, the incompatibilities (DTB UBoot/Linux) you've seen
is well known to the community and it's been a long running effort to
improve the situation.


>
> I am very aware that some of the below issues are not relevant to all
> projects, but thought it best to maintain a single list to ensure that th=
e
> correct place to make a fix for each issue is not locked project wise too
> early.
> # Issues
> - buildroot build fails when the directory length is greater than ~80
> characters
>
Interesting, I wasn't aware.


> - TF-A does not pass on the DTB address unless `RPI3_DIRECT_LINUX_BOOT` i=
s
> set, which also implies a define U-Boot doesn't need
> - TF-A `LOG_LEVEL=3D50` flag has compatibility issue in xlat tables v2 wh=
en
> compiled for 64bit
>
I believe this one is about the image becoming too big? Or is it actually a
xlat tables issue?


> - `mkimage` ECDSA key adding to FDT fails if there is no signature node
> pre-added and doesn't set `required` node when `-r` is used
> - `fit_check_sig`fails to check an ECDSA signed FIT file with
> corresponding FDT due to `<null>` hash node
> - `mkimage` expects ECDSA private key only in a `.pem` and not `.der`,
> which would be standard for a single private key
>
> We intend to release the Makefile and accompanying scripts for this on
> Monday 12th August, likely ~5pm BST to give us time to finalise what we
> have currently; this will consist of two Makefiles: one for verified boot
> using `CONFIG_OF_EMBED`, and another using `CONFIG_OF_SEPARATE` on U-Boot
> v2024.07. We are currently planning on releasing this on GitHub under the
> same license as the involved projects, but what would be the most helpful
> way for us to release this to you?
>
As one of the maintainers of the OP-TEE project, I'm always in favor of
having changes done in the official repositories, both code and
documentation. There is nothing wrong with doing a write up and keep fixes
elsewhere as such, but it has happened a couple of times that when people
do these things on their own, other people find the instructions etc on
internet and when they don't get it to work, they post issues and questions
at the official OP-TEE issue list. However, since this is code not
maintained or in the official git, there is little we can do about it. So,
if you can send fixes upstream to the official projects, that's what I
would suggest, that's the best in the long run. If you keep it elsewhere,
may I please just ask you to put some note somewhere in the docs or readme,
saying that this is work done outside official code, so if people try it
and if it for some reason wouldn't work, then asking for help upstream
likely won't lead to anything.


> We have, beside the points raised in the Issues section above, no specifi=
c
> changes for the exiting repos, focusing instead on Makefiles which pull
> together parts of the existing releases to produce a working PoC as quick=
ly
> as possible. We intend to also release this to the Raspberry Pi community
> as a TEE solution they can experiment with today.
>
I understand that you have a deadline for a summer project and therefore
have to prioritize and make decisions. It looks like you've done a great
deep dive and found various things that can (and should) be improved. For
OP-TEE, if you have time, please consider sending your findings to the
various "Issues" list at GitHub. If there is no obvious place to post the
issue, you can use the one in OP-TEE os (
https://github.com/OP-TEE/optee_os/issues). For U-Boot I believe it's the
mailinglist that is the best place to discuss individual issues.


>
> This email has been sent to:
> - u-boot@lists.denx.de
> - op-tee@lists.trustedfirmware.org
> and the Makefiles will be sent to Raspberry Pi Foundation and community
> some point next week
>
> Thomas Gymer (thomas.gymer@bt.com) & Eden Hamilton (eden.hamilton@bt.com)
>
>
>
--=20
Regards,
Joakim
