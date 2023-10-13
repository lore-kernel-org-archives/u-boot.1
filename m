Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D04CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20AC8653E;
	Fri, 13 Oct 2023 18:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W+WSqmYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95E186EFD; Fri, 13 Oct 2023 18:57:54 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8750D86B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso4344563a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216268; x=1697821068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xS2L5vGu/lhs1DvJ3q12PVTvCFinwWvup6X14JpYHVY=;
 b=W+WSqmYkGpvij+aicfmoxFOnGAkM4KlzxF/+2jKG7av1p4+ZtfjagdgK9tjGBMUGVf
 nyvDnJCYfH9o2COBclPHQmZZtidcgRice0uPbCDy6nN60FRIW4WVEEjFrLRNh6qbj6tf
 5eQJtFq8Oj/5ClJX48yMlNhOrtW+7/eQJuHAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216268; x=1697821068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xS2L5vGu/lhs1DvJ3q12PVTvCFinwWvup6X14JpYHVY=;
 b=ucCqztl1HxTD9k6lkUy9GTGCWpqZggj7Ev6qWZ63C7D3sPRliaTiovnMQU4S75bxLg
 TLuRrOuaZesc14v1Jso3IWoSask+Zkj8A+ep4xpCAIJodmfdiiVY//B4WtAzN8xN99TF
 tHT71DwRFFJ3Mq+GsUOOFuEEWUUtXc4luOWvdaGq3ZUp+YD1ZwRCxSnwKTLYimJg7QVC
 9HhC7nkUrNw61z+T9qzpMK+/1sfG6ZJ7OdFgWe06urAEi+qyuSmXDWyPAKP5+dPX4bnj
 i9bWIGO7s/xMy3mfEL6sE1COd+nYL6t7AdZz8EdJahdfegOAgHphLRbsKpK/YB1vKS6+
 lRTw==
X-Gm-Message-State: AOJu0YyvKPE3/Zg+WADu0+xcCzXNJU4iuXl05hyDPzUbobrBG8wz8Fyh
 mJMbDPbQVIDXCTF67401tVkQG4a65sj6MxTPgO6B+Q==
X-Google-Smtp-Source: AGHT+IHTZrpKXrgEIPVQ0T0CGohsB10O1EWxDusVyrY4hqp/2q/kfiyKP2hSb8KfeOHK7nYkb9K+BvImFKORtWuia/0=
X-Received: by 2002:a05:6402:2694:b0:53e:6624:5aeb with SMTP id
 w20-20020a056402269400b0053e66245aebmr279034edd.11.1697216267950; Fri, 13 Oct
 2023 09:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231013011924.23877-1-maxim.cournoyer@gmail.com>
 <20231013030633.7191-1-maxim.cournoyer@gmail.com>
In-Reply-To: <20231013030633.7191-1-maxim.cournoyer@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:30 -0700
Message-ID: <CAPnjgZ1U-EYeSbhQ_HEM0do8RhPBW_XgLUewXUTtWxnkOCjcAg@mail.gmail.com>
Subject: Re: [PATCH v2] patman: Add a 'keep_change_id' setting
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc: u-boot@lists.denx.de
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

On Thu, 12 Oct 2023 at 20:06, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> A Change-Id can be useful for traceability purposes, and some projects
> may wish to have them preserved.  This change makes it configurable
> via a new 'keep_change_id' setting.
>
> Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
> ---
>
> Changes in v2:
> - Add missing argument to send parser
> - Correctly propagate args.keep_change_id
>
>  tools/patman/__main__.py        |  2 ++
>  tools/patman/control.py         | 12 +++++++++---
>  tools/patman/patchstream.py     | 17 ++++++++++++-----
>  tools/patman/patman.rst         | 11 ++++++-----
>  tools/patman/test_checkpatch.py | 16 ++++++++++++++++
>  5 files changed, 45 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
