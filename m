Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC137CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4200F88C55;
	Mon,  2 Sep 2024 19:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b1JYjXwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8B088C67; Mon,  2 Sep 2024 19:43:03 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8704B882EF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53346132348so5531522e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725298981; x=1725903781; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAl246om1jTm4V7B/CD5rqwtwNCDx+A/b87INzhZ7FU=;
 b=b1JYjXwKxZKddRBYfnZL2XGH+OHx0fffyYRtP6odJMgjSd/FmGuCc55mWQuoNqFiw4
 axnM4h1G/QpoDoz0gkV1RApBZ+d00RvagBoaKgdhyQYhXsNK1/O5pfQSMsuA03ht8qdT
 0rESi4DOv3gEEkx+fr/DnblhcFVcgOPcibvSOUWKuomeSCXJK3J0+DBrAwTThfxSQBB0
 4YDKlFpPKg/HRJ1is/6UK5nsMtkEamR0gazq/BSMGjlo+2oXJ0xL9Os4qmQ7zUPSFQ+y
 zgUtI/9l/ucfgXALHaVgRzakzddcJBtdym9PH6ZdYWYtQab4Kw2Jy9lUvyI9K6p73qb2
 40EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725298981; x=1725903781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAl246om1jTm4V7B/CD5rqwtwNCDx+A/b87INzhZ7FU=;
 b=a1Yjl+fzZggH19DoID0KWom095cSTF21RZe1rkitEAHxv9Wx6qXMV+XUw5M3oqB3qv
 4XnmNd5xKfq5+4N4vCiYpENBBJ3RSf2gblZUeeMDx72PB3UK+C/CgE4q5ebIf1CZd8iu
 vpTsUNYpSq8WbHBQ9Yp1CP4eRwu7O2Li3UBX5zM6c6aGhm1ajINqKhMUeQNFt3x+cLBB
 IJmklpCNAOa2DTLz0+jg422P4/hkgQ1H3e9D8dLX7jNHBTt5EGBm5LzWtIdoHirYg4C4
 MSujIOuwB7eVISmSwiQx/LDi7MB4/eWXfqeQyzF8XwPhoaBZlDoxNXYRyjBi1c6Dh3E/
 SlIQ==
X-Gm-Message-State: AOJu0YxDRAWR194A0X2bIBERhn79KxakAj3ArI0dN9yz7HyGj0OW4kO5
 K0mprmGBj+CDweYGhrbNasvkPzT9C9QGg1YjrU9eJwrvusHFVe5jdHrPVJNPCrCimN+FNH6K/dN
 RU9zJmp+KTLMYMo8EO8KB5YBbXRatoA==
X-Google-Smtp-Source: AGHT+IEMQM1FGGpvEdpPEF9LyUmV9KD72e3Gf2Vb+0tS3kva/q9PTTvu2ZbJeqkWOhcmLnI6FeYkMV35v9SztvMZojI=
X-Received: by 2002:a05:6512:1091:b0:52b:c1cc:51f1 with SMTP id
 2adb3069b0e04-53546b2597emr7327149e87.23.1725298980391; Mon, 02 Sep 2024
 10:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240826180454.2778016-1-festevam@gmail.com>
In-Reply-To: <20240826180454.2778016-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:42:49 -0300
Message-ID: <CAOMZO5ARqAkVCmC-AaKeuiT=PJuzyAbY9cSR97C7JS3_Xm226Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mx6slevk: Convert to watchdog driver model
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Mon, Aug 26, 2024 at 3:05=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all, thanks.
