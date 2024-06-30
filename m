Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A41FC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF86788352;
	Sun, 30 Jun 2024 07:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725973;
	bh=+l9t23n7uNa406XFaRMi66VBIoDFql/R/KkiqtyiWaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zwaPLfaARrQDeukHNaP7E+Tp5z6JmL7q+9/UjoiH9mU+hz6B9mmTozgHjKCzeHPdv
	 BpwzPiQDyA4ogwU+Z9Zyg00/1sR3tkI5ZEqjQ+sEoH+yoHtOR2ZakN0+ET3WfokIvq
	 6aCqSXDRV3YdllBh4JFxgET6skOgz5U2Yr+MH4MckX8blyolSzeREBn+ycYWLfXM0i
	 1aJG0UIwXKtCQo+keSbKcQMf742nELFV5GkpqxC30NBel/vOWiV0hink9kqrgd41eh
	 jPKBvpi7bnajtnqfPq+yi/NZ4Szz3CNoZLqkb+oyKBSWc1ZimWO554Jvqx90OXUfNd
	 gF/jNp/J8ClKA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4C62B87E30;
 Sun, 30 Jun 2024 07:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725972;
 bh=+l9t23n7uNa406XFaRMi66VBIoDFql/R/KkiqtyiWaU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FKk4i3PkX8sMJLnp+GcjDqkuHivSlW3rSHyC490E5EVVOtWdjAwR+6/KjDQ5ajFg7
 FzdkSCzmdDifjJz7hjIxkWjfcF0Faq/R8SjFOn2SNeHJJhdWx2yJiqW2FeUwV1qipV
 9FOzxw8544BHXQJ5lmcwQK+Ry04xfuPAvz6D2rL+o6VC9WOgs43jsHXmmoicQtr9G7
 9F5m0SIvGPDv1aOTyeVpvCPHqBaI5ZHIf2pJHn5lArvHgrrISuWXjlMIxfICCDwAUq
 AtvEDcRwgiHmnLk/WDZOsFbOHRCjHMsuyuCvlxX3wb3XdJ0ieytAbi/orZlu5gUVGL
 ibaAvJ/S5HfhA==
Message-ID: <cfc92627-0592-44c3-8fc4-bb9dd25fcd21@denx.de>
Date: Sun, 30 Jun 2024 07:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/5] net: dwc_eth_qos: Fix header to be
 self-contained
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marjolaine.amate@odyssee-systemes.fr,
 neil.armstrong@linaro.org, n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-3-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240624083450.90297-3-pro@denx.de>
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

On 6/24/24 10:34 AM, Philip Oberfichtner wrote:
> Before this commit, usage of this header relied on a specific include
> order. Fix it by including all dependencies.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
