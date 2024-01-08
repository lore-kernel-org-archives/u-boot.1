Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5579C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF0887AAE;
	Mon,  8 Jan 2024 01:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f404UNhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F4087A97; Mon,  8 Jan 2024 01:16:33 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDAB87A91
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7831806c51bso118599485a.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672984; x=1705277784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jY67oUNIa+hKGAbM8FQcg6e3tI2pA7Bl0yHcfQ7gqlo=;
 b=f404UNhyfkNifd23nhyxQbu32NwLTtFfDzvHqdrGDfY+tCeTMkk7UVVg2ooQHmuALF
 C9wflOksLCGtaRRd2gk+56VpZz3QBeUZyORd6NgNegVuBbmNgpEEd1c9PM6GVV2eVUAs
 S7rCpPsKaIJHJD1KEhPXA7VWIDD+ort8wiDa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672984; x=1705277784;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY67oUNIa+hKGAbM8FQcg6e3tI2pA7Bl0yHcfQ7gqlo=;
 b=lFzPoBASWAVgYWoNmYgdjDb2+GIHRYUtTB208MtRSzCuEhnTmWwr8tbJCYRtiniaHV
 NzD/qOjFQZYiZVpibwkBC5kBzKy2UJdOjpXVKEKeJyoLDgtnMAG2fv9nTR0aVezuYgrG
 ga4I5l3LPNIL8W7CaSfDw6gavxok3t3v1vyXeGaE2W7GOQkCLwPAZCQhyoAl7qK16aCZ
 rsxiZFsSmOjouIX4DNA/6pIgA34MYdVDWE5ghTZ21j538zld+CyJpt2IWBH1dieQ/JG6
 icqI6TUfHJYROvn/lvZa5F+MMfyOfK8CeY8aZCfx2k3oRaHe9xb9+1Q/nPzAo8iBBIwg
 guFg==
X-Gm-Message-State: AOJu0Yw/W7m/QONdNRL+B2+8tuBf/xsRhPpFGkiYX09qTfslg9GLixl7
 6pe+NDMkKntXPjbtfEMEj3dGJT+KXluVx1OSIHxjrbAYfBb8
X-Google-Smtp-Source: AGHT+IEZiQ9VGWVlLxHymy5PDQNAOOxjiOKp+qSfi6ZQX4UJzjr1gXiGzZtELAyuX/FZM2AKl7K7Z8qvnZLaNfFT4jw=
X-Received: by 2002:a05:6214:2426:b0:67f:bd18:2eba with SMTP id
 gy6-20020a056214242600b0067fbd182ebamr4035377qvb.129.1704672984373; Sun, 07
 Jan 2024 16:16:24 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:24 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219150408.10949-8-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-8-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:24 -0600
X-Google-Sender-Auth: T0De_UdZLQktgEWg-ZJs4obmJpk
Message-ID: <CAFLszTg41T8PJqh5k0oPKAZgMJgW9Kiydz_5t4w0aJBXr8VK-A@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] riscv: allow usage of ACPI
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

Select CONFIG_SUPPORT_ACPI to allow usage of ACPI tables with RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4:
	no change
v3:
	no change
v2:
	no change
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm/next, thanks!
