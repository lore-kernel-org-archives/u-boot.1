Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE646C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2348793F;
	Sun, 29 Oct 2023 16:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592183;
	bh=7OVg+BRusy/y81nWytr6FBpaloCTaOMmZEublLhSXh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alOeOcNOcVqbUla3ak4viE2tQvBRYeSl+aIlmV9SVVKMxZGgRw27sIW2zhT52mrJQ
	 tIebaP39RjBuxL0LU6QyL+4rW1DHa15etn7rS9mWsfBFtZnVXktcYPr1qGq642H4zx
	 RgVC5zQ37v9Niihde7xOC7XOPrbBEFHPB6HgGFS18Y5q2t7BZTIUOgGmTm0aEG0Q0y
	 aXqOdt4+s+Lf2Bn60sGj7nsB3jwHRnTx/Wern61eojYXyA2hEQkJ6BCEewmH8Xpy+i
	 54s067oWQZd6uss2aJiiiHNNYkpkHTiz5exAVVpsKFHQ7igakxQykB/ehSz625i9sE
	 IusDz+7GpB4Mg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EF39087141;
 Sun, 29 Oct 2023 16:09:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592180;
 bh=7OVg+BRusy/y81nWytr6FBpaloCTaOMmZEublLhSXh0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MkDlRZ7xhFm10sIfcllHc1iXRw9X0ZGrN/rdljtU44N9CitT0K8UW8GffxsXjvnYR
 WJhj9bS88q7ekF0RxJbk24z3pfP+P8+p38KkIAmmH8a4OgL5a3Cyvwkle1ltidd8tq
 WHc9t32Apx8khhtUaTF/ohyU8s480dIP8NKMIWDKJFDTH+GYXcnBeSDt2ADionVjlF
 vI3/dm/NkliKqXFFeMv9JXOuhb3uMUIJKqYYBwfct/WBcaRAoVCvJFIcDZoDakY4E0
 TMhhX7wJjHA4XcptdNYtFRA966p6T6ygw1bqk7JDOhtr8G9QM7YCs+uhgtW1OqvNwf
 +aWqCojcc42MA==
Message-ID: <d1c03c32-95e2-4479-8a33-c6e89729dec6@denx.de>
Date: Sun, 29 Oct 2023 12:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: xhci: Hook up timeouts
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
 <20231029-usb-fixes-5-v1-2-54bb13001f54@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-5-v1-2-54bb13001f54@marcan.st>
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

On 10/29/23 08:36, Hector Martin wrote:
> Now that the USB core passes through timeout info to the host
> controller, actually hook it up.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Except for the negative timeout value question, which needs to be sorted 
out:

Reviewed-by: Marek Vasut <marex@denx.de>
