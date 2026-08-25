Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D1DC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A37C6405CC;
	Tue, 25 Aug 2026 12:53:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxHtWRgkJLwt; Tue, 25 Aug 2026 12:53:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787662414;
	bh=n/EIaod8WmiYW34DYvNkHGc+KZnkDzHaxe/886NcYf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MyMYlIU9lbxRPcR4DUxMME4FGIomGzNDqmo+Pa4hiuauNwUktHNwQWUzqs6ntNvWu
	 wJrrogNBsEjPb/7LdgMUgbY0x17PKFzjIxCYHYUn6HbtxBmQQK79afybEdEBITf33R
	 xw3AiEnf5WsS0n6NFzFcnhFrypY/cHB4Frn3b1JNt8XPKTpM92wcuCGa+P8Q8/0Lvd
	 o6j9hAzRLA/prOwm61OaJB+PExxTUc4UpYVIYHJIeVpzT6BSs/C9t0B1/Wa3J9URqI
	 k2YuTYti2iQgvQpski5g3cstpSeuunZPrWCpDPFeRA01XYx3em5AjFngpsTBjyqwGM
	 rgNdkaC8v3Stg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B264540592;
	Tue, 25 Aug 2026 12:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70E03118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62D1B606B8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKfAuPbTNAWv for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:53:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GPSBEd/j
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E09460606
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:53:31 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso8287002a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662410; cv=none;
 d=google.com; s=arc-20260327;
 b=BfLmmiNkFVPn97eDodx93ZLzS/05ll/sb6wEQjCtC9VN1tt5/lMyL+bfhI1QmAtfrs
 g0THfln9y09q5GoMEXtvAsBf11UBwTtZ1p5m7fhoWBYzMjq1lLKVzwpr8HTpfvOnvdWN
 CuKS6on4pC/FK2BL/1ojMfXqtqVDqpH6ehC2rf0UHBD/jzw+2/l+O2DQbjWOMPTv76rh
 C5Rgu0wrw/y00CkbBdrRF0cXIsoNoxsFbRLILGrwS+bGU4e3bajw6hw8sJQEw05sBCi+
 GF91BL91coHX5RrHVCfSdqg+7td+eXLXkRobKLbsZqb4UNk3oA5rpIysjRsU2tGhKn2z
 qFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n/EIaod8WmiYW34DYvNkHGc+KZnkDzHaxe/886NcYf0=;
 fh=MEog5Fwspqb+EAHauNEE6tSEOa7ozt6oYot3O+UhV3Q=;
 b=CjNku4AJxIIvwXEPR3/7sutrTZ/6OJexC8NiDxwlzB6BTfwltjaXKrN0zTRZA8PcPd
 VElUCYVMni9YKuHC+F+jaByjNadyN0069GDfuo/N2Vx9nv9kr/v7OrP0D6nsNj3WvO7Z
 KbatN3IgQboykHXP5Dlw1+Vc0JFgDN7ZUa2fTSRxOAY5zG84zjvSx8d6hnpG9OP6+XPs
 gdnor7/vl+UToAppeKoyJNdD5rFP0GuTQ856z53a5P09gdmYcJE0ifcoaQLc/KBUx0Bh
 ScKVbD4yT9kY/YsB5Dmn1FMSAEKy7gUcv6Tsc6IyvIFdY4BJ0SXU8ImIeGBVvpxwSkQm
 2TbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787662410; x=1788267210;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n/EIaod8WmiYW34DYvNkHGc+KZnkDzHaxe/886NcYf0=;
 b=GPSBEd/jjWVbWX5oQKdDcWkj4gG4v3ZLv/zyGadTZNf6qUsrYVzYlPDogDgFkBSnm+
 BzU2NS2q/dc4yce2ZVrVXX8lQD+ZKQaajW9Vmfp0hKd7RHZ2kin1QB/66HvxWIkw/P00
 jdhbQS/It4bRHsAFGt7NYfNGndtatGj1FIjgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787662410; x=1788267210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n/EIaod8WmiYW34DYvNkHGc+KZnkDzHaxe/886NcYf0=;
 b=GhUOcUIEQ1/g6O/c6CKaCcAcj/aKPELTP1q1FfuhmupPwRHsOm2Z5srNMrU3JRBUwm
 wXlh0CvORkCWS4ucuFqmCtdmEAgYYLmUl9mU6KWijpMYYdUWKAcrhm7LJO5GrDR6Kppj
 eG9RlSPDTG2X6RbdhGlYZsdaWS1wb/BX1G3kBIla4FIYpLGj3ZjjGm8zg7Lk+wQh1Bau
 xioAmZaUAh77+DfJIuAPZlLUbWG4kdMm63lYkG7lUHECLiPzSWmE/qXz+c7bYQH1n9u5
 lN9W+/pkAa1hZlWXju4Dkc+ZO92CILF2917G2xXtz8qx9aDP+8eajhBLaj0N0++uL7Ow
 30/Q==
