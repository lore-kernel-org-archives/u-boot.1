Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E956C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 18:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA7780F9C;
	Thu, 13 Mar 2025 19:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWCoAJNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC4780FF7; Thu, 13 Mar 2025 19:26:46 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC6780756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 19:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so1541216e87.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741890402; x=1742495202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MPIuDdJjJK/U9zzIOVyOOMEbyvoLjA3wNe9ZII7h4y8=;
 b=HWCoAJNgEX4j8lY9BRHnRnRizDp+oDbRiJrWAkxK5XLfWLA4KozJLhh4l4vo+B1bW7
 dLBWxImlbmtzQLBHwLzjc7eLnqjXDf17B1KW00QFDfjp8GakIh3F+xvZHGd94wELymDp
 IPnKldgry6m+5iNs7ZZ3ehCMyKvTOktz4vexpjj0Mhz0LJE7sZ8zkJkiYgHReMtLjUGi
 hBTL25siXMMqvfNpAzUJt1vzu1MDOSbNO2vic7sSZMnVZaenEW6U+i+QvTfsYjjX8MvY
 J8PMdQlyq06vRoWSTxt+8Vknjq8imvy2ok/XMnuXWXaFHRpBGdlp8lVGA9XDm/GkQ7et
 StxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741890402; x=1742495202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MPIuDdJjJK/U9zzIOVyOOMEbyvoLjA3wNe9ZII7h4y8=;
 b=ntLYjCpsUwbEcudHW5cLBsADOAxFekzkVaRurVQ9DyiZU5BRQaH4frTeghx1MSwZ7C
 t2/o1eDVf+/tU7qpLVbM1uVteC84ciEbW10pt8UAfx2yXa6A9GLT8qy+VZa+ufL2Td9/
 hW5vC7LJ4atEESFTYlLrG70fsV6kWUO3SJ3pgFitVhoCKy1Ks7q4VuDi2p8z+7VZliPT
 3qApiGhSPOruBoAAsGgpF6wcfs3yNsRsCHrrN0JRMigVwkrGnUv/XWXWQILo09zDatZo
 syto2vGC4BZppRNS0KbighQuWESbrH/zyNwWoWBJbRjFscmMW7+HYls2szUVI7K7SZQ3
 lZ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW2xoSJUERtHQq/kvI4jf/pLFNB1a8loubXiN4ZM2gZaDdQu26p90XUqfq7iYSjB9odPMkH58=@lists.denx.de
X-Gm-Message-State: AOJu0Yzkzk4w/hxScV/uPIiQ6WWPOBJqjsrFnOCpCp8ZTY++5Df9+rG6
 bFl5eHmU4hNtk7C1NjhlSV7xMDOeDtFApcmlw+6WzU6TW55IyAqVU6+M0bst0Y8PAE2S1nFBnvs
 uc+zpOLlZtNwfIKVHYwQRTC1nVQI=
X-Gm-Gg: ASbGncuA/wfUWcEvI1G3SuBw1LcB66XuG7AtmC0z3yFvNHUClATC54F2O9tW6TBIZKl
 IcklM3eau6XztE8rvF0Iz3CqG3UEfvjCWutf0tkqngpnwH1sZtpGQX4rpnWK/rP86KQTrME53YK
 tK6aqkx+tSkZlfnnJ2RCC4HGujjNY17X+JNDP1PfWtESlYNVPrayQGVFQVIA==
X-Google-Smtp-Source: AGHT+IEISIFSIvdHgoxobeXeXUdkdew6em0+Le7r+t597tUentANbkz5qn5LyccDGYtWRCef6u1VZzdF4jUVhRQsai8=
X-Received: by 2002:a05:6512:31ce:b0:549:7c5f:d961 with SMTP id
 2adb3069b0e04-549ba41c038mr1489091e87.17.1741890401960; Thu, 13 Mar 2025
 11:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
In-Reply-To: <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 15:26:30 -0300
X-Gm-Features: AQ5f1JpKR7H620EQkhaJD1UiCUMvQ_0eH44c3XQlYUGOfGFdzQadmeKMSVb6XeI
Message-ID: <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Mon, Mar 3, 2025 at 2:15=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:

> If seems that we are working on the same OF graph stuff

Yes, there is a conflict in next when I try to apply your series due
to recent commits from Svyatoslav.

Please rebase against the latest next, run it through CI, and submit a v5.
