Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74265CAC59D
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6749835C9;
	Wed, 17 Sep 2025 15:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iDyjvar8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8794F835D0; Wed, 17 Sep 2025 15:47:41 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65701833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so4699669fac.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758116858; x=1758721658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u1Frk3u4IrouKT9l8xOtWgcraTbYvfIu3JUygycWscU=;
 b=iDyjvar8PSqRd47AJ4XmoeqRc23PBJ3Xnjl43uDiip5FsIU48xQIlWDd+CmXTcgN9B
 jYwUgWCcP21n5T56SVMSKUd6TSCzTvrwX854T+ph2CbdJwBTRlZOf5z9R8d0xRoeJAgX
 Na8/OLFEEuJOyRTAU8GSgD0me2nopnrJYGiLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116858; x=1758721658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1Frk3u4IrouKT9l8xOtWgcraTbYvfIu3JUygycWscU=;
 b=Jfis4kJrAShhA3ITfTwH8ClFPcq/e/QjKDc+gqeJHBNDd7knVuaU0zxYHJ2mlYI0U4
 v3W1fQoH9TeqdKSTA9dwtcKbxX71uAwGYQZ3zgVOcZJZo6BrHx77DjJJ32O8S4tcnfAI
 vqHMAb3ukPrM6NzTKi7Hl8Z9i+ClpPd+FhrbsN9GDdLnKaY9BpTNd04vx7Q17+Z4/6Aa
 LF+i1phN0rLjRQeYumXFiUadDimRwxA5Qu27STghDW6Ukw5np4SEwcrq+BpEycFYsXWG
 nYu2gQbmDUFLeUEWac0iOy1efRyCBzEzEX2asZo+iGMNHnRGh+ir8xwUpypCI5sDJPw7
 YPwg==
X-Gm-Message-State: AOJu0YxsAJU+eYsmlMTUdZDgfxsOtKAFhL0Ob0J+48jGlBbor0JjpzDd
 dBSdVkaz3FjXyjYty+LKD1rBUbov10V5FW0KSOx3m1SI4jwKfcJGLuv0m3401gWfbK4=
X-Gm-Gg: ASbGncvhd5Wtw7UeOSoIxbx1mYGAjoOqU/ko6+lSD5+ABIG2WWMNA/yS3lQQ5nFXhYG
 NJ8lbcQz5zQ+iMhECFeDfH0b/y8n9tja44ymvaCii2+SnjIECoJp07KSGaa7gApjqO9118JWU7w
 eRZGYOWLOiypXVsZYlFegPFl5sCdFWd2HqBwmpsnKlPoRw62wqqXyCXvU/4CIKFJu6tsdc1W/nR
 N6//KcvypjzfLPn3NX9S/K3USj/EMvsh7tGOsdkV5N+R140uZu55mG691EAPQD4LAMlt4bJ+u8j
 iU0bNuK4rfZ7q1TREMq0GvbjId7TXOqBmuIgxVo6fvOoEt3zObDoxMoX00B/IX/W5WdgXlSa9O9
 W3MlvloEPwBVErI00Wlj/+9tidkORn6CI8Ox84kh3MDtYTOKWigyZcIQ=
X-Google-Smtp-Source: AGHT+IHq7K+47pS48MKTe5Ghk99aD0VgSVPyV9R6Je+W2HuD67zgU+ahXXXtPaeumHJJ5JjOLiZV9Q==
X-Received: by 2002:a05:6870:c086:b0:31d:7192:f695 with SMTP id
 586e51a60fabf-335c0149dfemr949475fac.51.1758116857483; 
 Wed, 17 Sep 2025 06:47:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7538127f35dsm4799937a34.35.2025.09.17.06.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 06:47:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250906000129.284428-1-marek.vasut+renesas@mailbox.org>
References: <20250906000129.284428-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] thermal: Sort the Makefile
Message-Id: <175811685632.752169.15330189859823061162.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 07:47:36 -0600
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

On Sat, 06 Sep 2025 02:01:18 +0200, Marek Vasut wrote:

> Sort the Makefile alphabetically. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] thermal: Sort the Makefile
      commit: 7be74f63f7ebeec1665a4f0f1cf3e41c5444518d
-- 
Tom


