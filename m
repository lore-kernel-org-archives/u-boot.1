Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AA4D58094
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 12:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F03788E61;
	Mon, 25 Nov 2024 13:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pn4IxULL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC4988F6B; Mon, 25 Nov 2024 13:50:16 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B42588E43
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ffb3cbcbe4so16898511fa.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732539014; x=1733143814; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfXgYAu5JypgQBvULS8quG9y6hF1DwtUKAcfYp46GmM=;
 b=Pn4IxULL3hIH1PUN4AEERn9Fm0+kzXOV/c/f3C7Y12C9UNusR8PhoNlGD3N7ZkDgyw
 03xS+alZ9XMZkXFJzv8gAkaC9p0NwYK0HrXxNClpFLZoOb0iouUdp39wuY0Wuv9Pr971
 l5B2N/FNu7ka3gfJTRhvy+egIYS05DtVqPZgGQupLRAtb28sf+uHLuGKNZilrN1SPBhs
 Yg5ul42J1mTiKYnGAfIinFkqM2sLT8/Jqh8RpumRDEmrHHyGxKRkcLixo3KFaPPZ6TTR
 0JNm2iu4gDf7VPuHNr/EBpPtxnB9YaPh/pEua/heAKgRSTuR3OpwPT13pddFTg1Zkv6j
 DDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732539014; x=1733143814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfXgYAu5JypgQBvULS8quG9y6hF1DwtUKAcfYp46GmM=;
 b=OxIWFr7MlTgYRB0SrY5WBfjdtdpeXK/Qdrs4hks9bvHMPdH1HhuzQO+dXqQrPQoRR4
 HVG7WwfCtBKtbX4JyzcXiu3FH7HNucJZOqi4MstMgJpCX/ZO+9iblwItQj1jbkaUZzvM
 iWwsNrl57u3gy2WaVn6g9NCKD7k/tr4XyrZb9lIl7VyDob7O/iq+48lPQWAsvKakrZxm
 jBIA4+kDzoC2Hudc9R/Ujm5YwwKXPj3+I5Db7ScLlE5dcch1F4Ju1oqSpiomYM7uhIqV
 6n3HJlS/MZxgrbAu/NIAQkfVsCVEoayKQVBIYoNtwUJkc0Pp2s4L8RhSA/Hg8ciTLyBH
 bKnA==
X-Gm-Message-State: AOJu0YwRsGPIC/srILmFqZcJp3RRCN4SQW7lzxTBzvWXL2hKEDf/oIkr
 MMd6edVs+gYjN6vSeYJ71XQ64yy7vZf/zF/nQC7RwyKa4qgqsN8w7D+PxaO4kz9RAOm6b/NDaWR
 YhmhKVWyxos0Sq2SOAUHwlHr2IWI=
X-Gm-Gg: ASbGnct+sCtEiHRjadeVBfuz+ll1bjOXcXHjMZdyurdhzgz2SkImZMw5Wjr+JiPb0Pg
 e6KnCaAvqNIOlVblp+ckzv7lAbIGKI/Ak6qdO1JO7Nn3KPG2a/G6TmXsdtgQadXja8w==
X-Google-Smtp-Source: AGHT+IFvgNO51hXTbfHgnEBOFX1wjojJVuPjDZLG4qWu0uu9dL03sqwt96vOtCz7R8g+F7iRtAvar8HYAM+QuwheQEY=
X-Received: by 2002:a2e:a902:0:b0:2ff:a4c6:b144 with SMTP id
 38308e7fff4ca-2ffa7180014mr61609681fa.25.1732539013376; Mon, 25 Nov 2024
 04:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20241125093908.50903-1-ldevulder@suse.com>
 <20241125093908.50903-2-ldevulder@suse.com>
 <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
 <ea069f71c6dd577eeca10279ae1ae715011f1003.camel@suse.com>
In-Reply-To: <ea069f71c6dd577eeca10279ae1ae715011f1003.camel@suse.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 25 Nov 2024 04:50:01 -0800
Message-ID: <CANV2PTP4k+LDS-VFeU1_O_ObBYKfAF=BnVPYnnQ7hVCZ2g1Qcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
To: Loic Devulder <ldevulder@suse.com>
Cc: u-boot@lists.denx.de
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

On Mon, Nov 25, 2024 at 2:51=E2=80=AFAM Loic Devulder <ldevulder@suse.com> =
wrote:
>
> Hi!
>
> Oh sorry I didn't know that it was already here before... Thanks, I will =
try the patches then.
>
> Just one question: does this means that we will not be able to "easily" l=
oad a different DTB like we
> can with distri_defaults? I know that we can always does this with u-boot=
 command line as well as
> with Grub but it's not so easy. But maybe it's handled by OF_UPSTREAM, bu=
t I have first to read all
> the patch series ;-).
>
> Loic
>

See "Device-tree selection" in documentation at:
https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html

Additional information to understand is that EFI bootmgr can prefer
the EFI configuration variable (file `ubootefi.var` on EFI System
Partition) to select FDT. There is not much control by the user of
which ESP is selected for U-Boot to operate its EFI environment, so
the environment may change at boot if there are more than one ESP
present.

When combined Unified Kernel Image (UKI) with support for wget in EFI
then there is not any need to prepare a separate TFTP server or media
for network-based installation. I have tested some version of Debian
Installer as UKI and it is easy, not depending on hybrid ISO9660
complexity. I think this may be how all OS distribution installer can
become less complicated.

When you need to make improvements to the DTS then you will submit a
patch to Linux Kernel Mailing List and when merged upstream then
U-Boot will sync to the Linux Kernel Devicetree-Rebasing git
repository.

If you need DTBO (overlay support) then that is some other topic.

-E
