Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D074606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dAdCxNkn;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iQhINYIB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373D940A88;
	Thu, 29 Oct 2026 22:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5ImdPpVaN3N; Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 656FB40A89
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312279;
	b=KtTCRdA6o6UFv8tuBkYuJEW5VOnoOJg6uyhb2F/oV8jgZHOYOLYk1CCiOG5YhoQysqFc
	 t3CgCmVmT3rjoi920A69w40H9MaX+WaJ3unHWL7snHfzOMe4HKkZBURSWVmYzwc3u53/Q
	 YRIEZn/tWBMo7POZv0rwO/k5wjpwmq4A404/7JdkTF58cMKIPrvFqVwp9yEj5itc4YwmG
	 sgL80pIPfztSnMOyFdkyRYaJuWsusNHSjqKNTlej43WSxvZWxJTt+wztSTMg57VFe2tZO
	 9BGY6ll+xWiduxsWFGT/9dnmm2WwbtZsVo3ZmQyE14qAhDv4XR7ULSjUBi9s/B+CfVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DOKVKV6lxeaI52QC+xKYMw2m4ZbYV9fKamukNSaJwq8=;
	b=sLuLVSGmbbLsNwwZH+H1dtnqw6lVFeHIrRHvigUTgOobuH3LbHAF5yQZEm+EnWMW+CEy
	 qY8YoXDD6zLSCwcIvxMT4QrEqG6V3zjfSj3Hn9nqKBXXtltoBgqI/tcmU3YoaYjMXDGyz
	 OIQs4NUCO0FM1N12PvNhbCzLsdfYnyGrQqcqD5CixODQ6Zz5NO+etOBNUuIaJDKh5XT+L
	 vsMxrDiqqmT8XqLFXIWYt5eJIN32rbRVt2de4J6Y4f3J5bJH/1mpK2HkxclV+TTUGKynV
	 0enHfZqva3WH4nyspZIKhGeyNVrZAdru05V59QKBJUWdFDWlhZzaQUXW6A9QpmPi7iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iQhINYIB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312279;
	bh=DOKVKV6lxeaI52QC+xKYMw2m4ZbYV9fKamukNSaJwq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dAdCxNkna62F5EZDEakHceJT0Ifk6PLTG77of5nbG8VAeFhWTpt1Vo3ngveu5vFCP
	 EJ6+DOS6KqaJdSuRUi6XI6uVJkmOHzFZNxvurYcDMkwjMop0KJrk8x82r290cUKoQk
	 jQnmsL4JDo+B5G/tJchPi2WXtjBWVfHPvJ6kMeBzI7aFfG4fFkK7nzIPMJ9atZHDd2
	 lZsi4kxWiWX4KxFGDoMH8OEJt8qMZwCI7I/N+fKXjBymsbjhpceEQrF+w0Z/PccUDH
	 xmAUfU2mgWcmKDYCz3+Q9ASk5YFTmSvyxykYlDQQ29FcLW6pLq9BTAQfJ+FAhuXSj3
	 k9vCmK9hSJ4VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 656FB40A89;
	Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65895712
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B8D740A7D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bvs9FcvbZbhX for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 925B540A82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312276;
 b=gt8zQ5HiIE572LWgTd2AzR1bTIlwmgrXjsC2eIsezRxAW4XJ+fgXlp1z4I6K1AB2S7/H
 Zgqj9XpiT+ZG8jdStllIdjL4tzHUucj5+H+oYGBz9rB2KXEDlhuuxMr+2rePj+QQHsXDY
 W0YKMRsb5zH0LGgU1Js4Cz+asZLXTmK8b1JJC4u/ULOdCcRYcCMXb9WYBtCAP6vbNH3/j
 I4xzGAInh+sPt5HD/9g+iBanAvXnOv+e2rLX/n/HnR36jeUi0lbHpYyEZURwBwZOSWg9U
 yIP1gA0WogoRM8Fg3vJ3JO4VzZ/KxttH2sUjVfJ5ffrMm8gEecJX1jP/+VZSgKqFSWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312276;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=DOKVKV6lxeaI52QC+xKYMw2m4ZbYV9fKamukNSaJwq8=;
 b=b88Ox0uJ1G8w8uQ0VMl9E1rS6Bz/mxBVXXGNcRxfxnMKOBHZXjDbAOByfFp8EpLISX7P
 BqSonPX04Hi6MRTe+OmITyc51c7RJGrfPwFr82cBPYxyHKoVn/3AdWeTu1wu/d1mI7JeL
 SnxFEDRPgls/voNSswz+eY90tp86zdobo7KgKnv1+O/kmFOFvrGDULmzD9kqjTxPfpM02
 vKReA7GYi7mrMI4G6OfRW5B62YbqoDxD8YGX1gcbZ5kh96ElzskkmBZJsHnycMV+YlYcI
 Lm/WJar8AY/ae1R66iCMEo8tkv7TKxMqBkQ0OSKnsGSpKQ8zccBQ+71YKCLPxiPPICA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iQhINYIB; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iQhINYIB
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 925B540A82
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:55 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4a85c656c58so53926fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793312275; x=1793917075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOKVKV6lxeaI52QC+xKYMw2m4ZbYV9fKamukNSaJwq8=;
 b=iQhINYIBfiuVNQ2DNHWgpPwAAsKGHUtA+DW4PacDyZD9gcCSg+81ShjSwFrSx1cSxu
 qOm2w0wOj89y1aOgLx04Kc3mt42p6S2Ta6RqOO3jbJKp8J4lZT21OWQ65QCccbbzktM8
 DU7ZJLR0bh58USsaVvgtcQm040owPC6Op9rd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312275; x=1793917075;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DOKVKV6lxeaI52QC+xKYMw2m4ZbYV9fKamukNSaJwq8=;
 b=vXEVH+WXxI0ohbwADFIBBKC4b9Zt9qFAhgMU3vx7ttO/y33w+ba5bN3wvzRG9Xsl+v
 M4pWa7dxbi2bexXWcnE/H3ZxCFDkqXuJKw2Bj5l1LPdoFfIAGd1u6LIwToi82XEL1C9w
 JbzRVq4Y708AIjtW+I8CLeRMcE/C44w2NjRzPY4yoe/wwK/9aKG4JzgYNEfTlBB1KWyO
 UWWtTVIu2fARFgddxX8Vf/rw0AAWPJzvqHq4MD+JahZEZDZyyY5m1JMPE023pmrptXrj
 2hkQXLnvDpMIuuLa5CztJSpzqG6vFNrCC9/WDwG9lDx5np8jPjHPQst3McKVQKRugfqD
 Yetg==
