Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328EDD5D693
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D803C88EFB;
	Thu,  7 Nov 2024 22:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="DgDdEEc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A87988E31; Thu,  7 Nov 2024 20:27:50 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDAD88DDD
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 20:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=u.northwestern.edu
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=friedrichdoku2030@u.northwestern.edu
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-288a6df82ebso208443fac.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 11:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1731007661;
 x=1731612461; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Kf1rLnCxrH6SxCc+3IJSJR5MO5izGDtQbXzWTiuVbzk=;
 b=DgDdEEc1mM3EQhu0drk7IQhxYYuyGhrCYTQRR/mFvsGAIZoJLR738OE6TdQN4wULhb
 x2KiySzlb7lT1sATxkb1/vqMoIfrRvvzEW/1hmZoFqWdPPf7zpW/DWsKdagak8wpMn0I
 ZD8/t+zW+CN9jC7iGIpcnJved5K62wtFaa0KP90ZBPuYfUmqB2UXKUzhyllb2DqTOXIH
 /rYU48pG+x+Vwu2Wlvs6kElxsReNm2bQQ295xJnac+Obd/txKE8qysvn2MK/xLE0JN6V
 HnOkpuiFxrlDPd6K7R9GPruyxhj09dSjHvqrZBiAQYK0IJTEBt/zKNgWZSCnr8ZI7gSS
 Uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731007661; x=1731612461;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kf1rLnCxrH6SxCc+3IJSJR5MO5izGDtQbXzWTiuVbzk=;
 b=KjymsAAHG8cINJ1QbCTCcY5liKmzEYowkCzWJYQaUthlE9YRuKGy7kEzSV/ZoqMjlK
 I7FITU5ShJsK4BqGBnchXlG260rE1c08CeKjTLuCYXiO71J6bDOxaZfTFgOw7GplfJPV
 dvqeOnEGTprz2aZ4lRjb3a7dbggQ+veydFjyZXQFwB1QyKBxJDaXWSD9fCHdToQ09BIB
 mv0lxU8Eq04FgPTb9cosIcFGNqxCKtSWCrpU+DO5UkfXGHTcKPOrxE+ZUGk0hBcwdk0o
 snTyXo1PuH1VOIIukFRKVGXvNp9ziD3KdIp1S8nWhDzx9Y4y7zyIfnuAIVlklvyG7rut
 mkrw==
X-Gm-Message-State: AOJu0YynIi/dZOFJ6iocJmBp2RU7gLiwbrEFMrhMp6LDBzGtyt0VJKBw
 sMBei7jQC6ZuJaio9/5xyqOvhQMoJu5f63tdELoZwgBrknNOB3fYPTStAYq5NUq55MjxpbsDIAv
 q+UgUFvc5+URD6tlg1mtQfA2TbofDTBwDASNyySTcQGOWwULSRZU=
X-Google-Smtp-Source: AGHT+IGAUpDGcX1yaDm0ybpGfCfTRzEuLpCbpqmWTu33Fdaj/N96TC3sTvauHJULwvhIePXQaJy1vX1FRL4wmrFqG9g=
X-Received: by 2002:a05:6871:7294:b0:268:bd85:ff9a with SMTP id
 586e51a60fabf-2955fff9e1dmr10815fac.3.1731007660712; Thu, 07 Nov 2024
 11:27:40 -0800 (PST)
MIME-Version: 1.0
From: Friedrich Doku <friedrichdoku2030@u.northwestern.edu>
Date: Thu, 7 Nov 2024 13:27:30 -0600
Message-ID: <CAD2_vGoJuBnckL1GPNug2Aa3XJOVgO5tknKkLhM=iZduS0hBOg@mail.gmail.com>
Subject: Zeroing Unused Memory in U-Boot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 07 Nov 2024 22:53:17 +0100
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

I hope this email finds you well. I am currently working on a project
involving U-Boot, and I have a question regarding memory management.
Specifically, I would like to understand the best approach to zero all
memory that is not currently in use.

I am considering using memset to achieve this, but I am unsure about the
most efficient and safe way to determine which regions of memory are not in
use and can be safely zeroed out. Could you please provide guidance on:

1. Identifying unused memory regions in U-Boot during runtime.
2. Using memset or any other recommended method to zero these regions
without interfering with critical data structures or operational stability.
3. Any potential risks or best practices I should be aware of when
performing such operations in U-Boot.

I would greatly appreciate any insights, examples, or documentation you
could share on this topic. Thank you for your time and for all the
incredible work you do to maintain and enhance U-Boot.

Looking forward to your response.

Best,
Friedrich
