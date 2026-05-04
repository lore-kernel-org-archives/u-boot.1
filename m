Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED180FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7791D8460E;
	Mon,  4 May 2026 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHadPYXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8176680F0E; Mon,  4 May 2026 14:33:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10A480F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso2283993a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898019; cv=none;
 d=google.com; s=arc-20240605;
 b=ViOc/OYQSsE2nRrw/O9ztCQ0o/hT7SX8f7wQzhWLXI/3dQrYFGbqx0WH5xu/0VErsi
 0QrRbDrDQbIYaR522bJlFRii/V7AkFYckeVSiP6HAKxmgUA50KnMWAXVpkOwl8msBVXA
 QA0c9tbkxFwTV4x/3QynGs5ZydxFOBMBaknWIhUeyy1+OirJ6764BJ0zJeeWH7Peg9ZN
 MLrcPlI8qAySXWx+4HJDgkqcBfaD897dLg93b2q19Vi6u/nJZBb0GzdCdZIPCeVR4dw/
 lIskjNL0hZUNp5Z5S/AFlPSGvRCUzNjoVfVYGo2iKZHlMM+0co79siyNlSK6A4CeeyT8
 fsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xPilpEdh2cKAThJJ3zUi8nGQtJrBvgdmI46lXMyY6wc=;
 fh=gE6Yt7gElLCbh8ryhtP+HD2nmjSP4RFADqefourqOuY=;
 b=eOAiHEfmvxloa/clZVtWf1soT9t/jRgScTWY5gdAcaWpl5P1/nE1VU+XCfitwB4kF5
 DAI5Z3mrAXSqCwQ+nx1FBEgL00XZU53/TwX9gdctA1uaCFs0JmK5rVK/oAYufVIwzhyN
 lxvIQ3wfz3mVc2QF8efZdpxpAZdHaRIZkIuS7WUxxc4GrtH0Oq7MQMjPWry04PHz5Pps
 e0RgHXN5fazUI1F3mtt0T2Jf9g/L0NapNwIbqRddfDPDOv0IibI/zU32fKYw7Ec0VZnr
 9VzmaVqjOrkvkohIi/61ke6vnp0ytom9TZ6BYhwQy4avHFRSAXFczKB7igcSxeeuEh9O
 uYDQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777898019; x=1778502819; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xPilpEdh2cKAThJJ3zUi8nGQtJrBvgdmI46lXMyY6wc=;
 b=WHadPYXYtqGvOdJ+fRNxnC0F4RFPCavZgcZyzkKw/ABB7cu56CLQydG1L2z+B1o+k4
 p4iRii93jcpEtzjRur0LHooskWQzd2SSvAO5abPVTI8Sqb+vyd39PW2ufZqyxDRZJtDI
 JcmDLNqUylswThBU8z/y11IfVYLS+LJcBmvOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898019; x=1778502819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPilpEdh2cKAThJJ3zUi8nGQtJrBvgdmI46lXMyY6wc=;
 b=rayLyEtDrD4yvLQKudKxLrDkZR2MSUMnCDNwM7hgRFVnIzmkG258yiejB8C0td/QkA
 XVt0iTg3y/S4Vsa5AmOsr7NfEVN+MSwiUhut8HcBb3LxGy6fekECDSNkyXM/IE7Gp9gU
 8Ih1HqVYU8I5QNz0HZj+lwDRz/0ohun9Bfj0gzmUeGk9IghBXclxNG5xofagusLhrUCL
 PTRR4/TM5ZexamlN/fkg6V4Vq19R2tz1VAq6rJd5MSgEJCJ1EoaqnnWzadPYRnzjrlI3
 iuuwBfTUzw2M0rqET3uT7ebUgFOe6Xqhy0HdeUzM2tiZysM+E82lEjNNXNUD8l17Ulvl
 OXvA==
X-Gm-Message-State: AOJu0Yw9oV32/vs6DfYZqCgzzx1QQ3vdovh+aWXWbTkVQtqslshngqG3
 gX3thrwvnqjjj0bHfg3Yp0E8Ah8m1+ya0eXhxNIdNw7VysBKjiExW9ElR1wrIEmHs9Uwy7XzwR5
 0OkyNCjRQKNFZJgpadb//inPHkojf17bvOYHUlgwZ
X-Gm-Gg: AeBDieub3sw2ebuNZWMVWF9Swwq/yB6qi6eATxIdFc06DPqUoEG7gVJsi+9WIC9UAgZ
 Agu0wOsak+prd+5ovwbOatSXADIlq2A18Z9vB7Fu4+g1wIfp0Awt2nGPNdVYF3g5LKLORsxiBoU
 jVObi27our2o5PoWpsqf4jtRFlUe6YziR12s6DwRErolKVzw81AMB93b3bxJcNZTFi+ibg+NiOk
 MtKFU/7CEjhIiigs0GgKQPpOPR13jL9Cq5vqi33+2o6vC1qvbDBkBQs5aSMJ+ESbaFd2Kbis8vt
 3AowFq0DtLv5/gkz
X-Received: by 2002:a17:906:7956:b0:ba9:d5c9:fdfd with SMTP id
 a640c23a62f3a-bbffcd82dacmr492322766b.31.1777898019184; Mon, 04 May 2026
 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074827.3917463-1-aristo.chen@canonical.com>
 <20260501055112.3966757-1-aristo.chen@canonical.com>
In-Reply-To: <20260501055112.3966757-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:33:26 -0600
X-Gm-Features: AVHnY4JT0fk20snKWZSPu3sqL4eZxkE_5u-rn4euJCbRXEWgoOTj709fTuuTf0U
Message-ID: <CAFLszThMEH1YW=zrV_N5o3Rq7Qi3vkNcHpSAgzUHDSJFo2Nw+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] test: fit: Use shared make_fname from fit_util
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-01T05:51:04, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fit: Use shared make_fname from fit_util
>
> test_fit.py declares a local make_fname closure that is byte-identical
> to fit_util.make_fname. Drop the local copy and call the shared helper
> at all seven call sites so there is one definition to maintain.
>
> No behavioural change. Both implementations return
> os.path.join(ubman.config.build_dir, basename).
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit.py | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
