Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6657D0D79F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9E489360;
	Fri, 11 Oct 2024 16:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FrM2EAYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABEF8932C; Fri, 11 Oct 2024 16:42:19 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994AE892F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-430ee5c9570so22865535e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657735; x=1729262535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLXdBPDRSmqEjjNZKvk7ZTzEERtGuAWK9DyddN5WdBA=;
 b=FrM2EAYCNF1TIBXTVIZRCLXPq2albJrYdNwOdnYsCWGDr75vlAaLigHaVvsX0BPCmK
 mIruMgHtxnLYDfOiUU76mZxDDz5WL5ik9FUvypm2UpA4e6ATFpkrLDMUqMB6SY9+qz0N
 7D7k3JaKnQbyEKowYCely+N+a7OMa8fXWclQaOR1Txmo7BHLe2x8faI4iAKAOc+oLu+G
 CJWX4zR2Wu5jwFQt/IrD8D3+dPUmznoote33eVallXL/5gIwVSltiP3O83B5EzZ5y4D6
 HXNb682ykZtbO+qA9RLhyf/n4rD7uIjIflqT5yodD4C4NjnJFo5tVYLE4m+nCl/ZOdXk
 4XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657735; x=1729262535;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLXdBPDRSmqEjjNZKvk7ZTzEERtGuAWK9DyddN5WdBA=;
 b=A0X47snRb+sLthTnlb6kiIvlPZInrjnQ0ofPQnqXMe7BZ7aFX2h1sJfMbpbdsJ6T+w
 ret36S+wdKpgXa6aT3BXxXSRBJ3TYYLU+0Nd5cd8sKi/UUtqkArPNvDV+gj4kFeJHe3e
 zK7uOFRLWPDidERE9YLn69y1xJxPPjNRFXLB1hT+io66w6XCwzsgZwLAAhPv5FJJYwik
 5PVGJPfNN/nSmxmC78sQ3ZGE655OidvsBYKqIBCS5cpYhYvASVGekom39mv1llSuWIoA
 RwQykOq9aoWtFf/KxqLzLaV0faEPMas8if8xaHmwUVWArqnV22CUqbWxAoAZE1okTExn
 KXIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUIhAJsibz1TANxyGvr3ln53K1CyGnakoNprJAkSL+pm8rIjJv0LlNMBsWCVFlxTZw3U7dXBE=@lists.denx.de
X-Gm-Message-State: AOJu0YyaH5ze0AqkWh6b0p1UxAbtsSp2kk+mfjaQAeZTf2jKIH//8gGH
 n05I7+cAymLrR/AMCIcOSufeEIhOiI9fN0L+IN6pxKTiHOhVxoPVNgCMTVUra0Y=
X-Google-Smtp-Source: AGHT+IH2lZqK3X61ypK5hclLt3Xn/kifXG0kvpIpzDSMGs23/KMRXA7tLSHV27u1TjUkNw6NtUlsew==
X-Received: by 2002:a05:600c:1e16:b0:42c:bcc8:5882 with SMTP id
 5b1f17b1804b1-4311dea3584mr28230705e9.7.1728657735062; 
 Fri, 11 Oct 2024 07:42:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182ffd14sm43951385e9.18.2024.10.11.07.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:42:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
References: <20241009-u-boot-topic-fix-hdmi-v1-0-2479cd90c4ea@linaro.org>
Subject: Re: [PATCH 0/2] ARM: mach-meson: fix HDMI since DT update to v6.11
Message-Id: <172865773433.2734796.4668834305012644771.b4-ty@linaro.org>
Date: Fri, 11 Oct 2024 16:42:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

Hi,

On Wed, 09 Oct 2024 11:15:19 +0200, Neil Armstrong wrote:
> The DT was updated with unhandled clocks and a shared
> power domain, causing a probe failure and a green output.
> 
> Add the missing clocks and avoid enabling a power domain twice.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] clk: meson: gxbb: add HDMI clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2958fd431af7d08a0b15881b59b0df2e32963ba8
[2/2] power/domain: meson-ee-pwrc: make sure to not enable a domain twice
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/25b489e2cb816f52467138665b9b6203c358f03b

-- 
Neil

