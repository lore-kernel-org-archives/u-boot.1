Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022E4CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 16:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0C7A60AEF;
	Fri, 16 Oct 2026 16:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2r2j6WTlSwx; Fri, 16 Oct 2026 16:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2FF860B53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792168899;
	b=V9Hhy15gXSr4DPZL+j6tCXpTzuNWww3XNK35uowQ+vHIYoeT9atuMlnDA7NduO9yGPHI
	 VNsBzAtRws1t8IoDCYfqYBUj039VrLCTSUqKrMgvHF3oFmYLNHq8U3W1+gec80/UTPhQ8
	 LosZuibCx1sqmjoa9IVgAXD3ICMD+QC8V4b8rejCczCNn8HgicAUbbhDaczj9wzUtjXAv
	 o9HRQpVxEIYeopuqwZ2ZvlAqd/N5xkP3cGLQ92DPgbF/T4eM/yqOxmt/lDIfWaRjJ+Cwo
	 BLLMxOkwB/v434NQZY+iOHrFBLW9ScGBkjZO1PZ/6f3Bu39dJTSruGbSVnNnuvPB/Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792168899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1jEJ97sHk/x/xbxPLBggfBfex4H2iyI8Y9+kyslOo7Q=;
	b=AiS5eJ/JnsubxebNwYwgmJWzQw63krUF0coCd0bp3JJZcMw02dXjaSEkf09vRbrraGzh
	 iL2/LhDgaYUt7rco/a07z9jHONz8IfkOVaQ3Y7U1+723SdJgyqblgycRSQQ+HPOvNUePI
	 4jJmwpuJN/TIbzRB0KfZqcnFMve6PqUeIHWn6ZNHiVGddX9Dzynfbg1YavTgrIKI4f5zq
	 lTn/NshesItzr9kX2IoFq62EywXlJ/wYOzRJhmkdOswFe2Djw9Ux5fDV5bFmp8lYvZZUy
	 Vna1YbLV+Wpe7hdgNNpf640rAaRn+iMQa3fNZ2k8ptsZw24WOrKtBE6f7Up+/vK25cQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792168899;
	bh=1jEJ97sHk/x/xbxPLBggfBfex4H2iyI8Y9+kyslOo7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5KjEfOCX/R9f+ZJqTr8mi3Gxt8SD7eNlvSioBfNj0JsiYv2rkF1LaDeW3C3abcLG
	 Zrb7SdwS96bxu9pVJ6RnXYHX+sObyf253jebcvfqLI10yAsZLGbOokPOGGYeWp6wY8
	 tgYW8trTLTMbpqEed4cm0uYeuVxHM0NMvopIY8cI1eMnnMf5C27PcY4yCKpuFRY5P/
	 b6DIWCAGxNoS62N3YLkqGui0s+9S+bUMNnRxYgWmGIBn4QwzutnAxMxf86FdhxmaxG
	 /Pd4oSxkQRNPvdTRRtIg+rf9/amdGeFMh/QoaUf/A7RQ+CFzfVSVS0VE/LJKBXFndT
	 BExlzPsZOKcDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2FF860B53;
	Fri, 16 Oct 2026 16:41:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45DE27AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C201404AC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:41:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e0OcVPpyl26D for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 16:41:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D83F404A1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792168896;
 b=UztoaXLNv87poTXfxvGZC6MHLa5SPirXWT+YSw1tbcTQWEaCRT1y5B53jZqcpMS9jo7z
 A7sUx9hupkw7I47TCPNm28n151ozgaqenFBByTzrgCS8wsmZN1scfVgctdVthjl91h7Dz
 aISZg5P5oxeCKNlwccPAYABnaByCL/iZXl5n/iQTJROsz56w/sDNB8PgeOaPEeqPUSLb2
 UeoyuHZexXp7Kb6lCyxjRuSVyAqoMc+sgUDcZxy4FqBkPWDcGMLfLWQwPWyoPiPv9pQgy
 TvGzRUalmUx3nFlroB0pVr7qt0TATMl0C4zEQ56LG6TqDqWSIVjpVdpyZKKTcYmjI9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792168896;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=1jEJ97sHk/x/xbxPLBggfBfex4H2iyI8Y9+kyslOo7Q=;
 b=D6LpKjGeVjlGbexIglBy7SXX8eBKreCwQzfdcFBMI09dBWUZtd1M19x1V/MIIPyIH39R
 Q7Vg2XkUXFY25PYMNiC5o2BRrGAW5RXynByC6XJNpMOwY7dLe11wK/vqlkldxdKyS+p0v
 I0zEKCl20kh8UP4l9KHnNNzvjXno2pD2dtGUiJvi0wBxb97R3nxFTcUlDiqXWlcbTqMFc
 MFiZCSmIaIIbktNTmUGAXcYu7MlZGHUncMOUMcR7FX6VJQ13rBb+RKpfSRU2IAF4zARGZ
 nQWVxnYs+QGrJgdsb+dOEuIBMyWBS7sOZpdbG/6d575lmpLLgYMDjE+fOzN8WLbTMow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SnPg4JQG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SnPg4JQG
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D83F404A1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:41:35 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc7e79c1eaaso97852a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168895; x=1792773695;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jEJ97sHk/x/xbxPLBggfBfex4H2iyI8Y9+kyslOo7Q=;
 b=SnPg4JQGpBlgG+C9Doj83ZLnQ7Y2Rj0kcKn3wKjpHCxOT6iVoiM8X3H4pOcQEdAlvZ
 srBIFjx/glGnEwji1Byq4NYb+MM89l8ATtkgPCuW8wR2qI6Tlchu4jkUah8ccflmAfG1
 B964sB+wzff7qIHa/4KrOjevUcR9gmBWIcRF2jmp2KYIGBeX4d7gKZ13OO8j7kn4iQXG
 eTpodL+1q3EBDkXbUP9r7x6ENs+V/yjKv6qD231pQpUn735mIXMnlFnNNsdp1UEcan+k
 OGH+oEpgYWId+iSnej8+ApqjPS1bWn9ZDxUexhfqsCreYxzRuLEH51vEkP27ao7BQoxn
 g5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168895; x=1792773695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jEJ97sHk/x/xbxPLBggfBfex4H2iyI8Y9+kyslOo7Q=;
 b=zK8/jQgnprGxsqCDpa0YsbFti+es22kXthHm2vdxe9/UFbFh4c/rw4C/JEU+rIbswe
 bHuFfr/5Roaqrj/G01edRMPihr2AUQPPEAJELTBgl6wnNd1OssAMAdfD6OkCmBOcTbvN
 z5+929eSqzoeMp9SVUcGc423FsG7YHlEvGfiGdD87hoA1EJlxL73/zSY9OfEfJAy/zvs
 44yHdfbIwvzNsp4kvAxDnqTEyaBrLzkpwiMAm2U8vKJAlnfRk4MB/44Y+65ifak2x6Af
 8EZSgDoE7JsMMdFU0hHQkJc4zGoVfT97D9tUR/hm8i+tpJcPHp8kniPnfOdWOlskg6Da
 FFNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl0DXdUGus9QSDnDakjn9X2DFWFt3IWXxFAx9TM1vy+htnkXdh39ZXeHkfOBQrp8yxjYIc5u0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJnrDbATcPkOtVqNUVBp9eiXMl54ysd6eQoxndDdG6Y7I6zBKpL
 ekOMPD8K/dpIFV1QE61YNA8PdCuwVfE9JWMXH5QO+rE8qNu+d7s1Y1+O
