Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E61C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 264476164E;
	Wed, 23 Sep 2026 17:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVMOyYJZkmWI; Wed, 23 Sep 2026 17:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B82860EBC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790185947;
	b=JdOP8NOBJQRel0apvbhT/tdXjphiCqCsV/rfBrp2Zxodu/CGYhcOxQu3qdfK1RajoFyK
	 OjS1HvKxdBAD+7cpsAZ6u5rmeF+dvqlg8IZ5V1jhm1v24qv8KBdAZe7n5dauMmcEs7KaK
	 1VAq0MUb8VmT509hv9vDHiqOaGFrAOMBncIaOztCBI/Ev2iq1KSg5+BEnrWxLvEDis0ZM
	 XCpJPLkVYgGKIuJw16QwBQ2KABPa9V9eH9tVtGQSwvzJa1JUkuzTLpBAEh7V9G9o9fodc
	 f3hmC0nnybSxvHh/dLA8q8WgUoZPYvgZBXIktD9GYB8H0QEHbfsnmk1aa/KHCPZsbMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790185947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hqzi7/q53b/9y33txAxABpjBSPj6ahE11qEVlZafKkk=;
	b=D2WW7W6dKqkdxSAwYz4DwNOhv4J9/WoMXcencozZYW/X5n5dFtRN89najvvB1FRuTiJH
	 GI/df0o4vipcDSeKkIPF5S7XE0bJ8HRryB/QWBrgf5p7gPEQe7z4U+lIPpEwVlVc/H1Jj
	 u14yBwxJXiRaO//2wmvN4CFODlWGxDv16PHYiVegz8Rp0hjD65QIAD2JCX6tnVtLAQbh9
	 U55YYrI9UPWSp2VW9drgV5Uj45gsnR1Ekwvw9DuZA8NUibDRsq4zfp82rOueWZIMJyEko
	 czdm8E5rdEJsAgeg7L2cYOdBYrAkpgkfnCF8F4mHNNcC/wS+HY6y4L8j17ReG5chfOA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790185947;
	bh=hqzi7/q53b/9y33txAxABpjBSPj6ahE11qEVlZafKkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xW7gSNq8EAhLxTBSMLYuu/ju17ZRlKEtKsIrXT5/9tJ2mPqb5NU/HVlLWRB4yxU2y
	 ClRFTB9TwHXjJVb/URaBLf3AObZxxa4losmHPx1eBH5YyHQo2lzSS3D6I50/2ZAakS
	 rLA/PjAYBn/ktzWb3Hq2VBR2xe+Bx2JeB/xGUiUHOrZDLmaP/buANfnWpaaU1WCsXD
	 X1EH3s2zpRdmBF3vola6m7MzDDzKRy+fcrmWFcVWM7nyWvPf/Fd4d9qidLhzAK9NjI
	 S6VEHqI873JRVDxwvBSYt3+sQBwMNqTnNr1U30S8Qg84LZmxwjDvUv5EP+plO9ULbe
	 l2/YOh/eK2baQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B82860EBC;
	Wed, 23 Sep 2026 17:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D029F28C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF84241B40
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Itxlq3aNGl7 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 17:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E0F95406A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790185943;
 b=F5aOpPI/PKJ3Djq46IOKobHtZX4WeCPXTD/7sHD977DzRNutPU0hUmdniOn5AzkbKip1
 ylRZ8U72KMGTJnvQd6GzeAHvlAPoCc8+ZuzKN/VTYofMZeV5K7dptQwBHf22JCMUXNfKi
 eFvdseOCTH/VHxjboR0foDVYBJSFbkhS5lvlFexFxZeQE6SPeIOmWwZHfsaDX0mmjPn4s
 dtRWfrTj43162Oifv2cmKfrPlb7k/iHhvJoiGEeC7Ee+Rc55quKg6IxpllTuWN2qiM1Vw
 L2dFMKZYG4/+wtcFjI7REovjQ4vyXqoXEhkkimrP8yrE7wYT6HOi8Fm8ExcER8Guh1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790185943;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=hqzi7/q53b/9y33txAxABpjBSPj6ahE11qEVlZafKkk=;
 b=m7cYXLGCyg5SGyfmQV5zG1+QhaP2MrL75DeSBgZK2h8cVa12NGbEGq7mdvV6RDy5z4Sp
 Qd5OGCPBjDX42iSehWJpBQHo+HKP+C+UzgSAFjMgnJ8NYaEYvaq6UH+eSM/PihLOD8d5O
 SlV52luii/YkJw0SuwJ15/0BltodWZXQ7ZCs4aczQJOdUc1Vo+IKr2ZEdmW+5ydfsDnjq
 V4qiqEihxvZtp9RcDS9lpNpQ/TEwNMg6/EvhRPLCPf/sfvJEgzGWBCdt2bOA22c0wxVNY
 lvuKKY8nnPHWGlaH0McN4Ao3VfPrUArClfhAtkoErYd15Qaa0Sh2wh7CGYnmiIHyNjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pOxODRMI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=pOxODRMI
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0F95406A3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 17:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790185879; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d/Ov3I5BAroTYGj0ye9yqCUcxbiQAOQHL94lArVj/5P0+FofeG61VVfpcqWuBzO2/LMDLmciuVzV/evSRd1cH6FjH64EdDpQDnKmqG3uFRbArSUzA0KNjHUM7cHGJywmQ4or96jgtC5VFU6TvKNLctTfNeJ8FK7NM64dxhkDsmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790185879;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hqzi7/q53b/9y33txAxABpjBSPj6ahE11qEVlZafKkk=; 
 b=EVL0zYin8lEBSe0P1dsXguwSCpn0O8iiv6lTNjepU/G8MIPljTN2/NMG4kQ047bLhHuK6T/eMTw3ikPBTd9BVRGjhh5rAEZ0rh2fhXSzS1Kb8LaNX5etE75fDtmHFN2RYQLvoahiB4HPUD2ajH6fl+8LHuCe7v8Jm9OtIVibAKk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790185879; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=hqzi7/q53b/9y33txAxABpjBSPj6ahE11qEVlZafKkk=;
 b=pOxODRMIv2JeOAiNzimhWj9iWf63GhXuE4XRM5+mjkrc4srLQmbR+O6cF1W6eemt
 dmcdY9znBUz73gE0Nt2O7nPmdiGvaTVbdJNa480eeuADi4xHEaIQN011hoFyoaH11DZ
 KDi7r1M8LnUnzfRy+bUT8SZT7dSRJK952r7XXYHM=
