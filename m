Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB0C5AD2C
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C07160829;
	Sat,  8 Aug 2026 17:39:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5e3dE_qPmDY; Sat,  8 Aug 2026 17:39:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56725606E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210791;
	bh=5YVxbs/pgIzQnMQWlTDmPVx0OpYaEPP+LLueeoV5czU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b18FVVK/kTf9UxzIndsYRLRI3D6i+wXTuxqOpcMKPA2scfCA/bLHlWzjHgUGDJJs4
	 gNl/kABELttmItczruJYqp9LZUEmZUgO7GTGlRxt6zjwicfpdBlNoXKkogIvAOJXLu
	 /mUicafdQXmn8FXmTcHZ2TnVhlINWl22guoTq7UfpONJViHdTKxBvWpsMa2AfnVGeL
	 tqELjI7WdtWM20BM6i3LXUaDJQACL1Q2YAcrmsPNhND/OII+NTO5FYu9Xg4zvuYPtR
	 cYG7f+DrTk49vGW5TgyVkd1NH04NJGltANO5f4Hk3ATS78/ByPsPmJD/+Bcrgd6CWg
	 /xvJHY/6sUK8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56725606E3;
	Sat,  8 Aug 2026 17:39:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26107296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1809480ED5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOB5CIt1v4Pa for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:39:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3C72180ED2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C72180ED2
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C72180ED2
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:39:49 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a17c04563fso556856a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210787; cv=none;
 d=google.com; s=arc-20260327;
 b=sMCpl4iFNt62bOlZF2jGreVcolH/AGOuASezGFoLG4x2pwklQvkZB9iK8KxnyDgTaG
 2Tz6PShe9GNM3FLUec8EpURiTdoj/x3IoKOX1UlisAk1o52ffG9LE7lLiFhC9CO7sbEM
 0dT59+kC8yhz3fJ1AswT6xcM9Bel1GjKxoaqxuzIW7nkKVxSChj4LygqoP8Pj36u4Y65
 ETKT9zrqTaRM2PyszCwHI2wCuxM7gMGQVk6/aSV5jNG/rSbvVfDLe4ir9bbjvjNOFTFz
 VGLo8N0kpazha61sVUR7jywSZXJTa+ePKiTjxNCRaqIYQZFdmXPkg2SKlZ/nImlNw9mc
 uhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5YVxbs/pgIzQnMQWlTDmPVx0OpYaEPP+LLueeoV5czU=;
 fh=Bb0XlRw6V8BiiXEvBqXF9Yhj6uWiZefwuiMKsvGo8Yo=;
 b=C3UtJQkJ8zpq/SKVIYl6RoJX4AOnOJxDsbn9z2gqyEDqq2nFF15DIp7HyX/fdEWx3M
 V5QguI0idhw6adchMHTajA3v/I4IqgLGjsZzRAs8Mwe4ElAtbAwI0YHOEFkpzHjpuDwQ
 LxZy951EHo7Z9CBLls3pIB7k7ub363BZm0tbrsyzhsa8E/Ece6BWj/vqNUAZIaIWs7RW
 4/6kb2yw6pazTmj/ylSGUjlZdVkOuvsKkLnHnS35mfqFaig4NUp+G6d1+0qp60E0F7Ik
 dyESrZ4ePae/IuJPnIyXbBQb738DXMlwv1mf1oG14McuQxuB6wBXk7NB0K5D/T/QZMZF
 ezNg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210787; x=1786815587;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5YVxbs/pgIzQnMQWlTDmPVx0OpYaEPP+LLueeoV5czU=;
 b=WZCmFaf8c30lGSGhFOf04QxqzwGc36vSZDCg5eaXKILQXywoADBEHqVuvAw8/CgoBN
 BXmw3SifFtaj4ou7Iek8ggA4oLoqrzjXBPjj/iYQt5Fe5u/KT6+slMN7ksIm92R522qv
 JmDrGKskBFj+jRdPUHaaEEiug3QC6BV+kSeE00kmFJT7y8UbMoyuOEMxLxMoQyk0Itrq
 RFn8n6LRNhUrtWoxfHidg8xP/XLWD4gj5FQYbSDGHfZyVlb35u2hg4XgPUTWFd7S/km3
 rUAYa/FFj2SJnB3GlM3yF7Un3fvTJzjZluUeTg3XErsJfEhnwtIwcO54mWfxMWVpSEcD
 SjaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV339YycK4b7sm1qNBrNHpUKPISj0T++ofyI/HCxY4xOnu9jleGuhF/ZFU6gvJR+xE8WAB7ic=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxC/o3Llhj3USHafDTY2Sc04d7FHJlTgVk1BTtH7nCv9npEYVYZ
 Kb1x5/LRxC7noVbrLvqxKZy3NkhU0t2Y7hgLtpPfKPRlMIhXjR89eiwAN02Uwgp25HRl4ksEf/f
 4aCkbECyS9K5cb8CkI/eLkM0ZZHmTWgG29cg1YOsS
X-Gm-Gg: AR+sD10ftuUo6uXShBYfdwn9TREjhQyfWg4hzLTdRFk8icNV8vii5otYYtukdox9ctC
 N71ww4dzxKdBLTSH9YJPTl6/0Mil6Pi2KnLUoUYm8VXhF0v3GnUq3WBZ4lWEW1IJmb8vSvrQA43
 5iAtsLZiKqFOYk19hu6LwzqKi4JdePPe5w5uPzj3WEt8iZlfhNv63M4HYEWoiW8gsWVodkFX/Ua
 b/R7f2avyI2Qe8emrx2Cl9vesedo17UcuaABqGC9WMQNpMhJw6BDVgjHdjKxpLeHirM2wWLMgn1
 +fFEuOnSxamInKpa7xAob1FqSFk7AS7IoG5HmGmCluw=
X-Received: by 2002:a05:6402:321b:b0:6a1:faf4:eb38 with SMTP id
 4fb4d7f45d1cf-6a1faf4ef69mr2015412a12.2.1786210787295; Sat, 08 Aug 2026
 10:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-7-jonas@kwiboo.se>
In-Reply-To: <20260803190946.2259514-7-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:39:29 -0600
X-Gm-Features: AUfX_mxw-cJG7AJfa8jkWlNex7V50bVxArI4mTp9afmgk6iZnrZ7BwcDBOntNGU
Message-ID: <CAFLszTgbOQNzDvBtQQvYEqsXuNxKhwWQU=kUJnY4kFnRsxwcEQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210787; x=1786815587;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5YVxbs/pgIzQnMQWlTDmPVx0OpYaEPP+LLueeoV5czU=;
 b=oUeiWgVsinExQaJ5ZaR/rwUT4cTwTSk/ND+4DwWbEGz7/sq6pDdQ+mnsb3N4m3HQMF
 W175yPWc31G0EenN3wBTPVETVlBZ3on8cLLinMJQH7bmcuNjdSlvVgUEvORmFRwB53Rv
 +9bnh94gKWkaLPu1LefpWpbBcMbStrEi/UUHA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oUeiWgVs
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

On 2026-08-03T19:09:38, Jonas Karlman <jonas@kwiboo.se> wrote:
> rockchip: rk3506: Use FIELD_PREP_WM16 macro
>
> Change to use writel() together with the FIELD_PREP_WM16() macro instead
> of using the rk_clrreg() macro or custom write-enable bit handling.
>
> No change in behavior is expected due to this code style change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> arch/arm/mach-rockchip/rk3506/rk3506.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
