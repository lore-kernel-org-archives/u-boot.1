Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3BDCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC07483EEF;
	Sun, 14 Jun 2026 14:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J1ku6KNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDC183FEE; Sun, 14 Jun 2026 14:25:44 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A42A800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso3379710a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439941; cv=none;
 d=google.com; s=arc-20240605;
 b=XHb7iCMpDbuZJ1OAwdjLKrmxVyZvVrqNaCzSV5o0loGXRFZiHFxW0Ee+W0O3jG98Q1
 zPEXbcK9cuoa8omNLgZwWYygSee1ycgyDe5XENKi5rNm0D6K2jRSHgSOh4S82GsaeBQ2
 AwpMxEQ07YoijPuH/5q5RTYewYnzRE3gwEsmA/0DtbtJuyzOd0fq6nTBq33oevsMLn+C
 Vf5icFn8kOKcvI+QfyCsS3ag/JrCkAaLsTutoYUkgXoQRi6D1mW1Jls15Mle02wdYClU
 ngSPXjXao0n+R0xrlPN2l5jJ/wn/bP9MYq/neJr4Xa1dKyTR+FVVlL+XQUQbnMcjxsfE
 d91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vU3Sr5awQLwGjag2+tkXE3rceyxxmz817PwUBmvruZw=;
 fh=PKLU0xSNpsrGOfl0gQ17G1VaKViMSq+Ysfr2F1w3zVg=;
 b=aP7o1M2r1634iyflTuKcJeISvx4xyH9+DQo6dtFMRYQt03xi2M03ER8JwX9Zdkkci1
 LujfsLn+uoZIuD/Y6iWQuFQRa2t2pBICkJEFpjXRnEsH4LkkmvtxLzwQdGCrEwOQB+zo
 OLcyOFSaXQP0cqnZiUUVWYxJ7YCe+P85CLg6TbyataD+5RaHmdHOxE6KsU4cRVX9aNVm
 D9uvmIfh2wWu3bXjowPjvoEI9GebWtqqDBQy/JM0y7CQx77Exi6PwdpRSKY4kmJybj23
 Lf8iXnzytvRH7oVLnc6NZGhsLQiQrAEwiJDU64JbyJIhau8DUpTCqvYLWyLFY0ohM0jS
 g9gQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439941; x=1782044741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vU3Sr5awQLwGjag2+tkXE3rceyxxmz817PwUBmvruZw=;
 b=J1ku6KNNvXRaiRsLsh52URTGymAPIIBODthJWAVBYLaOu5zK685T+5LdPAOmiaOmF2
 +mnmyOLxaqx+sMrG/bSPu7+9T2NW5u3toFj0BrYyWnYoehVPpXdMXMQypKKelnoCq4WR
 roVmeTWIgrdsPgCx8CuVjolOI0R3fy3hWBKfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439941; x=1782044741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU3Sr5awQLwGjag2+tkXE3rceyxxmz817PwUBmvruZw=;
 b=JDH0ACvyI+8Wg98ap3I7Uwr1VnIt/StDq3nwP1luA5HcaRLO5zv7NE/Do9mV7JqsKz
 OVaiu0vrN/E5KgV6T5OKwjoWsdJ7a1NABTsdlLz+b2+uGUJbVTMtGAJ3RXSHqwsKhnEI
 BKFm2G07QvOPEJQ3pDeeyNj61x8Nn4AQViwZ6sl0UehC4lMY2pXaB9QdNIjhVT61oJL3
 S0/K19hJ2V+YhPV4z+4OBAbztAJaqOinlKu1M62ZEBh8HmtK03lR4uEjvyBP+6a9nyoH
 hVhW04X9EVR9ok2ORAPU1K9XachkcF0o2AquwfjNiaiCxCntz3XS//WAr4S7N44+DCLo
 0cHA==
X-Gm-Message-State: AOJu0Ywi/ug0QhLJGcrUnOvk1B0I+5+IJokgT6rPedxjKbrNmJiZbJQW
 aovz9i39iwOG8gBSHfw5t/wfXRJOQxOSQZ+dOpRO7CLZhCYSzS2wStbp+HektZjpw8Bb/aNgHWS
 aGTBoN7AJ7U70ul5Irzh8dZb30VnM3d9UsVaLI4W5eA4GB+igrx0=
X-Gm-Gg: Acq92OG9KA1Nv/HX8P53K1RgH92el6rrAfLNGtaBDJxUtCUt+Zn9O+qaMgW3H3fkq9Y
 XfYaoy87FeZI6l/H+clu6EkNGWz10J9XCbwgrWlAlHDCSBgR22hdp5PYSsZOkfSFkYiaW8Fmn6o
 o4ANWxIEgz1Y2BDN5eWpedHCftHhreuRjVxAOOimghHhfXPnNaYJ8uGI5DtbLKNsVW3zb0oSyhT
 geQg5Jfwi/n5QE+kK+O9rThanPLemTsBF0SrRnR2nxcb+ToF440EIhx/OvV37pkJiUhHHc8mUGp
 lvhwAg==
X-Received: by 2002:a05:6402:c42:b0:674:1fe8:407b with SMTP id
 4fb4d7f45d1cf-693c6a63434mr2673599a12.9.1781439941489; Sun, 14 Jun 2026
 05:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260608130924.112831-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:25:29 -0600
X-Gm-Features: AVVi8CczfN7tgL-V736Xqd04u91vPu9T7SOgQ-4H3c9nxUcY83k1QaRd7b1UFZY
Message-ID: <CAFLszTggvyffoVC1eRNV63K8v-83ZwQA0YfwPodagsWzFSSvXw@mail.gmail.com>
Subject: Re: [v6,0/7] Improve FIT signature handling
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de
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

Hi Ludwig,

On 2026-06-08T13:08:47, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:

Thanks for sticking with this!

Could you update the docs a bit, perhaps as a follow-up to this
series? Specifically, the new FIT_REQUIRE_CONFIG_SIGS option changes
verification behaviour in an important way (fail-closed rather than
fail-open). Please can you add a patch updating
doc/usage/fit/signature.rst to mention the new option and when boards
should enable it?

Regards,
Simon
