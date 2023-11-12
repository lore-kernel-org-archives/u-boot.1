Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB1287215;
	Sun, 12 Nov 2023 21:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699820865;
	bh=H/C4ED0Fehfty1JznnN6n716HrwNdSZzgaJlfNT23pM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y22c3NUg1dWYTkJAnwklLJYh9qkRJ6CmVoMHwvlA4LPC/kKkMtcZ2W4H25sK/cP7H
	 YYiwLPafFaXyRoFc2zJtwAtWGpl4BN0N3/8SwT70TJpFroO96KdEC7sHMYU77KzO/5
	 wiLjaV9qjfHcZlIw9Ih5ZLCkCR6cyqNLhumWkccCXSgk9m/fiY4FHAGgi1f0Zr2J84
	 Ltwim6IntttDcyCBmACLMco84aQUmIoCuIsxP/zilECnINg/1kMAadfsSCkAD3AMwb
	 C3s5XZFxGg3dM8fCKBmAhibdQ+WIiCdmteQM9wTtEM5o7XJjX7MbVU7yuCFVJhzyke
	 /YtUZKDY6h8xg==
Received: from crub (p508b605d.dip0.t-ipconnect.de [80.139.96.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8281871CF;
 Sun, 12 Nov 2023 21:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699820863;
 bh=H/C4ED0Fehfty1JznnN6n716HrwNdSZzgaJlfNT23pM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eaOYeG1fTkg5rWLqX4B7ZMdne6YZ1+LmXtiYAG3H5dWH6AnnqflYr9U5poyqRDANW
 Kkffzy8YBoMmyCKTw70xDPiIGRX9DR+156JoCl7lUcxYUuccpaRuaj5Ps2VR4cDv/y
 m07RtyI95H8rQRmgkD55H4s50e3QoxuNrlPOtb2JToR7bYmOIHEnnJhWphd2Pd29h5
 ZpXwbEByYMzyExNNROBnDeCCGabmPBJznw/K15Wu7lRIiZULMrKNCpTGqY7vi8xjWQ
 BFjjZ9JPuQviak8ZxPleQjyoYGVt//Ige98IsUaGC3geBrDwuQEfl2CWluHSkkgCxV
 Q+GV7jJ+EzXbQ==
Date: Sun, 12 Nov 2023 21:27:43 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 07/12] video: Correct setting of cursor position
Message-ID: <20231112212743.4ee65db5@crub>
In-Reply-To: <CAPnjgZ0r2j7iRY5FpcKVUx2AHjaKDwtdL1Lars=MJbBAEMAOkQ@mail.gmail.com>
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-3-sjg@chromium.org>
 <CAPnjgZ0r2j7iRY5FpcKVUx2AHjaKDwtdL1Lars=MJbBAEMAOkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 12 Nov 2023 13:01:11 -0700
Simon Glass sjg@chromium.org wrote:
...  
> 
> Any thoughts on this patch, please?

looks good to me, thanks.

--
Anatolij
