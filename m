Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53EAC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136FB877CC;
	Sat,  2 Dec 2023 19:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJX0qy0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09C187768; Sat,  2 Dec 2023 19:32:18 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B263F8770B
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a00a9c6f1e9so485565266b.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541934; x=1702146734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnnoDopwlgWnQg9iQmgqPPqpxbeNu/kXbDLXowoLfVk=;
 b=CJX0qy0cNTzQn/Nl3RwEBmBhLINpSh20Nr3rIX74XOYgH07EG0aFzqNyhWA8Ob1veb
 CHJnH2chPNOVNb+VfrQZ+3UMmUFRkds6v7350iJOIdnChpnmPhdPtLKu51uayXq2jkHu
 Om/u4wYbQSxVPJDFwA7w6CEdEvppTT6IcIhuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541934; x=1702146734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnnoDopwlgWnQg9iQmgqPPqpxbeNu/kXbDLXowoLfVk=;
 b=lPv0raMqP48MvI+MFe3YYXlI4M0qdQf1QY+Mow2BgjPwLKYk7ZB0wq0hGA5s0L+pjf
 +HFQF8jnrSjflVmNnOS8oDtAJliJcuxWhwf2vfWy83pJznd1+Yx7WlS4BPt44nSUxfPj
 U/OOIwgEiiTy+ibhvXWcgD/7h+W/wavL9UN/ccMQzXdoEhlOaPyVEW3hAFhb3teTtp9d
 aZB5/6noAfdpbsE2Vef4Bv/ZCyg18H4NoSBmmG1hqG7dZ93IIgMQsieE2O13OoXdTihC
 bCV/wdnvM86ogc3k9F+Tc5o5JEU4R9hLTBpq2U1rEyElFkC41pp4F8i/l9XEMQBr847m
 hkaA==
X-Gm-Message-State: AOJu0YznwH5TeRMHdnMO4GzUFHPGVtk6X0fG9cVATYZHdMY1fSD8YxzD
 drzJ/dVs2ob4uaUsxFn00K/hfTrF+ichoao5KYOIMA==
X-Google-Smtp-Source: AGHT+IFhna9q5aNdl/iOfNSO0hFbuaZyYloVUC95qBwNMCl6uDb3s7umSXsmfwV37c3fwypW6/iRksCk1QfUntcbhsA=
X-Received: by 2002:a17:907:7e82:b0:a19:a19b:78ba with SMTP id
 qb2-20020a1709077e8200b00a19a19b78bamr2517457ejc.125.1701541934174; Sat, 02
 Dec 2023 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-13-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-13-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:37 -0700
Message-ID: <CAPnjgZ2uo8RvUwb7C3YEzOAKuPOacwXi70UPqoq+m5PAYdM8Wg@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] bloblist: Reduce bloblist header size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The v0.9 spec provides for a 16-byte header with fewer fields. Update
> the implementation to match this.
>
> This also adds an alignment field.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  include/bloblist.h | 26 +++++++++++++-------------
>  test/bloblist.c    |  6 +++---
>  2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Sadly this will need a later patch to deal with [1]


[1] https://github.com/FirmwareHandoff/firmware_handoff/pull/17/commits/331822f1985d70a7903f422789eab03f24355cfb
