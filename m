Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100C6E9A04D
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 22:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27A583C19;
	Wed, 18 Feb 2026 23:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QM/H2gXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0718A83CF2; Wed, 18 Feb 2026 23:33:59 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C917883B99
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 23:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45ee8823e2aso178363b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771454034; x=1772058834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tMqGuOT+lNA2ajn4YKuyfddisooWCznkC7a9HAwqNM=;
 b=QM/H2gXuzoYGuhhTTQHMrtPuiDxvQTnYsSOQ40Xlu7v89IwgmRsY5JGkPL1L5i7cHa
 yuzfrC5QZ1zog+dn9U2FKTx4Bkac/VU/GlIgJ+3W8j/A/E5h2ZE7/cRonuefUMKr3WLS
 W5Tu6k5Au82QBPnNOjOA06Y+3u8RAw7rRLcL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771454034; x=1772058834;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/tMqGuOT+lNA2ajn4YKuyfddisooWCznkC7a9HAwqNM=;
 b=TjNnS7NxjexXJWmLH7Zcq0cABhsxZIki5j/3wSPfWmGwWfIiRuoE3/gszrBGhweQnN
 pfLWhYZ93YgiotDpb+K2LOfTTs6uJHPuOMU1Re88UeoyZ3+pqbSKjA/894CT8MSw22sp
 3puYx6zdAE1a6FVN1rU0XIFHMRDcg+0aM2/z3tgJJOsitzmCfDFg9Nns9oPOz3x4/mkb
 RcwZzVBiuFsMkMEwa86IuO5Hv4GmZzDBryQ+Om74p4sNtTwJSUQcF/jjaZFuFjCdGz8T
 jV4uhK5cFGbd0rP6fWQEIjf9fWg6kZrRwQZtWBbXBmGyiBkLmRRL2LH7oKuxOioirW8k
 OmzA==
X-Gm-Message-State: AOJu0Yzbvk3xn2dK28pM7dnmtcHT4bbl/yq0lyu26vtcQObUUYv7VRMj
 8Q3YyteQmXb1PINPNkPjqdkhg2TQEulZg/3mzhrpTC00JmN76whbHpjW4WrpVQTBrf0=
X-Gm-Gg: AZuq6aL+iVF0iM3xJIF1vwHQcXRlw9v9jcZHb71Wwm3gsUJDXt+kGCpZjBGA5I6AYTf
 cUm0feDjGuPyRzeoU8GcFADvksJ5nAfVlryYPx527l3aGFCDiH8hND+/3yE2wQOH8mfWG2Ep5Y5
 l59h9926ww4h//oFVERXNzAv0i9QI3T5EWE1tkcsAoVzOwke/LM6Ic5Kin7AC+1rv4w3kqe6nlL
 73IRZlQ3ehdFcEyTjzOPoeekLHhBBSlNcNrrQ1ar54wTsgpQU2qxio/GPsMjBEIlgrbrfzSHvIT
 GsexrwMyLyPyno7J53/vPatAdlPsK+qUrhoAYDO+pdX5TnRHLG8y93u8QsgHNe9Ys5tpqJT/lBF
 jgr+pvCX0gvTcWZcBTYwotPOK3LREO9fpLAn8XIM0r231soE1e6Rc2e7zI/ldD+wJXQpR2y5XHX
 C6ANGxIIOulq6dBIqjM8Fc6VaAS9ocylZZ9swoZgLlnh3o5lJ5W8UW/CJcOp2fIqL6c0sgFKKO/
 jMO5F1g3VJnPXjcl/XLx6ICG4g4KoAXNN7nZEO0FKXXuB6+zTPtLA5ba92B
X-Received: by 2002:a05:6808:10d5:b0:45e:ada4:f2ba with SMTP id
 5614622812f47-4639adb8b4emr9386051b6e.38.1771454034508; 
 Wed, 18 Feb 2026 14:33:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-463a20598b8sm11601438b6e.8.2026.02.18.14.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 14:33:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
References: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 0/2] test: cmd: Add test for zip/unzip/gzwrite commands
Message-Id: <177145403342.3679933.3113762067625135878.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 16:33:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 05 Feb 2026 02:40:43 +0100, Marek Vasut wrote:

> Enable zip command in sandbox so it is always build tested.
> Add simple test for zip/unzip/gzwrite commands so they are
> unit tested.
> 
> DEPENDS:
> https://patchwork.ozlabs.org/project/uboot/patch/20260128194049.278542-1-marek.vasut+renesas@mailbox.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20260128194117.278566-1-marek.vasut+renesas@mailbox.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20260128194152.278586-1-marek.vasut+renesas@mailbox.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20260128194226.278605-1-marek.vasut+renesas@mailbox.org/
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] configs: sandbox: Enable zip command
      commit: 8a056a105852d2c3912acae16d558c73e73cd2a1
[2/2] test: cmd: Add test for zip/unzip/gzwrite commands
      commit: 6be3db6c1ab33c7ad90a8b25d7777e8425bf15cf
-- 
Tom


