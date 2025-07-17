Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187A6C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B9B83477;
	Thu, 17 Jul 2025 18:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ia/VXAmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25C383496; Thu, 17 Jul 2025 18:33:12 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9938343B
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55a25635385so1330439e87.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769990; x=1753374790; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFF+xGtc6dAe70D9awzHBnhCQ1iqej5ma4uaXZ5TrOY=;
 b=Ia/VXAmvCnszBMmYHsnjkkXyih/2uX7M59GvdoPGJ2s170Q8dFaj3arrASM1QzMJto
 MjcSrCXeXIbfTm4kPdA0qfpFkt0qQYZqyC/21frhLglRoI+6Z3QgLK3ZWlsF41aG1CgQ
 3ZSbytoWaHI8bPuQozBbsPHJUcOT816rbkFBHDwf3QwY1t7rNTicG9hFRzlzF+fIu/qT
 hD1oIefSVriyxzi5GYQlz5OziCR2KKgqZjEbGDtWU+EHqA2/fyMlGzxv343prZbCZtni
 vZqAEDddag1YStTBEz0Z7CWOLI+FbfOnphiNXeUuFS0bAp3CFjIVnmQNqTrxfImwJAZf
 u7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769990; x=1753374790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFF+xGtc6dAe70D9awzHBnhCQ1iqej5ma4uaXZ5TrOY=;
 b=dhm2cxOeYoltUmMRmwuR6uJweWa8g7VenDv8HQNxyd8yoDGCOQhdaKWOVhPFMOKlke
 6xiE/u/1bIyxp0lgAJ/Yix7Qbv8WQNBh3aINjfLSt+UJt5HFG5iQns3zxWFme/eDrOLA
 JearAcFKsIkixvhrAYMCbCVoCa+u+4GW3ohpoUntuKsDGSDumPXZscLddTZz0FgZvabb
 w4pEpx2/cMfLlaVFjheRh42K7ismNMA1ImP0a1J7MOpp0Ng9h9yTiLXwPvc1Rov5vLS4
 +ok1f5ZrmkSH7iGJ0G8hyM/kPQyMqyxYJrXqpwFHAHEgpEQBAT4ZNOsAWqjkOalIUUzb
 411Q==
X-Gm-Message-State: AOJu0YyMRWU96O+ylLslnuHx2wyGqWgq+E3QjQoeZwJih/BbWkcfQi3L
 ancOlooqKqQH1zlRP3xrh8zCPuiD3rzae8loEV3BscJMjFLevQRMoGv31spj843gCi+rylPY0zt
 7l4fByCuuGAoLzpoO/ytKaby8s2NI4KA=
X-Gm-Gg: ASbGncsyEFT3Ck+jHCt11xpL49EgvYgjCK1JjGZeX52boQs+y9ocdGcP8oTaVKZYS0V
 lOXtyOSxxt9zzUzLRvSlfDrC/9/poFii3b/FAMzz9jTlpKMJKXquGIF4eoamFZtkDnuMk0tVQFn
 i7K1T3WbF67gzDhwIINwxWKtEPT/x0Fql3FO55J3r0wPVlIbH8al850+lcU4MtTFYa/6GmATG++
 96ib1aTBRdI6bvFOsQTUt6dPe4zzQY7rTk9
X-Google-Smtp-Source: AGHT+IGSq6tWUKvRjPxZZfG5KdjF6e/j4U5JLwrGRT+rRVcMo8djwXGS6rv2yMPuYaV+No9zas/dT0am4YHVIcn+tlw=
X-Received: by 2002:a05:6512:1282:b0:553:da39:38a with SMTP id
 2adb3069b0e04-55a233012a3mr2167471e87.7.1752769989892; Thu, 17 Jul 2025
 09:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250712001254.232825-1-davidzangcs@gmail.com>
In-Reply-To: <20250712001254.232825-1-davidzangcs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:32:58 -0300
X-Gm-Features: Ac12FXyykvPmw_FtNDVfUwuoKJs-7YzH-1jLXtpXXjKxzej7tKgDF10QC0sSzA8
Message-ID: <CAOMZO5D7Lc978UPZ1RQ4tcTJEc_6yUGQ8C3KGLXufij7W7d10w@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx8ulp: Add celsius unit for temperature
To: David Zang <davidzangcs@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Sat, Jul 12, 2025 at 3:00=E2=80=AFAM David Zang <davidzangcs@gmail.com> =
wrote:
>
> Make temperature unit (celsius) more clear to reduce confusion.
>
> Signed-off-by: David Zang <davidzangcs@gmail.com>

Applied, thanks.
