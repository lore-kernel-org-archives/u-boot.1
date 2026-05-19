Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416A8CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 21:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742798483C;
	Tue, 19 May 2026 23:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K3UqJ6/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B959884841; Tue, 19 May 2026 23:09:26 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74AA284717
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 23:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso7348604a12.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 14:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779224963; cv=none;
 d=google.com; s=arc-20240605;
 b=C10i9ScxQ2Jw1qsIkq73ILAp3I2qLqCTOcHfOK+M00MbTxuGnyywuXrRxEdcQEnsB8
 NF5IVlW04RVTI+g9tzUVxPCzgtKLdQdnrtB3H7wkU8U/PC9QUAAyPPE3MmypPelc4ItB
 N1Q5DaRunaRug63d4Od3fmrHHOBA0oqWnBSPtGT8XSqJJnLqZtPvL18hQIIc3sR6CC3R
 hb2bbU11c/1V9K933YcZcgibPLhy+kKuV4GjAZpj83TJR0fOYG8XDnD98/0s4Q4LAewA
 Io42+NxpFIxbLxJQMWUC9x2yXvQ7+Lg4Ig6l0loF+Aaf6GwLNNRiJEEbkCUuugzKmBxE
 CMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i4hKVC5C9pboh5Ey7pvapg8tOkzVtMZuwTjI7rHnSI8=;
 fh=Iu3q8pU/HxKUxgIX3o2NhCmX5QQC75oOn2rrUk5yUdU=;
 b=MGf7pXHM3dh4Fv77/3SyY4MxQGZ+/4C/V72WckJfwDdi+wM8GHW4dVNWUGVTTV19Yw
 6V9NBSxU0z6qvMq1Tkv7Ipv1bX20T9bSySuNFIU9kuqjpUs+zqb+Me6oHQnC2r+o6JZM
 W+UEGrBt/wa7lOKaTy7ZuxdyDa3EKNObXGSNhqj63qSp7CpG0RRmycr+cYVxZw/LHhnM
 AAzYk9o0lwUj7cSsJcKd1TyTeqcNRketO9sDl2e/EL0xNtB6EfaYBu0ucaPEblPbuBN2
 jGHRNor+8CZDatVHbCOUehivIEtWuse6rqyIOBYVs4tQ5qSJLZfHsk1RAtevBwUULjr7
 ZeGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779224963; x=1779829763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i4hKVC5C9pboh5Ey7pvapg8tOkzVtMZuwTjI7rHnSI8=;
 b=K3UqJ6/CPkkHHamzzN3i8NRGzdsMObyuutryv6KluYQobwr+PVRitMzzzr5p1yMdL8
 2cRfu0HT46Psq9BrR95b1+Hz94WqH6BEVVradVVCmmeh8OeQTl3/3Ogt/AKqALz7PI6R
 YOQH0fymUJyHieEDhUMH6Oqe0xgmMWkhsc4aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779224963; x=1779829763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4hKVC5C9pboh5Ey7pvapg8tOkzVtMZuwTjI7rHnSI8=;
 b=S8dhkvQh/t1BsHNr8iH02m7Gx7X7/+V3b4B8ma+D4nnNw/6+8JVpY1sVp+znV2ODMc
 tlalfBVX+Llgd+IiVmjDvw27FBoyrmnkOmOfRRQGOiUttZimezthDVoImQVdiMz5AjXN
 Ir1tIe9ZoMY9wiIEJPwUFkgk3TmcyENEhl1WvUsOCTF94UdyP6nwDZcKhrUc+3Or2yQy
 IBG3PowJ8MMKyPR86GLg/sMWgzVtsJKxKIH++ycqF05ocsXJ8IHAxtzaOXVW/JKCVoe4
 Z+ppyV68HE8TPTgOGfiA52Bbrk6ZkKBFf0iRtNbepFXN4nMTDcgXc4voHDqT13cwblE0
 6vYA==
X-Gm-Message-State: AOJu0YwXyLytPAhbgD90vxzUwPP22BYaWW8fU6EiTw8yztKt3oFWVuiD
 dh+g3JwwEbAFClK/p+hZiVgigjiuIuN4bOb3PMnFjMXCwjFXMP3JoloPFJI//ltlWMNzifI5inM
 YZWgc57eEu+ZV6F1hF7wD7xuvsvBpessYuplJ3goMfWQQgkcitwHpsfBtByY=
X-Gm-Gg: Acq92OEQMwMwOuOhICkNzu3nNhug8ec3rY3jFoX4Jpc3oXet/SGtneQnvgDw4LuJlGm
 axjGAuZDA2FbEh62o8RoDSpZYirDS7YyP0GZStB9ZHTaQTSqTH3Cu57NfQ8eKdRZcbPjXdWTTmO
 pNpHQQcRJRtIfdolrOkahJ1VG8kTsHG/83MLPG14VjCIZ2crHXyM1L41x/McKNLUyHICn7WM7O7
 WWcaDH2vRLsErETCHk67vKP9lEns9K01zpvOJC6HhokD6sxlYTx3zEwCvFMenKKqhGfKQsB3tVR
 w8Q8bg==
X-Received: by 2002:a17:907:e11a:b0:bda:25eb:1893 with SMTP id
 a640c23a62f3a-bda25eb1911mr93081566b.20.1779224963202; Tue, 19 May 2026
 14:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 15:09:10 -0600
X-Gm-Features: AVHnY4L1FrCN2yT-4sdwFbyTp2z4ED0-f_0RwjbE8eyazIh4ilzxbWuTpQHGHWI
Message-ID: <CAFLszTha7OL9bWrQoyy6a8hKM+n+0rNuyDRJLawKE=NMa_cRWg@mail.gmail.com>
Subject: Re: [0/9] fs: add change date to ls output
To: heinrich.schuchardt@canonical.com
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> * Add the change date to the output on FAT and ext2/3/4.

> The ls command currently only displays the size and name of files and
> directories.

Thanks for working on this.

This is a user-visible change to ls output and may break scripts that
parse the existing format. Please mention that in the cover letter,
and consider whether the date column should be opt-in via Kconfig (or
call out that you considered it and decided against). A short note in
the docs would also help - there is no doc/usage/cmd/ls.rst today, but
this is a good time to start one :-)

Regards,
Simon
