Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6351C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E97187B72;
	Thu, 18 Jan 2024 08:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="glrwXdC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7167287B8B; Thu, 18 Jan 2024 08:23:04 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDDA87B72
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff7dd8d7ceso9078437b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705562581; x=1706167381;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OGJ3RZb2owCakrXCOOUqKpoUQ2CDwiSsH9PsWMu5xQ=;
 b=glrwXdC/V+l9Dr5nladRZNlLW2ilzh41HVpoCG7ufGvKHK0cb5aMTXqhPfu5Ak5Y2L
 3E575lTxrjuQP8rTjRpiOm+on1pLTEkos1HzKkxaFTODsamWHXQY4/x6DrPAFOGJAfh1
 JeFoWb+qdt3HKX9STt5wixXonj7ksxbMQHb9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705562581; x=1706167381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OGJ3RZb2owCakrXCOOUqKpoUQ2CDwiSsH9PsWMu5xQ=;
 b=jh3yi6FZjN5D7urrb1Kcg396xvWOXM/GcZ03mFwrjiNQ5MF2swnMP2llD+OqDJJrcS
 x7lA90EaGffmOV959YS3HKDwP2BG/i8N4z9XmcpufWv7kbTm/CHl0/PlM8yvoao8ji8Z
 b5QxUMFBmtKgJHKwQDh2Vy2ALYt51a5baDlUF6qSLQyxtcU2EoYqLrEzGvqTp88FNCow
 Zw4kNRbW3hS3yVfhgJZixlHSYbVGQleogTxfsfm7MeEzw4w9YFkaxRLEjt2KBKQZHMIq
 loNXBFAS9Q1hfJ6fzgwdpczIcqQ3O0v3S+YomjxvcQx/m6Z6WFy+lz19CyVEbgI1+CX/
 v1Hw==
X-Gm-Message-State: AOJu0Yy1xJtTVWmFzJ9YHUZezjgdIw2XR+LnzO9N5hxN4JgxK4UMi4vu
 1FBrZI8pze9xkXuYf3TvF1oUUCh6GWVS9Qv0FXIzgtUC68Zc45DFpJbCZ/m+hNU1qLuhZK0x9Al
 TUhe3o4+NQuZNeQKdMoe3WYe8TVsmpcX7oVMF8w==
X-Google-Smtp-Source: AGHT+IEVUrIjlDIGGN+xZgjmIeQHFH8QXBvKV+NHjYDcUizhbk5WoqAQNvXkPuWz3wZNOO9aEnVoZM0EdCnNA0U23sk=
X-Received: by 2002:a81:4f94:0:b0:5f8:2ea0:ea2 with SMTP id
 d142-20020a814f94000000b005f82ea00ea2mr386140ywb.35.1705562580978; Wed, 17
 Jan 2024 23:23:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMty3ZCq_d24p68fg1EfWCqmHyDVKZ54UgPDF09GVy0mh4ME=Q@mail.gmail.com>
 <61fa5f2f-1847-4831-a3f2-8acab93fb964@rock-chips.com>
In-Reply-To: <61fa5f2f-1847-4831-a3f2-8acab93fb964@rock-chips.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 18 Jan 2024 12:52:49 +0530
Message-ID: <CAMty3ZBAGLOyA_U99rHph_EoDEq8PuEJv04qonTp2hK1X8H5=Q@mail.gmail.com>
Subject: Re: Black and White Artifact on BMP (24BPP) logo during boot
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Andy Yan <andyshrk@163.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Kever,

On Thu, Jan 18, 2024 at 9:09=E2=80=AFAM Kever Yang <kever.yang@rock-chips.c=
om> wrote:
>
> Hi Jagan,
>
>      Have you check the memory area, does it maybe overlap with other
> area? eg. heap, stack, malloc area and etc.

Start with GD all memory map seems proper before and after relocation.
I did load U-Boot proper of rockchip with mainline and vice-versa. The
issue persists.

Jagan.
