Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0D6C0218A
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 02:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FE3811E1;
	Wed, 29 Jan 2025 03:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8Q+M0qq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395681244; Wed, 29 Jan 2025 03:12:38 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE248111F
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 03:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30227c56b11so63530161fa.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 18:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738116756; x=1738721556; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHfEsjLFabpFQ6PB9BMzfBPmHc81qDPbST7JaM/7do8=;
 b=O8Q+M0qqCBi+9J1ZgGr+VyqsmoDT38kv4gd1wdxpR0mU5ViJpGP8AfGBfZmAyEUPDk
 g/iwzmje0vP9HfsqVvwv4xIQ1bdFOJS9+zk/Z5GlcsbqkZMJIAWcFWoHoxu8dy4M23Z7
 xAfrfhTdN1VHa/npa/+JNKEjbWkqIxEbJ9uaFtMdk0kNi8o6EoxL3cpG/xrRw9CGX5NF
 s/ee0ZKvOM1aYpVoQ6e6ZfYNXzoYiNTh7iqcJjbVQuRrpIt0qo/ljKf+4dxedvCZF8bG
 km1PGVvjKHWOzmE7jRZiC7pdwTPZqZ5UBYxl6RyLz581FVrP23CrN5Iba8i8StKBLq5S
 nzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738116756; x=1738721556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHfEsjLFabpFQ6PB9BMzfBPmHc81qDPbST7JaM/7do8=;
 b=nHSEQNVPF23bLqDcuTrr5CBRzIUzGFZuQ4OprXZclotY3BM+Q9pmSERpmD/KYCULW6
 2tie3/xZIkSNVpXsg5EXCzyzmwXx0f6g8MG825HuTImGoinXtKfaFc1kQtxH+8dj7l6f
 Zc60USj0pqVFnsrgUx2ty0f6B29qXRNxjW/mJTHzDJ6I/8Za6bOIsU7B92w0d2Db538F
 2W+0WMLgxwltollRvVixqS4MIWsv5si1/8FcQ6zIB7iVeLlTBMqHUQ42zTsNjj/iwbPm
 oTGNC7U2XZIOat4bsgXuaOHNwzsxRMqcbQdzupP9nbqcyIkEC/YtJAO5CEGAmH3J0VCc
 IYAg==
X-Gm-Message-State: AOJu0YxUq4PQzcxw9tZejm20Sk4/yfPBTv7DkFvu/rf4hwuiFvNmJvSk
 ylFQEffoQvv1HSXXGqQlltSVxI4EY+PUJ32zsxZEn7cd+Bc/7cByVZ6ciOdjXz2j1nchM/Dl+IS
 iQxI15pqS3gjC9fkVWVzjI7CoSME=
X-Gm-Gg: ASbGncsKn71K9bZvQsPHxjcVlOsqzdTbWrdEYcR21JyjrGdvJswUPqStT9KXxpyJ0Gv
 Sgm93lUUgIjLQehIWaIR8LSQwOIMrAh+6ndGVPS3VA2Y85DYzPcUfrcfZNCcG6UxbeEddyGvhtC
 IVER8QyvfjT2J9FBpZXrc2hV2UCI8=
X-Google-Smtp-Source: AGHT+IGGjjupx3L9Q/MDylaahdHcDSJp+GlgX7qCzWBPuxeIUmEkjPdQSr/8J6Bl+D8uR6LHPHr+rF6IGeoksWB9cx4=
X-Received: by 2002:a2e:bc27:0:b0:302:3ff6:c8db with SMTP id
 38308e7fff4ca-3079694b6c7mr4136321fa.24.1738116755569; Tue, 28 Jan 2025
 18:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20250127211950.813813-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250127211950.813813-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Jan 2025 23:12:24 -0300
X-Gm-Features: AWEUYZnDcavP-Dk3swgPcpuKGgfykT0YS6lAhFTz4H0fPDp6QKKWnSjjwiQyXhk
Message-ID: <CAOMZO5Cc606nZfOdY+XOycQ5Yt9GgBpYh54i0Uv7Bf=OiXQ=rg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>
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

On Mon, Jan 27, 2025 at 6:19=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> The device tree for imxrt1050 is now
> available in the /dts/upstream directory.
> Migrate board to use OF_UPSTREAM.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
