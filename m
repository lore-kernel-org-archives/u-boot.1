Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9352ECD4F54
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 03:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A4483FEE;
	Sun, 24 May 2026 05:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cqM6QmGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCE984659; Sun, 24 May 2026 05:02:28 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2C983EF9
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 05:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bdbac72ac1fso619863866b.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 20:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779591746; cv=none;
 d=google.com; s=arc-20240605;
 b=gU9Wi++mEjg5pb9rzT31eiKjVcb0HLXPvnoenUjF1iGmZOdOVN3khwdnMOFLfjOHWj
 5q/FaNwqUNmFS5bstPtDgDNxLM6rv+lAPt5FsjGAvwNf6uQSBZpmgo74XkM2ijP32o+Q
 4Vt0SlGKFvPxrXgHyZOXbKaLYXOCoPHpKOMwoDrhhPfxawpDEwb2e6y+9GEeZ4zD48kU
 4mZJKiaB0uON+ujLnkNGGKuMaVQrvdSsmC3+NzzoTycGILyxUH3C4CTJHRxKW7+Nus75
 9fjX/Qv8IthvrnmNL8VzxjcGVhCqUXyMYZR4XPp9HnQms/NzepbHX8paNqoJBrnQwINQ
 N9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z00O4ViHvYHRDKbh5v6DQfGT9aJXTxSVueRlVW0wU0k=;
 fh=+aDa/ZUJHhP1Vy9D+0mrYOdjxTCA0qEBflA301btrvE=;
 b=kadADjaJY9NoHpXPdbcyRf+aSu5O15DnCunNdf84QV1wfjV15xy5/8jZY3MTyVzW0k
 is+lD74i8XzJdo6uVjeWDo8jDZjB+g2vCZgTODy/aW7BYbPNBQ+KhUS6wEYU28vNA6Mz
 i0OH3kVuPhXt4OFxMftnMtCSTAezX67MDTsFsS3gJPj8sT98N+Rlr2gDGKfOuQHsF5V5
 v2tHs1f5wgQw7YaV58Hj0xNFxKgneCOLVL4dWZKHHfui9Ic3RXTUlwuxWEKRoieVy20w
 XXZsbG2eEp3xKH0rmOGLNo31swM/hMwNqO6OP0o4dCrpeU20cZPBEZoGsEt7XOSRXbvF
 KztQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779591746; x=1780196546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z00O4ViHvYHRDKbh5v6DQfGT9aJXTxSVueRlVW0wU0k=;
 b=cqM6QmGS1P7OtcbROZSRt5EJiCsToyDl/DCaprRuzVHPro0hTncGp1sN5t7ZHasUn7
 D2prkXE0L3Vqt3h/gTcKQzCHanX79jDwUrxC8SLqDZIpJxPc1CX5xkIPY/v2e9xsZtJx
 jmm8wCt2Nmr7IxGSy/cLZmlqAuLWMs3spyT9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779591746; x=1780196546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z00O4ViHvYHRDKbh5v6DQfGT9aJXTxSVueRlVW0wU0k=;
 b=rA6/GkYxye7XuZjW2EFZhM+ultYwWlsrDW76aUFaA65Sbgtzt1FJ92H/t3of7+6mxg
 YKiDdXe8K4M7pEJoVOAu9eMtS+xFYroagCze1Ed4VPj4NlCFJFu02ODu+ZdnL6gn3lWP
 2xmqZf0WhdZK1ekaK1wPCszGZYHZjOE/1wBYZbzO2cSMeUOWS78ieNj45lczh9R7rVw0
 gqquzjavPs7QAdQEmyPRmV8GwjiQWXKZApaH9odvrFETiDgX3LXZerrtNR4M2x4hPBz+
 vGrj+HsLKLNsBy4SdNx2gaE/tzQf6OOsyko69QnY+c3bqDbt+bXP559Si6qR86KXSm2s
 aGxA==
X-Gm-Message-State: AOJu0YwHe8DXa219OkCy0iKDOXWOlkyzsko4EKux1ZeLQwDGFsIcqUlB
 YJBgbY3Zdwc2bjgllrUmVFKLbrUaHQGuG4VEzdtQWWG7bfSkgRmKHyGZNPuNtTa6tn+z6FWAwt0
 ZtK/4U9lonJ+FX7fITaTSZNaupFtJ7rOULvT6qy87
X-Gm-Gg: Acq92OFI3w5FXSxGgaiBvq1ohr8D1cEdc4eGOfez6dvMhIjXnA9zkFIMix9wEQaqf75
 PCvR+SwINrWIUEBS9l2eUe/Cec6cJQkroPacqjU9HKKhzn5T5vUCLqJoRZjM9PIooR16WSyKVV3
 KuhTZqG3VTQ8avMCSSTthxAnWDrBUoWdDFs+yAbR075n19RvzfbrJ87dXZ7V9ihcZoBc7Tp/Aip
 GE4IMguNkAWcT0rOsicfsKW+yxR9E0TmRi2lHPLycfEfSMqzKyW2u+oae5nkTHZtNK97p6Kz3ZV
 kpO0BrDs+2efQvbs
X-Received: by 2002:a17:907:ea9:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-bdd23bed030mr369503366b.22.1779591745747; Sat, 23 May 2026
 20:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-1-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-1-a24e16302a13@ya.ru>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 21:02:14 -0600
X-Gm-Features: AVHnY4J9AgIfKr7ol_8Yep-zhp_ImKcPjmob7BAVmIOkIucCRAbRpB6mWBwGKZ0
Message-ID: <CAFLszThXs584-D+aKMH9Hd7G-2v6autQedQ7-LfbNdNSOcU7AA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/18] clk: rockchip: rk3568: Fix building with
 OF_PLATDATA enabled
To: paullo612@ya.ru
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-17T19:24:26, Pavel Golikov <paullo612@ya.ru> wrote:
> clk: rockchip: rk3568: Fix building with OF_PLATDATA enabled
>
> Fix missing include statement.
>
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
>
> drivers/clk/rockchip/clk_rk3568.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
