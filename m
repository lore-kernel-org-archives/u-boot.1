Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E826DC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1B280104;
	Wed,  5 Feb 2025 01:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eCJaMvdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC87B80A09; Wed,  5 Feb 2025 01:07:51 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610F98096D
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5fc0c7b391fso1487732eaf.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714068; x=1739318868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N5270bZfFaHTclWuyxZjs+y4pyJDm5omztakuccTanw=;
 b=eCJaMvdmZ7SU7GV3LzyPx/3fnrBpRh54ckYXiSklDcSp2NqndZFCkgCBRdbhci4vPC
 n5u9yWA9VnVZKV6Zwf0TcJdbFyKRI/2gSnzhFqWEtsXBOEaN7t2LIa1mkSbczchGRtQk
 g+Ogr8+Bs6AjqQCgs2CTMTlWX/w5MmGU+gT2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714068; x=1739318868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N5270bZfFaHTclWuyxZjs+y4pyJDm5omztakuccTanw=;
 b=p1eEj80/bRmQFQCx0+NMaXwm5WPwKsqWW7Hw9Z7rF6ZQtrJvu8vmzFiTP+nsm1zAFY
 tPuW5bGVze5xNeMMSphotJj/UXyTOnhH9REROrBTIO4XPYJxXZ71ajw5xZjN9TP7y7W0
 ERaJKoHOJBig+WN3yp7T56jrFILW70uTRRpuDk/4F5fjOM1TlZl9tBtuOLG79AM+nxLm
 aRwWwIR1qtL/Fc1NdwirffS9QakVMi1pImM5HBK3Lkp03/OL2H5nEBzUfCcASUKdQvYi
 JP/vfoYJ3edmTw81UIHMkKpRAWichXDHo0wujxwj+xrlHZHLQF9DNZo2sM3hgfR4lwvW
 j+6w==
X-Gm-Message-State: AOJu0YyxSYgz9YCqQRgfseF+xLtQdCixpLPnvPJcRU45qtO3CN1kpo4d
 sjfqHxceT1lFkeopZQ6vrpA7y6b+KvH7FlNFtF7lYGze5OelHGNI2sKmcb+uEoOiMUehh7/ZZBP
 6fDc=
X-Gm-Gg: ASbGncuxKZF9sCBd1qVfxOmMHWK/EWJDD91f1VLBevd4ywfi+p+La6tWPVdudCV2iLI
 jmab+vtAsT9UViEHS4tUJoWNH3jAqlaHuFSDGwgBTbNoUUXQTsA69Cm9np4/ciTj5UmLbVRzGeE
 o+hePUkopfhpro0XhYJFN/83dHzSBw31IXPsqm9DfUj1fg9h89NKK/S5m7XRgjQIlZQCK9oDJRk
 6zPytMDGSYjJNm5NGLiEgKjtNKrT0uSFz+VloAw+QPlRXQuArQFf1iqeg2YVdUQrC74P2KmyExS
 5fjZmYKCBA+2DpVntA==
X-Google-Smtp-Source: AGHT+IF4FkUSyuLcAYu6Acg05FT2W+Rjg33oSJY6Htey2aTuXQfq5hDQl7S3+/+OSgZNlaFirv28sw==
X-Received: by 2002:a05:6820:4cc8:b0:5fc:4582:42a4 with SMTP id
 006d021491bc7-5fc47910e6amr661361eaf.1.1738714068017; 
 Tue, 04 Feb 2025 16:07:48 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc105d40b7sm3428552eaf.36.2025.02.04.16.07.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:07:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/6] Rework requirements.txt files
Date: Tue,  4 Feb 2025 17:12:03 -0600
Message-ID: <20250205000743.949790-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

A challenge we've run in to is making it easier for more people to use
various python tools that we include in the tree. Part of the problem is
that when we have a requirements.txt file, aside from the doc one we
share with the kernel, I created it using "pip freeze". And while this
might have been a best (or at least OK) practice at the time, that's no
longer the case and is why our files have so many things in them. What
this series does is create multiple files, one per project/tool and then
has CI install them as needed. There's a few places here where this
means that we update the requirements as well, but we keep a few big
things where they are currently. This is because updating them
introduces problems of their own and delaing with that would best be a
follow up series. I've put this through GitLab and Azure to make sure
everything is still going fine on both platforms.

Link: https://source.denx.de/u-boot/u-boot/-/pipelines/24468
Link: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10505&view=results

-- 
Tom

