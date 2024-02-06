Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33211C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 06:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488E0879AF;
	Tue,  6 Feb 2024 07:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yker0BjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533D387B1D; Tue,  6 Feb 2024 07:20:44 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0C387727
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 07:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so2311837241.0
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 22:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707200441; x=1707805241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8x88w4fW8QKYa4zEVOqo6YuBvcgJJdUHEHlLaf2wo8=;
 b=Yker0BjPVY31x807su9LR8eCWzPPOr1dXNEiqIBX0YaxePaUslK+xtI2HbHm8zoatx
 KIM5b8GzxMlHYA1aD1RFlFALarYlh6WGs99GtaAhJ9hyTy7iwdt+zOepcb3aMeP4D6Lc
 l6Jii/ZnOXAN7yeiDgmbV0GcqphyMnfqVaMi+UZsBbzT1o5LsuHnGYALZYmuyFGZroLE
 EIHIf449l3a2kQRTyUmXRST3SAdBgXVbe3VEEFjDfCTZnTMgVoupSZrczwYLhN0CmoE4
 E8tXaNnWtOILD/ptdX3CVGdgm6KKqb7hpPCC2BQP87yR9JB5rPWkZpd5wcBSwJd/G7+o
 vreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707200441; x=1707805241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8x88w4fW8QKYa4zEVOqo6YuBvcgJJdUHEHlLaf2wo8=;
 b=T+v9gA1mW0j/7fDgJqnSRhbH7SNzLcs2Rv0wIlAIwf2Vp7BkIV7YEiXdOhnogKsczL
 me4H7F0kmyQj/L3RmTE5Cef9oDSHMztAe7YdZrubXjRNVFIGO1uWMvQvB8kMVr2+Gr2J
 hftXAnRudyo67l/itIJfLCJo6XRly/PDGJJckim0y/U84EMOTqE+8pDQP/lDiQIbnzqC
 AmuYSxMfXN5kDFrUasrJgRb/s6wwlvb90JAb6R2cdjTPLO3e/nwdxeLjDvQKJjcqopt2
 xw33mnGWYAeGUeNqrpqZoWMBJAixNDkAhN1MztRF5s+8KivM5+2Gwks0XvKVlbmp4ith
 hKtw==
X-Gm-Message-State: AOJu0Yw7KW9YjBT7RxAWtrJ8DHo6iz/omgxUZ8wOQhWGK2Cnt4MGCr66
 32yrEg5W/Nku0zi/WLAxETtjn3K0M3KEsYtB/PgdhfAdUFhwGZzPfHMaWBwGcjNk2NIs+rI1LzO
 RaFwhOjKNhyriLgf5PPdQnuaJEXhcucvTCLbXnA==
X-Google-Smtp-Source: AGHT+IE6NEUfp9Cxmb2gKx89dOUlDcIZ3UYx4VDnO37vbvb8Ofey4zmK5xpDfN02s7Jo8BRbK0iql/bpVSO5Apspgfg=
X-Received: by 2002:a05:6102:c50:b0:46d:1620:70d0 with SMTP id
 y16-20020a0561020c5000b0046d162070d0mr2323257vss.20.1707200440718; Mon, 05
 Feb 2024 22:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-7-sumit.garg@linaro.org>
 <ae946009-64a6-44bd-9034-b035684341a6@denx.de>
In-Reply-To: <ae946009-64a6-44bd-9034-b035684341a6@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 6 Feb 2024 11:50:29 +0530
Message-ID: <CAFA6WYPgRM8xPQcoJLemXcKvxekgZMRWkc7XG2hH5MFmUmhMZw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dts: Add script to uprev dts/upstream subtree
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, 
 mibodhi@gmail.com, bb@ti.com, festevam@gmail.com, nm@ti.com, 
 andre.przywara@arm.com
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

Hi Marek,

