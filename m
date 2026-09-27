Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96810C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 19:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4383B80DFA;
	Sun, 27 Sep 2026 19:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dox9kNnyOXkg; Sun, 27 Sep 2026 19:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9897380DE4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790536137;
	b=O38m0owt41335+BiPBWGaivUzA1UwAXez19O7bt6YllVpDnsAq9WBgVq1/VYUJmzP1oF
	 gnFH4Z0RhjMYRDh4toHOaIUoH1M03BHUbMUx6COjmbZIsBx+8hblsud/Y3QlFJZDRxfgG
	 9NMkvJt7OHzjC5jl9ze1CGF9HmHJOGXU4NbIHnt3Tzth7/jyLn3xIxIwAlLzNtzuVzh2G
	 MLJ7+71B4DgUiVx6NgMqqIfZIt0R0eU351CHVceR1fRP+QOrOtKHK46GyGMrkEw7N5YNf
	 /iLOX+ALMGRTCzWWqIN3/TYi4hqDyKTrFrr3dmVmn0FURJaqk2hCu3qyWljcnpvGwBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790536137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bInehMcL9ZOazljDQUQyepbhZ8PV2OsuJkMZ2WWPgH8=;
	b=ZIMqQ1wbtVSQiX9ERIXVH4YbEjQw9HdccHVBilkZzCjGrPsmuJV6nF7Baq+25pEyU+ax
	 4jMwwzXeE/Dm+DZ+o2oF+1iB/2opc23ja/iY8eRebyHWaLg0g9KiyA21NtCiLP+3jMAku
	 YB4JcIgxVJqyyVrlNU/wvSd2m1doSMBXJsFfEs0yzgir1r3mKtfCQiwUgOUqDtIHXjp4x
	 NKvmV7IV103H7QQe3Q0LQbI3SNim/qIYNEhQZzyB+p4Wqh6KJJStwT7nwq38aiZYemwz1
	 GoUnykyCijsaBisdNETznwHf92SiVtguCOgSscN72BM4p3aiKuGTrzPn+NXVZEepGuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790536137;
	bh=bInehMcL9ZOazljDQUQyepbhZ8PV2OsuJkMZ2WWPgH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nokf/WccUd5VbveO1RxjMl6RcmcmcGXFsNrquw+IQKjidKE2q2jXYRdUypkIjAklU
	 OCIN8HKB5OzZ03m+SDQClVvhJSG/bi3RRk9AVYGIhU+zXqhGqDEBqroo3NeE1e1krg
	 vjiPuQ1dnQAcqgCZ2BtEPlS2nDK52VjcM8KvFVqkHEZd0qsZtD2P6/wJZ3RCuYG2my
	 p6ZyWe4hnVTXpgJ4EwVYBQ6J/FlIyxjfeLzh6R/Dt7nq4mBcMsIbsK+DlwWECu53Oo
	 G9hEF1x84qDQcCPf7ElI2l8qE/YxLXkx1puqjl+qysuXmnssna6jvpZYHNmrzQtEvk
	 RXV2R6VDZwYfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9897380DE4;
	Sun, 27 Sep 2026 19:08:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CA18194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52BE44002B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6nEgafI7OC2 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 19:08:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A2CD240050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790536133;
 b=fIeIgoeSDhnPndTLxHpN4rJvevvfr5tBg74FJGa9O2Uje9j0LfJgQRcNwp8OkVJdePmz
 eXw1huT2SmMZzg6MwefgQnOFO9z9igfQYjHsC/MRtRlhKbjhd8rAjHrZIU4QQOk58M9XA
 WX9X9TEOtvn535KyXFFpZSz583HcQN9X52OZZ6Ia86m2bdA+B0AA1dAd96qY915RjWrt5
 BfKT8+8Uq/BRoqrVTh44AmdPVrUwI9T7IxlwsRKOCZn/wHwGfl0J9fgRVy2Dyj3UxBSRn
 2EkA9WjfrBbvo+GvDaGvPUbMXfZl7dygEhgrMpBeGXvV8p0L4mR+rPdc/hOS1BJw+XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790536133;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=bInehMcL9ZOazljDQUQyepbhZ8PV2OsuJkMZ2WWPgH8=;
 b=o/UCfYd2A0ipltpmVpKwvak2TQPEe1qiaeHKCxt04S0uW0x/AFMIk4tmQkcdSTzSUvXh
 Nmj8z0/WR6q/UruAZ6kmUgUhm8v9JzvM9XcCn2w/sLFC0xhavVl/safz33x9w0fTwdva+
 f9XsJD9eLNTW4iEkszdoiXtmXghkj+Lx+RC9v8NIOzn/hukxNSbADtVjqq06xNASk0+iN
 qZlYwmdIDLFYRUUnzyuWQx9Awzk/Q19Wb/I764sxN5xOp+fx9ZHqzP2lWQtUR1/Px6ubG
 Qal/hIPUsWUq9FLGXznAF21v2M5OAKfZQUrKquor806V8g2C5xa3NcBq3Z0o8PDjUUA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UmBzqUyj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::e;
 helo=mail-oi2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UmBzqUyj
