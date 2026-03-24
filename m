Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD55FEC0EA
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6804F807C0;
	Tue, 24 Mar 2026 18:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMR5ZA9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7FE8352B; Tue, 24 Mar 2026 18:41:43 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7044780087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b976536806cso857268366b.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774374101; cv=none;
 d=google.com; s=arc-20240605;
 b=b2XchKcEvTdmvyU+0ydFYhaNmjY1BCJLE3m5yP6CgiaAkTndbpLVfgCe8RdeS04dz8
 gpQPUk98d7YQ/0KNpMk0rnaH4o2le6/P2PFOZkweT5AI+e5i9wDDwz7Dg1VAYMZY3fBG
 D9rMptfzL3j82IcKE/1nwY/J/3O5Qa+UbiN/ZitRLcKQhrVA1lm+qsoLFQ5WsNJenqoy
 H81AJb6TfCWDytGDHHGqoTjhGjFxyjInGedY2/iuv0yFqHcMVahgaJQtNxA624FXpBjN
 QhQojV/IxzmBHh6ZHLzDXFigp7qfWkA7b0EEe3E32aiTAert+HsSAq7UfcKo7DwG4SI1
 qTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
 fh=Gb2fdZljDMqR4+H+st4eHLv5+wAJHO97o+s7XNXyHts=;
 b=HHg0/pUWPvKq0fWh9V85a/l2RDQRvnUZObS11eFiOQhysJnEDORPkC+77V2Um3INAF
 Zdpa9uOtaCEq0/KrUKI5sVxCJCCPP0G9H1AQ7zhGj1LQKfvk9NlDV596UF5o6Mkmo4Fo
 Lk26GvrSPe3OqiL/LXmDOCSRDFQHc6dYTEKeOtlux3919YsnpxYzxXtOvzUdAdGwifd8
 MS8GBYkVGY2t8I6K7aZteqYXv/RhITbeEa2jZw07ssJwhqIw/ZvpjWjTt8j11tziU3n8
 HAP+Uf9lTUyOJbbx5fWgb2T2a13C4i+FgpLnDGm3VMGcI+6uBGix/nFwiURNWK/RnECU
 1cTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774374101; x=1774978901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
 b=aMR5ZA9FITULSFJOXl1SJunYwxWS1yjC9blc5iLAK3oFnVqZxq37V52IiNmixPzd2j
 lFffgcPgn9gO5B82rimh4WlCqoQBo3+SFjNoqL8EfVAaZErfI4pExWlDvSpuS/oeZjJn
 ZZS0ndWwFLvwYrflbFns7RKJxWWPhmLYZuIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774374101; x=1774978901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1ottSAtczohD1NRXdvebbjd0FdcbbwAYgrYaA1gVbo=;
 b=M8lOj+2cAIU+ckdZM8umv4a4ifQA37roOefgmv2jN/BWwQbz5ol9jCikUYuApm9J2b
 6AGQgF1x5XUFcPZ7wIQvFc4mgn2zzy6Nr0poBcBj+llpoeJsBu7RVkuCXT9abjKipikh
 9rFqWbHfXGvXVYCqjoOgeTf02qkMavbstNhvgOWEfCrZlmTUdLzQiDb+1+Gp8Rmri6dI
 FKFDW9/PgsD4BIJ1xOBrmQHcb3/APW4DQpX92Dfw8YnqScPDV0QCXQ2nR4unU6uBh0R3
 BqcF15ltQ9gfCpbgYhahwbWzooRSR8x1f4M++iPDeVoI24z85lvoui8cQkEKnxWyYIqI
 pb0w==
X-Gm-Message-State: AOJu0YwKZeJQkyo66hfsaM/9TzEP5nvz4EpIhwQ1Y5Rtwtjw9GqarUhi
 okKFWOPgnHxqnZzHlTb1q3XQkPlJsw5OtX5RYaarjHbxKpHYRjhMkW4qqfOth0+zSenXyfk4qas
 gze0lLcopOlOgNrhNu/Txia0ik72h5CzYLgUfAPaQ
X-Gm-Gg: ATEYQzzDAwGE4Wv8bN23RJFbGLV1fXrSc3cYj53QzInyW6J0YoU5SE6M2r7ccx0ho4q
 7sXJ9v9w1hiqyxFYWHIGrWKhynd5/6H3Bx1RiV4SOSpEey18Rvk/nQPyxYylDUCOVyX+b6BWACb
 ZGQyQXtdzx/KKdjPHsroK/q9wkjQkiW2xd0KCcKIJJYn6+AwUjdexkXa3tw1RyucSPmiU+QAiic
 4rGwlVlsImIbM/5BESfjCRSZA8BOso34DnBCBWa4HNdY9bXac+pc/yPi+Ut+Aw84cu14gCtUj3s
 /7LCL+0=
X-Received: by 2002:a17:907:e11c:b0:b99:7697:76dc with SMTP id
 a640c23a62f3a-b9a3f1663d8mr18984566b.4.1774374100786; Tue, 24 Mar 2026
 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260323225537.896180-1-trini@konsulko.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Mar 2026 11:41:30 -0600
X-Gm-Features: AQROBzDoBbiLnL-H8z3_ppKXN1rO1G4g0-_SU87GunPz7GS7SCrV8NIEQMmqpLQ
Message-ID: <CAFLszTjN7ZSkc0vfT_KmN9um+v=--RRyV5OzJSWVirOT2fZWMA@mail.gmail.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, u-boot-qcom@groups.io,
 linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 23 Mar 2026 at 16:55, Tom Rini <trini@konsulko.com> wrote:
>
> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: =C5=81ukasz Majewski <lukma@nabladev.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: u-boot-amlogic@groups.io
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot-qcom@groups.io
> Cc: linux@analog.com
> ---
>  arch/x86/cpu/broadwell/sdram.c             | 2 +-
>  arch/x86/cpu/ivybridge/early_me.c          | 2 +-
[..]

For x86:

Reviewed-by: Simon Glass <sjg@chromium.org>
