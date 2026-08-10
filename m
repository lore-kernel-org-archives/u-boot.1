Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443CCC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B2C680F60;
	Mon, 10 Aug 2026 20:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLD-5AdEmf6p; Mon, 10 Aug 2026 20:53:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CD3B80F1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395218;
	bh=QMPyXgug1Rz6tR2uNiv+QJuaMg+dR0EGxu0lNcyOGlw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0ZAGf5dECy85q5z7K9SF+NjSGs+Pv38bWd5irSGlOXuBMXTq7b58Kc7bc6ZfuR/c
	 BvyKBL3eTH3d/i5orbX3+65nHtLhSfkHA7N0IUHXcVBoFrUBmLmlmTPPhuPQs13XKr
	 izOadDGMYKkmt6d4ChwbutvBook9U9gnCa0XM8vmt9PDkGGXjxREHqVeCIDPtT3Gix
	 7LMdx3vW8Ww2n8MRVMTNpgPsMCci0T9Xad2C7gWBA7ac+DAL3X7J8QOC8rWNHazWGx
	 DJMzy0u69nmJHPZRd5FPX9+a5ygHA8oKHB4pa3XOJfPf/+gxTjfXe1Jnd5yTeBbUGK
	 RmJfQaHxVCrqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CD3B80F1D;
	Mon, 10 Aug 2026 20:53:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0836510E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE3804018B
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cW2wzFVbcKzZ for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 346D940026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 346D940026
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 346D940026
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-45171f2f608so1212848fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395212; x=1787000012;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QMPyXgug1Rz6tR2uNiv+QJuaMg+dR0EGxu0lNcyOGlw=;
 b=SJSeJYGnBXE59qXnPeWn10IWNg8uhjd/cS2+aOFedzGNLG4c4bdPwqU0BoDfyDf120
 NAIG23XhiITWZav3Yg0AHFrd3WuPvt6G0K2Gl/b5WMbexzYRIczA0HgB/j6ddsCL7SgH
 162qwCrC46bo4k5nBYST7dXKx/oxG/c1E70rPvb+HVOQ4Di3u2hql3k8fTx0iPfjH6Cs
 xlut4X19vuMxa9HxwmcXGsrhDPqUVoTZAt4iqZrBrOoLE8ssKVnPcE2ircGY5Zgy/rBW
 e68qWDal1QlmvL5zlENXmPbGa4Ise0Qij0wl/DYC9drKLxT4ZXoAbq0/6Gvyrs3L8rjV
 1usw==
X-Gm-Message-State: AOJu0YxEV4jul2cZbxxZpFBVoEqcLAkDLS9mo17lQVTYJD25YxZ7TtiT
 x0H3MefBIT9XMpH52TkBqPDgwEfFE59LbMowfMpJAKbyZvSlfpcZ8kTNlRKFGk3RvS75VTYQ5oW
 Wc39DyCg=
X-Gm-Gg: AR+sD13cYCuTmoZAXIAL67D75fS8LafDJCVHWb3uIHtkaQXry5uUTg4nOlJ7rRHoBKv
 eLYGEquU8xd6vmPzs2oxBHfAGsnuSJPIjmGbiqjcS3QNTIabbE+o92JZWRgRr9rDhdrBdd5lpdN
 Ph8XXiSUIFvrOTs9O8SIcNmqpAMAC7qjQF/BFq9l/8E2fbDropRqjanp65J2Vstt5U4C9uekVG1
 PjrKb6dddobegw+o2XZ6QL/qu+eI42dCYbghh/AvsJJf+LE5A/SSDKJTGn3biCkx+pxcdgI17g5
 T0aLQNQas/8WDaG+J/vH+PyGiNopfKRpEZCG30KgcEIulR4I3f+JlDV1+yOTPsjomVYXdsbmCMP
 +aDI6GCbigZ5J9IVRtVhm1rN6PdLK3HE7LjQn+KsgJ9Pk+pDkwItZNz+AbqGnpC/mVsA2btgpne
 8f4+txJcjc/+nNuzmz9qjUH7ZKWOtSMP3FU0zZST5WlJPbZwIuHTlU/LSGnoHxpaI3X4SBe+wmC
 ZqhoiPa2xT2pOWDC+fiIcjOWht7BMdRAyzGlcA5jHf2pJzgfHWX8lVmmiN3hijvfx87Ta8MjnCa
 T5eh+xqy
X-Received: by 2002:a05:6870:31a6:b0:446:eba3:a1ad with SMTP id
 586e51a60fabf-45a0f21b371mr12150844fac.10.1786395211977; 
 Mon, 10 Aug 2026 13:53:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, 
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Marek Behun <kabel@kernel.org>
In-Reply-To: <cover.1785660029.git.Munzzyy1@proton.me>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
 <cover.1785660029.git.Munzzyy1@proton.me>
Subject: Re: [PATCH v3 0/3] fs: btrfs: report file sizes from readdir
Message-Id: <178639521117.1450255.12065207244142362485.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395212; x=1787000012;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QMPyXgug1Rz6tR2uNiv+QJuaMg+dR0EGxu0lNcyOGlw=;
 b=Al0uQaTxwBcNRvpmSJuroR+PyjEaG1TQjY0btlekH+a7Th5mEyniY+ETE70jYRM2g0
 Tc9kQ+y+DOXqSWLumj9NkjVtWBtSyt5rfnhFOPZ04wjugoHkW+SSZ2t1Iry1MEuthlnn
 BgxBkIqAST7tpwmGof7R6RZ22JzRhs6q6gZkQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Al0uQaTx
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

On Sun, 02 Aug 2026 09:35:16 +0000, Cole Munz wrote:

> As agreed on the v1 thread, the fix and the cleanups are now separate
> patches:
> 
> - patch 1 is the fix in the v1 shape
> - patch 2 makes btrfs_search_slot() release the path on error like
>   the kernel version does. That is where the btrfs_size() leak came
>   from. Suggested by Qu.
> - patch 3 is the dedup Alexey asked about. One helper shared by
>   btrfs_readdir() and btrfs_size().
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] fs: btrfs: report file sizes from readdir
      commit: 1cf825afd0d7ebb4857002833658574efbef6626
[2/3] fs: btrfs: release the path when btrfs_search_slot() fails
      commit: 1a5c8af2d4e4b4029739eb8787ce259d74977dfd
[3/3] fs: btrfs: deduplicate the inode size lookup
      commit: a11f8659f451c5601bac6fdf5b48594d347db38d
-- 
Tom


