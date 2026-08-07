Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2CFC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 240918137A;
	Fri,  7 Aug 2026 16:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aB3qjbBSBxTG; Fri,  7 Aug 2026 16:16:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 657BD81370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119406;
	bh=6B1tg7uCs+9qQiu5mXx+GzDPwa40bo9hxX5QG23zokg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0iME8RYQkrKqEJLHEcRg6MX5ZLFkXKLETu/1cSVcEEIYh9A/cuYYnL5ywAfQ1AauN
	 S8j4cPmohLmKxkb9ffRImgHN8gNBBSkYc+6KniTOZXgKECvwGx4UvlU24+Rg8doEdq
	 QFgWqglbWtsd9sqAjQH8niztRmtHWzw25ckmUzTjmBkuGWb9b9GZBke9I/U93bydfI
	 2HoEuxNSxELRbhffD5jls5tkvRZ2VfTAwcCXi3uGvIRD7H8tvE66pDsr89mGIbiGUi
	 3KHfQubMeUMM2JVeM5AI8y4DjbCn2irvDmzfUNuZ+gJxvR+tTYgFSMOERZg2NMYpZE
	 A2u5Og09zltdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 657BD81370;
	Fri,  7 Aug 2026 16:16:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ED55D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 454EC4010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jh7v0NSew_qU for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DCDB4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DCDB4008E
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DCDB4008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b01562adbdso1041961eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119397; x=1786724197;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B1tg7uCs+9qQiu5mXx+GzDPwa40bo9hxX5QG23zokg=;
 b=MPVSK3aW+YDdCCzW7Oi//ZNyIHH+vTuMtoOk16EG7vTVVm3mfETkTEomyMzs9w1Ily
 EIZ4Ehi4uanhOwx7G1ZD0aL+Cjr1oda+fUdgAR3godM5RXTCWuv91U8xW6WGi4i/R2W/
 aRy3L8hyai0kNTDms0WitQ0sOqu3SzXy/my/Mnhc62hgNjiLDJ6cV7dSBglFnSeANC+g
 zBZU7KqoqJKNFRnnubb6/RwVvT6nQnZSOKeGpOE4aGYzMrSUmTrET6lm+xv4QcWd0w0R
 k1piDzHQbbj78ddrkItax1UmmsZkNnWJvUG3X2JV+6ev++JKPPrptwhkZfeufXIfaltu
 ocpQ==
X-Gm-Message-State: AOJu0Yzz/3EnFatMKS0iR/WoIOZnmPGH+eilMnuS3OjNwI1gq7CmxclK
 RuL4HQ2v2a7EOVn/cm2jsqJf/RmWDCnc+BMyzdps71gCiMkk8lQgar0W441HDVtTQdvrhl/QL5Y
 hH0P1WOE=
X-Gm-Gg: AR+sD11TnDfI0VvAsN/vDDEvAyBDjGcPgK/e976ULNQzBIrAUXY5AfFRH+tZZ9//e6l
 hDnVs6MGB6BTBE1WCgIGFIxGU/MGNhCrvJPC6newCgIVdM5BVliNha4ziJRRfDiQZBWAUxNU05w
 7KoSeIWtOvAug6OO8VFhAfIrMdtns6PHPhk1RvMZgBkDG39+mSpXCTjP831fzp+u4pSUprdWvNg
 VW4C4yjUnK9xd6tUKiMKyUkU8ARH24oruXCJ0Qc5sz3zxzPlaqMSex+bD+rCfDd3S9MhBrvwRm1
 pDWYSFUXfTUPo/tUoY95lAAI08OdZGZT8mrKi1d6b87iOJ3pdtcb6tpIQav24+anbmpCOsnerB4
 yhSr2A2qW5j16JI3Nxo02i8mGT2IKrzW+dHn2ciJ6+jj/07yhvMyVZYwnP1Pk+M1FtAnblxJq7p
 3USWLNj+KWr6Jk8n9t92Y8bHuaOrGp8wotSjssuzKIKckPnWdvkKHpEwABAYGJQp7Of2gKrbD8Y
 WuM/MKugGZOQ8JEuywSLctld+gykbnEScq4wXdRKQkKrUC5Oiutcc6vqNqGqJrRrhaVtSV8X7TN
 fpZz46R5
X-Received: by 2002:a05:6820:8118:b0:6a3:97a0:b224 with SMTP id
 006d021491bc7-6ae970653f1mr13470671eaf.33.1786119397328; 
 Fri, 07 Aug 2026 09:16:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20260731201935.2542305-1-trini@konsulko.com>
References: <20260731201935.2542305-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab CI: sage: Disable test_net_tftpboot_boot on
 Raspberry Pi 4 for now
Message-Id: <178611939647.381449.9110464191058042214.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119397; x=1786724197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6B1tg7uCs+9qQiu5mXx+GzDPwa40bo9hxX5QG23zokg=;
 b=QOnRxYxjfTJnTat378QlxNdRJLHHWmRV+flhT9ec/U08LO07V/rYHU3YclwvgEFRKW
 /8cHDRC9cHL6HSrLYS3Gz07ELAbDD5J0G8SuFHrQywXyCBq43MZyQe6d++iOBhL8tqx4
 esABMlcTjvz9++igu8LvNYKRrVEgZrye5OZ7U=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=QOnRxYxj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 14:19:35 -0600, Tom Rini wrote:

> With commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
> we now get:
> ERROR: freeing fdt memory region failed (addr=3ef667e0 size=36 flags=2): -1
> ERROR: freeing fdt memory region failed (addr=3ef663a0 size=400 flags=2): -1
> on console when booting, which is non-fatal but leads to the test
> failing. Disable this test for now.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Gitlab CI: sage: Disable test_net_tftpboot_boot on Raspberry Pi 4 for now
      commit: 06c866fee0052579dbd27456fac425d002d44a80
-- 
Tom


