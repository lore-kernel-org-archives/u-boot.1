Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626B5C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB73388842;
	Tue, 13 Aug 2024 14:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tLbRWnHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93AA58899D; Tue, 13 Aug 2024 14:32:42 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6D6871C9
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36bd70f6522so2961499f8f.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723552360; x=1724157160;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cTZG5j3pAGUYW/r81VA/ySd/KdONQKd6FvAMtYQIHgE=;
 b=tLbRWnHTfHNWkFcj/JzvToyAG+rYRY+hak6Xg2THr2Rrrk9f5sF22SwZrYaL714AtL
 AYS5SRv3QKM5U+70gt1oQXcTzsI5DNpXqIRN1C/fqWQFlSbpMzVHxUjuq3wO6cQLLGyp
 v5YJVd6m1XFxrYHQyNyfPx6vE1MqglLmNuVdpgnpLUkZUeSQUZJfd3c38jO9lUayE/cG
 DgzxeAp5tGqSgczm9fEvOPVBFOgjb/jZRDfKO0Yo0Y6h77tBLDkHSFOJba8GicG3ji3R
 bqYWkJ5r0HamKcJN6H28hUPjFYlDJZvAW9gmpfRQfNJwqhIsXldYVzpoHdKQXE3OXqox
 GfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723552360; x=1724157160;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTZG5j3pAGUYW/r81VA/ySd/KdONQKd6FvAMtYQIHgE=;
 b=RQWYyxVA4GDbzgfb7MDsoxOnLOIi9pQJzcGwx+HQMXevVkRvUc8LfOb74CCuY283or
 bGhkUxKMcHBC3KP9LXYP9wU7eu8YILQcaBHcU+UKfDdhtRaZKaQo994wQMxiTpxcruVC
 HcaFcxaTrvhTKe6sswICOFoJvL/PTKNyqYUBk2lt8xMzPA+G03G6zsVVCrye2ism/bhG
 9C0VLzT7u6QybjDf4l432UasX2N3h7fMpaxq0THbnTSbvKVwb/wUypBVvvshI4u8Aw4U
 K6HQGA4uNavFMmfQ16O4qIzWLJ7slRyBFFJy8o1GGE4oP2ok6HJNODRsdaOdDkzcPJJA
 hhpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGLYfVa/k03Dtta/8QVZYkwL7MDzIr2hHj/2bMHQ+7Qv2o8OXRljZjcRIDjku30ZqzJDNO8U1AOwEoXrrW/4LJB31oYw==
X-Gm-Message-State: AOJu0YyJ3VG4p2ylLEsRdktAj5Py7q4LmTfqlVJhhNmEdAwmWqB0zi5U
 YNV8H3t+o8MxE+SHJoRC99QNgdXmfCKymLRHlFdOUrhucMYspMwYiPDManLL3Fw=
X-Google-Smtp-Source: AGHT+IG5YytO9RGLkaNXeiVK4bN9CztUrjhIaLp4TtWviVxAZD44F315UtmEMNJGG+AuIlFaZluhdA==
X-Received: by 2002:adf:e051:0:b0:368:117c:84fd with SMTP id
 ffacd0b85a97d-3716ccd8e6cmr1884922f8f.3.1723552359396; 
 Tue, 13 Aug 2024 05:32:39 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c775b015sm137572475e9.40.2024.08.13.05.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 05:32:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Julien Masson
 <jmasson@baylibre.com>
Subject: Re: [PATCH 2/6] sunxi: Add a bootmeth for FEL
In-Reply-To: <20240807205032.3745680-3-sjg@chromium.org>
References: <20240807205032.3745680-1-sjg@chromium.org>
 <20240807205032.3745680-3-sjg@chromium.org>
Date: Tue, 13 Aug 2024 14:32:36 +0200
Message-ID: <87bk1wsivv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for the patch.

On mer., ao=C3=BBt 07, 2024 at 14:50, Simon Glass <sjg@chromium.org> wrote:

> Add support for booting from a script loaded over FEL. This mirrors the
> bootcmd_fel provided by distro boot.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  boot/Kconfig        | 14 ++++++++
>  boot/Makefile       |  1 +
>  boot/bootmeth_fel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 boot/bootmeth_fel.c
>
