Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6686AC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 05:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D1A838FE;
	Fri, 25 Jul 2025 07:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5NE3zvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2928390C; Fri, 25 Jul 2025 07:07:52 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F439838FA
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 07:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60402c94319so987134eaf.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753420067; x=1754024867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lsOp9FW4rm36tz9o26DktKx3tbBv9aioe08I2B3B7cM=;
 b=D5NE3zvgXkEp1HZPCYs+qPluYDszRzZMA65dpxW7Q5XnUDGJvP8GDMRIwVU+k8dCVl
 /uIXSJW7zQKyoQyU2rT8maUlOEzELRvcFF+//lJtp6yW9lIR6mjI2KoUPGaGswr7fH4M
 4n9ENIBZah1XXza8Ev3QFheEWzn2m/HqBpjuH1FLTAobVH7wPgUVofsEDSbZWEWhPGUy
 MUuwM4MOwXXCbrRlJSSgCo+HW/epr46TPC16e0ixDGLTTa1dk0GCF7cKHkx5BbYJCyyc
 OmFtxcAeU/Gvg3WjbkoTZn2Hnz4E3urU6iO7xY9SC5qsupqmtiWkgyhhWTQhstCeHafu
 h3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753420067; x=1754024867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lsOp9FW4rm36tz9o26DktKx3tbBv9aioe08I2B3B7cM=;
 b=oVA9HwUm7D+J5D+snIC2n6fGcyvx1u3/s/br0qCgLN1KaB1wzN5PQ+bhq5yJ14d7l8
 7EllruVDmNDNr4mc9TGHa8wQVfEAJe9Dem1qLtJNzt0LUETR+Xy05wWtp/MRihSFroJP
 qA/T9ROKG2OPhOPJ7b/Y5bnfIEzTMr/kc6ZNIQZJ9DqAsYCIbshuCRRfVVVE0BoIK28A
 9bJa7edKxz/3SihyKRhsUshZB124f5sAx1npTejsCceZtc+Llrc9kmQQiH6E9WydnwZ/
 2I57SCIHO+cGT5SjeYakKnuORZe5ThXHjRAxrZUVRJrROKcSAtyux2u/gLOz6FXwji5/
 Lgsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ18iyAWJ+pblQSCvDkG/baXowCcBfl4Pcv0JlZ/4RNfJhUgjCNsu0bLI9eWC8bWygO4LsBOo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+wGNp9hnBBHCaqrtUaQnAX0sb1bKFwwocirDOzNjtGcNv5VqA
 vF/WIOVkayDhZiEjXZiuX7yY9EaJh9UCxQAODMSwkAToCrx6wfoZSUv/LlxzSKljQ3h2pQW20GI
 TFhTxjRqeHX8Iv9VlcYI3zrn1Ff23xgg=
X-Gm-Gg: ASbGncsYQQGMp/DWUDiGMkORzCBxywkFlPzN6UiXgUZ6x2KGwy0Bjk8X6F90YgBYhTn
 aBVtlWRvfr3MMKpmSPY1yW77DhqFNubPmUDZYkJMNjGVJWmLT6UIDpsgv68QXOPFZhVFLSsBWq0
 AfUo6zSB+YHZDSJfArDwwB1/vwLv1ctMFko835qq7iDAAJ62seFPIk87h/eQNKJOdIXAvQEk5Ah
 /2DsURfg108rve3jCecpoK5SkOWhLhT+G4ixagG
X-Google-Smtp-Source: AGHT+IFkBDe2pwzWlt3vn3RO8+ToY+X3hxWN0pRcSQTvp1xncg4/B4M4B4RSiSD6TL2r05cX2WEUnUmWa6mPxp6JfPw=
X-Received: by 2002:a05:6820:2918:b0:615:f834:2eb5 with SMTP id
 006d021491bc7-6190c9b7959mr230316eaf.5.1753420066809; Thu, 24 Jul 2025
 22:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
 <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
 <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
 <CAPLW+4=gdMZqoP3zZn0Dk6p5GY4N0pCDnKsXcqtLK41P-Qqu3w@mail.gmail.com>
 <CALrBrZ2Rouk+G9HCS=pbAwxJ76ZvLKhkWp=mW_ztE5R5OPiPSQ@mail.gmail.com>
 <CAPLW+4=W=e0jJhuyKEe02Q_OKVu4y1ReMvQLQfN61YsUxO7eSg@mail.gmail.com>
In-Reply-To: <CAPLW+4=W=e0jJhuyKEe02Q_OKVu4y1ReMvQLQfN61YsUxO7eSg@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 25 Jul 2025 14:07:35 +0900
X-Gm-Features: Ac12FXyNomroZsY_3Wpx0c2aJ2Aopfc8H7geKrAJG_OKbiOtxFXqQQgCwLF2bIo
Message-ID: <CALrBrZ0eUPZjm1y681B-vbbJtZq+8=T=8xY9aRk88KBLqBU4gw@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marex@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
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

Hi,


2025=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=EA=B8=88) 04:16, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Thu, Jul 24, 2025 at 4:45=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> =
wrote:
>
> [snip]
>
> >> Hi Minkyu,
> >>
> >> FYI: it might not be on your side. I can't access denx gitlab right
> >> now as well. There is some relevant discussion going on on #u-boot
> >> IRC. See also [1] thread.
> >>
> >> [1] https://lists.denx.de/pipermail/u-boot/2025-July/594671.html
> >
> >
> > Yes, now it works.
> > But, patchset was failed to apply on latest tree.
> > Could you please rebase?
> >
>
> That's weird, I just checked and this series applies fine as is for
> me. I tried rebasing it on the most recent master, but after doing
> that I didn't see any changes in v2 patches (as compared to v1
> patches). For the reference, I checked it by applying on top of this
> master commit: 7bf2a52b4943 ("Merge tag 'xilinx-for-v2025.10-rc1-v2'
> of https://source.denx.de/u-boot/custodians/u-boot-microblaze").
>
> Can I ask which tree you are trying to apply it to? Also, if possible
> please share the errors you are seeing when applying this.


oh, yes my fault.
there's no problem!

Thanks.
