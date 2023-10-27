Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A78C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 02:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8794F87BE3;
	Fri, 27 Oct 2023 04:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R3HjtN2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546AA87BE6; Fri, 27 Oct 2023 04:13:07 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4167C875EA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 04:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27e0c1222d1so1291950a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 19:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698372783; x=1698977583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy7XD9G8ktzl46q2JOhT7omaHLBCxT6cNNokO43bVKg=;
 b=R3HjtN2PUNCG2zNvNkmbjqqHsOEkBtSVvCE2mXrwrnRre/MDjB+Ta/rgGZ0d3OnLrE
 QUELTOpWGKDVVSu3WoDX7H3F3JwGeZ3QBqvlYYQ82cqr2QYQ3W++lzLeckSfz3CUmNi/
 qXtj8k80yXlXeKZUnzQIetVLxzQUbiMzr4H8hS9RdDP+P+Slm8czlCGsUCDZuZGEvD8a
 NaeQn2wjClCdkd3zQlTyIfpvXUlbsYDRCjim6hPU4UfsqaJoj44fgoC6Z2O9H5cdTiol
 5uzZbgJYB57EgvzEBNqH9HUnqW40PzvSpBJdZZokPEJP/cvr9eH21Ggb/DlNJySbJoCE
 x5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698372783; x=1698977583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy7XD9G8ktzl46q2JOhT7omaHLBCxT6cNNokO43bVKg=;
 b=iNj/fFp/CchF61jvpinT9BEi1YcH0q7pH6ep0UDpjHz9gNgPQGd8NHkt+/hu/qMD2p
 X6Lpjmbf/V5FaJVttfu53auOA5uZUQJM3icDWyQK0xT6KGojBll9nrJwr/rAvvRXRXY8
 CVZvWAx/ISSlq3Njn+j1YDJamfPKNDtwwGae/oddL9AUuh6gNX8UPItZk4RSuRA0GpPh
 OFBN1rQfIVA49ZpZb0S3Z06NwhPQn2PDtDx/dSpgaWNdM2RlBxqecZod3jGiZx/Yw5iv
 Ofq8u6Gv+fCTlJaG6Mw7z62AFiZfDpk2YWd23qgF7Ou0kn+ANbWjvLlwtzBwA4bzbvCG
 skSQ==
X-Gm-Message-State: AOJu0YwAfTXWLG+LKv34tLijMOIsAidM2dYme0wunL7veBBdKBm0X1q8
 nwL8kcJnpmlS4UxkjzEpgF+oebXahOvubx5IkF+AUWs9
X-Google-Smtp-Source: AGHT+IGrHEIpO3gcK7G0GfBdjZH0U2BI8Awuj3Gzyf/+AEOhGWhzNHRuKCVmvF0168c5cmgdMpBfu5Jd6OXMEb3zw+k=
X-Received: by 2002:a17:90a:bf07:b0:27d:1df4:26f3 with SMTP id
 c7-20020a17090abf0700b0027d1df426f3mr1234542pjs.15.1698372783358; Thu, 26 Oct
 2023 19:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231025231311.8701-1-aford173@gmail.com>
 <20231025231311.8701-3-aford173@gmail.com>
 <917ce30e-d737-4881-92ec-4da29e1cb8ad@denx.de>
In-Reply-To: <917ce30e-d737-4881-92ec-4da29e1cb8ad@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 26 Oct 2023 21:12:52 -0500
Message-ID: <CAHCN7xL9S8QxUL96L2+j5GOV_9Ka1D7=J-ROVbjF2HYuHYXmxg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm: rmobile: rzg2_beacon: Auto select Linux device
 tree by SoC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com
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

On Thu, Oct 26, 2023 at 8:44=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/26/23 01:13, Adam Ford wrote:
> > There is a function inside the board file to autodetect which device
> > tree is needed by U-Boot to properly load its own device tree, but
> > it currently defaults to always loading RZ/G2M for Linux.  This is
> > not correct for other SoC variants.  Add board_late_init function
> > to query the SoC name and use that to determine which device tree
> > is loaded for booting Linux.
>
> Can't this be scripted in environment instead ?

Do you have a recommendation for how to read the SoC type from a script?

adam
