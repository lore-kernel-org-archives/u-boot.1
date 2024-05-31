Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A9CC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 20:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB24882F0;
	Fri, 31 May 2024 22:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="KG/3mCrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11228831F; Fri, 31 May 2024 22:47:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BAC5881BC
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 22:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6858bdc9ddso127090566b.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1717188459; x=1717793259; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yNgIKySXcF9/8B2sEGPTbt5GYrRbu8ygKcEU3RfpDts=;
 b=KG/3mCrNAglVA9KxxW85gOF7wrCGHV1xt7waGy2GnchzyF0Q8fnVNpmsOz6X5qQQZo
 H1bxUNLeQMCuMI5TeG2EgkGMIrcChrCD0QZ42o2iT2TnJ8feUXdpb1Oe9GebwIk8rRBb
 vT3ZUwPD17lV4Cg5qyCh0Yj+rbw55jF4FhIVuV1K+Y8HpyR/q7NdxbVtkyDsu+zb9I2W
 sefFpEhkAxep0EM9thLFG9Af+LCr/2+J9BaBZPTOEutyvogJzKpd+2nnyTBUvOWkWHPj
 khyefNAaBYFEpGbYRFhsUCF+GxOfR6qfy5HeqBS7UX1HVdfZKshEnvg0ruCHPpNJdBsV
 6VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717188459; x=1717793259;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNgIKySXcF9/8B2sEGPTbt5GYrRbu8ygKcEU3RfpDts=;
 b=iynY5NeqRGw0bM1DihQRXX0fZvNIEEtYRXOqkV2rOGUY2Nm/Pdtn3VKin5Pr/dV8K5
 JaXGbCC36lMSYjodbGKDCeqPqaElwSlFRobp3kvuwuybStAgmFhXYTd4PAmuJYRTi+0x
 6ABeX2V72gwbVpwjcrnkfvp5womV+Am7J0zU6fH18xLGuNdGOiQdbyQ6bGnxhzgtyOy1
 k5CJWY2iOcKJn+Tmopscr4CLbnxZNxnAcVBNsFs0q3jJ+XSCcg5D8Z9HapBHo2nY6gvK
 9hCqIFEu5e5WWxzwgm8o5qserybWn84gYSWUVQy3qjtmHg1f11Dh+niQXtr+fq0guirq
 tgcQ==
X-Gm-Message-State: AOJu0YwQcSIDW5jji72rR9MWzOttINRKhICcF9IP1kytkPBncGac4qlK
 j1nGTl26PHVyhPAlXSy8VMaQ7l5j4P267b+ZYJutJE2hcN4RwjL8TN4aL2oUCf2O3eLbUk7+F3r
 p/QYYuxOgeLBBkc8G1UQprlExp4Difmh0rbaEC0DHuHgR/7xQbxqpeA==
X-Google-Smtp-Source: AGHT+IE2ahQcykB8Inrt656onRcQdyqgq3qoX0/iS8oPBhpbEvMlHYddl9A0N3tRYB0QAdjuBhEx7BGFZCGQ59wulCo=
X-Received: by 2002:a17:906:280a:b0:a68:4aeb:e32f with SMTP id
 a640c23a62f3a-a684aebe420mr190460266b.2.1717188459047; Fri, 31 May 2024
 13:47:39 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 31 May 2024 13:47:27 -0700
Message-ID: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Subject: obscure microsd detection issue between U-Boot and kernel
To: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Greetings,

I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
for a specific set of microsd cards if I have accessed the microsd in
U-Boot with UHS/1.8V the kernel will not recognize that microsd when
scanning.

The issue does not occur with all microsd cards but seems to appear
with a large sample size of a specific card/model (Kingston SDC32 32GB
SDR104 card). I do not see a signal integrity issue on the scope.

Instrumenting the kernel the issue is that the host reports a CRC
error as soon as the first mmc_send_if_cond call which occurs in
mmc_rescan_try_freq.

I can avoid the issue by either not accessing the microsd in U-Boot or
by disabling UHS/1.8V mode in U-Boot therefore what I think is
happening is that U-Boot leaves the card in UHS/1.8V signalling mode
and when the kernel scans it sets the voltage back to 3.3V
standard/default and default timings then issues its clock cycles to
'reset' the card and the card does not recognize the reset. I'm
wondering if this is because the reset is done via clock cycles after
the kernel has set the I/O voltage back to 3.3V when perhaps the card
is still in 1.8V mode (although I don't see how that would cause an
issue)?

Is there some sort of MMC 'reset' I can/should do in U-Boot before
booting the kernel? Has anyone encountered anything like this before?

Best Regards,

Tim
