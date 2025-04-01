Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2982C3600C
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 02:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA22A81E5B;
	Tue,  1 Apr 2025 04:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="peWQl2Iu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DE681DE3; Tue,  1 Apr 2025 04:16:40 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51A280584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 04:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b0626c785so3996619a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743473796; x=1744078596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qx0ZPKBH7yLlgNu0j17rHJkEywzUkiXeU6B6FeDB5ls=;
 b=peWQl2IuFfJUfKoCE87pHXjvtsqaoC5Wme45Zr6QVjKEsoO5nd0Y0lLZv/8OEpgxMa
 Et01MqTBnXlN9m2r1Y1AofELvt/u5Wlz+DpD/WZ+bWKIEy7qCweduDU1yIxSc0PR66Ln
 r4y0gIKAJw4n1KL2k0n4FKtRor1rAPaDi6s0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743473796; x=1744078596;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx0ZPKBH7yLlgNu0j17rHJkEywzUkiXeU6B6FeDB5ls=;
 b=j1OV1BlpOi+yDRgCCUtFgVns/jVTyzWiAu/b7tlRgxaImEcWd4GP/yarYsqwLgNcda
 SAQ0MzOlwSuTDapAecUlg74Q4cXaySfX+Ibp/k70iZ0JLJV0fv9MLeb94QDVly3z+MwR
 uZam7IAjxjJAhh82NYhJFTD9uQwQHGHH6sNKuhF9Bw/UiEk/aa4sqZn98wPfzVpc5mv2
 EZ4vMKPaKirXZzCuU0suWL2aapnAlAn6oRBlhBpIIx2Z2FROUFx/J9yWlJuWfFWl24Mm
 u8e6z1A8taO+rErWwmC68LH3Jcc4CzkiOEr43MGnMJz+/vyeU6nse9F4F1J6OdZ3gHGf
 z8cw==
X-Gm-Message-State: AOJu0Yx8FRMBYXSvgYJMcCECLnR5Zfug/ke1+TG6TVZCx7R37I5PagGI
 hjLwuCaa6FyA+KeAMctTUV9lYjNLk7pHVqeAuqbk+3HNdoJQ8vtw8VogtwbPVbk=
X-Gm-Gg: ASbGncs4drT9eIbh0+7rDKZTP9QyTtIrVFLHjntARkrRI6GMvUGrxjjIcEzrFCNwxi1
 5Wsh97fvDMiMOC/bE30AZ6B4gTF10Dm7l72ls7tj66P6p4X9GCewYU2QmquvYOEz5VC2U3U80bp
 XdZzxutyS7Ey4oMG5pRQh5lYSX9EGqH8XLwdtFSyAXv8iYkgTo1KIw59IkkIQ3jEvrH6aE6DbQp
 1UMvay85GerxCTQ3NCbSHUfEKdqUuOSWhvYX5OHAXcQ7YLl0ePwnGjTN3AEiB3CvjJubG2F43LR
 /I3S0v17WKSufGxFlJtL/I+OpXT4R7H2mVbhhZkmWgw1QVttUv4cfCTkPCtt3+tpbNbmrXg2kIf
 C1ExQ
X-Google-Smtp-Source: AGHT+IFgF7F9pZkU5zA2NMrcR9Ox4qMhzmrVCN6n7FvTXK179KZlcskGAT+TjHyvBgSV9Zu9eDo/vw==
X-Received: by 2002:a05:6830:488e:b0:72a:47ec:12da with SMTP id
 46e09a7af769-72c637a4b1dmr7917454a34.10.1743473796204; 
 Mon, 31 Mar 2025 19:16:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1704892a34.18.2025.03.31.19.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 19:16:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20250311141430.154763-1-richard.genoud@bootlin.com>
References: <20250311141430.154763-1-richard.genoud@bootlin.com>
Subject: Re: [PATCH] net: am65-cpsw: cpsw_mdio: fix typo in error message
Message-Id: <174347379512.47384.1071435305710440787.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 20:16:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 11 Mar 2025 15:14:30 +0100, Richard Genoud wrote:

> Replace "froced" by "forced"
> 
> 

Applied to u-boot/next, thanks!

[1/1] net: am65-cpsw: cpsw_mdio: fix typo in error message
      commit: 2f132281cc7899b74ac6de41500e1c44c8180c53
-- 
Tom


