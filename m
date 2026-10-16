Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D58CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 16:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 046C460B57;
	Fri, 16 Oct 2026 16:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUBkb3tSFJq6; Fri, 16 Oct 2026 16:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5892860B53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792168814;
	b=bbvv9hKQuwHesUuXIsZlZGq2kcZuw+4z3XKRdVv0c0bCfgrfU+GbYW77ZUyjk6HpVFDn
	 lDM0LDt6oya/qLulPImKnMDFjC7iNc9DORTILEDgqzLUkXXDsWGtJbwi5inDAAG7+Py1T
	 VCrT1wgZoxW5aHt5Sr0o831KcymwHv+M+3JKXx0/q73RvyrLuTq7G42/qZKqNp3AQKy92
	 uzXv3L+khvtQR92Su10AQKEv4HBdjM45MiMVsQQwYQkXoDdjW4TErw+OPu/TjAdaZounp
	 7tkCsZy3pTE9knqqoWfXZkGyhQBhrFGMtvUI970RB3DvNE4qIHgkEbOJNkIkOyxchXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792168814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sr9zLcBforH7tB5HQ9qbJyjrxzT9YEz0EdXGAFpXvks=;
	b=pc22dQ+eTXyoYVmzSJ/rl4bBMw2oNj5dOT4WnF0jKZz4GHJEU7fFPdruBlwGiVp5ul0Z
	 HVS6XywqwSmu59dles+CF1bK3Gfc8NoQ/ijjbmgZpD5rDMNIiQNZPXuVFTXkZp0W5WPAg
	 A2peKCWdmx6U2uOL0sxxVF2lsSbGm7EJFRt9BWNBBo0kJLbDgjUQZ0LtjaujLN+4admZ2
	 napbofaFmInESowgRQ0WMex6+oAWRFS+NLtSzWuLzHVavGthEEDekFl4HI8gegiJzCsyQ
	 +yBlLd47RF6ws4WQDVfxmNs3GcwY5xrvkd1mrunH2GJkDx5crfTUl/5wTlIo94Ugykg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792168814;
	bh=sr9zLcBforH7tB5HQ9qbJyjrxzT9YEz0EdXGAFpXvks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffnTjd044VUp+oC2f+NPJ/l0TVcc7vw+RoU/rb72GTU/H95twkFcjdnBHG6drCzc+
	 7RolHnMlo+LnEefRF2bHVDnzH+mbOtMGUEmfC2vrHJYWspEFN4Qi/ipF9Dv+3GaGLZ
	 z9WFqRIjeptZJAYJZJI2aaHwOeU05tJbceubFAZC1WwcI+NPWZYcscyFbTLNHD6Vh4
	 26f31VmhbNvQlOWfHhunj89YXIDLeVmjApkjjJlnAr571E4ANBAw5gmlXQQLEUoSKQ
	 niGsoBKwK+Z6NE1odpUhX5XihbH1eqJE6C+s+36g+4ynjbTfJhJPzZ/CEpxf0Z1KZh
	 1bmFLzgMU1GTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5892860B53;
	Fri, 16 Oct 2026 16:40:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60C117AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 529038159B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kc-kgTqJvbMw for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 16:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3B118156F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792168812;
 b=dKZf9CH8kcLNGnfxcdljGaAfNku4RmPmtsdX3fxvQIQD/W5Pv5mMkLyZ+VMf09pFy3AS
 /oAV9d9uA3zk9V8JCdzNmUl7qBkpNkUC1Io53MRcFhtNYEvT12/dkI2ic7ROQLXxAw306
 Gs5U19yCj3L31COPrrhPzJu8f4wH1MZRqET5QaL/0TBqwIj1ZTF/55cVDLwD/Gpx75LME
 f79GCbHQBV8zk9kOnJDrsIbTO2mmRagt7QZfDdaoV/z1M5vlW+y6szjX2Zo/u/LI8LCi9
 OEn2wPfRM2uEzUm8ze9LEX6+7c0Ku4qodPJqkU1nwpQZqGo+aQqb/CvlN/Tc1qFcbHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792168812;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=sr9zLcBforH7tB5HQ9qbJyjrxzT9YEz0EdXGAFpXvks=;
 b=cjfx8D2HJNfeD1vKqkot7uVE4F4EVUPz7CCqXGB4D8wl8+p9zhgFFVUgD8UfmzYRjf/Z
 3jVlcJMxiY+pgItd+xXA7g422h4nItQg6VbpgXDDVoUca5BSWRMibCzlFo3XfnDupdqV4
 OYQr8fvkysw6iVN3VHFrYJmnQt4gIoeEqntccLo9eAThe9RIuv3y2tuySJ5u6tysBshFh
 lff5r6pShA5PZsbnArcqZpg5LPF3JSespgO2O0rdKsqbGl0Ss01lBNmL4Pr18adh+UV7W
 igw3afQ54bMmHD8+RkTNJNZYxYa5uuIi9NCHK+MdqFmjYC2h9GEn1Pmu63ZrSIkbznQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="PP/RsFDd"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PP/RsFDd
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3B118156F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:40:12 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e987b4a710so5113905ad.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168811; x=1792773611;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sr9zLcBforH7tB5HQ9qbJyjrxzT9YEz0EdXGAFpXvks=;
 b=PP/RsFDdxVq3nxaFpT5wlOT7oKdz8f1IBGP1Ynwo37WXNGtpQTJTLGu+Iz0a2wLoX1
 jhRIbtpCe11WErCw9qHzy5bKDYTsPJ5LxKkC7rgAGC6RVEsC0zP2Qf91rkMloIJzC308
 5ddD6/Je5Ke/JBJcGs+yyIA0DL7+hDHiMmP9JlwLV7ucT2Ae2qTVL8zaq5F2ud0pUhtm
 r/eWsmPDaLCK6AOa+JTMjCBom/plRlMVTZ7l7Ln20xjBR7KvrsOhX5rzQDAuSZtqeLAJ
 sCk+V2MxC4/Zy1B0TXMzrgejcwb5ARE2QqytZRt3IogqPoBn2e7VPqPdVt6qsEqQ+WUg
 Qq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168811; x=1792773611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sr9zLcBforH7tB5HQ9qbJyjrxzT9YEz0EdXGAFpXvks=;
 b=VUW3t1IjsgPcQ3nHyCbIZPraTnMdRVhssHplmyhbJPTaTrAnGFjTRyW9eXRCUi5Oqd
 UFRfe2+MpEioUUw4CIvIwUaVnzH/y2aakF+BGS857r1Dfg2Qg/xZ0ATiZebQhjNyfFmT
 lGolPmv84mLq855SdlGmwhURxQwVXJ+CLOouYueazC2EIsTREYCIEzjx5mAk/DfTObEd
 lSs3W40QHtRHrusughCh1JzK3cnYup06PEzfwhK7TUt9p6h2f5B0XqREyGZqroYmufau
 h+cmCMk1dfl1VbLwpul1P32Q7qUrFevIbLanyCofFk2lerYKFFDgKAJYxhNoLnYDoILC
 cwIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByvNiMl2jy+nZEf+MB6jg9O5bKQ69puuStH/e/TkAvStaeIDWYWaXqVUmzWseIuOpE73/xtaII=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKtAQdCBR3QMsE7CNwq/P89FlA58HA30gajuW7ouWIIfNBRtNjJ
 g8nzKaNGIrm6zrWmjnYHC05UdkhqsrVYnXO7Q32dI4vhiM8NqQgHDNxE
