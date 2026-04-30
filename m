Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A33CD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D95B83A91;
	Thu, 30 Apr 2026 21:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i8EjYhgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FC480433; Thu, 30 Apr 2026 21:27:30 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D07780086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50fb8e9a4edso14334141cf.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777577245; x=1778182045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdR859gHuPIoNxRK1sh5uveWeTEkqpZ2cVCVEZbTZH8=;
 b=i8EjYhgoPh6mJGtAIX8hBlVCIgYPlUWDsRjaU70t/dc4IsSJx3tBYJuaE0ZDDq0LmQ
 kX7lA8OAjh8ZX6P55voY0oRb0z8e11NpHLjjU2H9/L7bGckQjZqP38Nw5wgXRevy4Fwz
 pXE9cttBrYhPSXh/LcZB8Qm0UHtGALBmRgwhY7VxILpNtQRRALovm8HR4NwZxBikGWQA
 kR1yqIoJpa3cwGxpHIOZwCZ3c4AE1mLnPyDEoJyN/5RML5SqoyaUmzvovd80YK64Me9T
 u8n6MDMiL/Cw0TdH6fD7dTHho0iIKpjfTq4ZJCO2daJqoqY+C/b8v7bX5EWESPFuJBH4
 3RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777577245; x=1778182045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DdR859gHuPIoNxRK1sh5uveWeTEkqpZ2cVCVEZbTZH8=;
 b=K1t0NA4BPYawO5A68oIAYi/8t25yNmtlS44rjbE1giuhHFmkMvyxY3YZgxZ48i+Pt4
 +7f6XbUUqB27FoOfHHLR4aDXshlBlkKPk5A6I/+hnwv56+JG7O61BgG094WcSJL/jhBp
 B5FHElbmZsH8OBqC7n8R31HAQnzpgutQD4V/4ElHQdTvTgDCuFIbveZJJw3cO3ntpLPE
 +Eagkj5rhgmQcDgFBOzvaNuN0C9DjmTHUXnAbcUs0zqmFhBetjn51nzkzG5jaoO96jvf
 HoQNpnt5U8QPxl0U1lXSlNOE2K+1GC1/oACxO8vEaezYAqcYI0mY8UnwPankgFpbewv8
 4/GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TuzYpLxr1DAjhBIv0AS/MCiMgkKLIlXQLtcjDOmRkrLIZPV6WNm76m//OPvJI9V4+18HZ4as=@lists.denx.de
X-Gm-Message-State: AOJu0YyWsXH6M6lm1Bpn/97A3tjschKfSEtcW3+sRKCPFaC9mdAV6aHA
 TpvaNDt+wMsgRjdnZa+92nV8I2iwjwg/MYz4cn2oKuX0WpDU+yJpk1ak
X-Gm-Gg: AeBDietaQ8+1wkSCA1GbnmwVr6KS0pIE9U7107Lbpzv7WRL9MGuDaia2mbWwxx9UiRm
 9g2wcQ0cYGID5ixkg6CaCkDX2dYleNCUUG2pTtEwj0YEdPEpItcmcJeublsaPlMTGqGPugLHTak
 CYVqKV0lQetE7GQE3ssNiSVQmqYZMy6FZU5oZXA1QiEtxoMI37J6X1MzfsJGuykWvyR3DYnSCNb
 NpfjpBZDro+s/HOwNnR80wcW8xVjI/E1FNHhYrCqzYPeNl+5WBqyWGbHM1B70ygIaMEp1BGzII9
 N5hLmdeMNhT2X8nT27wcVNEqnZOQXLZjxRD0uj04qn8M6Nrg4cyIBLJG++HPTSf056oSDLaqYTg
 WR12vDUH/ERY7kINEiC3zAZSrHmRtIYXOsfk7fGoOb9MpGoKKf3t6jQqJuYqqQvBx1gD/5vvdo1
 WWtz3aZD+SD5cakuHP5JBNMORiWhvSxPn+BI/DUBhgQxDquTM15OBs1y4fucM=
X-Received: by 2002:ac8:7d05:0:b0:50d:84a7:72d0 with SMTP id
 d75a77b69052e-5102ad9b157mr59720281cf.36.1777577244937; 
 Thu, 30 Apr 2026 12:27:24 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d3371adsm2794491cf.29.2026.04.30.12.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:27:24 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: sjg@chromium.org
Cc: caleb.ethridge@analog.com, jcethrid@gmail.com, linux@analog.com,
 malysagreg@gmail.com, philip@philipmolloy.com, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 03/15] mach-sc5xx: Update boot commands
Date: Thu, 30 Apr 2026 15:27:21 -0400
Message-Id: <20260430192721.4833-1-jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFLszTgG1+cW+1-uKnkX8w0pY4Y=S=EPwCSxdc-q2BXrEGm9xw@mail.gmail.com>
References: <CAFLszTgG1+cW+1-uKnkX8w0pY4Y=S=EPwCSxdc-q2BXrEGm9xw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Hi Simon,

>Adding CONFIG_SC5XX_LOADADDR to the four sc594/sc598 SPL defconfigs
>seems like it doesn't relate to "update boot commands" - maybe have
>its own patch.

I have moved these changes to their own commit, it will be reflected along
with the other commit changes in the next version of the patch series.

> Don't you want to keep the de-duplication, e.g. by setting sfdev in ospiboot
> and then 'run spiboot' ?

I would prefer to keep them separate, we have kept them separate in our older 
versions of our U-boot fork as well. De-duplication is good but at this point
with new boards in the sc5xx family being developed and  released,
I believe keeping the flexibility to easily change either of these commands 
without affecting the other is better. 

Thanks,

Caleb Ethridge
