Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10313CCD193
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 11:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA3D832AD;
	Sun, 26 Oct 2025 12:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EzjbwC0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB5983623; Sun, 26 Oct 2025 12:29:05 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEF782E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 12:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-378d710caedso40954431fa.3
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761478143; x=1762082943; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynTadvmvoc4pSoY0OewF8in8Z1Yuq8/00xoZUqgg8e4=;
 b=EzjbwC0G0UoBHP4Tp/fDBnPGJaHoxfkV+qv5lpXzrBvRrfLsbWxaw0C6or3MeGPgrH
 IZzkLI3dXkK0pesDyrrfBLxp+dgyt8jHTZWLzXVMjw38HgAuDPqCWWqecVjDTr2678Cv
 xLLdETSXySQSU7w7tcaukGkfKmPt5ifSRrNquiZxzX9hkBrEDtMLHqI+o3mQNrkfZp+l
 dJfL/OUtZMOimveT8Z7ngU8PHSP6syMepsgOxlGkZI6uRig2VnmO+rbteMKZOgtNCUiM
 05AKpX6t/ykcDcMOSjZMPLMZXHR923Rd599jCIPjVZ9mvUVlX/S0sVQZGJPgsvvR0Eoz
 BV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761478143; x=1762082943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynTadvmvoc4pSoY0OewF8in8Z1Yuq8/00xoZUqgg8e4=;
 b=fKzad2mr4slHaFeborCcP13i8UWadkrsoxl0F4SEkOZt6z+OnY6Bt8n8urThGMZiyR
 bkLphz7TREMd3t2H+neRR7TKax/+AFR2+gSFJtGFSyyfRl7QfImvaHRVRjCX6cHAaxtn
 dyMTR0kUGO9osFGA10fuyDaxXPqypOUKqBBoVcdoskxPBG8t2d/YHA93/SZGowa62/SA
 aYlMuYFY8Ti3ayXnvaC4K7rAEstkJZI1Lxx/7lqa0Hw2ngvSR29zHfsOwuraJgqIjo1c
 JXF9bGGQxwoozesjIExZgqpfGU0x3YwQ1GODQWrNEey+RbP/3agUQIbaVhBrjlYLW4kr
 cmbw==
X-Gm-Message-State: AOJu0YxWzMQ2ci2ua5CtmAcZiyWPLGxNDX5Wnllmd05r+04jpfuCsTx4
 4GCj8ZLtZXqrVJDP1t7/GfI7v5QfB4jIVb1IPz9tIV/0TyNqubl7MNwSog2RkFHPnkYMC0BGIZ4
 TogGP9+ayprHh6xLz8GIqYfvZCyU43t0=
X-Gm-Gg: ASbGncuexY7JTmYjsp5psDl0/SNnJJbQDydIPltPumQa/b6sT6TWaxLkLLMQi0AC2of
 rJf2MOihPil0gEzt7iwoOHemDCD9jrhc6ptlNg6YBLqbgPabhDiPGDyUlvxhYUvbMkftVPiLDk+
 F5ds6qVZVWqZLJ3TvCgm71k31E0LhYzVsnnSRliHFZSk4a979TIeh4k14YmG9iFVt7lQ9Ht2Nd0
 +Dq1KKNv31idtXoNJz3DcjgBtLrFYRauUkCKIuRT5KIg7u62Xsec77y9SDj1v3E0tHYW4ZXVArL
 tRyxpGceqSWoymYxpoaTidbzGXA=
X-Google-Smtp-Source: AGHT+IFLKKqmGQ3wE2zzJi6BFxHhDNwCUT0PKVJBwtSnM7rSh6lKQ2j3j5s2gHDX5QVIdMU0dMLp8iU/lF+HZ1MaswE=
X-Received: by 2002:a05:651c:b06:b0:378:d63b:9d29 with SMTP id
 38308e7fff4ca-378e43d6654mr23250731fa.47.1761478142486; Sun, 26 Oct 2025
 04:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
In-Reply-To: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 26 Oct 2025 08:28:50 -0300
X-Gm-Features: AWmQ_bmmMbRvPogXPfX7up5DAniUNizY89HBxZuZ3MVwTIKDOuuzingVzpb60Ec
Message-ID: <CAOMZO5ASxBCdTQFfoUA7k5aXKwQZS+MC75kHw7uHoHsF1AgbcQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
 Ryan Eatmon <reatmon@ti.com>, Alice Guo <alice.guo@nxp.com>
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

Hi Peng,

On Tue, Oct 21, 2025 at 9:48=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=3D21
>
> This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
> platforms. Most of the i.MX-specific logic is ported from the Linux kerne=
l to
> ensure compatibility and maintainability.

I'm getting the following ut_dm_dm_test_remoteproc_elf error in Gitlab CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1274168#L276
