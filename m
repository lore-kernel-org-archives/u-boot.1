Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF85D29C28
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 13:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07400802C1;
	Mon, 19 Jan 2026 14:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IhpuzLyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DC183015; Mon, 19 Jan 2026 12:26:21 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA43800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yannaboinashivaji@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-78f89501423so50180197b3.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768821978; x=1769426778; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EG2nSk/ttWDcd6dU8o+T11579wBedKTnU6+6cpazwaY=;
 b=IhpuzLyP9PlLKhfQBgINSPporyXcCfiqfgFnrtJoozWQ8SpWbsvK4U6dvTgvk1I76f
 eD3odtG4mgqo6famD5C4rGFGH7k5rYL9VzVf0cN6qBXJBTcaMgztXY2JA/IMNYcSv4EV
 nNZRlkLfqqxKRIV/TpU+K1TX70xF6W5f+6oKIcL5VHkluLR5TImQtpdvP9FzpOHphdzG
 8aI1L2xS3wvLy3CUuX2ngSm8XyzfGmPWnkVuq21QEKagV8O0QZrvozgT518tBG/fXAm1
 x7sXvGoARzTTljwYj5E6bTlcuZ+Kh+tiVvvcL2dreRmOOFmVqWmx3QGbOtR/DWk438AK
 ZjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768821978; x=1769426778;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EG2nSk/ttWDcd6dU8o+T11579wBedKTnU6+6cpazwaY=;
 b=O9EwXAQOaUi08KYsP7P+pMmWU+qcY3xTqFrViIGVpv+PwnXgJC478896eBcajxjfzM
 p+0lKgHpD1x7pguaRYXZSTRfXiFw6V15ZyMtxJYop6WDrUBz2IT8eTzZiUwQKzi39hAD
 gy7chMYWs+2+Ya/gRQfiQ146mhG/kLPck+sjqR53JWnq2xSQEk5Z3PByQwIIpwEbRFeA
 mWLXSQIXz/UgDbwv+VmRxd5ahT202dZJs29zN4zG9/sc3KCrxHdicUD/d8knRcd438bH
 jB3TJoOD4cBrp4blWWLaBqzRaY7iUMezowEQF1boqyfk70siSoStCwKVDfVnrkz3CFuU
 J+Cw==
X-Gm-Message-State: AOJu0YyGSvhVvQgANlV8s4bsPPR0MlHhj2MH6Jq1GeD+Xvz6GVAAN58Q
 8uf1f1Jvn4hVvdnHIT9xvuewh/yhrSawHuaomLYlpRC+/G9FrcSwRon3SPZhLSBWIHeGuPpZogk
 dEg8i/BsyDbkLEmmNanPagRooMXFRPC0fNA==
X-Gm-Gg: AZuq6aKVt0+IYJcYIMYeDA0Kj8eVzfZ4p3etzMA6LWRvWPA4uOfWqxKxt/ztRVVrTKJ
 MmCW6tXcHKwoftZ6lNYkubvCmJBE3LyLJSHp5/zqqdnDzvQbUtKOCTkSA6L6AcrrCMcsWl9kZQ0
 jC1riInXbzl3mY5pQes30jupD8JyDwWT4DkXkriRXLvimIUzMxM8CpeCPekYAj2AGGxbSldp9QH
 Bm3r0k6XrVrm93vnmdG8bTot5JEs/2MSk/RpS2taa+/JMwHW+3lgUkfhfRhINI7df/lgDgC/l36
 khVnfnDkEsJDPZA0GhoDkytVgz7FzRKMFdwNAp9D
X-Received: by 2002:a05:690e:1919:b0:644:7b19:c207 with SMTP id
 956f58d0204a3-64916b7d34emr8004392d50.38.1768821978171; Mon, 19 Jan 2026
 03:26:18 -0800 (PST)
MIME-Version: 1.0
From: Shivaji Yannaboina <yannaboinashivaji@gmail.com>
Date: Mon, 19 Jan 2026 16:56:06 +0530
X-Gm-Features: AZwV_Qgt0DtdzebnKfwtxdgxJ3n9L0iLLa4NYN6-03-qC1VFSEHyog-eCUpXR5c
Message-ID: <CAK-N3=PeoVkJJkcxVvGFK3An5-uGTxszt6X1HtAPPSN2m1U4NQ@mail.gmail.com>
Subject: Raspberry Pi CM5 recommended upstream U-Boot baseline
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 19 Jan 2026 14:57:40 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

We are bringing up Raspberry Pi Compute Module 5 on a custom carrier board
and Evaluation kit.

Could you please advise which upstream U-Boot version and defconfig are
currently recommended as the baseline for cm5 support?

Thanks and regards,
Shivaji Y
