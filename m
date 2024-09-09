Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78A4ECE588
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F73488E2E;
	Mon,  9 Sep 2024 21:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725911262;
	bh=2EDJzRYjn+NR1P9dePVA2QCgpavb9TFDTz3EIO40MtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qb9gcjWOG1KCauBjINbvJ7ZNgWRqqS/eVIRzgjpgLsTxXbfD5dHyxaa8lcqQJ/blV
	 m5ymh3c+7XX//V4Du/Jys+oBW9iquFi16SwzWpBVq0EQ+UkAJgHorggWDcb0Z9jDqA
	 j5OYMEoUPLcUI2koI7TVUx7/xre/LmJtO0MdQMDxF0dpBPn+J/vG+GhElzTbWFEaKa
	 R5gCs0OZCnr8pXUs6iHxKd3fchuNa63KUQNp55EcXumQl2wOVFjyI+38g2PSCGnzQH
	 mq/iMZhQg/H04MmcDGgDfxEPtuH3QfgFb4ael5BiGnIYU/mJOWhJztf/a3esRaNn/U
	 vZgkS2wegBnKQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8ECFE88AE8;
 Mon,  9 Sep 2024 21:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725911260;
 bh=2EDJzRYjn+NR1P9dePVA2QCgpavb9TFDTz3EIO40MtE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k7lZF6b8SzGkrvc8z+HAcjsTU7aL0Vhn4BeVEDQxvLi4akc4QLuxEYB3glAbKV8Gk
 n473Nh29pR7yOWWYkW5Z4iBp9/IQNyMfI9WIQU3le0oV8MggUV7BVw3l2VSUrm/MuI
 4ZtKh5tGWqbfBSHQMQY97ODRvLUZcsQQWSU+LwWP6ltf9nS86STuy1ASvdLp+36hrN
 CqsHtCpcspMqm2ArsR7kl5zBXAI9Qtz3NoIfn8glRRlZrx34edEGP17roA7yENi1oO
 MltfBK+RftCcYknvNGCGGLcy+gyXsv4yg19pnYKn3JKEaIvd5TeJTMUO3/WzUm/6wq
 0zYTDL5arEGgw==
Message-ID: <e86659c7-567d-4515-b671-4b1ea03746d6@denx.de>
Date: Mon, 9 Sep 2024 21:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: imx8mq_evk: Boot regression
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Otavio Salvador <otavio@ossystems.com.br>
References: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
 <CAOMZO5Ce0g3tqWe2k47J5A74bVey7X33bzdir8DfM8zX5OnkDg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5Ce0g3tqWe2k47J5A74bVey7X33bzdir8DfM8zX5OnkDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/9/24 9:32 PM, Fabio Estevam wrote:
> On Mon, Sep 9, 2024 at 4:11 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi,
>>
>> imx8mq-evk fails to boot with top of tree U-Boot:
>>
>> U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
>> PMIC:  PFUZE100 ID=0x10
>> SEC0:  RNG instantiated
>> Normal Boot
>> Trying to boot from MMC2
> 
> I have sent a fix:
> 
> https://lore.kernel.org/u-boot/20240909193003.707732-1-festevam@gmail.com/T/#u

Thank you
