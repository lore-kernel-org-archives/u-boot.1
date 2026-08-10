Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBAC5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C01FD406E8;
	Mon, 10 Aug 2026 20:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlZ9sdD9fz1v; Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B607D406E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395212;
	bh=bB3A8rWjxB57tXA/LGN+ir7MjPzx/XqOs5mlHY9dmBA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTWMFPEGd3Op6w+UK5ICu9ETmfYcO63wnB6yk5xEPn9un9Cc/oFZQHgrh7J/kdNw4
	 sATwnKPf3iN4CH8eu+aGQ0cVggxaAkpH8Rwp7j6UwBmPBn1R0Nkxp+vsV+i7RPNZVl
	 doHcO6nD/sC/H6ipY3UE8YoIeXZa+UHA4X+AyfFZyNCCaaScHUY9sAAq0yI0ZpAdli
	 rEql1wYKP0ABAbOmdwH1trIY+Tz3E43ddqcSxTvvgtq6s+803ZQmRdOlBtdZSiNOhE
	 /C3TGWzSJjTSUumBlEFjTHmXhjh23qnynughvhFs/zIEgCKE/u4dl699pi9TVh6pxd
	 aUioxA3WFeK9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B607D406E0;
	Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB3EB23F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9262C6075F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4WwLYf-3hqk for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6A3660756
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6A3660756
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6A3660756
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:27 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43bf9548df4so1432517fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395207; x=1787000007;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bB3A8rWjxB57tXA/LGN+ir7MjPzx/XqOs5mlHY9dmBA=;
 b=nXgrBSeB7GDOmkWAASy+uYTYrG7sUFSOo7G1ah54UUvxckTsFqA/xtF7fnJP6kCrkS
 tCbp9XuEjzvfSxz9K5s/Zu4FuddmyrVqgGt5d9Lxx9KkB2AN6na/+TRwFNFrOErsd/TL
 5VcwY9lyiOtjpWE1YaiMJQ0F17Am9znVGn1vya9DoClPkZNkRuJ9YdpPccdSRfN0775x
 tIB7fhIiswE6OU62LrCQZXmIzxXN1Bn4gm36uGz2ha8DxPgE5dvjfhzR52i7uOPqjIQ+
 azfS/6P+Aw18OWdWPlB0VgPAEdVHYPADM6/QYjB5At1zOR89/r4XTjqYryKHrLXwjAeq
 zFyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgSIWGLW8Cn675H2kDRop56lKfC+3SKKAT2PY4lz6/iucs48VJjX/K6at10DWMCiggrFcyXKk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyUMjeBXYYaRG3ku6wx/Ksq7z6NBpfT/aSQaNnA0AAq6hsvdSlN
 eO9JgjVLRci7RXPvzzHNHqa443p2HBv84o0wnnxic+P+bxMDtAR8w0QOgiHF2v7ISR+Ijw9a64J
 LM8jSPh8=
X-Gm-Gg: AR+sD11No2N3bg3C2HugxGVtkMYo5mkRTJiYMtkBWYeU6Dn35vj+2DkQ5M9INd8x+7C
 QmQkBBQtvyrI0ckW/0+TlK3fQyNcl45+hOfJ1hAXeyxbJG0QEsCwv86hcYkOS9Rnv1sz2NJ45Cl
 OLqqbz2pFCheITmhfMBvWSjLow0LpJUUyeEUgXAFC2rkpkpWmWNIf/2nxGNhUTlEIs145pR9Vqg
 X53TSkFUxTMiiPkXD/RlNlQTIkW9/F5xYH8KAeIxiRc29Q6HWbU9ia0cZNPWvEkO2ftS7fGMW37
 WEg3C6guGXDi9xli/08YPquMa9GXrQ7xquD46GS86Urgr0rh1UP3eFklEyQ2/keGvhzmm+58Ba0
 3f9OWm+HUcB5wsZ1LTmA/GNPXUfZDfG+/NwlPX+fo7oG4WbsybR7DKXhN/j1/FSOaHMyHZvyxIO
 TW102eydk+wBjQ3/Ql0hZN9wF3du+ZujMGkLSSZDX0nSMtq/01H+dDtsPUURCMjVYpOhBDWG/bU
 EhM/ZgtlctiHzGMU91g8aXrmIndchFmpnXyQVm7N3cRQNjEbtYM1PTy6N+jSQLbBH84NdN9sC/T
 kP6KMlU3
X-Received: by 2002:a05:6870:9124:b0:451:25f2:da63 with SMTP id
 586e51a60fabf-45e0554a344mr2492639fac.6.1786395206691; 
 Mon, 10 Aug 2026 13:53:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Randolph Sapp <rs@ti.com>, 
 u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <cover.1785276461.git.daniel@makrotopia.org>
References: <cover.1785276461.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 0/3] boot: fit: authenticate the dm-verity roothash
Message-Id: <178639520566.1450255.17476771130005296710.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395207; x=1787000007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bB3A8rWjxB57tXA/LGN+ir7MjPzx/XqOs5mlHY9dmBA=;
 b=nvvwNoZAWok3SH9UsH2ls0RkXX2VsBq9sNASiR+vjGPVaPlsJEjAiDJkMGiliz3wE0
 +3t016rGCICf7HU0Qcf8Vocj1e7ic4X1uYz6B8RRfr84Uc6fjomoU6kBmrZKjIhWoQAu
 qc74NnReIqclrJD/sj+iRxRCM1H46Xgr5MaSY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=nvvwNoZA
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 28 Jul 2026 23:09:30 +0100, Daniel Golle wrote:

> A signed FIT configuration can delegate the integrity of a (potentially
> large) root filesystem image to the kernel's dm-verity instead of having
> U-Boot hash the whole payload at boot: the FIT carries a "dm-verity"
> subnode with the roothash, salt and block parameters, U-Boot passes the
> roothash to Linux through the dm-mod.create bootargs, and dm-verity then
> validates the filesystem block by block against it.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] boot: fit: factor out node-path collection in fit_config_add_hash()
      commit: ba9ce23d21e3536b7de5e5722f20b8d6be695d3c
[2/3] boot: fit: cover the dm-verity roothash with the config signature
      commit: 2601d94691c00e0a05dc61241bb91d680519d49b
[3/3] test: fit: verify dm-verity roothash is covered by the config signature
      commit: fe9877c7d9dea740985edd11f7ff583e311568be
-- 
Tom


