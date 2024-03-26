Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263B8C54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9187A87061;
	Tue, 26 Mar 2024 03:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="JRs0r+uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED1887F5D; Tue, 26 Mar 2024 03:49:43 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2449187061
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dd161eb03afso4434017276.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711421380; x=1712026180;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eT0oez/x5TyX46nYiTAuhgciG0nD8e5K70X1m05GV90=;
 b=JRs0r+uhyaoh83Gvq3J/q+NPA1Y6ocpskpYLrRwf/74DfIe0S8eOKFPuX1vPRq66m6
 DjTjyTeJBgFtQJvgAfP841s0pgJ17nqcbFhYs79g3zpkyKnPSc/+O42Q12GbrbkFUUPR
 /4+eA5oW6D56LeHXIs+t2Ceg/1vS1TkZ7uHcahPCHtQSLyuJTA39OqNyIOHhbRp7jLTK
 aJldUrcKKxxH83zYtXmkDIfqqERgA39lMTR+hdzJ2Pk+dP7y+K8+M3v0CuFVrTyqNeho
 Oah9JKAjcYqyAc4tpEE1jxvc7IwwigqbRDGUZJvdLs7CNWZHQGrbQ1mF3GU5ZGpd+TYZ
 /xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711421380; x=1712026180;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eT0oez/x5TyX46nYiTAuhgciG0nD8e5K70X1m05GV90=;
 b=V2Yyr444nq3cUPUjmi0BAGW8DlGHV7o8ENd8AYqCzUUw4SqAOBt4bgTssxn4UhDVde
 CMxE623OexnZMv0cbiwWlLtZHKCnnHZERECcKQx+hZeqLThTC9o+ANA06OHwM9FBsZRc
 +k9S80bHHtkbsaNU0hBX2KM72vviLI1tpYPrrp5lGz9SadNWw2GsiN78K3yBZWmkWyR+
 3Nv1WvwlZ2U4bNWjA1jmoOX1xRFwyEKXcb0mrvBRmP3kuNkwS67UKLL4iyQ1mt3acxyo
 M6nzgblMvH0C+d9jss29+cqcsV2yvXH3XezAbKg3Z+e96DwQUnnMcJ7OPyQ6kSQLzFzW
 wBtg==
X-Gm-Message-State: AOJu0Yyky1JQFZfiTopmLEk9ZIfnGDnIN8Kocqn8sIMKG37YX4a25xjc
 iFlNjMpx9q935JgDFcx5C10NAT72nzNOfapelAEn8ZSLz6WULiy2Ml0llwH7ospb4j6C0iUvrtg
 odEvlpP4DahvGGdgs2Jih9ZkiEHD3nSoEDlN/970rUgH4cz8=
X-Google-Smtp-Source: AGHT+IHkxjaK0V1MkrHuRIxFpdANBF56Ngx4lK4eRqBQe8Z9tsltIKY9F0dnfa5ixNAXQ2fO7I+ZI0F6/eAXkscs4zE=
X-Received: by 2002:a25:a89:0:b0:db5:3b32:b1c3 with SMTP id
 131-20020a250a89000000b00db53b32b1c3mr1484507ybk.21.1711421379948; Mon, 25
 Mar 2024 19:49:39 -0700 (PDT)
MIME-Version: 1.0
From: Greg Malysa <greg.malysa@timesys.com>
Date: Mon, 25 Mar 2024 22:47:30 -0400
Message-ID: <CAAjXUar=97omadi8MSLox5V_iCwix+YSUP_fMCGsLhUzUfBpcw@mail.gmail.com>
Subject: Upcoming Analog Devices SoC Support Submission
To: u-boot@lists.denx.de
Cc: Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

I wanted to get a little bit of guidance before dumping some patches
on the mailing list. I've been preparing to submit support we've
developed for the Analog Devices SC5xx SoCs including both core SoC
support and specific device trees and defconfigs for the eval kits
available from ADI. I've submitted several small patches to touch
various shared parts of U-Boot that we needed to extend to get this
hardware running and to get some familiarity with using patman to
format and submit things, but now I have a roughly 15k line changeset
consisting of a new mach type and all of the required drivers for the
system. It's broken down into a bunch of commits: one for the mach
type support, one per driver we've added, and one per target board
supported.

What is the best way to submit this? Ideally I'd love to get feedback
on individual drivers from the respective subsystem maintainers, but
it seems rude to have a 20-element patch series that gets resubmitted
each time feedback comes in for one component. If we break it down
into separate patches for each piece, what would be the best way to
ensure that all of the dependencies are merged in order?

Thanks,
Greg

-- 
Greg Malysa
Timesys Corporation
