Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9081AC61DD6
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 18:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 164B36081D;
	Fri, 28 Aug 2026 18:07:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j762mx1C0Y5d; Fri, 28 Aug 2026 18:07:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787940472;
	bh=qLljJcf4lpq/gzeE3UWvJLXyAA0qA7u7/0k9SOZy1Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MOqgC58WHjFXkilrVbRwRpKQUxbnBBBSAbWTJDlJBNha6bvqaDxSx6+S5dlJR8Y7I
	 SN+hQCv6NoM+VnT3ajbV+3mJgI7pKObFi20X9XfSQsuAHmgfnYiPdcwtyX3VG9A2XI
	 g4gHnkCUzRVbdryPlzN2u5QVyjHYDrXK9PFb33oSXL7USBh9ecg9hPBljjAUM0TiKw
	 7F1QkzgyjNiBl30xyGyI/wR2bax0pe8gkG5VKo3rZjV8Jkn1YfHkHqK3kcq2WppgY5
	 bxKwEzbU7Hlr/bwKH8JmOcN5YQsVHKZ9wsaXRyAra8fm5v6DNLmQGOJD1rpbvEyj5U
	 qQrsmIWyobdKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDD5D60705;
	Fri, 28 Aug 2026 18:07:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0228023E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCE4A80ECD
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPIiMIRjxyod for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 18:07:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sTtMTB3K
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A53080EB6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:46 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a456e44e01so1325090b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787940465; x=1788545265;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qLljJcf4lpq/gzeE3UWvJLXyAA0qA7u7/0k9SOZy1Y4=;
 b=sTtMTB3Ki29X7xS6fhOQbT8c7GR3Xg2b2Zy+vOT7Ot0X3n4zGXCuSnDiutyGnsPaFw
 6AP8BkuHdx6jp59vNmqeTVPb6ekXMxs5NLWamNbT+vNFAgSvjr4Nz4/2YPygbnW1IpxT
 Xy5uL3ywZFd4Zo8UD2GAvaICSrjgqdDEvsmDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787940465; x=1788545265;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLljJcf4lpq/gzeE3UWvJLXyAA0qA7u7/0k9SOZy1Y4=;
 b=WRRQSe9EmNVQeoARs+6PrEWm+XtZWycGQG3bac4tfDwzVbHHqVjyHKOrUlC/vwxVBU
 8G+MAMHsR25EYlq2pNx2LdcUEowuUfB2jRZrlGTKYNC7oShlE+tzjW6XkVI6O36+G46S
 kPxQhtMxUGEAETL19SzyQJkD0fXg+nd15soKOowMufLUH2mwpIbeau96J18kPuIpEr/2
 D2r3xdOfc/66ijGpx7nH2B2/FrGn/VyJ3D5q8J7ZPCN98HP4bpbkxPkhoQ2j9Euve55T
 +FxWZbraxR90eVUWJsRXD+e3D0r9eo/ukxNB0RiWJO3+pH+8ufWnjArTl7fzc0xmZEuz
 gSRA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrnf7MJCV0iJ3rHW+M5QS+7YeBPxs08PNHxjk1G+pJtBmp9vIIltdCYV4XhcgLeMK8jRt4NWmw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nL91Wx7rhFYboQjq6cHO0ID6PX94X39pQXGXiFvEJkixAyMmC0
 LUpePfELaGGEohqZXYZ8oBF3OkS2Mp2vZZTZOJcDkjc5dcGpkF+aBjVaKf4qkxCFDxs=
X-Gm-Gg: AR+sD13AsjDw8Y2mqoY737eJRaZOtz8S955f0oUMd3qQYV4o86ncI73AjxwPexT6wEF
 jKxg53C9cIhsyQgmw6l3RWVk1m4+chJ7oK8pKarZi68iuVE6Gt8OicZEg4GFuMwestdNPvY2u7u
 zVwT4IijhFDHrc5vajx60QC2bywbEPXez6RwPofzBNtcxo242498t8McOmMBMpCBVGPla2y3X7O
 8smM03z7GNoVB7kF/FcxHxx673RHH2iiWigscU5VUQ9ki+gdJFeAMge3o9RvWg7h60dOle7ceB/
 PrOi3ULwVHBgtGEaRkH4dgh57bHdWcqULmJ0Z0ESv8xqXzgZPMp9z/5aa8o0Zq9GaKC9eh8tC1q
 zcC0fVneI8wTYKvazQOFNhEWokg8bf8TiOI2XL2+Wu4KXG4ANcfXqcKjaJksl/HwONDX5sFU02P
 tcK4CDcCHpXq8wY1ESi0Qfk0MUmJCAhArBxYgcjcy5PTHY0dnqfk3xnmW5PS/bHCPI+m0P8k+W1
 JlhQUASn2ag0DfiBNzFSGCbgJrh+5J12l4IVBSQxL/ybYoqHOgarAaGSSKUdQYOf/dC+WGJvCtp
 dYFUzsk/
X-Received: by 2002:a05:6808:1a0d:b0:49b:c387:36b6 with SMTP id
 5614622812f47-4b39827284cmr9508948b6e.13.1787940465206; 
 Fri, 28 Aug 2026 11:07:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995f2fsm1834283b6e.11.2026.08.28.11.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 11:07:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: upstream@lists.phytec.de, u-boot@lists.u-boot-project.org, 
 Anshul Dalal <anshuld@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Sparsh Kumar <sparsh-kumar@ti.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
References: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
Subject: Re: [PATCH v2 0/2] Refactor binman nodes for boot binaries for TI
 AM625 into templates
Message-Id: <178794046366.240063.10479512415360622460.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 12:07:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 29 Jul 2026 16:24:58 +0530, Anshul Dalal wrote:

> This patch series seeks to help in reuse by moving currently duplicated
> entries for tiboot3.bin and tispl.bin into a generic SoC wide DTSI
> (k3-am625-binman.dtsi).
> 
> This dtsi in-turn gets included by all AM625 based boards which can
> insert the templates from k3-am625-binman.dtsi.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: dts: k3-am625: add template for tiboot3.bin
      commit: be1cf93cdb602e85ca198954b494145dce7f0104
[2/2] arm: dts: k3-am625: add template for tispl.bin
      commit: d200bb9b318c2d660163b545300b795b43f450b5
-- 
Tom


