Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8F7C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E768773A;
	Wed, 29 Nov 2023 19:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CzkXqTTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96B1870AB; Wed, 29 Nov 2023 19:14:45 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F7B877A1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-280b06206f7so11775a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281682; x=1701886482; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwA3A7dHOxpmXkB+oCDpmKPuHT1sQ+2Ye0H16n54pN4=;
 b=CzkXqTTXXeSInoWxyCXhEwGqZhaTWt4m02rOGXfA4sPGQZulVkPfEJiWGAPx8OaQwK
 Qxy/9mXKUr7DNnyKUYs/2RT0OubL32xpbVi++BG+VL5kB/vuhVfSqmOlsm+XcCTnKsgc
 z6pCYDpjjRx7kUtYnIvQ1Joq+viy1zYlvWNewpnUFvyuTt5e+WyiwWuOMKW64oD/dWIZ
 RUK2rmJMROWOtGqcrsBTvy015xsinl5nIBjztQloUSuZHsWwivMqoyXEF85npQo+kP+8
 yHG8tpFe2m2sIlyxku6KGGAGAlfovqe0C2uC8PgUFGI7eOcJ4spz/If64Mt3x4QtY77R
 icvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281682; x=1701886482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwA3A7dHOxpmXkB+oCDpmKPuHT1sQ+2Ye0H16n54pN4=;
 b=QzwmvZvqhoP0Wwa1Z8+w6Ee4dWDd2Bk3C4iXwo6XQdlZKCvb4DW0N+h4TDJDdjZl7T
 rXQN3bxcpkpJ+ZeSR8cjQriQBoOnwohvdrgn9J0h9aV0QD48sQq0Y++YuhKG/3XtfEy+
 OyutG2Gb0/p3WsdvJs2AL+jHcTr5jXyVRDA2RnDCv7MBaIaDs9ejeTLn6P7erzQ1Dm8/
 bt/KTzliZ/bpaijtTg9g90xE5wIPwYxHs5C8cvL9kPiWYy2YuNubZfZHbHNW3s7BBnbc
 t+UX7+554tgIq41zxxhNGylg+FKeDARw/P3xQQUBmBLMyt5mWpqyqftPMXK6vMDmgNkS
 Pcog==
X-Gm-Message-State: AOJu0YykMoy0mcrr6e82k8kU9SJzJnB4tAX+yxYK3YsRQSZ6qoNJt0/n
 owr1kpvoIFJ982ofVdMITiJdQAuy8obJEIGoM0ycn/f6+3w=
X-Google-Smtp-Source: AGHT+IF+yU8R3JuLBJUPeG77f/zEByViAfK/uwn0bUIXOC/sBrzQ9jzdP/aHSbPsEZAYuopEa7L45AaAdnW9MC8gVNk=
X-Received: by 2002:a17:90b:713:b0:283:5405:9e90 with SMTP id
 s19-20020a17090b071300b0028354059e90mr19244005pjz.3.1701281681662; Wed, 29
 Nov 2023 10:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20231104163243.117404-1-marex@denx.de>
In-Reply-To: <20231104163243.117404-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:14:31 -0300
Message-ID: <CAOMZO5C8LPM9naPFOy_LU-cCfxAT6vRrekVk3EuUiECYDHYVvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: imx6: Enable TCP, IPv6, wget on DH i.MX6 DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Nov 4, 2023 at 1:32=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
