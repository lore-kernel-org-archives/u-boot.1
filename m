Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C58CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D63C60631;
	Mon, 12 Oct 2026 07:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6coasCiqqGIE; Mon, 12 Oct 2026 07:56:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A17660602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791809;
	b=FFiUuINYhBFp7L6mc1VOP9WAZ25mT9rvfl6BUXsS/8rzijtADQyo0du1gnByZ8z0yxf0
	 hZSveKfZ3BEuMPZjDIlCTxBlM+BjpS841O8zF2FS5goqSzhgQEofQSINPJvaqiHlLJN67
	 Gwk1OSmKBaZXC1h77jN9Hav7MF8xD2FLT3ChiuCRjKX6YaxdkpPmxsV1ui3bIqzFFT63l
	 GgVCksVY8EhUl3l7rBl/O+K2I5/IQ9fXmvweU4rUI3r1MwaGONuldEd3acvotHGOeJ5GK
	 zybAdAh01QcqqRbLxbqBeuXOdwFDxjrSuyiW2NGUqEVOoLRci+IE0CrtWKi+5uX5PPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jiMSWzXuC39qSouaPEV9Hp2BmPptt30X3DEvnbLpYfE=;
	b=f+JPpoe5nCU+NmWBvqVGZvisWzBL6R0I+vHKW8SEf7TY8uMWIIIzu2P571ZU5D8LY6F+
	 XouKC8L1jPpeSXzV0Qy3ExP7bemoAT1SJX1mwqUTfgk33lKpREssoOhYIZjN+78Xmh92N
	 r1m9SifVguVweafgaBNqSPZJvjkFrC2DbojBUK0hhY0T1EQnwtB0Md5ArCg+mlw3dgsBw
	 lsgBoqO+3cq4mCQOAhzegLiUWVE/C+bLHdezlaAf9B6zmphdu0nSHEXtyVEjMWIRfAMIo
	 XhipGoHB99lCNUecVW1mlWbphwR1Q+VbdXyzWFI6x1x+pUyAUNmL2CilrG/pHkSewZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791809;
	bh=jiMSWzXuC39qSouaPEV9Hp2BmPptt30X3DEvnbLpYfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dewYHNkpZMhzh0tn1p5wY8UBlSMdFkCHDkWk2zvWPcKulS9QUOu+glZPKKdtoJDvz
	 wfe7PO7ST+KckJjd3EKa2xezIXJq1FWbFungOArQs2/1hky9gst8tC522iqlf0s8Pm
	 D4K/HhwPhs8XuW37OKOJyQkN/E3SW6Lw9jkePBmKLlnFYUsX4MAPER3XBsCrPr8J8C
	 +wW3yPgxkC/43aeS0c/fmgAnSQh9essl7ZENG9f9lJAsCQp2LnG1XARcOK57Ovon88
	 Xm96lVZEsGrt00FDxXsWg9a6bcjAHqEyTpW4ftsKrxKU5hjqHPOvLaGsAtZvtricYX
	 ZTnT/kemRkGIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A17660602;
	Mon, 12 Oct 2026 07:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 778DA2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 695B64002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSAMT1O0X-5B for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B558240024
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791791806;
 b=oiLN3cIdJmscDKv2UaYlgQ/q7LvStH+KEFL5OLYfOAZrgw8kgmWW6mZHVndrxjo4xD52
 ou3cEdaIF09R1PTurBckhD8sH7MAyy1r5lplXN1dNr14ObUqIdPzHuHGborrxZIWGGqUt
 OP8xD3z+lc0VUpwrACUGSU4q0HpA0f2PR+TA1x1ZOcSQteKJCeTFxy14uBfZ5nh9Tx2G1
 qPZQhJcRw2t0mTXM5ZdTKDz9/VC6sMX/bCc3l/6epgVh4KFOH/iARi0MlK8mj5+AZB3gU
 M5c3XGkZ+5VTN9/p8Wj6/GaVfFVCbrasLxivl0dPMVFCHSACxDubSkouTXsOJYbVMQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791806;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=jiMSWzXuC39qSouaPEV9Hp2BmPptt30X3DEvnbLpYfE=;
 b=tfzX3YfFRe6H8jdDkrWwtLjFKg5JnxsyDaeqoQDBSN2+VdUYPRB5f/AOP34F/TaxqrBj
 0YHf2LlRiU9Aj1Jo64ojoGRzfWU7wNne47WaBSsPDEpZuW0B+Y7cE0Vq13A40QE8WkV7J
 FMqXuMDsyagEkKFM3hCqON2/NrwnIBPLNmoqkoYFjvXUhbiSk9Wg+zTXP6gFhoh2JhUMB
 8o9kd/LbV6UQf+Xb+5pE61v0g9AzGSL1vUyEFXClr5oizVTiqrGy7tl+ey7G8uqDSst+A
 0BHzqBoG+GR5Ayb0nvKeL6wILmuoRgDDkxTwxIISXJYxM2Lytt0TnHybVARbB4ajRWg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KcgKKUUK; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KcgKKUUK
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B558240024
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:56:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78CA560DA2;
 Mon, 12 Oct 2026 07:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E391F0089B;
 Mon, 12 Oct 2026 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791791804;
 bh=jiMSWzXuC39qSouaPEV9Hp2BmPptt30X3DEvnbLpYfE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KcgKKUUKrWFf2ii8+HRMk6899RMGKnUn9E38vEqn2QtrKVUaUDIC3gnDkZOcIxm4D
 u4/tfHJ0ThKjqr5Gr1AvBxJD5lsDWr2+GosNMCpZmKNxOsMPYjEObd1zFmrfh5yv7n
 BCSc5UH8fKUE3wfnFnczOZDv14VXf+z3FvZ7EYScd8TMNaAGqKUbYaakYfaSqk4WHf
 u2ixC/rfdu6GGy6E+DIs4CCwyhe42SMbnWR9IViyjr319l+Ud4AQ9AGoth/wLxhQgG
 /wd3sNO15cq82dDVpTCQJUB/+UnR9QZOR6dTlkc2EXyntJDKOIJFFaj/FnSBSVao8s
 YWihJIy1+SRpg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: E Shattow <e@freeshell.de>, Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Suhrid Subramaniam
 <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZug==?=
 =?utf-8?B?5paMKQ==?=
 <Macpaul.Lin@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, David Lechner
 <dlechner@baylibre.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
