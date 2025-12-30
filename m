Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C7EE57C2
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 23:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE26283FD9;
	Wed, 31 Dec 2025 00:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fY+2jC/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFD683F36; Wed, 31 Dec 2025 00:19:45 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7672183FA4
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 00:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6d3676455so4674329a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767136782; x=1767741582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BiIQ9VYDUdzkg7iRZrNNcb0ORVGlvOtaW04VLfUWLY=;
 b=fY+2jC/ouHLxEZWRvVyTJFTaczJtSH99k7hs8lOd+use6v9cEhIN4KPNlNWLN4XwhX
 y+788h9gxKf0EVwhk8q3MIX0kJC4zn5TirtqUbqDUYBrVAtPWkg5IOydupu+/cN2iICQ
 bzipy0T8iSKXfFCbY+5tYKl5xyWx/WsMNHKuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767136782; x=1767741582;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6BiIQ9VYDUdzkg7iRZrNNcb0ORVGlvOtaW04VLfUWLY=;
 b=kN+sYls3RPm8xKgP1IUp9wmrZiObF9fMAKrHb1V2kmTB8kD+mLgHz23a1U5soAL2aJ
 ImN46F+qm+xp4hoBIAedAbQcUsFu8sRfOd4lhUHbyWH9LHAJE1ldslSa1wVvPvpYgfB3
 0eABAv47ok5LXcP3SOWsJOptnzKZPKsi9SDf+JKb438YNWYaCp36Tqhh7CU1e3NEK0yB
 /kMN6gx99aPXF5aSYXeC37nteQ7btTXX0etj9g+7idnTU9N1f83uTSxNKd/wlAvIA4rm
 hcbqDVLQHN78D6qCVAPvxeX4eK5NrFldiGzkEUFPdXCHiAO/u0joFHZGKPl167l5TvkW
 ZcVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqZqaJAIE0cilkMUeY0Ug5CKV332EOOqglR6a+9FjPBqop7C7p9QUQJKQU6sU8TZGaJdhKmEg=@lists.denx.de
X-Gm-Message-State: AOJu0YzMswGPaTYxYiH5QvHGTCJXRFEzWfK5AQZADzI6PCm/lCLvz+9D
 myI3Ky5dROBIpIcoB8EnmOuMv3CzC0rqQ6zS6CcetVb+iaRlzubsTcHsJ9sXKDaeOH8=
X-Gm-Gg: AY/fxX5sUdJBASGJHGPHfI2Cce/mkh6YtET1qt8BwCVCgEO3gu/yOogv/PONRXTbZJE
 xKK+ms9BySdm3sejCAqcPacvV19rvCkTsmqeXUZ4qaJAwGfEk+X0NxWFqF/isEeIpKSeYT1+m5r
 1DUchs8Ia86GQADwC+zavnZnV7qxF6+v9m13y/JHXumFfzdwUoCIm21H2E0XjhVnIUtItKLznpN
 H4D+K0ieVGy64owyDwwJJeXO5iucZ3RklFFk7MwpwtHu0ZaqRCGbtSlAZ8EpFbTnl0HAvz30O4z
 TUSoCmoDCCOnI+L0gYK9l8QW6Wnbn5e3vdHQONu0vkeCDFTkxskGEC4AU2sL1cygtRYRy/KMeC3
 SwqiHp8bvAvOmPPLZJc5aomuT6QzOwm5acIW6ny0H8orD4OBxW2wWq5/eOoedjBo2HWtOuAZmaN
 Lp47/M7Miyq2dKD+ez5jTm875qN6s573EDOAAabUexCjFMhfK8pAiIIiPBKnR938BA3aKcbmDcq
 xlrFuMcJvW4/8BIT1ye1eejFh/tMOK3dtVTtA==
X-Google-Smtp-Source: AGHT+IH8XystOiLF0CjCk6X3Ad1sMpLI2KyaBK/5tfw55EJHOytDAnZ4GK5o6CA5yS+p6JcKFkO5gA==
X-Received: by 2002:a05:6830:314e:b0:7c6:cb39:adf7 with SMTP id
 46e09a7af769-7cc6689c9d0mr17009060a34.6.1767136782223; 
 Tue, 30 Dec 2025 15:19:42 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm21172083fac.4.2025.12.30.15.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:19:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: devarsht@ti.com, aradhya.bhatia@linux.dev, n-jain1@ti.com, 
 tomi.valkeinen@ideasonboard.com, Swamil Jain <s-jain1@ti.com>
Cc: vigneshr@ti.com, praneeth@ti.com, h-shenoy@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, u-boot@lists.denx.de
In-Reply-To: <20251106085842.629521-1-s-jain1@ti.com>
References: <20251106085842.629521-1-s-jain1@ti.com>
Subject: Re: (subset) [PATCH v4 0/2] Refactor tidss_drv and enable early
 splash on AM625
Message-Id: <176713678111.315706.6873791987699455243.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 17:19:41 -0600
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

On Thu, 06 Nov 2025 14:28:40 +0530, Swamil Jain wrote:

> This series:
> - Refactors tidss_drv
> - Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot
>   SPL
> 
> 

Applied to u-boot/next, thanks!

[1/2] drivers: video: tidss: Refactor tidss_drv
      commit: 209c5d9da18375a6ea320786254803d28486e739
-- 
Tom


