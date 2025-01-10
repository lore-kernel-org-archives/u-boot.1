Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C42E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 04:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39BB6800D0;
	Fri, 10 Jan 2025 05:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFKqKGwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFAF80196; Fri, 10 Jan 2025 05:12:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6C28001F
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso12041165e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 20:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736482350; x=1737087150; darn=lists.denx.de;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hcg+AbNUagdr/GnXOyARNpX3VNRzL5mr6RLcmdmpWq4=;
 b=EFKqKGwlzxCEDrpOxhK0wsYqGA/UbwMk1kEIhWEJIugofpsNkQks80W8/XtVuaO8Ri
 pI9fnq2X72ewpCyCVXf9PlWmBtXqYgeYGM5SFbROhZgJxxLh5q/l22buKtZ/N43czRON
 FOxCHqsiYErMVntus8mObNng88xAXVvuy1NgPxc0nWQj1MtU1k4XdF+bb34Hgzy68aqb
 /cfXVxcUHePWLrDpechFeWmfdNEXKHr3cQUu2vbeWgVDp4VdJE3ult/rYijNoYmnH8vE
 3S36dyuZHklINKM1pGm7yNd3EN4hDQsXrHWrBvQFKq+oDHo0uM45LNsdlNZI3zTjc9Cl
 +iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736482350; x=1737087150;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcg+AbNUagdr/GnXOyARNpX3VNRzL5mr6RLcmdmpWq4=;
 b=hAirP4uu6n2XB/GKgdyWnIUW6KA6BdiGQYxAtpxD+SDhDy9GoA0eXXzg03+HYKoCZk
 RjlCdwERxD9OJrmtQzqvkAgl+1FSWx41Z6ajgMkZFUW6YU0i7TOClc8BJ6mZVkmdQkzC
 a91IM+4gg2LfGrjQovOG2jypgwJFZKCipgynLtUCdSRHAodFYgx12qTlG9t217JbQFzx
 aNFo+RUlopYZPsxPRJDFcDHgdFz/bWdfZBCaQgsKN4oEf4YKNGH1SKegODwEVmpE8ZMn
 Ez0aUREC8QwwnDMBwQl7OYTn3G2Z/3KUWVrRhEe+tEkqAuIuijPdCE755UozU8ujAKhI
 5vfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nNpWI5VMtvMiiTIPMDEYwQHg3Cw20pjxta5Zwj1FDVoHCE+zADeqbNwY4810IyWJPGSByng=@lists.denx.de
X-Gm-Message-State: AOJu0YynO3Q7nCfpmucmPQyv71fYE1Z9VuS1mntga9XXSb4dYbZmk3wm
 +2jyC/IwJQF4Ykp3YJ5tDxQeefr930mZ4/m/2xf+Otf7R2rs+8hytdZvpg==
X-Gm-Gg: ASbGncsqiUwl0QHBRMooEUrZSxnxc86kyTrFcgGXH/6petsM9xHDFHTnvCsHfsVZ3bf
 Zpgp/vLmMXcgTrpKAW1zXrnjPOR5+pX4rcxhdkED46RbhkZjI8kdz2xe3leZOuneEap7uK4ESa0
 vYhYx3ls8fqrIM+s7tfdV2HSbSHOhPRJ30wlHyH+WNpEgolR9WxUfnpRbkCysI5f8XEC3zkrNKK
 JKVWQxio6S1w5ZxTknhzPMeYW4Q60biOp4E3cTqHH4M6gaSlJH6FGgd/gyANhO27YlDm9BtRHvx
 EFk=
X-Google-Smtp-Source: AGHT+IGbDMIld2lAh5kd8KV7ln8byuZOqPwrIxJ4sixY28HelypxvHQugYQ+DIZdYNNqD3wjEoTaLQ==
X-Received: by 2002:a05:6000:1fa1:b0:388:caf4:e909 with SMTP id
 ffacd0b85a97d-38a872e8bc4mr8994719f8f.25.1736482350274; 
 Thu, 09 Jan 2025 20:12:30 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm3429114f8f.52.2025.01.09.20.12.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2025 20:12:29 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] board: amlogic: odroid-n2: remove amlogic prefix from
 fdtdir path
Date: Fri, 10 Jan 2025 08:12:17 +0400
References: <20250110040353.3424412-1-christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20250110040353.3424412-1-christianshewitt@gmail.com>
Message-Id: <CC4AC28B-2FB2-4AE0-B4CB-8FCA84D8A6C2@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)
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

> On 10 Jan 2025, at 8:03=E2=80=AFam, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> Commit 834e7c8136c6 ("dts: meson-g12a: Switch to using upstream DT")
> changed Amlogic configs to contain the default /amlogic device-tree
> path prefix, e.g. for odroid-n2:
>=20
> CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-g12b-odroid-n2"
>=20
> The board files also prefix amlogic when using fdtdir resulting in
> an /amlogic/amlogic/meson-g12b-odroid-n2.dtb path which is invalid
> with most distro packaging. Drop the prefix here to align with the
> board configs. This resolves fdtdir boot on Odroid N2/C4/HC4.
>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Please disregard this patch. I=E2=80=99ve spotted the issue in our =
distro
packaging and this is not required. Apologies for the noise.

CH.

