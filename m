Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1FEC5DF69
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3A16403D3;
	Fri, 14 Aug 2026 13:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkWXeEIcZm2z; Fri, 14 Aug 2026 13:51:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1C9340D54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715487;
	bh=g7JtJtrOCIBohiDhtqhyspaSQ7sTLnxXHBRqBG/Wf3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwYXuREdJb31OobZkRmg5+YOKHAcowx95dex++lfdxJQwNu4ZNM37aK3SMgy4BP0o
	 8CsWNULat/KmrPG1PBHCKDYZyDZkXSkB/RrSufrPO2eOBKxVn/UNCulqyo0HxhKG84
	 fz9PLLFnDbfLH76TERqueXhjFOL92db9MUf5FrKqlTKwMs3rfUmph7YQ5gPXEVjLnz
	 MAi5lttuO8oiQecuMYsU6csyfHHSuQUBqyqRD8UXe+JX0JecvJn+84wGWSn3dmr58i
	 fEP9XQPEHlLsr/UxPPQS4uUp5WcID9ADjXeGeEU4SwzuZPOf1H2cMnb1sOOPGIb4bj
	 5e/KZ8G3pNwDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C9340D54;
	Fri, 14 Aug 2026 13:51:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C190B33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A790D81373
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dn6zE8fyrkki for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 03751811F1
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03751811F1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Ct8mFzJh
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03751811F1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f18c0e03e3so511387a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715475; x=1787320275;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g7JtJtrOCIBohiDhtqhyspaSQ7sTLnxXHBRqBG/Wf3U=;
 b=Ct8mFzJhUpI6SGAS/MbLF+dwTElqgtA1Vac6DCE02g+qSyA39cMgP3YaSycvjsTRZS
 MHLYEoprcsc2F0BvI750ZewPFO590IKzdt1mfPLFmSJsvwEUTGGpvEGig34DXOFf+UBP
 2jChVEzDFlS9uFAjLKSqY3RskNq878eJ0FBFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715475; x=1787320275;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g7JtJtrOCIBohiDhtqhyspaSQ7sTLnxXHBRqBG/Wf3U=;
 b=bkWrM/vdQaV7xeIVRC6oeDILfqa6aRBtFtHIcnuDr8Jdt/Uag364GDBNuywhAP0hxY
 W+cTTPevc6xFrwGKzkQzhyH6k6hMi5XEiY3pffi/w2DJ/bwIqYBUz9500Vd+Bh/onL8V
 bC83YVlHaha2iW4sUmKiZ6Fn3GJ8chsWBRePDG+9Ap7h95Y/0UT61K+Md8JK4V5XL7xq
 pxajzuECJKuYDp4fpp74fpcW48YMXKp2OTv7nZFaK75Fg4XkzoP5Qwqk6HEN0GmsQG0g
 wNFkJb2WeJFG+0o6N9Q/Ukr35FPMeSh6b3kpJhHr0XKoqs+Vd9SRU5MHj43Ifn7zgTR0
 VoVQ==
X-Gm-Message-State: AOJu0YyTSAYDpRnCicbXdj3DhfOlypDLElkPp0dtGwUO1wqP0BAuWTnM
 GI+UkSoBH2VIsnKPV8SSt3J/va8V5ilBXhqTYKX9OIG8X5xPswxZWI5AhFn0znyigiQMdAMqsZT
 87oyzlfs=
X-Gm-Gg: AR+sD13OdjovROAs64gGUqdfX8lBKzx73YxsCuPNO0gKdGfyvhBKj10XdBpsXfUXEeU
 DZQik+YNbsS7aXJb9aARNIJ1fL7iDhZCn1YDwkm7Fg8utmXwyYBFJD9fzQINv3r6EqO92tJo+VB
 Dp1LnebtQJtn6QM0Jxlv+Oy82of9VW85KW5gZ2RfdxuNnzBLGrSv36loJZWZpINZ+N62vOXCvyx
 oy8Bl/9eP/AzHQmBht4ylkpRQMi2YF1wxK0f+/ejS30FMvKclZ1j8RDvh+HQCIYx34qYJplXgCa
 OI6itO1IOUNiNJqL2LRMYO97UkxNbPmEHULxeR896f2c1QwjsQvSkDPEa43Ugz5P1p9IMjg99OB
 4s/aUlxd7+Pv9Oj2X9rnlGG0ONVwaNno9lMIUFm4vm3Zs8HzxluN/FDJxRfWkWeY6bddQ/sgm42
 ZhX84EV+AcdL56+duKEsEV0O89Ukdol7FixTK+/HFit1VLcWnmmmeCq02su5NGSy3hq4uSqYUoO
 lIlU3OExW6B81B6k+25GEt115ElBgKLNgK+jalvy7k7Eqyid2Epyi044pgc11uuxaVf9pM3bp7c
 tV4aotjG
X-Received: by 2002:a05:6830:6d4d:b0:7e6:ee1f:96f1 with SMTP id
 46e09a7af769-7f3de5ce42dmr5186656a34.5.1786715474858; 
 Fri, 14 Aug 2026 06:51:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Cc: sjg@chromium.org, dmukhin@ford.com
In-Reply-To: <20260809183643.4163840-3-dmukhin@ford.com>
References: <20260809183643.4163840-3-dmukhin@ford.com>
Subject: Re: [PATCH v2] pytest: fix out of bounds access to bad_pattern_ids
Message-Id: <178671547424.3828101.12613405549620459987.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:14 -0600
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, 09 Aug 2026 11:36:45 -0700, Denis Mukhin via U-Boot wrote:

> With 'pattern_lab_mode' at index 1, every bad-pattern index is off by
> one, so the wrong id is reported and a match on the final bad pattern
> indexes past the end of 'bad_pattern_ids'.
> 
> Ensure out of bound access to 'bad_pattern_ids' is handled correctly
> while processing test console output.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] pytest: fix out of bounds access to bad_pattern_ids
      commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
-- 
Tom


