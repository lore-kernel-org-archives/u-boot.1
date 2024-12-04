Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D7E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 11:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C42896BA;
	Wed,  4 Dec 2024 12:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733313546;
	bh=DczJN05pk0rjt/k3zjzDDsw5CrH9n7RBRTUoFCJe/Jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjS63xaAN9+i7X/dbMLchBsY6d57s9bUJAJ4+nH/9KQ6NHlI8su08A/oTnkvSCMON
	 ZJMh430oogf1SHznK2qbpB5HWHROhO1S1BaBz/ooSp4ZOydOjNII/8d38YUByecZvm
	 4VQDN5SBk3AATzn5ZXiZyaxyBeK56mle95RlqFcx8RfiSpdnh72gCR+WtlP9ICuq8A
	 AxldyQ9qc3hMiuAoLigK1SXlG5/Mh0/kqRg5W7JpQPcilw26HM8V4yimwJJZLBHJQV
	 Jyf1uGZ/v6uxNdSvuy75OCc6Hphfuh1vIpJ1lEYv0vyF6e1WJoha3gGCD88iDxDG7H
	 nOssZELaU6zdA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7E49F89221;
 Wed,  4 Dec 2024 12:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733313545;
 bh=DczJN05pk0rjt/k3zjzDDsw5CrH9n7RBRTUoFCJe/Jw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k0byN9dD60ScYnW5RfIUxiLPPn1wBy0Q2CIQo2ECeIZGcZCaFhQ2F4EZs+q2dIifQ
 FruJqsJAsyZxEpD7sEkkDxGEqxV/869sAEAOyDeBLwACKw3IifvhcyEeQBDpaMQBV1
 vFYVdlnz0H1YpAw0agVMx5PPQ9kskElRMPvJG3st43U82/ysJNp7ba6nXYaBwFpUVW
 7mD7etJCq0s648v+T7wHE/FDqh/xR8SEl84YoTeCmkXA/NOkr20+J+Twb8a9xO/T1s
 v1K5gy3EZCSWveVRv0e1w1MvLpFF4AGUrsvwcYe/+WQYbgoyPMBpHSdOtSIdtxp8Yl
 yTN6wzoYt2WHA==
Message-ID: <3e1ddf38-c70d-4092-a996-a3da207d09f1@denx.de>
Date: Wed, 4 Dec 2024 12:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net: designware: socfpga: Add RGMII-ID support
To: Rufus Segar <rhs@riseup.net>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: simon.k.r.goldschmidt@gmail.com, rufus.segar@carallon.com
References: <ea18dd21-1251-455e-8456-09098414c1dd@denx.de>
 <20241204112127.3008702-1-rhs@riseup.net>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241204112127.3008702-1-rhs@riseup.net>
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

On 12/4/24 12:21 PM, Rufus Segar wrote:
> This patch adds support for the "rgmii-id", "rgmii-rxid", and
> "rgmii-txid" modes for the dwmac_socfpga driver.
> 
> Signed-off-by: Rufus Segar <rhs@riseup.net>
Reviewed-by: Marek Vasut <marex@denx.de>
