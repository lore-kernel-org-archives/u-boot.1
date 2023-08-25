Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D15C83F04
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B91A86B1D;
	Sat, 26 Aug 2023 01:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Musy1B6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC4886AE8; Sat, 26 Aug 2023 01:53:42 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023B586479
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so2088900a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693007619; x=1693612419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqD88SIaoXVBqgqhQFNQJecnKATJB7DNz+KILduvEjA=;
 b=Musy1B6FsB/5iVd+w0c3VwRKBewrUY82AICPpIy4dnIWe85YAWqMCstpG4Xh4BOi22
 3o3EIa2xkvpslf/AI0OiM2mwIL3HVnldMvXPMmNVkajTVJGSGqrxcjvTGHom9PMDHhbG
 zisir9BoVOzrUXJ5A3B7PQT0vk/sXAqqwnpRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007619; x=1693612419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqD88SIaoXVBqgqhQFNQJecnKATJB7DNz+KILduvEjA=;
 b=L7CYNDDPOV7c3iEEDqlxUHIYlYmDTvThapch4u3YzqzLBIXvKt/FjPUz/Si8bGIIvd
 3NAgAg0DAfzD3SHEfJVnsVB+umbuD2Cm1vSdH2oEU1+g5/WAM9ooA0TmJYswJJTJpbfy
 krChqc3WcCkCJfIKli4y9jI8xOAc9u4lFjHt7xrm/0+mEWifLz4tDqeimiWvfOhrxLX4
 Y29Nk8IXoXDVMOCRdV49hl+z23QXzJXRtIWcHDvB/w9HUY3rHYGxSNtgDdeTAjVN1uB2
 ilzeRp0f2PIQGrrfTGSDT4zQIlcpNEhTgv5mkbxS4VEwXcY083hCQNkHmW1+UwGApehs
 YN3Q==
X-Gm-Message-State: AOJu0YxBZDzA0jREVv5NMeaHrDlNe6DlBtNRFQIVTX5aSmHKroGxYucB
 x6yqGQ4w0K8lal1RBUGE9RX/wG35l4Z2NhOncalfGGvOWcVdODe3WbU=
X-Google-Smtp-Source: AGHT+IE2UPG+ytHsbDRoKFjc6yzLm8xWJdyRkpVxfDGPd+U7hDZjCbpZj+kc6SakZ1Xd1jxNett3rBAjtEIzDZRw+Qc=
X-Received: by 2002:aa7:db58:0:b0:523:3631:876c with SMTP id
 n24-20020aa7db58000000b005233631876cmr14492624edt.18.1693007619513; Fri, 25
 Aug 2023 16:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-5-JPEWhacker@gmail.com>
In-Reply-To: <20230825193830.2753640-5-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 17:53:27 -0600
Message-ID: <CAPnjgZ0jDR+O90D1gMV0GMWWrkzVnzHon28Vuno68vou00mt7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] cmd: gpt: Add gpt_partition_bootable variable
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

On Fri, 25 Aug 2023 at 13:38, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds an additional variable called gpt_partition_bootable that indicates
> if the given partition is bootable or not.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 |  9 +++++++--
>  doc/usage/cmd/gpt.rst     |  3 +++
>  test/py/tests/test_gpt.py | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
