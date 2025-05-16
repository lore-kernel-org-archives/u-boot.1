Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E13DC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 07:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4AB80AE0;
	Fri, 16 May 2025 09:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZaYijKJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9D708277D; Fri, 16 May 2025 09:36:31 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B60D803DF
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-6016d401501so456782a12.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747380987; x=1747985787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rbxtQJQXyqkpr983d+yVjDEk/xHWC9fq/OknjsQeH1Q=;
 b=ZaYijKJeQbgukLQn0IGpg+jD95z+kV+fIncStBrgF6eZ9cdlyS4iOUKDvIPT9Ba8NM
 GPwbs30isbngARzi5xTrBmS7k8ZNbZJq3c6T2jWeF5UyTklpU6hwyTPrTFWefxsG5pKC
 jFchHggjcaeC5s5QybclURZlETkAL2isO3gvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747380987; x=1747985787;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbxtQJQXyqkpr983d+yVjDEk/xHWC9fq/OknjsQeH1Q=;
 b=wesZ4d2QbHQ9A2PfmdChYAPFpr8jOjXYh2T6O2i5gX1xUdnfO6SOTJTR/8rQWF0FOT
 rOJuysYi4IASsbRD4q7xx+VWbUlLw/QrfLmnUZqtfPTXqAwQFfKfiLFkW8sXxAsUk4wq
 WueEJWZto/UbDFhvcAnqczrzWAuN/KTsWQWhqJH3nt4JM0pb42yQ4vvxt1Gk3Xl6gOqu
 WVWy5A1KVQAwKMwOfBq08qUhS88kemRru0CVeluVZy8yIAjx9s9JCY17/E8FCcYggrWf
 WXHvC/bLzOkdP6B574VL2Q85hEwLB7bD7nWDOYGiNVp5E3yKizw4EveX38assSaYmCqt
 mm6A==
X-Gm-Message-State: AOJu0Yz6D6LYeS1AI+BB1s4zrravIlh+dQkAikpEacVmR6PXX4u4fSyG
 henQfi/WpZ+3GXgpbyOneeF6lN+cSS9aQEHE6VmRRRLfoI1E5VjSBHw3jEDmfPXguSBLsSBancc
 mGVXe8vUmljsLtu5OiLX3KUckwNjkgLJO40c+lfrTav/asyYN3IYha/vKmgI7HDJ2
X-Gm-Gg: ASbGncslVaBCuOSZ0CFN1EmDIsoPFYYVEg1OEHeXQUsI+OtB91E7zzi2V3J0nPqEN4W
 0zpNjMPAi1lXcZ4rA0IPmso70BswEF28nnFeHM+QNoxr0gIHlcVf8BHe6EBNKHxagSQYav+ZlNh
 DdbcAnOHRq/Ex6Qc3qD305jYgh15XhbxriRQ==
X-Google-Smtp-Source: AGHT+IHmpLZe0j4J9Sz1ls54tM/AeIT5TOeHEArw/rzhxgKCzSiS5nkZZi5dalv33HXo2NTr2NrKZOWjYpOzGN3N8BQ=
X-Received: by 2002:a05:6402:5188:b0:5fb:1fbd:e3ad with SMTP id
 4fb4d7f45d1cf-6008a5ae719mr1962510a12.13.1747380986780; Fri, 16 May 2025
 00:36:26 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 09:36:14 +0200
X-Gm-Features: AX0GCFv4epy1nMU_d28ByWJM5vf1zNpHdbeFFVWvXZc3W-35MJcTEbSPc8fwVqs
Message-ID: <CAFLszTg5GzLW1KvGvjcygoH8ktN_bqJyutbojHyONfmKVtddSA@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26199
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=78&view=results


The following changes since commit 4c26de2eea6bcf5f27b13da0372d27d767cd38e3:

  fs.h: Switch to using rtc_def.h (2025-05-13 11:30:09 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-16may25

for you to fetch changes up to 13223f8ea1ed102055362bc7ee242bf992443ca1:

  test: Add a test for strim() (2025-05-16 06:21:37 +0200)

----------------------------------------------------------------
Bring in the strim() changes and associated test

----------------------------------------------------------------
Simon Glass (2):
      strim: Sync up with Linux version
      test: Add a test for strim()

 lib/linux_string.c |  6 ++++--
 test/lib/string.c  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

Regards,
Simon
