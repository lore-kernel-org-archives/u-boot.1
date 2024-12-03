Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A56E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A558958B;
	Tue,  3 Dec 2024 01:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CdyKUmej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D1188A0A; Tue,  3 Dec 2024 01:20:27 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A439E8953B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0bdeb0419so3872424a12.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185225; x=1733790025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=77lDfkVfo4kJjoL6MsAUXaQTK2sR+PJf7QJ62Gk9dUk=;
 b=CdyKUmejaeDrruAOk2mdk/+IRL6bKxjsw0/ezQnjIBjEeLfmLXW+042JlYlb8Sbz0N
 76j9wokpO54Y+ZFxo4sQL3PoG3B6yRZCag+t1RN5vvAsm3m+PA6hfdD7PmQT/0MdKZVu
 ZyNOv5tXv1jLd9Y2PjlRYwZxkoo0TJljwfKU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185225; x=1733790025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77lDfkVfo4kJjoL6MsAUXaQTK2sR+PJf7QJ62Gk9dUk=;
 b=nHxA7cIOd0SEqcibHvaYrGCTLdQwM0+zt5N3SGNuMWaEL+C1FgCvOSRmo2qWeZNSxT
 URAYPn4iXLGcaO+uU6RrFEzyoFBuZ+U64e63P1Dku6Ug+FcGxsYHH+9pSdaMHLDDD9nO
 wG3x9+YX0pugCtMzWL9M/QFsLyEs6iy5SV/5JpPfK5wWDKPs1EDawVOO0W3nc0PoYh2c
 vD/XpD3Q1yyt7lTq43saV33tf+3MKitRNA26QbpPlVQqhRCpLNsvy4t30HDkQ5K6kioO
 8WzWDUSfb6k03hF49keXEIYTElXKs+EJfY2e/TtiegK2vmQsLHMnDTxmCEfSzQTpALb2
 IvKg==
X-Gm-Message-State: AOJu0YyGAoRkgSgC6nVf6SkQ6nxw7+KR/xQ2G9/+eEEMZ/wc1q1tXD/U
 vWIoBJC4VJ8B8NIjfQubOdmrNEYyhZ9Yr6BC0w61HzYY+9FPP1IChU//AHvUfr2kXPsUCaEKuWV
 9JvUKadx/WTrSbhAX2fPmbgLT5DKro4tf2u3e
X-Gm-Gg: ASbGncsLlvGgrI5rNbLanwcNxZeHnxNuGvwFgcsq/QyoVGD/k/TbBDVBA7QpS7rrvm6
 X6yOng4eyhDftZ8il+8hT6ih4+0ORMbJE
X-Google-Smtp-Source: AGHT+IGWQ0jnWO0ntayV87dBLemewpRzLsFrmmJgJ1p4llOwSsLmbajp/S+EDDytiev/U5SgN+7vwSZxHNdhCl0MlPc=
X-Received: by 2002:a17:906:1baa:b0:aa5:427e:6af4 with SMTP id
 a640c23a62f3a-aa5f7f0affamr16870066b.47.1733185225153; Mon, 02 Dec 2024
 16:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-2-sjg@chromium.org>
 <20241201164017.GS3600562@bill-the-cat>
In-Reply-To: <20241201164017.GS3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:20:12 -0700
Message-ID: <CAFLszTj=8ux3kjM-gCa+MZrOja-Qh+VLYoB0VKRy3gabv5pqmQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] CI: Drop extra condition for sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
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

Hi Tom,

On Sun, 1 Dec 2024 at 09:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 07:42:29AM -0700, Simon Glass wrote:
>
> > The rules part of the template makes sure that this doesn't run until
> > specifically requested. Drop the check in the script itself, so it is
> > possible to trigger a run manually without re-pushing the tree.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> You don't need to re-push, you can just manually re-run the pipeline and
> set the variable to 1 on the webpage.

OK, well I don't want to have to do that :-)

Are you wanting me to change the commit message?

Regards,
Simon
