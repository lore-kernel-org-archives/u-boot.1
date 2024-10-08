Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49502CEF173
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81FB88E7A;
	Tue,  8 Oct 2024 15:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cC3pUqdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA3688E7B; Tue,  8 Oct 2024 15:44:28 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E4ED88CC8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-710daaadd9bso3123936a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395065; x=1728999865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1RxAvuIMR90Hl8nw1oPmNkv4EnGdBz6lx5KVvCDT5o=;
 b=cC3pUqdE9S1wq6+Pcz0r0AoZe3BGyENmlBJJWM96SQGt2UOGl0Kiqqr5WZ7hIFC0LZ
 eTgWonK7bc+/htoDMIV3anpwdjReZOqryQliyuVu9/7MyRRkfuZcBlPl30DtKpnd3rf1
 Ype1cRLAnDPFI0LjIKUe5gsmNwz5pGFibHgzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395065; x=1728999865;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1RxAvuIMR90Hl8nw1oPmNkv4EnGdBz6lx5KVvCDT5o=;
 b=gstaki804O1c4rR7w8ylh0IOydJ8o5vlEPCF7iR5SZKirxcrN+CyBpKFRJWtVAK8sE
 Mc3eOg0HRbVfgbMmap9KDo34Thd1HdQCo5v4rXch+b6wrC+8rhnL4rxcWhXK6UaYeWwW
 u2iR8THO2MwIsvvBMGTKpPTsO6JZWcOqVunQvqp0Nx/xPd+UcK1+AUya7xZmFzush94Z
 bpulNisaspUeNaZjFpQQbmcCgS6Qx0ToR+m6lgBGJqpOUsHwF/XQghzIVS9y6/Dp9i9K
 B8jD2xTo3aqcqhqzg74bTXWFrl2vsXe1W/2szq+1Fgcij3d4WxavRBEvrKYCfIhbf+fu
 XqZQ==
X-Gm-Message-State: AOJu0YyG8Fki0WtwYEHP6VGAIwC3w8xYJDd0OmufG691vqwlI1MZP5bj
 ldfAOJKl48iThjnl9FhH1ifQ18PKRxsDYtuW8ph263agApBHzJ5SX45XJSOGwoZgz/sSUkMVTqm
 hXsE=
X-Google-Smtp-Source: AGHT+IEkNKifR5hn/FsNeGjUGetNr+KJoxUCbNr/u8Vg+KngPJxlYJzH0ab7UnYyRQftBKP3Ea0W5Q==
X-Received: by 2002:a05:6358:5e07:b0:1be:de52:97c3 with SMTP id
 e5c5f4694b2df-1c2b7f0513amr512121755d.5.1728395065280; 
 Tue, 08 Oct 2024 06:44:25 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chris Webb <chris@arachsys.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <6ef2583e85eea60560d7776377d662779e7c44e5.1722419839.git.chris@arachsys.com>
References: <6ef2583e85eea60560d7776377d662779e7c44e5.1722419839.git.chris@arachsys.com>
Subject: Re: [PATCH] pinctrl: mediatek: Bind gpio while binding pinctrl
Message-Id: <172839506434.112860.9528093895429256401.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 31 Jul 2024 11:01:31 +0100, Chris Webb wrote:

> Mediatek pinctrl drivers call mtk_gpiochip_register() to bind the child
> gpio controller as part of mtk_pinctrl_common_probe(). This breaks
> gpiohog support because the gpio controller is bound too late for
> DM_FLAG_PROBE_AFTER_BIND (set while binding hogs) to work.
> 
> Move the mtk_gpiochip_register() to mtk_pinctrl_common_bind() and call
> this as the .bind method of each of the mediatek pinctrl drivers.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


