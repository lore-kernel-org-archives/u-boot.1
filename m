Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97823C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F40E382131;
	Tue,  1 Apr 2025 15:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="NuTzoWVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2165E8212F; Tue,  1 Apr 2025 15:19:00 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB678209D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso12530890a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1743513537; x=1744118337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yxMrv+HSD364fzxDTN7KsZTGu7RefZnTP1hVd1TsVJA=;
 b=NuTzoWVnfyWWnMURwP39GoCdV258QWwebkZKNjwxCJPxXGen3YbUH3cZngOjkO+LPu
 UupGWhsMrZeo0j/qd1FD8BjU5K6LbSvt3KXcV5X0bKL387DdefZ6IjMLJQe2Z7O8gvFf
 oLZK1NSb/AbCPZ8nPl5ralipVunj6OQKgIygU+rqI57TWjq2bNG/yqLPLsAaQLDNSITC
 R/kPbpEuzysx0tlezlNtZ80MVL3JliX9qhE4NoiX39/SHFLwhR8OdZgB6peXuAweW4h6
 ODWL+H3y257SYage0+NqZGi2Q+WeDyXKV1N8ycHd+ZorueQk9l/urmUOrvuleRDJVw4q
 wMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743513537; x=1744118337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxMrv+HSD364fzxDTN7KsZTGu7RefZnTP1hVd1TsVJA=;
 b=FPWvCtREB+1HYwQXP7Na3pNoOtZpyrAM3JvtvgEHPFy3e8odJhKVmikxsJqxCg9U4E
 txraSyNTiKpymO0+xax4mE9t5N9SwahS59Xgw7zeHakBfLUAS+9eY9dkLV0dhXxKUiqM
 Bs+1FK38UcnDODPg3QyWFIP2D4po7O9kerK5M0DRC/EolzjgVIPiQmEK7jctXvYHOkJE
 0IuBN7Fz3XfaUc+RsJCAfs3BbMxy98PlZYz5t5fV+ZW2gIGNY/coSIKFnMzx8P4WUUTx
 Sv1wkrq/0sqCvlGjlkWlpe/qXZDY3BcABfR4r5Cgl+ndFizF5iDYxD7BlnsEjit7BwUe
 HxeQ==
X-Gm-Message-State: AOJu0YxOoiqoqipKSMxrXeQ5axC4/LroiP/klp0L/DuBMVRP3XOmIC51
 rX+RSuqKmFufvZYg6bsSLuX7R0pQe2nSArT8Au79oyzU2d1bJirRN2oFdjxJL4fAi3exfOIfCmC
 zsL/vca/ZmqWI/Fxz/VXB+CYROI0S87v5TPcjIvKx3msJdLejEO0NWsM=
X-Gm-Gg: ASbGnctmfM0Ru5J02rk3+jVa33762uXt9iG96pEBdRYQkRUCrRN8yJq5imzAOffoa59
 TDxbOVXN6erVGbhsvnQulOLg93W3gG4++u0Sll4pbaQ5FhekurSqzu5hHLr2Te1WbZAWVY2n5XA
 UM26KQQvngT9E1rdnHo18WyHNiHglte/6jMyk6q5WQbE5Fn+xGQlJ5qnGL+t3Q14Sw5pag3tE=
X-Google-Smtp-Source: AGHT+IEyZTiyMvGiGY9piQjf22sBWWCHNMMMRO/Nyy2fW6vqwUswr5pP17Pn5yjtrErCNq8qo/4c013RFLSl4pi9zNM=
X-Received: by 2002:a17:907:968c:b0:ac7:31a4:d4f5 with SMTP id
 a640c23a62f3a-ac73683ab2cmr1254221666b.18.1743513537261; Tue, 01 Apr 2025
 06:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
 <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
 <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
 <eb506671-c8be-4a00-9341-5db15cdc5d44@linaro.org>
In-Reply-To: <eb506671-c8be-4a00-9341-5db15cdc5d44@linaro.org>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Tue, 1 Apr 2025 14:18:46 +0100
X-Gm-Features: AQ5f1Jrwna8Jpa8OvcZoj0kxC5bX0NTh1e7Wm1zv_LR1lV1gfx8Jq72NSj5eWPs
Message-ID: <CAOWkq4koPm8O40yjhCbfq+9poLjJ3ABWLh-xejX=-XrEfbJ07Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, rammuthiah@google.com, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hey Neil!

> Ping, did you find time to resubmit a new version of this patchset ?

Apologies, but it looks like I won=E2=80=99t have the capacity to complete =
this
patch stack after all. Please feel free to take it over if you think it=E2=
=80=99s
useful!
