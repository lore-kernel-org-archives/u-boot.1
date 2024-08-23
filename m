Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C773C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E9388AA9;
	Fri, 23 Aug 2024 21:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jzxz1huY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C99288A99; Fri, 23 Aug 2024 21:15:46 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D23D88A9B
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f4f2868621so17046571fa.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440544; x=1725045344; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewPjOu1xc0DaPiY+qyqD3ziapoEYBJj5Pajv0D6sevo=;
 b=Jzxz1huYr3ZJPAosNTcmi4iaQ+JUjUgvvNFaTmjhfFA/0cDpX1XzxU8LZtKmObz9yV
 vkG9MbbMj9ysungvbqxC8k7v+TNSsdHNvpLUdnV0ppLXIqc51yjvRTVOGWrWE34Qc2FN
 Ecgj/IgeoxQ0SysK9nYWSil+O+2ID1TkZvL2WNE4qpE3vkw9A7Sy+ti/8RrKH3cu+XzH
 mO2NvFyDpdbV0klUFRwy+zN7+bE1f2Tbm9Omxz7YfLYzb2FREFdF7H+ubpbsc9pnzH3L
 eTiBIaujhGH3R2OlJaFMo8beEPQcRzD63Le1myRAFTY78Ng8T7V6jhi/DASw6ELtaW70
 Q+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440544; x=1725045344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewPjOu1xc0DaPiY+qyqD3ziapoEYBJj5Pajv0D6sevo=;
 b=T0dtskRCGHZbRpGxhEriw/zwQk5jnauDDuzXW0AW+MdxevRaw9U6yTeSOwJHlbcV/n
 aZrNX7CKuR6aUGn/oQifUW2lqS4lqwQR/7t68EePcnH4TNtszRYSrH/43qrcCXgqkzXl
 7U9QTIX57IzEP9We/+MHHW3Eb8scoMylTC1EzXb46PO2AJOePDSXSSOmyvEoPILbES25
 5e1SCIzl5E+4KdTQvIG4tkRVbJalwnztaUobQxPdg7axRla7FY79A8AAOs3oTK0woh0Y
 I0Fku2yBVsq8prYT7vMXtfl3XrQmaxALUBWBt3W7oRNDVppQRmzP+STPjQ+HK3f/BkoK
 WFBA==
X-Gm-Message-State: AOJu0YwAwJ96mnfEeMllU8j4JBKeHc06eWQ3KRh2waw63P2ejObnb85e
 +8fk4kp30ChMNvHx1Mzjx8Jmk4XDeA06xbou/ByX/cIQAm/iBQZe/vLNGJj4IXO/FaNbg9aP5rF
 tHDBXRP1FIgeakPJ65pRe2I360FGL/g==
X-Google-Smtp-Source: AGHT+IFosB/sI+NStwYiBuy4eq179RLhXBk9aK+QA7vYOIcFQnr8iNmzu9uNgV0+yXUOIlqpM9ceJeojJ9fl0D70cPY=
X-Received: by 2002:a2e:7d14:0:b0:2ef:2dc7:a8f6 with SMTP id
 38308e7fff4ca-2f4f5757030mr17880131fa.13.1724440543565; Fri, 23 Aug 2024
 12:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240821210345.269145-1-marex@denx.de>
In-Reply-To: <20240821210345.269145-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:15:32 -0300
Message-ID: <CAOMZO5CTC05C3K2NuaknyhXpFUq7ng0xjteSDwycPA+ETp8kTQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable cat and xxd commands on Data Modul
 i.MX8M Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@denx.de>
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

On Wed, Aug 21, 2024 at 6:04=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable 'cat' command to print file from filesystem to stdout.
> Enable 'xxd' command to hexdump file from filesystem to stdout.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
