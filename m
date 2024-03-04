Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FB8C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0751E87BA8;
	Mon,  4 Mar 2024 12:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtO5Drv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9994C87F74; Mon,  4 Mar 2024 12:24:52 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 369BE87BA8
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e59bc0d8eeso781055b3a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 03:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709551488; x=1710156288; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0cgMRtTAuZBD5nDBR0Z3s/Gkx7xJpm0/yjKhqd1zcA=;
 b=FtO5Drv7g5W/VQnJYCQjcob6yP/AvRQpEXml4mHvHCehB5d+klluwo56spL2SJxs98
 Ns+sK3Ccksxi/DznFGzrbb2DzTVYDU3g+LWSlhw8BC6orBJiGdVLnJTicWwxrQeQJbVr
 lYNZRDiGdWThgGNzLbcbkMFUG72shwyqNE8O+QS60G3O4hPXVOoPv+QEdDwfM2c5pdgM
 fYldYrA2qgRcWaeieuMviVYm/rffjMNOAlJK/qYMGOmg9bZ7gfaWnWhPDhOUKuBS7Zko
 BF8de6p0r7GxqlJ9aMSsWDyGqZAdYnF7/UdPhr1kZzWhmbKR6R33Ctq/4tQlKEB/yko0
 GyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709551488; x=1710156288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0cgMRtTAuZBD5nDBR0Z3s/Gkx7xJpm0/yjKhqd1zcA=;
 b=TtTf7jDL7DHjUzeq8CRHkNa7xKuVV2DqHOUIv1jjUIdu8eoyNWwUfNv3rrZWsemFvd
 B1ZhvP/fCFljC6D4uhtsjcBxgdtYW3iv7it2O2i1BuaZSQVzRzwPRrgjf6g8kZBZMZnA
 zHxOqRpfFlkTYbgxtAg10mDTDRNGM/nZjNXPFR/65omSAPgoWdlysGQm/LOIadJY/kW2
 5gwCJiSez1Pb98qmxLl8uBUl5KxRIo8ep6iDI7Ehd9euGH2/YBEQ990XqesNmISOQQ7T
 ndrclKrG/GNAYtYPg5ZxwJeCSAk09F74KrjMExCGqq7G0ccJntKpOTXFXyJtXP5BBYrt
 CM3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE+ZL3slBwRkAMftGeybk4vXQtmiSUe6VwGic0U36l/tVpW4FRpwGPtW5cLoCUA54i6sGlMrEIx2+9SyEG8VJ1qW1uKg==
X-Gm-Message-State: AOJu0YyuoExuan+R3yYA0ME+rPOl4rmlG5Kgu81wMXXE9YUuwvc4S7y9
 hmMoL2GTH9Mq+TuTkL2FOPB/adjc8M0UJhKHTSem5Hski5RrxwA0Aiu0y0mjnFF8k7nxzTM52RB
 Gi9g94MDnFjkpHut/Up04u7VAyjI=
X-Google-Smtp-Source: AGHT+IFY2tlsvImAFY2qjQ9m76ukVO6GCZvRVCZpqh72GWJxy+gU5CvRmz9jDXr4rPS6LlsXmoW66ORczymQEqhtrtQ=
X-Received: by 2002:a17:90a:d98b:b0:296:db75:c240 with SMTP id
 d11-20020a17090ad98b00b00296db75c240mr7089140pjv.1.1709551488553; Mon, 04 Mar
 2024 03:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
In-Reply-To: <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 08:24:36 -0300
Message-ID: <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, peng.fan@nxp.com, 
 marex@denx.de, Bryan Brattlof <bb@ti.com>
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

Hi Sumit,

On Mon, Mar 4, 2024 at 3:33=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:

> I think you also need Bryan's patch [1] to be incorporated as well.
> Give it a try and let me know if you still see any further issues.
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240205-am62px-wip-=
rebasing-v3-11-04cbb42eaa6f@ti.com/

I applied this patch, but now I get a different error:

  BINMAN  .binman_stamp
Wrote map file './itb.map' to show errors
binman: Filename 'freescale/imx8mp-evk.dtb' not found in input path
(.,.,./board/freescale/imx8mp_evk,arch/arm/dts)
(cwd=3D'/home/fabio/denx/u-boot')
make: *** [Makefile:1126: .binman_stamp] Error 1
