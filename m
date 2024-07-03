Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297A4C30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 02:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2111E88738;
	Wed,  3 Jul 2024 04:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aakfbCVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8181088784; Wed,  3 Jul 2024 04:01:44 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2536988738
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 04:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52e7adf4debso508151e87.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 19:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719972101; x=1720576901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTE9BEO3SF8km/JLPNG2jLUMQfr3bAvE7oxKPERm1hI=;
 b=aakfbCVDP3mIXMsNMPsN47IVWYshIL/qNxnFr/a7Lu1LIAkHAvHzhfHVTpiIoyasWA
 HTy3oVi7F8Th/NTGBxwBmfr7tfVTNFGrEGTvO1ETlD3Vqd1a8gEsD1P5gkm7+ufNUJiv
 nmrjEgg5gpFVrE+MEtIn+9IQnwOBWWxL+A7AQ7DW9PJzjUUVhsODolyyZtLBmGwoNoh8
 omf4JqQnsfDKnUmc2p9w08j9n4HAVQ9DwVP0cYL3nTwIenPegk6PkVQI4Dm6dO8fH6oN
 faBC4fZBJVtVfBq28U31A53XMZTT35Wpq7x2fx9vqXgeL68O9TtCxp4E7a1jFReBahyA
 GkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719972101; x=1720576901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTE9BEO3SF8km/JLPNG2jLUMQfr3bAvE7oxKPERm1hI=;
 b=kTdmoHWHGg6CBsigrpvTnPsnlagF3ldAziQgzQKv4jLfzhFIyrAfmw7OdbfLBEsEMw
 n0s8/Y/qhXxrY797hwhxr/WySSlrK3veW8I3CVDPtv3/2doVN/NvDT+B36IuG1XCUUsP
 LHsOeHWHkD11xU80HTfQ6YeVovPjKuquV+npFZHW8TrmOLH0APpjKnUtyB7ykmzilbe+
 MTNq2UHV4xbicoteKiG8G+llr796PfHckMppD7P+a3QGBY4XjzbfLaLnMBdlMwG2JNPG
 otOhPO2tmJWqSnL2irejvsz9so9Ku8NKV4ZLsccnqeSj9xvZDw84ptEvOrvTqOQvCk/P
 zREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2fK0RcUeLsewyUwqwEWab8xMVEd4+sec8fz/tIUTzbl6vfkja4ZmoPTTs9jccCLtjPvXqDTUAyCD9PSrzzpmcTGhIfQ==
X-Gm-Message-State: AOJu0YyajvNz4kz3uMcVh0X/WMPpp0mZddbVIYzM13sBSMZEOYRDLJFb
 OWBTxxqkEj33swK7M9rCinUpVYFi6WQH0vBcQqyv7fegt9XtOzW+R0iYAgSWcVmWYTO5zNWUzKa
 8q6B+e+0e+ku1u3PXm9zIbAD8ZQg=
X-Google-Smtp-Source: AGHT+IEQYSl33WSVA1BXLyf1/ng9OotcxLrt23Azf94kUrfYkX37xYtDi6uS8DVYxL72aK60miMOsR6Ej6sEV5d12tU=
X-Received: by 2002:a2e:9c07:0:b0:2ee:84a1:9be4 with SMTP id
 38308e7fff4ca-2ee84a19cfemr1479021fa.2.1719972101071; Tue, 02 Jul 2024
 19:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 2 Jul 2024 23:01:27 -0300
Message-ID: <CAOMZO5CPkTdRb8-UtFeO1xv4RLhp_nJakf6OodBPdV=rS0M03w@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Fabio Estevam <festevam@denx.de>, William Zhang <william.zhang@broadcom.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, u-boot@lists.denx.de
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

Hi Mikhail,

On Tue, Jul 2, 2024 at 10:16=E2=80=AFPM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> The patch fix a missprint introduced in commit 2e9fe73a883a ("spi: soft_s=
pi:
> Support the recommended soft spi properties").
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
