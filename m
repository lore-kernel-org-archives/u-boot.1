Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C653BCDE00B
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 14:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EA588CD9;
	Thu, 26 Sep 2024 16:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X8E2z3U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497D188D3A; Thu, 26 Sep 2024 16:14:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4888F88C91
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 16:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso4815805e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727360084; x=1727964884; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbvIVi1R7K3PJ3l9x2xuORpY5Nsc4HY9TpX0U8J8Bbw=;
 b=X8E2z3U56YcnmyOVC4x0bU/gwwwMS8gBXTKZ6DoAkAvwptMJ6y4nVtDBdRs/6zm6nt
 2Wv40NaOebhMXNNcEtZCw8G/y6b1qyObF3Y01qFWeKTOIktatA3x6UgFutl+lHUjixw2
 juCqpdxyfw3Rqiuj1S4LCJjObcS0yIKhx8aoLnTgLSoyDhdU/KKufWOdWhMYKgBTgble
 +ZE7j8emtB2oUhFitAMsAAvRYGvFbmNyqdoQyDDCCL1wORfjGrLy/XZcJr60AQeiZGok
 Ywzmx9y+Vs+4d+wIoVf6vSelDKk3Jdgtvyq+flvexAMeoyBUzKo4oKUU0faJ+7t9a7Q2
 JU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727360084; x=1727964884;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbvIVi1R7K3PJ3l9x2xuORpY5Nsc4HY9TpX0U8J8Bbw=;
 b=t6theOocMXPYAufk4eU0It7X8gG3ZHt9NCIliUYJj3bDcW8QfI6QpyXLeXnZFJ/cfA
 5In/uW1VJKVEZeSPl1fAzZyEsVFl0US31Wc9/pdsIQJjqmwYUEWJVXSIiQpS6f+e72F9
 6uRpg2Ibq8k+wRDz0D1QQjSB9uxBcY4XZUCdRUXTIp/F9WgUJcWKIVHi6+JV0BtVThac
 HXzuseoU7ol9gw8VJbiMi2pgQMtwilXp002MeC16epxsEmeWMpU2rZ3KYLOB4bpAH4T9
 tPgcYz6evpqigxYKjdEw5CoP0/RjcJNzdU8p5VqrtoeR2uq6BY9E1uLpy1FkC1wKaTys
 Y7Wg==
X-Gm-Message-State: AOJu0YzKzbwtmfynPisI2h1kBHPsm+1jBu9NrBVMVR7rbFn9XTX8CEha
 cCNaaU/BeW/k9iME686fGUyf71mcQblP0TLQnjABIiHeff9OR3dL2TNtXw==
X-Google-Smtp-Source: AGHT+IEfukcaf4eNhsqYIcwB3CRlFdvPoZ+mFrE2RdOZpckb15rMDTa1zjln+v93OLbzV8GM2ijgIg==
X-Received: by 2002:a05:600c:4f54:b0:42c:bd4d:e8ab with SMTP id
 5b1f17b1804b1-42e9610a65fmr60294445e9.10.1727360083364; 
 Thu, 26 Sep 2024 07:14:43 -0700 (PDT)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2f983fsm6557254f8f.66.2024.09.26.07.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 07:14:43 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:14:41 +0200
From: Max Krummenacher <max.oss.09@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>, max.krummenacher@toradex.com
Cc: u-boot@lists.denx.de
Subject: i.MX 95 support in master U-Boot
Message-ID: <ZvVsUcglRde5nZsD@toolbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Peng

We are working on a i.MX 95 product.
What are NXP's plan on adding i.MX 95 EVK boards into U-Boot master?
Thanks for some feedback.

Best regards
Max
