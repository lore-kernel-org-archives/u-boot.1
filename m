Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB288CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7094D86E8B;
	Thu, 12 Oct 2023 17:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VYLsbS0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F3A86EB5; Thu, 12 Oct 2023 17:30:53 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA6986EA2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so177055566b.2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bo4y24mvCVxAdWWZB3Y+X3ZLRb8B6vDzfEOzGggAkYc=;
 b=VYLsbS0+szVd/GWV7/EIDoN1x5+Zax6lVkilHWE9dQvwBXwbwrfgMX3HV8bTE02r+/
 BIE/yCC62EpXRN9jiJlC8fWRVO2/4hK+PVrDqBZtWaXm1agfjuxJd46GfBmk4xJaa2ex
 qtjwlxyx6EV/JTQmM35i7jLodrzwEu52X6IMF1cUNWvbUbvCJE43UuiundMl5Ysd0e6C
 R4L7jOBfcGrDj+cjX4VqaZHxZEXDLTK/vVFDwNy0otxnUn0OuDaBXbtUQraJmr2gl/JB
 tqOChd/ovv988mhK5jKWvymP9dHoJKuQlfbjJiyE3b/SfNRTK/l0OIl5rKroqGQBdnCQ
 EfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo4y24mvCVxAdWWZB3Y+X3ZLRb8B6vDzfEOzGggAkYc=;
 b=mUc4ax0+IHCMFvoR83A56UBTMlFDDygT5AAkWx8/skDF4o4+7SVcGR9eE2IjYNqqAO
 FVS/GeYLbj7ev65pSrFRGQ1gTOHAd05GeINjDn99I1xkGkVBs08WInYG8KYLBmFVlMnT
 J99ONJPy56Xk8mgCE9TkCrQ/IZ9nBwZUmLb4JHiFBoLFrfDKKjuWO3rhvz/FgiV6GhI3
 rb61fRU76qsWo0ALX75du/6Sp3K3oXPkvp9jTIhvRENtNzMa/w9VQFzWjLW6aIer5oIM
 M1MueDD5+5+3PRe8ELFdntHBiKrapgLsDnOjLO/3OR6K1wPDex5GlH+gpOU2NSgwuGIO
 LSPw==
X-Gm-Message-State: AOJu0Yyhcn4/qi1IJSrS3+Jr65+3s/Yl2pC88ciUchzTHrOvygxgqpd/
 +zAQcVJySfqCrYS9/vf6B8Fz4KkR+QW65TG75MvpsURCuZDacABP9Tk=
X-Google-Smtp-Source: AGHT+IHsc6QTaXOefMU7Zk9bpkEH6NtrpS/Dg9TsHhlZsicCJiQVIAXUsMgFszggxV9X2k0SSxEcWQOsqF1f46Ro/4A=
X-Received: by 2002:a17:907:7809:b0:9ae:5be8:ff90 with SMTP id
 la9-20020a170907780900b009ae5be8ff90mr19980638ejc.68.1697124553314; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-5-randolph@andestech.com>
In-Reply-To: <20231012063509.2963258-5-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 12 Oct 2023 08:28:58 -0700
Message-ID: <CAPnjgZ1_YX8NAjsjh8mx_r7fwG1Oy6QZq46Cki86QbZgs1UDkQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] Makefile: delete file *.itb when make clean
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

On Wed, 11 Oct 2023 at 23:44, Randolph <randolph@andestech.com> wrote:
>
> Delete the output file *.itb
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
