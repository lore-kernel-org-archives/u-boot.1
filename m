Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAECC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 10:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F192C80C7B;
	Thu, 20 Aug 2026 10:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48e82BpA1bTm; Thu, 20 Aug 2026 10:29:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787221753;
	bh=xQU2ydmok9pS01AjLOaEvCItAbJfLEt3/3SvZnueLeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fkUgtNRNcSxvfbGW7MRJTFGy3t7fLn/PxkJ6UBdSmgO5TCkSo9akSPxtqATPQ7LqC
	 LKJykkT4xL+ocyWY5Ur0+KGsg7brbmr1sTO9g3FrC/dYQKpjxUBBseJjvTLJOVF36G
	 EpA/UjC2ZXg2UJZP60WwoBfOmvnxVsIGQ0hmPVJ6QYbTUa2FmJ/CaAvC6mM3a5JAaa
	 2SLqj0p75LPC6uHdHJGJMTOzsvpkDjzOajbVHHvl50oMKLBbaxjUo/ekP8ZNMDwhaH
	 rwVvLByjP+8jDIiIAbrpS9Iyz1XCtD8OFXUGQ9CfbSyfg3+pTVLpej/s1bn48h4F1T
	 Q/bTztBVWySTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D29C80C84;
	Thu, 20 Aug 2026 10:29:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59F471460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AA7040281
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBOKCJyBvQ8f for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 10:29:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kczsq8sZ
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D37F40275
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:29:11 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-902e4af2d9dso5449396d6.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221750; cv=none;
 d=google.com; s=arc-20260327;
 b=HdE2mlnsuhzkGKG4coH+Wq7zguI15IQ9NdTxnJL2K5qqN29Zinju9TiPizw3bPW0NS
 +T+6/KublI2XQxRNKYuzYVyokJS3DjFRePZp1yvrRXhkhlbkKOW+k3whwlUf5o66qg3F
 2WSRfBYgKNMZLApWYn5zjus5gLV9NkDMUQWxMFiko0umf7vM7dQZB71/MXtsDT9QG/bG
 SnK+AyIUsvbKbSloDoAWRZSfRtWmN+WghgRpkqfMa/Amg+V/mmtJZwmX7OUOQoIjO+UA
 XGJKVjFcIreSlBn0/82MQHJJbQdUTf2z0/iTOUwzh3LpI3bD9nWw1PKpyqsZ/l+nXjD+
 hGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xQU2ydmok9pS01AjLOaEvCItAbJfLEt3/3SvZnueLeg=;
 fh=T16Bv44u7Uz0Q1ZW0RAuvVMiv7vHnYmGtVeXn8AIbGw=;
 b=R6oU1tAuVvP832MS/eJE+FEIw6G9/Pboa3loMP5wzL4mkJQGJRikO4qKZPGP6gHM4c
 dBJSBRBFa7wVsTuNXx6KiPo6yZASz8X1ZCCcyderTYLPFQzhx1jBcEya4ca4MMeE9AQx
 PyXYJBCH0RkIGjKV535lua6vJT2HljGB3o7Lb1XoWuA1yVIad7PamIFgbatfBh3O08fv
 xMPNcn2YF8rTbOQ50kqw97okFzmE+XTmVsx18Xgxr0ZeA2p+LPcx0cQ1MIohORbc89HZ
 uZI1khIp3LMTfTorIQmPg/vKhfx/lwgaeVxC2h3J2UWk2dfDdWGi6C8nbbILl6cwhrMO
 tL5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787221750; x=1787826550;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xQU2ydmok9pS01AjLOaEvCItAbJfLEt3/3SvZnueLeg=;
 b=Kczsq8sZuisx9DagRCU9ubhBP/tuKRC48CtoKQOZ1ZUDjNNkzVmCDYsDiyuGIT1R2Z
 yRZwAi+v7qKKLSlP0B7YtBVEJWLIV1F6OMVcUC1zhDtarLlKcQLFSDvDKflnj4YpifaA
 ZQq3UwAfSftpkFW8x4Fl37JdIPhNmNuUEndJQUqUQRA/HFO0cXU6WxIRspjJeU56btXl
 M/kV+0nYk+yV3L5k/6uKzrwxxvhDxfG/XUvjs6ssmx1qBrTZywA6Q4t5YklSruCUXMlb
 BUXuu89BblZVhrIQM1gp+/JaMyMEouUk/fnrJkW+QW7mHNZtfoie6xX+STKRQNM206hq
 B18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221750; x=1787826550;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xQU2ydmok9pS01AjLOaEvCItAbJfLEt3/3SvZnueLeg=;
 b=M7AA9LMaNtVOSApYYtdBcZ0eFMjcMD60114am37UhlwP5XRXYtDcD7+flsau0UUZPG
 4jyCQU/ZX0E7O2Zgxc3ZpQPYPRo0Ha9kWCm2T4mzl6cq/JgAGcOyREiTtCSqLnXer/rC
 4SbIbl6pZKHFUJZGqCwQafBascsd2WmDi+rsFqMdE6cbupwN9IrjpVYkOOTHr8nNfdPh
 Sx4xnp6zgiUVRATsMFJYG4cjUrhVoVFTbEZros4brVllSMBLEZtWTj6rc/khWVg28h4n
 ZwCfHVULBtTX07iyVl8FRR+Uiu5NreQ9hxc3Mar+LhvtXp4ta/3HW/TKF5Zrmy2uKMfa
 TVRw==
