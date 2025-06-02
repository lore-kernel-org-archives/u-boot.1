Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E07BC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D86181E06;
	Mon,  2 Jun 2025 16:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Askk+Wqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6605D8205A; Mon,  2 Jun 2025 16:03:53 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480118070C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c27166ab3so3054379a34.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748873030; x=1749477830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/u4PylPfzY8UfQKD/qEnKsdQl1lDpRpq0OpcR67kac=;
 b=Askk+WqaTbPoJB1+A4w2P1tx5a//wjCQDCqCjdAUAUODGB9uDLX+leMK6hXPvVUiBz
 sMvStowVKbusJN286xJ1tQMVtxDATF8BXStNQfzDKGI65oNEw48cdSRG+HxNE/OZ2d0J
 KjMy7J3iJZNKJ1aFLuQddV5SV1Dz/kzOIBHrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748873030; x=1749477830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/u4PylPfzY8UfQKD/qEnKsdQl1lDpRpq0OpcR67kac=;
 b=PdNdek6J+LIXtENR83zhcgJgPN1C1eR8RJKQ97puMvCEj9RMVqA0ox7CpNZDBizpdc
 0GbIfw1PDe+neSVm6KIK3joPyrh0TqW5891yw+vi0nr3CGFBs5rwYVsF0CNcLwUVPaSt
 lHauGKd2WThtkiwBEz8KJS/5I31XytjK5dJblxvAqSRLFOQlwd/XzVsoMxVoahTUsmYp
 IytltvirdX+SxOBHeVoeD8sSC5HKrUGJcLq1vmWlsX3svtJvb5Sed6BoqCbC6TJ1a0dN
 2iggdhXOLJFxwleXbvUlFI/g/9tN+WR8wi6p95TMdcOxQGvP1ziY7HhvLF74pYSco4zv
 Db/w==
X-Gm-Message-State: AOJu0YyWIv1llPd1yxE05MTcJdeqMiYVFkyPM8T3oa7rxFCTeS/x2OV7
 pAoL+mzKT/VTmn51jvdnYrGHqapQTsclZJ1ki1DrkcoOmBSm2KhVImPwmeDn8uQj82o=
X-Gm-Gg: ASbGncuyzPT7lV+MZPOj16CNmrqsTcpnf1lOOpsNc8uVibzgmH4WNKkV9Z4f8bZa7ev
 q6KNSiOizvt3Ey1bj/9YkugWLNm5ig4qQdulwvx36qOTQH66e9wdy+yepVjD0emgu4hWFEvDcl4
 X0wCTs/MpLYzu5E1f5T5q3XIuWnbybQb1y3gsveSgBA2jCqAuIGs0iDiS7bfG0hU85AY7pT5pFW
 FYmxR2V3gdF7bwq+AS5HlfaFaW1p29/BtToPraMwDVAR7CwWM/aUCUr0yUwEJtNJ+Elj/EJgevF
 ztxA8b+Me73wDQ3RVnnCbM0sQGrARHXwsRAte/G8gg1eOqaUhUJGINuhVEfvEWQvIUSzNYauYIh
 IpIEc4tjYnsg=
X-Google-Smtp-Source: AGHT+IEd+r5F3mgUhay2ezpm87X1GMGN5FQ2H5H6QwGrFjWPkyQZW5Jl+vl7EMWa196WfVyuJ1a9TA==
X-Received: by 2002:a05:6830:f88:b0:72b:87bd:ad47 with SMTP id
 46e09a7af769-736ecdde740mr8916036a34.3.1748873029937; 
 Mon, 02 Jun 2025 07:03:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af82d2b8sm1540153a34.3.2025.06.02.07.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 07:03:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250601133022.1461652-1-festevam@gmail.com>
References: <20250601133022.1461652-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250601
Message-Id: <174887302865.1219081.18151554706720762138.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 08:03:48 -0600
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

On Sun, 01 Jun 2025 10:30:22 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 5eb1b7843811e3e87b0e677212a9145f07552a60:
> 
>   Merge patch series "test/py: enable HTTP testing" (2025-05-30 11:19:45 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


