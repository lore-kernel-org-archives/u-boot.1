Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A25C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1014F87FC3;
	Tue, 20 Feb 2024 16:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443171;
	bh=M7CINnKHfX2I0in+EL9o2inZOZZDeNemMOKSN4krxmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AlxeufFgJU9PIkPTDDm+RfFpZHIc27VOWBW9SkTvkSF2o4/dU8amtg/waba3omFnu
	 OElM5X+82toXJ6Tg6dQsF6+id4d6cLWnrDZNO/4JC+24uciHGDVPyfknK8VFxS08JS
	 J3r0YRu6kzjHbJfluvHTDZkUd/f9fp0y5gujfVqkfZ1FbdeVjpx34V29iTQBUPv++g
	 ntKc/6bwZuiebvR2yQiTGxbI9921O7e1ZW42g80c+bqPQKLoh2fc4pnJ/YV7ThDGkg
	 E7mfMZ/cujLm6TUQ6IrDx7cvA/SzQfWuquo456uT1Dn+ca0DMmeKQMX7vb4IFcuVeJ
	 khIJOFV00GdyA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E3F4987ED6;
 Tue, 20 Feb 2024 16:32:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443170;
 bh=M7CINnKHfX2I0in+EL9o2inZOZZDeNemMOKSN4krxmc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Rh+GtCc9+DHikEXSyV5l427QOu5U9+cMs5cd1G4zkPw6RA6rlRNT6X7t3ZyOoAEG6
 JT0j89mTBeVSNgFUNtxeKQgaUZxXqhQ5QlrPUwylnfsyXj+8QDFPBOfHZcZGSemypC
 BM0C6jTVnAVrR+YwcPxrtTVF5kWUIive4vK5n5gvhD31UASOWz2L5itbDPMZBxn0Dq
 4Rlg+5OosVXRcMr4Q6tgy6HZvfd1Vm20a+bDm2OFGPIqYXUzsFIgDjEPenZHW3hxcX
 4PTgLOPobpOBXFf7R1/D6Tz+3y89dDJVJzb5comFfyutZJjeUayxB2BjQ9VnKwQm/K
 2AcSrK0Oy8r2Q==
Message-ID: <0d3d4efc-03e1-4236-bcc2-5b8efdc7f340@denx.de>
Date: Tue, 20 Feb 2024 16:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-8-sumit.garg@linaro.org>
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

On 2/20/24 14:10, Sumit Garg wrote:
> Also, enable reset driver which is a prerequisite for PCIe support.

Commit message needs to be fixed.
