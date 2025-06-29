Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7DDC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 12:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4223382E5A;
	Sun, 29 Jun 2025 14:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJwPwlvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB31E82E67; Sun, 29 Jun 2025 14:48:15 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CD982E40
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 14:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55511c3e203so1221538e87.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751201290; x=1751806090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoJ/Il5VTvqtTUjpUhKc7DHpncRzuRFUULrLbPlGDfc=;
 b=dJwPwlvVEtfVaZHzJ43dUp3uzTxEttKSvyCZAOYKIN6uv8prxo1H1at0lqUanapsEv
 edVkHQhLlo9iTVQXOIABY03lRnrfQ5sD8sDF6YSRH2x+o2BEkYU4YIXBU3+c7zCzdWiQ
 +0WIXxJyM6Nrz8UX8SKc16b4oqHGX3TWY8flp0vqiggseYtA/MPVcRBGPLturoMYpxOr
 lJTXNdrlPD4cAMZIrZjQhoTqPLJwGFUPD9LexcAaGaDtgfTk8ejJJvSfEB8waKk9zWev
 mEBd/DekIyJYpmBw/DCWiaXPAbGIA3VTzk+d5kY7gdJDfU+cufSnhMdwnx8eV854O2yD
 HnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751201290; x=1751806090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoJ/Il5VTvqtTUjpUhKc7DHpncRzuRFUULrLbPlGDfc=;
 b=BBwmVW236m1s3hFS8RPYoq0xULRzfOJVwWK0oQASknb5++0Dd68ji//+vB9BfqRvS+
 45SFzpSNvGMrx06p66ZHrqK4CzMNJ34ZZ5pDoArw6Wsdsv1IeDx82q7MBWa4rClJQrwo
 0x4F/nnjgbRyHsW6S7D/+vvCVT9a9PfU11eU9zXPd7HIC4r0Md+X3vi409zaDFaCejix
 v2E/yOLDfAHL1GzKTZyLWZ7bXWEYP+71MqGDk86wSCJNxwD9jOZybEaDkF/qGZRmT/11
 66mZfamVme4HarvUv15z1hBWZluu43AThHSCLljUt1jiTSWG2skWPLUDRlCkyjiBEREa
 uZ1Q==
X-Gm-Message-State: AOJu0YyqCksLiY3cti4T6SlFi82RM9gawJ7CdjA888USDpfy6R7DOG91
 U4a6esvd8DwUHhPvcltSjOI58nv8XgoVu+qMVkKuuocNwD8kcig9SU4eF3DULAZ/jx7U3fIV0mZ
 eahHCzaYvksBPzVOvuE4nmF4DUGbSwHg=
X-Gm-Gg: ASbGncsichGvUmgqGgPuAKypcXT8qtq+6sOi6ie7g946pm9a7VxiWSq5KJk5hM0Z8ov
 3X/20qU7Suv4G/aeOihMGVi9rHjabNlTfXv+wdT/Xqd6fZnjGRSs5D0xBOm7ZjSxxuCmX5Zk/wx
 Z+PaHpmVL2pHBdTaHfMXeXGm2PvpsGnElUj+th+aspHNtZKO9ComwC65bnDJrtBW2uQj811A1lz
 Wk=
X-Google-Smtp-Source: AGHT+IEyeBJ2xIj1BaP51ldfogqvNP1Tnc5w/+cXj4ko5MsL/D65I84ddJLY3Mp/mwTP9QA11FHhUbY2a8HSAR6RLQo=
X-Received: by 2002:a05:6512:3990:b0:550:e527:886f with SMTP id
 2adb3069b0e04-5550b8d8b7cmr3521347e87.51.1751201289460; Sun, 29 Jun 2025
 05:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
 <20250526194811.1179530-3-michael@amarulasolutions.com>
 <CAOMZO5ARdWa2bZrg+0VnndR66yFbmAOMNaMtn6PFS1Y9b1xPOw@mail.gmail.com>
 <CAOf5uwm5mTn3ac65cZiZedpo3kLQH4H1PEWtYMR+Rp_f8tR9fQ@mail.gmail.com>
 <CAOf5uwnjLjd2y_eBjiQkrqwgNMOR-0WjYAvwxP+TY=3cumDqOg@mail.gmail.com>
In-Reply-To: <CAOf5uwnjLjd2y_eBjiQkrqwgNMOR-0WjYAvwxP+TY=3cumDqOg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 29 Jun 2025 09:47:57 -0300
X-Gm-Features: Ac12FXxMpen6Mj31XZ6rbwj41NYp7MH2JT6yLF5p3mCGSSdVesyTuqw4HqPozZI
Message-ID: <CAOMZO5ACskwikgDm1voj=3MhzvfMdMXH=X16scEhV+VRf9UiQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

On Fri, Jun 27, 2025 at 2:36=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Fabio
>
> Are you going to pick up my last series?

This series is already in the u-boot/next branch.
