Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9931BC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B3F5605D4;
	Wed, 19 Aug 2026 14:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCbsSMaMgTNC; Wed, 19 Aug 2026 14:57:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787151466;
	bh=qZoyLsgA0u3CwGqgnbKRtGbOaLsTBdUKfNnU9s/uQ5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0qE2/bCPBbIZ9zkJFUz46Fze+o1wfQYefHY38l44pgbWSm+NWBvhZ0kopXSG3h6zD
	 +5bszJxs+3g4PbyxiqCy1MjCb7V9BcHoYH59kEf23GBn+UhZ6ua3R2mv34L3r99Ztu
	 hX9zfWFHXFI5YFQUTlm9wuNA2Cd0TgiptK9uL+Wwj+RRkHHWA12wdZdKBead7wHRWu
	 qX1QRwGxHWeexdmMylIeCPI5NZWB3/WaCLBW7K7tJfeEd74cEYWXLC5k34gefV86Rb
	 sym8l/C2WBaGpWbCZqiDj0qRyMTX320tH1l6it1AwXXB8TPOAOQ4Qxc8qr9DXe1p02
	 hl88x3b9DlKDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD533605E3;
	Wed, 19 Aug 2026 14:57:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C5FA3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DEEA40093
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCuZFY01yT3z for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:57:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=E7yT4p4s
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FC094002B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:57:43 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c67a73eb7so3186536d50.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151462; cv=none;
 d=google.com; s=arc-20260327;
 b=YQYP/W56HaVMiDgNHaAP+NF1LQJVC9TwJ4I/NXg5i8cmPbcsLt70c5mYmWMHKom+A+
 52prQp+R1eo/Y3fR5UrCPLyjZr4xJMljwgyK/Ux3+lSgeRcG9TpRT2xsb8pnwtN6DXl/
 QTo0SaGpwfQAJHwxpXi4ZvvadSVDKPzsAskNPyDhaG7f3wrz0GMaIDb15t3c5C7GwHzP
 JES66cS5ZWUaAutoiLhwPimK8rKihW7+wzDurVzLgGXktAFk5A8fhqYzCA8DX9xUgbKX
 VSvCVcRvG921bzWY8uazubS0wniNM9Yd/N/neelEmWzQBqTUO/C/2BKCOWvQbmGoG79k
 Fj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qZoyLsgA0u3CwGqgnbKRtGbOaLsTBdUKfNnU9s/uQ5M=;
 fh=lO9g+rTj/Uy7OCCA8AL9ImSXq/xc87njTqTXQWmK988=;
 b=iEspwvKG+P19V44XfkAiBhvyk55Pk52PRk/6cB/LNJeoxb/w9Xq4DKZPMsJCRhM4sm
 55j1G+r7Fa6zQnBNQ0hdJRxPdaky+8ThFxq6RZom2qXMnIRE77R/Ohzg/fQlCluztGnx
 oESXAvk3FUUlz9UUmWvwpKNC8ssbqe4nIviIVMP1R92eQstUdmgq15Q042wOB8QaHbk8
 BBNEtmyTHmd2eVeJvZdrerkWqZWUzMHp/NBqj58EM2YAin6InGKJH811T8xOx4wUL62M
 ETSntdgWPr+Lc2Z42ePeoCIsbczdzoNjZx5oSJc3ylkT+TS2y4a3nU/T42foa2TfOfMC
 iUlw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787151462; x=1787756262;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qZoyLsgA0u3CwGqgnbKRtGbOaLsTBdUKfNnU9s/uQ5M=;
 b=E7yT4p4srWUG91H98/mCNzNZBx1tvXL5eeVtl0lofLre3hBWyQoAmKJlTFyKB6IZiG
 Qpu6Xkce0BWbVkWq9UVDT8/2Mx0aJIrpc7xmPAU050vqQu0yrwln6T/pcerhBQgBzWYO
 Q9QgrnGjopPglRjZAY4diPPn7nGNnZlxhiEg9ntHc0aZFTPkyJqAEQNMMh7BkC9ZVVTW
 PeZ6VPznEWDNqRhinamFo8oxVfK6LEet41Z9vLtxP544WWMtze4ycZRYdwBxYJSuwDif
 4z8oOXJ6QwJw3zffFlTX4qIBNy3Zr9MtSBM45xXCZhj/XrG57nbBEe2+6wf2pzHl7Xmg
 0i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151462; x=1787756262;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qZoyLsgA0u3CwGqgnbKRtGbOaLsTBdUKfNnU9s/uQ5M=;
 b=OJgiXC/jvna/pQHAOvrKxTNBkPn1udJPh6P4syWEwDshBUAQgfY71Y5dyc0ECWctoc
 Au+sXRHi4NDIUEQy9kCOYs4LOJYckSMv7W3MX5pMoIz3bl9WUsopNj6m4v6P1LSpwGLq
 4AR5bWdPM6TfhXUv9uFzTswUHGvt6qcdjkCcqRWOtyhAQMsepx8FpKhgsr1hCBjzjEGx
 4DLiz/Y/VSEzkJqyq8jbI9yj8wTaYHQw1hd7J+FrWk61GCsdjDxm2korz0BvvQvNxD6q
 b4asaEQqunxQwk82mM4UXyXHxkuw9kqTvNQlZdx7Dmz6MjMMkTmXLImhDX3SbZukiLtF
 s1ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAE9KNr/Ryhwgqg14bMkoEzvV+B2lT0vyqjGkHO+YNSDm7Gj/6NwBNP/G8I2p8hTXXWCxwgZM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lnBNi7XhOHZ0hL7FWQXfk7nd/rkxWeh0R7SEyAq1V13QUqBaOR
 coFiSzxynu/9K5GVEZI/gWhalDbyQfv7V/8vpunLxau7dNQNFLQ+tLz5eg1ddnBDAX0YS0UZQxC
 HnC8zvcb0JrUG7qHjUQmuEU1DoFgWxGHmNSBmHe6cpz7eZa8f6RI01k8=
