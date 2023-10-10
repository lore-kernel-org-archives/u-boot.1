Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2CACD80D3
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5778686B79;
	Tue, 10 Oct 2023 15:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696945111;
	bh=VyDuXgcg6Gzr8QEGbQFNhjBN2Y8ipedpmThpptPgs3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zniPQndhHnOKydIdUR39T5HlKAkJYna1doxQSG9hfUMRNP/Bk8txED8yXIopKW0HE
	 cV9MuAk/jF+q+FqZZ0BPKVMekHIauoHhCoTGtcb3qEjr/3Z3KKP+09LIteu4yAhHMZ
	 wEFWaK1mN80cOo+KHFE7HXLc2yOaRWo8xhIy9HAbZlf2G/yWCQ2o0CbSSUbRKEvLts
	 F56XhhTh9h8IvFd1dc1pZtlFrIDEhj5F7CG6YSSM8Z2GG8OrXT+4HY7voeDfQbjNUz
	 ZvjMJkdpok7pGm1v3QxDwIyHtga4HRN0SKx3doou9tAD5Vq+NVigSK0CFZwIMyyuVN
	 dZHu/DM/rgHtA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1D95586B84;
 Tue, 10 Oct 2023 15:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696945087;
 bh=VyDuXgcg6Gzr8QEGbQFNhjBN2Y8ipedpmThpptPgs3A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U6v6CG6EY0DAdA3eRs4WjEdSDRrHuyJrHlEmdSDlOLg/G1Jf2omKw1iFMVrqoteBh
 8B8plVMb+CBtcW2MX2MU8p7/aN/gETHGutySJMKcHY9dpgZpsHoGGQKEg+T7Cg+Uzr
 bAUQERLCSejdst2kO+TsRJnV0RRSIVX7drg5RpKoyUKRoFxZzkD/6v9QnTJ9Gm3pVM
 AWEDdCJAdgtM4UAzc2diOXr0Wso+0sUSW38+jSy2NjYa0Mifgk/eDycL7gpQ0sI05G
 Ea/NkYFVmo1AthHTQ379N2Gfqjl6GC2HdmdA/9XqEknbSJpuxKc+v2N98IupbfyShO
 EWsdCCj8k6iVg==
Message-ID: <17a4f83a-b87a-4b09-8d0e-9f6d868cbe6e@denx.de>
Date: Tue, 10 Oct 2023 15:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mmc: Add mmc reg read command for reading card
 registers
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
References: <20231009231458.354400-1-marex@denx.de>
 <0881AE45-0209-40C8-B7A8-E9B3B3F22D74@gmx.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0881AE45-0209-40C8-B7A8-E9B3B3F22D74@gmx.de>
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

On 10/10/23 08:51, Heinrich Schuchardt wrote:
> 
> 
> Am 10. Oktober 2023 01:14:58 MESZ schrieb Marek Vasut <marex@denx.de>:
>> Add extension to the 'mmc' command to read out the card registers.
>> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
>> supported. A register value can either be displayed or read into
>> an environment variable.
> 
> Hello Marek,
> 
> could you, please, update doc/usage/cmd/mmc.rst.

Should be fixed in V2, thanks.
