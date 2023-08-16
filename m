Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3967CC001DF
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FBE869F1;
	Wed, 16 Aug 2023 19:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZJVwXuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D55386A00; Wed, 16 Aug 2023 19:05:44 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9582846EE
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b95d5ee18dso102509451fa.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692205540; x=1692810340;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WbmfiOFhYKK3BqdD3JEj4MvCO3avQe9yztWlbH9waKU=;
 b=lZJVwXuQ3w0qu6q1VJbdMoYkpsl8TuAN7XcLBN85Lrgdz2Kjksm/ouYRj2XejCZc14
 OOHyDennFdECC5Hr6AQd+sSv/QjpXBg9Nt+PfKt/9goKgSgYn8uAF8Sem05+fHXesHeL
 AMPCcFrGY1HohzNK7xOFY99mXH3pB/e9dZ8Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692205540; x=1692810340;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WbmfiOFhYKK3BqdD3JEj4MvCO3avQe9yztWlbH9waKU=;
 b=jBbf8MBLsI+YdZAgt6+3f3RXyO83s1zrQBo1s11ootIsYNJ8wq+JGP7W46yxPLEdNF
 N4u3YvB9PdRR2tUUa9pwUHhWekOPMLCo+l0nAAHRnhjMuKCDJ6unncQxP1UgZ2JjjDGe
 k/o3GEXg9BCFIvSNv0VyiN8Cg/BC9uoMXypOF/WGq3THbTy7k8BCwaIzsss4m55uXb2i
 +2sO3vCjp2VJ0dKwDv2fsqgkbS+l73BnNbmQ23NF72GIM1vRe1t/Q5/qCxPxa74t3HH8
 gLEEksbYfgOb9fZm1kDdBQClttqJ9/jdniJThyhzOxHkBgW6nuK0mV1s2WR9UIEDV+8d
 EzZQ==
X-Gm-Message-State: AOJu0YxzXzmBg4A3/1Rshw/Wkq8yQY4llO3kPhs/LArkkKnbtijj7cNe
 8t6QVhWIq6gCbWMN2MgYkZ5X+2Jwpdolr4oAn3cv5w==
X-Google-Smtp-Source: AGHT+IG2ahssO7RBaPtmsOlM7s1lEgbmW78mZxiSZRm6diQtrYydF4W++n84eRj95mqP2vmNrD096oU0wul5P68uz9A=
X-Received: by 2002:a2e:9f57:0:b0:2b6:b6c4:6e79 with SMTP id
 v23-20020a2e9f57000000b002b6b6c46e79mr2138320ljk.1.1692205539879; Wed, 16 Aug
 2023 10:05:39 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 11:05:27 -0600
Message-ID: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
Subject: Doc style for method functions
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonathan,

I would like to do something like this:

struct part_driver {
   /**
    * get_info() - Get information about a partition

              ^ causes error

    *
    * @desc: Block device descriptor
    * @part: Partition number (1 = first)
    * @info: Returns partition information
    */
   int (*get_info)(struct blk_desc *desc, int part, struct
disk_partition *info);
...
};

But this gives:

scripts/kernel-doc:292:
   print STDERR "Incorrect use of kernel-doc format: $_";

Without the brackets on get_info() it works OK. What is the purpose of
that check, please?

Regards,
Simon
