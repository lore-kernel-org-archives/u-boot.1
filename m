Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01847C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104C28353F;
	Sat, 24 May 2025 07:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nw6p071S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D6483303; Sat, 24 May 2025 07:05:56 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF0B83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7884so1021821a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063154; x=1748667954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CNQkyJgBtG7PgSjZipxgUlAhc8M0oAu05eT1kehvteo=;
 b=nw6p071SFzpi2Uoj8CDrGga1zNM2SXBwxuAglkjpyGQ+V/sX7vVjasgHLCm7aAQHBo
 c8FhsoD9p1NdmAuAELJuNdFR1L5cvxqMMew44ZJgbi4wY3PP2kJDZwebAHkRC3vUBues
 T013zrNvRL8jGEKrMqAddGnuThgjUNpPvhIcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063154; x=1748667954;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNQkyJgBtG7PgSjZipxgUlAhc8M0oAu05eT1kehvteo=;
 b=f2FM2VWBgo0y8pjBazx77CxtUc3ftZZTP8UaZRQVN/T/i2suzskpjDIX2t8u5dc2mZ
 hR6TVMM2q5Z3VMW1u4lXOfjMjWwWaQnIaAP7SEdoLwjMmbAfL9nMl7+yw55m9wFcbxvp
 NKe/X113hHqBUBfGtd6+IHveGhCj0VxGMPopEHCTEfDy5qqvplsAvDCPgFwO+21wYjXQ
 hsrbSEo40Jym/xfGrpIcUSuTlU9QNvxQ9XqM4PyQ8rEw+e2tpPY/p/98cnWGYRjHNBgC
 RbiFS7gFVP5CWbZjWF5FCVdNekHU7itPsBS8NNFYEpheNm3U8zse6J1AqZ2p+D8QpVun
 DPOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKe35BNeGM6xhIcuftICOuZNRHtjyJwDxC+L57NvtskFyf+npqB5iJxsvNVkYkrB69ym/6uiM=@lists.denx.de
X-Gm-Message-State: AOJu0YyuiKirySNVwh1+ymiVniJm9BVEtyS4HLgxenKdLDjg7GCiHDun
 VQsp72uKVjytYLdD+OXGXh7572w5rdAfnvDK6xIIUpzPHY+1UfdB7lTvJfCOVSv5TRiDOTfl2tx
 SCUq0zEiWj6EbaEdRw3p5mnlSUnDX2f+GybLH8Ggs
X-Gm-Gg: ASbGnctz2eh/hqrFTaQDP0pFsCP4c02ZMAypOyec3znpc51zDqs1NDjdII598IIjl6I
 xYDwzx4LqONg2R4sZwSa7tEuOqqzYLneCUSMw2YguBBT4J1KKhKFxjV5TXr23nAve136LUNwL4L
 p2/SISm/HgZ5ZCSd+0qVFg3BVIWVuRzW9T98arqgoRFQ==
X-Google-Smtp-Source: AGHT+IHBjgIhJRpUemCdDtaCBsmab+0a4Hf6N7N9nHLAwc/JoDdJlxvEFlViSz097HT4lU87W7zbpoxAyf55jzOvjds=
X-Received: by 2002:a17:907:3e17:b0:ace:bead:5ee6 with SMTP id
 a640c23a62f3a-ad85b20ad21mr115464166b.37.1748063154088; Fri, 23 May 2025
 22:05:54 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:51 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:51 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-20-sjg@chromium.org>
References: <20250510110535.1453745-20-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:51 -0500
X-Google-Sender-Auth: uGfQAnoAU6SNiogOtFBh_LB1UtM
X-Gm-Features: AX0GCFt1qZ1MRmF8lNRstVsRLr_vCwKuybw7XDEU9AsjZn7jgDsoG_zDXlfL49E
Message-ID: <CAFLszTgvf9kRm711sdijcM1uO1cyOOZqfuCYhW8=PzfmJ-Wi-g@mail.gmail.com>
Subject: Re: [PATCH 19/25] patman: Implement the patchwork subcommand
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add a command to allow setting and getting the patchwork project. This
is needed so that patman can use the correct ID when talking to the
patchwork server.

To support testing, allow passing in the test database, patchwork
object and Cseries object. Fake versions can then easily be provided for
certain test cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 25 +++++++++++++++++++++++++
 tools/patman/control.py | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

Applied to sjg/master, thanks!
