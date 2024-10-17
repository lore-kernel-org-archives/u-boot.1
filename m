Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D87D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C1E58917A;
	Fri, 18 Oct 2024 01:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SvWuOmFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365B589157; Fri, 18 Oct 2024 01:12:15 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE4E8915D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8151676d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206732; x=1729811532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf1zPA/2yzUeayMoo4FeHkvO4U7KDJlvDGugN0wODRk=;
 b=SvWuOmFCLJuI0t9IEZe74TyjCC6OMpMYdRLdBi02QtnNvEfqmhyq6KEdp2CXzdmrQN
 K/6YhEi+H9r6lDzCH0eW757IsPLD9oeAPOhRXph1H7S5XxkUy/kAzSXKQ0IsdJVqk2yT
 iCsHAcwZhNfR99FHgFqSUohrcCVH0M5MKZqos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206732; x=1729811532;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qf1zPA/2yzUeayMoo4FeHkvO4U7KDJlvDGugN0wODRk=;
 b=P6RtVi8CCYD6G7xYxURfUACr7cGvHRd2A7ToQZZ25K6BQBA55YE1VaOEtjzyyAD3ir
 y/fl1U8M5XXmgAgY9WkvPEgRVlYcQN24vY6qGTfuTfjNY8sy55rd54mGGGqPYxHSIp7M
 B8Zrd3Ly3LP+F99l8EqPe9SENqSoed1A7Gmazeh1FBDBQF41hqUrbFsmhsVbrLdoNTdu
 OXGvAp+uBZxdNK6cBQM5wYO9b6gEyvK2v3Q1iGTkQHIBJCaeRfcA9ASdSqX5KB/qDbVP
 n1naTc0yay+mn5VPym297MzirmjEIxHq8KYXZRtWCBT4BtoCre1ETcMRghOvDCtJEqdP
 3MgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwcGIR+QLrqKyYwVTeHI1TZnIm0UmsVjDLfS/fLZd3NGJzNNRLwq64yev5Lk/9xXi/STr6jWM=@lists.denx.de
X-Gm-Message-State: AOJu0YyyUYR15KRfFJ+OBpgSuRYKJTurlIVlPprJdBI28KsZsZ9W68GA
 3qxhdrnA8MdPKha2JieZIdU0cULKPlIeHBpMVF4MclLl6v/N21fPSsMLrDh6WA6l9hUVCYX/bfp
 agyuryI1XlnZyUzr8WXx4nlwpuvmma7IplXhC
X-Google-Smtp-Source: AGHT+IEh7YSAbLqjrMkeSmqlIAZypa4/DUj7g96IDFMMqOD2971RSmh+xnmesDy7Ik1FwiXqrEJ/QDABLYNijb9dSM8=
X-Received: by 2002:a05:6214:5b0d:b0:6cb:c9d0:df32 with SMTP id
 6a1803df08f44-6cde14c2822mr6762626d6.11.1729206731954; Thu, 17 Oct 2024
 16:12:11 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:11 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-7-sjg@chromium.org>
References: <20240828014429.3320011-7-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:11 -0700
X-Google-Sender-Auth: y2gyrR0_W7m8oI76mBvBC_cPc1A
Message-ID: <CAFLszTi88+eazT0X=ADKh5_s=gQD=+pxukSPr=QyhYqyRj-TEA@mail.gmail.com>
Subject: Re: [PATCH 6/6] x86: Add msr command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joshua Watt <jpewhacker@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

It is useful to obtain the results of MSR queries as well as to update
MSR registers, so add a command these tasks.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/Makefile      |  2 +-
 cmd/x86/msr.c         | 52 ++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/msr.rst | 61 +++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst   |  1 +
 test/cmd/Makefile     |  2 +-
 test/cmd/msr.c        | 38 +++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 cmd/x86/msr.c
 create mode 100644 doc/usage/cmd/msr.rst
 create mode 100644 test/cmd/msr.c

Applied to u-boot-dm, thanks!
