Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F9CC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 10:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD18187E52;
	Fri,  9 Feb 2024 11:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TA1z4nba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FC887E58; Fri,  9 Feb 2024 11:35:39 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7225987E50
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so69607a12.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 02:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707474936; x=1708079736; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xV4BG/S3LL4ybBB732OTTVCuSHuQT7II4hlO/L1ydQ=;
 b=TA1z4nba65fmv0hmpOjxYv4slQKgU4IHwQJkLU9rCNcdBheyM6jJLWFIw7Qw+sSn0S
 rFgnIqsf+ma9OReTbz9pW0rbRXXRZhAMsaAm/w6+VPqKgj8DBMv8tAzSFUVaAq2iUyQc
 C9InpsSrawWOA3Ex0IEbzMQ7KaEWpDZU5gIdYhocUxJwwAzu0J4N4rLzlDNSEx3CuqAc
 Li7Ym8RryZ4SoHv+qGM8BUUzOlq74IlW0qOiPzAiraV7HdmbOdp5HbHjEC1evLfbHPt2
 adjVLiIdlyzm25cmRtA5EQ/taS7zjJkBwakrgC0218n5Ku3hUn5WBGpCffUExXQPGInO
 qJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707474936; x=1708079736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xV4BG/S3LL4ybBB732OTTVCuSHuQT7II4hlO/L1ydQ=;
 b=nXwVJ+bbM01hjVzvIV6lDMUqBb1zxwKNGZ1/NILO31NJlxSnk0gTVZcInKxzp9KhlO
 oxTid7y8sogrq2BLkTVNn8GTm9I/QsFbzBenfctuig9DqEv6NcgbQBjgARBRkwRVfLlZ
 GQuc08JI10bJVuYFXWIlYlqXYo7mp8VN1OgnmjqDwN5WtiQGYly2MgFchcZ+QNFrad/z
 2LdV3tDEr9t9PlbNUIpKQHGF7+b3lFCbPJgawpnFaOGNIeCXLfsd2NTezx0LrrsRRxtx
 s6r9sBRFnBI6PBasEcuGID0f/jzpa+Zr1HwVQ8AP7Yh+h/B8263caQN6tGMro25g4PHE
 LMng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkuVpyvTxo12C3qhKp3biIMTvyR5GbazBXq5OOKU6eJSI60Qupuq/2YaAVe7/SevjocCa8Pz6OgZJa7kJgyTnDmpKJ4g==
X-Gm-Message-State: AOJu0YzYQ7U0klLLm9ZOrU0404WhR8S+sZ314IXOxJTMs+m/WmtqR9JA
 gTXgOU89r8cp5Te33k5UNzC8TfeLc5XVISseGUdzneWF4hYFRYerfF69D/pSRsJdZt7yQ7SCI9T
 4IFWez3f9O+7Gxk4W8W4YvzG83wc=
X-Google-Smtp-Source: AGHT+IF4hxxlyECUe8RkNmYCUbeYUMkQblgyPN6ALOBSpL374cjbJao2Ocyh5joNafGFAyDEynYKhBJzzNUUOrtIVfk=
X-Received: by 2002:a05:6a20:8f1c:b0:19e:a9bd:3bed with SMTP id
 b28-20020a056a208f1c00b0019ea9bd3bedmr1417493pzk.0.1707474935799; Fri, 09 Feb
 2024 02:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20240208094518.391-1-othacehe@gnu.org>
 <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
 <87le7uyset.fsf@gnu.org>
In-Reply-To: <87le7uyset.fsf@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2024 07:35:23 -0300
Message-ID: <CAOMZO5CmE40nKAnhdnMxHxwQy8bJ=Fvd42VPUDb7cpVYVQneAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx93_var_som: Enable AHAB support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Mathieu,

On Fri, Feb 9, 2024 at 5:05=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org> =
wrote:

> No. I fused the board and with this series applied and the three HAFDBS
> commits reverted, I can boot just fine on that board.

Yes, this part I understood.

> Without reverting those commits, the SPL is working fine and u-boot
> hangs at relocation. It is 100% reproducible on my board.

This is what I am concerned about: this hang causes the board to brick
and can no
longer be recovered since it has the fuse programmed to close the device, r=
ight?
