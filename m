Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F31AC47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9793C87BB8;
	Fri, 19 Jan 2024 14:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LY0zjZsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1353C87BC5; Fri, 19 Jan 2024 14:01:17 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E8287561
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d51bf8a7dcso1410085ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 05:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705669273; x=1706274073; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9JRdBYLKZvFAYraSCF1gmn6Ya1O0idHcRoRpwdFRxQ=;
 b=LY0zjZsroTTTgrWOg5Z8otm/AT6CP8HO9+XDmIy5i2WOhz71kF1jyTl2khgnpMbNhr
 Op9rcooxamMjXUY/arXQrCCKS1UHFFtDfJiEwtfxPvCSuWc1MYjBBFTR48wwLHyAZdHt
 xvAITPvYrXJwPI5zksJGR6HSZUcUfgZpZ+ock6gkoutUiY/mAaLMNprtdvmbsg9qTP3y
 fUE3pjHUqRzzBijw+eY9y2oHDjn9nEw6k1T/RBZDrYlOidpM6Jl4O1tUW2X3m/n86u8X
 D+qG7DQx8mL3zjjKnsx4kOz4mihcrWwrV5hd+Iujy3wZc5IykGQOPhCZwK+hunE7zvbC
 Z1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705669273; x=1706274073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9JRdBYLKZvFAYraSCF1gmn6Ya1O0idHcRoRpwdFRxQ=;
 b=t56dLPaMuCt7IRwsGJ6jvC6heDPztItT+8S5b/j8E3DP6VKrmHZ0/bvrLd/5QVFfT9
 fUVPFgMb8WvhSC247YvV/VPLBF0ms/IKzRmVWFIU1Ca9s73mYpiJ5r5giAoqRasj6p8W
 eka6COf6nmvfEW3dqVwzkGlmOyckTXnPNOtSs9nU4PbsXjSk5+VUI21mwru4Jn3NyrJT
 pL8at3k+RVgkIT7NXhivTj1lgLuyfLyJXRT28/QK3KLII6H0j6U4yJt8nRwt5hB1oa1e
 x5wWLBnkJWQEurxt70UX/et3xWzoWg7r9BcONv+j+EaQ5ZsZfag4A1nZ8tInbFFSuBhL
 EpKA==
X-Gm-Message-State: AOJu0Yy87mMLi4fn1aUjLz/vnWIk2prP7W7XCsJaAtGr8uX7mLfUD1dG
 LS4BGzlMOR6o8OoEEid3ITZ/gD+LqaL4V7EG/jEXSqdj+PXNHTR5OzvjRupAEzVOGm/eMdYs0uX
 g1PlCDNs1lRbVS42nzWv38sV+woA=
X-Google-Smtp-Source: AGHT+IH1j36U6yt73BSjh94GlkITsz1B8lQ04qYiyvCwGdoToE0MotUfyv9M8sGiwfsud83oXGeZng9tpw1dfQg1nP0=
X-Received: by 2002:a17:90a:d384:b0:28e:8e5b:73fd with SMTP id
 q4-20020a17090ad38400b0028e8e5b73fdmr2002564pju.4.1705669272900; Fri, 19 Jan
 2024 05:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20240119003742.251587-1-marex@denx.de>
In-Reply-To: <20240119003742.251587-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jan 2024 10:01:01 -0300
Message-ID: <CAOMZO5CLhRdELR=UpNO+NMZq_TPgV5g3YQbAQHViO3ehvZYS6w@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable SPL_BOARD_INIT on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Thu, Jan 18, 2024 at 9:38=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
> during the SPL start up. On this particular system, spl_board_init()
> is used to reconfigure GIC clock parent to PLL2 500M, which is the
> configuration expected by the Linux kernel. Enable SPL_BOARD_INIT .

Same as the other patch, please explain why setting the PLL2 to 500MHz
is needed.
