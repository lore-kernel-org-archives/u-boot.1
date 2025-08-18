Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9597CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE16582BF6;
	Mon, 18 Aug 2025 12:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lelyk3XF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34065830CA; Mon, 18 Aug 2025 12:31:34 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55C4830CA
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a1b097037so20279165e9.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513091; x=1756117891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3tCiRLPgEqS7AE8xp5IMQ3M3hi43NvSojyh/WxZBIQ=;
 b=lelyk3XFrYgb91kSaiVE53ikhRTeOyMSsuuX8qsuSJSVvZjOXLpwhWf8ihcTH6CZ2q
 Rvk8a6Azyt9r/1XerUajTyHyYjGlYhiJsObyeBi35NVyW0X9onrHZCiNML21LzFBbWsm
 mxeF/wmG6O+H0g7VCyXqhCCVU/XbWfXN3bHR/ZdFYwCIo/MEw72ac1W8oGdOSxfWJmFb
 20EWDedNDwkdqL+2jMoBKclWW1ds651H+rhdNrGNu8U557vSuXa58RKqlPZbKBBF3a5B
 en0QhqOfmWY9APrFyns+ZTfRabPnvSVqoGQ2qpSgs0T/Picyp73nIIT1MFFFqlhWWlwF
 egnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513091; x=1756117891;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3tCiRLPgEqS7AE8xp5IMQ3M3hi43NvSojyh/WxZBIQ=;
 b=SZoXM7rI9VVZteB8fYp1zfITr2aFB6F4JoaMc3JX0H+HO9MetS02o9hJ3g8DAmu1I0
 0ouJka5wcg/5+TEFsmnjGQlo8xpBqiP8mPkRw+LNFQCz9TzNB/8EfcuonXeDjwlb4wlm
 ZbRNbvgFQ7huBKhP7SlpT6gy+4oNqTR8lnw88FvTx04uTGC0X7VKjhW0l3173ZcOivqp
 PK0yFcRSp5NMh3yCGAZ5cGGmIeDs7UVwY3X1G2z8bFryOfBQQ13i+Qc5KgYFegrQmRot
 NqOUGjUEena8BW4qPxXnxHPy6DLA3c0PyGQJbdWxdusVbo+KXNOWQVujuwX3pgrPS5ZJ
 Bmvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJVATn7gLbuI71E9GYPwrws4qwVpozktWiXwjuPmGXKWsxdAOZD7fslFqRVQGQsFP08q+0Q5o=@lists.denx.de
X-Gm-Message-State: AOJu0YxTJF0s3ywVKAArqrgWk93FNBPK4IfLc7vED73QRIPwElTTqv+S
 TDTe0oSxqRtUFJZmWFSG1RDhUQ2WagwnXYO3q0HZaGSoOiSrEcKdLCrFK6+qtVhhMF9Ds0GAv+q
 zmVPQ
X-Gm-Gg: ASbGncu3+VF+uVe4oC/uzjbRPf14OYAu4tboWoZC0HaeIj+AI5EanLI0q6AI1LHnUXm
 t5pGT/WjfcQ1ANbmH2lLBzHJv+poImDRwM9Em/aGsym8WyCOrx4U85g3Nwe7AbH7q2ipQ21XMCv
 4DcJlXGMoKvPXIo01IiI1FiKEHhzFDobaVpIRd3M6mE7gHm+eRBQhi2IWT01TkBGN7bNONqOTGc
 QASKdqrGuMmwJksCP4hE5eweNLrHN5eLD3u4ApPJJAD+6ReUDyTZoNdlJBPwepL+0BEPWhzObqN
 IAv3pkuF+vfeyh603nOHK08spJZ5rKrSZun07Q4KnYG5CgC7Zi48je2z4YgKznOtozg9ZmRz95E
 RA0NTTeNxCAHDCtxeGV5DuV0Jt5iOQn0V1R2cNc+LN73jnPGSOW5joUMRNgA8e8lfzAU=
X-Google-Smtp-Source: AGHT+IHT5z+V39hN2I6EN05v7HVY/eMPoUMNdmwxhYsuqpqxAZcjYRzezjGogbPRfMNtzKAcaVGUAA==
X-Received: by 2002:a05:600c:4ecb:b0:459:d3d0:6507 with SMTP id
 5b1f17b1804b1-45a2679f1f3mr58616105e9.32.1755513091157; 
 Mon, 18 Aug 2025 03:31:31 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm172438035e9.21.2025.08.18.03.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:31:30 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
References: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
Subject: Re: [PATCH 0/2] serial: msm-geni: Fix Smatch reported issues
Message-Id: <175551308993.842888.1636080119569806141.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 12:31:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 11 Aug 2025 18:03:38 +0100, Andrew Goodbody wrote:
> Smatch reported issues with an uninitialised variable and inconsistent
> treatment of a pointer that had a NULL check for only a small part of
> its usage.
> 
> 

Applied, thanks!

[1/2] serial: msm-geni: Detect error from get_clk_div_rate
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f236451cb426
[2/2] serial: msm-geni: No need to NULL check priv
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/10e65926a37d

Best regards,
-- 
// Caleb (they/them)


