Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A58CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 23:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAB286EC4;
	Sat, 14 Oct 2023 01:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T6ctzfuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCABC86FB9; Sat, 14 Oct 2023 00:07:03 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF1686F7E
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9a398f411fso2856122276.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234460; x=1697839260; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qCXQwnJh1GeSrPIGYxqVHHhecYhXcoGdybtrtL3szA=;
 b=T6ctzfuhCtT9Erb3JctOLt2YpHbE5uB6HJTE9NDKa8/EnroIhYxL+//JehGxpmXiAj
 NHb2n9U7Uk7cAhoHBIhXK01GZf1pOSp9ylssNgn6nj1De40NMMELG0Q+N217HJxqDQHo
 HtyPfehjZ7oWd53hD0hAUYhO5WEzKaho+A6GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234460; x=1697839260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qCXQwnJh1GeSrPIGYxqVHHhecYhXcoGdybtrtL3szA=;
 b=rF1Heq4XOMjzXnIV5p3VUBBczAE+fhxqykDDSKEv/1wO5No7fYGcrdGLPOB0MT3eMC
 MkAzP2GjdhhVCoQNf+kZ4EJLKiSHhxi4KEkt6ctEA++w6+ymnnZQBuFWx3wpYllwlKIY
 3XBzu73ebbE9xuaxAIkxwfqo4jBCJrzQxsQ3390Ip9NMUlsC4CVDPN2bWofO7rk9ZhYo
 v6PBfKHLJgX2DVKqCrevreXDpOjwoQWmZFIr6yPUZ9TmyZZ+6WFDCZ0fX6lSJYUoxKBE
 odr0fwRM4yvX8Ar6avLi523CuzcYP58XqM3paLwzVmrv5TJ1BRtdBfPMCbMN2SRi5t7u
 Nwsg==
X-Gm-Message-State: AOJu0YygNuomjYIKI9zp4SLBJGQOXIOHvvkeUKJPBS1JshwS75cBuYwk
 qhAJ6odOUDleQZM8/gT/P6EMgyrb7bY1xjtZAv1dDw==
X-Google-Smtp-Source: AGHT+IEMeHCMrQi0gyEUAscbIgWQ4j8113VfhrlBWLd19h2Tq7pKowXf2FMN9AYCiBcLYDXXi9Et8/O2NhRF0HJ7tk8=
X-Received: by 2002:a25:50ce:0:b0:d9a:3d70:db36 with SMTP id
 e197-20020a2550ce000000b00d9a3d70db36mr12542062ybb.42.1697234460405; Fri, 13
 Oct 2023 15:01:00 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 17:00:52 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2pCB4K61tcQ-VZApRgM+w36hjpMt8WpQqp5H0BW-tu0A@mail.gmail.com>
References: <CAPnjgZ2pCB4K61tcQ-VZApRgM+w36hjpMt8WpQqp5H0BW-tu0A@mail.gmail.com>
 <20230923205017.1754340-1-sjg@chromium.org>
Date: Fri, 13 Oct 2023 17:00:52 -0500
X-Google-Sender-Auth: bFur05eLNRFwxjJ42YfqpHIkjKo
Message-ID: <CAPnjgZ3jFxTjw-G=x03SueXGahHcSqmp355uts-X75EE-NBTYA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Scan all bootdevs in a boot_targets entry
To: Simon Glass <sjg@chromium.org>
Cc: Date Huang <tjjh89017@hotmail.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Sat, 23 Sept 2023 at 13:50, Simon Glass <sjg@chromium.org> wrote:
>
> When the boot_targets environment variable is used with the distro-boot
> scripts, each device is included individually. For example, if there
> are three mmc devices, then we will have something like:
>
>    boot_targets=3D"mmc0 mmc1 mmc2"
>
> In contrast, standard boot supports specifying just the uclass, i.e.:
>
>    boot_targets=3D"mmc"
>
> The intention is that this should scan all MMC devices, but in fact it
> currently only scans the first.
>
> Update the logic to handle this case, without required BOOTSTD_FULL to
> be enabled.
>
> I believe at least three people reported this, but I found two.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Date Huang <tjjh89017@hotmail.com>
> Reported-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> ---
>
>  boot/bootdev-uclass.c |  3 ++-
>  boot/bootflow.c       | 21 +++++++++++++++++++--
>  test/boot/bootdev.c   | 10 ++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)

I'm going to pick this one up. There are no formal tested-by tags but
there are two reports on the mailing list that it fixes the problem.
[1] [2]

Regards,
Simon

[1] https://lore.kernel.org/all/ZSMlNWJ9f7HkoaNg@Dell-Inspiron-15/
[2] https://lore.kernel.org/all/VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1P=
R08MB2847.eurprd08.prod.outlook.com/

Applied to u-boot-dm, thanks!
