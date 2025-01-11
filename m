Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73066E7719A
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 01:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B86801BE;
	Sun, 12 Jan 2025 02:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736647105;
	bh=pzgIgysORourI/knECVu3iftO/zC+5ZWS4HYvnJNpMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OoBGL1I1wzx6akAt7PHjzFcOOb34wxgfJ2Od3GdWHjnfzO/hafBKADh4USf4HnIR7
	 Ja0FgMt7Ca6tvG5Yhn6Z8I1t/foLgdvWo2t8GUm8+c0Gh7t0isCu8nXLEvGVS6sr+z
	 qjWCikAJeq7vL2ZQaqPH2e3qiRcV49wqkEA5P/J9Uk6s0Wpq2Tntjn+7eDr1w9g58T
	 +hq48XnbR75LwAZTvhdI80ND0V1ywR6fHyjeWMjxlGlF3QMgivnkMgW07LlN0rL6ql
	 T4o8xxu+Kbqao3TD6s0aTfRJlO1cL8hzyDuMUw64TgQocvkghMN3YUcp6/Y+bpxupJ
	 mIRMbEHNSCvQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5379A801F5; Sun, 12 Jan 2025 02:58:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E332380137
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 02:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iD1cMIW8"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3AC2E101D2390; Sun, 12 Jan 2025 02:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736647098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzgIgysORourI/knECVu3iftO/zC+5ZWS4HYvnJNpMY=;
 b=iD1cMIW8mdoPtMiZVY35UtIlvSUE88/wYot2MEnzs+nwOmExiXXuWix+GFAuTvqatXgCoI
 QBrYDDw6XOGjgYFUZuIOjZvfHpsHZhJbeoxY1B8lS3C6tSHE9W9CcQe55qMrf4t8YtewCp
 sQLbFo6a9LFDDf+z3S1c3tzXipdrDTEhC/ErCiogvDKOwZWx0ZnxcuDEvA4hFTcI/FR67d
 8ivXNkafB4g8QU9QmBuZhST2ks9lCVIespkbw9T1il+zxvGoWHVbYXdn71FEyDIjLssRrP
 Ji6C1YaKBPqToH97YXNAwjzBTF2yzIG+5AonBCMzwfqXDk79KLOZQD8/3uONBA==
Message-ID: <b4a469e3-dd45-43af-ab73-0abdf87d4f88@denx.de>
Date: Sat, 11 Jan 2025 22:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
 <20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral.tech>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/10/25 2:55 PM, Junhui Liu wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> This patch merges flush and reset logic for both host and gadget code
> into a common set of functions, reducing duplication. It also adds support
> for the updated reset logic to compatible with core version since v4.20a.
> 
> This patch mainly refers to the patch in the kernel.
> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
Reviewed-by: Marek Vasut <marex@denx.de>
