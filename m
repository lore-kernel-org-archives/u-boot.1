Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3457CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612078710C;
	Sun, 12 Nov 2023 21:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699820759;
	bh=9zx+jq5RdM4hbFp6FdzSDtTdSrqCCSbqCL70VFWeQ2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S6zqSIXDRqJEJkpfad3/sAJxwblSChxtPNpxuKYVcGBIxT9HU+fSSypi4vomctcSM
	 zglzUtppHPvuW1vSwXLt2U8xzI3fV2A/LpMggECLGF1l2FSWjMN3amtzhEoyI36dJO
	 g58mrwlwSzCYfj7b/mq6XYWNdrkRx2I9XrSYPQp97K/31x4QNz181xRTmXpYPHF6iJ
	 qiuVnI/TvyH8ebiwRQ05PkV3V7yjkT1wRfpS1xxVn9kVWBp2qbxajA0jWQev8Mev/I
	 jvtw8yHxzAQAbiQMnRrOD1E3fkglcIgHxfbNMY2xwEDUdafRZ9NN+dijna0e9B791m
	 nmLVGdKkfnK7g==
Received: from crub (p508b605d.dip0.t-ipconnect.de [80.139.96.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B82C787134;
 Sun, 12 Nov 2023 21:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699820757;
 bh=9zx+jq5RdM4hbFp6FdzSDtTdSrqCCSbqCL70VFWeQ2A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uyy/BPwWjaARSbeCWmPouEajhDeucz8YhvArFHv2qgN/AmFZ/d563oKq1hHM7cU2y
 3Vqohn4Ea/GvL1gqQNCZ2sMcHFP9q8t3cbg+keE6loavw3fsvggGgT46N3O4os8LLV
 uRqaoWEc8HAhcsQiHreBAp335Acaj1Z8uWYmYlllj8VgczykFmFewDaA3sG1ne9VVD
 PO9TZ3I+yXl9wbUh6yquyQkKMC6ZrPQ48fmIxrgnLpuxnH1GI0sF2i8DCwCo4Lkj+Z
 D+6HNE4iAZvxUEBRwSFVcV28yCmQDcK4g8arHsW2IQ+bka1Ybl8KrwRw1UHi6yu4/N
 t4A5A/30MMygA==
Date: Sun, 12 Nov 2023 21:25:56 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 07/12] video: Correct setting of cursor position
Message-ID: <20231112212556.42291df0@crub>
In-Reply-To: <20231002011450.462468-3-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-3-sjg@chromium.org>
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

On Sun,  1 Oct 2023 19:14:42 -0600
Simon Glass sjg@chromium.org wrote:

> The ANSI codes are not correctly handled at present, in that the
> requested X position is added to the current one.
> 
> Correct this and also call vidconsole_entry_start() to start a new text
> line.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/video/vidconsole-uclass.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Anatolij Gustschin <agust@denx.de>
