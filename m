Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A7606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NHYbC44+;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gETTy6cE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6F4980BDD;
	Tue, 27 Oct 2026 14:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2GeDtGzxw4TY; Tue, 27 Oct 2026 14:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D81480B49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109854;
	b=DS4tP+FzUZjSvgqa3rmtrODdRCk8ra/ak6mJiAbLOgx57JvbZUOHC/UoCizY1CRMqYs4
	 hMQrwMAZBEVdUyo1Qh4AdZuuRWMuWWBDvuHqvPMlsWhruRjtfVBfJ6G9MFcXVmFoRnuA1
	 27ZSF0ucj8EacN9h7cxqRz0iv6Kqwd0mIDkuG4qZ3E4zJH9KggJtNPuLvhBwL9JiXOuqD
	 XUZv79RVDfRueyEXOmv8nuSYfLNaS25RtnXgtuKKVnbe2HcOcEfwW26rrnLNGBdlBQQqV
	 JhkthBxdqRtUyJAPUcnDg3rtsqxIm2kryhzBi8BYsY/RB6wKfOvxrNvdIVDlrM7Xtlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793109854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yF9I1Ka2v/YJwejpyAXk2CJ35iC0pn+xvUSs9hQPMns=;
	b=Lq/tHUJQ1ZNWhin0cFxIWBP17lnb9LAEmX6MDvEsueXr4j2bHcGCSZSLYHkJADoHDwWU
	 jC6IL2YoceVBOm96uqV4OExUoP0MXNburfatsk9oLPcSw6EWGG37yaMit/vX0q3HSoG9S
	 0K2azsP27AnfvU685XNNavE1zS9LrhGvaPtx8UAvJ5xJ3S6xiQncncKf2KxxIaHFp/iC2
	 IP7kKtTSwjFZlEDBFnx/hlR5pjTjk4IPZ/c78Q8vnPeSuhnHne8ZnL6FXX7Ym78x+OAs3
	 ri2PDMyFt0L+g545e1Hb/0JHRctQO8nLtHjOYz0qJrdmBHO0FYJXU3gK/g+0bO8z0Qw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gETTy6cE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793109854;
	bh=yF9I1Ka2v/YJwejpyAXk2CJ35iC0pn+xvUSs9hQPMns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NHYbC44+xezvQ4qKRBrGoBfCCOZJyruV7zLJJ0sUh1PatUamW8xHTSCVrAEkxSiu6
	 WtZt2cO1vYjdq8trUa3dqtexYi8HyV5GKqve7qP2gTpq8rVdd8yA9SCnd+EXuv3a0+
	 bWTKgwv3Jx1zxayF86ksCQTIgrjc4K9yGr/EDbLdJ8pJ05OAfAFTfYGO3wXK8YoQge
	 y3TKJsimflEhqe+a3z2BZcNJovKd5Uv9tb1SMx6qhhMYvXQ8WAAShNMpskl5gRZYGK
	 /mvBvlgXC9NjfIbAZUvZ7KMUVbiYBme3csjlTiHx9c8JOqw0ETAD6F1RkZPNB980Iu
	 79hGZqnQD9Png==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D81480B49;
	Tue, 27 Oct 2026 14:04:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0E43279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6EF080BE2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgs11BS9nRV6 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BA2580B08
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793109465;
 b=eaqhiNehkm0jB2AdeGG/pHMGEXlp5QwwSERiadfT7WkrLibIa0JB19r8+aD7v+MO4/Bk
 KLz6xlYMkXXshk0sJ1l6no6BOwc9wNQuxyGUlrhC3KPaHZtjC2VkALYtAoM98pL5or14W
 A7WSqMNKlbZ3p5mgXcR9PYvrKu2o1bYXuyKk7XrrUNiGu5/oAqzo313D0PJWBpN7ulacG
 GZ+QjJBKSwvAK3OrqCARu6pWbXuOgp+l4eISzCOnRxkD9XTBbZsX98cG3EQWHTv09PTLc
 3OeOuqo2u/ndaQAY+WHcPLfnBzKJ7lFoBeqIBuSt0jb5w6D4hgoK3DFfrEYudls+aVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793109465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=yF9I1Ka2v/YJwejpyAXk2CJ35iC0pn+xvUSs9hQPMns=;
 b=pKEM6C7UZwL2c7Ue6bi/inxyeDBJVkV/S2gs4ATjg1cxnekDufWFLPYr6aqMAAx2MEdl
 iXiVynoq11DIrVs75j1+DHr1LuVO5fvbR268aWF/bkReS4tTOINdT5x+geyFZGozWQwct
 1pRfy/GTlRjWICp+/+FOTXl87dkuccOHwfKSsRC8+S6mHPcecEdsrsLYXetBZ+rh0nPxj
 HDB0ycCb3hZv4+W79o1o9GggkC+IlO9zTARXXsREOqZs5I/x+ObRHvmf6GoukBo7+0nvV
 nBp9uMjCAOQm58oKGbjjlBp4Bk3XHZfD4FV0VdWuejVs61A7vA3A+S1K0og26VrKYOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gETTy6cE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gETTy6cE
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BA2580B08
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:57:43 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b3f7d5b112so798818a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793109462; x=1793714262;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yF9I1Ka2v/YJwejpyAXk2CJ35iC0pn+xvUSs9hQPMns=;
 b=gETTy6cE6ElDnmspl/5myVHCYcAVHG0zJ/MwRg++dgATJnG2kBcuEbeD44C0KqjBGz
 2mU2QLTrDOEOeV3Oiv2TRt8xi//s5TMeeN6+dV5dvvu/BCSiNgSlH7XwlVWyI2dAa+Tp
 glBMK38CJ/Tpgn8atO6EA7sAqzS2TMZOewnpzHfAl77GikbuLsb/F5lV0VDCAz0rkZRx
 GbUIIpbXW6v1VkiqK/1tOp/WOhfeJhVkiwIOb/BJwwAG3C7ThsjER/tJkWTi0vps65AT
 bJ74RdKNhGLJWsR4mIU5oZ1YL/OLINl1sZGVEXPUmHrSisozcVJjuwWVKFMcaGzXzEel
 x+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109462; x=1793714262;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yF9I1Ka2v/YJwejpyAXk2CJ35iC0pn+xvUSs9hQPMns=;
 b=iTnuAmgjmtGb15gb5FLlL9+3l16sI3sYXYToaEdVu6SKV8V99FP3VMFkpEDSYgApy5
 /SqGlpRj+zXYrGth7k5WDJhi2YPSQuU9HaFfJmRs9zfta2tUYTeOQzfuWsUig+YGreCx
 ODdLVLTNibwIh+NaZ475vgsZd49g4ESrVtEPcvVK4IM2dBsdqMtBJ7xCA6UMXHKhGtcL
 99pgTUX7ExlYcb6S7RLxbQ5QO9QPMgBxOKE9/gp8rx39fAjrTYz6bYALX2ktmwzTmiNs
 mQMIJh/dc7ok6O+edXfcr0GkDaLK1aPWnelYL/fj8mGKe3FltLp4Ju0ADZXU/i67dI2y
 Xm3Q==
