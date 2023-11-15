Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E167FC54FB9
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209BF87285;
	Wed, 15 Nov 2023 16:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D5Uzle6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC76871FC; Wed, 15 Nov 2023 16:53:59 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F0B87285
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so4048268f8f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700063636; x=1700668436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V7r01QJ4eawwDIwrwGYDTTACjBEc9W9HRzeapszGhA=;
 b=D5Uzle6ilyyMXWWg7qyvT1s/U5+1TMsQYfl49A0UoF5xfh2sRJdAhd2IEqiutYvmQy
 Cu9FYZGwuIsYcxO3n3dil69chu8HrVwMbQKq8wiQubdwtymoxwZxqvz+oweG+i1G5IRJ
 K7Vxvkq3qRUHTUwxlv9z3jdVbzhvXK/hj8PCbSJWIwSeUVn+4S/P3ALQoSmthP0gzhKp
 KELU9xxgvbMFbgdkLaCMazh+sqfCQ0Miz2K4YIqb5x8FjfgseSgWWhRd7lT9Flh7ZGAP
 8hA9PYSJm474ivwxy6IASG47MX22BY/nlTFtrJ4BdaLuT03MDifguRhEYrym4X7FA+fS
 qfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700063636; x=1700668436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V7r01QJ4eawwDIwrwGYDTTACjBEc9W9HRzeapszGhA=;
 b=st4LNqEojecfirvGlaZMg2Zs5Je3N8MOgeGeFV0mZetPTC8sW2Wh/qRMyEPHq1+Mg3
 ocgKn/1SgfVRtJRHuDN1/qv+C1rT+Gy+OFKG4kut8lsZ9M0tfUgtnw/JSyNlBFQM9Sdq
 7JZTryX0h/o6nD6TsORTNo2jRVAx9VtVJi2PI6egBf2DmJ0zlzcMhP4A9xSTSdALiuGb
 MCzHytO9FD/xXsYx718eAr9ftf1ifTrO981kAtOOGIfdwtIdPxHkPyZwQtVvtedSA7vp
 k08pnSdjL8dhQmsNTIH4n914VQXuPBrdULG0/ow2wNZIiPrEyqeEF9S9eLaOmR6oFJ0k
 qdyg==
X-Gm-Message-State: AOJu0Yz93sEdFUWlGcR8nzTgxtGa3ERZQELXLDSvn0sD/mXhPGZXXmff
 ezYQjejMvJdptNGm6/T13twlKQ==
X-Google-Smtp-Source: AGHT+IGelwVjZqIy+qbkStIPSicmg7NDYErEHzRR7BmYZLM2tW0R+Ceusq3hclM0VxwFROsb5pYr6Q==
X-Received: by 2002:adf:fb50:0:b0:32d:bb4a:525c with SMTP id
 c16-20020adffb50000000b0032dbb4a525cmr7805885wrs.14.1700063635706; 
 Wed, 15 Nov 2023 07:53:55 -0800 (PST)
Received: from lion.lan ([79.79.179.141]) by smtp.gmail.com with ESMTPSA id
 p1-20020a5d48c1000000b0032f933556b8sm10938496wrs.7.2023.11.15.07.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 07:53:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/4] arm: mach-snapdragon: Qualcomm pinctrl driver
 cleanup
Date: Wed, 15 Nov 2023 15:53:52 +0000
Message-ID: <170006354509.1884171.1811409567367693249.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
References: <20231114-b4-qcom-pinctrl-v3-0-a7121677cca4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Tue, 14 Nov 2023 12:55:39 +0000, Caleb Connolly wrote:
> This series moves the Qualcomm pinctrl drivers from mach-snapdragon and
> mach-ipq40xx to drivers/pinctrl/qcom. It then makes the necessary changes
> to enable compatibility with Linux DTs.
> 
> The pinctrl hardware on most Qualcomm platforms is made up of "tiles",
> these are just banks of pins at different register addresses. The
> mapping between pin number and tile is totally arbitrary, this
> unfortunately means that it is necessary to have a map of pin to tile in
> order to support all pins. Up until now this driver has ignored tiles,
> meaning that the pin numbers and DT nodes are entirely different to the
> Linux DT and only a subset of pins are addressable.
> 
> [...]

Applied, thanks!

[1/4] pinctrl: qcom: move out of mach-snapdragon
      commit: b009e7e619d35043e9dc347999227447c8de0134
[2/4] pinctrl: qcom: move ipq4019 driver from mach-ipq40xx
      commit: 75ac9c61b973b96b3b6a81a7e294c195c71a212f
[3/4] pinctrl: qcom: make compatible with linux DTs
      commit: a5764aeb78679b475e97a12a9711bb07e517cfb3
[4/4] msm_gpio: use unsigned int
      commit: e319539a061e4cfc665907b4afcb57afd5c4e0a5

Best regards,
-- 
// Caleb (they/them)

