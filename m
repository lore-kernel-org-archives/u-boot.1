Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB53C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B32B87D5D;
	Mon, 29 Jan 2024 13:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="auK2T60O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE6187D6C; Mon, 29 Jan 2024 13:17:53 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6CE87D5D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff7a098ab8so25256077b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530670; x=1707135470;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1yz5saiNXvu1egsyqcsERs2EIlAeez7TN11mt7spA8=;
 b=auK2T60OuTqC0lIQfZIs9noQbE6o9fk+X9/5Idelp114WG96WnFfqpOosN4D/JYXkE
 vRD8s1kWEP8BiJsr0z1ax6tqt5pBcHkUwpCbreEsZiZmUkPplsE7smjXtbEmszFuPSAE
 +Ew2jse9axHVB1ml+TAsnxzrGKCy8S0j+ypLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530670; x=1707135470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1yz5saiNXvu1egsyqcsERs2EIlAeez7TN11mt7spA8=;
 b=TrFzX3hsVATpBjK7zmPAgFoKzsYmRg55/4Cx2IhVjrrSwLVEZxBDgJH83maD6z6gZg
 Mwi++xtCqZnLTzRlAifViBKdv2ndplKPbT831DX0uuGKv5yxVz4S8QYicxS38oxIjnYd
 D19rmNCkwReP9QsCVZnzVG53SgqB772dlx3TR2nH/OXo2D3EmRvZGi0hgx/3GVbjGo5L
 Ca4BBIh/GhsZaFKRdC0eqRRcKSPmz9J8mAecLBGnjrP/LJhH8pvY/47xkVZ8b1yVDCdC
 BqD6fljfhihRkw6MpxF+2OBkTDbYBIj+FuP6I+6RbULm61e3Q5dUE4dRcrgcDyoBELb/
 4InQ==
X-Gm-Message-State: AOJu0YzFXQe/SxiMkkAdrp3YKpF8cjupY02wr+qUm70V6Z1DTX8U8PKt
 hu75JIURjycoEtwUtESueo5GcurGyiEJ0oG0dVgCsz/xvSC5DXx6gDss1YnsK6Rm0YjzOvwDGio
 nT4RlpTLceP/9qJ047TGPOPApKHNjEHcETfjGCA==
X-Google-Smtp-Source: AGHT+IGklpsYuJyHmhqkQrX7LO1jL0zCV+I+TIGtcA8WiLpsSr12rRb5Wm6nZdrHMBXWxEDQ0eg5o6sTvk4OtDMCHfA=
X-Received: by 2002:a81:d20c:0:b0:5ff:5413:7cc4 with SMTP id
 x12-20020a81d20c000000b005ff54137cc4mr4891462ywi.2.1706530669837; Mon, 29 Jan
 2024 04:17:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <e75b7d07003573dbadcc26bb07b7665e5ece8e12.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <e75b7d07003573dbadcc26bb07b7665e5ece8e12.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:47:39 +0530
Message-ID: <CAMty3ZBybr7_m_MSQ_A0KvvxvaduhH=5N5VEa7PZ+1q==rLyyw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mtd: spi-nor-core: Rework
 spi_nor_cypress_octal_dtr_enable()
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> Enabling Octal DTR mode in multi-die package parts requires reister setup
> for each die. That can be done by simple for-loop. write_enable() takes
> effect to all die at once so we can call it before the loop. Besides we
> can replace spi_mem_exec_op() calls with spansion_read/write_any_reg().
> And finally, we must mask CFR2V[7:4] when changing dummy cycles, as
> CFR2V[7] indicates current addressing mode and that should be 1 (4-byte
> address mode) for multi-die package parts.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
