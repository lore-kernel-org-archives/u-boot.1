Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 18:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400858760F;
	Tue, 31 Oct 2023 19:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CxpREvtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D66875ED; Tue, 31 Oct 2023 19:50:03 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6048760F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 19:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so244916a12.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698778200; x=1699383000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rBfnG+cB9f8OKMJ7aQ8KF6gPPHD8RVlxQTDfZWB2NXE=;
 b=CxpREvtRoK7HdF6YnUWroE9MuZJGbLM5byAaROmEc2V6NJ4RWkW+RlO4rhJcM4rA80
 mVeZzU5K7wLDf6bWQuKfkh2is7LLm90nXccyPoe+TJPx7l1XSvTnn5GxmNtI5E9KEZga
 rKBtFPnqMmjy8wSYAU4LSVcX1gwLiaa743Nzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698778200; x=1699383000;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rBfnG+cB9f8OKMJ7aQ8KF6gPPHD8RVlxQTDfZWB2NXE=;
 b=ZvFxIz5sDhV3Qx91Ov2a8jue1i+aameSr9QqDT4RrOUtotPGZnAAMmpPEDUkqoBzGI
 +At9UbPx90N64cUiyO5kr6N1xeCQf0fiiupkJcOuy11TYL4S0YgbqePaMEWUqMozdw6K
 AAPIPXXiB3O8It6UvLNHrbVTEiAsvocVBNkbtiZ93XapLakWuyJ5CaIh3yZbF1CVlh+5
 E/LsSU6y5LLnjDuQ2hUdDfOCZ+4UoQDZ7e9l3Jpwl+KektWZ2+unekZL7qc9ph61AYlI
 vOye4QLpi8GRsK4XQystLMDzcQqgWBJtrwBBQ4dgcpqw9lNTNA5V54pNYt2/8ZTQEBJL
 FA6g==
X-Gm-Message-State: AOJu0YyQ/iQuATok4X2CtE1Uglx+/IryjRTlMsiG0TK2Ut7jiW3lfOVq
 nMssUvuwzuk7VDYQsRl3D9ONft6x1Fd54pRqhCqZ/69rZRV7AIyX4Blx0Q==
X-Google-Smtp-Source: AGHT+IF2c1kStHHvjnpDsMNQTQlalX4AgbyDg8KQqj7qiLCxYAMP8RU1IH/Q3MvwwEHh+/5D6AFwtvdA4l4ikC2Qklc=
X-Received: by 2002:a50:aa92:0:b0:543:57dd:503 with SMTP id
 q18-20020a50aa92000000b0054357dd0503mr2864010edc.3.1698778199577; Tue, 31 Oct
 2023 11:49:59 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Oct 2023 12:49:42 -0600
Message-ID: <CAPnjgZ2WT0NkisCdMo-1Jhe9ycXFZtFcGw665N_-Q1Vowepm0w@mail.gmail.com>
Subject: Re bootstd: Skip over bad device during bootflows scanning
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
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

Hi Tony,

Sorry I cannot reply to the patch[1].

Can you please send the console trace for this situation? I don't want
to ignore errors completely, so wonder if there is a special error
code which could be produced when a device is missing?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231030194650.11594-1-mibodhi@gmail.com/
