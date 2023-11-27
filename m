Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD19C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 20:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130B687804;
	Mon, 27 Nov 2023 21:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z/cU4oyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA4387539; Mon, 27 Nov 2023 21:39:21 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D124876BF
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 21:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-51f64817809so783245a12.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 12:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701117557; x=1701722357; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmTNOH2mphG2a5l82l5W5X3n6zUIYJHyRpqryjUQEp8=;
 b=Z/cU4oyKJgxfHcAhMIJlYInV/J0rtSNhGI58uQzJG6rEV8QDXWm4PSQj484eDW+ovM
 3TcYQDuYquyH0WduYNpx0SU67bRwry1R/UWD+3hTCg30+y6r8gNZQazY82xs77ms3ujD
 WsU8sd4UfG2jFkMQOoWjaM/kFX1f/TnBuZKJeHx6zgG+1dH3U12o3nttIaCs0feKsSSS
 QeS4uS6vHHOJQREH3V1DbjHGWY9F6FWgU6inLEzKIOoqWodRwMJJqVkNnud1PX6UQqOS
 kAnbj5LYg9QV7Y3O9N/ckIItF8p0FY78QtfN892ci4T+5PPD0GrjpFYsK+aw1+1KCDEt
 FE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701117557; x=1701722357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmTNOH2mphG2a5l82l5W5X3n6zUIYJHyRpqryjUQEp8=;
 b=D24LfK2azhkVCvvZfmCRYDPVDZSfPrxnHDOitXXYE3uoIXEXOxKVQztZYMstddQoNt
 CXkevEaR7DckpQ+t+VONRdmK89HzpNhrFsf+ACUOOZsNWiHt5cKlazzBZl/tvLFZWqmi
 V83/nix9jdsK4pB5rVVumjbP/BcKIWqN1rkkj0PM4XEmGC5LJL+ugy7zmtw45oN+r4N6
 zIOKh+im6kH/W/4ToLw+G2fkRU2krdQrwoPeumdENabi4ZdOXdSzIohsMD+ISbOaRXMn
 MHSk/YGRNiX5fH9oAbZ7e7ivmEAGXSbeQjLnoO1STdRrLPdVEzra2z5/OwyNpWoV5N6L
 Jj5w==
X-Gm-Message-State: AOJu0YwSW3CR7HV9qvzQpK3KJIMfq5ghoBy29ZrTAOwqFek9XNXTYZo2
 D7Rh9JlepWBme+uOKobACr3Vv/qYd/ZLC4dUNbU=
X-Google-Smtp-Source: AGHT+IG581md0xVqCIK5Xcw+k2YBuPt2H3PascLE6hMe2CmdnnsjX+h3+Q66Vk8QFyYMP8LU+5osk1xSspIYpLo7bR4=
X-Received: by 2002:a05:6a20:728c:b0:18c:19ac:d771 with SMTP id
 o12-20020a056a20728c00b0018c19acd771mr14466987pzk.4.1701117557369; Mon, 27
 Nov 2023 12:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
 <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
 <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
In-Reply-To: <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Nov 2023 17:39:07 -0300
Message-ID: <CAOMZO5AK3cxy_mOD_J9UPPCzFVfzoVw=OmACeh2+27k+4CkCnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
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

On Mon, Nov 27, 2023 at 4:55=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjami=
n
<egyszeregy@freemail.hu> wrote:
>
> Unused function parameters should be removed
> https://rules.sonarsource.com/c/tag/based-on-misra/RSPEC-1172/

From this same URL:

"Exceptions
There are some cases when you want to have an unused parameter
(usually because the function has to conform to a fixed prototype"

which is the case here with your patch, where you need to conform to:
int board_mmc_get_env_dev(int devno)
