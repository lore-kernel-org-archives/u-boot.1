Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB1BC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 19:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E2487480;
	Mon, 15 Jan 2024 20:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDX2ymyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D074874B1; Mon, 15 Jan 2024 20:53:38 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B3486D82
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 20:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9b23698c0so636901b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705348415; x=1705953215; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klqOFrzx1mej8v9nOh+LxNgdRt1yQNHesuI+yNgKeMI=;
 b=jDX2ymyVcIwpnBVuOdE3Q+DkB6N1hHsjN5yq65g09II2e3BdhdzYM47tZBYDjY2+1Z
 YVzgLuv7AeqC+z8KPUS6J7yV2T0PgSL88L6MmwPxF+zZc/xM8FeCeioqx/Dkanlylm6L
 WxWXor046ZWO22IvfMbsMHHj64NZFEWWnkZRRqqIbTrtEEdEr5jjbW27ujDQqruvbGRE
 O3nsqGQO4DuXIQR0mgPXe8jpfrL+yQn5mnPBthbjUAM699C8Wsx1PYgsfMd6SQB5EB/Q
 3dLpf0fvDO2ArCxBsGa9xsdBelNX8/O3Tk5fdHQB1HRP3VU6Kxpo1k5D7wu4Fwqq0uo1
 GS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705348415; x=1705953215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klqOFrzx1mej8v9nOh+LxNgdRt1yQNHesuI+yNgKeMI=;
 b=JmpC5btJTLBkhPr3RJeAL2bIqmlvkiwZAaMOpKjLgc5mjK4bYjjrWmA4K+J+Ntg851
 90MnQyqHdRI19XpaLJvsqek5WzoJkqZi9jRAEAeW3hNNukM6diLuCV7IkZHVLbpy40+e
 +sozuLojQFAz4FOEOhhE1K6j3Gpmxz1/LSCP/TDi0NKVyPTkghKO475XBnqXqY4/mRtT
 XifvZXf+6qeHyUhL7O1lTyxMZqH7f/nLevI/y49CeMDrkyZQlA+IUJ5oIS0eAGrhvtDs
 VGqSQn88b3t2CU5eyOuCrEC3gIUGx3U2432DjWEP1fyFLu8TtCbxZfeDKml8YRREG/0E
 GjeQ==
X-Gm-Message-State: AOJu0YyhD1kgzP18c82WHxtKhBzMtbVOuGSrlmDIkWRIw4eNSnkd9ctk
 M3h+FS2BXoQv33wLpw0m7vf7JfOLpKiluL2LGcg=
X-Google-Smtp-Source: AGHT+IFNWM62bZYoweCoHFR2LGE3eqMY/y+K4kj8xxujUSne0lCDXkK5S10bjb8YKyhvVJ5Ky83Fovu1I6dBlxfCKlI=
X-Received: by 2002:a05:6a21:9218:b0:19b:20e9:90da with SMTP id
 tl24-20020a056a21921800b0019b20e990damr1578494pzb.5.1705348414851; Mon, 15
 Jan 2024 11:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20240115-wip-y-moog-phytec-de-som-detection-fixup-v2-1-993ac37f964b@phytec.de>
In-Reply-To: <20240115-wip-y-moog-phytec-de-som-detection-fixup-v2-1-993ac37f964b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Jan 2024 16:53:23 -0300
Message-ID: <CAOMZO5BQy4YKG7aqUUCvKLtDS5ACxWvgbN7tTqBMEbnkXgi+dQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Mon, Jan 15, 2024 at 6:31=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> Commit aa7858fe5e2e ("board: phytec: som_detection: move definitions to
> source file") moved function definitions from header to source file.
> Makefile however was not updated to unconditionally (from
> [..]_SOM_DETECTION) build the imx8 and phytec som detection units.
> Also remove unused includes that cause build failures on arm 32bit
> boards. SoM detection shall support 32bit boards as well, but arch
> specific code should not be included in the generic module.
>
> Fixes: aa7858fe5e2e ("board: phytec: som_detection: move definitions to s=
ource file")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v2:
> - change imx8m_som_detection to conditionally compile when arch is IMX8M
> - remove unused includes
> - Add reasoning in commit message

Applied, thanks.
