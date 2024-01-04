Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04942C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 13:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F538788D;
	Thu,  4 Jan 2024 14:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OqPudvKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2830F876EA; Thu,  4 Jan 2024 14:22:50 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCBD8788D
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 14:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7cd3880e86bso176288241.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704374563; x=1704979363; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Asv8qeswAKq7BKnD8orOSDPcF1sohzHxrXvdZv0mnJc=;
 b=OqPudvKwTQC2WIcUMuPLffUh+/0Qg2JKWHPn0k3GfcPTelwHj5TxIlRVeg1nLG5zmO
 MaSfz22Ue4ap47ziDeRC+rWZW3WMf6y+44cmGEu1VAf20/i1xpjOwo/ieSP2tcrkwGeP
 rLJ/03VVwmaVg0SBs+rfyxSnvzT97F0oVwKdpleySM8oyPuHYvIVoWa7hk4BOoSrdeCe
 tXBumAMjjvgSQh6JCmajtEBO8vsTRH42FEBl3T7UNX6kvLgnrkja96jd9Ty4hOrzx472
 eDIpotYea2Qbl1Id4IiaFAFJBBBcwQPD70zrlc4kNk/aigpZHRJCMqjSSh2uE/eC+PgM
 u+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704374564; x=1704979364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Asv8qeswAKq7BKnD8orOSDPcF1sohzHxrXvdZv0mnJc=;
 b=O3zfqnoXhnTHPtIn23Qvc9BaIl9wWlNXMSRoN6wMRV8dS5qW72R5i/KwgmYFxyVcPW
 YHqM1Xq5k+bHI7JC2UIlIhIS0dVYlXGk2Bw1D+wU4U1pdQakXzPcvdrQpjOvj9+/Xe6i
 vr/noOzyDbzl/uBRNYOoOs3yxIYdqeS4sQf1FyrDOqWN9AAC3KU/UT7pS0fi+CMDVixj
 0ZijSoBx5no58bFBqRxfmWDZZQtHQjcQcmXWJOXFFjMKl9/x3Ou8crdvj96tqGag8pE6
 N++UeFUPaEQ6tz1nYZmkSVt8zD7OITMRsP4DRFMYWsxEBmBzx8VI51wnZuxNZhTZqUOE
 DmpA==
X-Gm-Message-State: AOJu0Yy7YcngIBKUSntNxvcOCu1GeQDgA+OhVr1RbyQuK//15oFBMV+W
 kY77ngdXAaA2dqIxWrwDVriHFPj38Cp3sfTlign+8rtHsKqWnA==
X-Google-Smtp-Source: AGHT+IGdwk0pHmNwzwuC7yddW7jwpIUi756aoUoeTp0g3JBbUqOrpeHlcKuiLbYu4H4nRUy7jrmpdz1S0Ahnh8BflF0=
X-Received: by 2002:a05:6102:cd0:b0:467:504:a19e with SMTP id
 g16-20020a0561020cd000b004670504a19emr362819vst.32.1704374563696; Thu, 04 Jan
 2024 05:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
 <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
In-Reply-To: <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 18:52:32 +0530
Message-ID: <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,

On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 1/3/24 17:32, Tom Rini wrote:
> > On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> >> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > [snip]
> >>> +In order to maintain devicetree files sync, U-Boot maintains a Git s=
ubtree for
> >>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It i=
s regularly
> >>> +kept updated with every new kernel major release via subtree pull as=
 follows::
> >>
> >> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> >> had in the original repo). I don't think it's relevant.
> >>
> >> We're not likely to regenerate the tree, but any clue what 'git
> >> subtree pull' would do in this case? It could happen if we switched to
> >> git-filter-repo.
> >>
> >>> +
> >>> +    git subtree pull --prefix devicetree-rebasing \
> >>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> >>> +        <release-tag> --squash
> >>
> >> I'd put this in a script to run. Documentation tends to be not quite
> >> correct. A script could also be smarter and figure out <release-tag>.
> >
> > Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> > something using subtree, I do hope to learn some lessons from what you
> > do there. The first thing is that given the size/nature of the commits,
> > I had figured I'd be the one doing this as a subtree pull+squash then
> > push, rather than posting to the ML since it'll be huge and
> > un-reviewable, but with a note sent off to the ML that people should be
> > aware the next sync has been done and retest as needed. But Sumit, were
> > you planning to do some of this instead?  The second thing is that if w=
e
> > move the subtree part in to dts/ instead (where we will still have the
> > Makefile/Kconfig we have today and then our Makefiles within the
> > directories, this might get more complex and so really require a script
> > to keep it from getting error prone?
>
> I played with this series and didn't really have time to dig into subtree
> mechanics but one thing I see is that when squash and merge happens you c=
an't do
> simple rebase anymore which is time to time very useful.
> I see some different rebase strategies and --rebase-merges option but if =
this is
> adopted it should be properly described how to rebase u-boot tree which c=
ontains
> some subtrees.

Did you observe any specific difference with respect to subtree merge
commits (Tom will likely do those in the beginning of next release
cycle) when compared with normal merge commits when Tom pulls in code
from different custodians like one example below? The same rebasing
rules should apply to both types of merge commits.

commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
Merge: 2b28c3b871c e266d273114
Author: Tom Rini <trini@konsulko.com>
Date:   Mon Jan 1 12:38:15 2024 -0500

    Merge tag 'dm-next-1124' of
https://source.denx.de/u-boot/custodians/u-boot-dm into next

    support propagating supernode properties with bootph schema
    align bloblist with v0.9 of Firmware Handoff spec

-Sumit

>
> Thanks,
> Michal
