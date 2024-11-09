Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB0ED5E366
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 12:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C5E8909B;
	Sat,  9 Nov 2024 13:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZlIdpqMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCF08910E; Sat,  9 Nov 2024 13:06:26 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B36189072
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 13:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f53973fdso2966584e87.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731153984; x=1731758784; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN6v0nm+jHJSKVXVP5ft2eFE6IV8lgazSwgQrU88AMA=;
 b=ZlIdpqMHjQolb0qUx2UmcgGFCIjL0Yu6iBO7U+9LCvljlgqnwyaHP9tMbQIRZRi/gB
 BTuaxmY+HmojKmPwI4TLL9SKraSFaSUS4h53b4swgq+lMuJTk5KpTwzhZTk95PKiD6UJ
 AW24r+uRHpzGl7iGEb0OcesEDBbOvQ8DFxNOv4v5HWd8jhfZr2OWx5PBS8Fqz8k8kFYE
 Wac9eAyisvBGLuxnjTjN2TWNs/YmlDEVR3SvMGi5QutOfpCTCQq8rKE5kVrs7d6hBx4G
 ExacOUWKVYzIGCmkINnOeE+FhD/BaYB8FGm9cEPiymvxI6hnHpUnYdsfnd/pGOHqRIeh
 yWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731153984; x=1731758784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fN6v0nm+jHJSKVXVP5ft2eFE6IV8lgazSwgQrU88AMA=;
 b=KnsBzjREOpJ1Zf69KRA7soMh/N7eHk6bplENstqMXmVzREjelcErw5piq7aMdZyI58
 UOXJ3z/y952anoa3W5m6xahPQ9qtEHSrdb4NEWFXgSh7YBEuzqr44qgK/7IIUezFLkX3
 IHelSrggX6mEXciD6iTZfW2hCpyYjA4+e8eo+eRfOJNTf66bRulxvdU3qrRpw6zhKEmm
 pz/zReXu4zBY3IdhAN1VysdePUMJWJxvPqJ49ci5NYJwVW/Eq2dHK3/KTeq/yq3ippUZ
 gpSISXyg+Ors2FbxzD7uSEqLd1pCk8g6dzNMDvQ3TtWMfuBL81dI8EPj967NogHQrYSg
 eCIQ==
X-Gm-Message-State: AOJu0YztsEFiR8DrLEAMRPO1oPJgBEhKswfXxXUc9TVbZB4YS469aR61
 QA7USLQ/k72b/gIpPndb76jIsG1hN0kUMIT64gkMe5cGhSdse5NS+ixMsTokEto/ETtakVTpNlh
 niVa55tm+SsXVQliA4t0iv08+iKA=
X-Google-Smtp-Source: AGHT+IEaEmMRLN24I8p1j3QpQS8S66v5iul0PZG6FXaFTm3XmysNm9Dq3+XowF1fALESgVpIqYyIFmpjiuKANOlrqso=
X-Received: by 2002:a05:6512:1395:b0:53b:48f2:459b with SMTP id
 2adb3069b0e04-53d85f231b9mr2204618e87.23.1731153983339; Sat, 09 Nov 2024
 04:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-21-hs@denx.de>
In-Reply-To: <20241108052143.26874-21-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 09:06:11 -0300
Message-ID: <CAOMZO5Btc3grPOChT5VQyaLWSx1uyKHdBgH5q3m3b1s_neiCrw@mail.gmail.com>
Subject: Re: [PATCH v1 20/22] siemens: add ddr full memory test
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Heiko,

On Fri, Nov 8, 2024 at 2:24=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Add siemens specific memory test. Enable it through Kconfig option
> SPL_CMT.
> The test is required from our HW team. It runs over temperature during
> many days:
> * must run indefinitively through the whole DDR area
> * must write/read/check all values

Isn't it better to run a utility in Linux like memtester for this purpose?
