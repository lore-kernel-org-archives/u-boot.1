Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B369FC982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 19:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14F424050A;
	Mon, 21 Sep 2026 19:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Wicv2jh5bb4; Mon, 21 Sep 2026 19:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D86DC403F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790019764;
	b=oJGtiDQESY3uBrgrc7iZrbCKdRvDJdLYv4ps5QcAQMnEb9CU9VNPIjy8PmCp57Jq/xw9
	 hU17GFVJocKKJ9x4gRIasVxERSZhMIX4GnyyLlmGUiQwOJQRnAeDapY219bEo1pxfhgKT
	 gfE6vqd/Jo/oaC2YVJRVW39c3rz4pw/3KcLZdiwogMT+FrhePGnA50kpsChY6xz26DqjH
	 LFyMLijeJMd+lJjVVjcWTaAbJ8w8xPwOgZwWWxCDw3HOtq7MyHJUMBf7rkiubDFUJEhcG
	 IACV5jCtxiBvPl5Nb4qYLjwBnOs4y8V8TYszv5ufeoiC6Bnx3wHdt/vFXpDImJdu5yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790019764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=faf76dv4xYHI+TU9adOJ62x6ba6leykqpTfdMxJuvbQ=;
	b=iRkZ9VkuZvtZ83/fZChoZhJRYhhK1Ngp15U/SzoQRVjcs99YxcouLRUurcCJWymbJ6Zl
	 NkLRfjm65Qn8suZqGKeKPYq+WQqz0bkSCM33pYM8lDyLH3bNLniZainSV6Lrt1L8Lt0Oa
	 Czw4ylT5u38hFt+heW35uDkblYPEEXU96e3DIC2fCoaEIe32Fb12mAPg/+gNKk1hNOYrD
	 G9p62XNugn07dRp41ULNRmbBbcXMSjtHeHrdW2KDky8u88bbr+vroYyujKtHNV6mh6Xd0
	 a57tN3S1VCc5023birzxcJi0kX8/LJFrcldijJM9zXdgoiVLXLKVmg5GznmS9/yvlvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790019764;
	bh=faf76dv4xYHI+TU9adOJ62x6ba6leykqpTfdMxJuvbQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0San4D3WBaDaYZMUgcLduH/IUhbmJK7NCvlrNDBgP6ZjY1eyNdQ/83lVEl2X7vEe
	 JqfPNOZrDZYk3SYlxk18z7ab5+bVbwwogenwFaYr7Mx7yFOB0W+fhwtg3RDsjHgu1u
	 9h8lefYZGRP2Nn5XbpUkZal+hFp6pu8kC3alWmV7KEURJcvAJLBtOgICcieDXY9Cyw
	 6TE8VzB1OAQPfoNrCPC+XKJrIWXFHLUyhDODaeW0yU/Qa7s8iFa70VmbTmkJBafHU6
	 lLhjmqpODZLZqkhuZiYSM5gdBdMCzuGl5bUMmjFwfSYtQhJXQLYCCz0pBH6HU454Kj
	 lZVOip8zehthw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D86DC403F8;
	Mon, 21 Sep 2026 19:42:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2E072D4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C910360705
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id deNi77dy4ijP for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 19:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3396E6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790019760;
 b=FAcDIf+xuLLPtIuX2xO1tbwEKrjSJpzf4jFawtpCWnydkDTfEInLXsJsiukU2FqQGAEs
 mEoSCCtVMlF+6V/RX8xOVUxHrEtcUwvnXxdS7AP0nVlv4mj4OiuoAk+Zz7nEWelTQF+FS
 tw/f3WtQ/TPrqxnGS8dy/swcScz1hPQEmck35mymcpd3HetqM4PhPmJBw0K9kw0lCRLb+
 uSzrrqto4D2FfRbntMpT6c+L+IvaU+3szM4fJ5x7zLy7b5RIBhcAJ6fgS28+PZzKh4pPM
 xmnGC/nVuibVmo1PAnNjPk1Pp8UF3q5gj2vw7kNd201D43ty8Gd2vbRBfsyfjNfQA2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790019760;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=faf76dv4xYHI+TU9adOJ62x6ba6leykqpTfdMxJuvbQ=;
 b=FhG8P9BvwC5Hw1KFKCBsEEu2m6hceIsycHcTmNb4X07BQ9O8rmXmAuESCabRTXOCHPv5
 Hlv74eXtu9p4bwXkmzIT56MDkVOcRwjWBLxg2SRf1+q1wZ0CYxj2OLHriCYfR6ZMpsFuZ
 H615/gSk2SuU+sRzTcwkYuUkGhRHPb3NA0Ui7P0HS3tkltWXES7THzLolm+Uww+tNGKFS
 B4x5Xle6COaQO27IwxmqCK9FCFJRcu9QI9qN1aV3mPJNlXJSAI1GxtKpuja8WfUexTij2
 /d/tpsoWfaI5vE9xZurE4LvJJk5DditKd8ko957PkwunofE7It9t1udRJU3O1EB5wjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=fv6lR1RK; 
 arc=none smtp.remote-ip=79.135.106.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.120;
 helo=mail-106120.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=fv6lR1RK
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3396E6060D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1790019753; x=1790278953;
 bh=faf76dv4xYHI+TU9adOJ62x6ba6leykqpTfdMxJuvbQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fv6lR1RK7ATbCfutNU8WpLNl5zT0F7Ly6EqdkHNs1VYj0m/yE6JhVHIe9o/NDHQ2Z
 rNSzYe7IwcvgpWIRbwz1sBMMjlxFJd8WGYIFaVN0qXs3CzNWD8CH/UgkqpKam0pi1/
 jnZzj4ukfWtyR57bOBuOxViTYii6XPgBGL4JVukBEKnkA9z+pb6n9826jNqPX/xOwq
 9gTgP8FCV7gMfaaKioaw3mP+hpiNbtukZDXzHkC6JzvU3NtW4RHVD/BWEJHOVuv92x
 9PVtSoFYabm6nJyS9rxvXdv0Bmi1Xdi7oiOjMki35iYDYtc4dZNL5CLIy0S6uffzDb
 4hT+Cp++3hFMA==
