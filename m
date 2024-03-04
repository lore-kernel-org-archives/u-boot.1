Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8DAC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FAF87F6E;
	Mon,  4 Mar 2024 15:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O1kPACGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E08F87F85; Mon,  4 Mar 2024 15:42:53 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E618A87EBB
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5dc8961f5a9so290064a12.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563368; x=1710168168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr2FEL3XJc2GqeKXWCxF47NnSTxM38mFtomKfZ8FD38=;
 b=O1kPACGTVg/hkHoycIXs9ZlamWFdzs0o7/K9oITjYJVVsrY4JJHot9YSK/gkO3htvj
 LT7ydWbYWc5nL/C5cedagf531XzBug3JcKllQL+4yyRbdlThirjgeCK6Veg6w30AZ9sg
 QHAW0kw6+vSrmlPIH2hNphUC5WeG6kVSC1Me1Up2o08deO3dvgUykCudWstLXvAeox3p
 VnAvWoqfKqe/phApxTraLS/DlU+db3TPfd9S4GXls3STVcVhsJd8jN9gPDfveK3Wp8BB
 PxNU9oIjN6ZbI7CDp3L41S0jY8yj4c9/ry1KPYJkSyvTo5nDaxWdGgrXYyETg4+xkEhN
 tVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563368; x=1710168168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr2FEL3XJc2GqeKXWCxF47NnSTxM38mFtomKfZ8FD38=;
 b=TXj+yxip/4TLMBXYMU+0kPMHm3CHImRGp552VNl4yrouhkmMLqFStN9p39uhb+IILb
 +DRqts9GwwKocOx+ykBcFlhJweXEDppmhgBD8hPLOQNeL1fvMXMWRW3YEaTi7FViJTcR
 33XGeJtNa+XtNKLpQKOtCP9dVIF1Pa3iK5dUwblGyZDkjrv79RAh0lTKqql2jmKiXwIX
 wkbfrvqnXKgVG+HwU1CHeMVTq1FZWGgzINl/gwZnMClLZJxe7vkA0dShuMObqRNA6GyY
 ixSU7h55GrGuWWuH7Sue0RqAZD3x+NcTO1Po0IGdyDcosFMEIu+lpet9o5B0mKpTOIrV
 3VeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUteoEGpuvFUOC/hf0G4jQ7bAON0pIwLE60T8G2sN/wL/9w+kDnr9LJyrrXpvGUlpy462/JYJhLxzmLwaaDg9xV4Yv1xQ==
X-Gm-Message-State: AOJu0YxMWUgVobV2DOVOGuySUdfVEAjjHk0Q1CIVBE60gt10OrmpSMQY
 jNDr62EVtZ1RGSX5tS3nzOw1eF/YMOz/N3OHE4VeXi6NeGKaey3WeWR0Aub844MBNAKYK/WZQVH
 LjfsfKCjG/s953Gu2V3ZM1EsQe5mAZ0qqDYI=
X-Google-Smtp-Source: AGHT+IFuAczXRP8MTygN7nptmYxWVyPbOevVdtYop+xWDGhOkl6sMdVdSWvXYeqRZi6zAkpJFjllb1PZcX0A2HvxeWY=
X-Received: by 2002:a17:90a:b78d:b0:299:25ad:7c98 with SMTP id
 m13-20020a17090ab78d00b0029925ad7c98mr7549200pjr.2.1709563368274; Mon, 04 Mar
 2024 06:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
 <20240304-pcl-070-patches-v1-1-6aa6c89e3b81@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v1-1-6aa6c89e3b81@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 11:42:36 -0300
Message-ID: <CAOMZO5B2BLAuMKeOHWJdpVwj0N9oWQJuNQOmcNfF_8b+5L+dRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Mon, Mar 4, 2024 at 9:31=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> Add a function that gets the som_type from the EEPROM.
> Add an enum for the som_type.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Your series does not even build:

board/phytec/common/phytec_som_detection.c: In function =E2=80=98phytec_get=
_som_type=E2=80=99:
board/phytec/common/phytec_som_detection.c:210:18: error: =E2=80=98struct
phytec_eeprom_data=E2=80=99 has no member named =E2=80=98valid=E2=80=99
  210 |         if (!data->valid || data->data.api_rev < PHYTEC_API_REV2)
      |                  ^~
board/phytec/common/phytec_som_detection.c:210:39: error: =E2=80=98union
<anonymous>=E2=80=99 has no member named =E2=80=98api_rev=E2=80=99
  210 |         if (!data->valid || data->data.api_rev < PHYTEC_API_REV2)
      |                                       ^
board/phytec/common/phytec_som_detection.c:213:26: error: =E2=80=98union
<anonymous>=E2=80=99 has no member named =E2=80=98data=E2=80=99
  213 |         return data->data.data.data_api2.som_type;
      |                          ^
board/phytec/common/phytec_som_detection.c:214:1: warning: control
reaches end of non-void function [-Wreturn-type]
  214 | }
      | ^
