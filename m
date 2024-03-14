Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B696C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FEFC87F46;
	Thu, 14 Mar 2024 05:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389755;
	bh=SdLZiYzUHJoWmurtbbreJhqHRNkYsUp7iMwt9+g1YVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Haz1RmtAYTMEddcNATDQmgnJcKkYGtNZptifcGBaZE41Sj/Fz2kxKxgjOFwRVD4AD
	 m97p5f87kxhWBn0qp+ujiS7UjJCuC9IV/ymXlqrQGGZl4ksIhegpw8xH8aj/K9FAVN
	 fyeJUbZOxKsVBYxb9KcWo67LXS2Z64+4OAOwegue0Y8QaFv3cTBe/yXgiHgIRdrjAZ
	 l3QpoFGTSa5FFZATgSZrW2yEzwMD+ckIulhsYrKB2DpVewBLtbNvhO61XaP2N34SXp
	 4UX2DG4NIVnOWZCwxkctYBrs3qGG1xhOyjMT/M2di0i3moWIx0WMQipzMsp2eduK5b
	 oLx3vGS3wbrBA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EF50887F3F;
 Thu, 14 Mar 2024 05:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389753;
 bh=SdLZiYzUHJoWmurtbbreJhqHRNkYsUp7iMwt9+g1YVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SbjplByDlwUsgmyrkd13e1B7mKRrLqbHhYAG5TgxUDDgG4rSNmOSTbxDrD6Jq3+GN
 3BA7Y/yqGU3K8mlI/Lh+SNrezY16ns9Y9VP0TdcAq6Ux/8nVlLAAT2n7sFrKUO3+ja
 YcoM0zWUBaxKNGejJuj2vxtRUB7HS4vp7cTuy8KNaWAWUAY5knQ6gS37+77r2/8eEc
 0Icd/eUsSOtYa2B3V/62qpU9NLRqGN/Z9YPmGn6uDSbf/d4ceBTQJiDF/81ntIV87w
 cxden8XhqIMjPNc5t5a4W8bklRXJrXIqM46LiZoWa9aSj6VCn2XiEoLqyhMiUuNn2J
 5+cEkBgMbZJ+g==
Message-ID: <cd1d4c59-a30c-472c-a793-9a5516108abd@denx.de>
Date: Thu, 14 Mar 2024 05:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] imx8mp: power-domain: Add PCIe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-6-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-6-sumit.garg@linaro.org>
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

On 3/12/24 8:03 AM, Sumit Garg wrote:
> Add support for GPCv2 power domains and clock handling for PCIe and
> PCIe PHY.
> 
> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
