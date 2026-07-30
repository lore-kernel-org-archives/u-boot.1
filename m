Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA1BC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41DAD81046;
	Thu, 30 Jul 2026 13:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jS1xIh8aEpS6; Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80C908100A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418720;
	bh=B0Y3c1wXlHCwJ4KkEGiasDJHnIsbbGikatE2VSY/as8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B0x+65l4di8f72yUlTtgFm7QBb1Y1XaF4SMPnhnSZ1HwfNdVbNqWVrBRiH77sqxTm
	 TZyO7b0uXzaoeP/E3mafURVw/h/S8DFpJ95LNGKUORqpExaTR9BKCZMDrndJ89qLNp
	 IEz95iaGqHi2WNjJ+jVX/8dBDGQrnhbMaB+4X/FGf/EQ8TvVu4d1XfKbDtppkzzp3r
	 Txn1q5ovYQpsuq5mxKPX5RyiNQWqYWfjskU5x9veZD4ALa6odin7FegvfmnuyyiPFh
	 9GXNq1UvKYNa1XGyEjmBCoa5ibji97LyWWvCsC5+WyZ+nyEpzwFU4ovN2Yp9vMl/yU
	 EI089SdibbIhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80C908100A;
	Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFD1F197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E14EF80DB8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vse4hmvMeaTm for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3AEBA80D9F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AEBA80D9F
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AEBA80D9F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:37 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6ab06473488so833928eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418717; x=1786023517;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B0Y3c1wXlHCwJ4KkEGiasDJHnIsbbGikatE2VSY/as8=;
 b=HdSWV+1qKG3dEORkYPJMob8LIr/CS1i+1HS4skxfZD1y/1bhdIpal52euJt0tvrO9a
 zUSXA+l85fQDkh8amkXuD/Ym9A/Y8RbSV8/OKrOlohzSRZNCvze6LORJX2wSarrDcyhJ
 0jZ2OGzKh39BUGAXiICBSgYLLUMTT0Fg/hEmW3dTL+4QRDf01OUv36ig4uWyiiqRNuEO
 MeOhLuptKXGiRlcqF2H0rYYbvKj9hUoBd/kHW4dmv88Cfw1uycsdpfsCKJYGMkcgfU5E
 PkU07ARsNJqse7TAM6UcSiheboAjvUlKcPsXRjc3fVNCgiI/DpMKJQJemUF1q3WWBeNb
 Wrjw==
X-Gm-Message-State: AOJu0YxX4O41zbP1WhCkeg96IPbhTMbjXm0YqKqEP/PsOkg2pB9uEqa0
 sbOChPoTSWRnzZ1kdp0RIJWU1HOI3bXq0zc7SUbpNn21wuu7/pVF6dkPJelJnm6Py0ubkRc71Bg
 7XoLrAls=
X-Gm-Gg: AR+sD11BwPsxMWlPjCqr8NKMvcRzXxC5LhPk5lxdn+4eQV6vsMvoMyhcCReDUent2h4
 jt9qlSsi+uBNgIPGNkqrVzJQTisMeSBZoO4Iht51dUOkW2qa1E6WUtI2X61L86hQnnemLfH4jCy
 OwvZ8qtY6Xcckd5sNb5cD7yukdcUuAl/9VQiSGhfFEJgdClgpspoTAzTC3uT+hvfNmdmUMaKHgI
 CMQB4M0ka91S65bOY3GF7+apBuOdfILvku1QZQqBZ2EzLtiVrUkyuaO53CpDYl+lMTYNfgNdMrW
 8irq3yy1K+7AC3aTd7HHNN3W6Bi7+4W/rDa8YZpRuxoO2G64x3VqyjxU7HSfb/xcgnL6M0cKVP+
 eoNHDYIv0I7StpOpIclFtk9jW4bBNrz9GiS1QIOZsXuwhfIbLx2m6c/ws+NIri4obmGti9PmkCl
 x2Ulmi/oWyjwGPfiaubIXq4DVoAXhibpa459eMFkMhfAHuuZ5MQuJ/ltPqtimvjoVQfIY/DIS1I
 feWBtPhJM8JJj64/ACkkQ416MmDTvfrIqnAijPQolOgqsVjPft6FwX8Ndx9sckrem5in0IsOSJ9
 WGvuXoD3HEtaYE9FR/M+
X-Received: by 2002:a05:6820:a09:b0:6ac:a0db:1a78 with SMTP id
 006d021491bc7-6acbbdb9101mr1617179eaf.5.1785418716989; 
 Thu, 30 Jul 2026 06:38:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260728221231.1745444-1-trini@konsulko.com>
References: <20260728221231.1745444-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Azure: Correctly skip semihosting tests on
 vexpress_fvp
Message-Id: <178541871392.2173019.15761963387559933898.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418717; x=1786023517;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B0Y3c1wXlHCwJ4KkEGiasDJHnIsbbGikatE2VSY/as8=;
 b=BFJBZHCa5vwX8VERxYQFJdE0Zd+8QwSBBto6XIf/g0BKQ0y1Nj/R3H/GFr8bdcnhom
 EsD+bnDf0Dk8Kfo+2NbSxCpexTRF8a6oizrvHJivuviTkfQHh5oWYVfpAL0YaQiOwiKV
 ob12CgvS6BUBBFByzi7xSJNmejZe7X8XjSYKk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BFJBZHCa
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

On Tue, 28 Jul 2026 16:12:31 -0600, Tom Rini wrote:

> In commit d75998b476de ("Docker, CI: Add vexpress_fvp /
> vexpress_fvp_bloblist support") we specifically disable the semihosting
> tests on FVP using platforms due to upstream issues. With commit
> 7ffa20af30dd ("Merge patch series "fs: regression-safe load <iface> for
> null_dev_desc_ok fstypes"") we add a new test that was not caught with
> "hostfs" because it's a semihosting test. Update the logic in our
> pipeline to skip all semihosting tests.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] CI: Azure: Correctly skip semihosting tests on vexpress_fvp
      commit: 9e596aee6855edc7e786b90db07e24a4f263daed
-- 
Tom