X-Gm-Gg: AR+sD13PAHxMjyuWTVS7Jid0FOhsyZyY/u8ly6zJBcFr3qIbueI5cqyGHXTRUEakUHi
 f4P+HI1ZYFdgNFz8cFXXdnzdjWzop9Gnl4KXtU5H8EGYpO6HsmrbpcM3FEc1V8/PpCnrt6KyPVI
 OOKIg5rssCw9jKVFiB8GZDJ70RCWy8Eao0glOzw29bcaHhllMIjx2Dcnsj8m0KShqQux0k9ddKS
 Ajw1CRmqF7eZemGeM7+HfsXLoOMFDwdnrgreWYRpbRg69886GYH6VfSmy7XxveN43VLL6SGkz4m
 sEpBKLIxwWn7o0Qt3Yc9wz535OhuR/SqI+D/EuiNgcliL7yU5rwA/YmTbnG2CHsgVdnuVUMNVVc
 =
X-Received: by 2002:a05:690e:4814:b0:66b:32bb:740f with SMTP id
 956f58d0204a3-66ccb1d8e2bmr1576038d50.0.1787151462565; Wed, 19 Aug 2026
 07:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com>
 <rxsu6crqaqxylns2vw5trz4fzsis5w4j36ovh5u2fp3ajj3k2o@oolpt5ilpoxc>
 <CAEev2e_=TojrBbrfD0ZTEGJvGS7XUA44ZruOL5NfUPmSHE054A@mail.gmail.com>
 <3q2w5dsgdii7eeeq5mq5jxempshgw4hagagikmvpigxnnounxd@d5rnytl4gkbu>
In-Reply-To: <3q2w5dsgdii7eeeq5mq5jxempshgw4hagagikmvpigxnnounxd@d5rnytl4gkbu>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 19 Aug 2026 09:57:31 -0500
X-Gm-Features: AcwNN1VFKFsF43sTERnx2-vVBGzOKDwOWRGE9cJRMoEmYeKVpgnVLZhcAq8XIzc
Message-ID: <CAEev2e-gvsjtwuJKyFB8RdEJM-sscLT3SUtY7eUaWCKdU+b_TA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add RISC-V IOMMU driver
To: Tim Ouyang <tim609@andestech.com>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Leo Liang <leo.liang@sifive.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, oyst.lnx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tim,

On Wed, Aug 19, 2026 at 12:28=E2=80=AFAM Tim Ouyang <tim609@andestech.com> =
wrote:
>
> On Mon, Aug 17, 2026 at 09:18:23AM -0500, Anirudh Srinivasan wrote:
> >
> > Hi Tim,
> >
> > On Sun, Aug 16, 2026 at 7:20=E2=80=AFAM Tim Ouyang <tim609@andestech.co=
m> wrote:
> > >
> > > On Mon, Aug 03, 2026 at 03:06:12PM -0500, Anirudh Srinivasan wrote:
> > > > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > > > specification. This driver sets up the IOMMU in bare mode so that
> > > > peripherals requiring DMA in U-Boot can function.
> > >
> > > Would you consider adding support for SPL?
> >
> > I don't have an easy way to test this. This will have to be done later.
>
> OK, let=E2=80=99s just move forward with the U-Boot proper part for now.
>
> > > > +#define RISCV_IOMMU_DDTP_TIMEOUT          10000000
> > >
> > > Although the timeout aligns with Linux=E2=80=99s, it may still be too=
 lengthy
> > > for the bootloader stage.
> >
> > What value do you suggest? Seems like none of the other iommu drivers
> > use timeouts, so I'm not sure what to pick.
>
> I think a one-second timeout should be sufficient on real SoCs, while
> three seconds should accommodate slower FPGA implementations.

Thanks, will change this to 3s in v2.

> --
> Best regards,
> Tim Ouyang