Received: by smtp.zohomail.com with SMTPS id 1790185878146525.4988582365819;
 Wed, 23 Sep 2026 10:51:18 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:51:08 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>, u-boot@lists.u-boot-project.org,
 Chao Wei <chao.wei@sophgo.com>,
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>,
 Inochi Amaoto <inochiama@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Liang <leo.liang@sifive.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 09/11] rtc: cv1800: Add RTC and system reset support
Message-ID: <arQRjOUExoQro4ub@pie>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
 <20260922-milkv-duo-upstream-dts-v4-9-d45b74dfad36@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-9-d45b74dfad36@zohomail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.183.46
X-ZohoMailClient: External
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

On Tue, Sep 22, 2026 at 11:46:24PM +0800, Zhuxu Ran wrote:
> The upstream devicetrees describe the CV1800 RTC subsystem with the
> "sophgo,cv1800b-rtc" compatible string. The RTC seconds counter and the
> system-reset controls share the same register range.
> 
> Add an RTC driver which directly matches this node, enables its clock,
> and implements reading and setting the 32-bit seconds counter. Bind the
> CV1800B sysreset driver as a child from the RTC driver's bind callback so
> both functions can be instantiated from the same devicetree node.
> 
> Initialize the RTC and sysreset register maps from their shared devicetree
> node instead of using hard-coded MMIO addresses. Remove the board-level
> sysreset binding from Milk-V Duo. Boards using the upstream RTC node can
> now instantiate both functions without board-specific binding code.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

This patch looks quite large, and comparing to other parts of the
series, it adds new drivers and modifies existing driver massively, so
I think it makes sense to separate it out of the series, i.e., send a
separate series converting sysreset-related ABI to match upstream first.

> ---
>  board/sophgo/milkv_duo/board.c         |   5 --
>  configs/milkv_duo_256m_defconfig       |   2 +
>  configs/milkv_duo_defconfig            |   2 +
>  configs/sipeed_licheerv_nano_defconfig |   2 +
>  drivers/rtc/Kconfig                    |   9 +++
>  drivers/rtc/Makefile                   |   1 +
>  drivers/rtc/rtc-cv1800.c               | 122 +++++++++++++++++++++++++++++++++
>  drivers/sysreset/Kconfig               |   6 +-
>  drivers/sysreset/sysreset_cv1800b.c    |  86 ++++++++++++++---------

This involves multiple subsystems, please separate rtc/sysreset/
board-level changes into different patches. Bisectability might be
broken for one or two commits, but I think it would be much clear to
handle.

Regards,
Yao Zi
