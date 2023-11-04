Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D70C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 11:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017C287007;
	Sat,  4 Nov 2023 12:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jjk4ZTa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08A08704B; Sat,  4 Nov 2023 12:54:48 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F9286F7D
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 12:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bcef66f9caso669111b3a.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699098882; x=1699703682; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XG6CLKg7RoJbpHyNVL3eSQfx+3C3FPc7AG54vwqkgnw=;
 b=Jjk4ZTa66g/EayDGtLATiD8QX0I2bN++qwJ9P2dm9GYpf+6kT/KS0H0qT3kdk5vG3+
 5wziI3yy6KkXMmqs04QeoZbCCP3G5xri793crV7WhuyX92qmIlG1h/Q/mmm4Jt6SF0mO
 5gJxaejj3JDxc9DW4/HfL1GcAJRMuegdEhuoVkp3KUEUWHbz6xORy8g40PgyIQ9MwuMv
 gGzMcmy0koDt2YSYdLTCFmO1ovqOGJASz8gwgBIZPYvbtrIIX4Qqn3Y08LthaNQVpUJ2
 3giVXUm1rQgGg4EnshSEXfodjdPs864dH1EM55FbPWVYdDRc6cR2NRDG0zpUiU5IbRo6
 dX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699098882; x=1699703682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG6CLKg7RoJbpHyNVL3eSQfx+3C3FPc7AG54vwqkgnw=;
 b=YHYGRyzFvzeKt8wrkB4KoGE3e5GIRfm7HLOPNQx8P/9Go2VGihLIPok5ZEPlAM0lAS
 ZZvPSIBgztpau9YFd0a2I7s+tsSnIoOr0RTYtss8vmra1EcMvOPGhhv04YLkmQAzexmb
 vpO9xHUT7t7bdSnOsgRvoAU7vf9auhFAT931w8O0aKYsW7OGpG4VFOFonpg3g61l7qAj
 rULyd3SHppbegag4reUaMZiikn+UkCJu9Xp6pasz3wTXeMYgs0NLjHwhydFwYR+yN2t7
 bvPyUW7YbNinH1V6smvOBWlAR9MtB06DwR+GA/5LQePOMbLzP9SJOxqQB2jFU5VkN8Go
 OZow==
X-Gm-Message-State: AOJu0YwIdldlSjRa1XaxBZlh6MdGQxvQ14Zzt1+U0IXyIR5Jyce24TgZ
 0t1RLvF3kb21Y7GpsHPghSw+aenrOAhNeKRgWVY=
X-Google-Smtp-Source: AGHT+IHk58ScGTxz8obrxAsCmjXkxPLpYzfv3bB1cbLoiFZdlIswKVfcwWSbF7YGF9KTVspbwXNcft9JIRK68P3TTto=
X-Received: by 2002:a05:6a20:4423:b0:16c:b514:a4bc with SMTP id
 ce35-20020a056a20442300b0016cb514a4bcmr32695396pzb.4.1699098881735; Sat, 04
 Nov 2023 04:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <A2A0QA.IjxBof9kZfpi.ROrtIN5Y6l3bqrOxHBXX@freemail.hu>
In-Reply-To: <A2A0QA.IjxBof9kZfpi.ROrtIN5Y6l3bqrOxHBXX@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 4 Nov 2023 08:54:30 -0300
Message-ID: <CAOMZO5D8kpOeEBPiz9M4BEuFfLg=pu3EfcMMZiyRf7ne5wBDrw@mail.gmail.com>
Subject: Re: [PATCH] pico-imx7d: Remove board_phy_config()
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Sat, Nov 4, 2023 at 7:45=E2=80=AFAM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjamin
<egyszeregy@freemail.hu> wrote:
>
> Other pico SoMs still has board_phy_config() also, you should remove it f=
rom them, too.

board_phy_config() could probably be removed from these boards too.

To be sure, someone has to test it. If there is a problem with the
devicetree description, simply removing
board_phy_config() may cause an Ethernet regression.

If you have access to these boards, feel free to test and submit patches.
