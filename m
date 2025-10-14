Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E479ACCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2402583655;
	Tue, 14 Oct 2025 16:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PKcHTtpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA9583653; Tue, 14 Oct 2025 16:20:40 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D60809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3729f8eaa10so1035284fac.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451637; x=1761056437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxtV8259KEERkcsYl+DMPAxPOZkIoFmTx9DCOLo62pA=;
 b=PKcHTtpZXsCtvkt/D18F8EAqR59l3iFZDz49P04YmTMmU7zTCRAcpekSfdQlOu06g+
 AYY1y+2xL1oeChVJv/Z8++GqBet5Lq14pf15/sDucyS3zsSId+FVVe/J11s7N2qDGJcj
 Nm4rlZU90DRzKoEGpHcrej4+kGZcEvM0i+i5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451637; x=1761056437;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxtV8259KEERkcsYl+DMPAxPOZkIoFmTx9DCOLo62pA=;
 b=EBCJOlbb6OlpS1eEvfE1hVVCmvYi/BN2Xdd8Dv5ZqDxOR+LElgNZVf9IgJXaGke1bi
 Ak6M4nlt0p2U3O3jV6/tojxhthAfEdKynLXAO2Hg4A4LLykC+IuPwdM/OmGo5s2TykCI
 zVIGRFO6iIEsWF0AP78E+aRNuPAyPjl6gYdpPEHEiQtG0zNbSmmliqpjxc30lwBf7Uy/
 ZZTl4NRexCsgoLjabLiFU+D2HoL26gbWmb+nNv2vM0LZweUw/gvN82QDUJ67aN/Dr51o
 WiBT9ldyIf9RFkxLW6NqpFrevXWwfjjS4BfsIHQ2VtuVaTF8wkUS+Or78GvkVZpl+vGQ
 IY2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7cShZEE0ud+ixNtPwpTZxyMcRCsJGwIRLj3EJgOjoP5GPF8jVg1Bg2+RYCea4AouWU7rYkds=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/sLfVh/sVPj7dwiHcjfSbu4m2WvZUMpxhNYtOccpAc2UTRxt0
 4dg1Y/SYDs29ulBA4asfBokk2YT6kRgWDLAc/oJ8ApdzLKUkvtN0RVFsxmRi8ytAGdo=
X-Gm-Gg: ASbGncvnf4LxRFzj0fSSVZzsSgxwyuVHW9Nr+96DNZPYjGDsTnn4GccBcIfd/81N7Zz
 SM0dZD/0DFAHf1MC0Zy0IUNdwW06VdnQ+7fOGze6/exIZwY+YCJZR9Va6cs82IF0RC0C0RByvYA
 iCSoElm8BP5qiuI8tW6K1lkd4DkgjUCNxFbULNT8dv/gmfVEZomlVK2ldD1WIuAJ2HvDaU6kmq3
 Hf5tpSjdbzNwa6iBJOMJZeCRn3kJucv1kgMqvHHLTDcyQkO6R53iPYp+dAt8W+JUuQYA5bkSNH6
 Qo8potAS7PCdbNg5Bes3Tq/eEP57PK3ZkTdkSZ3ktUGETUzDGbr4lddKDAkj4C900oiLo12TT8/
 Od0+Ohthx3I+nKU19mSY83Vk8U9H9Z865g+nMQRPU6CL19+eYRPmBs02OyTspQ2LkMUGGgMg7Es
 jQBphpbEW2iBlR3Q==
X-Google-Smtp-Source: AGHT+IGo0AObNUfjWZyQlx7m8ssFxMbcb0rX52W+4+EcqQluHHwxTeA0a2NCjqVA5K9OQLw4viw91Q==
X-Received: by 2002:a05:6870:810c:b0:37b:43c9:9266 with SMTP id
 586e51a60fabf-3c0f54b079cmr11025471fac.21.1760451636589; 
 Tue, 14 Oct 2025 07:20:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251003222714.4921-1-semen.protsenko@linaro.org>
References: <20251003222714.4921-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] bootstd: Fix bootflow info for efi_mgr
Message-Id: <176045163573.284655.9041283233604347510.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 03 Oct 2025 17:27:14 -0500, Sam Protsenko wrote:

> A "Synchronous Abort" CPU exception happens on an attempt to run the
> "bootflow info" command for a global boot method (e.g. efi_mgr):
> 
>     => bootflow select 0
>     => bootflow info
> 
>     "Synchronous Abort" handler, esr 0x96000006, far 0x8
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootstd: Fix bootflow info for efi_mgr
      commit: 3b278dd9e6643a9f75ef108d229c619e197067d0
-- 
Tom