X-Gm-Message-State: AFuF++mpA9OQPVNPn09ph0RSIgCJ8NZAevuBhvikOreCKtCli+mHiXco
 fyppoEJZM8AsS6Kd2Jpc5aqEJzkw/VNz+LcYYMhO3/UsBUHKRtJKjqW4OqKJkAPqevE0HCPH1S5
 hMPeSOpCafKsiCA1NIFWgzE9ShpPtxANX9T6KRtYW
X-Gm-Gg: AR+sD12zuD+b869aVcjQMWdHhQ4tElukL3j/VudoAzr/8K0O98hEFiAtQfbflesAjfD
 vLWOV45sq5qyoz59CXlsO9fjNeFGOXTPVc7Gv0R8UdZlCQEUnB+wlyiSp3jBdYG3LOKyHAyq7Z2
 meifrxW7xoyzJBd1lPuhGyVX/yLS9lKxm7lWdK0il9A61tJgbpCkRh7lUiDGDZ98JBdG/ZWPKzm
 Id6OLzUJ7qYd86hRDC/ramt0M5eS6uj69/5Lw/wJ9jxb9Lo7uQCJQOdZ4xHqKgTrf4F0t9s7qTd
 3unU+mRlGzhnKBPFCeqxFcfmuht2zEei2XXRGUjyhew=
X-Received: by 2002:a17:907:e1c9:10b0:c25:388:4202 with SMTP id
 a640c23a62f3a-c2503885e2amr164536866b.21.1787662409813; Tue, 25 Aug 2026
 05:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
In-Reply-To: <20260815220754.11724-1-pranavkasthuri@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:53:17 -0600
X-Gm-Features: AcwNN1WPlcYiBKpi2JJgiUAhXXkzsaHfjhYhhRFp_8xWtFc5LVx9U2-QkKGqZcc
Message-ID: <CAFLszTiGNt5cmztM-c+irvFF3jnSmbVrh0EAVqio9jM3kL7Ruw@mail.gmail.com>
Subject: Re: [v1,0/3] fit: cipher: bounds checks on the ciphered image path
To: pranavkasthuri@gmail.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Pranav,

On 2026-08-15T22:07:52, Pranav Rajendran <pranavkasthuri@gmail.com> wrote:

> I have kept them as separate patches since they are independent defects
> with different consequences, but I am happy to squash 1 and 3 if you
> would rather have one change per function.

Please keep them separate - distinct Fixes: targets, and easier to
back-port independently.

Since these are security fixes, how about adding regression tests?
test/lib/test_aes.c covers the primitive, but nothing exercises
image_aes_decrypt() or fit_image_get_data_size_unciphered() against a
malformed FIT. A small sandbox test constructing a FIT with a
non-block-aligned 'data', a truncated 'data-size-unciphered', and an
oversized unciphered size would pin all three down. What do you think?

Regards,
Simon
