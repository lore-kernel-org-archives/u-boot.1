Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C8C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B4E280B6D;
	Wed,  5 Aug 2026 19:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ez1WEzkK7jDI; Wed,  5 Aug 2026 19:10:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82B9C80835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785957059;
	bh=CvYdFikWHoJk6NmWR0Jz15lXLJEInMAlrQgzLo3YX/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvYaE6OfIJI5gnDYqFZ0i4M1bFpXsIhnRNzj3fz8kKsWU/L59lZJGkl3MHPvJzkVS
	 Q0r2KSCnCO7+zv4+1xSPQTmkFnyHW9LMQwEw4KyLX7uo+95bF8qpCKlYwq5XtwpjaT
	 llC62/7fC4c7F9hLTF9WzJ6HU8vgGhintqC7037WxdHX6n+d+V3rVs6Dz/zpzLEFYx
	 XdWninqlFZ2IMYgRbeDEYOwylCw5iNTQEjAHuGOKlBmfLp+tSSf7P7SBAh3X7mGpvz
	 sYkSInCQJwbHEa+E5rTJE81jPDXgyO0TnN+jlD7iTHzeu2TShx6vvJ29TcpvucERg3
	 b2DmssiCmBmsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82B9C80835;
	Wed,  5 Aug 2026 19:10:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59A612A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FB3380822
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:10:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTRj-bkfCLBX for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:10:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 867048082B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 867048082B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 867048082B
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:10:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A053084867; Wed,  5 Aug 2026 21:10:54 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D732803F6
 for <u-boot@lists.denx.de>; Wed,  5 Aug 2026 21:10:52 +0200 (CEST)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5aec6360133so1228769e87.1
 for <u-boot@lists.denx.de>; Wed, 05 Aug 2026 12:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957052; cv=none;
 d=google.com; s=arc-20260327;
 b=RcrxZFcHtFEq211EXAX2+CdFbm3jErarUWw/K4jh3rQmAwtV8vYOITWL5Jqq9S5zPP
 xTpPtskFgoCeWSb4DBZ9WPddZiXgHN90whT6Yaig2lEKq1j/mD+LIbX3S45i4yAqpF4W
 LzVySxvcDuEfmY2R0V0LmrlXTuXhWPG22mZUyi9Sbg7eGbaKwDzEoVXH4c2vQhb8SOpK
 06H4S056drvgUzkhJ9If+dswOCbILDARpHRv4U+JOBQAfoYB1XemvitTMO4TEtSYW5Q+
 ruEeboEBfMCNEKwro9kiUYiYSEVyfRPzNoAdEawdk7CHCUXf45wjKZTdNE41k+LoMNcd
 eEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CvYdFikWHoJk6NmWR0Jz15lXLJEInMAlrQgzLo3YX/o=;
 fh=tr0GhvMzl3my6alJTNWvKQWbYzIsaQjyCP4jDQVNuPs=;
 b=HDJ05Q7J9uqfSe+EOsWB0kXUaZDlGTv3zTRZNADeZHAZFR2RHytK4vndXOqh9sAnXn
 DE36YoS5SBywKf4I0WhnHi0rJylZ9MRich84IA1jZn+jCZDfpujx4DXiOtmrNpi9sANn
 XzZHBZCQ40FtYNILtFeE67Rt/rssQhmWkwbzuCebhGLGR81aAYmt/UtDEc2L888qr9Ok
 9lySwT3WsOIVKNkdSpKUgVv9AEhUYog5Y+r3NPrJKNkqTKlK3N4i+dV2ubaLIkVge40i
 j1MZo9hTahKDX9zP3fGHCnEobKIoagoPrYhDNU9Z2fSfo307Kow4x/8DAOG7WpiP7YDG
 J22g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957052; x=1786561852;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CvYdFikWHoJk6NmWR0Jz15lXLJEInMAlrQgzLo3YX/o=;
 b=mEOwqr8kpcCRSRRIuRUiov8cESGi8+2FDhNwvMxHAcTOjdUMUDloQOOCzHiqdtL9uv
 2JEw8GUr0y+ABmD15Z77i8xe6TSSwcQ+SBiy6jes3vVNT3out6p/rEVHfuIqumlip8rq
 fs93rd9c9/fiP8PJqm0UKxJBam7N+fPkl6wMJRT9Ome+t+zLnjV39amqvRv8nF/qMwJi
 iWAH7pWi2nZAP5kTDBr6dSZUy/vBh35oVbL2SK+qZSDObiEMXgHWYRVYQFRPStJgNlQ7
 yZGWIWgdyYiMQnzmYb/VlUbDlssvVBYaroHKNvq4w3Ot6MPj9Xc8yyGa8YGFyeg1T3Pr
 Br7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpsk02ZcDzpPAppwRcFq05mAyE1Bh8NzQTAStnYVKTJSl0m7FstC18XEaGo0jR/lqTFRZ6wM2U=@lists.denx.de