X-Gm-Gg: AYBFou01mtxWgSKnGkAi+yQZOcmvf5Y6fDwekzuOpguGqYlfncSdQ3amy/wbVxetLaZ
 OR/aYb2261Iqc09AKSzAncjkQ3J2B9bIfQsnJr4pHh2/fuGFay2lEJFwzZcroLOMfywYu5WwOaz
 8ZYTM5X43j2clCSWvhBbS2zTkkHx0Yyju/Gl+/6qHJQbSkLqViRhI4lCCeqWQUUFOXHTsw796ki
 WH6sMbtu7ZjcLNxEnP5wsVWpva4TzwWFq0UCHN4g8+4QC5KtR4M4T8bn/V+U/pl/kX6FsDshhcN
 LRs6/KHbM9Fm742J0RThLMz7WY/LKvVwFCMUX518u1I/pODcR9gNTURIMfL7xhaRefryzJgoGBW
 JHJwrym/OaZpsJiXz/BxqI0CtObf91x7gOLxtaX9gEC82LHKy+S5Bij3j5X0A7j+Xf0PN9TFAkW
 ip0wuDNlbxfarwK0RfTOXb+utt5xk/gc214eYCvhiSnSdDsjkbrOOhTusc/61qyLPbYpTu6i9l2
 6jA9P9caE+/DyiB+dnHPu3S5GrfavlTTJGOh6Xupe4AFE+T9DYFuoAORxH2O5A55I1WTIU20pW6
 0tZcMYbzi5wd1JXABZTcBx84T1K8kETKlVe10bRaQjyS38+EfivK1w==
