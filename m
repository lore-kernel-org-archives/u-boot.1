Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C70C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 22:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D15D44059B;
	Mon, 31 Aug 2026 22:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7199gEnaVJM8; Mon, 31 Aug 2026 22:46:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788216371;
	bh=AW1QRbSeYKh4ijkrBeXGjcIMDxdILbVl1dbGkkxyxog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6a5oLG2kHy1ZrxmXuTT3RdFeqaOFVggwTCXULdofVcqFMjotBZwjKec/V6DsJVgJ
	 3IwqyaeVv8qsGEC+jKP7AOttgkiOCgXkP9IsfYW0BasJHXRCMtd0oT4dKQ890KZr6Z
	 I29MOVVgamA4Hifu9IAkz2ZzjQAOyfOqxBBQ6Vl4h6ovvJJfOzy20b0muurWVZlHg2
	 fjzwyVGABwZSlg57NwkOEDp6m0+6qoygNttec2Aqbo94wjmP6Eu+/Gxvp+CfG/+qL2
	 0bv3svbg8aZgKbuiH2jtNxEvxsUS2e+v9HwGTuu961DOnV0NX13Xq22hmNVm2SgOb9
	 Pv11R7LCKdyIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E47E640556;
	Mon, 31 Aug 2026 22:46:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA2A42FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABC35400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y7usWDWF0XfG for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 22:46:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qu7aHxI/
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F174840056
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 22:46:08 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-46af2e2654cso395525fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788216367; x=1788821167;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AW1QRbSeYKh4ijkrBeXGjcIMDxdILbVl1dbGkkxyxog=;
 b=qu7aHxI/2A1XePcL0qjngBENtqiY5MgqeyjhS5CBVqrn268z3278tyW6dDrrTb0oys
 EN3porcpMIYiBqKv6eWYxniDuD2+me8nZa7QoRH30M1EhTWBmXDEB3ojWAEIt8KmjBtL
 oo4xzqWbuVblYOIR4iOhOj/xswdcDNPrftu14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788216367; x=1788821167;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AW1QRbSeYKh4ijkrBeXGjcIMDxdILbVl1dbGkkxyxog=;
 b=C0clwX5TKt4esGKuBfaz5XoklAhYMpGo3nzZsSV0UkPuRZS44ct61icxwJtPJYx+an
 TB40wDCHycGMznLlWgtCIzAOBAYNbgzGuvC1rDnYLUrikUxgkJ9Azv6PTsLCs86lRFqm
 iRI682aF2HdN3ORlOYDSsCIAxMET56XeMUGJXOI9TSCDivTvzw5I0crFe/ANxtbiCOP0
 ZuiA78PC8dPSIvbnDKx6cl0OzgQK6C6nD0oB+v08TPjUMuKuMOFdxts2gbo9AXPpvbza
 xtEgS/z9KaSeTDrI7yod4LrjUUeB5iNPGjAJeJ6DJMHe+vbwKe+iIMQV1UjCBRhSlp41
 G/RQ==
X-Gm-Message-State: AFuF++nWInSQqdQGi4oTV0tvCJkwkRdrj2+NK4NKHoGsPfFz1pHEMNXR
 i3DfgLn3kxxMEwKMZ1g/7GmklMvR1U50LD7a1txsqtRfS+xYI43ZqC6gS05CS79oyA0=
X-Gm-Gg: AR+sD10pSBo9kfpYSdwJuN6oJUABeTZuUzefmvmonF2FSJGV0lSWXa2mMaN3OwSTz+Y
 29lYhdiSq+LD9ulEj5fkrGOX/qN0UWAUQoNKRO6QSgjYHP4y6Tj7D3Wv1gmHN22++GYu95jWShU
 w1a3x+GG9+tT4Cs58GQgUnnWbNKtxz+htSkPbUDhwi5iWSkYJdK2pTKGHaX2dShv36yDX+EgTqu
 IC1rvGFayY5nZO/nTBx/rozo3ypx/664bJ+VI8KB6W5sYZTvV/eEY+lB9CfyN+o9/D6JUjRrkWG
 bVn7PKHTIxmrwrWvZC925ToySyO2Gyx5XEX0Zg6jPnp9TJ/9pl1Z35BIWCU30LHTQe8QzbXkVQL
 OslThfn7Y4oeIOBUp/7hHal5jWP+BFoXYeR3cCJbLCNy5RXDAOIdOkIeIKPNc6uyxf9LwK6z1u2
 12rP0t/IQ/b+JDHCKjDTf9MmBDM+ZKMGSFdXN4fBety5Mr126m3X2IY6v0QFSQUZHxGiGoajXOm
 NuIje0b3BggnpMbVNb2udzh/c2hplSdthZ8GqC7fWkz883SmJPZUvLLdaeKkPhYLW+fvdo2CQrQ
 +2JJwO9W
X-Received: by 2002:a05:6870:82a8:b0:467:c40d:8920 with SMTP id
 586e51a60fabf-46af568cd51mr4431570fac.11.1788216367335; 
 Mon, 31 Aug 2026 15:46:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a4ef784esm11009499fac.9.2026.08.31.15.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:46:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Cole Munz <Munzzyy1@proton.me>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <8b94e9fbaf45e2ccede0f1a4a6bfdf53f82a6a60.1787561254.git.Munzzyy1@proton.me>
References: <8b94e9fbaf45e2ccede0f1a4a6bfdf53f82a6a60.1787561254.git.Munzzyy1@proton.me>
Subject: Re: [PATCH v3] lib: zstd: update to latest Linux zstd 1.5.7
Message-Id: <178821636625.1229240.5785829746184687647.b4-ty@konsulko.com>
Date: Mon, 31 Aug 2026 16:46:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, 24 Aug 2026 16:21:07 +0000, Cole Munz wrote:

> Update the zstd implementation to match Linux zstd 1.5.7 from commit
> 65d1f5507ed2 ("zstd: Import upstream v1.5.7").
> 
> U-Boot has carried zstd 1.5.2 since commit 4b9b25d943ff ("lib: zstd: update
> to latest Linux zstd 1.5.2"), which mirrored Linux commit 2aa14b1ab2c4.
> Linux has since moved to 1.5.7, which carries decode robustness and
> correctness fixes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lib: zstd: update to latest Linux zstd 1.5.7
      commit: 0d08023f102f187c625b586d867e082f69fbd22d
-- 
Tom


