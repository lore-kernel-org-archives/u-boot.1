Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1308C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E320B86F91;
	Mon,  6 Nov 2023 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7yYuUtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08B586A4C; Mon,  6 Nov 2023 11:42:21 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E60B86A8F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5441305cbd1so4968569a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699267339; x=1699872139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p8Lbpbs8buHWjAM4O/zBpQafpANWFszdLK821VSe6lU=;
 b=D7yYuUtGaQvOP7hwU4voltQwSTIdnYJljIoGOAWqCFGwqLOLXgTQzTZZ4NhVcxVwzh
 Zc/+31NhY0x/N6/2nNedEw5xbTvp3vkYuTokRwdUGmoqkFO19oD6O/3QC7i6kO8yrPk8
 2yhOikvlc0FNyVG+O1yNe8teT6kaVYj5pCZjNBpzApg6nkMitP8+FgfIFKnSubk4fC44
 lCi5WeIThifr45XTy9OvF+X5lVxBW0ZX4Bmp8cTJ1xA0mPkRruuVScBik+xnNkRGthpW
 cN2nn8LTi89Wkcii22hNLGxxGYUMVISgCytr79XIPcyK4Zz5z46z7up8sIhX42PIfc3O
 82SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267339; x=1699872139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p8Lbpbs8buHWjAM4O/zBpQafpANWFszdLK821VSe6lU=;
 b=DHfagIYpYaIQ74k74eZHmhE4KzuHae9RIvoBGdl4PZY6/eKGijeH+yz/tNsiTxsxWD
 r2po5kHz1hdYusAwRFR9NWhkEhnTWWo3GkNGiZlSNvlHBkDC9mnZIU7tZGzzhoL3XWtu
 wKfWtKtRapNzi+JGgiuDylxciHYMzi1Xp/ZFd1Ho69nBPAVuSMNr6h1hAMBHzshGYeuS
 EQ2nvS/F091RZW/XpW2l7bLRBiZFlDjiak6w8XtNmsrp4z2NP12w/mzWlfF3JQ4eiSEG
 Hg8KtNK5OIM1BHQEKVIgvkd6n0QdGg9/WZPhGSNORf6bkZNAPdfcX2lkWdZmR5ppPAWp
 h5eg==
X-Gm-Message-State: AOJu0YyW6wKUU+rrIsKGt9jm0JHe7lbQaFjmcrrsJkmVT+wm1iwFSaaE
 wqjciHWRsOuqz5XPQe6rqL8mS0+RgudpP87Ayjw=
X-Google-Smtp-Source: AGHT+IGKUUiOqbd9WBWGRf4CT/1rnS83o4R/ZIQieJXU9mxL4PgmhCWlmRfIekJ1JJ2kQG4NPy0/EdiyCB9QoH15Gnc=
X-Received: by 2002:a05:6402:35c2:b0:53d:be55:5fc with SMTP id
 z2-20020a05640235c200b0053dbe5505fcmr27757690edc.27.1699267338786; Mon, 06
 Nov 2023 02:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20231106101403.80409-1-goliath@infraroot.at>
In-Reply-To: <20231106101403.80409-1-goliath@infraroot.at>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Mon, 6 Nov 2023 11:42:07 +0100
Message-ID: <CABfBAmCFSA7DhvE9obZqFBQ0tPy4wEqfhkoReD0HEOofsFE1Cg@mail.gmail.com>
Subject: Re: [PATCH] fs/squashfs: enable LZ4 compression support
To: David Oberhollenzer <goliath@infraroot.at>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 miquel.raynal@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello, David

Thanks for this contribution!

Em seg., 6 de nov. de 2023 =C3=A0s 11:15, David Oberhollenzer <
goliath@infraroot.at> escreveu:

> The structure is identical to the existing compressor implementations,
> trivially adding lz4 decompression to sqfs_decompress.
>
> The changes were tested using a sandbox build. An LZ4 compressed
> squashfs image was bound as a host block device.
>
> Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
> ---
>
[...]

Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>

--=20
Atenciosamente,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
