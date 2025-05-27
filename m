Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB1C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 17:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D3583156;
	Tue, 27 May 2025 19:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GWvz5LrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD75D8315B; Tue, 27 May 2025 19:34:34 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F28A8313B
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 19:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4064ec63b16so1448209b6e.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748367271; x=1748972071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jJ7zMdldkGrR4j6gQWg1R+EKlrhbEMBk712X5UOxMoY=;
 b=GWvz5LrMCfbMv74tz2hAq3w10hnBJZ5D/gMAHXBwB6lqqtIjxpOG/LzXWDK674k0dY
 OVIL2lLZUKUT6SJrPtgGiHXR4KDK0uVL9pgocOCLXZnRlUnETVP+7Hotm9LjIizMpKk7
 j8Q9jsy/GW7gZAFj90gFq+TgGrAdOTnn/CFPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748367271; x=1748972071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ7zMdldkGrR4j6gQWg1R+EKlrhbEMBk712X5UOxMoY=;
 b=iD7z8r8xxERCApWkiXI0vGSMIsQdJhOGQSPWQBphU7eOqMXTueLeCkp3nNMITrQOZI
 WSvTW6gO1ECK3ZXuDcJGGFRhgPgiDVUYAk6pvx4z8cLnRaKi0j4w7Vy05m6QmsbzLMHj
 gdMCyf1td7tzyo2hZ1gy3Iq8HLkk+cbDsyQXkGGETM9c7r5u6SRfEav0ZICtYhswJMLR
 RDNi0aMwqtaG/PcUbvDvTe9Za6jBtscDAJty69GI4T3hWYBGti+Ql/uJUXoeJ8RUUa7K
 R8k1kCe9aff+8NwxO1fp+uMUU0SH2NM/LVEPYhoEEVSrCIRrtuAzPO3ma+pzQlXxmyRp
 E8UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzkDjJM6C22E9CQgGVpNW8nsP7Lki/oUk3Oh2foltVFkhOdc4IwloXijoazdZ9ppFV04sl6XQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4djuO1eLVaOMFEzw8BpfywLI0LKBy5YUtT7aKn88Qrigg8ZWf
 5TDQarv+vjExS4X1iOyETDpcnWDsmz+VffNI21oWJIYCrbOOkX+fleO0he+A0g/WEOM=
X-Gm-Gg: ASbGncsPWnIlBbRPE142cGY4UGDFx++lmHXmTBuqBRtt1sTKGObJ2waxHiYTezdg2FN
 c4yuoMDh9SCZgJbZOMtOuCy5KLLYvTmnpliYniyaD12XXioyGjH7aPMxjDa9a5gA3Eufe+fSa+q
 /eaIrykUmyBNck9ysdKKnCwJiKVs0Dof7XWyf7qg6nM7pSDeQ0x7pNh2QpTXNhdx92ANtiADtQn
 PkiMzbAy4UcwqELlJPKiuakHp5LNZrDQsqp8p6Z5IjbC+tx6XLcvhfxHe8tZ+Dtj76v59512HeN
 IDsg4CJewACqlDnWuks8tcDoFFlsEV7SLfI8oRvQRYNQKcg4WNB8CErvKqJZjr7h2/uQQOFQVJ8
 WZepro+9V66+k
X-Google-Smtp-Source: AGHT+IEEG5FYIr4VyrL1B9WzxvwiDPO+K0g40S3L1tL3uaa1pxWjMvlMY8gm8LWjtuWp67C+Fjsdvg==
X-Received: by 2002:a05:6808:2289:b0:404:f4a0:7fbf with SMTP id
 5614622812f47-40646827871mr7973577b6e.31.1748367270887; 
 Tue, 27 May 2025 10:34:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404dc2d4954sm4517462b6e.48.2025.05.27.10.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:34:29 -0700 (PDT)
Date: Tue, 27 May 2025 11:34:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250527173427.GK100073@bill-the-cat>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
 <20250526-disband-cover-cdc6567452f2@spud>
 <20250526145636.GX100073@bill-the-cat>
 <CAN37VV6SLVFmfxjbhs8YYEBpzdE8FqjstNh5Xw+DAUx5tC05FQ@mail.gmail.com>
 <20250526181631.GA100073@bill-the-cat>
 <CAN37VV5q16APZnaS4cEwHaZRUTw7H_NZAMWYc0Wt6CaMzVpjUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6+7+q2Omoe5wpjyI"
