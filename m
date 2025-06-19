Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00F0C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 17:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4218582CBB;
	Thu, 19 Jun 2025 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n5H5dpBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393AC82CD5; Thu, 19 Jun 2025 19:03:53 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C617D82C65
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso579091fac.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750352629; x=1750957429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcUXIDZWYbUWkKkIFdIcxU/uWr/aRgYQaaD5nbTpWXo=;
 b=n5H5dpBKPJWTRSU9L/Cv8ggHG+TV0yjaOeYZUCzn0nm01wdetEFaQ4ao78tKWZYBj5
 pU4EziA+jtoqKVlZOmIOW6ZHIAslk96laAm29/4mF/Pwwmc6D2t0J0sXKfd418bmBAZY
 KpLPKSwbVoSGwTPt0Hp37T8tF7QMJe3qH0RUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750352629; x=1750957429;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcUXIDZWYbUWkKkIFdIcxU/uWr/aRgYQaaD5nbTpWXo=;
 b=M0JJYP48DAI23udzVlVJMHmOIr8VjprbmyHuEDSbDTH3KoIlybEhgAHCi1IStX2QfO
 kz/w+G2UQPeg68z8fiD6kNuzoutb35Km1nU6fNQOXpriVCbueGE5WlPiSk00mZWgJ7gr
 HLQVIBOnC8dSbIJGguApAaY1e2VdswRHz9w+gngw9revTMNvdjT1lAjynbnM634Qitg2
 BR8bUfPr8jOeevjCP3VPOOs4wN943oEJ1RWxOKUoNeFuVVvUoPxffHJpWJsQj4VFjn4q
 Y2T2xme0R4NTpwmvKyfyMMf/+x/NvMKqpRcJRIRhXLmDkPdEhUHKlEEnUALPoT7F4k5O
 IuNw==
X-Gm-Message-State: AOJu0YzixkwyEIEfXy/bH2onQyYm+gk2nkWcamiAKiEkoqSbXCd6UCUB
 ViSEMkU8EVN1a2jIRtQZl345eW46YSgkdHgPK8ORZJxaIWZyurrTDsyOZdaRu3TqBMU=
X-Gm-Gg: ASbGncvzWpU7P7pxEEo9ScB78lZs09OxxpaQpFlD5Tt1VCjXXB9smPGLhkthHTabTiA
 GpyIG4Ovx9iAm/+CtK0U176qrZoSdbSHNl/O0HRH27i5/md3MSmOr/SlRHrSOfi87jkGJ5iubGT
 DnXiyKGl/jz+zREcqv0xjr5fOb1S1RRyn8Bx+36vdssEUByVJJo0qFnSG8Ha5txJf+TGJRaqiYP
 wfGRJuc5UhXb+lsby/frvWyG267JTHwHJTnuKtqQM8ZXU9Bk+/zWNB3yMQPXNy3mdQ8t87GVWsH
 UukciUUtY1AwMNseIDoYX7ZdClqrQNPcExKZKtcS3ekcRO/AxeF4yVYAUgsQEXTAsOJl7tLxoAx
 kVOOXhUgjiQ4Zida/5fXzaA==
X-Google-Smtp-Source: AGHT+IGPjiNN6ZvDJACwq+kvN3rj+YWWfxTZnQhWFG6Zs5sTXfxG3/7rXlYNmOTUNXy7c1h0/6qZRQ==
X-Received: by 2002:a05:6870:658a:b0:296:b0d8:9025 with SMTP id
 586e51a60fabf-2eaf0aa3158mr12312667fac.20.1750352629527; 
 Thu, 19 Jun 2025 10:03:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61158443871sm57135eaf.34.2025.06.19.10.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 10:03:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Shmuel Leib Melamud <smelamud@redhat.com>
In-Reply-To: <20250618203351.182063-1-marek.vasut+renesas@mailbox.org>
References: <20250618203351.182063-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/next
Message-Id: <175035262826.2261235.9509605163429383729.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 11:03:48 -0600
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

On Wed, 18 Jun 2025 22:33:46 +0200, Marek Vasut wrote:

> The following changes since commit 5d7e003248ae836cbcc2b4c254901c1d85c85537:
> 
>   Merge tag 'u-boot-imx-next-20250617' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-06-17 08:12:39 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