Date: Mon, 21 Sep 2026 19:42:29 +0000
To: u-boot@lists.u-boot-project.org
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anton Ivanov <anton@binarly.io>
Subject: [PATCH 0/2] test: spl: Cover zstd and gzip FIT decompression
Message-ID: <cover.1790017078.git.Munzzyy1@proton.me>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 929d7ca6ee3eb6c88d7a236d7d9c442cd9a56788
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

These apply on top of Alexey's "spl: fit: Generalize compression support" v=
2:
https://patch.msgid.link/20260918-spl-fit-compression-v2-0-28e946f57357@fli=
pper.net

That series adds the FIT_*_LZMA test pair and enables CONFIG_SPL_ZSTD in
sandbox_spl, but nothing decompresses a zstd or gzip payload through
load_simple_fit() yet. These two patches add the same pair for each.

Each patch builds on its own with sandbox_spl_defconfig. ./spl/u-boot-spl -=
u
runs 29 tests after the first patch and 31 after the second, no failures.
Replacing the zstd_decompress() call in image_decomp() with ret =3D 0 fails=
 the
two zstd tests and nothing else, and doing the same to gunzip() fails the t=
wo
gzip tests. With CONFIG_SPL_ZSTD and CONFIG_SPL_GZIP switched off the LZMA
pair still runs.

Sandbox only, I have no Rockchip hardware.

Alexey, fold these into v3 if that is easier for you. Otherwise I will rese=
nd
once the series lands.

Cole Munz (2):
  test: spl: Cover FIT image decompression with zstd
  test: spl: Cover FIT image decompression with gzip

 configs/sandbox_spl_defconfig |   1 +
 include/test/spl.h            |  20 +
 test/image/spl_load.c         | 764 +++++++++++++++++++++++++++++++++-
 test/image/spl_load_nor.c     |   4 +
 4 files changed, 779 insertions(+), 10 deletions(-)

--=20
2.55.0


