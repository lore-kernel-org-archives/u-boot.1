Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F696F433DC
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FFC83FC0;
	Fri, 17 Apr 2026 10:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PWjkMLBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A46F84214; Fri, 17 Apr 2026 10:14:12 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1B883B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A9B160128;
 Fri, 17 Apr 2026 08:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250DDC19425;
 Fri, 17 Apr 2026 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776413648;
 bh=2BeoxLSR6tamyAiYLM/Y/Rtm/gjd5xeGRGDr3vAva0w=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=PWjkMLBfdocrRkFO6e4RsDMCi0G6B0bk6OLuzhj/SAuQdqXs9Zgi8XNNFtiLymnR8
 ZHRSuy1ntPq3BYQzJxN7CTwEQMFAAPm1T2lSS4/o0pyTe8R6p6lHuRNNb9yIUQldSc
 wGVo181OwNDOFHvWEMVUwO3bOcPOEc4fda09OjS9iyG+nXVfdTD3WcpZaXxcz9jo3A
 g31HeZk8L36iTecdpfRf/Hf8S8c/IYJPqAKQV259vgk3QK70AmlZ8ePs7T1zZ7EweX
 aiGguhD+MTFPsu31eMc2tKkvJ7N9oYnEQGAG16y1VA8nUS43jWeQQiTm5d0xiaVtZg
 DdWFmp5Ofx1yA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
In-Reply-To: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:14:05 +0200
Message-ID: <87h5pagg1e.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Gurumoorthy,

Thank you for the patch.

On Thu, Apr 16, 2026 at 11:25, Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com> wrote:

> In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
> being freed via dma_free_coherent(), but the evt structure itself was
> never explicitly freed, causing a memory leak.
>
> In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
> with memalign() was never freed after iterating and releasing all
> individual event buffers, causing another memory leak.
>
> Fix both leaks by freeing the evt struct in
> dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
> dwc3_free_event_buffers() after all entries have been released.
>
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

