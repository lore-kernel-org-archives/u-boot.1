Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E441C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6355C87A7F;
	Mon,  8 Jan 2024 01:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i/tCWznZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F8C87A9B; Mon,  8 Jan 2024 01:16:36 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA9987A83
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78314e00337so106479785a.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672987; x=1705277787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWSOSJ24a8/GxORkAQOaa87HeUh+vX2RlID6abUvPXA=;
 b=i/tCWznZnoDUmIp46Bg8UaVaGLZuqmvjNMki8BU8vcsjHoDKtzWzQRCB5ZCokij9B9
 DfHMo6ysr8zJNTX+Sy15AAPZ63tbvdcED5PBlR7IZ4M1ZQd0nTh0mNtwVPyme42g+iSt
 cNtRM5Mz2UoHQTX7FpxHqWLGkfe/Oz+p7Iljo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672987; x=1705277787;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yWSOSJ24a8/GxORkAQOaa87HeUh+vX2RlID6abUvPXA=;
 b=sqULHhd2S5lG3r7jxVbB0p1t77ZMWPDWoq6KsKl0eoxy/GBDehaZp6kin/Yr81oSDV
 /jqvjUL5Opm5MjqiDznDE5zwFGvilwkTnZneN0iPMtn/UgvnENAKtxOn9sa74FODfXzZ
 IC7keS2219RvoWyGlRAtcsE8lrJYBdLEJ457wuc0irzalewFkc/viPA5OdUHiqN3RPoY
 k9FQrjUS7VcNqlmtyDO9X9S5DyGJlFJ245c+3tNwJYNmgYkT3tj8rcpIq6KX3+rGBMXb
 nPo9Fip7Ft+C9QJG/j+bE/xFbFk/07NwKIEE2+GwPX+fbTWSW4nevGiLPpBZykx+ZKYf
 nQjg==
X-Gm-Message-State: AOJu0YyAj3d6bR+NvRnU0E02VPOeAWNNXfC18RNfHVuvdVphhDLWBxUj
 BUmG4mblCvzPzpF6LcldAv5WUD+R9A5rVvOEsoRSULa6r7dB
X-Google-Smtp-Source: AGHT+IGQ3L/btputHGvzYmKBcLe5g0NvTsYBJiwbzZ4ZgujcxinD3iE0tq4/xN9cnaYVNdJFP2HT87a25IoLeXXNGWU=
X-Received: by 2002:ad4:430f:0:b0:680:d224:702c with SMTP id
 c15-20020ad4430f000000b00680d224702cmr2825531qvs.84.1704672987489; Sun, 07
 Jan 2024 16:16:27 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:27 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219150408.10949-5-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-5-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:27 -0600
X-Google-Sender-Auth: Mrte6GJusfLojSau21QLsjcPuWk
Message-ID: <CAFLszThQ6JjZPvsUA8gNNdgofYGpk6PR_1T4p2AuY0wc_DAnAg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] riscv: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Add fields for the location of ACPI tables to the global data.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
v4:
	no change
v3:
	let tables in global data depend on CONFIG_(SPL_)ACPI
v2:
	no change
---
 arch/riscv/include/asm/global_data.h | 6 ++++++
 1 file changed, 6 insertions(+)

Applied to u-boot-dm/next, thanks!