X-Gm-Gg: AYBFou2Pcs40bN3Ox81yGymd6QD4cqTfDaEedFuKG0RS9CUw6vCoNsFh6pWg9NdW+Ah
 +GKlKooIFrajDcEboZ3L19KISh97Fd13r88BjfqSQdXr2FFUOAyQPZmHWaNZmKG5fSn9aXyPRHn
 e/VCsXpcsv4Jvmkl74lENSQHcUNQXN3AI6goAdklAESy4Tczn5xs77yEwn66QwzVWfPzJukYvJc
 hvPu20Mbt4Ljfl1S8bsIuvwKPdZqicLifBXyBg8bkYzPddUOa0oBwHTtgcqXsu403rz8a4bg02l
 5T867anlfd/A2qgGMLn5DKccp6CZbKPs0OaGOnEbGyQWtqoWzVeZOMFzi/y9sDuGMoK2OmBDhTj
 QduAmcaVuN8Ql746x+6egMwKpMGYCUz7YFz5E8Hsxhhm8f7YDsx9PoIjLsGTODNs8aqSnlMJdSn
 evhV0d3CD8ydVd5c4Nc6InnaHhuIpSSxiWIJXdEWJkM9NaWcm6qZWFqa+NVd8ZufdYhEIvdSJHR
 8ffIhBfTBtdzd1HBYVsHB/YNia9FKZy9AjeYnX1CCnLJRLZg0uUQOThlf0Owp60YmWkfhacuSVs
 01MRVGQvopNLDpXtz+adUHgzibs5BDV3b6yq3MM2OTLV8rCI8xnjA+M=
X-Received: by 2002:a17:90b:1d4c:b0:3a8:cb54:e132 with SMTP id
 98e67ed59e1d1-3acef148617mr341435a91.49.1792168895355; 
 Fri, 16 Oct 2026 09:41:35 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd65484fe24sm1413263a12.3.2026.10.16.09.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:41:35 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/3] virtio: rtc: Add virtio RTC driver
Date: Sat, 17 Oct 2026 00:41:31 +0800
Message-ID: <20261016164131.402292-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as_b-1hWbg03DGOJ@google.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
 <as_b-1hWbg03DGOJ@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Kuan-Wei,

On Thu, Oct 15, 2026 at 03:46:03AM +0800, Kuan-Wei Chiu wrote:
> Actually, when I sent out the qemu virtio-rtc code, I also had a local
> dirty version of the virtio-rtc u-boot driver, but it has been sitting
> on my TODO list. I might take a closer look at this patch in a day or
> two.

Thanks for taking a look, and for the QEMU device that made this easy
to test. If your local version handles something mine doesn't, I'm
happy to fold it in.

> I would suggest leaving more time between sending out new patch
> versions to give people a chance to review and reply, which helps avoid
> spamming the list with rapid revisions.

Understood, sorry about that. I'll hold v3 until you and others have
had time to go through v2.

> IIRC, when I sent out the virtio-9p driver for review, Simon made the
> same suggestion to add a timeout mechanism to the loop here to prevent
> potential hangs.

Good point. For v3 I have the loop bounded with get_timer(), giving up
with -ETIMEDOUT after one second, as virtio_9p does.

For your comments on 2/3, v3 also turns the device types into a
bulleted list and retitles the patch to "doc: virtio: List the
supported device types".

Thanks,
Hung-Chun
