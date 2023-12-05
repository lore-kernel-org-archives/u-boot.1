Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7EC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BCBE875F5;
	Tue,  5 Dec 2023 01:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OeB8hcxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9D28788C; Tue,  5 Dec 2023 01:52:18 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C2B86FB5
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54b8276361cso6231675a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737536; x=1702342336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=desNvrZYjc9YcgCgGrl4d/4q1+NqWWd1PbgZeFovR5k=;
 b=OeB8hcxTf3semtrDVtpjyHkza1/YCKauCt6yVWunj0vokhYPHvQTCmZyf13UYmij/p
 dGZXQn1SefEriXGXICs+w/MSA7q4fx12XMKEtmV6bcAJtSDTEvzs3n6xNGGD7VPKTHLb
 LGP4u8rZpwj9DPMVm7QQla6ZgVpMYYtdanEqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737536; x=1702342336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=desNvrZYjc9YcgCgGrl4d/4q1+NqWWd1PbgZeFovR5k=;
 b=cBZfB9V3gE0idArJZ14LsV04/neEyDcyep1RRGmRItvKaE4xmL/K9i7YubCnnpJ4my
 kIbBprjLruPz0nQ3tnp+SfYoEPEG2yJygdw7sBXuNuWvevEXaTj0SZ648xvwViHSsWx4
 MlmjY7IqzxV4PBsYeOTkeEFiJ4paPS8CkwyQ4NceW0RbjGt2hCyjyLrjnKvfldkU52+R
 N36ZawHxoprfyVbuPdBetdR7qqus5Pee9C50jlho7vip5bKrqpZaL5nhc+v2raO3nrnf
 8mhR6lt/OPs556kBldfhW88dg7kckDcr1A38z49Y7nTk4+3WXraL8UrSmjeOhBhvIW1q
 lIzw==
X-Gm-Message-State: AOJu0YxS8mINFy2mF52oHg8XNcigDwCPTZBpdCEjJhLsxyqYq0n842gk
 ks1N7KhB8NFJofoelKGrevlLUOWmw/sJuhHRB5j8HU9kAG4zsyFG7u1GazOS
X-Google-Smtp-Source: AGHT+IE/QjMhnhmbs0EGOsEjBfO2soIHrBWe5rqVElMM4EuDjHXpTcFuvTzvIwTJlA1JDC7Bjq2BHjNxfqEiaISakoU=
X-Received: by 2002:a17:907:9391:b0:a04:7d85:2a7c with SMTP id
 cm17-20020a170907939100b00a047d852a7cmr3912ejc.59.1701737535952; Mon, 04 Dec
 2023 16:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231203172622.5.Id5671bc2d663f968a6f9da1c7d248525a794a4ba@changeid>
 <1ea1bd8e-d0e4-5f35-aaa0-5a95c37222fb@kernel-space.org>
In-Reply-To: <1ea1bd8e-d0e4-5f35-aaa0-5a95c37222fb@kernel-space.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:02 -0700
Message-ID: <CAPnjgZ2AfK5cCE6j17OKUT8x1Rn7_K85a1RNo_N_-v_Y0V28bg@mail.gmail.com>
Subject: Re: [PATCH 05/18] treewide: bootm: Drop command-line args to
 boot_os_fn
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Angelo,

On Tue, 5 Dec 2023 at 08:01, Angelo Dureghello <angelo@kernel-space.org> wr=
ote:
>
> Hi Simon,
>
> looks like i cannot apply this patch:
>
>   =EF=8C=83 =EE=82=B0 =EF=81=BC ~/dev-k/u-boot-coldfire =EE=82=B0 on =EF=
=87=93 =EF=84=A6 master *2 =EE=82=B0 git am
> Complete-decoupling-of-bootm-logic-from-commands.patch
> Applying: bootm: netbds: Drop passing of arguments
> Applying: bootm: plan: Drop passing of arguments
> Applying: bootm: qnxelf: Drop passing of arguments
> Applying: nios2: Drop separate parsing of bootm args
> Applying: treewide: bootm: Drop command-line args to boot_os_fn
> error: patch failed: boot/bootm_os.c:441
> error: boot/bootm_os.c: patch does not apply
> Patch failed at 0005 treewide: bootm: Drop command-line args to boot_os_f=
n
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
>
> And getting similar issues for the "pxe: Allow extlinux booting without
> CMDLINE enabled"
>
> Am i doing something wrong ?

Could you please check the cover letter? There are several series here
and I put the -dm tree links in as well.

I was keeping these to send in sequence, but it would likely take
several releases that way, so I elected to send everything at once and
get feedback.

Regards,
SmIon