In-Reply-To: <1b3febf5-71f4-4306-b0c9-db65794f5041@freeshell.de>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
 <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
 <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
 <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
 <1b3febf5-71f4-4306-b0c9-db65794f5041@freeshell.de>
Date: Mon, 12 Oct 2026 09:56:42 +0200
Message-ID: <xhkdbh5ir8i85.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, Oct 10, 2026 at 02:16, E Shattow <e@freeshell.de> wrote:

> On 10/10/26 00:44, Carlo Caione wrote:
>> On Wed, Sep 23, 2026 at 10:02:34 +0100, Mattijs Korpershoek wrote:
>>> I've just applied the series. This means that they will go through CI.
>>>
>>> If everything goes well, it will be send to Tom for inclusion in next
>>> when I send my next PR.
>>>
>>> If there are some issues with CI, I'll let you know.
>>>
>>> Thanks again for contributing to U-Boot
>> 
>> Hi Mattijs,
>> 
>> Did CI uncover any issues with this series? With the v2027.01 merge
>> window closing soon-ish, I wanted to check whether you plan to include
>> it in an upcoming pull request.
>> 
>> The MediaTek DA series depends on it so I'm trying to plan in advance :)
>> 
>> Thanks!
>> 
>> --
>> Carlo Caione
>
> Adding my opinion that I'm also positive on this series for the v2027.01
> merge window.
>
> All of the starfive_visionfive2 variant boards have some form of
> SoC-connected USB and BootROM UART loader, but not always networking or
> any physical access to eMMC for flashing. Without this series, then by
> the moment of opportunity when we would have U-Boot main loaded and
> could use fastboot then it's already several minutes' time of UART
> transfer (of u-boot.itb) elapsed to get there. A proprietary vendor tool
> exists which is an SPL loaded over UART and serves this same
> functionality. I'm excited for the prospect of replacing any proprietary
> vendor tools with mainline U-Boot :-)

Thank you for reporting back on this. I also think fastboot via SPL is a
very useful feature and I'm happy to see that it can replace a
proprietary vendor tool.

I'll make sure it get included in the merge window for v2027.01.

Sorry for the delays
Regards
Mattijs

>
> -E
