Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56293C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3C6807E4;
	Fri, 24 Jan 2025 14:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HcJETa4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC803807FE; Fri, 24 Jan 2025 14:39:21 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A13EC80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so3008916a91.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1737725958; x=1738330758;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtpzB2nr10kCdDcVqdOFJWQVaieD7ZjcxSvlCml57/8=;
 b=HcJETa4FYC15t8wnuNYMlaq+zWSanZUu/iv6f6RLmw1L1xXuCaouI39ThWr55zQdCg
 tMyKO500X00P2mu/s/3to7ufiGJ4diUR+A99Me3qMA6gdt4L8kUriXaAGcNhz26FdGzo
 ZESkaQq77tBdDzC+cSOWKq/9Bwj6/UwqD1JMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737725958; x=1738330758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtpzB2nr10kCdDcVqdOFJWQVaieD7ZjcxSvlCml57/8=;
 b=nnw53SASYVxayxnm7rv5rKsHiBTHnS6X9ti+T91bgI/x94TqlOzXhSFufuF67PaPpC
 mjWlo+9qqmVrl1E4pNz4Ha5Xx15vOo/Lf8noyRv2zdW2jZPlRnu+zk2D23UpaqGqgaxu
 6tmFuVyJM87fcbtNRnmoabfiy23jcma9yzC75YJ7Elp2S/Yw65KYaqeyUC3eCLtOphxC
 BC9GWfpXUq3KNqqu5Dr1FA29lgNRYabrxRxpNHjFJQnivhiqs1zsmfaaqaPQgWUEkam8
 vImj1iuAqgPK+v/ZK72f37lltuwOqPoB5LFrcHp2DqtK6F1pnVGlW/xNhYbVgHJ1qruy
 qLYQ==
X-Gm-Message-State: AOJu0YzAniwOotJ/ALE5o50r4FzHXV2aGFCshf+BC7xGaVVj+7ueZwd5
 oN8tunV3aLDt+G2ma6wGQ99qlkNsfUo3fWfpfzN8+kgsHA/OqrQutxhFLbO80vFHBelcpJ44k/Q
 SyKFiG6KwEihv+a76j4Gv3fn9Q2Dd+pbfZpKO/A==
X-Gm-Gg: ASbGncsKwYsZAqGZtUWS49Ol+baxxebWP0Zon3TPrLJ+gTz3vyttVIVp1Fqc8sNMCJE
 SjNORE7HNY13TUWu4hgqk74Z2uLDTN0Hvs2KijLKn3+sP8263+7p7ipqPMI0wYHDx6wwZ5dL+ev
 EG4tLEz4F1kHk1jrmAOOk=
X-Google-Smtp-Source: AGHT+IEz+5wbUhLTO7UF6bg/J1LC2gIPd88tVFFDEKUqZ96EE2D3qCrpnPWFYWKyMyEkWCfpqnSQQLFPYuLU75o7Akc=
X-Received: by 2002:a17:90b:5146:b0:2ee:c04a:4281 with SMTP id
 98e67ed59e1d1-2f782c6579dmr38629395a91.6.1737725958096; Fri, 24 Jan 2025
 05:39:18 -0800 (PST)
MIME-Version: 1.0
References: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
In-Reply-To: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 24 Jan 2025 14:39:06 +0100
X-Gm-Features: AWEUYZlgh0CFT1vIde_I2z9RpAuAQ-ki5H8hnTLM6ZN4pYmS9h0vNkal4NKJXI4
Message-ID: <CAOf5uwnhGi_Rdm9jX3EX8U7+R6b9OTF_rAaarkgdC0HBHm2h8g@mail.gmail.com>
Subject: Re: [PATCH] fs: ubifs: Remove unnecessary assignment
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

On Fri, Jan 24, 2025 at 2:18=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Variable self assignment has been found by clang. But Linux kernel alread=
y
> fixed this problem by commit 2a068daf5742 ("ubifs: Remove unnecessary
> assignment") and commit ae4c8081eb77 ("ubifs: remove unnecessary
> assignment").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  fs/ubifs/recovery.c | 1 -
>  fs/ubifs/scan.c     | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
> index 6b6884fb2098..12c0575cc976 100644
> --- a/fs/ubifs/recovery.c
> +++ b/fs/ubifs/recovery.c
> @@ -439,7 +439,6 @@ static void clean_buf(const struct ubifs_info *c, voi=
d **buf, int lnum,
>  {
>         int empty_offs, pad_len;
>
> -       lnum =3D lnum;
>         dbg_rcvry("cleaning corruption at %d:%d", lnum, *offs);
>
>         ubifs_assert(!(*offs & 7));
> diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
> index 7a6e46df5d90..2335e9e2d256 100644
> --- a/fs/ubifs/scan.c
> +++ b/fs/ubifs/scan.c
> @@ -169,7 +169,6 @@ struct ubifs_scan_leb *ubifs_start_scan(const struct =
ubifs_info *c, int lnum,
>  void ubifs_end_scan(const struct ubifs_info *c, struct ubifs_scan_leb *s=
leb,
>                     int lnum, int offs)
>  {
> -       lnum =3D lnum;
>         dbg_scan("stop scanning LEB %d at offset %d", lnum, offs);
>         ubifs_assert(offs % c->min_io_size =3D=3D 0);
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>



> --
> 2.43.0
>


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
