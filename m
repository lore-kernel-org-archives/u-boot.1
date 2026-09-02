Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D005C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 18:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB84080F48;
	Wed,  2 Sep 2026 18:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFvF-XOy4V1Y; Wed,  2 Sep 2026 18:03:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788372222;
	bh=KpYmFzfqCJOjw2EwV0gbnmqqysK8xTn2k1XGJ7IvysA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GunIJ76huHQ/4/V9kORwwcgSO4WgTrbt3g5d0CWYuKRsNm4HeHFy3Ftut0NJYB0qE
	 614VdK49nfSrg9eGfQlEn71Et+4OHsM6aqq7f3Qan5hok7y80sF0nib4WN8f04Qnhl
	 14hzmeu38U3cVBLGA1ulCed2Lfx+cyupWwFR7GQhUD/DmZKj7mIZqoxUoEA9TAaYZ4
	 imv7dKjSCau+oM4Wazzvy1jWl8uPVKDuyeIpYhMLVbdnfdhYGSq/0ICLCrDnRHvXWV
	 +gkr2TiyXg8wcG3ZU74FEHv8pdFpa+Ck8mzOTqZd2K+TgsKZsixYVXDnodOJtFc0N4
	 T8ZxYN9+LykFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF7D280E8B;
	Wed,  2 Sep 2026 18:03:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5ADF1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BA8680F91
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLS4c_1AmqTc for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 18:03:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=QRbvYryq
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBAB680F48
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:03:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hZrFM4XnXz8sp8;
 Wed, 02 Sep 2026 20:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788372215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpYmFzfqCJOjw2EwV0gbnmqqysK8xTn2k1XGJ7IvysA=;
 b=QRbvYryqh7lXdeBNg+yMUd1Lc6wEhQpHr2ZlsYbsSVyRjvV8ELz9/3fnMFMk8ZkqtpYTSG
 3IAMzNNKjmli2xuK6uH0nKglxpSRuh3q1kAxoAG5ftALyE1qOXNVEAsKB3xxCoVRkPUJkV
 fOWy59Ny/M0E9GwkWtVqhietgF89S+4BHYAWumH5VGuhB+fFhr6pmkvMl2TDhiQwjFB5yw
 GM0dSYHXQJHKzhQnVKRV3CQJ3EI4D78cjewFAETKAycPMLVidNDiLWA/Og0l5a1ePVBuru
 Xp+QTk5+nJaO0Amy+Vytz4QNfePJeOLkPSPftYOzIza+PjxTdUuqWopHr8W7qw==
Message-ID: <44c5b17c-de5a-4002-b9cf-71f8cf6a1837@mailbox.org>
Date: Wed, 2 Sep 2026 20:03:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
 <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
 <apHK_Q-dogLc3Mkr@maple.netwinder.org>
 <89aa40df-e38d-45a0-a422-4ef045153771@mailbox.org>
 <aphaDa3N37St_dr1@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aphaDa3N37St_dr1@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1npdchbqsdktp7nd1a59i8sfoiyh8e1p
X-MBO-RS-ID: 0310ab1a337b1e9dd2d
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

On 9/2/26 7:17 PM, Ralph Siemsen wrote:
> On Fri, Aug 28, 2026 at 11:18:30PM +0200, Marek Vasut wrote:
>>>>> +    select SPI_MEM
>>>>> +    select SPI_DIRMAP
>>>> Shouldn't this be selected by the SPI NOR driver instead ?
>>>
>>> The same driver has other users, but they may not all want DIRMAP.
>>
>> Why would they not want dirmap ?
> 
> There are currently 4 defconfigs which enable SPI_DIRMAP, three of them 
> are AST2x00 and one is imxrt1170-evk. I would be adding a 5th one.

Talk to Aspeed / NXP maintainers and ask them to test it.

> However the same Cadence IP is used in many boards, including TI K3 
> am62a and am65, k3-j72xx, and also on Xilinx versal (based on looking at 
> compatible strings in devicetrees). None of these enable SPI_DIRMAP.

Talk to TI/Xilinx people too.

> Lacking the hardware to test, I cannot say if enabling SPI_DIRMAP for 
> all users would cause problems. I would prefer not to take the risk.
You can do this in the SPI driver Kconfig entry:

select SPI_DIRMAP if ARCH_RZN1
