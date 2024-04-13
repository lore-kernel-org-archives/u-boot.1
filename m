Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAA9C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 12:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EB087C62;
	Sat, 13 Apr 2024 14:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nXe0LZVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0961287DF3; Sat, 13 Apr 2024 11:20:21 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3357B87915
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 11:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=reno.kober179@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e4556990cso348161a12.1
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713000018; x=1713604818; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i98xdCYAX2B1gLRKCvqlPi/qfvcJ9qLutGrUeXINYeE=;
 b=nXe0LZVzlonPYliyaqIxyMrKG+Uq65zCW3EbFLutIR3kO7ajkWELEgWEB93rxGbxSy
 PPrWaDs4EuneU9U0iBw6K0GyXddxYML4vrq5ia99FNlFiRZLgBrZ/HopggXVnARYmI9l
 UC7AOK+rZeBDZiuaZd87FzgUGdxad6zPWqApyuKswgKGeghYumcLTr0VHRMouD8oH+pP
 KySxVKTKjuZz9HaAL3Y+yFlTTfwMR3QD3BdaZ1DuxZMMf5H+dljdOi9f/uyU1QbInYX+
 UJx1P523UL6TXcECdvl/Bl0rKMlR4LiqtwYjbl2Tb11sSgfrsYICIUjqSeKsdtbMMql/
 fiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713000018; x=1713604818;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i98xdCYAX2B1gLRKCvqlPi/qfvcJ9qLutGrUeXINYeE=;
 b=m5I1r8k8U6YvAuIFReo+Ocxz7+sjJ7ZaQBPkXlvcX7/ByLDTLEBfMPLuWrNVqf5SjG
 zg9JKJ4besNHo7RmqwCPqKHY4hbvBdabSYrejR7t9GNVmCC34wvAhIYPrVLlx7E90Bg9
 MvSvdS4+GnYvBGmlOaOM/eUCfoS4oWct3s6Yl46nlKnpzN+rVzqEeKPF/OLOFUip/sXF
 nIxZLWaFOk/fLLV84XGRZ7W3O4cym0dI3n6EiKGhQh1qA49wHBnjkoW0q+f9MddxGhET
 7DWM0tr4DSpyuj6o1GL1s4kLZDQug++tBFktU1lAUqP709ujLaVD8yqk9rmdU8S6GqUb
 CLUw==
X-Gm-Message-State: AOJu0YzriP/L/1NMWdY6oaSYtoqXK7aFdiQD0sa/HXwxXzFav0q526sF
 hNaprX8l6x7O+ZzFxeUHg9eoSoXwMl9SVnUQt7yBH0WhRd5yeiYyg3ti0YezE2NMtQ0mgoNK0L8
 tqWnoDzqRzn2nXp18eWEBqZQxd9zDNc+q
X-Google-Smtp-Source: AGHT+IEhFiCFTW0KMmZvmXZVLSCAXk3r1eUfh4mID4j7ebzZ3c/br8l3CLiSCAkQ/F1o6SnoQnOHj0yIGekrfrdburU=
X-Received: by 2002:a17:906:35da:b0:a52:5498:2423 with SMTP id
 p26-20020a17090635da00b00a5254982423mr102933ejb.3.1713000018060; Sat, 13 Apr
 2024 02:20:18 -0700 (PDT)
MIME-Version: 1.0
From: "* *" <reno.kober179@gmail.com>
Date: Sat, 13 Apr 2024 11:20:07 +0200
Message-ID: <CAC2Z4u92WO3Fup8s5JkupujRM7e6hpnPDn+khYTSSUxK+W0Y1Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] clk/qcom: sdm845: add register map for simple gate
 clocks
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 13 Apr 2024 14:50:51 +0200
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


