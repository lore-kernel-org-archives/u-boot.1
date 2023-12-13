Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB28FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5880D86A81;
	Wed, 13 Dec 2023 17:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WRfI8nlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D5786564; Wed, 13 Dec 2023 17:31:11 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4A88784F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-286f3e0d010so1861684a91.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485067; x=1703089867; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52G2aa+zKGc4ag52LtrdeHNsME+bEZ6jX/o3hIumJsQ=;
 b=WRfI8nlVH/UA2T4MCRMHu3A48IA6IYv7cRj0OqYooWVJG5KOxIj4PWY9UB+ufEFIMV
 bUEIX1DNB3YzVSfEcJysPgwdzq+PtYcIhC3rLMwtfqpEkGingkhoPlhwHRFq/Vl7mWKB
 6sDaBKd3DmZ/uQT04GPyumxvOaZ9NmzmXcyZne52gf7rop2lKZlq5N3WuGG2+qkmBjN8
 af/14V55e6a18vij7b8/kEKCmYLpF9dcK2lIZHYrAdid74SGHbJrlcR01NGaib6RIQif
 P2ewy3DJdDJxT+jF6/1k0OqZ2FsfExxSPO//vCsF3dykMD0fe90NjM25fBDBPTo6JaYP
 /qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485067; x=1703089867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52G2aa+zKGc4ag52LtrdeHNsME+bEZ6jX/o3hIumJsQ=;
 b=lfbcH0eAkWw0A8S81Zm3Pw4lStjjJIVVe9NSwR1wn4VYkH50MJ2EEGSrDyz+cF87AT
 OHON6bCxg0gTS3c5ZmNrwWGzd1qxTALXHFFLEFpmmQEauuKLQ3XgjIpg0jB3gZfm/Gfg
 C951l/kh46Wlup/Ay2VjH1lFcDDG3xyhcs2sxeGc2fFlFa+/eWsoQoOhz8VmKozvIoaP
 CTBplSfXttGtA/dM7IRJ425E4npsTBSMmDt7Cu4X9w1MgHauIyZPZXGd/fUBKY/MZdLA
 OnCLgJTNvkQD0Fl77SeVsTfBANerGzTvuiq6HmNdyAOwB6CutxXIuKa5DS97QHuW6l33
 m9lw==
X-Gm-Message-State: AOJu0YwYOCsrMolyWl1NBFWCtq2Msb8dKGSPAfOEnZN249DdgB5jE6uK
 GkI3gpRi6p6gBME3U7BkkJOwjxXy4WyMyOf/iBk=
X-Google-Smtp-Source: AGHT+IFEFS51hBMpp+JT4lNpPRgUUJ6ll9GWczKrsoJkB9djt4HY8HoTtARpq261DPcLR59Ufpd3JEekbJ59XRQ8KCQ=
X-Received: by 2002:a17:90b:3718:b0:286:6955:6754 with SMTP id
 mg24-20020a17090b371800b0028669556754mr14382034pjb.0.1702485066869; Wed, 13
 Dec 2023 08:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20231019194323.2207989-1-hugo@hugovil.com>
In-Reply-To: <20231019194323.2207989-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:30:54 -0300
Message-ID: <CAOMZO5BekTAdGuVmchqu4xTBQr1YVqdKMBHEuxgLVA1TE+q4eQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mn-var-som: Simplify FEC initialization
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Thu, Oct 19, 2023 at 4:43=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> With DM enabled, there is no need for board code to initialize
> the FEC interface.
>
> The ethernet PHYs on the symphony carrier board have a dedicated
> crystal/oscillator. If the SOM has the EC configuration option
> (onboard ethernet PHY), it also has a dedicated crystal/oscillator.
> So in all cases, there is no need to enable the RGMII TX clk output.
>
> This follows a similar change introduced by Fabio Estevam:
>   Link: https://lore.kernel.org/u-boot/20231019170441.1610453-1-festevam@=
gmail.com/
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied to u-boot-imx next, thanks.
