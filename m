Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD961C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 19:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300A583D77;
	Mon,  4 Aug 2025 21:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HrlujuEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E2C83AAD; Mon,  4 Aug 2025 21:06:53 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7699083B0D
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 21:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-86cdb330b48so337163339f.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754334409; x=1754939209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5xvyl9mIJy3Avgdv4x7jrctwpiy9YiSkLwMEGWz4vVE=;
 b=HrlujuEJcEHkgjYCszkXWW48WfSsG3V8/tVp0TjfrrPW3jjX3cLneY0aJJaVLYSzb9
 akRIVtca1V4X8SNUONLzqkymwsqsJaRiBOQhInnY4HHoU8VqnOflCJAgI/JopAPmkUxZ
 P5QLjR/MSt4NJ9kelTGaE5XMRWBJH2w7ew1zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754334409; x=1754939209;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xvyl9mIJy3Avgdv4x7jrctwpiy9YiSkLwMEGWz4vVE=;
 b=fWTVaIqP4/Ide5gvd2VxK/YAjtJuxxrCi6aDeU/1xA615IWfo+MpEIASaU05n8UhH4
 isVKIGLOWqJt7+TXiTOuMd5Od5VPdb3W/1Sm+M2G0MKYc1hRu3TErJvnnfEtjDftiQDG
 KyHhQ7wEY+3hzSTt/wUQuw+7O71tJT1Xtx1gUbG02vx2D3M3a+2AIaPNJcWjH3N2QmeN
 DZ8HE8SaW1RVCPpPyYqwb5j0dTSzwWw29twEBqe5DnUBCnfjooZRD+dTxgF9e7L4vhz6
 DdVww6Nm4vsj3LK0Sf7en6TMBUTiImgJOkGUxMqlS6vi5JElTkqxsmt6PwGCjjrsrXJk
 w64g==
X-Gm-Message-State: AOJu0Yycfo3bb8O1HFAsNzApKuK4Vyh5hEdpJ+f+kag2NYM6hxqNO9yR
 z03++SJG11RAnpZPu2xUIoFOhM1tlHCyhP6olzhmNzj4s7Fljnh8IMKlvL64H+TUkRw=
X-Gm-Gg: ASbGncsrZDG1fvHP+JjLQLdIJbeX/WvrWwwmGeb5i0y45ny9Hda52kQph6yN34es2PR
 z8bfq0fl/6iC19pjBCLwNkq4tKyJ1GMgRFck1sfYliN8O8OK2QuGrKvwn5Zk3GGhWUGlHPcqwJQ
 5A54Qm5kRoR5JZVP2o2XkpahOu4rjTDmGRxtxjdvtYiGmMRKed8getvS3ngw6m6fAgn81z2HYwH
 0sI2qyxCsF4Ew1KF/HBuTwfyRUIOqCeV6sAraMLlBVwBIZxSpV7QN4iq/yjYYH24bC5yDAO50bP
 I8Elxek7sG65+nnQ1VS52voTUUWPKuVP5YS4DL+eWW9Bnl1+N25HS7u/MNF7SmRsQjtVCvcT/55
 0+h7I+GrkBJYZKkMk9vbuPUj6feIfIhMTzlddOMAKH34Y/xrcECeCJ74=
X-Google-Smtp-Source: AGHT+IHusqhwGC2SPhRZNWt1o913hE9ou1BS2eNB8J3dJX7kQ/+h5knbDL0o6KRQo4zDp72WAvohWA==
X-Received: by 2002:a05:6602:13d1:b0:881:7e0c:7a79 with SMTP id
 ca18e2360f4ac-8817e0c7d65mr1084013239f.2.1754334409219; 
 Mon, 04 Aug 2025 12:06:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8814defb614sm344156639f.10.2025.08.04.12.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 12:06:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <CAOf5uwkN5cc79v8fcCva2tGie1vWi9Rkr=b=W-=n+efrKmesww@mail.gmail.com>
References: <CAOf5uwkN5cc79v8fcCva2tGie1vWi9Rkr=b=W-=n+efrKmesww@mail.gmail.com>
Subject: Re: Pull request for u-boot-nand-03082025
Message-Id: <175433440775.248105.8579134640280178497.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 13:06:47 -0600
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

On Mon, 04 Aug 2025 11:25:38 +0200, Michael Nazzareno Trimarchi wrote:

> The following changes since commit ae5711f881100f856ead1e76832c32b92dba93c7:
> 
>   Merge patch series "env: mtd: add the missing put_mtd_device()"
> (2025-08-01 17:59:07 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> u-boot-nand-03082025
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


