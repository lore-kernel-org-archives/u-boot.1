Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E77C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A96A882B7;
	Sat, 30 Mar 2024 20:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJ19MVIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E82882B6; Sat, 30 Mar 2024 20:45:47 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8DD882B7
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso711231b3a.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827943; x=1712432743; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mREBGQqmLvpBWqK2hSky8qNDt/orXRCaJ7Ql6tSlOXA=;
 b=AJ19MVIrSrkkTLoLdF0mHUUwP2QiqmNVWUlWsZdA/pIAIlhDe9o32r3ZOgq9MQcyNz
 gklHD31eOthi1KUO3sJz60h7fteqZX/M5a8w/eMclsKfL4cH27Et3gWUtu17Bsuudy/w
 BFuBd9pN+xcK7Q3okvMrdB5/l7vfVnIGiFnMBhnOT+2Ij1yOz5cLILNAsO9kB9jNs8CT
 Vdr4kjvvfyionwU0PPXCUdhGdod2X7JQTvMlVGHkweexPO3jqz/Gy9kX8CpR9jCe+uhH
 2xSqnfMkhy8HJ0VSD0s3z9MF3A2z7PZITZuxlWvj3uTgH/O8IxA7ZLRjN6bJTUB7syLr
 YpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827943; x=1712432743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mREBGQqmLvpBWqK2hSky8qNDt/orXRCaJ7Ql6tSlOXA=;
 b=YPXZT9RA5uw4lgDsrtkNneWLWweqt+vMmaGKCFPXNoW5sv6ihgDvxSd6gsJ4nRvJQW
 9bvXuMWbsQTjFZE8fHitKrwJ6BFfH3oaBNhFzMrwRsfhomobBO71IAp8mChUQooM8qAT
 DQAt/C4AKpJElhf9YaUjE321w/paONeo3PI0jIUk6WTYo3rtpuoKNLXevQ3ji40H/XAC
 vdXMHpdlmBA4C+f+AKeuXN0mLZeMPB6umfRIy03AJETudy0ndWhQVcIz5q3YBNljsx0Y
 jj3F0ZA5MK8uX+hXOhEsPcGIgYTtM8qHRTO3HRMKiVIVa1Ozo7lhfGiRjaQrzb+MQ17H
 /x8A==
X-Gm-Message-State: AOJu0YxfK1wiMj6ewrPaUPrJrZVmJVaBGT0ppujMh1KW0r0kOc5spMZ8
 IighRlz1bsxX1lC4bUEBh4CzpvWlcDvQ4bluuLzf8D2nUHcHmKBR1CFWtt17+ai1zTqcjlXBoti
 OiTJHjWWp8TNrsT39mcVooslarus=
X-Google-Smtp-Source: AGHT+IE0k5NTkG/r1txaEasr/buJv3GNFNUrHpX/aQ8Ai65+3uQJEZKCwAPQQFeUDmbv17D5+9zz8VdmHrLIQdr/95Q=
X-Received: by 2002:a05:6a20:3ca9:b0:1a7:c2e:41eb with SMTP id
 b41-20020a056a203ca900b001a70c2e41ebmr2452545pzj.2.1711827943218; Sat, 30 Mar
 2024 12:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240325162702.1350537-1-tharvey@gateworks.com>
In-Reply-To: <20240325162702.1350537-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:45:33 -0300
Message-ID: <CAOMZO5Dkk0VgA3guxbpehXp-Y+euGucZyL2pf8V897CoJCKmMw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm-venice-gw7901: add digital I/O direction
 control GPIO's
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Mar 25, 2024 at 1:27=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The GW7901 has GPIO's to configure the direction of its isolated
> digital I/O signals. Add the GPIO pinmux, line names, and hog
> configuration.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.
