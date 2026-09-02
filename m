Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227A2C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D74B80EC5;
	Wed,  2 Sep 2026 14:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQ68Y7Qp_kr1; Wed,  2 Sep 2026 14:12:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358339;
	bh=I4141nGxAgBhlV1gYOTnJfq4b9hGUoyLR9POJ/hXQxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=04yUjx6eC///h9ha/Rw2ILZ3kjSqfil5HencXy0Su4lc1sf1IPUyzxkKKjTc6MBBo
	 i3PFGLNQJCI67swXUKFqekH2VMIrFN1tdLR+GLxCMm+/05vksRZAeM6AIPTitSvtoI
	 OnjPa09SJPoVA30dpxNViDTUHXSQ/3xYF5ubncvjFcijSWKebEhoSXSLWhFFyWID/d
	 4hv0GxFxOLw97u+MmgXSfg6Ii0MHiOO7cl2eWQyuVTfokXaL+oUMr+gWqP65qaqDAy
	 dZvwIOriM0PxWG19Brip5zckF+HC4KlabDWZjHLFy56O8QE36gre7HZxE+s0jkwVwa
	 nbgiEKsTBMehg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBD7480EA6;
	Wed,  2 Sep 2026 14:12:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DEAD1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E791D80DCA
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2yK0rj4hpDg for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:12:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=o2AyeTwZ
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4524680DF0
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:12:15 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b1bf68b387so495265b6e.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788358335; x=1788963135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4141nGxAgBhlV1gYOTnJfq4b9hGUoyLR9POJ/hXQxI=;
 b=o2AyeTwZgftYrtg3mpvmCIEyBPT4Kw+8KkdB8rO/YrrpVvE8e0PEVgRnwMXB0OjdvF
 prPLFZM6SMA1pv2MJW8jQB9jbx1d8PDXZI8fHmhDSXisgwJcqwKtN2ZcavOacBSKj3Ee
 EbFo8dG58TKpBBHz9amuDvMfNAIsrWS9RB6P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358335; x=1788963135;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I4141nGxAgBhlV1gYOTnJfq4b9hGUoyLR9POJ/hXQxI=;
 b=lpJ5crsgHitIjIp0zxUKPWXbG3Waz4LfsSZMCXNug7kh3cGkzet3TbDw27teq2ArfJ
 QUHVUrvJ7zdVoYnRLMapQ/GvlvLW6hT3IVNXplmfcQDtrSbCdi/kNKo7iA7lX6BOddca
 +X8YqF8Iq/b+iMXNj2IMoDhqsYMP2mfpfbPNkAewjmOvOhpEEmuGqSbSl3U5JHvog/b6
 ftA3BZnmb1o0nX/caWLu58nMqhO/kDwgCt6m9rZhMvqXIj6qThrLvJojkxZVkbu/9DMz
 gFWSGt0eIiT+cj1OxmEUeqAgasC1JatNETbe040FD+7b6x2SikGS4V8LSSrBHWVuKb4x
 VREg==
X-Gm-Message-State: AFuF++ktUlfMTr++YiEkT5idc3fZ+M8G2+VxH+Eh4RV0IIDv+jqdbqM2
 TwbiPcZplcpo9mKomAQPTziw6CaZm2IHK8D29gH/dkvke4LGGV0ELc2QUgZ9iaGg+Pg=
X-Gm-Gg: AR+sD11gJnGSuM9HkRPJjzLJewo+4UvTXbMKi+fu9mR3qQJKbEcxwZIKJ2cezbEnCwh
 Oc+rcej88h4RYwR2OcWq2CGOhnDetR67qyYsz17TCQ0o87hMYQMpYGn5YilUa2T8XEeDbHyuJmv
 D7bzL21zLjdJNTUGSiD0nanL7GKNie8rg7leMX5uDQcHPtfPnoVA8mb4UjcHb5CaP+QibAeDfPo
 Ilw10OvIkJK8UpatFtz/Fdf0a9MP+u4M+F8Ig6grfh2ZKeRqO2txCoWbfYosCWN3K9huKzP4dg9
 1tryE8261Ig5qwZdcu82Nurfry49i673lHOZgKE7o+OQz5aMD+XPQ6U72vuaB8gbqhxqS3IbdO7
 PLnv5ETW0nX7YFW5YiW19nIHOPRwT6bVFrOKKXOEY7H1UWfHOZruYzCxIfEYi8gl9GWyHd2zwGq
 yc28p5WpOI4H7YHLY6Dx1ZwuKW7txkG6ZFLfBXv67tOuG3kKH7wUwgUcSpuG79flO40qkJJTm0r
 0gpN0H5/j2Z13UZuFLiN90kD/Ei1DXoWf4Cvl1sXQWyEc/6XafBqZWtz24SV10zHsgyTSAd5X+Z
 Cj6ZLc3r
X-Received: by 2002:a05:6808:10c7:b0:4b1:bc2e:3f60 with SMTP id
 5614622812f47-4b6bf8a2b12mr4041031b6e.16.1788358334853; 
 Wed, 02 Sep 2026 07:12:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69851ea2asm2100494b6e.2.2026.09.02.07.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:12:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Patryk Biel <pbiel7@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260813-up-j721e-get-boot-device-v1-1-fb50a5a328d0@gmail.com>
References: <20260813-up-j721e-get-boot-device-v1-1-fb50a5a328d0@gmail.com>
Subject: Re: [PATCH] arm: mach-k3: j721e: make get_boot_device() available
 outside xPL
Message-Id: <178835833392.1743075.12063395348280305104.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 08:12:13 -0600
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

On Thu, 13 Aug 2026 14:36:31 +0200, Patryk Biel wrote:

> J721E/J7200 decodes the ROM-selected boot media in j721e_init.c,
> which is built only for xPL. This keeps spl_boot_device() working, but
> leaves U-Boot proper without the get_boot_device() implementation
> declared by the common K3 hardware header. Board code that uses the
> helper to select the environment or boot targets therefore cannot link.
> 
> Move the existing primary and backup boot-media decoding into a new
> boot.c and build it unconditionally for J721E and J7200. Keep
> spl_boot_device() as a wrapper around get_boot_device(), preserving the
> existing xPL result while making the same decode available outside xPL.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: j721e: make get_boot_device() available outside xPL
      commit: 97626d3f0ae6e7d470ee4048be58ee180b29fca5
-- 
Tom


