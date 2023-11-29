Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927E2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 13:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFE7870B3;
	Wed, 29 Nov 2023 14:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VFlnG+05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3FA8706B; Wed, 29 Nov 2023 14:13:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB47086D12
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 14:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cc3dd21b0cso66387177b3.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701263591; x=1701868391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XH3mO4k+G6MpBHlc47wLCMbeTVphJmIha7HqNmn0+Do=;
 b=VFlnG+05GmAe8Fp/DrhqMTpkjEizhNWBoApco4TUKh4B1uJttIiXWeAM6EPTzyQ/As
 ISqw9e0Yk12pyhZ65Jo1ATOb/UVyyrBL8AiYm3tPEc3/b2EI0y0bYSmZkA+JKjN/524C
 bjXFPzRu+PLkXHsOSIe+FZL2dS+9SwiLeMvc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701263591; x=1701868391;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XH3mO4k+G6MpBHlc47wLCMbeTVphJmIha7HqNmn0+Do=;
 b=AcNtLaIBnOxpavb4RM9jvubdNiYjREjTH0DC2ok58fZxMouAqANuqhzpEy8+rFCzZI
 0mOdIe+pt+0h25ygQXDHWIQIPDapFJJNGTncpeJtNjvJGk2CjDRHyJReCnh7wf2mM48N
 OZfzo8byd2ykVNuaJCQyRVseyWHG4tYVgY63U5DLrWYmIo5qU9cCWGZjG5ooTZzsf9+4
 r7u8897NnFadlUBDpg2JAscSL9bf5MNlXwEkEOdgLWg7nE2dvcA3Qt0bzRHcoC2XV872
 mIUnMfHMD5qIlcipDDXo1N0juU03RgVhL/FathN3NNJk5sLkbH4DzK6njzO35k53eax0
 BbkA==
X-Gm-Message-State: AOJu0YyS+ZNm5w0n8i2p0SFjRn6txQWUorUXBbiaGBYNqu3DD/rB5S4H
 1uq4fPkxbLqFBBWehlBame//vjnliNmJ8C3wCXF/Kw==
X-Google-Smtp-Source: AGHT+IFlhw5GDk2xIrBTsmAVoeLeC8Tm8fPVFYOrSmMHD/TIk5oqRUdvQ/kUwerOpmBZXjbolxhnEA==
X-Received: by 2002:a25:4ce:0:b0:d9a:45d7:4eae with SMTP id
 197-20020a2504ce000000b00d9a45d74eaemr17981802ybe.62.1701263591186; 
 Wed, 29 Nov 2023 05:13:11 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a25f608000000b00da05d771097sm4198870ybd.22.2023.11.29.05.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 05:13:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: etienne.carriere@st.com, michal.simek@amd.com, u-boot@lists.denx.de
In-Reply-To: <20231114021428.531887-1-takahiro.akashi@linaro.org>
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 0/5] cmd: add scmi command
Message-Id: <170126359059.837865.14550655014121507125.b4-ty@konsulko.com>
Date: Wed, 29 Nov 2023 08:13:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 14 Nov 2023 11:14:23 +0900, AKASHI Takahiro wrote:

> "Scmi" command will be re-introduced per Michal's request.
> The functionality is the same as I put it in my patch set of adding
> SCMI base protocol support, but made some tweak to make UT, "ut dm
> scmi_cmd," more flexible and tolerable when enabling/disabling a specific
> SCMI protocol for test purpose.
> 
> Each commit may have some change history inherited from the preceding
> patch series.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