Received: from mail-oi2-x0e.google.com (mail-oi2-x0e.google.com
 [IPv6:2607:f8b0:4864:32::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2CD240050
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:53 +0000 (UTC)
Received: by mail-oi2-x0e.google.com with SMTP id
 5614622812f47-4e893ed88c4so298558b6e.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790536132; x=1791140932;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bInehMcL9ZOazljDQUQyepbhZ8PV2OsuJkMZ2WWPgH8=;
 b=UmBzqUyjRQRGhtCF6xfDzGha77xlfysp+bEYReyHtiwp/E4b8A+FCS0Y+V/Rm0vsLR
 TLm15QOti+y2JJWMhIK1Z7F51QeUvoeNZzPPVP1tzrt3t3MdHTuDd1T/VpkNbDUXnArb
 SBowID6F5VlrAMB1eH1yZNLq0cmlTM+l2+fr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790536132; x=1791140932;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bInehMcL9ZOazljDQUQyepbhZ8PV2OsuJkMZ2WWPgH8=;
 b=MB05m7I3F4tHZBxLgFddp06Il26YnGAmaTlMCsZqSvxYL8VKZ9vJ3TlnmvUrFbscOW
 hx56sDTcXW0jdiCYSg5Snw1eBi5kIEXVZ/JCZRHKJaiK+DmrjEjDSC2kBk8jgJnsWzI2
 BAVPzEu08Y7EFnRmxTi4TIcVQX9sCNXM4p18ii3YfY8X5+iKDF3b2zjl05MVptqG2zj6
 1vN4dhIS84WCtEQliqqSYVtfKLqBQVkPPUc3QYOP0FZ/EPxgsgx0SQrJlaAoLTI+r4AH
 V+q+07MVuC3wpxnp7zuembz/yco2e3ehv86SN8OuNnrUkGnr6Qmm6E+ptC0SXmUa01pg
 ez9w==
X-Gm-Message-State: AFuF++k3LasgA1zdMR58LonRWBfq6ePTI/YlZbJp1Bxq2W0Tlnwf9kaQ
 XDRNd37ZH9XurfWi4MEMvwQUmRnnulNgmEAI9hdaU8lHjjcQDBcWx7dmkVAo6vOWyaU=
X-Gm-Gg: AYBFou1kQD8odvN7W42uwZWBYHsF0NeBMMAz2vAEtN519EDILzrPKW2qSOkr7/QQfFV
 HDPc5W/PfyMP3gzgiu2dT0m5kYVxKMeEywHDSYNvwGzNIu5fj0U9EkOoj303O7GrP3BZOCHD0zx
 P+padA75MJpk/sExmMnsDm46BXQFplbA8oa4eN/Qb5Ncpqova5j24Nvb+6ce45nSfxhpYTXp/3f
 0dghjRGBdceLB3pGVXredGwaN8bhx5mY+j5i7ZZAKTg78VMYiDvOCAmrLaNMXnh0SXq0UpPCYe9
 37lN8dY9Az8tUKKD+8E/jHC+3HM4h/OUVbynZjVARpSf5OUEVyhQm895dvEohOL948yy1v5nsqh
 NSDxdMII2R3LiLIgVzfuY+T1aIAHV5BMb12cz++MqJD9jf7CvJvm0tYl8ez9CT72BHQZ0lGjWej
 6MWEsavzW26tEFJ6R41RAnwf5eoT4huVJkoxEmMj4GcKAM8pcI2Wr7DDPdHKwgh9gFSYe2EgJmT
 dwDqVl7PGtski6xFz65alxvaPrQ38tkvj2JFxX0L9Ij/jLlvoTxPQXk6aOVIlDEL9RnoHBcF4LE
 07P97rjd0AKS+jboEQ==
X-Received: by 2002:a05:6808:4771:b0:4dd:18c7:544d with SMTP id
 5614622812f47-4dd18c75587mr6082124b6e.31.1790536132280; 
 Sun, 27 Sep 2026 12:08:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4dbf849c0b0sm7300032b6e.11.2026.09.27.12.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:08:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Linus Walleij <linusw@kernel.org>, 
 Vincent Jardin <vjardin@free.fr>, David Lechner <dlechner@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <aretHk7cp91PEuhY@nxa18884-linux-1.ap.freescale.net>
References: <aretHk7cp91PEuhY@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2026-09-26
Message-Id: <179053613092.2206597.6130644874049886241.b4-ty@konsulko.com>
Date: Sun, 27 Sep 2026 13:08:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, 26 Sep 2026 19:31:42 +0800, Peng Fan wrote:

> Please pull mmc-next-2026-09-26
> 
> --------------------------------------------
> - Improve arm_pl180 mmc clocks, supplies, PIO
> - Power up the SRAM-isolated MT8189 domains for
>   ADSP_TOP_DORMANT and EDP_TX_DORMANT
> - Support board-selected raw partitions
> - Use DTS address in mpq8785 regulator
> --------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