X-Gm-Message-State: AOJu0YyBKNG9RKo5CDgecEQl6NIPkrBlK3zY+vfdbS4376XSON0Tea4a
 CpfwK0MmBdA1kmQMeqe/zisOXs37QeJTQ8xjTtBiIiJemsYgA0oHkhm+aovCsyB+Z5OnoFc9SXQ
 IEGtXUUJGlIVoZmF7UBDQn8CfJV5JKIQ=
X-Gm-Gg: AR+sD11sBfQwrkLK4Is9+7NtrCw5JR6KUTvuzWdzWXQDP4jyte823xr6FrrOk0Zmdcg
 i1/sKJlfvuPMgtNhhqbaccyhHC/CZ4MNi0wfiWBnESMXsn8jt+4EYJUIjaFS8o/hNnSlozYUL+A
 qlqDfThMeGlmvcii+csxSy0PRL1DuSaNwrQHTKLtiE1Vo0RNfF9YGwjCnYNIgrFYVHbeoWhPZgb
 eYbt149yd8PXiswPB7GYR39XJGAHmnMdJPTeBOklvr5Yhya//3Z4YVzid8/0CgYqzXwCkQYhpFt
 psfAUjjWPN0ikaWQM1lEUmADrF68navtQwLgcuXVEmElyzpT3weDvUMmAPj4im4RB48gD4tGaL+
 sRPsNhg3GS3GFCjfIw/s7CzUVwh/UoorzJQ==
X-Received: by 2002:a05:6512:15a1:b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5b2f4b885edmr1469713e87.16.1785957051466; Wed, 05 Aug 2026
 12:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260728155624.86989-1-marex@nabladev.com>
In-Reply-To: <20260728155624.86989-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Aug 2026 16:10:40 -0300
X-Gm-Features: AUfX_my5zrzgQAYdWuLp2h5QrTpLWTgxCL2Hun2fp7KWYndsAhpS_DE-7O4Szt4
Message-ID: <CAOMZO5DA6N6Mv1uD7vG5VbfooB1O7BRqE2TQNmUQOuWTF0UrZg@mail.gmail.com>
Subject: Re: [PATCH v3] binman: nxp_imx8mcst: Handle FCFB header during SPI
 NOR boot
To: Marek Vasut <marex@nabladev.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957052; x=1786561852; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CvYdFikWHoJk6NmWR0Jz15lXLJEInMAlrQgzLo3YX/o=;
 b=XlypcVUYw56CQRChMqmRDD3dp4KM8v2d3/6SHHFPbG1hws/C2tzoUlDjZKu7ZUc7Je
 MDxBWc0sHrRB0dunt8RKWLUkR+40DigPKiGJ5c8+pJwYb6sKf/CKm9C0ByPHVHV0s5pL
 3hhJvbZbT5b72ne2y/0ztHsK59t7IZN9gp+uYWFrQ03+3AY07hay5LO7i0VCBwHomXqb
 dO+kk6qwo+ckw5d+tWFHufu9mDk5XQkZyBv6AomULxfZ6hq5EVjQcQ7oHPSUkw2fpRnU
 17+EsMf5fGd4gy2+K1IE1tv7mCjJ/08Rk170T9sFpKksCQV7uX+pRmsmCyVa3dv2SQQ3
 Jh2A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XlypcVUY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XlypcVUY"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon.

On Tue, Jul 28, 2026 at 12:56=E2=80=AFPM Marek Vasut <marex@nabladev.com> w=
rote:
>
> In case the image that is wrapped in the nxp_imx8mcst already contains
> an FCFB header which is mandatory for SPI NOR boot, then the IVT is at
> offset 0x1000 instead of offset 0x0, but the whole image including the
> FCFB header must be signed to prevent attacker from tampering with any
> of the headers. Add the FCFB handling.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Update the block comment to mention the FCFB
> V3: Add testNxpImx8mCSTFCFB test and document the 4120 figure

Could you please help review this patch?

Thanks