On Tue, 6 Feb 2024 at 05:51, Marek Vasut <marex@denx.de> wrote:
>
> On 2/2/24 14:05, Sumit Garg wrote:
> > dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
> > Usage from the top level U-Boot source tree, run:
> >
> > $ ./dts/update-dts-subtree.sh pull <release-tag>
> > $ ./dts/update-dts-subtree.sh pick <commit-id>
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> How are the fixes which land in linux-stable handled now ?

Firstly, all the fixes land in the Linux mainline tree, then at every
rc* release those would be mirrored into devicetree-rebasing repo. And
then if there is a critical fix to address DT ABI breakage for U-Boot
(for at least a single board) then they just need to notify us with
the fix commit ID to be picked up. Or if people are willing to use the
dts/update-dts-subtree.sh script themselves then we are happy to
accept patches too.

BTW, we will also work with Linux DT maintainers to improve DT ABI
maintenance towards U-Boot.

>
> Do I have to duplicate the work which is already being done by the
> linux-stable maintainers ?

No, we don't have to backport all the fixes as they will make their
way automatically via the next subtree pull. As above we are only
concerned about fixes which are required to maintain DT ABI towards
U-Boot.

>
> > ---
> >
> > Changes in v5:
> > - Added support to cherry-pick fixes in subtree update script. Also, used
> >    https:// instead of git://.
> >
> > Changes in v4:
> > - New patch to add script dts/update-dts-subtree.sh as per Rob's comments.
> >
> >   dts/update-dts-subtree.sh | 45 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> >   create mode 100755 dts/update-dts-subtree.sh
> >
> > diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
> > new file mode 100755
> > index 000000000000..b781bf710025
> > --- /dev/null
> > +++ b/dts/update-dts-subtree.sh
> > @@ -0,0 +1,45 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright 2024 Linaro Ltd.
> > +#
> > +# Usage: from the top level U-Boot source tree, run:
> > +# $ ./dts/update-dts-subtree.sh pull <release-tag>
> > +# $ ./dts/update-dts-subtree.sh pick <commit-id>
> > +#
> > +# The script will pull changes from devicetree-rebasing repo into U-Boot
> > +# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
> > +# automatically create a squash/merge commit listing the commits imported.
> > +
> > +set -e
> > +
> > +merge_commit_msg=$(cat << EOF
> > +Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
> > +
> > +[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > +EOF
> > +)
> > +
> > +remote_add() {
> > +    if ! git remote | grep -w devicetree-rebasing
>
> I think you are looking for git-remote get-url here.

Ack.

>
> > +    then
> > +        git remote add devicetree-rebasing \
> > +            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>
> Rather than reconfigure user git remotes like this without user
> knowledge, either ask them, or print a warning and let the user
> configure their git remotes knowingly as they need to. Include the
> command in the warning to make it easier on the user.

Fair, let me add a message specifying the command used to add a git
remote automatically for a user.

>
> > +    fi
> > +    git fetch devicetree-rebasing master
> > +}
> > +
> > +if [ ! -z $1 ] && [ $1 = "pull" ]
> > +then
> > +    remote_add
>
> remote_add_and_fetch , since this does more then remote_add .

Ack.

>
> > +    git subtree pull --prefix dts/upstream devicetree-rebasing \
> > +        $2 --squash -m "${merge_commit_msg}"
> > +elif [ ! -z $1 ] && [ $1 = "pick" ]
>
> The non-zero test is not useful, just add missing quotes around "$1" and
> compare:
>
> elif [ "$1" = "pick" ]

Looks better.

>
> > +then
> > +    remote_add
> > +    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ $2
> > +else
> > +    echo "usage: $0 param1 param2"
>
> The param names could really use improvement, instead of 'param1' that
> could be some '<op>' and 'param2' could be some '<url>' or something.

Sure, how about the following?

'param1' -> '<op>'
'param2' -> '<ref>'

>
> > +    echo "  param1    pull or pick"
> > +    echo "  param2    release tag [pull] or commit id [pick]"
> > +fi
>
> Please run shellcheck on this .

Sure.

-Sumit
