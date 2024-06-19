Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7482C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 04:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B722288416;
	Wed, 19 Jun 2024 06:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718772364;
	bh=1Pk33CUKTvRruDG+vekgWiKhK0ZWt1IKnfBr7zE0scU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gcF3qApUASfGVUfF3bepbeGN1k1h6I0iEHrHFB7+ZEyNOSR1lR2f15RKQWOhJa0kj
	 yY+kRngaypxOUSlivFzTSAUr5HBa7Qp4kvoQ5RwXx87C5AYJQTJx0lLanhukjf18HO
	 INqM+zhdGo7ecCRlqdI1y84t49UfhRKCVk+h2mO06RQzQimdpcOICmEHO0uyHrt43X
	 vVltffFVOEZVSMjUWoHFelD9paEBSrI+y6jE8MiIDKWtuW991poLwBo0JE1j7thf11
	 dey1GM/tJr1xwiRgsUOnjot4jPAWZpQtcukVt9sJ4taSNYfGs6pUKFZTfyl14oh12E
	 XmPFZg4e1MW6A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2967F87923;
 Wed, 19 Jun 2024 06:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718772362;
 bh=1Pk33CUKTvRruDG+vekgWiKhK0ZWt1IKnfBr7zE0scU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=clPuNmoPmuGHmAAyiTGx4ksUEUZW8uCiEkwPVSrA0fY/89OXzX/wZ1iZ+SNkv6wrU
 J30bBzB6wCSr/bUNKixF6NZREhRXSQt8nSlETAc9wF+FdIMWHvh0cq2x1v7jcqDobY
 cSBnoalXTRVQplrorpYC5FKp9uII3OrJVtnihapvEfuihUpX7SfkUWcOja2iRoK7mF
 vHfdPwD6huBJYkIc/pqq27jhn4OoIy114T3+dNOvfk/fEEIBeQ+mkZU8gLofygqKRP
 9AeIPZseeFgLHb/MOtv47KFLixvV94rIaNEJdWfWT9E+m2DN0/ib5dkY7bk+9DZXcL
 pZcD27L+3jcxA==
Message-ID: <a19bd9c3-b071-42cc-95a8-94eb96ae56f4@denx.de>
Date: Wed, 19 Jun 2024 06:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] usb: dwc3: add newlines to dev_vdbg calls in ep0
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240618150359.3306514-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618150359.3306514-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/18/24 5:03 PM, Caleb Connolly wrote:
> For some reason none of these debug prints have newlines, resulting in a
> "fun" surprise when attempting to debug this driver.
> 
> The other parts of the dwc3 driver have newlines, add them here too (and
> fix some minor nearby indent issues to make checkpatch happy).
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Rebased on latest next, no changes

Applied, thanks.

Sorry for missing this one, thanks for keeping an eye on the patch.
