Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C8C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E24885C4;
	Fri, 28 Jun 2024 21:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOqlJvfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB86885A8; Fri, 28 Jun 2024 21:49:29 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6BA88578
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d5611cdcb7so447759b6e.3
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604166; x=1720208966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GknTWjxBbHVVZscJwEI5wG1FgQGmt6EclqS0odP/QIM=;
 b=dOqlJvfKYRBj2wbwKrZKnLXgJ0GZ32aLCE489oifhXYrq02ag2Dcu4ohXPHxe+fIQA
 4qLrgPxPoezN8RFq090xf9P61jH4M5OojefN2JBEb0YsBRJgOKThjY1IfN6TMtUdmxGT
 BNV8pCzInUK19zCI+jW8wEmCO1yNK9NQt+NOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604166; x=1720208966;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GknTWjxBbHVVZscJwEI5wG1FgQGmt6EclqS0odP/QIM=;
 b=F9cAphL/6TgkkXubQZtOl/EW6bNei8WmhbI085iBfWPGFHh+Hj5Z6FNOIldUdhOmkF
 kZF5bQ9xLqpYXVr3oIsiKGyV/fuv6NztUhKISRFkrDAsBQkkfHddzXX/SfVqwlm7aKCE
 WURGGY8kS+85QOyeTWZcFA1XEdgJF9pDz19u+sp9AUc0169SAomq7mLNEmBGVPYPz+zY
 t7NiP0BQ3zzcR6eKPw28l2bUD7fMjEpB0efALRdQ4buoIdNTF4HHQq/iKOHlSOB5zlop
 uCza1Qi66YTUqNG5uYD+WOUn4bVl/MRw2TlS+OuiT6Alj8wXx58UjrtM+KOBdvswBqP3
 YKzw==
X-Gm-Message-State: AOJu0YxFXB/VlSr5QKfDevCWnXDGM3S7+uvKBxXgWl5KYDE8eUEc+GC3
 rHk4YjvfwhQqmzsta5Ib60FfoVeqrN0JG2lwcfIJu1iGrYHKW42LsAC6dL5AoUI=
X-Google-Smtp-Source: AGHT+IHwMvHK4q1X9xf4LSDPfH8VsRk8g8muPwVUDCoS+/QmFK8jI5zjGJJfqOy6TprUPxbrDuixaA==
X-Received: by 2002:a05:6808:140e:b0:3d5:628a:a41e with SMTP id
 5614622812f47-3d5628aa942mr8345451b6e.51.1719604166457; 
 Fri, 28 Jun 2024 12:49:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, m-chawdhry@ti.com, 
 vigneshr@ti.com, Robert Nelson <robertcnelson@gmail.com>
In-Reply-To: <20240618044946.270299-1-d-gole@ti.com>
References: <20240618044946.270299-1-d-gole@ti.com>
Subject: Re: [PATCH v4 0/2] k3-am625-beagleplay: Add symlinks for tiboot3
 and tispl
Message-Id: <171960416549.3614069.6493655660701045492.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 18 Jun 2024 10:19:44 +0530, Dhruva Gole wrote:

> Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> anyway rename these files to get the platform to boot up.
> Also update the documentation to reflect above change.
> 
> Changes in v4:
> * Add the docs patch.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


