Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2061C4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7441E84D64;
	Tue, 14 Jul 2026 19:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qtCrbhl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9918884D66; Tue, 14 Jul 2026 19:56:13 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8781D84D5F
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so945507a34.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784051770; x=1784656570; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+AJ1EZ0fF1U3NroZEkEoExwu0ktraaZBLDjs9yUdaps=;
 b=qtCrbhl3Cmm9og7/ZuozCh3KjEXlCkvandW3lZCbZqmta+jys340XquMIyCTa+pHam
 zHjOJCVSt8KXHFg1+tHLLwIVDZ8WfhIU3YbNqGvL+Ni8tRY7ha/GqPzEHlc2WE+4zsjy
 pRsxJZd3tbPkTfv34uFyqP904PXnTAqT86wdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784051770; x=1784656570;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+AJ1EZ0fF1U3NroZEkEoExwu0ktraaZBLDjs9yUdaps=;
 b=IPJZwu7CGpnO0i3Kb2I5smV6BK7gH+9bH4gb39WTWriF+5AImOshn823niXHpDrHTU
 FeY5S/wED7RnTSIGJmxgeMhhs/nLnd1m2H6MVsspjvIYwj5MZ/gZvnrME9sLKwiLdlkX
 dqytsosKR7bJ3MXO6amnSwE9uvEUCp2KiVsgaTT4/4rkbzx5C6Q+DvogxoaoBMdypkvC
 dWhKY1AhiDGsn+fuMaNrkB115adyFwA7z45HhcLlOEpuyOHvFcro4JZD7uARrzaOpNIO
 h/kwviUc0G9Tt2XxUukezFo3IbyOvKcISS8aYCYHW8X7fyPac5GGR6w09eATc4d5v172
 +z9g==
X-Gm-Message-State: AOJu0YxcOAsxX0911WwhMBdyGZkusFlu68ZwDsmRDDlQU0Qhldqbm5X+
 WoxMSeX/vzLSm8FFO67BUhw0YgaURB3MklLU+inzajL5a+NtsFysxqpfoiUo/IsBROBZkK2tqSK
 s7BgZK3w=
X-Gm-Gg: AfdE7clw8qylLpzXRmgogWcQpDyhLNYJYUC/NK7e5mIb1mTtrB5Z1cIDwWrR19LVX0z
 SS+86UMQFIrIgGROIt/LQ77+drgqFb9II4tAowHQ1g/hPOnZ9bhVlqMMjj+vMUeC3Dy6ibaXpnC
 otr200Q2S3ybqqD5MBdyBxQN8MKE6ZA25+uY1ppgToUEarXxbKbzqOSQnEfkBB9P809vnMFDm12
 YZ7AXlW0fZxcCIodq/A/hYP+ERLpbw9CBwssizl3VqKyF5aRZdCfbPIlXXBNswy6c+9snx+neOz
 AA8SFl8nv+FgbkixmFIzqRDh9dXsIKaxYcuR6QbJyMiTReopa8yrErDu+uBJbn6uDNUGHcsM9U+
 X7nDSUN0wQ1KOH2wJqnI5DZ9tbsfVFgX+ai9vvzf7E7hNhoeIOo05a39qZxEfzsl8S1aP0PcLjZ
 WO7dVfYW5gSXRvfCMA3Q/dsCQoNI41FdAL/dlDlR8m4NJZtjIqPtxql1kKBB4RuVtS0iBS9QffO
 zQsQZWtWs24+vwA9uVNtdbI4mrrfxr3QYMx
X-Received: by 2002:a05:6830:f88:b0:7e9:fe5f:4406 with SMTP id
 46e09a7af769-7ec0997528bmr8687616a34.30.1784051770153; 
 Tue, 14 Jul 2026 10:56:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae206e2sm15597648a34.2.2026.07.14.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:56:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: quentin.schulz@cherry.de, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
Message-Id: <178405176924.3971373.15562595792017097014.b4-ty@konsulko.com>
Date: Tue, 14 Jul 2026 11:56:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 26 Jun 2026 20:33:49 +0200, Dario Binacchi wrote:

> Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() compares
> an unsigned int (mmc_dev_num) with ret, which can hold a negative error
> code.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test: cmd: part: fix integer handling in setup_gpt_partitions()
      commit: 8d50a5ce721212f0b4277a3b24f5d07799970bee
-- 
Tom


