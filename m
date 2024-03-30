Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF16C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43231882A6;
	Sat, 30 Mar 2024 20:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chRkHgoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727B4882AA; Sat, 30 Mar 2024 20:50:01 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64897882A1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ea7eff5f3cso451787b3a.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828198; x=1712432998; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTXTqIcqHAYuZFtbumYtrf1l3y4URAo6b4Fgt0uXD1w=;
 b=chRkHgoWC7XXxEroEXDvBG+D+axxsBfSeVNFb2NAwqFsVXTJE8L/hv2kurRpqEYByp
 B6CnPFg7ezdrC/FILiNtIrlVz/IfGmniyTOu0zvO2DYZaVlQY2b5AMzDFQFifokuutC9
 IMK2DobBKNyiYA8bQ8w3A0iKFecFpQU9yvYors1uBN0F9HAgncq0OG7+YZ5lIBeAwKzf
 y0N7Tn6s+avqU9Mo+WraLfwAeCqPav7oErTZrKZZtYpFUA7HF4Jb6PYN8sGwjl+Ul+S5
 Pg1rBFI0rn17afXF8sc1J0b8vaIMvTlNBsEZuV4uWcAKvMFTa2Dii/khVv/DoZrN5ttm
 h+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828198; x=1712432998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTXTqIcqHAYuZFtbumYtrf1l3y4URAo6b4Fgt0uXD1w=;
 b=ha2HfyBIEV4OID4wydLV5gUSrXqhf6ggCa8D+7Lntp3X/N4JyxGoEIJVXZDMaXjx02
 T5jY2qkc/vGQxsHm69eXxrtflcLTV/JVqTB9MHjTgqGB/YWEXFeJJ/lwIzikzW5x8F2p
 YznXDstWwImNqKIvcpKlh6OX9wS3M7mw+0gHYpGB91f02fBg5WMRLGz27UgFvmr+I11e
 V/F8YhS/rW1AxZw8+Yet3+sKnTfbbGBboQEHyMqEaB9DNKLuvBQzE2m+pEwSHuWfwdqB
 WzGQxnqdTc0sZe9ZtWBVjpBsZaxpQQeyy4QuBNJTa3FHKJF1zo0O9zn1dBksLOhGyjDS
 9Gew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7AOl2bwtEXJ3KWVZSC3Jk1KgbREqszKLTc4i5fKzO0F1EIYYetk+XXyFkG+wCz4BFFnPnZOLfvBsRab7+kiBur9GrQQ==
X-Gm-Message-State: AOJu0YyJ9P86GVSQQws0QZTmOdzZdF1w1oki4NgztoViv7WQx3MQdAhG
 AJwrqFMstUL56CutjcgXz/wcHBe3bXn/35DQmhVnLVeCcyJKK7ENoZiaZe1GFD7oCwty9Q2VZL1
 /Q3tzwV+fcP2p1x48ZyC11K/gnVs=
X-Google-Smtp-Source: AGHT+IEXbr0OZFZpE6QSJASskmHCD3uEQBZTWs0E/sX8gPu9hppCwyhwHsjoTQ8QqYg68qX5+gX6jyq2ogcEbxNCze0=
X-Received: by 2002:a05:6a20:7345:b0:1a3:c603:61d4 with SMTP id
 v5-20020a056a20734500b001a3c60361d4mr7637447pzc.3.1711828197950; Sat, 30 Mar
 2024 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <1711622958-62199-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711622958-62199-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:49:47 -0300
Message-ID: <CAOMZO5AD6oBsm8FUXO7S53rMBi9JnriBmVUCrgaP9pd-NdHnUg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx9: Fix MMU map table overlap
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Thu, Mar 28, 2024 at 7:49=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The size for flexspi AHB buffer space is wrong, so correct it.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to u-boot-imx/next, thanks.