X-Gm-Message-State: AFq9FYILeMag6YcBockeLqm9lExQoGhnehf/teDkaNEDJnDzDMBG2ChD
 36IsGjXl1abaPNZV1T1+6iCctzdDNaM+mCZC19y5DuQbLdct/dFGse7sdj3rjNU3n7I=
X-Gm-Gg: AYBFou1RvScD0eflyHWd++4GD8xc0zzI9bX48GgQNPFFIGniQdC2i+gcN6JLB1xpVdP
 UXC/ZDx8+vRHCegT/9FzL6bEZQerSYlz4f14IFgTjh1qrfHgJmLTqTZ1K8gC3K1EbQTCF7SZAej
 nnKEU7ChWLW2Vq/ZutSM2sVapsUhZzL2TXrYgcOhvJ5/vPulAZGKg+Z2boVKeTgw1h62rH5shx1
 FQ24AUW8Ih7F/aS1PNr+IqieE0r5XpgXUJSn9bCDi/dH8C/eudx0yp7Sz+6ts0WqZuzAW6Niqbj
 jNfaBEhJz8oWkEkJxd+gjMAjhYIv4RA1dI1k9QXFgiSEphwqXJYVE33tc2oYyZ7bqHIhYHbqK4z
 XLqeqYw0Ic8zdjB/QExk2Y1gkgPNVv5GeP+u4Szm/5ryGZFp0tAWP06ghepiddCaOodfCuucjY9
 dvlvP59XF5Hk8Yj0vR2aR1avt0jYQVGTSZ2wMBKKYovnmYPjgxGeTGwginCNoYNON1QEYX3S/NZ
 Kbv5YGixuEzQJoe6Xf3H9Xd8FBPJGZ6QhRM07/u3WNbF4mMVYsjxcOXjtsGhcE+nQiZzR0LU2SS
 GzSg9ez7mLBb1gfTI80h3iJh33ACXx3Vqzg62N7NwfaseNDvZCN746WM1wrkDAgygedaf+zcV0S
 15o5T+pZt/kOiNbcmOoYTk6vOiw6O+HhjQ6o4pXEiC/Rz3LcyHS3HTbNN0kxLSPbaGnDExEAmWo
 FITDfzC4y/G7YlvwVnvGdvGJHzl08Zjg==
X-Received: by 2002:a05:6870:d187:b0:494:b659:b397 with SMTP id
 586e51a60fabf-4a9072ccfe1mr350516fac.6.1793312274682; 
 Thu, 29 Oct 2026 15:17:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4ea68sm119005fac.6.2026.10.29.15.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:17:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Bin Meng <bin.meng@processmission.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, 
 =?utf-8?q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Subject: Re: [PATCH 0/8] virtio: Fix virtqueue teardown and probe cleanup
Message-Id: <179331227333.3078583.5309949153049365140.b4-ty@konsulko.com>
Date: Thu, 29 Oct 2026 16:17:53 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 19:13:15 +0800, Bin Meng wrote:

> This series fixes virtqueue teardown across MMIO and PCI transports, as
> well as a queue leak on failed virtio block probes.
> 
> 
> Bin Meng (8):
>   virtio: mmio: Fix private data lookup when deleting queues
>   virtio: pci: Fix legacy private data lookup when deleting queues
>   virtio: pci: Fix modern private data lookup when deleting queues
>   virtio: Release virtqueues after device reset
>   virtio: 9p: Reset the device before releasing its queues
>   virtio: blk: Validate configuration before creating the virtqueue
>   MAINTAINERS: Cover all virtio driver-model tests
>   test: dm: Check virtio queue cleanup on device removal
> 
> [...]

Applied to u-boot/main, thanks!

[1/8] virtio: mmio: Fix private data lookup when deleting queues
      commit: bf63101333311a42d5d77d415d2ddb2901458d42
[2/8] virtio: pci: Fix legacy private data lookup when deleting queues
      commit: 8c622c79b802d32b94abc32c5c83966d97c0b187
[3/8] virtio: pci: Fix modern private data lookup when deleting queues
      commit: 4a8e9fcb28b602c565fb75d173db338b49b863e9
[4/8] virtio: Release virtqueues after device reset
      commit: 9ed51fad740a121e3be7165a9b53053190b1c64f
[5/8] virtio: 9p: Reset the device before releasing its queues
      commit: 3b342531012b304444d681e354136cbec9be70d8
[6/8] virtio: blk: Validate configuration before creating the virtqueue
      commit: a1804316c43fcb75349f12d29280ea75bf4ad345
[7/8] MAINTAINERS: Cover all virtio driver-model tests
      commit: d9271bc030eb524216b59236ab34c000a706d89c
[8/8] test: dm: Check virtio queue cleanup on device removal
      commit: 0ba7fd7e9092c6d219b269210ae87a7b54eb0b06
-- 
Tom