X-Gm-Message-State: AFq9FYLUBWtzMDnVtcqnNKbfkvwso9w0PIjjxDVrewW9RgjbyIGC5dKL
 e2TV5wTLrmLL4kGwTh8R7TjY5BrC3LVfuVRah6U0JE0Zax1DhbODN4nnqD4/Hzeepos=
X-Gm-Gg: AYBFou3J9tDLf0aRakHGo2JQ0AVMt4VlJSIk2P+nLnFNTbtaAxw/+7AywVg9bxpsPCz
 vTUQUBhepR6C0dDLgXSXoAtbQ4wTzgErQuzD+M0SzCCrl/E+khYrXAyMHedZsB8QTqZRSU9b4pT
 myVaZ65sKjieNb2seWY4YQX0LtC9hFFVIKDg7SDju5jWzh8IoX1ldMK+DD+9jpnXhdWQoDnN0vx
 ByPuWbX9fAmVyVOyrZ9C9Sermu7iAl/NfLbvFABC/DVjJM+MFPCY8bEhom1RGRPor0ZpOJbGzXu
 hfFnMIVHNAaMjobNupV7anCYx9IXc67Lle4NEjUoqwoJGgPxlf8Z1N9b1ismDgcX1B96piqiqjl
 Gj7R+lhOZRk7i71AuS+TaImZ/p0Usjv0TQBEjdHy2G504PwVl0sDfZsgXAsKHE+xRd1VQCip64J
 wBDg4EFpHiPRRNcTGHQ2t+YJ77rvIeVeeYhoq+IJfGUl4IqLgWDxeTXkrPYBQkzCo8d3HWDFisk
 6hwLRbOcGxWIJBIoM5+/S0gu7ldHePi89UJrA6LUT6J51RgZPhVto++2KqbnjNoLnBygQ4ykZCD
 wuxvOSoz/EPO5dg2QG8EK84+5UtyWxtB38mbhQLjQ9wShGQVX8Nj3eYIURrAuw==
X-Received: by 2002:a17:906:abc3:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c46bd95850amr1260254966b.0.1793109461819; 
 Tue, 27 Oct 2026 06:57:41 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7984e9sm456546266b.74.2026.10.27.06.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:57:40 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:57:38 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com
Subject: Re: [PATCH v9 07/26] usb: dwc3: bring back the samsung usb phy driver
Message-ID: <auCt0gCv9NPx8oF0@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-8-anders.roxell@linaro.org>
 <4b24f045-7fa1-4be0-8993-2bd441a7e716@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b24f045-7fa1-4be0-8993-2bd441a7e716@mailbox.org>
X-Mailman-Approved-At: Tue, 27 Oct 2026 14:04:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 13:42, Marek Vasut wrote:
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> > The restore commit at the start of this series deletes samsung_usb_phy.c,
> > because the file was not part of the original v3.19-rc1 import. It never
> > came from the kernel, it is U-Boot code added later.
> > 
> > Nothing added it back, but CONFIG_USB_DWC3_PHY_SAMSUNG is still in
> > Kconfig and odroid-xu3_defconfig still selects it. exynos5-dt.c calls
> > exynos5_usb3_phy_init() from this file, so that board would lose its USB
> > 3.0 phy setup.
> > 
> > Bring the file back unchanged and add it to the Makefile again.
> > 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   drivers/usb/dwc3/Makefile          |  1 +
> >   drivers/usb/dwc3/samsung_usb_phy.c | 77 ++++++++++++++++++++++++++++++
> Maybe this file can simply be retained and never dropped ?


Yes. Part 1 keeps it now and this patch is dropped. Part 1 needed a
resend anyway, since v7 does not apply on master after David's
dwc3-am62 fix.

Cheers,
Anders
