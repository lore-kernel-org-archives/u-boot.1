Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6BFC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFA087F33;
	Mon, 19 Feb 2024 15:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708351952;
	bh=hJw1S5dj/jKVgkC62LpSUF3j6sWgKIX5YMKgAl/NFrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYBHfjUbmcUfkrMwL442UA1Ldh5M0Xqh6Ku4KQQw+go+jrgWXNVAJXJqp0LVJXzfb
	 z3JRJX5GB9akfPwOvXoxHsXYZl3XY79VBPJ+x2o/wt6M5ACyc1F9RPF7z2QXOkKI7a
	 ULD6/kU/l+yWGpHpGCUG8G1dFL2oi1UyS33dG4AitJMahLmcg3/nXkolmIN9ck4M+o
	 UQE++3+JPouXjZXjRyjIhPE7LjnGb8zClZoluCd9/2CEapa5dyuIndLic6WniGD2p1
	 LbcweomXLs4vpyIP9MTtuCkCIHvYLfGAG2yOiEQB8aWiXsBCj9Dq4sdtntyvWlLB4T
	 N0YBBTKS+7+iw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 814E086DBD;
 Mon, 19 Feb 2024 15:12:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708351950;
 bh=hJw1S5dj/jKVgkC62LpSUF3j6sWgKIX5YMKgAl/NFrs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vMCCvsahwTU9PwWi7nzlXtXakK5tj/FJ6lFkvc5nFY7wgzlukxF832dclIrFKvDZF
 c4NSs/RRVhKtpPKA0FrBJtmS0/M0IdxU56cn5Nq+PFNAIDEbO0iocNzvDa0JG1F7bx
 PJ3410JUL33ZNOv/7Y0II/3V0fm9ilDV3NNQh9mhxlZB1PBj2v6vhHC708MddV2zO/
 0+wzuKIU+QuU9luiXgyCXwW5/V7U1ORaqOGJqaERY00qigQKC7npPyz6cZAUdFI2wc
 SJHF/9itcyG5QNHgMI3W4Llpqw0SRVDPxT6N3Exy6R1s3NIx6CnX1aMyLZ62xPARMb
 labxY1L1YWZQg==
Message-ID: <a84821a6-f9fa-4986-84a2-af1170017d7c@denx.de>
Date: Mon, 19 Feb 2024 15:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: ehci-mx6: Add i.MX93 support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 u-boot@lists.denx.de
References: <20240219084300.8228-1-othacehe@gnu.org>
 <CAOMZO5D2rMX+7RH+8Fs0o+bXv+a0BLb9=g09rCnodrXf-O43ng@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5D2rMX+7RH+8Fs0o+bXv+a0BLb9=g09rCnodrXf-O43ng@mail.gmail.com>
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

On 2/19/24 14:18, Fabio Estevam wrote:
> Hi Mathieu,
> 
> On Mon, Feb 19, 2024 at 5:43 AM Mathieu Othacehe <othacehe@gnu.org> wrote:
>>
>> i.MX93 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
>> driver.
>>
>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> 
> You missed copying Marek Vasut, who is the USB maintainer.

The patch itself looks fine:

Reviewed-by: Marek Vasut <marex@denx.de>

Just send a V2 with the collected tags so it can be applied.

Thanks !