X-Received: by 2002:a17:902:e88c:b0:2df:5c13:b37c with SMTP id
 d9443c01a7336-2e977557360mr26775245ad.26.1792168811412; 
 Fri, 16 Oct 2026 09:40:11 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e5c4b57sm12877145ad.4.2026.10.16.09.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:40:11 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>
Cc: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Date: Sat, 17 Oct 2026 00:40:06 +0800
Message-ID: <20261016164006.393531-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014212835-GKM26088@kernel.org>
References: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
 <20261014212835-GKM26088@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Yixun, Tanmay,

On Wed, Oct 14, 2026 at 09:28:35PM +0000, Yixun Lan wrote:
> I'd suggest we try to see if able to go with setting DT property,
>  assigned-clock-parents or assigned-clock-rates
> the advantage is it will also work on Linux kernel side

That makes sense, so please consider my RFC "mmc: k1: do not require
max-frequency in the device tree" withdrawn in favour of the
assigned-clock-* approach.

For what it's worth, I finally got a working UART on a Milk-V Jupiter
and ran the mainline SPL from an SD card. Two data points that may help
Tanmay with the respin:

- 2/3: Jupiter shows the same failure as the BPI-F3. With
  set_vdd_mmc() putting aldo1 (the SD vqmmc) at 1.8 V, the card runs
  at SD High Speed, 50 MHz, 4-bit. Single-block reads return the right
  data (protective MBR, "EFI PART" header), but a 32-block read of the
  GPT entries returns 0 blocks, so part_get_info() fails and SPL gives
  up. With aldo1 set to 3.3 V instead (a local hack, not a proposal),
  multi-block reads work, the SPL loads u-boot.itb from the "uboot"
  partition and U-Boot proper reaches the prompt; "mmc read" of 2048
  blocks also succeeds there. So dropping set_vdd_mmc() in favour of
  SPL_MMC_IO_VOLTAGE looks right from Jupiter's side too.

- A side note on debugging this: the SPL printed "Error: -38", which
  is misleading. The real error from part_get_info() was -ENOENT; the
  -ENOSYS comes from the SYS_MMCSD_FS_BOOT fallback, which runs after
  the raw read fails and has no SPL filesystem enabled to try.

- The io clock that BootROM leaves for sdhci0 on Jupiter is
  204.8 MHz, matching the SD rate you mention.

Tanmay, I'm happy to test the next version on the Jupiter and reply
with a Tested-by.

Thanks,
Hung-Chun
