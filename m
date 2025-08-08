Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9D3CA0EC0
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52AAF846F0;
	Fri,  8 Aug 2025 14:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gKxxCQye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD894846E9; Fri,  8 Aug 2025 14:56:43 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D199A846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-33230f1347fso17250501fa.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657801; x=1755262601; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRySwT4ZMZuMV7c9OcMkpSYDICnJ60w4ApXs82gZK1Q=;
 b=gKxxCQyeyVsdiA3eJVTteMS7LIRH6m1Vg44kJtoKjUHvO/WVOtAkAoYjQfv2TXWVWw
 wEgbpfGYaVynW2kr1ohRUP+OVK2M/5rMbLQ+ZOM/zJAOuIABzi3ESZEy6jfbBrrul8K1
 PSIUDF50rJ0GLABUzsGGLkfIKNfKWKWcckq4VMz2UXw0RNQ2W1MeaOy8NwUt3As3bDdT
 SDeV9OLmRZmV3iwCDfsoYryzgSw7dE4YhPQKYIF+vo3HeQ0XGeeWcXeaSLMz0YMmbcZC
 JzxBb+g9jBvxuYv7QjAs9gLQDJI3tUWtI1wlTK9HxtLphPL1LMP27HgTzWRk8wf+AteJ
 +g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657801; x=1755262601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRySwT4ZMZuMV7c9OcMkpSYDICnJ60w4ApXs82gZK1Q=;
 b=sDeOCsEnQm25jRNBS/PwdWgTlJDkfakDuIM1+OhByVteH/nAz33VCAeuWyyO6Dhr5i
 K1iY9KFFAK2hCabYl+vMqL/2OuoiwpZXk0TPZ49g/fIRiEF7846Bw5VlpvgovwfEHhxX
 P28RVRJt9wkQNPDyza7tk2FchQv5gUzxYXmnfbBQXAFWBvS21IiKKn1Yz1B5F+Uj3+i7
 HovQQ6PbLOslvQSBpJWonrpICl3n5hFspRQtvMaij2OMEg+Q48hVwGaSDibKcl39VBO/
 zdadKNFR+9gqXY9j//NYHlgBghQRokdaAiePc7FVmq5q2ZzDzewvWafCMhvXmIbitCyT
 8ySg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDWpcY2ugDr4xVPxf0pFZZpVj70cRopKJjrC1K5GdjwPYMGAMfCcbK+5RiwPN5WfGkPPCa9nA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlw8ud62fXL9RNxORdk4qnGLFL7aRzc0KtjK356oSMuikqaK6S
 PIdI8oJvnSuaC6PRJB+Lza9W7uTcWER54j7YgFFWXPjSDpQbuDGeueQpgytGEyVFGwMZd9iHPrp
 0J6ODlR9BHo6FxLWBNFG+Xq5wAVRjnHs6hg==
X-Gm-Gg: ASbGncuBSMdpjainivOiGdilUFNLlNghbr45uW/cmFL03gKIUqH6mNZ4GSXof+qtsxT
 Uph41SFadi54BZh23GarMV9T2X8rCmsZ+Vv4VEOJ6jGX3BlntGngy7vyJLCCcd+/z7fSnySHBOc
 D+NtYt98Qcedb0sXO/oG1XrIwnJH7mC826jRzy7CTE05F9SVVVqI2n1eGuGNzUPOyGrzzW4NJPE
 8eS3m9ZS6c8D6f+U4aUVMWcVFQI2j2Zp7pm7g==
X-Google-Smtp-Source: AGHT+IEgCehI6Xbwdqk458VKmku4s3Ix84uAxaqKclI8JNj5w68zu0L04yzC/kZO+OvPkig64ejBBKreIB5nuE6fRKU=
X-Received: by 2002:a2e:b546:0:b0:32a:6e20:7cdb with SMTP id
 38308e7fff4ca-333a22138b2mr4603901fa.17.1754657800945; Fri, 08 Aug 2025
 05:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250724-imx8_cpu-v1-1-f72f2755f0bb@linaro.org>
In-Reply-To: <20250724-imx8_cpu-v1-1-f72f2755f0bb@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:56:29 -0300
X-Gm-Features: Ac12FXzNxB5uOG1UxWK-KsvRKUlD4QRgkMC18_CyJhH2mbMVWTktRTyV9gFtV7U
Message-ID: <CAOMZO5CMrfUc56wKqSLxCK2-8kHc9-G=RJJQ4hsjuB2TsDLDYw@mail.gmail.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Provide default temperatures
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Thu, Jul 24, 2025 at 11:46=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Add setting default temperatures to the weak version of
> get_cpu_temp_grade so these values will not be used uninitialised.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Applied, thanks.
