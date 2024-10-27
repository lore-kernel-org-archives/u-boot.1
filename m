Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED1CD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE22788EBA;
	Sun, 27 Oct 2024 18:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IWhfh1E9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52C28839A; Sun, 27 Oct 2024 18:16:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F5F88FCE
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so546018166b.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049390; x=1730654190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DZBkJNmXarid57cl3pkwOxghSVccSZQd6pp52ikZF1s=;
 b=IWhfh1E9p8HfIjDmD6DV/YIXfRF8nxFOklpPwuKTMokBDfWQLOlf2yValZHICuPJqV
 T893iohwjLOct9U4c7wvP7zUwSQieFjqWri8ourKECWO5z6rRdgsxiALVZYFn6sD7jI3
 Phdd3EDmO3HrgM6xedWT7mLDiPyDhqCagcX6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049390; x=1730654190;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZBkJNmXarid57cl3pkwOxghSVccSZQd6pp52ikZF1s=;
 b=Er7+LKgr5Ewz7MC6dslpTXdaxwS0MhOXiWI3V3srcSCJr4PMe+apMvZRf2dtY+z9+P
 K6K3LTsZDJyb6YIwa/u5SPpfkMO2v5vIeEXyleKsVwCHyb+TjARxWwGRnisBYjVGDBjr
 MzBTWevvcXV4+02ZQdFO/F+UWPB3dvFsfZ4ibCI3Sr0YxpWv1Kfk9J7SIIplCA4nOT9T
 pc2WQfLxAvnpOMWppnmCeJfDtLx2W7Itv6a4tfbke00RC2Nrq7ojZcqsRJ6eVbqlDzer
 awvN6Z5ODm2i/xmhVFGOOhrrHOzqBdwxY4ek19aC7OiZ5yKyOayZoo9BjmT9cN3cT3Lc
 cmdQ==
X-Gm-Message-State: AOJu0Yyxl3IhdIGkgNw+MFKb/GCrQbqOibdMYTzIYjJkvJcYOBMy43RV
 eDvIRy+lMUfcxczTN/mv6HIxh5KskAYVgzqkaaFpoyDfb8jQVEdsqxoPhCbQo1+eiVnR6jZdaO2
 hSSUN2orE7nrY6BE0dKxNIS9XNgSp5kB8twgbJBSNXXsXYzfg7Q==
X-Google-Smtp-Source: AGHT+IG/dt6cDLn8NRD6B2I6ugLe8LxKiZQFISJzFfiptyKlMAxq7MHdYW6hqfG/RY0BuV60tHYOnmQYII7JloMCxF8=
X-Received: by 2002:a17:907:9447:b0:a9a:c03:ebc8 with SMTP id
 a640c23a62f3a-a9de5fa914cmr548697066b.37.1730049390584; Sun, 27 Oct 2024
 10:16:30 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:18 +0100
Message-ID: <CAFLszTi9XE8oHuZCYrj85UVXVEYFDomqK=KrO5E-fTAn9_f=0w@mail.gmail.com>
Subject: wget bug report
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>
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

Hi Jerome,

Just something I noticed earlier...when running 'ut lib' I see this
failure on sandbox:

test/cmd/wget.c:215, net_test_wget(): 0 == run_command("wget
${loadaddr} 1.1.2.2:/index.html", 0): Expected 0x0 (0), got 0x1 (1)

Also, since it is testing a command and is in test/cmd it really
should be in the 'cmd' test suite, not 'lib'.

Regards,
Simon
