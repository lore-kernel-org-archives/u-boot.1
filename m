Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E9FD0E6CA
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD36892DE;
	Mon, 21 Oct 2024 10:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="g3bFSz8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC91D892F7; Mon, 21 Oct 2024 10:26:51 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE3688B4B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e291cbbf05bso4043254276.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729499208; x=1730104008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyqzMIEpp4jRJ8NQc0niwtx3//WyTsOS6NDlUpmRPaQ=;
 b=g3bFSz8t7zYvG8bdGhmv5If2Hrqo0bD5gypFm6mS/fmK/VgUYPTq81s/E57Rl4EdnA
 YWJV7pHkbNqmbke8LZ4e+gVNxQvTK/Ikhy29iYsfbibbjDUbaWON6tDuRJctM2+yolC7
 7X138P+3FaYDeiCB8WFr+uXeaeDw8g6aNH/hcHVRuLkiJ62Aa8uEJVUG11YyDAIVwvVD
 9SGuGSvuu4VsBDPxymjfOGxId7O/vtl93RFpSR6YKNlFB4g3weAD1KIbin25GXSGQfCl
 t5nqNz5Jvxn20J0QarKJ04l+JScgQs3hHjN3PyN0Pd08S8mEa6VvxWXcpP2lFGKyU7G7
 AmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499208; x=1730104008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyqzMIEpp4jRJ8NQc0niwtx3//WyTsOS6NDlUpmRPaQ=;
 b=cyXRPDleOeI8lk5itLQ1zf0nFi349D9XlMRcK03uIQAvueIBCTgyEz2Mcr/cJD3Ipw
 Lk6JY/wVDpi8Y+oD/Cq0Cqd678gmSDIeB0IP8CCDX7gLEwgDIHsvSW8pcwyGUgs8hvk2
 FBscY3VE2pnSE+cbmYPWorR/AlhbatralzQOku8/pSkh3rYYlDZL7MldL1+4THlcdjJW
 Lf86P6JgIJ6BWugBIfHNhlsb1AMbACqJYWWw3oHERJE7kkf0W5OEkhhmpJCm4X1tzmpz
 fVNeSbpm5Bt/1YMgOF1yHGqtvvneSGqX0nZav+f/bk3UzUCyhUprlulSsNwAQFNB+Zga
 XSHA==
X-Gm-Message-State: AOJu0YyOpdUDlXBEtdNMA9q34FbmYIZMWCnsWDtAM3QqtjUkPT8DUl2O
 EstzGywPsQpjGN79nyMhs/VY/x7DNgmgcNLZjLV/s5yEIPUCRElwZvmRFl4stqkT7o8/ghcccj1
 PZ8//nbW5hegD4kmH9pT4TKF9sYfIFn+1YYyjJA==
X-Google-Smtp-Source: AGHT+IHnIvuqu3YYS74eKl53uayBWq9bK/JoAAVMxGnENdLNM835JvQTdK2pOZ6bunwh4foYgB+IJzN+/djXOkQIBh0=
X-Received: by 2002:a05:6902:2b0e:b0:e22:4f74:9590 with SMTP id
 3f1490d57ef6-e2bb1428d1bmr10087863276.27.1729499208392; Mon, 21 Oct 2024
 01:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
In-Reply-To: <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 21 Oct 2024 10:26:37 +0200
Message-ID: <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

Hi Simon,
On Fri, Oct 18, 2024 at 1:18=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v9:
> > - default to BLOBLIST_ALLOC on arm
> > - Move default for BLOBLIST_SIZE_RELOC up
> > ---
> >  common/Kconfig |  2 ++
> >  lib/Kconfig    | 15 +++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
>
> This is fine, but please disable it for snow since it needs the FIXED
> option for now.

I cannot follow. What needs the FIXED option and what to disable?
I run this patch on the CI and test_py_sandbox tests are still working.

>
> Regards,
> Simon
