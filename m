Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A193D10F21
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 16:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4272893A6;
	Sun, 17 Nov 2024 17:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qoElJwSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF510893AA; Sun, 17 Nov 2024 17:46:44 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E8D889383
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 17:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b14554468fso222120685a.1
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731862001; x=1732466801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jrFUhQ1mexClf862mBYsk7Fyq6wPnBhJ8STodrgt7Ck=;
 b=qoElJwSRd9+7PE8y3wPZBGEfngaSgyr3zac7FJHw9tRmqsoJchfPEast16qh0zYycx
 CCMsWoGoz8Bo+PjIORYW/2PmIsPl0YhWi2v4yEAXqwODTn0U7IKdSS0x+dZ2uJTdMc8f
 565tmrIc+LSIr/H7Ct3Zxq0fLivtdyZ8yQTkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731862001; x=1732466801;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrFUhQ1mexClf862mBYsk7Fyq6wPnBhJ8STodrgt7Ck=;
 b=bogs+d3Y5r80/RNOVR591shUcopriX30ug0DXDae18tMLw/OHjYs9Dm3WFr9JgqRUs
 M7Ag1nrbhtp81YJ5kcVflVW/2fc2HQwpN99u4jPk4eKPLmhUv8C4NUmVrDk5P+9uUH8r
 0g0KINkWSLrxQ3P5oJF+FB3kylRjjeM2H/OCgBOCTF15iCMwzmJn3LcWvrxvnQOvo3bz
 0lcVxJj2ru8bLZicZ4xriXeTYxtLujVKU/0+p5swF/eNLxId1+/vusSyeavZRMSrs3W6
 n8lhSZAtSv7VhEyGfhYZ3GdWoA7Vo5nlhvJ4aAeKSpR2p6OXXkFVz4OAVGiZmdFol30Z
 vWtw==
X-Gm-Message-State: AOJu0YzzzneSTL28AbuuzhBsDYeSLf69RJaynHqnbkHskBs0UMgFg6GP
 IanWJrLAaFJHVUNF7I7PDkqUaL8lGNxxd/3xJQQmTUcm34mOP9zccgZYgDKm5Ombq8KLu2GXrgH
 DSG8=
X-Google-Smtp-Source: AGHT+IFOgT6DfjxsOQF+LixVK+BogJuf+kGKkFK9QohCFh8p/O9LNLLGo7eihM+ZsFb4Tip7WiI2lA==
X-Received: by 2002:a05:620a:4094:b0:7b1:ae59:47c4 with SMTP id
 af79cd13be357-7b36229f196mr1267072685a.2.1731862001530; 
 Sun, 17 Nov 2024 08:46:41 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4dcdcsm375768885a.102.2024.11.17.08.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:46:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20241026140900.1692591-1-trini@konsulko.com>
References: <20241026140900.1692591-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Remove bi_sramstart/bi_sramsize
Message-Id: <173186200003.3244505.4805968108115707931.b4-ty@konsulko.com>
Date: Sun, 17 Nov 2024 10:46:40 -0600
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

On Sat, 26 Oct 2024 08:09:00 -0600, Tom Rini wrote:

> These fields are currently set on exactly two platforms today, and used
> by only one of them. Update pic32mzdask to use CFG_SYS_SRAM* in the one
> location it needs it and otherwise drop this field from the bd_info
> struct.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


