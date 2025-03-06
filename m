Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A210C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD1E810DC;
	Fri,  7 Mar 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PmaP6q8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240DE8122F; Fri,  7 Mar 2025 00:23:07 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17EE7805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f6c90b51c3so12136347b3.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303383; x=1741908183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fhsGOmx1ekK5+OcCPQMUPnHBaRza3XolA51JWizVZIA=;
 b=PmaP6q8Pjoh1/5HEMyOlCXbxjxbSiQRuUsZom1OMmAxa+Lj9zoft3ii+W9gL+5Rg+H
 vRWHChxWwGXPH0wVzcpQ2VyNaBZ3bERLu4iYY5ndv54zxtJ/jUIO62Bc3iHUh68Ji5ik
 Ip3qGa7jwbZtTpOmBzhtvcCy4tA98mN6rhCw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303383; x=1741908183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fhsGOmx1ekK5+OcCPQMUPnHBaRza3XolA51JWizVZIA=;
 b=lubXrxqqrPl6fXuYOO6rMTgmyykrNAMg3CY74pFBWjqmbhNnf5u/X5RcNcYc0tloIP
 iKAyL8mYNCMfJ3kw25CDGYeMACSaAwYPsghuMn4GurLmD23o3b7XA5VhhDC8psGC5CO6
 3WicFPI+AK2BWlzhCFlcFwPmRpWBRQf3t6uLNHd3v5kEnJ26KN5BhEs+gwwqXFYXPPSZ
 XUv3vBDrzfAS6DyyLC0mmBckXF/vre9DVHaafH5flckKW/jRjKmMIIfPLJ117yFl0eUI
 92rr1XHNvTQk8yx7N7nxjyCspU3ol9V6XpOGq08H3m9FfnDUMhTyZnQ8jCEKRfAzZN/y
 dvIQ==
X-Gm-Message-State: AOJu0YweK7E2O1zlcQErz0GpP9uwMDomIwL15S2V/GiAqgU4ESYEQW3j
 kCPEfJyWUKJVw4w+YCieiINDlA88we8vFJki5O8AlDuAn9EoMmjdKGyAZI3gEIEqV6UUbv2Jow+
 7
X-Gm-Gg: ASbGncsAiBCCA5LDXz8AMmGsOdA+F3PgA0lXpLGCU4eVHZ+Tzy5oK7VkXFw5sywNpFD
 s9aJ9tA6GzyR3acsCRkDCB7mnzbNYWvDhSN0XXnMeHg9eAisbvRN2CHMQOWkJnPUtrT3POGAcSY
 cDijwal6HZLl/WeNK8k68aamNUW8LdagU5SZUHNxVWwyhr1OJ1q5nXPcT1htBddfYRJHMyR+RmD
 pt5rALEsBaeHSknZZdvfWI9jHxszCPefBLaQcCXgqKwuZ5zOrQuEecPhyOy42IZhxNjuX2/k8vJ
 cu7xXkGWXVs/4wes7MOxkU1Nj4yRTvknsqs+TC/wCV+1haig
X-Google-Smtp-Source: AGHT+IEAf8nTh09G9D3LKkBAz6jtX2i/gWJlsoVyO/ZlRbkuCShDrHZ/n8vosBzDoaTG3lTFIqnYlw==
X-Received: by 2002:a05:690c:3603:b0:6f9:aeee:8f1b with SMTP id
 00721157ae682-6febf3e0495mr20715957b3.31.1741303382865; 
 Thu, 06 Mar 2025 15:23:02 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.01
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 00/10] Improve pytest runtime
Date: Thu,  6 Mar 2025 17:17:02 -0600
Message-ID: <20250306232256.4150882-1-trini@konsulko.com>
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

One thing that Simon Glass has noted is that our pytest run time keeps
getting longer. Looking at:
https://source.denx.de/u-boot/u-boot/-/pipelines/25011/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
we can see that some of the longest running tests are a little puzzling.
It turns out that we have two ways of making filesystem images without
requiring root access and one of them is significantly slower than the
other. This series changes us from using virt-make-fs to only using the
mk_fs helper that currently resides in test_ut.py which uses standard
userspace tools. The final result can be seen at:
https://source.denx.de/u-boot/u-boot/-/pipelines/25015/test_report?job_name=sandbox%20test.py%3A%20%5Bfast%20amd64%5D
and the tests changed here now run much quicker.

-- 
Tom

