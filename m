Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70500C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906F787AA9;
	Fri, 15 Dec 2023 02:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuPRNnS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEDB87A9C; Fri, 15 Dec 2023 02:15:37 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E388887AA9
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c6ad67ab7aso37811a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702602932; x=1703207732; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc80pFeeBRTky+5SFAxxERIyhBX0n8LBw6HYP/CD0jU=;
 b=SuPRNnS3KUj8nXMT8ovPeF1T0xcOv8phG8WHwY25d8Edl4mr0iRBIzLC0BpRA6f0Gi
 LVe8zt3YLckO9+C6dQlSoIu8z5C9lZZgl3ZQOcHP1fxlLAbbAYXSl7tJ2nQFjgqfL2/3
 5QSfAGpn2IWxDd6e7C7739fi635F1bs1VRQIBALlocW2WqPxT2ndbpUOvlxTZ4PQOR5S
 6ONOJseugMXhb3CjhSIrGlRO+78CtFYqB52kINffNkRdP/c/T2uNelyvzWCEOlmodhgx
 HyaARAMe+DjTGAMoTjkVJhH1Ic+enHjfMTfvcfyYvauJiNkN2CixxgaxpE6lj9rlWX44
 YQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702602932; x=1703207732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xc80pFeeBRTky+5SFAxxERIyhBX0n8LBw6HYP/CD0jU=;
 b=NFalDRsofVZ9RJFtsuwvVAo4DuTfKpUyhw1OkEYOkxncI0QmYGNCrfwDtQv0R/FKU6
 dsyh/Te2qGh2Xfvbj1b3J1cdoyqjuTumEHaKPtZg0marnLOwWDR29DJgmXy08IfurCsz
 NlfdIP4+VODazqUIlwco9SxsyFwgRYyW5TjEKu3myHgqEkYSOe8jWkSNvWFSI+L2miAB
 LjUlrYmua8qncbiTRQvcbxy11pdZLQhDKcXWyi8NDTLaHnv/V/8vGxEf6uRC37VkEz+M
 VPaHwdu9em0hcq1QrAs6XT6mHTbZIfCADcrKongi2aSBDfUKkGFYIDeoq4iwDFwHUMnT
 3TRg==
X-Gm-Message-State: AOJu0Yy/hifaeb5bNz763gtjLRS2BVVyFKNczy/g5NT/RqV4i58DCswe
 y0aKfeHSRCBLA3Aw8j5/6fE3VFXJWP0Jhk9gaFw=
X-Google-Smtp-Source: AGHT+IHzw8Ba5vIPHbOxZijmStkFILMe/sN7HM/NgOdxgD4kLmzdOg5vwGs+de4nvT+N3cMbdukyoCNELbnvU4aXWbI=
X-Received: by 2002:a05:6a21:78a8:b0:18b:1f5d:b105 with SMTP id
 bf40-20020a056a2178a800b0018b1f5db105mr22546696pzc.6.1702602932129; Thu, 14
 Dec 2023 17:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214162227.1199831-1-tharvey@gateworks.com>
In-Reply-To: <20231214162227.1199831-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:15:20 -0300
Message-ID: <CAOMZO5CDPtbEoc4aJL-5BT6TiqzfQbi2VQdub0yJB1yCZn2J3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: gateworks: venice: remove extra file
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

On Thu, Dec 14, 2023 at 1:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Remove lpddr4_timing_imx8mm_512mb.c mistakenly committed
>
> Fixes: a1c711046b0d "(board: gateworks: venice: add imx8mm-gw7903 support=
)"
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied all to u-boot-imx master, thanks.
