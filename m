Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C0BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC56887753;
	Sat,  2 Dec 2023 19:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mIQRLuqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717C3875FC; Sat,  2 Dec 2023 19:28:31 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEB0876F8
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d7084b6bb1so10025997b3.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541707; x=1702146507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kVcDG3GyYak9lQO/bpWWkQMIYWzqufPmCUirzc6rMvk=;
 b=mIQRLuqKxvy6tQH5+NXkfoivEtoi8yN9Iytm/hr+v2aqwrtlxTzUgIvdWESAH4tVa4
 7liwSSQsNnYEnI0he2IhBnEbaDWXFuLM/nHmoyNMaZMJupMfNxEii44XyoIwHYVDK3NP
 4Dm2lFkZ64qxUe/cxfQ2iewT6YxcWi4j07ceE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541707; x=1702146507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kVcDG3GyYak9lQO/bpWWkQMIYWzqufPmCUirzc6rMvk=;
 b=lBGa6pGTKjSBsy4tHQfvJmQbY7b5ffLMAQvhbt6nTxPhMHA86qO2suc8K2NhcRrJvv
 rzQGxv6oIB3xWCPyM8bFepcBl+tjNW07jPRj1DJYsl3QS7hKeoRlLWj4NK0NA9serxC5
 0zFh7+/VklHjOpyZN8kyI+qgZdSArJv78CP49sdVplqzT6lkWCyDFUXofem84rFp5J5A
 8AdUj1BKAKtWAMINQbOD4VsCe5BnoS2y95cu0c2IVqlkwALgbCPsVBya7HL97iH1Y+ap
 dN3yYfiQ/Btc3Al5sgOIG05AhNveYak1tZ86tlcEaPos8PcxSu5wwotTrWYRySnJEHhx
 WYHA==
X-Gm-Message-State: AOJu0YyRIFrBgp1EFUKvYH1oG2sL1NwZ0e4m7NIx5DWq17zg9DGPM0dN
 pDyUsqQuocXXijff/2ytVOjKxFFf4t0pNwD6wJUuMTY2QRafrNaoVx3hMA==
X-Google-Smtp-Source: AGHT+IF56dM7+A36AMcsYEMjTGVci/FwS96+oJNBxHmqMS7+J7X2ULUEKa3kZTI2punWPZlKKWotrdfmphQ+eS0436w=
X-Received: by 2002:a81:99d4:0:b0:5d7:1940:f3f1 with SMTP id
 q203-20020a8199d4000000b005d71940f3f1mr1153961ywg.89.1701541707477; Sat, 02
 Dec 2023 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
 <20231117225313.2144665-4-trini@konsulko.com>
 <CAPnjgZ2N__uy8qdhJfwzrk088dyG8fFGXbsh4-Z4yWa6rkDFNA@mail.gmail.com>
 <20231118174550.GI170968@bill-the-cat>
 <CAPnjgZ2vYJbk_pU9DgnQTfr_DavFM970v4PfWdEpUtjEx441cw@mail.gmail.com>
 <20231118184412.GK170968@bill-the-cat>
In-Reply-To: <20231118184412.GK170968@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:16 -0700
Message-ID: <CAPnjgZ0=ouh74OOKkho0pJJt0PysKMv9-escHimaHWXPd-H+9w@mail.gmail.com>
Subject: Re: [PATCH 4/5] sandbox: Audit config.h and common.h usage
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Sat, 18 Nov 2023 at 11:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 18, 2023 at 10:58:50AM -0700, Simon Glass wrote:
>
> [snip]
> > I found these:
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=262148&state=*
> > http://patchwork.ozlabs.org/project/uboot/patch/20210925121958.26001-1-pali@kernel.org/
> >
> > IMO the second one from Pali makes sense, but it was never followed
> > up. It doesn't look too difficult.
> >
> > We should have a policy that if people complain about a patch but
> > don't follow up, we apply the patch we have.
>
> I think the patch from Pali was the right direction, but as I noted, I
> wanted to see it implemented for some other UARTs as well, and it wasn't
> high on anyone elses priority list. Covering ns16550-style UARTs too
> would be good.

https://source.denx.de/u-boot/u-boot/-/issues/28

Regards,
Simon
