Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61093C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311C082CC9;
	Fri, 13 Jun 2025 00:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="adhCOEoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424A782CA8; Fri, 13 Jun 2025 00:15:31 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A9482AA7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-736f1953673so427810a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766528; x=1750371328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn7KBSn3Q1j7w6JvQzxN7ZuFgXHwEubgBhlP7BAdJJc=;
 b=adhCOEoMo+Z2os9FjD4GzjNTrY3wIESjfTbD9iHTxFyKr3wi0998ApkuQ+VdZhf9IK
 O4JR8b01w33PImM3eFu6Sw445OS0kfWmkxzrdMl4Hq5dQvF08AlTDcju1krwbDjn8Xmx
 c3qwkkR/ddpq48tHiaH+mFuxSe9iB0OT0tSEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766528; x=1750371328;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jn7KBSn3Q1j7w6JvQzxN7ZuFgXHwEubgBhlP7BAdJJc=;
 b=iLVAVIUe86Pc1sj8aK59R0QKszlddvG99cJGLQaKajH6bpT8FJjWg0tOZF7uIArwtO
 oPKGQLKBdIHUW9P1fyMxuqYtws5C8JrEHzRoqAitVsoh2nOCVKZBDTrl1bu/ev+qDDu1
 B0zYE+orRp5t7vD8eWSMw2Te1ECzMj0SoEg5oXsmWhY6D/m3t5CrzMDvroeJocgddzZh
 hoSdMwUywhW5IombedYUshuFD1yB8wLXvIPzv/Hq44R8hneg9F5ExY1E/lLcf4E+1/rv
 aAP5RMKmXgW70L+6KuGPodWg2tDzVnIdkdsgCaOKv/1KHEhIB60ADgYx1eXMA7JtdIUv
 OMKw==
X-Gm-Message-State: AOJu0Yw744/MR8k8gebrq+zdPt+Eum7eSsAS8ODRJJffvgVuZO43sJZ8
 CelajisCxOP60PVaCXjecSsiqT37DTXHnflp3lRUBG3Xw1a7OLrQ0hLYyPLAjXidCNw=
X-Gm-Gg: ASbGncvtyQRJGPiP2g4/TXYnzH9wmkbUBl5ZIqiklW4frkL2irk9FWFGOw+zDz66dUf
 TC2Y7xc6as0uTCEDIkV9xUTxKBi+htCt9PzSFbzvPDQhCeaEfQd61J7WhYbEcUDGP2cQHXyOyHb
 eeyPwLvViSloMIAsaCoS11uDEHFViFcP4Pw89MVAg/Z1WMP18kDgh73043Ry+W0OJ0rQiV4jCTh
 MT/Xa7HEvXKHuGa6CujlAbLXd8jf29GrEXhN2doCK6cQ34ujiSXNwZqLY9GMIFazwQYzteG77aP
 tmpVqzSbOFLD3+jh1O1dLeJlOphkZbgTugsnIBUQ61RgBR3iBUE9SSDe+rXC+O8Gy0tH+os+ry4
 eKELlMt+aizXFDG1UngCFerC6wAMwWMbZ
X-Google-Smtp-Source: AGHT+IGF2fkBVxTnflnyjhLxtfCDY+iyoXQLCHZGeo5WRVrxsMJb44oP/rkqIoN74eE85WWlbLq6Zg==
X-Received: by 2002:a05:6830:638c:b0:727:36a0:a2ae with SMTP id
 46e09a7af769-73a27118a28mr319903a34.14.1749766527921; 
 Thu, 12 Jun 2025 15:15:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <jj251510319013@gmail.com>
Cc: sjg@chromium.org, richard@nod.at, aristo.chen@canonical.com
In-Reply-To: <20250602021818.2277-1-aristo.chen@canonical.com>
References: <20250602021818.2277-1-aristo.chen@canonical.com>
Subject: Re: [PATCH 1/1] bootstage: Fix typo
Message-Id: <174976652671.365589.18370859649124507893.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:26 -0600
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

On Mon, 02 Jun 2025 02:18:02 +0000, Aristo Chen wrote:

> Fix typo from heder to header
> 
> 

Applied to u-boot/next, thanks!

[1/1] bootstage: Fix typo
      commit: 0805e4648686d5aa50b3990347b2b9f41dd42b3c
-- 
Tom