X-Gm-Message-State: AFuF++lFRyh/r3mvKxhDTGzYd38t0g3g3dChMdSWLSNKHp+fJtNqlS8k
 RzNDvSNwfBEZGyvqAKZYNokWQGpBV3fxQmtMFjW07BQjKDEkL7mwrnBg0zwquksrqsBm+6OD2cz
 ixjAQUy2oabCzRXvtNF/sfoyeaiyVtR1vtQ==
X-Gm-Gg: AR+sD1042Wn/2oYhQSk5MWF6EXf6pKWXn5pemQtIZM6qdmc7rNvW6ybHoIqo1fYsq5/
 +8nmOS3VZxowUm+JuZGFH3Y9vfiMwEflBslbV5WavjJKf5+W2Jkg0WRPEZmfLT8WwPN9JuShpg0
 kv9ND2rFHHTBsYbCMODwP0TZe66eIm++zRneDJlMFGBEiGM7YCFNxh0XpOeFif0FXZdQQcXrtbw
 3fSBFcvxn9bxSCmZ75jVtpWfy/T5UP9WEtIV/t1z3w3WHPUktnKLbDkfFPyTyxSEs1eY00Kb0C5
 x9k+NsBVWykQ6qkJG/qJhMSJdmPF1NIdfK5otBU2IwBZbvx/ej75aLESBVD9KsAfEvD9ILVHsAe
 9ck/YbvoYzQXpsyJ6rB+yIMrzn5gt5gE2ZRtCmw58it0pNv/mKAsJOhqwwnmFCBmHxq62AkF987
 liwzVx/6ZRIIy8yWJUPXjoFSkNMxSBjBlj8Vx8ECs8RJjMhE8TEA==
X-Received: by 2002:a05:6214:4c8d:b0:90a:7cb8:70b3 with SMTP id
 6a1803df08f44-90c6a7d07a7mr55959306d6.0.1787221750012; Thu, 20 Aug 2026
 03:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Aug 2026 11:28:57 +0100
X-Gm-Features: AcwNN1WD9I845mY_KyPmb6qP9EHOt4TDKNuTmM14n27gLf1u9RiwdbDcmMSj5WY
Message-ID: <CALeDE9NAGVvWm4Gt6rK9h__f6o4_TuV0fGjoB1WdWd5=7pQHhA@mail.gmail.com>
Subject: Re: [PATCH 0/8] net: mrmac: Fix Rx packet loss on back-to-back frames
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 20 Aug 2026 at 10:26, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> The MRMAC Rx path drops frames when two arrive back to back. recv()
> always starts at rx_bd[0] and clears the status of both descriptors,
> and the status field is the only record that a frame arrived, so the
> second frame is lost without any error being reported. This shows up
> with multiple boards on a switch, where the extra traffic makes
> back-to-back arrivals common and network transfers time out.

Out of interest is this using the legacy IP or LWIP stack?

> Fixing that needs an Rx ring the driver can index, so the series first
> makes the ring scalable and then fixes the bug:
>
>   1-3  Independent cleanups: check memalign() failures, give the
>        driver its own Rx buffer pool instead of borrowing the shared
>        net_rx_packets[], and read the link speed from the standard
>        max-speed property.
>
>   4-6  Make the descriptor ring scale: index the contiguous BD blocks
>        directly, build the Rx chain in a loop over RX_DESC, and
>        program CURDESC only once the ring is complete in memory.
>
>   7    Track the descriptor to consume next in rx_bd_idx and take
>        completion from the per-descriptor COMPLETE bit, so a
>        descriptor goes back to hardware only after the network stack
>        has read it.
>
>   8    Size the Rx ring from ETH_PACKETS_BATCH_RECV, so a full
>        eth_rx() call can be served without hardware running out of
>        descriptors.
>
> Padmarao Begari (8):
>   net: mrmac: check memalign() return values
>   net: mrmac: use a driver-owned RX buffer pool
>   net: mrmac: switch to max-speed property
>   net: mrmac: use contiguous BD arrays
>   net: mrmac: initialize the Rx BD ring in a loop
>   net: mrmac: write CURDESC after ring setup
>   net: mrmac: fix Rx packet loss on back-to-back frames
>   net: mrmac: increase the Rx BD ring
>
>  drivers/net/xilinx_axi_mrmac.c | 235 +++++++++++++++++----------------
>  drivers/net/xilinx_axi_mrmac.h |  20 ++-
>  2 files changed, 137 insertions(+), 118 deletions(-)
>
> --
> 2.34.1
>
