Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E89D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 00:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 160BF83923;
	Mon, 29 Dec 2025 01:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wSfY2nRW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ta5bYt/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724D8838BB; Mon, 29 Dec 2025 01:42:50 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8026A83759
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dfcrS1j78z9spj;
 Mon, 29 Dec 2025 01:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766968968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGLBd/zrP/g1vgp+7tgzT8tqKR/QC+I7+NdVCTOWPHs=;
 b=wSfY2nRWTT74ytzjAF65k1iTOM8qhPQYTW9LWG+0y39XX2Uzr35MSELkxUNyjktb0l8hWJ
 WRQysM2XVKaNTlstexSKjfxOMt7QHOBYkn4jpZgT+JQMDYkHiReGSO3XbkrhfA8TJfI7YC
 xh2X9uID0EnUFSoLs9xA0y2sz0VLdVBqJZVMGBUxtbC92M/BlE3yL7OqSwOc3V5vLaiDlC
 rK7ZtqHPLtaWzbQoPud6HSgODQQD5RNGzAeJ0MAEBQdxRuzUDAAXEHOFN0n/ETI6Jrnvzo
 GOFMNkK0M4ZJ54uUrmLEPYqNIHs2j/MSM+XpVOmjiKyM1hOuUyXoNx69xXfqVw==
Message-ID: <6c0c3023-9273-48d1-a36c-44c32a82ada3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766968966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGLBd/zrP/g1vgp+7tgzT8tqKR/QC+I7+NdVCTOWPHs=;
 b=ta5bYt/y7qRgEWfhwtRsWriRN8xMHbF3Rg/f3dNvxvkDhSFQAHQ98BSUqBkBeMwfbwuCEC
 HkiP4ZVcyordyEBvbK2ZGV2Y+MtXAgYL03oUcQ7mGPpf8mrjVRrq7v88XDOCOsu7B5xlt3
 cKRUnSq3j2XVSVZjLJ3wV54VBwBjgvzQpyRWCzid4g3XkbEyIoSxm4zzYg6xpKFKrXR8S4
 JTXdzvFcpr40awtBzVM6w/J6x4QbpR3Oi+9sTbkRx1GzBxqxJMicG9K9Q85Uw+InogsFRI
 C282cZC+BkoQP6iyVBkg3hNM842C+nwuXghX0JmJvWpN0pR83IeTZKKgi9gh+A==
Date: Mon, 29 Dec 2025 00:07:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] clk: renesas: Do not disable realtime modules on
 R8A77995 D3
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228220717.3630713-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251228220717.3630713-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xpkfsgbwrdwwyfuzc3ptbds1ymbpmykz
X-MBO-RS-ID: e057aae1ea217711922
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

On 12/28/25 11:07 PM, Niklas Söderlund wrote:
> Later versions of the datasheet makes it clear D3 do not have any
> realtime module stop control registers (RMSTPCRx). Remove the
> manipulation of them from the module clock table to match this.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
