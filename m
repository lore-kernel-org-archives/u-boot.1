Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4E3C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9837F80D5A;
	Thu, 20 Aug 2026 13:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spOOxr7qxhiy; Thu, 20 Aug 2026 13:21:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787232115;
	bh=UEMd2y4zOZswTlQy/amjW6WAk4wZ9/Z4WW9QBhEY49k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwdDsf91s/rOPaToEn9T+lhX+Czk/qsDX8HRtHxjvvJJk82T68fH9cuojMokhblJp
	 wNE+kuiaK6RfEZVXShnjYXRQu0lwOGhbTzfHGfEYR6cpslB5JlFnp7rvV4hiZCHr6B
	 l8cBvXM75nUh7tH6bHHTXJTPlY2E3V15HNSDzGBkE+AK/ePe45jar431Bv0CGtYush
	 rUf9jPdc+U3hmcLvkllygQg2ikiYhj8ThQFCe+lneT6NvUiXVOR8IrLWAbHNf5Xbcu
	 GdWKCqfxJ0kOC7SgJGplcgLc9c1tY8FsK4/1KcY5WR7xb0Z5EvdHJAi91xoIMAGBWy
	 A1eIwkVXGR12g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF2F680D23;
	Thu, 20 Aug 2026 13:21:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD2323AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C397980D1D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7090JymYL-S0 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:21:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=haHQ7HKg
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEA4C80D23
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:21:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1ABC40B6F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868E61F00A3D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787232110;
 bh=UEMd2y4zOZswTlQy/amjW6WAk4wZ9/Z4WW9QBhEY49k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=haHQ7HKgffhJlunbznaIV13qw4BB8cfQ42Z2coMvMCUFdNCmMx9ZQFxBZV84CpR8q
 5GX9bjU8+jGhU+9+XRZATnwoXanreyglSvRMBdqUxAXhFCqrfnlxvK4d09HEwDnJq+
 sqqaUdAoAwBrEnPEpXNp8JGILKh4JriHzadiLO4FQTABScZYWoITnuzySmD4bu79hO
 Okxz/LMawlRvm2MMUGPzllZ0DwWsVveU1NF4pp4u49thfldF7RY6gt3cT6tFkZOQDt
 KGcgl6at8cvAeeWMiXkb1UkIgoIg3qknw4zF6bh3s1Hn3jhMIgzJaBvtP9TJfUMgB5
 hsz/nFPVuxmvw==
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aec201b582so2627013e87.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:21:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RprEPePOg5bGTpZXLFSAlit3rVWgWm/o1QNbjqaEIEdpiWBsLjaWRek0sHrQnVuBEo1buMXxcg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyAZ84TRfWBAzOXBLhn291LVvTrPIY2sU9FBl2+RjGT5bTZDSUr
 1jkvGYFDje3RLnL24nFXbmA0zByLiNdmp34cG8pSpujKS7mWVM1Bv/6T1b3wL3UvgiGUFh4/oxl
 Axumug3tOdZ9D7ZMYnk+lfbZ0uI41Mgw=
X-Received: by 2002:a05:6512:10c3:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b478bcae85mr4917375e87.16.1787232109355; Thu, 20 Aug 2026
 06:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 20 Aug 2026 15:21:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLmZm5FH3C5YK+V4wb818QMHGi4N_+Rm=Ke8mZhUAz7ayQ@mail.gmail.com>
X-Gm-Features: AcwNN1WLw21fQAmLcZCqpAQTEmiw1ftrsu_dCuHbh8rQKcdNfZXSOGriHSdbdE8
Message-ID: <CAD++jLmZm5FH3C5YK+V4wb818QMHGi4N_+Rm=Ke8mZhUAz7ayQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: build mkeficapsule for
 CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Aug 20, 2026 at 9:27=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> Currently we build mkeficapsule by default even if we don't have EFI
> capsule support enabled. This adds a host GnuTLS build dependency.
>
> Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=3Dy=
.
>
> tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=3Dy.
> Hence distro packages like Debian's u-boot-tools will still contain
> mkeficapsule.
>
> Reported-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Looks right to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
