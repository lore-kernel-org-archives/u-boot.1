Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526CCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 17:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0808329F;
	Mon, 29 Sep 2025 19:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpPWSmsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4943E833E9; Mon, 29 Sep 2025 18:41:30 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30148319C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-74435335177so82937087b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759164087; x=1759768887; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/9FxL4a0+nLRDYoR89J5uO43dYmWXxEvqEMMuAtGN8=;
 b=RpPWSmsmCGo+UfQxHQNh+QEX3O6zVkd74Ta2j07DT2TyBVAAVy62PmdD4wiMRBqcOu
 RBLniFDuyJBIxYxTrkvpPUhG+DWcpHLzMLvXpf7DwFE/lroC/UJxjNpenJwwkv30TrzZ
 eXg0iymGOzMGNzL3GNIY/bs4feQT7xBWfXFWOulljCIJHABMKin1Fy7uiq4+1e5BNTdJ
 8vf8rXNJrFX+ZqfMZSePrnXCqqatPf28H7nP/hTDQEJPIiqgZ+WMhPVCYWJCIB6aSWzM
 0LaFOZYVn4/mjdHLrk7FojJmTX0rzhWeMGocDeUwxa4SB5J5Y9u5J5jG01IXbIm4INMo
 Ln9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759164087; x=1759768887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/9FxL4a0+nLRDYoR89J5uO43dYmWXxEvqEMMuAtGN8=;
 b=fmVNu1z9JMDlgKKunZTW+sLAvqOrd2+PGxt6fG4F5lRWURl102WL7vwkUBXbQyCnK8
 I0m5zS3jlhn/4/VAAdGFVvQBaLW/wff4eM+QanAfDIStup0gwcOBzjXuiztfv+jAWZru
 r1+Nk7DFi3LEvTJ2yZZuFdIAC2rukdnXXPp+W/ZkSFU/FbB3JxueE6A0LqOnOI3jo7Hr
 cI8thYYxdDpQA/mnDhESVr5TGHFvrPkgOsMs58C7Xxhs+paeUSuMcjGUvxjEgfKqJUrn
 jRKqPdIXlJ9Y0BgjXyi9nZ1pQE7lq+hWaaBgo4Cl4eCN9wt3P7R2G9RnEdWM2uEi3xhC
 +5iA==
X-Gm-Message-State: AOJu0Yyqt1MhIei+RzViin2J2DRSyFt96P0ZJkS0ZuclTrFOWTx5TXG1
 02keo5uBbpdoQN0aMMc3XbCT2N2LpmytzZ5PRt4XyKg2iXeGnMfVAliq4+R1vna8ehdoDkI4Syj
 SwQUtKW1vkIdZqC5SEvRFqwAD+2gRD6Baqg==
X-Gm-Gg: ASbGncsFKFw1M+7IrEOwPjTFcCyMIeD+LBNO+n11rRIAldQl1LeFzMpBMCTa6xi8VqD
 mS8d/a2lFOoN8QDZE1RUoIrHBRum/v/xw3PQZ9tUOJ6XWqIV7G2MYyKtS1Dta+nXngXoxIXsghg
 ykKWOJW7B0RPy8GW1scKWx6kuunVGbLKEldgKPQMAHCpWEWvB1BVAgZ/Zg5oy7aIEu5pLUkJ+59
 2xFIHRtTvhzfTHhDg==
X-Google-Smtp-Source: AGHT+IGc3xsIHtG17+OaHFV7WmylO9QtLB4/fTpXivbex2nJKivF+Lm/ZZwl18+ykBYw8nnTfXePOpD1LFcKxg4ICyA=
X-Received: by 2002:a53:b10f:0:b0:633:b317:9cea with SMTP id
 956f58d0204a3-63b59a7e8f7mr1165779d50.8.1759164086421; Mon, 29 Sep 2025
 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU2+vrO5KGeoWkDZGOkmL408R6SHqdGhq315cGq+mbq3XBz4g@mail.gmail.com>
 <67073eb8-2416-44ca-a97e-04ab5bcb3ab9@amd.com>
In-Reply-To: <67073eb8-2416-44ca-a97e-04ab5bcb3ab9@amd.com>
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Mon, 29 Sep 2025 10:41:15 -0600
X-Gm-Features: AS18NWAI5pBrde0N6hCJ4G-4nRG2o-s1Tonl3v86x36Em052JnMUKGsgkRhT9QQ
Message-ID: <CAEU2+vpyU5A_UB=y2K7m0UmSX1_U4q-M5ZZiLCK8bajSqCUxeA@mail.gmail.com>
Subject: Re: [PATCH] mkimage: add register initialization file support to
 zynqmpbif
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>, 
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 29 Sep 2025 19:43:52 +0200
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

On Mon, Sep 29, 2025 at 12:14=E2=80=AFAM Michal Simek <michal.simek@amd.com=
> wrote:
> ...
> Not an issue with the patch but your patch is in utf-8 instead of plain t=
ext.
> ...
> Please fix it and send v2.

Thank you for letting me know, I'll subscribe to the test list and use
that to try and fix my settings and resubmit.  I thought I used all
the same settings I had for the old Wine mailing list, which had the
same submission requirements, but it looks like my client now mangles
my email even more than it used to (looks like it's deleting spaces
and wrapping lines when in plain text mode).

Best,
Erich
