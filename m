Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6DC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 18:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E710882DA1;
	Mon, 25 Aug 2025 20:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="npudBUI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A23830E4; Mon, 25 Aug 2025 20:34:47 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E7D83020
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 20:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-31533486f07so533656fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756146884; x=1756751684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zB2wqTW4wGlqt+YI5IRW9BoStGtpMTyflPRNnbsV2+8=;
 b=npudBUI44duZ5PA3MzjLvm1ZKgMg5WjL1WU0LRyMC4V2FznBlh/L5LSTK7pgs6Jacr
 YTd21Md3uhXljKGb+P8AZxScP1CggA//cvT9cJs28mGk4y+2rSqg8bNURwB6zpVxRQan
 6HXacwDZgQdHBWHswH8hCVHAKwb0A/q3T1g6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756146884; x=1756751684;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zB2wqTW4wGlqt+YI5IRW9BoStGtpMTyflPRNnbsV2+8=;
 b=lrxuOXcyAqogfNdV98G91OblgfIbZuQff8z3xIsCV13yTxxc+VYxn14lwPGRuhVNi1
 GAW5Cz/Ab6z7WUIKldvyE2C2TRlKqDkh59Rvozbt+l7OOq+3+um0mDiuaCbshb4LTs9Q
 Cl8QkdFzkwXhYr5KXb2KuxYNBypPGWCGGz48B7FvKp0gsLhao2DhYiKiILyo6OexfGJ2
 7JHWTnG+qNyo1/Om7wLrAYHRqAjdRsRZPNKtQBAo4o9SUcRAjX2rzVzzCp/9w5cU4vzt
 FI47bFmHWrgbOnAwlGa++kM2c2VoR+IzCSgMAkBhtWEDPNF3o/RXl1HDNk89W2Cq79yj
 QVSw==
X-Gm-Message-State: AOJu0YxNQ1VI7Eg8mkGdc56GbctCxfsozeBMr4WuOsbB5EnJskBH7i84
 ipFV6Vp54CYXNrlu6fsHAIr0POmFxdBFkgcGOvxlSovtkY/poCcRd38oCH5LV+LQrhq5zKWW459
 /MpKMEaQ=
X-Gm-Gg: ASbGncuceoNSuUF5zqxaPcsVm+iu01uuUsFlTW39JRDnmpWbsMYq/TswuGW9ZVuqRaP
 BkybHlcvs1LY/IIFVKZFTPEYJKdnLbXPFhKttYkqwjy0P+mhOhQ8poWtKqktT7CBKf53cFkb5xL
 6f7UxSMKAWzyiKr13nf5eS3MC50tQG7fraIbK55RPQpzIWSlIUmPWcuCoM7sXIGTCMj+oIk2nYC
 p3fjRfSsM2n8a7ukynlXd++Z9AmA/h0AK/h/dxKD56IMqot+ydnHGQCMiKfvAneluZ1JLxP4FMm
 RCLN356jGuqN0JYLgq/lHqaEbrTXtoCZMgBwmbDa+IEIWrldQRyYDXtG1jDi9sGQj2iwtmIkQ3o
 DN4rpQbF75+oK7zElTu1RWs1j4UxGslrDg8cAJzotqzv+b05HQcLMeuk=
X-Google-Smtp-Source: AGHT+IE1XdwvY8hvILmROTKJnv/v81Qz6NcMJqNRR90Vq52zrEPqaFJq/d/IO5MIVPVszFDv8bcrsA==
X-Received: by 2002:a05:6870:e997:b0:30b:b618:2cb3 with SMTP id
 586e51a60fabf-315439130eamr321437fac.8.1756146883863; 
 Mon, 25 Aug 2025 11:34:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79bbcfdsm1931051fac.7.2025.08.25.11.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 11:34:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250815-wip-bootmeth-rauc-no-config-global-v1-1-4de26389bdb2@phytec.de>
References: <20250815-wip-bootmeth-rauc-no-config-global-v1-1-4de26389bdb2@phytec.de>
Subject: Re: [PATCH] bootstd: rauc: Do not select BOOTMETH_GLOBAL
Message-Id: <175614688264.2891795.11218821502173290819.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 12:34:42 -0600
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

On Fri, 15 Aug 2025 09:12:56 +0200, Martin Schwan wrote:

> Since the bootmeth "rauc" is not a global boot method, do not select the
> corresponding BOOTMETH_GLOBAL option.
> 
> 

Applied to u-boot/master, thanks!

[1/1] bootstd: rauc: Do not select BOOTMETH_GLOBAL
      commit: 997c0c45c197dd8bfedc41c72d4579160b018e5e
-- 
Tom