Content-Disposition: inline
In-Reply-To: <CAN37VV5q16APZnaS4cEwHaZRUTw7H_NZAMWYc0Wt6CaMzVpjUQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6+7+q2Omoe5wpjyI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:40:53PM +0530, Mayuresh Chitale wrote:
> On Mon, May 26, 2025 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Mon, May 26, 2025 at 11:04:02PM +0530, Mayuresh Chitale wrote:
> > > On Mon, May 26, 2025 at 8:26=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Mon, May 26, 2025 at 10:17:54AM +0100, Conor Dooley wrote:
> > > > > On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> > > > > > On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.=
org> wrote:
> > > > > > >
> > > > > > > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > > > > > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > > > > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > > > >
> > > > > > > > This PR seems to have made my CI blow up, and I'm not
> entirely sure if
> > > > > > > > that's something intentional or not. I've not yet bisected,
> but since
> > > > > > > > the error is "Image arch not compatible with host arch", I
> can only
> > > > > > > > imagine the patch in question is:
> > > > > > > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type
> for RV64
> > > > > > > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread
> overview]
> > > > > > > > | Message-ID: <
> 20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
> > > > > > > > | In-Reply-To: <
> 20250404144859.112313-1-mchitale@ventanamicro.com>
> > > > > > > > |
> > > > > > > > | Similar to ARM and X86, introduce a new image type which
> allows u-boot
> > > > > > > > | to distinguish between images built for 32-bit vs 64-bit
> Risc-V CPUs.
> > > > > > > > |
> > > > > > > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.co=
m>
> > > > > > > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > > > > > > | ---
> > > > > > > > |  boot/image.c    | 3 ++-
> > > > > > > > |  include/image.h | 3 ++-
> > > > > > > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > |
> > > > > > > > | diff --git a/boot/image.c b/boot/image.c
> > > > > > > > | index 139c5bd035a..45299a7dc33 100644
> > > > > > > > | --- a/boot/image.c
> > > > > > > > | +++ b/boot/image.c
> > > > > > > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[]
> =3D {
> > > > > > > > |     {       IH_ARCH_ARC,            "arc",          "ARC",
>          },
> > > > > > > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD
> x86_64",   },
> > > > > > > > |     {       IH_ARCH_XTENSA,         "xtensa",
> "Xtensa",       },
> > > > > > > > | -   {       IH_ARCH_RISCV,          "riscv",
>  "RISC-V",       },
> > > > > > > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC=
-V
> 32 Bit",},
> > > > > > > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC=
-V
> 64 Bit",},
> > > > > > > > |     {       -1,                     "",             "",
>         },
> > > > > > > > |  };
> > > > > > > > |
> > > > > > > > | diff --git a/include/image.h b/include/image.h
> > > > > > > > | index 07912606f33..411bfcd0877 100644
> > > > > > > > | --- a/include/image.h
> > > > > > > > | +++ b/include/image.h
> > > > > > > > | @@ -138,7 +138,8 @@ enum {
> > > > > > > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare
> ARC */
> > > > > > > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel
> and Via */
> > > > > > > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > > > > > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > > > > > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > > > > > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > > > > > > |
> > > > > > > > |     IH_ARCH_COUNT,
> > > > > > > > |  };
> > > > > > > > | --
> > > > > > > > | 2.43.0
> > > > > > > > |
> > > > > > > > since it is changing the existing "riscv" image type to be
> the 32-bit
> > > > > > > > image and requiring the new entry for 64-bit. My CI job uses
> the system
> > > > > > > > mkimage to create the image that U-Boot is loading, so it
> doesn't know
> > > > > > > > about the new define etc. Maybe it's not considered a probl=
em
> if a new
> > > > > > > > U-Boot cannot boot an old image, but the comment above the
> enum reads:
> > > > > > > > |/*
> > > > > > > > | * CPU Architecture Codes (supported by Linux)
> > > > > > > > | *
> > > > > > > > | * The following are exposed to uImage header.
> > > > > > > > | * New IDs *MUST* be appended at the end of the list and
> *NEVER*
> > > > > > > > | * inserted for backward compatibility.
> > > > > > > > | */
> > > > > > > > The overwhelming majority of existing supported boards in
> U-Boot are
> > > > > > > > 64-bit platforms, and the 64-bit platforms are the ones that
> have been
> > > > > > > > supported for longer, so my thought would be that the
> compatibility of
> > > > > > > > 64-bit platforms should be prioritised over 32-bit? Or even
> add explicit
> > > > > > > > 32-bit and 64-bit entries and the existing one is a catch-a=
ll
> for
> > > > > > > > compatibility reasons?
> > > > > > >
> > > > > > > I've mentioned entries with bitwidth explicitly specified in =
my
> previous
> > > > > > > reply (and there hasn't been any response).
> > > > > > >
> > > > > > > > I'll consider IH_ARCH_RISCV32 a better idea, instead of
> implying 32bit
> > > > > > > > when no suffix attached. We (and the Linux kernel) mix 32-b=
it
> and 64-bit
> > > > > > > > variants of RISC-V together, thus it's hard to tell the exa=
ct
> bitwidth
> > > > > > > > of "IH_ARCH_RISCV" without inspecting the code around. To m=
e,
> it sounds
> > > > > > > > more like "RISC-V, but no bitwidth specified".
> > > > > > > >
> > > > > > > > It will be nice if we could avoid this kind of ambiguity.
> > > > > > >
> > > > > > > (referring my own reply[1])
> > > > > > >
> > > > > > > I'll second explicit 32-bit and 64-bit entries, and keeping
> > > > > > > IH_ARCH_RISCV for compatibility consideration.
> > > > > > >
> > > > > > Are you suggesting something like this :
> > > > > >
> > > > > > { IH_ARCH_RISCV, "riscv", "RISC-V",},
> > > > > > { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> > > > > > { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
> > > > > >
> > > > > > I tried to implement it like on ARM64. However the problem is t=
hat
> > > > > > while on ARM64 it switches to aarch32 if it encounters an
> IH_ARCH_ARM
> > > > > > kernel image, there is no equivalent mechanism for Risc-V yet.
> > > > >
> > > > > But we don't even want that, since the current behaviour on a 64-=
bit
> > > > > system is not to do anything 32-bit related, right? My 64-bit ima=
ges
> > > > > created with my system mkimage use IH_ARCH_RISCV.
> > > > >
> > > > > > Another
> > > > > > option could be to disable this check in the bootm flow for now
> until
> > > > > > a similar mechanism is implemented on Risc-V.
> > > > >
> > > > > Why not just allow IH_ARCH_RISCV to retain the current "dumb"
> behaviour
> > > > > permanently, and only implement the strict checking when the
> explicit
> > > > > width types are detected?
> > > >
> > > > This seems most reasonable to me for the current situation.
> > >
> > > Ok. In that case, I think the patch set needs to be reverted.
> >
> > Please post a revert and Link: to this thread, thanks!
> Ok. I am wondering how this problem can be solved as there would always be
> older versions of tools or images etc which won't be compatible with this
> change.

It's only been in a -rc release, correct? I'm fine saying no one should
have shipped that.

--=20
Tom

--6+7+q2Omoe5wpjyI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg1958ACgkQFHw5/5Y0
tyxG0AwAh8CRIwqDh/VEbkIkeJRp6zi4Lx6Jmdg7qp5CBCkciSsfxHgrwFSsxP1P
JUfARy2Dej3dl+04CC//bpVv2p03+Lrre8l+8MTfa2+PY7jtJ+5WYdRG43z+5fr5
0ClnKg3PQo+6oBXJpykf68KifHu2RzjGjlyDuY3NuMCdtG9joflnsHgAqZTQ5XI1
wf9DEWRZKTr5ZipIP71ZHVzcq9hF9njZ/YRJDKbzRDdZWH2wi84jUIS8Kg8CILmA
+20XMJOhVxAO1y/W/YLFgOdggpMFHbmuott57lN0/p4L1+IoWtiNZRGASdH9pdBn
w/ev8JJBaUI6J9IqJRnaqcTdtIyFWrWI/2UmLyW3QktQIRfayygc0d6btS0C2qs+
SKWK5Jc5TuWla8946+f0YQq6ZkB00+PS/ypfm6K0DoJXolOC74qIHk4qqFLBkhSY
VQbsS4vpG1jYiPtqf1JDGoYElUU+uERFmKIwmKR3QZjGy4hwuY54dbRYn8OUJFvJ
UxVN3COa
=osFh
-----END PGP SIGNATURE-----

--6+7+q2Omoe5wpjyI--
