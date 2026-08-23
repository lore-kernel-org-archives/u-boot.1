Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ED1C5DF97
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62ABF6066F;
	Sun, 23 Aug 2026 14:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzIMs3W7er0t; Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497070;
	bh=evTbu+qftbAcGgMGrVi0WtRDHLAvgW9ziE12M4rW89I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kiv0AY0N8ya7UtChnot60lLfK2iCAyJj6nYt4IHD9+k9zx/yV7RlrzNz+IlNf/718
	 AQtbsV1ncLW8FFQoZbFQyn+/qavft2U785qhJdozQ5gEEuX3bg39Iw+Y4ek+4z0gf/
	 YfS0MfJqgaI5rw4yb6Rqi2OnSUrUH3IbtHCZv6yntK4q0fOGx1Oan3O9gWQEngA90z
	 quCCtK8ABalT4cJgG7bSh1RYcq8FfRuUjO+qmlC+iQX2qi1FvwkDmflKubo2A37ysn
	 nUW70rzQEfV3vkmA5JHfvu30sJv9pu94z5Y7jpjdA/EfLTMVJtTs4pEpzUZrkWHgpr
	 hguM2eMWl+qcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8500360679;
	Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC98A336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB5114052B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wi3ZALIwL2VU for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:57:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VCwt9gfW
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2195740515
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:47 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso1250144a34.1
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497067; x=1788101867;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=evTbu+qftbAcGgMGrVi0WtRDHLAvgW9ziE12M4rW89I=;
 b=VCwt9gfWHtnQ+/IiiwhGr49Tvsz4cwLJ69hra/g2vzJDaIu4ZHKz/5llGDuEUzms5A
 Tj04TGdql7kU+B2B/bTGFOGmn0EZM2IBJie+mU1TyGHn6coXnSjnne07nAG8Kp4op/D0
 m9htsg1o5gPzG0Js89/EVGtUzf5lowhi/RuMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497067; x=1788101867;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=evTbu+qftbAcGgMGrVi0WtRDHLAvgW9ziE12M4rW89I=;
 b=DaZep/JPzBnJXserJx0AkFGOZkkMv7k6GxBmT1SXlhGmL3ilX9js4a59JRT4f94DqR
 122MJxiysrueXf/uffHb3UZdjjodmwtqvGCfrTOr42m+B3GoA20AacEYjD+0owSK4eay
 VvHe7ZWRJlcS5IIwtWovZP2JMX5A+2qiyqqdvj1gQgZfiXTsyVrDchPA6PG5TX13i75A
 6LVSklyfZQFKy9nmHLGDwkJ4IO13qRBbg2J/3E8+bLK+i0+ecVHKnK8fnXCcjHpvWSBs
 nv+LRkn5HGUQgaFSynbYHI1wD41Kxd7IMFKenWsvoVN3ZQRUQOaY5skinGaDSLBIJqOQ
 D8Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuwwzA+qOt9YHrhg5KfFzL0hfJcnVE3e+SQrs8B1T7o52FXakOXFvMrLRQY8BMXgKJOlmNY84=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nPYHFKzaV4lePsyc6nRVNznk1pPnLe2zZfd4cvOpQB9uO02TbQ
 YLNdFE5zksDVC1ndDQQVqM7UX2YEsv4ZnhMoCfcIAXmtLQW9d3zSncxu0MrjW3Abrbbt52WheLo
 n1yRt25bCNCEi
X-Gm-Gg: AR+sD13DaiiXY0yr6LhdX6ZHoKzY27mCncL1ueLi9Jx/EGFKIsU9yvm8z42B1kCkKaw
 LOmtC6zR8YR8vr3iuVUtr4e695IC7Ei8iUUSRWJDZ4wovV86IIaXV9eVFW+urdHZoIfB6dE9Gsr
 BLQZw/ouZlI4JgMofRRxAluOsl0hz03drf0UK4pTIoLonhNMf4gAMdorGn/S9anwnGFOrqPjX+d
 QSCplJI91g8je9JxSa5tu/VqDRAo4by3uZRz9AymJ2uQNnZN8j2U8JNVCAmu8uWhMK7XDit627d
 MyorZI2FTBy+I8scRPsJ3kD8BVUkFtaeFR+Vo8EXCYxB6ZJacZT74WRDvA80z1RM5vjGODtNa19
 jhKjjOjMgC7DZmwXBCUHMdRwt5iQ0NcVfaGtA0pV8NN9cGmgPoxGuOgvYwirjwwCaYdoVKzOnpk
 uIG+dbYJTi//bxhAi9xUlcu4ruRJDOixSVooAjRizDUPPeha7qZGQ6vGDpsfhrpYK+FmtocwxAM
 w2q2jAR56FVlV0CbPk/p1mnr1gxZDM9ORoXbAGgELod6Ry6Fr738m6V7/ess8skkG6bWWKgxoKi
 yfQolVEw2ccgspqfZ+w=
X-Received: by 2002:a05:6830:380f:b0:7e9:8867:cb23 with SMTP id
 46e09a7af769-7f476556758mr14980828a34.16.1787497066755; 
 Sun, 23 Aug 2026 07:57:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc89283sm2028583a34.24.2026.08.23.07.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 07:57:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: kabel@kernel.org, Cole Munz <Munzzyy1@proton.me>
Cc: quwenruo.btrfs@gmx.com, sjg@chromium.org, linux-btrfs@vger.kernel.org, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <f6ac2bbdb9b559041cb0c82efccf89ea7262cb43.1785545440.git.Munzzyy1@proton.me>
References: <9acf406b5e73fa83001e1951e883143e2afb8b2d.1785528314.git.Munzzyy1@proton.me>
 <f6ac2bbdb9b559041cb0c82efccf89ea7262cb43.1785545440.git.Munzzyy1@proton.me>
Subject: Re: [PATCH v2] fs: btrfs: fix zstd decompression of compressed
 inline extents
Message-Id: <178749706570.206448.5287903104249745566.b4-ty@konsulko.com>
Date: Sun, 23 Aug 2026 08:57:45 -0600
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

On Sat, 01 Aug 2026 00:55:20 +0000, Cole Munz wrote:

> The kernel compresses an inline extent as a whole block:
> run_delalloc_inline() calls btrfs_compress_bio(inode, 0, blocksize, ...),
> so the data is zero-filled past EOF and the resulting zstd frame declares
> a content size of one block. The extent item records the unaligned file
> size though - __cow_file_range_inline() passes i_size down to
> insert_inline_extent(), which stores it as ram_bytes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fs: btrfs: fix zstd decompression of compressed inline extents
      commit: 6f0719e4c420d9e3b1cbe92b2934e03f2f57e6fc
-- 
Tom


