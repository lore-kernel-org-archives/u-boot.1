Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D14C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 19:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CC980214;
	Thu, 23 Jan 2025 20:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aM3L4VLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92AF080243; Thu, 23 Jan 2025 20:04:18 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35EB80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 20:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flobro30101@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb8accbde3so1274944b6e.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737659054; x=1738263854; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gQ0cVokRhmiQtwCBJgjN3L7bymM5f07yokZLFrIOMuQ=;
 b=aM3L4VLmrXyTa7ew1n2KmFtU1HNLLNAlTNteeSWrzLr6DmjfL0TdSV+KgUAs5Jjoy8
 JhSvqz4yCnKDSYIRapt9U07+kkEWM4xP/NmpGUcM/lfVUobIGxY9eorOUxd8rdYy+Ma8
 XaUhNAY+8c3qHxtWzVdyWLcAcSoOU/P0Rabisx26N3d7XLXxHqSOT4mDgftJDCMyrUzA
 AX7fspWnwtW8GHutKPPejj/6pF6Ow9ELN/0h1tCIWUxA0lxFNjbqt7eMW9OVanEhBrdx
 AOk20opjLU/x3kZPvJo/hFoh79kX9eI8eVgLzmdMakyNMVcbcnDSBW+K9sVKHYmuyeY8
 zNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737659054; x=1738263854;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQ0cVokRhmiQtwCBJgjN3L7bymM5f07yokZLFrIOMuQ=;
 b=D88myAJ5gGeOMROZlKZ7T9a7RuUlk89bWZXoKuhyqVleMpe5cStNTg2pb0VsniZ7sU
 i9yFQYrpwjGZKdM6EjJspQX4fhxnHUdUNEd+K7LoJJPCZocIUiHRSDx5Gzcm80oQPTLo
 h9A6lS54Egb2qcjwD9j0Jw/5K8rXPhHD5dORwe/u9IjbL7As3Itt7MYTXp4XHfdqJQDI
 ynKqHi7Tw8ReZew/judi/Pv9WGcxFfmduj2471I0jMi5PJS5B9je7hXiKP+19knzmZaj
 W8Q8TUD3PAVSVhndDSIh9sf2zIxBeX3y5vss8AbW5cX4LRN8gpIFhJY86wLd0tRhQwLd
 Dk2g==
X-Gm-Message-State: AOJu0YxACiUA3NKMQNzUgiquklZZkXyqidFV9c/9nB8l7Muapx/J+uRi
 czJ0SEKz/k+HASWNA6X5e78nxzcV8JRFgG6v30pMD3fyuzm43ylKT1MKjyMziWO5+vWsVZ/4U1S
 k1Uqhb6DhM/rfHNaHBtYloKfD4yTMZQ==
X-Gm-Gg: ASbGncvt4QRKuKVF0vmawGLK93w5nP6pJFQ+qjLJ9Fsw+c9Sue/1L7dIgxw14YvHpVM
 3eyyemQFOsbTrTeEE2DClLCXF20EUnEICSU9XOaOJMIl1QJ9Vb/w+QgujXJZ9mq3IGs21PEeJHZ
 E5qrlEkcVshKcU299P
X-Google-Smtp-Source: AGHT+IHMlHTgf/MvvzbM5FTZhLoYEsYgVt4QwD+ZncyXvBiacFWhWe3/AIaklsR5k1giemo6FyV46n/WhIP6QssEXQA=
X-Received: by 2002:a05:6808:1b87:b0:3e7:bd4e:5b98 with SMTP id
 5614622812f47-3f1e4a77e4cmr2900444b6e.0.1737659054172; Thu, 23 Jan 2025
 11:04:14 -0800 (PST)
MIME-Version: 1.0
From: Floyd Brown <flobro30101@gmail.com>
Date: Thu, 23 Jan 2025 14:04:03 -0500
X-Gm-Features: AWEUYZkdSTAQ8VwVXCBleShZSqLKy6Uf5NrrPy0B-3VluZB5Bo8VO5AdrqKshtU
Message-ID: <CAKiD1a9bH=0N3KZP6Hzbvznhueqb-Oob_zvtGky+g-EEix2+gg@mail.gmail.com>
Subject: mkenvimage CRC does not match the CRC of fw_setenv
To: u-boot@lists.denx.de
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

When I run the same file against both utilities, they do not produce
the same CRC.

The CRC of fw_setenv matches what uboot has when the environment is
created inside the image.

Is this a known issue? If so, I am sorry to bring it up (but maybe
remove mkenvimage...)

Thanks
