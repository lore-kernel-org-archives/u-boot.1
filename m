Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D60C4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB5887CBB;
	Tue, 31 Oct 2023 13:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698754852;
	bh=RErnURMyt6oJ98n9DLRP2fnfVneFEPYCCNqp0XFoDlc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siOxxdjuPwOkHHSYS7rAdy5VGu+Vyl3vc9pHfbARgoDD6Lv+7YsHID5AiOvRdEPH9
	 1sQUjmlxRp5vuEMezwJx6NLqUYCuJ3ii+ozc5UECSWUdRwvwnNkd+aK0ApqENCkYK8
	 Qbvymic++AQKpk4XbMyZeLnFG21UAXe3ipd8PHQLlbPCeTC2kOa70mu3+f0AKtFMKG
	 xC/3aTRuUQ0q8LVsZWysvjp8jV85cCJbY8FRrNFgaXnpgNdc3xiHJjJ7h4gXfIX1F9
	 j3pNMeF36TvQDcAWMt2Lw7/JicY46RFoCBpRNYl+lo+TndX/Kwwn/0mEpVqJDBw2cK
	 83mWAlvNTlExg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A157987CC4;
 Tue, 31 Oct 2023 13:20:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698754851;
 bh=RErnURMyt6oJ98n9DLRP2fnfVneFEPYCCNqp0XFoDlc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wB32iaQEbom6EaM/T7JMLc96KEVA15VtWQuoIQoC1WjNb3/tmZD6pjCdsa434m8fx
 0R6ZVd+b51VWXOE6DLBD9WPbPtYdpBhTQXvoUuJP+vAkAhHv+G6zmVI4fI3ezns443
 0BzccvbB76uK9CMr9OXN7Vszh5dqQ9E6l7H7HaF++1RDXuTg3d33GP72SIutXU/Tg0
 AWuhySHF6sQBCr0kCVzVhDtPQxBDEyrSj+cQf7EA4KKcOtQyWwaUCXjERBJ4qdPzyb
 SdNg3A8cFbpK7ZtB2i+xXx6Z+JvBR15xW0OClnQk01PthpL2H0071yRhrCRf1fgwHi
 gNfFlJE5OZaTw==
Message-ID: <31dbcdc5-f416-4486-8a75-a861bd9c83b2@denx.de>
Date: Tue, 31 Oct 2023 13:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: mmc: Add mmc reg read command for reading card
 registers
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20231031101621.24926-1-marex@denx.de>
 <CAOMZO5DjnYOouRo9eH9LU6QPXcfSmFByigt4YtTu2KvGAWcj-Q@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DjnYOouRo9eH9LU6QPXcfSmFByigt4YtTu2KvGAWcj-Q@mail.gmail.com>
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

On 10/31/23 13:06, Fabio Estevam wrote:
> Hi Marek,
> 
> On Tue, Oct 31, 2023 at 7:16 AM Marek Vasut <marex@denx.de> wrote:
> 
>> +config CMD_MMC_REG
>> +       bool "Enable support for reading card registers in the mmc command"
>> +       depends on CMD_MMC
>> +       default n
> 
> "default n" could be dropped, since it is already the default.

Should be fixed in v4, thanks
